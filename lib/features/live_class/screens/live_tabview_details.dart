
// import 'package:flutter/material.dart';

// class LiveTabviewDetails extends StatefulWidget {
//   const LiveTabviewDetails({super.key});

//   @override
//   State<LiveTabviewDetails> createState() => _LiveTabviewDetailsState();
// }

// class _LiveTabviewDetailsState extends State<LiveTabviewDetails> 
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//     @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: const Scaffold(
//         body: SingleChildScrollView(
//           child:Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Icon( Icons.live_tv),
//                 SizedBox(width: 10),
//                 Text('Live classes',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
//                 Expanded(
//                   child: DefaultTabController(
//                   length: 3,
//                   child: Column(
//                     children: [
//                     TabBar(
//                       tabs: [
//                       Tab(text: 'Tab 1'),
//                       Tab(text: 'Tab 2'),
//                       Tab(text: 'Tab 3'),
//                       ],
//                     ),
//                     Expanded(
//                       child: TabBarView(
//                       children: [
//                        Text("hvrsezrxdcf"),
//                         Text("hvrsezrxdcf"),
//                         Text("hvrsezrxdcf"),
//                       ],
//                       ),
//                     ),
//                     ],
//                   ),
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

class LiveTabviewDetails extends StatefulWidget {
  const LiveTabviewDetails({super.key});

  @override
  State<LiveTabviewDetails> createState() => _LiveTabviewDetailsState();
}

class _LiveTabviewDetailsState extends State<LiveTabviewDetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.live_tv),
                  const SizedBox(width: 10),
                  const Text(
                    'Live classes',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    Container(
                       decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                      
                      child: const TabBar(
                        tabs: [
                          Tab(text: 'ongoing'),
                          Tab(text: 'upcoming'),
                          Tab(text: 'completed'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 300, // change height which will cause height issue from bottom
                      child: TabBarView(
                        children: [
                          Center(child: Text("Tab 1 Content")),
                          Center(child: Text("Tab 2 Content")),
                          Center(child: Text("Tab 3 Content")),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
