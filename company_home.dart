import 'package:flutter/material.dart';
import 'package:myjob/model/data.dart';
import 'package:myjob/widget/drop_down_menu.dart';
import 'package:myjob/widget/screen_modal.dart';
import 'package:myjob/router/custom_router.dart';
import 'ui/index.dart';
import 'address_modal.dart';
class CompanyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState()=>CompanyHomePageState();
}

class CompanyHomePageState extends State<CompanyHomePage> with AutomaticKeepAliveClientMixin {
  List<Company> companys = [];
  List<String> _dropDownHeaderItemStrings = [];

  List<MenuCondition> _sortConditions = [];
  MenuCondition selectSortCondition;

  PageController _pageController;
  DropdownMenuController _dropdownMenuController = DropdownMenuController();
  ScreenModalController adressController = ScreenModalController();
  bool selectSort = false;
  bool selectAddress = false;
  bool selectType = false;
  int pageIndex= 0;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey _stackKey = GlobalKey();
  GlobalKey _keyDropDownHearder = GlobalKey();
  AdressParam adressParam = new AdressParam(selectDot: [0]);
  @override
  bool get wantKeepAlive => true;
  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
 @override
  void initState() {
    super.initState();
    _pageController = new PageController(initialPage: pageIndex, keepPage: true);
    _sortConditions.add(MenuCondition(name: '推荐', isSelected: true));
    _sortConditions.add(MenuCondition(name: '距离近', isSelected: false));
    _dropDownHeaderItemStrings.add(_sortConditions[0].name);

    _dropDownHeaderItemStrings.add('上海');
    _dropDownHeaderItemStrings.add('筛选');

    // customcontroller.addListener((){ });
    for (int i = 0; i < 20; i++) {
      companys.add(Company(
          financing: "已上市",
          name: "阿里巴巴",
          scale: "10000人以上",
          address: "上海 普陀区 长征",
          industry: "互联网",
          jobcount: 165,
          jobs: [Job(work:'高级前端开发工程师')],
          // logo:'https://img.bosszhipin.com/beijin/upload/com/logo/20191021/2f27f008c37bef718297fb25a43d12ce5464992ddb1862903d49e245f2a353e0.jpg?x-oss-process=image/resize,w_120,limit_0'
          logo:"https://img.bosszhipin.com/beijin/mcs/bar/20180906/5fd9804307c9e266559d8c4c911d228fbe1bd4a3bd2a63f070bdbdada9aad826.png?x-oss-process=image/resize,w_120,limit_0"
      ));
    }
  }
  _buildConditionListWidget(items, void itemOnTap(MenuCondition value)) {
    return MediaQuery.removePadding( removeTop: true, context: context,
      child:  Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child:  ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: items.length,
          // item 的个数
          separatorBuilder: (BuildContext context, int index) => Divider(height: 0.2,color: Colors.grey[200],),
          // 添加分割线
          itemBuilder: (BuildContext context, int index) {
            MenuCondition goodsSortCondition = items[index];
            return GestureDetector(
              onTap: () {
                for (var value in items) {
                  value.isSelected = false;
                }
                goodsSortCondition.isSelected = true;

                itemOnTap(goodsSortCondition);
              },
              child: Container(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        goodsSortCondition.name,
                        style: TextStyle(
                          color: goodsSortCondition.isSelected ? Theme.of(context).accentColor : Colors.black,
                        ),
                      ),
                    ),
                    goodsSortCondition.isSelected
                        ? Icon(
                            Icons.check,
                            color: Theme.of(context).accentColor,
                            size: 16,
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            );
          },
        )

      )
    );
  }
  Widget listItemWidget(BuildContext context, Company companyItem,int index) => Container(
    // margin: EdgeInsets.only(bottom: 8),
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey[100].withOpacity(0.8),
            blurRadius: 1.0,
          ),
        ]
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:<Widget>[
        Container(
          width: 60,
          height: 60,
          margin: EdgeInsets.only(right:15),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
                image: NetworkImage(companyItem.logo),
                fit: BoxFit.cover),
          ),
        ),
        Expanded(
          child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(companyItem.name,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: Colors.black87),),
            SizedBox(height: 8),
            Text(companyItem.address,style: TextStyle(color: Colors.black87,fontSize: 13),),
            SizedBox(height: 8),
            Row(
              children: <Widget>[
                backgroundContainer(companyItem.financing),
                SizedBox(width: 4),
                backgroundContainer(companyItem.scale),
                SizedBox(width: 4),
                backgroundContainer(companyItem.industry),
            ]),
            Container(
              padding: EdgeInsets.only(top:10),
              margin: EdgeInsets.only(top:10),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                  color: Colors.grey[300],
                  width: 0.2,
                  style: BorderStyle.solid
                ))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width-130,
                    child:RichText(
                    softWrap: true,
                    maxLines: 1,
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.ellipsis,
                    text:TextSpan(
                      children: <TextSpan>[
                        TextSpan(text: '热招：',style: TextStyle(fontSize: 11,color: Colors.grey)),
                        TextSpan(text: '${companyItem.jobs[0].work}',style: TextStyle(fontSize: 11,color: Theme.of(context).accentColor)),
                        TextSpan(text: '等${companyItem.jobcount}个职位',style: TextStyle(fontSize: 11,color: Colors.grey)),
                  ]))),
                  Icon(Icons.chevron_right,color:Colors.grey ,size: 20,)
                ],
              ),
            )  
          ],
      ))
    ]));
  
  Widget appBar() => SliverAppBar(
    pinned: true,
    elevation: 0.0,
    centerTitle: false,
    title: Row(
      children: <Widget>[
      GestureDetector(
        onTap: ()=>setState(() { 
          pageIndex = 0;
          _pageController.jumpToPage(0);
        }),
        child: Text('公司',style: TextStyle(color: Colors.white,fontSize: pageIndex==0?20:16)),
      ),
      SizedBox(width: 10,),
      GestureDetector(
         onTap: ()=>setState(() { 
          pageIndex = 1;
          _pageController.jumpToPage(1);
        }),
        child: Text('探秘',style: TextStyle(color: Colors.white,fontSize: pageIndex==1?20:16)),
      )
    ],),
    actions:<Widget>[
      IconButton(
        iconSize: 28,
        color: Colors.white,
        onPressed: () {},
        icon: Icon(Icons.search),
      )
    ]
    // ),
  );
  
  Widget listHeader() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      selectButton('排序',selectSort,(){
        final RenderBox overlay = _stackKey.currentContext.findRenderObject();
          final RenderBox dropDownItemRenderBox = _keyDropDownHearder.currentContext.findRenderObject();
          var position = dropDownItemRenderBox.localToGlobal(Offset.zero, ancestor: overlay);
          _dropdownMenuController.dropDownHearderHeight = 40 + position.dy;
          
          if (_dropdownMenuController.isShow) {
            _dropdownMenuController.hide();
          } else { 
            // _dropdownMenuController.hide();
            _dropdownMenuController.show();
          }
          // if (widget.onItemTap != null) {
          //   widget.onItemTap(index);
          // }
          setState(() {});
      }),
      selectButton(adressParam.title,selectAddress,(){
        if (_dropdownMenuController.isShow) {
          _dropdownMenuController.hide();
        }
        Navigator.push(context, BottomPopupRouter(
          AddressModal(adressParam: adressParam)
        )).then((result) {
          print(result);
        });
        // if (adressController.isShow) {
        //     adressController.hide();
        //   } else { 
        //     // _dropdownMenuController.hide();
        //     adressController.show();
        //   }
        //   // if (widget.onItemTap != null) {
        //   //   widget.onItemTap(index);
        //   // }
        //   setState(() {});
      }
      ),
      selectButton('筛选',selectType,(){
        setState(() {
          selectType = !selectType;
          selectAddress= false;
          selectSort = false;
        });
      })
    ]
  );
  Widget backgroundContainer(text)=>Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 0),
      height: 20,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(3.0),
      ),
      child:  Text(text,style: TextStyle(fontSize: 11,color: Colors.grey)),
  );
  Widget selectButton(text,active,onPressed) => InkWell(
    onTap: onPressed,
    child: Row(
      children: <Widget>[
         Text(text,style: TextStyle(fontSize: 14,color:active?Theme.of(context).accentColor:Colors.grey ),),
         Icon(
          active?Icons.arrow_drop_up :Icons.arrow_drop_down,
          color: active?Theme.of(context).accentColor:Colors.grey,size: 16,)
      ],
    )
  );
  @override
  Widget build(BuildContext context) {
    super.build(context);
    var screenWidth = MediaQuery.of(context).size.width;
    var tabWidth = (screenWidth-50)/3;
    return Scaffold(
      key:_scaffoldKey,
      backgroundColor: Colors.grey[100],
      body: Stack(
        key:_stackKey,
        children: <Widget>[
          NestedScrollView(
            headerSliverBuilder: (context, isscrolled) {
              return [
                appBar(),
              ];
            },
            body: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: <Widget>[
                CustomScrollView(slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Container(
                      key:_keyDropDownHearder,
                      height: 40,
                      padding:EdgeInsets.symmetric(horizontal: 15,vertical: 0),
                      color: Colors.white,
                      child:  listHeader()
                    )
                  ,),
                  // SliverToBoxAdapter(
                  //   child: Container(
                  //     padding:EdgeInsets.symmetric(horizontal: 15,vertical: 0),
                  //     color: Colors.white,
                  //     child: DropDownHeader(
                  //       items: [
                  //         DropDownHeaderItem(_dropDownHeaderItemStrings[0],width: tabWidth),
                  //         DropDownHeaderItem(_dropDownHeaderItemStrings[1],width: tabWidth),
                  //         DropDownHeaderItem(_dropDownHeaderItemStrings[2],width: tabWidth)
                  //       ],
                  //       stackKey: _stackKey,
                  //       controller: _dropdownMenuController,
                  //     ),
                  //   )
                  // ,),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      
                      (BuildContext context,int index){
                          return CompanyItem(companyItem: companys[index], index: index);
                        },
                        childCount: companys.length
                        )
                  )]
                ),
                CompanyDemystify(),
              ],
          )
        ),
         DropDownMenu(
            controller: _dropdownMenuController,
            height: 40.0 * _sortConditions.length,
            child: _buildConditionListWidget(_sortConditions, (value) {
                  selectSortCondition = value;
                  _dropDownHeaderItemStrings[0] = selectSortCondition.name;
                  _dropdownMenuController.hide();
                  setState(() {});
                })
            ),
            
          ScreenModal(child:Container(color: Colors.red,height: 40,width: 40,) ,controller: adressController,)
            // menus: [
            //   DropdownMenuBuilder(
            //     dropDownHeight: 40.0 * _sortConditions.length,
            //     dropDownWidget:  _buildConditionListWidget(_sortConditions, (value) {
            //       selectSortCondition = value;
            //       _dropDownHeaderItemStrings[0] = selectSortCondition.name;
            //       _dropdownMenuController.hide();
            //       setState(() {});
            //     })
            //   ),
            // ]
      ],)
    );
  }
}
class MenuCondition {
  String name;
  bool isSelected;

  MenuCondition({this.name, this.isSelected});
}
