import 'package:appflowy_board/appflowy_board.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:next_starter/presentation/components/button/primary_button.dart';
import 'package:next_starter/presentation/pages/ticket/list/widgets/text_item.dart';
import 'package:next_starter/presentation/routes/app_router.dart';
import 'package:next_starter/presentation/theme/theme.dart';
import 'package:next_starter/presentation/utils/constant.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class TicketListPage extends StatefulWidget {
  const TicketListPage({super.key});

  @override
  State<TicketListPage> createState() => _TicketListPageState();
}

class _TicketListPageState extends State<TicketListPage> {
  final AppFlowyBoardController controller = AppFlowyBoardController();
  final AppFlowyBoardScrollController boardScroll = AppFlowyBoardScrollController();

  final config = AppFlowyBoardConfig(
    groupBackgroundColor: HexColor.fromHex('#F7F8FC'),
    stretchGroupHeight: false,
  );

  @override
  void initState() {
    super.initState();

    controller.enableGroupDragging(false);

    for (var e in ticketStatus) {
      controller.addGroup(AppFlowyGroupData(
        id: e,
        name: e.toLowerCase().replaceAll("_", " ").capitalized,
        items: List.generate(10, (index) => TextItem("${index}_$e")),
      ));

      controller.getGroupController(e)!.enableDragging(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Ticket'),
        actions: [
          IconButton(
            onPressed: () async {
              DateTime now = DateTime.now();
              await showDateRangePicker(
                context: context,
                initialDateRange: DateTimeRange(
                  start: DateTime(now.year, now.month, 1),
                  end: DateTime(now.year, now.month + 1, 0),
                ),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
            },
            icon: const Icon(Icons.calendar_month),
          ),
        ],
      ),
      body: AppFlowyBoard(
        groupConstraints: const BoxConstraints(minWidth: 290, maxWidth: 300),
        config: const AppFlowyBoardConfig(
          groupPadding: EdgeInsets.zero,
          groupItemPadding: EdgeInsets.only(right: 8),
          headerPadding: EdgeInsets.symmetric(horizontal: 8),
          cardPadding: EdgeInsets.symmetric(vertical: 8),
          cornerRadius: 4,
        ),
        controller: controller,
        boardScrollController: boardScroll,
        cardBuilder: (BuildContext context, AppFlowyGroupData<dynamic> groupData, AppFlowyGroupItem item) {
          return AppFlowyGroupCard(
            margin: const EdgeInsets.symmetric(vertical: 8),
            key: ValueKey(item.id),
            child: InkWell(
              onTap: () {
                context.router.push(const TicketDetailRoute());
              },
              child: Container(
                width: 285,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TICKET/12-12-2024/1/KAI',
                      style: CustomTextTheme.paragraph2.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Text('Action', style: CustomTextTheme.paragraph1),
                    const SizedBox(height: 4),
                    Text(
                      'Fixing Broken Pipe In Sector',
                      style: CustomTextTheme.paragraph2.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Text('Employee', style: CustomTextTheme.paragraph1),
                    const SizedBox(height: 4),
                    Text('MR John Doe', style: CustomTextTheme.paragraph2.copyWith(fontWeight: FontWeight.w600)),
                    groupData.id != "ADMIN_APPROVED" ? const SizedBox(height: 8) : const SizedBox.shrink(),
                    groupData.id != "ADMIN_APPROVED"
                        ? Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                decoration:
                                    BoxDecoration(color: ColorTheme.primary, borderRadius: BorderRadius.circular(4)),
                                child: Text(
                                  'UNIT_ID_HERE',
                                  style: CustomTextTheme.caption.copyWith(color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ).expand(),
                              const SizedBox(width: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                decoration:
                                    BoxDecoration(color: ColorTheme.primary, borderRadius: BorderRadius.circular(4)),
                                child: Text(
                                  'Blok Rokan Hulu Riau',
                                  style: CustomTextTheme.caption.copyWith(color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ).expand(),
                            ],
                          )
                        : Container(),
                    groupData.id == "ADMIN_APPROVED" ? const SizedBox(height: 8) : const SizedBox.shrink(),
                    groupData.id == "ADMIN_APPROVED"
                        ? Row(
                            children: [
                              PrimaryButton(
                                title: 'Reject',
                                isSmall: true,
                                backgroundColor: Colors.red,
                                onTap: () {},
                              ).expand(),
                              const SizedBox(width: 4),
                              PrimaryButton(
                                title: 'Accept',
                                isSmall: true,
                                backgroundColor: ColorTheme.primary,
                                onTap: () {},
                              ).expand(),
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          );
        },
        headerBuilder: (context, columnData) {
          return AppFlowyGroupHeader(
            margin: const EdgeInsets.only(top: 8),
            title: Row(
              children: [
                const SizedBox(width: 8),
                Text(columnData.headerData.groupName,
                    style: CustomTextTheme.paragraph3.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: ColorTheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    '10',
                    style: CustomTextTheme.paragraph1.copyWith(color: ColorTheme.primary),
                  ),
                )
              ],
            ),
            height: 42,
          );
        },
      ),
    );
  }
}
