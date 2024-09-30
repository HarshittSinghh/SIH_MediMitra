import 'package:flutter/material.dart';

class IntroHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width * 0.85,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage('assets/img/banner2.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width * 0.85,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage('assets/img/banner3.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width * 0.85,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage('assets/img/banner4.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 253, 185, 85),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        tileColor: Colors.transparent,
                        leading: Icon(Icons.notification_important,
                            color: Colors.white),
                        title: const Text(
                          'Urgent Notice',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        subtitle: const Text(
                          'Important information you need to know.',
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing:
                            Icon(Icons.arrow_forward, color: Colors.white),
                        onTap: () {},
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      children: [
                        _buildGridItem(Icons.policy, 'Health Policies'),
                        _buildGridItem(Icons.local_hospital, 'Hospitals'),
                        _buildGridItem(Icons.stacked_bar_chart, 'Reports'),
                        _buildGridItem(Icons.business, 'Departments'),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'News Flash',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        ListView(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          padding: EdgeInsets.all(8.0),
                          children: [
                            // First Card
                            Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Image.network(
                                      'https://pibindia.wordpress.com/wp-content/uploads/2017/02/nhmlogo.png',
                                      height: 100,
                                    ),
                                    SizedBox(height: 10),
                                    const Text(
                                      'National Health Mission Extension: The government extended the National Health Mission (NHM) to improve healthcare access, especially in rural areas.',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            // Second Card
                            Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Image.network(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpOzWYWW1fhzLlTbCNiCTIMLemoqxyRrjfKg&s',
                                      height: 100,
                                    ),
                                    SizedBox(height: 10),
                                    const Text(
                                      'Ayushman Bharat Digital Mission: Over 50 million citizens have enrolled in the Ayushman Bharat Digital Mission (ABDM), which provides unique health IDs for digital healthcare records.',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Third Card
                            Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Image.network(
                                      'https://i0.wp.com/www.theindianiris.com/wp-content/uploads/2016/04/logo-hindi.png?fit=440%2C166&ssl=1',
                                      height: 100,
                                    ),
                                    SizedBox(height: 10),
                                    const Text(
                                      'Universal Immunization Programme: The UIP continues to offer free vaccines for children and pregnant women, including COVID-19 vaccine',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Fourth Card
                            Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Image.network(
                                      'https://www.researchgate.net/publication/379359797/figure/fig1/AS:11431281232252039@1711643343808/Trends-and-patterns-of-non-communicable-disease-risk-factors-This-figure-is-self-created.png',
                                      height: 100,
                                    ),
                                    SizedBox(height: 10),
                                    const Text(
                                      'Non-Communicable Diseases Focus: India is intensifying efforts to tackle non-communicable diseases like diabetes and heart disease through early detection in rural areas.',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Fifth Card
                            Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Image.network(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2-d22m2PxuOLK2mpJTieOqrxtDY6Nfk4lCA&s',
                                      height: 100,
                                    ),
                                    SizedBox(height: 10),
                                    const Text(
                                      'Mental Health Care Guidelines: New guidelines focus on improving access to mental health services and reducing stigma.',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(IconData icon, String label) {
    return GestureDetector(
      onTap: () {
        // Action on tapping grid item
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF7CB8C0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 40),
            SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
