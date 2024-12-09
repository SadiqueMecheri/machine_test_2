import 'dart:io';
import 'package:flutter/services.dart';
import '../contraints.dart';
import 'file_handle_api.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfInvoiceApi {
  static Future<File> generate(
    PdfColor color,
    pw.Font fontFamily,
    // UserViewmodel user, OrderDetailsViewmodel orderhistory
  ) async {
    final pdf = pw.Document();

    final iconImage =
        (await rootBundle.load('assets/images/logo.png')).buffer.asUint8List();
    final watermarkImage =
        (await rootBundle.load('assets/images/logo.png')).buffer.asUint8List();
    final signImage =
        (await rootBundle.load('assets/images/sign.jpeg')).buffer.asUint8List();

    final tableHeaders = [
      'Treatment',
      'Price',
      'Male',
      'Female',
      'Total',
    ];
    final font =
        pw.Font.ttf(await rootBundle.load('assets/fonts/Poppins-Regular.ttf'));

    final boldfont =
        pw.Font.ttf(await rootBundle.load('assets/fonts/Poppins-Bold.ttf'));

    pdf.addPage(
      pw.MultiPage(
        build: (context) {
          return [
            pw.Stack(alignment: pw.Alignment.center, children: [
              pw.Image(pw.MemoryImage(watermarkImage),
                  height: 450, width: 450, alignment: pw.Alignment.center),
              pw.Column(children: [
                pw.Row(
                  children: [
                    pw.Image(
                      pw.MemoryImage(iconImage),
                      height: 50,
                      width: 50,
                    ),
                    pw.Spacer(),
                    pw.Column(
                      mainAxisSize: pw.MainAxisSize.min,
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text(
                          'KUMARAKOM',
                          textAlign: pw.TextAlign.end,
                          style: pw.TextStyle(
                            fontSize: 15.5,
                            fontWeight: pw.FontWeight.bold,
                            color: color,
                            font: font,
                          ),
                        ),
                        pw.Text(
                          'Cheepunkal P.O. Kumarokom, Kottayam, Kerala - 686563',
                          textAlign: pw.TextAlign.end,
                          style: pw.TextStyle(
                            fontSize: 14.0,
                            color: PdfColors.grey400,
                            font: font,
                          ),
                        ),
                        pw.Text(
                          'e-mail: unknown@gmail.com',
                          textAlign: pw.TextAlign.end,
                          style: pw.TextStyle(
                            fontSize: 14.0,
                            color: PdfColors.grey400,
                            font: font,
                          ),
                        ),
                        pw.Text(
                          'Meb: +91 9876543210 | +91 9876543210',
                          textAlign: pw.TextAlign.end,
                          style: pw.TextStyle(
                            fontSize: 14.0,
                            color: PdfColors.grey400,
                            font: font,
                          ),
                        ),
                        pw.Text(
                          "GST No: 32AABCU9603R1ZW",
                          textAlign: pw.TextAlign.end,
                          style: pw.TextStyle(
                            fontSize: 14.0,
                            color: color,
                            font: font,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 1 * PdfPageFormat.mm),
                pw.Divider(color: PdfColors.grey400, thickness: 1),
                pw.SizedBox(height: 1 * PdfPageFormat.mm),

                pw.SizedBox(height: 5 * PdfPageFormat.mm),
                pw.Align(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Text(
                    "Patient Details",
                    style: pw.TextStyle(
                      fontSize: 16.0,
                      color: PdfColor.fromInt(AppColors().buttonColor.value),
                      fontWeight: pw.FontWeight.bold,
                      font: boldfont,
                    ),
                  ),
                ),

                pw.Table(
                  border: null,
                  columnWidths: {
                    0: pw.FlexColumnWidth(2), // First column takes 1 part
                    1: pw.FlexColumnWidth(2.5), // Second column takes 2 parts
                    2: pw.FlexColumnWidth(3), // Third column takes 3 parts
                  },
                  children: <pw.TableRow>[
                    pw.TableRow(
                      children: [
                        pw.SizedBox(height: 10), // Add space between rows
                        pw.SizedBox(height: 10),
                        pw.SizedBox(height: 10),
                      ],
                    ),
                    pw.TableRow(
                      children: [
                        pw.Text(
                          'Name',
                          style: pw.TextStyle(
                            fontSize: 13.0,
                            color: color,
                            font: font,
                          ),
                        ),
                        pw.Text(
                          'Salih T',
                          style: pw.TextStyle(
                            fontSize: 13.0,
                            color: PdfColors.grey400,
                            font: font,
                          ),
                        ),
                        pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                              pw.Text(
                                'Booked On',
                                style: pw.TextStyle(
                                  fontSize: 13.0,
                                  color: color,
                                  font: font,
                                ),
                              ),
                              pw.SizedBox(width: 5),
                              pw.Text(
                                '33/33/3333 | 12:12pm',
                                style: pw.TextStyle(
                                  fontSize: 13.0,
                                  color: PdfColors.grey400,
                                  font: font,
                                ),
                              ),
                            ]),
                      ],
                    ),
                    pw.TableRow(
                      children: [
                        pw.SizedBox(height: 10), // Add space between rows
                        pw.SizedBox(height: 10),
                        pw.SizedBox(height: 10),
                      ],
                    ),
                    pw.TableRow(
                      children: [
                        pw.Text(
                          'Address',
                          style: pw.TextStyle(
                            fontSize: 13.0,
                            color: color,
                            font: font,
                          ),
                        ),
                        pw.Text(
                          'Nadakkave, Kozhikode',
                          style: pw.TextStyle(
                            fontSize: 13.0,
                            color: PdfColors.grey400,
                            font: font,
                          ),
                        ),
                        pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                              pw.Text(
                                'Treatment Date',
                                style: pw.TextStyle(
                                  fontSize: 13.0,
                                  color: color,
                                  font: font,
                                ),
                              ),
                              pw.SizedBox(width: 5),
                              pw.Text(
                                '33/33/3333',
                                style: pw.TextStyle(
                                  fontSize: 13.0,
                                  color: PdfColors.grey400,
                                  font: font,
                                ),
                              ),
                            ]),
                      ],
                    ),
                    pw.TableRow(
                      children: [
                        pw.SizedBox(height: 10), // Add space between rows
                        pw.SizedBox(height: 10),
                        pw.SizedBox(height: 10),
                      ],
                    ),
                    pw.TableRow(
                      children: [
                        pw.Text(
                          'WhatsApp Number',
                          style: pw.TextStyle(
                            fontSize: 13.0,
                            color: color,
                            font: font,
                          ),
                        ),
                        pw.Text(
                          '+91 9876543210',
                          style: pw.TextStyle(
                            fontSize: 13.0,
                            color: PdfColors.grey400,
                            font: font,
                          ),
                        ),
                        pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                              pw.Text(
                                'Treatment Time',
                                style: pw.TextStyle(
                                  fontSize: 13.0,
                                  color: color,
                                  font: font,
                                ),
                              ),
                              pw.SizedBox(width: 5),
                              pw.Text(
                                '12:12pm',
                                style: pw.TextStyle(
                                  fontSize: 13.0,
                                  color: PdfColors.grey400,
                                  font: font,
                                ),
                              ),
                            ]),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 1 * PdfPageFormat.mm),
                // pw.Divider(color: PdfColors.grey400, thickness: 1),
                pw.Text(
                    "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ ",
                    style: pw.TextStyle(
                      fontSize: 13.0,
                      color: PdfColors.grey400,
                      font: font,
                    ),
                    maxLines: 1,
                    overflow: pw.TextOverflow.clip),
                pw.SizedBox(height: 1 * PdfPageFormat.mm),

                pw.SizedBox(height: 5 * PdfPageFormat.mm),

                /// PDF Table Create
                ///
                pw.Table.fromTextArray(
                  headers: tableHeaders,
                  headerCellDecoration: null,

                  data: List.generate(2,
                      // orderhistory.products.length,
                      (index) {
                    double price = double.parse(4.toString()
                            // orderhistory.products[index].quantity.toString()
                            ) *
                        double.parse(100.toString()
                            // orderhistory.products[index].price.toString()
                            );
                    return [
                      "productname",
                      // orderhistory.products[index].productname,
                      "2",
                      // orderhistory.products[index].quantity.toString(),
                      "1",
                      // orderhistory.products[index].unit
                      "1",
                      // orderhistory.products[index].size.toString(),
                      price.toString()
                    ];
                  }),
                  //  tableData,
                  border: pw.TableBorder.symmetric(),
                  // border: null,
                  headerStyle: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    font: boldfont,
                    color: PdfColor.fromInt(AppColors().buttonColor.value),
                  ),
                  // headerDecoration:
                  //     const pw.BoxDecoration(color: PdfColors.grey300),
                  cellHeight: 30.0,
                  cellAlignments: {
                    0: pw.Alignment.centerLeft,
                    1: pw.Alignment.centerRight,
                    2: pw.Alignment.centerRight,
                    3: pw.Alignment.centerRight,
                    4: pw.Alignment.centerRight,
                  },
                ),
                pw.SizedBox(height: 1 * PdfPageFormat.mm),
                // pw.Divider(color: PdfColors.grey400, thickness: 1),
                pw.Text(
                    "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ ",
                    style: pw.TextStyle(
                      fontSize: 14.0,
                      color: PdfColors.grey400,
                      font: font,
                    ),
                    maxLines: 1,
                    overflow: pw.TextOverflow.clip),
                pw.SizedBox(height: 1 * PdfPageFormat.mm),

                pw.SizedBox(height: 5 * PdfPageFormat.mm),
                pw.Container(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Row(
                    children: [
                      pw.Spacer(flex: 6),
                      pw.Expanded(
                        flex: 4,
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Row(
                              children: [
                                pw.Expanded(
                                  child: pw.Text(
                                    'Total amount',
                                    style: pw.TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: pw.FontWeight.bold,
                                      color: color,
                                      font: boldfont, // Load bold font file
                                    ),
                                  ),
                                ),
                                pw.Text(
                                  20000.toString(),
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    color: color,
                                    font: boldfont,
                                  ),
                                ),
                              ],
                            ),
                            pw.Row(
                              children: [
                                pw.Expanded(
                                  child: pw.Text(
                                    'Discount',
                                    style: pw.TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: pw.FontWeight.bold,
                                      color: color,
                                      font: font,
                                    ),
                                  ),
                                ),
                                pw.Text(
                                  20000.toString(),
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.normal,
                                    color: color,
                                    font: font,
                                  ),
                                ),
                              ],
                            ),
                            pw.Row(
                              children: [
                                pw.Expanded(
                                  child: pw.Text(
                                    'Advance',
                                    style: pw.TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: pw.FontWeight.bold,
                                      color: color,
                                      font: font,
                                    ),
                                  ),
                                ),
                                pw.Text(
                                  20000.toString(),
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.normal,
                                    color: color,
                                    font: font,
                                  ),
                                ),
                              ],
                            ),
                            // pw.SizedBox(height: 1 * PdfPageFormat.mm),
                            pw.Text(
                                "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ ",
                                style: pw.TextStyle(
                                  fontSize: 14.0,
                                  color: PdfColors.grey400,
                                  font: font,
                                ),
                                maxLines: 1,
                                overflow: pw.TextOverflow.clip),
                            pw.SizedBox(height: 1 * PdfPageFormat.mm),
                            pw.Row(
                              children: [
                                pw.Expanded(
                                  child: pw.Text(
                                    'Balance',
                                    style: pw.TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: pw.FontWeight.bold,
                                      color: color,
                                      font: boldfont, // Load bold font file
                                    ),
                                  ),
                                ),
                                pw.Text(
                                  20000.toString(),
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    color: color,
                                    font: boldfont,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 10 * PdfPageFormat.mm),
                pw.Align(
                    alignment: pw.Alignment
                        .topRight, // Align the content to the top-right
                    child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.Align(
                            alignment: pw.Alignment.centerRight,
                            child: pw.Text(
                              "Thank you for choosing us",
                              textAlign: pw.TextAlign.end,
                              style: pw.TextStyle(
                                fontSize: 18,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColor.fromInt(
                                    AppColors().buttonColor.value),
                                font: boldfont,
                              ),
                            ),
                          ),
                          pw.SizedBox(height: 3 * PdfPageFormat.mm),
                          pw.Align(
                            alignment: pw.Alignment.centerRight,
                            child: pw.Text(
                              "Your well-being is or commitment, and we're honored\nyou've entrusted us with your health journey",
                              textAlign: pw.TextAlign.end,
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 10,
                                  color: PdfColors.grey400,
                                  font: font),
                            ),
                          ),
                          pw.SizedBox(height: 5 * PdfPageFormat.mm),
                          pw.Align(
                              alignment: pw.Alignment.centerRight,
                              child: pw.Image(
                                pw.MemoryImage(signImage),
                                height: 80,
                                width: 80,
                              )),
                        ]))
              ])
            ]),
          ];
        },
        footer: (context) {
          return pw.Column(
            mainAxisSize: pw.MainAxisSize.min,
            children: [
              pw.Text(
                  "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ ",
                  style: pw.TextStyle(
                    fontSize: 14.0,
                    color: PdfColors.grey400,
                    font: font,
                  ),
                  maxLines: 1,
                  overflow: pw.TextOverflow.clip),
              pw.SizedBox(height: 3 * PdfPageFormat.mm),
              pw.Text(
                '\"Booking amount is non-refundable, and it\'s important to arrive on the allotted time for your treatment\"',
                style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 9,
                    color: PdfColors.grey400,
                    font: font),
              ),
              pw.SizedBox(height: 1 * PdfPageFormat.mm),
            ],
          );
        },
      ),
    );

    return FileHandleApi.saveDocument(
        name: 'Ayuvedic-center-bill.pdf', pdf: pdf);
  }
}
