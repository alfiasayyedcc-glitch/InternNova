
import 'package:flutter/material.dart';

import '../../models/intern_model.dart';
import '../../services/internship_service.dart';
import '../../services/application_service.dart';

class InternshipsScreen extends StatelessWidget {
  const InternshipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final InternshipService internshipService =
        InternshipService();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        title: const Text(
          'Available Internships',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),

      body: StreamBuilder<List<InternshipModel>>(
        stream: internshipService.getInternships(),

        builder: (context, snapshot) {
          // ==================================================
          // LOADING
          // ==================================================

          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF123B5D),
              ),
            );
          }

          // ==================================================
          // ERROR
          // ==================================================

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(25),

                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,

                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 60,
                      color: Colors.red,
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      'Something went wrong',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      '${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          // ==================================================
          // GET ALL INTERNSHIPS
          // ==================================================

          final allInternships =
              snapshot.data ?? [];

          // ==================================================
          // REMOVE DUPLICATE COMPANY NAMES
          // ==================================================

          final Map<String, InternshipModel>
              uniqueCompanies = {};

          for (final internship
              in allInternships) {
            final companyName =
                internship.companyName
                    .trim()
                    .toLowerCase();

            // Only the FIRST internship of a
            // company will be displayed.
            if (!uniqueCompanies
                .containsKey(companyName)) {
              uniqueCompanies[companyName] =
                  internship;
            }
          }

          final internships =
              uniqueCompanies.values.toList();

          // ==================================================
          // EMPTY
          // ==================================================

          if (internships.isEmpty) {
            return Center(
              child: Padding(
                padding:
                    const EdgeInsets.all(25),

                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,

                  children: [
                    Icon(
                      Icons.work_off_outlined,
                      size: 70,
                      color:
                          Colors.grey.shade400,
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'No Internships Available',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'There are currently no internships available.',
                      textAlign:
                          TextAlign.center,
                      style: TextStyle(
                        color:
                            Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          // ==================================================
          // INTERNSHIP LIST
          // ==================================================

          return ListView.builder(
            padding:
                const EdgeInsets.all(20),

            itemCount:
                internships.length,

            itemBuilder:
                (context, index) {
              final internship =
                  internships[index];

              return _internshipCard(
                context,
                internship,
              );
            },
          );
        },
      ),
    );
  }

  // ==========================================================
  // INTERNSHIP CARD
  // ==========================================================

  Widget _internshipCard(
    BuildContext context,
    InternshipModel internship,
  ) {
    return Container(
      margin:
          const EdgeInsets.only(bottom: 18),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withValues(
              alpha: 0.05,
            ),
            blurRadius: 10,
            offset:
                const Offset(0, 4),
          ),
        ],
      ),

      child: Padding(
        padding:
            const EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            // ==================================================
            // COMPANY + ICON
            // ==================================================

            Row(
              children: [
                Container(
                  height: 55,
                  width: 55,

                  decoration:
                      BoxDecoration(
                    color:
                        const Color(
                      0xFFEFF6FF,
                    ),
                    borderRadius:
                        BorderRadius.circular(
                      15,
                    ),
                  ),

                  child: const Icon(
                    Icons.business,
                    color:
                        Color(0xFF123B5D),
                    size: 28,
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                    children: [
                      Text(
                        internship
                            .companyName,

                        style:
                            const TextStyle(
                          fontSize: 14,
                          color:
                              Colors.grey,
                          fontWeight:
                              FontWeight.w500,
                        ),
                      ),

                      const SizedBox(
                        height: 4,
                      ),

                      Text(
                        internship.title,

                        style:
                            const TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // ==================================================
            // LOCATION
            // ==================================================

            _infoRow(
              Icons.location_on_outlined,
              internship.location,
            ),

            const SizedBox(height: 10),

            // ==================================================
            // DURATION
            // ==================================================

            _infoRow(
              Icons.access_time,
              internship.duration,
            ),

            const SizedBox(height: 10),

            // ==================================================
            // STIPEND
            // ==================================================

            _infoRow(
              Icons.currency_rupee,
              internship.stipend.isEmpty
                  ? 'Not specified'
                  : internship.stipend,
            ),

            const SizedBox(height: 10),

            // ==================================================
            // SEATS
            // ==================================================

            _infoRow(
              Icons.people_outline,
              '${internship.seats} seat(s) available',
            ),

            // ==================================================
            // SKILLS
            // ==================================================

            if (internship.skills.isNotEmpty) ...[
              const SizedBox(height: 15),

              Container(
                width:
                    double.infinity,

                padding:
                    const EdgeInsets.all(
                  12,
                ),

                decoration:
                    BoxDecoration(
                  color:
                      const Color(
                    0xFFF8FAFC,
                  ),
                  borderRadius:
                      BorderRadius.circular(
                    12,
                  ),
                ),

                child: Row(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [
                    const Icon(
                      Icons.code,
                      size: 20,
                      color:
                          Color(
                        0xFF123B5D,
                      ),
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    Expanded(
                      child: Text(
                        internship
                            .skills,

                        style:
                            const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 18),

            // ==================================================
            // VIEW DETAILS
            // ==================================================

            SizedBox(
              width:
                  double.infinity,
              height: 48,

              child:
                  ElevatedButton(
                onPressed: () {
                  _showInternshipDetails(
                    context,
                    internship,
                  );
                },

                style:
                    ElevatedButton
                        .styleFrom(
                  backgroundColor:
                      const Color(
                    0xFF123B5D,
                  ),
                  foregroundColor:
                      Colors.white,

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                      12,
                    ),
                  ),
                ),

                child:
                    const Text(
                  'View Details',
                  style:
                      TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // INFO ROW
  // ==========================================================

  Widget _infoRow(
    IconData icon,
    String text,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color:
              const Color(0xFF123B5D),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Text(
            text,
            style:
                const TextStyle(
              fontSize: 14,
              color:
                  Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // DETAILS BOTTOM SHEET
  // ==========================================================

  void _showInternshipDetails(
    BuildContext parentContext,
    InternshipModel internship,
  ) {
    showModalBottomSheet(
      context: parentContext,
      isScrollControlled: true,
      backgroundColor:
          Colors.transparent,

      builder: (sheetContext) {
        return Container(
          height:
              MediaQuery.of(
                    sheetContext,
                  ).size.height *
                  0.75,

          decoration:
              const BoxDecoration(
            color: Colors.white,

            borderRadius:
                BorderRadius.vertical(
              top: Radius.circular(25),
            ),
          ),

          child: Padding(
            padding:
                const EdgeInsets.all(22),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [
                // ==================================================
                // HANDLE
                // ==================================================

                Center(
                  child: Container(
                    width: 45,
                    height: 5,

                    decoration:
                        BoxDecoration(
                      color:
                          Colors.grey.shade300,

                      borderRadius:
                          BorderRadius.circular(
                        10,
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                // ==================================================
                // TITLE
                // ==================================================

                Text(
                  internship.title,

                  style:
                      const TextStyle(
                    fontSize: 24,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 6,
                ),

                Text(
                  internship.companyName,

                  style:
                      const TextStyle(
                    color:
                        Color(0xFF123B5D),
                    fontSize: 16,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                // ==================================================
                // DESCRIPTION
                // ==================================================

                const Text(
                  'Description',

                  style:
                      TextStyle(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                Text(
                  internship.description
                          .isEmpty
                      ? 'No description provided.'
                      : internship
                          .description,

                  style: TextStyle(
                    color:
                        Colors.grey.shade700,
                    height: 1.5,
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                // ==================================================
                // DETAILS
                // ==================================================

                _detailRow(
                  Icons
                      .location_on_outlined,
                  'Location',
                  internship.location,
                ),

                _detailRow(
                  Icons.access_time,
                  'Duration',
                  internship.duration,
                ),

                _detailRow(
                  Icons.currency_rupee,
                  'Stipend',
                  internship.stipend
                          .isEmpty
                      ? 'Not specified'
                      : internship.stipend,
                ),

                _detailRow(
                  Icons.people_outline,
                  'Seats',
                  '${internship.seats}',
                ),

                _detailRow(
                  Icons.code,
                  'Skills',
                  internship.skills
                          .isEmpty
                      ? 'Not specified'
                      : internship.skills,
                ),

                const Spacer(),

                // ==================================================
                // APPLY BUTTON
                // ==================================================

                SizedBox(
                  width:
                      double.infinity,
                  height: 52,

                  child:
                      ElevatedButton(
                    onPressed:
                        () async {
                      try {
                        final ApplicationService
                            applicationService =
                            ApplicationService();

                        await applicationService
                            .applyForInternship(
                          internshipId:
                              internship.id,
                          internshipTitle:
                              internship.title,
                          companyName:
                              internship.companyName,
                        );

                        if (!parentContext
                            .mounted) {
                          return;
                        }

                        Navigator.pop(
                          sheetContext,
                        );

                        ScaffoldMessenger
                            .of(
                          parentContext,
                        ).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Application submitted successfully! 🎉',
                            ),
                            backgroundColor:
                                Colors.green,
                          ),
                        );
                      } catch (e) {
                        if (!parentContext
                            .mounted) {
                          return;
                        }

                        ScaffoldMessenger
                            .of(
                          parentContext,
                        ).showSnackBar(
                          SnackBar(
                            content: Text(
                              e.toString()
                                  .replaceFirst(
                                'Exception: ',
                                '',
                              ),
                            ),
                            backgroundColor:
                                Colors.red,
                          ),
                        );
                      }
                    },

                    style:
                        ElevatedButton
                            .styleFrom(
                      backgroundColor:
                          const Color(
                        0xFF123B5D,
                      ),

                      foregroundColor:
                          Colors.white,

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                          14,
                        ),
                      ),
                    ),

                    child:
                        const Text(
                      'Apply Now',
                      style:
                          TextStyle(
                        fontSize: 16,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ==========================================================
  // DETAIL ROW
  // ==========================================================

  Widget _detailRow(
    IconData icon,
    String title,
    String value,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 12,
      ),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment
                .start,

        children: [
          Icon(
            icon,
            color:
                const Color(
              0xFF123B5D,
            ),
            size: 21,
          ),

          const SizedBox(
            width: 12,
          ),

          Text(
            '$title: ',
            style:
                const TextStyle(
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}

