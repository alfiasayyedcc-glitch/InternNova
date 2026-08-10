
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ManageInternshipsScreen extends StatefulWidget {
  const ManageInternshipsScreen({super.key});

  @override
  State<ManageInternshipsScreen> createState() =>
      _ManageInternshipsScreenState();
}

class _ManageInternshipsScreenState
    extends State<ManageInternshipsScreen> {
  final TextEditingController _searchController =
      TextEditingController();

  String searchText = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        title: const Text(
          'Manage Internships',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('internships')
            .snapshots(),

        builder: (context, snapshot) {
          // Loading
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Error
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Firestore Error:\n\n${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }

          // No internships
          if (!snapshot.hasData ||
              snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No internships found.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }

          final allInternships = snapshot.data!.docs;

          // SEARCH FILTER
          final internships = allInternships.where((doc) {
            final data =
                doc.data() as Map<String, dynamic>;

            final title =
                data['title']?.toString().toLowerCase() ?? '';

            final company =
                data['companyName']?.toString().toLowerCase() ?? '';

            final location =
                data['location']?.toString().toLowerCase() ?? '';

            final skills =
                data['skills']?.toString().toLowerCase() ?? '';

            final search =
                searchText.trim().toLowerCase();

            if (search.isEmpty) {
              return true;
            }

            return title.contains(search) ||
                company.contains(search) ||
                location.contains(search) ||
                skills.contains(search);
          }).toList();

          return Column(
            children: [

              // ==============================
              // SEARCH BAR
              // ==============================
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  20,
                  20,
                  10,
                ),
                child: TextField(
                  controller: _searchController,

                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },

                  decoration: InputDecoration(
                    hintText:
                        'Search internships...',
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.indigo,
                    ),

                    suffixIcon:
                        searchText.isNotEmpty
                            ? IconButton(
                                icon: const Icon(
                                  Icons.clear,
                                ),
                                onPressed: () {
                                  _searchController.clear();

                                  setState(() {
                                    searchText = '';
                                  });
                                },
                              )
                            : null,

                    filled: true,
                    fillColor: Colors.white,

                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),

                    enabledBorder:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),

                    focusedBorder:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Colors.indigo,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),

              // ==============================
              // RESULT COUNT
              // ==============================
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Text(
                      searchText.isEmpty
                          ? '${allInternships.length} Internships'
                          : '${internships.length} Results found',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              // ==============================
              // SEARCH RESULTS
              // ==============================
              Expanded(
                child: internships.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 70,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 15),
                            Text(
                              'No internships found',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight:
                                    FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Try another search',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding:
                            const EdgeInsets.fromLTRB(
                          20,
                          5,
                          20,
                          20,
                        ),
                        itemCount: internships.length,
                        itemBuilder:
                            (context, index) {
                          final doc =
                              internships[index];

                          final data = doc.data()
                              as Map<String, dynamic>;

                          final title =
                              data['title']?.toString() ??
                                  'No Title';

                          final company =
                              data['companyName']
                                      ?.toString() ??
                                  'No Company';

                          final location =
                              data['location']
                                      ?.toString() ??
                                  'Not specified';

                          final duration =
                              data['duration']
                                      ?.toString() ??
                                  'Not specified';

                          final stipend =
                              data['stipend']
                                      ?.toString() ??
                                  'Not specified';

                          final skills =
                              data['skills']
                                      ?.toString() ??
                                  'Not specified';

                          final seats =
                              data['seats']?.toString() ??
                                  'Not specified';

                          final status =
                              data['status']?.toString() ??
                                  'Not specified';

                          final description =
                              data['description']
                                      ?.toString() ??
                                  '';

                          return Card(
                            margin:
                                const EdgeInsets.only(
                              bottom: 16,
                            ),
                            elevation: 2,
                            color: Colors.white,
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                16,
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.all(
                                18,
                              ),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                children: [

                                  // TITLE
                                  Text(
                                    title,
                                    style:
                                        const TextStyle(
                                      fontSize: 21,
                                      fontWeight:
                                          FontWeight.bold,
                                      color:
                                          Colors.indigo,
                                    ),
                                  ),

                                  const SizedBox(height: 6),

                                  // COMPANY
                                  Text(
                                    company,
                                    style:
                                        const TextStyle(
                                      fontSize: 16,
                                      fontWeight:
                                          FontWeight.w600,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 16,
                                  ),

                                  _InfoRow(
                                    icon: Icons
                                        .location_on_outlined,
                                    label: 'Location',
                                    value: location,
                                  ),

                                  _InfoRow(
                                    icon: Icons
                                        .access_time,
                                    label: 'Duration',
                                    value: duration,
                                  ),

                                  _InfoRow(
                                    icon: Icons
                                        .currency_rupee,
                                    label: 'Stipend',
                                    value: stipend,
                                  ),

                                  _InfoRow(
                                    icon: Icons.code,
                                    label: 'Skills',
                                    value: skills,
                                  ),

                                  _InfoRow(
                                    icon: Icons
                                        .people_outline,
                                    label: 'Seats',
                                    value: seats,
                                  ),

                                  const SizedBox(height: 8),

                                  // STATUS
                                  Container(
                                    padding:
                                        const EdgeInsets
                                            .symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration:
                                        BoxDecoration(
                                      color: status
                                                  .toLowerCase() ==
                                              'active'
                                          ? Colors.green
                                              .shade50
                                          : Colors.grey
                                              .shade200,
                                      borderRadius:
                                          BorderRadius
                                              .circular(
                                        20,
                                      ),
                                    ),
                                    child: Text(
                                      status.toUpperCase(),
                                      style: TextStyle(
                                        color: status
                                                    .toLowerCase() ==
                                                'active'
                                            ? Colors.green
                                                .shade700
                                            : Colors.grey
                                                .shade700,
                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  if (description
                                      .isNotEmpty) ...[
                                    const SizedBox(
                                        height: 15),

                                    const Text(
                                      'Description',
                                      style:
                                          TextStyle(
                                        fontWeight:
                                            FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),

                                    const SizedBox(
                                        height: 5),

                                    Text(
                                      description,
                                      style:
                                          const TextStyle(
                                        color:
                                            Colors.black87,
                                        height: 1.4,
                                      ),
                                    ),
                                  ],

                                  const SizedBox(
                                      height: 15),

                                  // DOCUMENT ID
                                  Text(
                                    'ID: ${doc.id}',
                                    style:
                                        const TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: Colors.indigo,
          ),

          const SizedBox(width: 10),

          SizedBox(
            width: 85,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

