import 'package:backup_ticket/model/ongoing_movie_model.dart';
import 'package:backup_ticket/provider/ongoing/ongoing_movie_provider.dart';
import 'package:backup_ticket/views/Home/image_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<OngoingMovie> _filteredTickets = [];
  List<OngoingMovie> _allTickets = [];

  bool _showFilters = false;

  // Filters
  String _selectedPriceRange = 'All';
  String _selectedLanguage = 'All';
  DateTime? _selectedDate;

  final List<String> _priceRanges = [
    'All',
    '0-200',
    '201-500',
    '501-1000',
    '1000+'
  ];

  final List<String> _languages = [
    'All',
    'Malayalam',
    'Tamil',
    'Telugu',
    'Hindi',
    'English'
  ];

  static const String ticketImageBaseUrl = "http://31.97.206.144:8127";

  String getTicketImageUrl(String imagePath) {
    if (imagePath.startsWith('http')) return imagePath;
    return "$ticketImageBaseUrl$imagePath";
  }

  @override
  void initState() {
    super.initState();
    _loadTickets();
    _searchController.addListener(_performSearch);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadTickets() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<OngoingMoviesProvider>();
      if (provider.movies.isEmpty) {
        provider.fetchOngoingMovies();
      }
      setState(() {
        _allTickets = provider.movies;
        _filteredTickets = _allTickets;
      });
    });
  }

  void _performSearch() {
    final query = _searchController.text.toLowerCase();
    final provider = context.read<OngoingMoviesProvider>();

    setState(() {
      _filteredTickets = provider.movies.where((ticket) {
        final matchesSearch = query.isEmpty ||
            ticket.movieId.movieName.toLowerCase().contains(query) ||
            ticket.theatrePlace.toLowerCase().contains(query) ||
            ticket.language.toLowerCase().contains(query);

        final matchesPrice = _selectedPriceRange == 'All' ||
            _checkPriceRange(ticket.pricePerTicket);

        final matchesLanguage = _selectedLanguage == 'All' ||
            ticket.language
                .toLowerCase()
                .contains(_selectedLanguage.toLowerCase());

        final matchesDate = _selectedDate == null ||
            _isSameDate(ticket.showDate, _selectedDate!);

        return matchesSearch &&
            matchesPrice &&
            matchesLanguage &&
            matchesDate;
      }).toList();
    });
  }

  /// ✅ FIXED: accepts int & double
  bool _checkPriceRange(num price) {
    switch (_selectedPriceRange) {
      case '0-200':
        return price >= 0 && price <= 200;
      case '201-500':
        return price > 200 && price <= 500;
      case '501-1000':
        return price > 500 && price <= 1000;
      case '1000+':
        return price > 1000;
      default:
        return true;
    }
  }

  bool _isSameDate(DateTime d1, DateTime d2) {
    return d1.year == d2.year &&
        d1.month == d2.month &&
        d1.day == d2.day;
  }

  void _clearFilters() {
    setState(() {
      _selectedPriceRange = 'All';
      _selectedLanguage = 'All';
      _selectedDate = null;
    });
    _performSearch();
  }

  void _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
      _performSearch();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Tickets'),
        backgroundColor: const Color(0xFF1976D2),
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          /// SEARCH BAR
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search movies, theatre, language...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  icon: Icon(
                    Icons.tune,
                    color: _showFilters ? Colors.white : Colors.black,
                  ),
                  onPressed: () =>
                      setState(() => _showFilters = !_showFilters),
                )
              ],
            ),
          ),

          /// FILTERS
          if (_showFilters)
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Price Range'),
                  Wrap(
                    spacing: 8,
                    children: _priceRanges.map((e) {
                      return FilterChip(
                        label: Text(e),
                        selected: _selectedPriceRange == e,
                        onSelected: (_) {
                          setState(() => _selectedPriceRange = e);
                          _performSearch();
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                  const Text('Language'),
                  Wrap(
                    spacing: 8,
                    children: _languages.map((e) {
                      return FilterChip(
                        label: Text(e),
                        selected: _selectedLanguage == e,
                        onSelected: (_) {
                          setState(() => _selectedLanguage = e);
                          _performSearch();
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                  TextButton.icon(
                    onPressed: _selectDate,
                    icon: const Icon(Icons.calendar_today),
                    label: Text(
                      _selectedDate == null
                          ? 'Select Date'
                          : _formatDate(_selectedDate!),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: _clearFilters,
                      child: const Text('Clear Filters'),
                    ),
                  )
                ],
              ),
            ),

          /// RESULTS
          Expanded(
            child: Consumer<OngoingMoviesProvider>(
              builder: (context, provider, _) {
                if (provider.state == MovieState.loading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (_filteredTickets.isEmpty) {
                  return const Center(child: Text('No tickets found'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _filteredTickets.length,
                  itemBuilder: (_, i) =>
                      _buildTicketCard(_filteredTickets[i]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketCard(OngoingMovie ticket) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ImageDetailScreen(
              movieName: ticket.movieId.movieName,
              categoryId: ticket.movieId.id,
              assetImagePath: getTicketImageUrl(ticket.movieId.image),
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: ListTile(
          leading: Image.network(
            getTicketImageUrl(ticket.movieId.image),
            width: 50,
            fit: BoxFit.cover,
          ),
          title: Text(ticket.movieId.movieName),
          subtitle: Text(
              '${ticket.language} • ${_formatDate(ticket.showDate)}'),
          trailing: Text(
            '₹${ticket.pricePerTicket}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1976D2),
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${date.day} ${months[date.month - 1]}';
  }
}
