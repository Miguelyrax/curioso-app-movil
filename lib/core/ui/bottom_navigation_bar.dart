import 'package:curioso_app/core/themes/colors.dart';
import 'package:curioso_app/core/ui/custom_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/user/presentation/bloc/user_bloc.dart';
import '../constants/constants.dart';

class CustomBottomNavigatorBar extends StatefulWidget {
  final PageController pageController;

  const CustomBottomNavigatorBar({Key? key, required this.pageController})
      : super(key: key);

  @override
  State<CustomBottomNavigatorBar> createState() =>
      _CustomBottomNavigatorBarState();
}

class _CustomBottomNavigatorBarState extends State<CustomBottomNavigatorBar> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }
  int index = 1;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
      color: CuriosityColors.blackbeige,
        border: Border(top: BorderSide(color: CuriosityColors.white.withOpacity(.1))),
      ),
      width: size,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if(state is UserHasData){
                return CustomItem<int?>(
                      gruopValue: index,
                      value: 0,
                      icon: index==0?Icons.favorite_rounded:Icons.favorite_outline,
                      onChanged: (int? value){
                        HapticFeedback.lightImpact();
                          index=value!;
                          widget.pageController.jumpToPage(value);
                          setState(() {
                          });
                      },
                    );
              }else{
                return CustomItem<int?>(
                          gruopValue: index,
                          value: 0,
                          icon:Icons.person,
                          onChanged: (int? value){
                            HapticFeedback.lightImpact();
                              index=value!;
                              widget.pageController.jumpToPage(value);
                              setState(() {});
                          },
                      ); 
              }
            },
          ),
          
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
                index = 1;
                widget.pageController.jumpToPage(1);
                setState(() {});
              },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: CuriosityColors.beige,
                borderRadius: BorderRadius.circular(8)
              ),
                child:  Icon(
                  Icons.trending_up,
                  color:index==1?CuriosityColors.dark: CuriosityColors.mirage,
                ),
                
              ),
          ),
          CustomItem<int?>(
              gruopValue: index,
              value: 2,
              icon: Icons.newspaper,
              onChanged: (int? value){
                HapticFeedback.lightImpact();
                  index=value!;
                  widget.pageController.jumpToPage(value);
                  setState(() {
                  });
              },
          )
        ],
      ),
    );
  }
}
