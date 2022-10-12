import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../../modulus/web_view/web_view.dart';

Widget buildArticleItem(article , context ,)
{
  return InkWell(
    onTap: ()
    {
      navigateTo(context, WebViewScreen(article['url']));
    },
    child: Padding(
      padding:  EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 120.0,
            height: 120.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: NetworkImage(
                  '${article['urlToImage']}',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
           SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: SizedBox(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${article['title']}',
                      style: Theme.of(context).textTheme.bodyText1 ,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${article['publishedAt']}',
                    style:  TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildMyDivider()
{
  return Container(
    height: 1,
    color: Colors.grey[300],
  );
}

Widget articleBuilder(list , context,{isSearch = false})
{
  return ConditionalBuilder(
    condition: list.length >0,
    builder: (context) => ListView.separated(
      physics:  BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildArticleItem(list[index] , context),
      separatorBuilder: (context, index) => buildMyDivider(),
      itemCount: 10,
    ),
    fallback: (context) => isSearch ? Container() : Center(child: CircularProgressIndicator()),
  );
}

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
   onSubmit,
   onChange,
   onTap,
  bool isPassword = false,
  required  validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
   suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffix,
          ),
        )
            : null,
        border: OutlineInputBorder(),
      ),
    );
void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);