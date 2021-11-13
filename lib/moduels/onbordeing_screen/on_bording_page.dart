import 'package:amazon_colen/moduels/login_screens/shop_loging.dart';
import 'package:amazon_colen/shard/component/components.dart';
import 'package:amazon_colen/shard/network/local/cach_helper.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class BoardingModel{
  final String image;
  final String title;
  final String body;

  BoardingModel({
    @required this.image,
    @required this.title,
    @required this.body,
  });
}
class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boardingPages =[
    BoardingModel(
        image: "assets/images/buysall.jpg",
        title: "Start Shopping",
        body: "get your SALE",
    ),
    BoardingModel(
      image: "assets/images/sale.jpg",
      title: "Enjoy Shopping",
      body: "get your SALE",
    ),
    BoardingModel(
      image: "assets/images/prodact.jpg",
      title: "start Shopping products",
      body: " to get your offer  ",
    ),

  ];

  var pageController = PageController();
  bool isLast = false;
  void submit(){
    CacheHelper.saveData(key: "onBoarding", value: true).then((value) {
      if(value){
        navigateAndFinish(context, ShopLogin());
      }
    });
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        TextButton(onPressed:() {return submit();},
          child: Text("SKIP"),),
      ],),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                physics: BouncingScrollPhysics(),
                onPageChanged: (index){
                  if (index == boardingPages.length - 1){
                    setState(() {
                      isLast = true;
                    });
                  }
                  else{
                    setState(() {
                      isLast = false;
                    });

                  }
                },
                itemBuilder: (context,index)=>buildBoardingItem(boardingPages[index]),
              itemCount: boardingPages.length,
              ),
            ),
            SizedBox(height: 35,),
            Row(
              children: [
                SmoothPageIndicator(controller: pageController,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.blueGrey,
                    activeDotColor: Colors.blue,

                  ),
                  count: boardingPages.length,),
                Spacer(),
                FloatingActionButton(onPressed: (){
                  if (isLast == true ){
                    submit();
                  }
                  else{
                    pageController.nextPage(
                      duration: Duration(
                          milliseconds: 750
                      ),
                      curve:Curves.fastLinearToSlowEaseIn,
                    );

                  }

                },
                  child: Icon(Icons.arrow_forward_ios),
                )

              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel boardingModel)=> Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image: AssetImage("${boardingModel.image}"),
        ),
      ),
      SizedBox(height: 30,),
      Text("${boardingModel.title}",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
      SizedBox(height: 15,),
      Text("${boardingModel.body}"),
      SizedBox(height: 20,),

    ],
  );
}
