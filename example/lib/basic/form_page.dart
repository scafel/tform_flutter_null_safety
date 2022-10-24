import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:tform_flutter_null_safety/tform.dart';

import '../utils.dart';
import '../widgets/photos_cell.dart';
import '../widgets/verifitionc_code_button.dart';

class FormPage extends StatelessWidget {
  FormPage({Key? key}) : super(key: key);
  final GlobalKey _formKey = GlobalKey<TFormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("表单"),
        actions: [
          TextButton(
            child: Text(
              "提交",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            onPressed: () {
              //校验
              List errors = (_formKey.currentState as TFormState).validate();
              if (errors.isNotEmpty) {
                showToast(errors.first);
                return;
              }
              //通过
              Map<String , dynamic> formData = (_formKey.currentState as TFormState).formData();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                action: SnackBarAction(
                  label: "关闭",
                  onPressed: () {
                    // Code to execute.
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  },
                ),
                content: Text(
                  formData.toString(),
                ),
                duration: const Duration(milliseconds: 15000),
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0, // Inner padding for SnackBar content.
                    vertical: 10.0
                ),
                behavior: SnackBarBehavior.fixed,
              ));
              showToast("提交成功");

            },
          ),
        ],
      ),
      body: TForm.builder(
        key: _formKey,
        rows: buildFormRows(),
        divider: Divider(
          height: 1,
        ),
      ),
    );
  }
}

List<TFormRow> buildFormRows() {
  return [
    TFormRow.input(
      title: "姓名",
      name:"userName",
      placeholder: "请输入姓名",
      value: "呀哈哈",
      fieldConfig: TFormFieldConfig(
        height: 100,
        titleStyle: TextStyle(color: Colors.red, fontSize: 20),
        valueStyle: TextStyle(color: Colors.orange, fontSize: 30),
        placeholderStyle: TextStyle(color: Colors.green, fontSize: 25),
      ),
    ),
    TFormRow.input(
      enabled: false,
      name:"IDCard",
      requireStar: true,
      title: "身份证号",
      placeholder: "请输入身份证号",
      value: "4101041991892382938293",
    ),
    TFormRow.input(
      keyboardType: TextInputType.number,
      title: "预留手机号",
      name:"phoneNumber",
      placeholder: "请输入手机号",
      maxLength: 11,
      requireMsg: "请输入正确的手机号",
      requireStar: true,
      textAlign: TextAlign.right,
      validator: (row) {
        return RegExp(
                r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$')
            .hasMatch(row.value??" ");
      },
    ),
    TFormRow.input(
      title: "验证码",
      name:"varCode",
      placeholder: "请输入验证码",
      suffixWidget: (context, row) {
        return VerifitionCodeButton(
          title: "获取验证码",
          seconds: 60,
          onPressed: () {
            showToast("验证码已发送");
          },
        );
      },
    ),
    TFormRow.input(
      title: "* 密码",
      name:"password",
      value: "123456",
      obscureText: true,
      state: false,
      placeholder: "请输入密码",
      suffixWidget: (context, row) {
        return GestureDetector(
          onTap: () {
            row.state = !row.state;
            row.obscureText = !(row.obscureText??false);
            TForm.of(context).reload();
          },
          child: Image.asset(
            row.state ? "lib/src/eyes_open.png" : "lib/src/eyes_close.png",
            width: 20,
            height: 20,
          ),
        );
      },
    ),
    TFormRow.customSelector(
      title: "婚姻状况",
      name:"marital",
      placeholder: "请选择",
      state: [
        ["未婚", "已婚"],
        [
          TFormRow.input(
              name:"maritalName",title: "配偶姓名", placeholder: "请输入配偶姓名", requireStar: true),
          TFormRow.input(
              name:"maritalPhone",title: "配偶电话", placeholder: "请输入配偶电话", requireStar: true)
        ]
      ],
      onTap: (context, row) async {
        String value = await showPicker(row.state[0], context);
        if (row.value != value) {
          if (value == "已婚") {
            TForm.of(context).insert(row, row.state[1]);
          } else {
            TForm.of(context).delete(row.state[1]);
          }
        }
        return value;
      },
    ),
    TFormRow.selector(
      title: "学历",
      name:"edu",
      placeholder: "请选择",
      options: [
        TFormOptionModel(value: "专科"),
        TFormOptionModel(value: "本科"),
        TFormOptionModel(value: "硕士"),
        TFormOptionModel(value: "博士")
      ],
    ),
    TFormRow.multipleSelector(
      title: "家庭成员",
      name:"family",
      placeholder: "请选择",
      options:["儿子", "父亲" , "母亲"],
    ),
    TFormRow.customSelector(
      title: "出生年月",
      name:"birth",
      placeholder: "请选择",
      onTap: (context, row) async {
        return showPickerDate(context);
      },
      fieldConfig: TFormFieldConfig(
        selectorIcon: SizedBox.shrink(),
      ),
    ),
    TFormRow.customCell(
      widget: Container(
          color: Colors.grey[200],
          height: 48,
          width: double.infinity,
          alignment: Alignment.center,
          child: Text("------ 我是自定义的Cell ------")),
    ),
    TFormRow.customCellBuilder(
      title: "房屋照片",
      name:"houseImage",
      state: [
        {"picurl": ""},
        {"picurl": ""},
      ],
      requireMsg: "请完成上传房屋照片",
      validator: (row) {
        List<String> images = [];
        (row.state as List).forEach((e) => e["picurl"].length>0?images.add(e["picurl"]):null);
        row.value = images.toString();
        return images.isNotEmpty;
      },
      widgetBuilder: (context, row) {
        return CustomPhotosWidget(row: row);
      },
    ),
  ];
}
