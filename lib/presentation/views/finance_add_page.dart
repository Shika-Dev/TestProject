import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:test_project/domain/model/transaction_model.dart';
import 'package:test_project/presentation/bloc/finance_bloc.dart';
import 'package:intl/intl.dart';
import 'package:test_project/presentation/views/finance_home_page.dart';

class FinanceAddPage extends StatelessWidget {
  const FinanceAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<FinanceBloc>(),
      child: FinanceAddPageView(),
    );
  }
}

class FinanceAddPageView extends StatefulWidget {
  const FinanceAddPageView({super.key});

  @override
  State<FinanceAddPageView> createState() => _FinanceAddPageViewState();
}

class _FinanceAddPageViewState extends State<FinanceAddPageView> {
  TextEditingController descController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  String category = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Transaction'),
        centerTitle: true,
        leading: InkWell(
          onTap: ()=> Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> FinanceHomePage()), (route) => false),
          child: Icon(Icons.arrow_back)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField(
                  items: ['Income', 'Expense']
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  hint: Text("Select Category"),
                  onChanged: (val) => setState(() {
                        category = val ?? '';
                      })),
          TextFormField(
            decoration: InputDecoration(
              label: Text('Description')
            ),
            controller: descController,
          ),
          TextFormField(
            decoration: InputDecoration(
              label: Text("Amount"),
            ),
            controller: amountController,
          ),
          ElevatedButton(
            onPressed: (){
              var dateString = DateFormat('yyyy-MM-dd').format(DateTime.now());
              if(descController.text.isEmpty || amountController.text.isEmpty || category.isEmpty){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Fill all the field')));
              } else {
                context.read<FinanceBloc>().add(AddTransaction(model: TransactionModel(
                  desc: descController.text, 
                  category: category, 
                  amount: int.parse(amountController.text), 
                  dateCreated: dateString)));
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> FinanceHomePage()), (route) => false);
              }
            }, child: Text('Add Transaction'))
        ],
      ),
    );
  }
}
