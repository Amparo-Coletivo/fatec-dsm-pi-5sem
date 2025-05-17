import 'package:flutter/material.dart';

class NeoHomePage extends StatefulWidget {
  const NeoHomePage({super.key});

  @override
  State<NeoHomePage> createState() => _NeoHomePageState();
}

class _NeoHomePageState extends State<NeoHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Center(child: Text('NeoHomePage')),
      body: CustomScrollView(
        slivers: [
          // SliverAppBar(
          //   title: const Text('Início'),
          //   floating: true,
          //   actions: [
          //     IconButton(
          //       icon: const Icon(Icons.search),
          //       onPressed: () {
          //         // Ação do botão de pesquisa
          //       },
          //     ),
          //   ],
          // ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              height: 200,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Text(
                  'Banner',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.25,
              width: MediaQuery.sizeOf(context).width * .8,
              child: CarouselView(
                elevation: 4,
                itemSnapping: true,
                itemExtent: 300,
                children: List.generate(
                  10,
                  (index) =>
                      Container(color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ),
          ),
          SliverList.builder(
            itemCount: 30,
            itemBuilder: (context, index) {
              return Card(
                clipBehavior: Clip.antiAlias,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    Flexible(
                      child: Column(
                        children: [
                          const Text('ONG'),
                          const Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
