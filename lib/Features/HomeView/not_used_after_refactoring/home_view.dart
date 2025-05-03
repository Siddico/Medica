import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical/Constants/constants.dart';
import 'package:medical/Constants/fontStyles.dart';
import 'package:medical/Constants/imageStyles.dart';
import 'package:medical/Features/BooksView/books_view_api_redesigned.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu, color: Colors.black, size: 24),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none, color: Colors.black),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: CircleAvatar(
              // backgroundColor: Colors.black,
              radius: 22,
              backgroundImage: AssetImage(
                Imagestyles.DoctorsLogo,
              ), // Your profile image
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            // Search Bar
            Card(
              elevation: 10,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search a Doctor',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Icon(Icons.mic, color: Colors.grey),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            // Live Doctors Section
            _sectionTitle('Live Doctors', action: Icon(Icons.add)),
            const SizedBox(height: 10),
            _liveDoctors(),

            const SizedBox(height: 20),
            // Surgery Scheduler
            _sectionTitle('Surgery Scheduler'),
            const SizedBox(height: 10),
            _schedulerCard(
              number: 4,
              time1: '11:00 am',
              time2: '02:00 pm',
              finished: 2,
            ),

            const SizedBox(height: 20),
            // Inpatients Check
            _sectionTitle('Inpatients Check'),
            const SizedBox(height: 10),
            _inpatientsCard(),

            const SizedBox(height: 20),
            // Outpatient Appointment
            _sectionTitle('Outpatient Appointment'),
            const SizedBox(height: 10),
            _schedulerCardOutpatient(
              number: 11,
              time1: '3:00 am',
              time2: '4:30 pm',
              finished: 4,
              isDark: true,
            ),

            const SizedBox(height: 20),
            // Intern Doctors
            _sectionTitle('Intern Doctor'),
            const SizedBox(height: 10),
            _internDoctors(),

            const SizedBox(height: 20),
            // Notes
            _notesSection(),

            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: _bottomNavigationBar(),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Color(0xff0B8FAC),

        onPressed: () {
          NavigateTo(context, const BooksViewApiRedesigned());
        },
        child: const Icon(Icons.add, size: 32, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  // Widget for Section Title
  Widget _sectionTitle(String title, {Widget? action}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: FontStyles.style16weight700.copyWith(
            fontWeight: FontWeight.w600,
            fontFamily: GoogleFonts.openSans().fontFamily,
            color: Color(0xff333333),
          ),
        ),
        action ??
            Text(
              'See All',
              style: FontStyles.style14wight400.copyWith(
                fontSize: 16,
                fontFamily: GoogleFonts.openSans().fontFamily,
                color: Color(0xff858585),
              ),
            ),
      ],
    );
  }

  // Widget for Live Doctors horizontal list
  Widget _liveDoctors() {
    return SizedBox(
      height: 168,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 12),
            width: 116.48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              image: DecorationImage(
                image: AssetImage(Imagestyles.DoctorsLogo),
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 45,
                height: 17,
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                      ),
                      height: 5.6,
                      width: 5.6,
                    ),
                    Text(
                      'LIVE',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Widget for Surgery/Outpatient Scheduler card
  Widget _schedulerCard({
    required int number,
    required String time1,
    required String time2,
    required int finished,
    bool isDark = false,
  }) {
    return Container(
      height: 130,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient:
            isDark
                ? const LinearGradient(
                  colors: [Color(0xff0B8FAC), Color(0xff0B8FAC)],
                )
                : const LinearGradient(
                  colors: [Color(0xff0B8FAC), Colors.white],
                ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_schedulerInfo('Number', '$number')],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Text('Time', style: FontStyles.style18weight800)),
              Row(
                children: [
                  Text(
                    '11:00 ',
                    style: FontStyles.style18weight800.copyWith(
                      fontSize: 20,
                      color: Color(0xffDADADA),
                    ),
                  ),
                  Text(
                    'Am',
                    style: FontStyles.style18weight800.copyWith(
                      fontSize: 20,
                      color: Color(0xffF8EABF),
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Text(
                    '02:00 ',
                    style: FontStyles.style18weight800.copyWith(
                      fontSize: 20,
                      color: Color(0xffDADADA),
                    ),
                  ),
                  Text(
                    'Pm',
                    style: FontStyles.style18weight800.copyWith(
                      fontSize: 20,
                      color: Color(0xffF8EABF),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text('Finished', style: FontStyles.style18weight800),
              ),
              Center(
                child: Text(
                  '2',
                  style: FontStyles.style32weight800.copyWith(
                    color: Color(0xff009ABC),
                  ),
                ),
              ),
            ],
          ),

          VerticalDivider(width: 1.5, color: Colors.white),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  // these comments work but i will uncomment when i build app again
                  Image.asset(Imagestyles.detailsIcon),
                  SizedBox(width: 1),
                  Text(
                    'Details',
                    style: FontStyles.style14wight400.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: GoogleFonts.openSans().fontFamily,
                      color: Color(0xff938905).withOpacity(0.83),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _schedulerCardOutpatient({
    required int number,
    required String time1,
    required String time2,
    required int finished,
    bool isDark = false,
  }) {
    return Container(
      height: 130,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient:
            isDark
                ? const LinearGradient(
                  colors: [Color(0xff80999E), Color(0xffffffff)],
                )
                : const LinearGradient(
                  colors: [Color(0xff80999E), Colors.white],
                ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_schedulerInfo('Number', '$number')],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Text('Time', style: FontStyles.style18weight800)),
              Row(
                children: [
                  Text(
                    '03:00 ',
                    style: FontStyles.style18weight800.copyWith(
                      fontSize: 20,
                      color: Color(0xffDADADA),
                    ),
                  ),
                  Text(
                    'Am',
                    style: FontStyles.style18weight800.copyWith(
                      fontSize: 20,
                      color: Color(0xffF8EABF),
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Text(
                    '04:00 ',
                    style: FontStyles.style18weight800.copyWith(
                      fontSize: 20,
                      color: Color(0xffDADADA),
                    ),
                  ),
                  Text(
                    'Pm',
                    style: FontStyles.style18weight800.copyWith(
                      fontSize: 20,
                      color: Color(0xffF8EABF),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text('Finished', style: FontStyles.style18weight800),
              ),
              Center(
                child: Text(
                  '4',
                  style: FontStyles.style32weight800.copyWith(
                    color: Color(0xff009ABC),
                  ),
                ),
              ),
            ],
          ),

          VerticalDivider(width: 1.5, color: Colors.white),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  // these comments work but i will uncomment when i build app again
                  Image.asset(Imagestyles.detailsIcon),
                  SizedBox(width: 1),
                  Text(
                    'Details',
                    style: FontStyles.style14wight400.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: GoogleFonts.openSans().fontFamily,
                      color: Color(0xff938905).withOpacity(0.83),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _schedulerInfo(String title, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: Text(title, style: FontStyles.style18weight800)),
        Center(child: Text(value, style: FontStyles.style32weight800)),
      ],
    );
  }

  // Widget for Inpatients Check Card
  Widget _inpatientsCard() {
    return Container(
      height: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            height: 104,
            width: 87,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Image.asset(Imagestyles.inpatientImage),
          ),
          SizedBox(width: 36),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mr. Ali Osam',
                  style: FontStyles.style18weight400.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Jorem ipsum dolor, consectetur adipiscing elit. Nunc v libero et velit interdum, ac  mattis.',
                  style: FontStyles.style14wight400.copyWith(
                    color: Color(0xff858585),
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 80,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Color(0xff938905),
                  ),
                  child: Center(
                    child: Text(
                      'Check',
                      style: FontStyles.style16weight700.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget for Intern Doctors
  Widget _internDoctors() {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Container(
            width: 105,
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      color: Color(0xff777EA5),
                      size: 16,
                    ),
                    Spacer(),
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    SizedBox(width: 4),
                    Text(
                      '3.7',
                      style: GoogleFonts.rubik(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                CircleAvatar(
                  backgroundImage: AssetImage(Imagestyles.DoctorsLogo),
                  radius: 35,
                ),
                const SizedBox(height: 8),
                Text(
                  'Dr. Krick',
                  style: GoogleFonts.rubik(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '\$25.00/hour',
                  style: GoogleFonts.rubik(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
          );
        },
      ),
    );
  }

  // Widget for Notes Section
  Widget _notesSection() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 100,
                // width: 400,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.amber),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const TextField(
                  maxLines: 4,
                  decoration: InputDecoration.collapsed(hintText: 'Type notes'),
                ),
              ),
            ),

            Container(
              width: 140,
              child: Column(
                children: [
                  Container(
                    width: 115,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Color(0xff1FA4C1),
                      // border: Border.all(color: Color(0xff1FA4C1), width: 1),
                    ),
                    child: Center(
                      child: Text(
                        'Send',
                        style: GoogleFonts.rubik(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),
                  Container(
                    width: 115,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      border: Border.all(color: Color(0xff1FA4C1), width: 1),
                    ),
                    child: Center(
                      child: Text(
                        'Check all',
                        style: GoogleFonts.rubik(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Widget for Bottom Navigation
  Widget _bottomNavigationBar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(icon: const Icon(Icons.home), onPressed: () {}),
            IconButton(icon: const Icon(Icons.schedule), onPressed: () {}),
            IconButton(icon: const Icon(Icons.chat), onPressed: () {}),
            IconButton(icon: const Icon(Icons.person), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
