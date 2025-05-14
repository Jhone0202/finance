import 'package:finance/home/controllers/home_controller.dart';
import 'package:finance/home/entities/transaction.dart';
import 'package:finance/home/entities/transaction_status_enum.dart';
import 'package:finance/home/shared/formatters.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeBodyData extends StatefulWidget {
  const HomeBodyData({
    super.key,
    required this.transactions,
    required this.total,
    required this.onStatusChanged,
    required this.selectedStatus,
  });

  final List<Transaction> transactions;
  final double total;
  final Function(TRANSACTION_STATUS) onStatusChanged;
  final TRANSACTION_STATUS selectedStatus;

  @override
  State<HomeBodyData> createState() => _HomeBodyDataState();
}

class _HomeBodyDataState extends State<HomeBodyData> {
  late ScrollController _scrollController;
  late HomeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = context.read<HomeController>();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _controller.loadMore();
    }
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Transaction Type'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('All'),
                onTap: () {
                  widget.onStatusChanged(TRANSACTION_STATUS.all);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Approved'),
                onTap: () {
                  widget.onStatusChanged(TRANSACTION_STATUS.approved);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Pending'),
                onTap: () {
                  widget.onStatusChanged(TRANSACTION_STATUS.pending);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Rejected'),
                onTap: () {
                  widget.onStatusChanged(TRANSACTION_STATUS.rejected);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total Transactions'),
                    Text(
                      formatRealBr(widget.total),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: TextButton.icon(
                onPressed: () => _showFilterDialog(context),
                label: Text(getStatusText(widget.selectedStatus)),
                icon: const Icon(Icons.filter_list),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.separated(
            controller: _scrollController,
            separatorBuilder: (context, index) => const Divider(
              color: Colors.black12,
            ),
            itemCount: widget.transactions.length,
            itemBuilder: (context, index) {
              final transaction = widget.transactions[index];
              return Column(
                children: [
                  ListTile(
                    title: Text(
                      getFriendlyDateTime(transaction.date),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    subtitle: Text(
                      transaction.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    trailing: Text(
                      formatRealBr(transaction.amount),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: getStatusColor(transaction.status),
                          ),
                    ),
                  ),
                  if (index == widget.transactions.length - 1 &&
                      _controller.isLoadingMore)
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
