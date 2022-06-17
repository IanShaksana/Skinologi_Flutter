import 'dart:io';
import 'package:flutter/src/widgets/image.dart' as img;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:replikasi_marketing_tracker/api/printing/pdf_api.dart';
import 'package:replikasi_marketing_tracker/model/printing/customer.dart';
import 'package:replikasi_marketing_tracker/model/printing/invoice.dart';
import 'package:replikasi_marketing_tracker/model/printing/supplier.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/model_inventory.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/response/model_treatment_tx_treatment_detail.dart';
import 'package:replikasi_marketing_tracker/util/general.dart';

class PdfInvoiceApi {
  String skinAddress = 'ISTANA DIENG UTARA II NO.14, MALANG';
  String skinContact = '081233769194';
  String skinHeaderPayment = 'Payment is due within 1 Day';
  String skinPaymentMethod = 'Bank Transfer';
  String skinPaymentNumber1 = 'BCA 2630585859 (Dwi Jayanti Natalia)';
  String skinPaymentNumber2 = 'Mandiri 1400016640329 (Dwi Jayanti Natalia)';

  String phNumberInvoice = '';
  // String phRecipientName = 'CE EKA';
  // String phRecipientContact = '081333319808';
  // String phRecipientTown = 'Banyuwangi';

  Future<File> generate(ModelTreatmentTxTreatmentDetail model,
      List<ModelInventory> lInventory) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      orientation: pw.PageOrientation.landscape,
      header: (context) => buildSkinologiHeader(),
      build: (context) => [
        SizedBox(height: 1 * PdfPageFormat.cm),
        // buildTitle(invoice),
        // buildInvoice(invoice),
        // buildTotal(invoice),
        buildSkinologiBody(model, lInventory),
        buildSkinologiTotal(model),
        // buildSkinologiTotal(model),

        SizedBox(height: 1 * PdfPageFormat.cm),
      ],
      footer: (context) => buildSkinologiFooter(),
    ));

    return PdfApi.saveDocument(
        name: '${model.treatmentTx!.idTreatmentTx!}.pdf', pdf: pdf);
  }

  Widget buildSkinologiHeader() => Column(children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 1 * PdfPageFormat.cm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('INVOICE',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0)),
                SizedBox(height: 0.5 * PdfPageFormat.cm),
                Text(phNumberInvoice,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: PdfColors.amber,
                        fontSize: 20.0)),
              ],
            ),
            Expanded(child: Container()),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // logo
                Container(
                  height: 50,
                  width: 50,
                  // need skinologi logo
                  child: pw.FittedBox(
                    child: pw.Image(pw.MemoryImage(
                      File('C:/Skinologi/white.png').readAsBytesSync(),
                    )),
                  ),
                ),
              ],
            ),
          ],
        ),
        // need black divider
        customDivider(height: 5 * PdfPageFormat.mm),
      ]);

  Widget buildSkinologidAddress() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('SKINOLOGI', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(skinAddress),
        ],
      );

  Widget buildSkinologiInvoiceHeader(ModelTreatmentTxTreatmentDetail model) {
    final headers = [
      'KETERANGAN',
      'JML',
      'TARIF',
      'HARGA',
    ];
    var data = model.treatment!.map((item) {
      final total = item.price;

      return [
        item.name,
        '1',
        (formatMoney(total.toString())),
        (formatMoney(total.toString())),
      ];
    }).toList();

    data.addAll(model.treatmentUsage!.map((item) {
      final total = item.realQuantity! * 10000;
      return [
        item.idInventory,
        item.realQuantity.toString(),
        (formatMoney(10000.toString())),
        (formatMoney(total.toString())),
      ];
    }).toList());

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: pw.TableBorder.symmetric(inside: pw.BorderSide.none),
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
      },
    );
  }

  Widget buildSkinologiInvoice(
      ModelTreatmentTxTreatmentDetail model, List<ModelInventory> lInventory) {
    var data = model.treatment!.map((item) {
      final total = item.price;

      return [
        item.name,
        '1',
        (formatMoney(total.toString())),
        (formatMoney(total.toString())),
      ];
    }).toList();

    for (var i = 0; i < model.treatmentUsage!.length; i++) {
      var usage = model.treatmentUsage![i];
      var inventory = lInventory[i];

      final total = usage.realQuantity! * inventory.price!;
      var x = [
        inventory.name,
        usage.realQuantity.toString(),
        (formatMoney(inventory.price!.toString())),
        (formatMoney(total.toString())),
      ].toList();
      data.add(x);
    }

    // data.addAll(model.treatmentUsage!.map((item) {
    //   var price = 0;
    //   var name = '';
    //   if (item.realQuantity == 1) {
    //     name = 'Benang';
    //     price = 75000;
    //   } else {
    //     name = 'Obat X';
    //     price = 100000;
    //   }

    //   final total = item.realQuantity! * price;
    //   return [
    //     name,
    //     item.realQuantity.toString(),
    //     (formatMoney(price.toString())),
    //     (formatMoney(total.toString())),
    //   ];
    // }).toList());

    final headers = [
      'KETERANGAN',
      'JML',
      'TARIF',
      'HARGA',
    ];

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
      },
    );
  }

  Widget buildSkinologiTotal(ModelTreatmentTxTreatmentDetail model) {
    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2 * PdfPageFormat.mm),
              Text(skinHeaderPayment,
                  style: TextStyle(fontWeight: FontWeight.normal)),
              Text(skinPaymentMethod,
                  style: TextStyle(fontWeight: FontWeight.normal)),
              Text(skinPaymentNumber1,
                  style: TextStyle(fontWeight: FontWeight.normal)),
              Text(skinPaymentNumber2,
                  style: TextStyle(fontWeight: FontWeight.normal)),
            ],
          ),
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 2 * PdfPageFormat.mm),
                Text('TOTAL', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(formatMoney(model.treatmentTx!.totalPrice!.toString()),
                    style: TextStyle(fontWeight: FontWeight.normal)),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Text('DISCOUNT', style: TextStyle(fontWeight: FontWeight.bold)),

                Text(
                    '(' +
                        formatMoney(model.treatmentTx!.discount!.toString()) +
                        ')',
                    style: TextStyle(fontWeight: FontWeight.normal)),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Text(formatMoney(model.treatmentTx!.realPrice!.toString()),
                    style: TextStyle(fontWeight: FontWeight.normal)),

                // buildText(
                //   title: 'Vat ${vatPercent * 100} %',
                //   value: Utils.formatPrice(vat),
                //   unite: true,
                // ),
                // Divider(),
                // buildText(
                //   title: 'Total amount due',
                //   titleStyle: TextStyle(
                //     fontSize: 14,
                //     fontWeight: FontWeight.bold,
                //   ),
                //   value: Utils.formatPrice(total),
                //   unite: true,
                // ),
                // SizedBox(height: 2 * PdfPageFormat.mm),
                // Container(height: 1, color: PdfColors.grey400),
                // SizedBox(height: 0.5 * PdfPageFormat.mm),
                // Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSkinologiFooter() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // yellow divider
          customDivider(color: PdfColors.amber, height: 5 * PdfPageFormat.mm),
          SizedBox(height: 2 * PdfPageFormat.mm),
          buildSimpleText(title: '', value: skinAddress + ' :: ' + skinContact),
          SizedBox(height: 1 * PdfPageFormat.mm),
        ],
      );

  Widget buildSkinologiBody(
      ModelTreatmentTxTreatmentDetail model, List<ModelInventory> lInventory) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        width: 10 * PdfPageFormat.cm,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(model.patient!.name!,
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(model.patient!.contact!,
                style: TextStyle(fontWeight: FontWeight.normal)),
            Text(model.patient!.address!,
                style: TextStyle(fontWeight: FontWeight.normal)),

            // Text(skinHeaderPayment,
            //     style: TextStyle(fontWeight: FontWeight.bold)),
            // Text(skinPaymentMethod,
            //     style: TextStyle(fontWeight: FontWeight.bold)),
            // Text(skinPaymentNumber1,
            //     style: TextStyle(fontWeight: FontWeight.bold)),
            // Text(skinPaymentNumber2,
            //     style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      Expanded(
        child: Column(
          children: [
            // customDivider(color: PdfColors.amber, height: 1),
            // buildSkinologiInvoiceHeader(model),
            customDivider(color: PdfColors.amber, height: 1),
            buildSkinologiInvoice(model, lInventory),
            customDivider(color: PdfColors.amber, height: 1),
          ],
        ),
      ),
    ]);
  }

  Widget customDivider({double? height, PdfColor? color}) {
    return SizedBox(
      height: height ?? 10.0,
      child: Center(
        child: Container(
          height: 5.0,
          color: color ?? PdfColors.black,
        ),
      ),
    );
  }

  static Widget buildHeader(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildSupplierAddress(invoice.supplier),
              Container(
                height: 50,
                width: 50,
                child: BarcodeWidget(
                  barcode: Barcode.qrCode(),
                  data: invoice.info.number,
                ),
              ),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildCustomerAddress(invoice.customer),
              buildInvoiceInfo(invoice.info),
            ],
          ),
        ],
      );

  static Widget buildCustomerAddress(Customer customer) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(customer.name, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(customer.address),
        ],
      );

  static Widget buildInvoiceInfo(InvoiceInfo info) {
    final paymentTerms = '${info.dueDate.difference(info.date).inDays} days';
    final titles = <String>[
      'Invoice Number:',
      'Invoice Date:',
      'Payment Terms:',
      'Due Date:'
    ];
    final data = <String>[
      info.number,
      Utils.formatDate(info.date),
      paymentTerms,
      Utils.formatDate(info.dueDate),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 200);
      }),
    );
  }

  static Widget buildSupplierAddress(Supplier supplier) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(supplier.name, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(supplier.address),
        ],
      );

  static Widget buildTitle(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'INVOICE',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          Text(invoice.info.description),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildInvoice(Invoice invoice) {
    final headers = [
      'Description',
      'Date',
      'Quantity',
      'Unit Price',
      'VAT',
      'Total'
    ];
    final data = invoice.items.map((item) {
      final total = item.unitPrice * item.quantity * (1 + item.vat);

      return [
        item.description,
        Utils.formatDate(item.date),
        '${item.quantity}',
        '\$ ${item.unitPrice}',
        '${item.vat} %',
        '\$ ${total.toStringAsFixed(2)}',
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: const BoxDecoration(color: PdfColors.amber),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
        5: Alignment.centerRight,
      },
    );
  }

  static Widget buildTotal(Invoice invoice) {
    final netTotal = invoice.items
        .map((item) => item.unitPrice * item.quantity)
        .reduce((item1, item2) => item1 + item2);
    final vatPercent = invoice.items.first.vat;
    final vat = netTotal * vatPercent;
    final total = netTotal + vat;

    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                  title: 'Net total',
                  value: Utils.formatPrice(netTotal),
                  unite: true,
                ),
                buildText(
                  title: 'Vat ${vatPercent * 100} %',
                  value: Utils.formatPrice(vat),
                  unite: true,
                ),
                Divider(),
                buildText(
                  title: 'Total amount due',
                  titleStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  value: Utils.formatPrice(total),
                  unite: true,
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildFooter(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          buildSimpleText(title: 'Address', value: invoice.supplier.address),
          SizedBox(height: 1 * PdfPageFormat.mm),
          buildSimpleText(title: 'Paypal', value: invoice.supplier.paymentInfo),
        ],
      );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style =
        TextStyle(fontWeight: FontWeight.normal, color: PdfColors.amber);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value, style: style),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}
