import 'package:flutter/material.dart';
import '../../../data/model/test.dart';
import '../../../generated/l10n.dart';

class InformationTestScreen extends StatelessWidget {
  final Test test;
  final int indexResult;
  const InformationTestScreen({super.key, required this.test, required this.indexResult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Text(S.of(context).description),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(test.description,style: TextStyle(color: Colors.blueGrey.shade100),),
              const SizedBox(height: 10,),
              ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index){
                    MapEntry<String,LevelDetail> itemConclude = test.conclude.levels.entries.elementAt(index);
                    return Text(
                      "${S.of(context).from} ${itemConclude.key}: ${itemConclude.value.description}",
                      style: TextStyle(color: index == indexResult ? Colors.yellow : Colors.blueGrey.shade100),
                    );
                  },
                  separatorBuilder: (_,index) => const SizedBox(height: 10,),
                  itemCount: test.conclude.levels.length,
                  shrinkWrap: true,
              ),
            ],
          ),
        ),
      )
    );
  }
}
