import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:test_project/presentation/bloc/finance_bloc.dart';
import 'package:intl/intl.dart';
import 'package:test_project/presentation/views/finance_add_page.dart';

class FinanceHomePage extends StatelessWidget {
  const FinanceHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<FinanceBloc>()
        ..add(GetTransaction())
        ..add(GetSummary()),
      child: FinanceHomePageView(),
    );
  }
}

class FinanceHomePageView extends StatefulWidget {
  const FinanceHomePageView({super.key});

  @override
  State<FinanceHomePageView> createState() => _FinanceHomePageViewState();
}

class _FinanceHomePageViewState extends State<FinanceHomePageView> {
  DateTime? date;
  String? dateString;
  String? category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaksi'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: filterWidget(context),
          ),
          SizedBox(height: 10),
          BlocBuilder<FinanceBloc, FinanceState>(
            builder: (context, state) {
              return summaryWidget(state);
            },
          ),
          SizedBox(height: 10),
          BlocBuilder<FinanceBloc, FinanceState>(
            builder: (context, state) {
              if(state.status == FinanceStatus.loading){
                return Center(child: CircularProgressIndicator(),);
              }
              return Expanded(
                  child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      itemBuilder: (context, index) => listItem(state, index),
                      separatorBuilder: (_, __) => SizedBox(height: 4),
                      itemCount: state.transactions.length),
                );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => FinanceAddPage())),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Card listItem(FinanceState state, int index) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(state.transactions[index].category),
                Text(state.transactions[index].desc)
              ],
            ),
            Text('Rp ${state.transactions[index].amount.toString()}')
          ],
        ),
      ),
    );
  }

  Widget summaryWidget(FinanceState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Balance'),
            Text("Rp ${state.summaries?.saldo.toString() ?? "-"}")
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Income'),
            Text(
              "Rp ${state.summaries?.total_income.toString() ?? "-"}",
              style: TextStyle(color: Colors.green),
            )
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Expense'),
            Text(
              "Rp ${state.summaries?.total_expense.toString() ?? "-"}",
              style: TextStyle(color: Colors.red),
            )
          ],
        )
      ],
    );
  }

  Widget filterWidget(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                onTap: () {
                  showDatePicker(
                          context: context,
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2030),
                          initialDate: date)
                      .then((value) {
                    if (value != null) {
                      setState(() {
                        date = value;
                        dateString = DateFormat("yyyy-MM-dd").format(value);
                      });
                    }
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * .4,
                  padding: EdgeInsets.all(16),
                  decoration:
                      BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
                  child: Text(dateString ?? "Select Date"),
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width * .4,
              child: DropdownButtonFormField(
                  items: ['Income', 'Expense']
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  hint: Text("Select Category"),
                  onChanged: (val) => setState(() {
                        category = val;
                      })),
            ),
          ],
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      context
                        .read<FinanceBloc>()
                        .add(GetTransaction(date: dateString, category: category));
                    });
                  },
                  child: Text('Filter')),
            ),
            SizedBox(width: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * .3,
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      context
                        .read<FinanceBloc>()
                        .add(GetTransaction());
                    });
                  },
                  child: Text('Remove Filter')),
            ),
          ],
        )
      ],
    );
  }
}
