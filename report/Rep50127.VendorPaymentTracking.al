// report 50127 "Vendor - Payment Tracking"
// {
//     Caption = 'Vendor - Payment Tracking';
//     ProcessingOnly = true;

//     dataset
//     {
//         dataitem(DataItem4114; "Vendor Ledger Entry")
//         {
//             DataItemTableView = SORTING("Document Type", "Vendor No.", "Posting Date", "Currency Code")
//                                 WHERE("Document Type" = CONST(Invoice));
//             RequestFilterFields = "Posting Date", "Global Dimension 1 Code", "Vendor No.", "Vendor Posting Group", Open;
//             column(Filter1; Filter[1])
//             {
//             }
//             column(Filter2; Filter[2])
//             {
//             }
//             column(Filter3; Filter[3])
//             {
//             }
//             column(Filter4; Filter[4])
//             {
//             }
//             column(Filter5; Filter[5])
//             {
//             }
//             dataitem(DetailedVendorLedgEntry1; "Detailed Vendor Ledg. Entry")
//             {
//                 DataItemLink = "Applied Vend. Ledger Entry No." = FIELD("Entry No.");
//                 DataItemLinkReference = "VendorLedgerEntry";
//                 DataItemTableView = SORTING("Applied Vend. Ledger Entry No.", "Entry Type")
//                                     WHERE(Unapplied = CONST(No));
//                 dataitem(VendLedgEntry1; "Vendor Ledger Entry")
//                 {
//                     DataItemLink = "Entry No." = FIELD("Vendor Ledger Entry No.");
//                     DataItemLinkReference = DetailedVendorLedgEntry1;
//                     DataItemTableView = SORTING("Entry No.");

//                     trigger OnAfterGetRecord()
//                     begin
//                         IF "Entry No." = "Vendor Ledger Entry"."Entry No." THEN
//                             CurrReport.SKIP;

//                         NegPmtDiscInvCurrVendLedgEntry1 := 0;
//                         NegPmtTolInvCurrVendLedgEntry1 := 0;
//                         PmtDiscPmtCurr := 0;
//                         PmtTolPmtCurr := 0;

//                         NegShowAmountVendLedgEntry1 := -DetailedVendorLedgEntry1.Amount;

//                         IF "Vendor Ledger Entry"."Currency Code" <> "Currency Code" THEN BEGIN
//                             NegPmtDiscInvCurrVendLedgEntry1 := ROUND("Pmt. Disc. Rcd.(LCY)" * "Original Currency Factor");
//                             NegPmtTolInvCurrVendLedgEntry1 := ROUND("Pmt. Tolerance (LCY)" * "Original Currency Factor");
//                             AppliedAmount :=
//                               ROUND(
//                                 -DetailedVendorLedgEntry1.Amount / "Original Currency Factor" * "Original Currency Factor",
//                                 Currency."Amount Rounding Precision");
//                         END ELSE BEGIN
//                             NegPmtDiscInvCurrVendLedgEntry1 := ROUND("Pmt. Disc. Rcd.(LCY)" * "Vendor Ledger Entry"."Original Currency Factor");
//                             NegPmtTolInvCurrVendLedgEntry1 := ROUND("Pmt. Tolerance (LCY)" * "Vendor Ledger Entry"."Original Currency Factor");
//                             AppliedAmount := -DetailedVendorLedgEntry1.Amount;
//                         END;

//                         PmtDiscPmtCurr := ROUND("Pmt. Disc. Rcd.(LCY)" * "Vendor Ledger Entry"."Original Currency Factor");

//                         PmtTolPmtCurr := ROUND("Pmt. Tolerance (LCY)" * "Vendor Ledger Entry"."Original Currency Factor");

//                         RemainingAmount := (RemainingAmount - AppliedAmount) + PmtDiscPmtCurr + PmtTolPmtCurr;

//                         //YSr
//                         //Excel Start
//                         //Payemnt
//                         IF (DetailedVendorLedgEntry2."Document No." <> '') AND (AppliedAmount <> 0) THEN BEGIN
//                             intEntryNo += 1;
//                             IF IntTotalAppEntry < intEntryNo THEN
//                                 IntTotalAppEntry := intEntryNo;
//                             ExcelBuffer.AddColumn("Document Type", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
//                             ExcelBuffer.AddColumn("Document No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
//                             ExcelBuffer.AddColumn("Posting Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
//                             ExcelBuffer.AddColumn(AppliedAmount, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
//                         END;
//                         //Excel End
//                     end;

//                     trigger OnPreDataItem()
//                     begin
//                         /*//NB Start
//                         Sdate:="Vendor Ledger Entry".GETRANGEMIN("Posting Date");
//                         Edate:="Vendor Ledger Entry".GETRANGEMAX("Posting Date");
//                         DetailedVendorLedgEntry1.SETRANGE("Posting Date",Sdate,Edate);
//                         //NB End
//                          */

//                     end;
//                 }

//                 trigger OnPreDataItem()
//                 begin
//                     //Filter[1] := GETFILTER("Posting Date");
//                     //Filter[3] := GETFILTER("Vendor No.");
//                 end;
//             }
//             dataitem(DetailedVendorLedgEntry2; "Detailed Vendor Ledg. Entry")
//             {
//                 DataItemLink = "Vendor Ledger Entry No." = FIELD("Entry No.");
//                 DataItemLinkReference = "VendorLedgerEntry";
//                 DataItemTableView = SORTING("Vendor Ledger Entry No.", "Entry Type", "Posting Date")
//                                     WHERE(Unapplied = CONST(No));
//                 dataitem(VendLedgEntry2; "Vendor Ledger Entry")
//                 {
//                     DataItemLink = "Entry No." = FIELD("Applied Vend. Ledger Entry No.");
//                     DataItemLinkReference = DetailedVendorLedgEntry2;
//                     DataItemTableView = SORTING("Entry No.");

//                     trigger OnAfterGetRecord()
//                     begin
//                         IF "Entry No." = "Vendor Ledger Entry"."Entry No." THEN
//                             CurrReport.SKIP;

//                         NegPmtDiscInvCurrVendLedgEntry1 := 0;
//                         NegPmtTolInvCurrVendLedgEntry1 := 0;
//                         PmtDiscPmtCurr := 0;
//                         PmtTolPmtCurr := 0;

//                         NegShowAmountVendLedgEntry1 := DetailedVendorLedgEntry2.Amount;

//                         IF "Vendor Ledger Entry"."Currency Code" <> "Currency Code" THEN BEGIN
//                             NegPmtDiscInvCurrVendLedgEntry1 := ROUND("Pmt. Disc. Rcd.(LCY)" * "Original Currency Factor");
//                             NegPmtTolInvCurrVendLedgEntry1 := ROUND("Pmt. Tolerance (LCY)" * "Original Currency Factor");
//                         END ELSE BEGIN
//                             NegPmtDiscInvCurrVendLedgEntry1 := ROUND("Pmt. Disc. Rcd.(LCY)" * "Vendor Ledger Entry"."Original Currency Factor");
//                             NegPmtTolInvCurrVendLedgEntry1 := ROUND("Pmt. Tolerance (LCY)" * "Vendor Ledger Entry"."Original Currency Factor");
//                         END;

//                         PmtDiscPmtCurr := ROUND("Pmt. Disc. Rcd.(LCY)" * "Vendor Ledger Entry"."Original Currency Factor");

//                         PmtTolPmtCurr := ROUND("Pmt. Tolerance (LCY)" * "Vendor Ledger Entry"."Original Currency Factor");

//                         AppliedAmount := DetailedVendorLedgEntry2.Amount;
//                         RemainingAmount := (RemainingAmount - AppliedAmount) + PmtDiscPmtCurr + PmtTolPmtCurr;

//                         //YSr
//                         //Excel Start
//                         //Paymenr
//                         IF (DetailedVendorLedgEntry2."Document No." <> '') AND (AppliedAmount <> 0) THEN BEGIN
//                             intEntryNo += 1;
//                             IF IntTotalAppEntry < intEntryNo THEN
//                                 IntTotalAppEntry := intEntryNo;

//                             ExcelBuffer.AddColumn("Document Type", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
//                             ExcelBuffer.AddColumn("Document No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
//                             ExcelBuffer.AddColumn("Posting Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
//                             ExcelBuffer.AddColumn(AppliedAmount, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
//                         END;
//                         //Excel End
//                     end;

//                     trigger OnPreDataItem()
//                     begin
//                         /*//NB Start
//                         Sdate:="Vendor Ledger Entry".GETRANGEMIN("Posting Date");
//                         Edate:="Vendor Ledger Entry".GETRANGEMAX("Posting Date");
//                         DetailedVendorLedgEntry2.SETRANGE("Posting Date",Sdate,Edate);
//                         //NB End
//                          */

//                     end;
//                 }

//                 trigger OnPreDataItem()
//                 begin
//                     //Filter[1] := GETFILTER("Posting Date");
//                     //Filter[3] := GETFILTER("Vendor No.");
//                 end;
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 CLEAR(DimValueCode);
//                 intEntryNo := 0;

//                 Vend.GET("Vendor No.");
//                 FormatAddr.Vendor(VendAddr, Vend);
//                 IF NOT Currency.GET("Currency Code") THEN
//                     Currency.InitRoundingPrecision;

//                 IF "Document Type" = "Document Type"::Payment THEN BEGIN
//                     ReportTitle := Text004;
//                     PaymentDiscountTitle := Text007;
//                 END ELSE BEGIN
//                     ReportTitle := Text003;
//                     PaymentDiscountTitle := Text006;
//                 END;

//                 CALCFIELDS("Original Amount");
//                 RemainingAmount := -"Original Amount";

//                 //RSPL-AR


//                 PurchInvHeader.RESET;
//                 PurchInvHeader.SETRANGE(PurchInvHeader."No.", "Document No.");
//                 IF PurchInvHeader.FINDFIRST THEN
//                     PaymentTerms.RESET;
//                 PaymentTerms.SETRANGE(PaymentTerms.Code, PurchInvHeader."Payment Terms Code");
//                 IF PaymentTerms.FINDFIRST THEN
//                     PaymentDesc := PaymentTerms.Description;

//                 DimSetEntry.RESET;
//                 DimSetEntry.SETRANGE(DimSetEntry."Dimension Set ID", "Dimension Set ID");
//                 DimSetEntry.SETRANGE(DimSetEntry."Dimension Code", 'EXCISETYPE');
//                 DimSetEntry.SETAUTOCALCFIELDS("Dimension Value Name");
//                 IF DimSetEntry.FINDFIRST THEN
//                     DimValueCode := DimSetEntry."Dimension Value Name";

//                 //NB Start
//                 /*CLEAR(RemainingAmount1);
//                 Sdate:="Vendor Ledger Entry".GETRANGEMIN("Posting Date");
//                 Edate:="Vendor Ledger Entry".GETRANGEMAX("Posting Date");
//                 DetailedVendLedEntry.SETRANGE(DetailedVendLedEntry."Vendor Ledger Entry No.","Vendor Ledger Entry"."Entry No.");
//                 DetailedVendLedEntry.SETFILTER("Posting Date",'%1..%2',Sdate,Edate);
//                 //DetailedVendLedEntry.SETRANGE("Document Type",DetailedVendLedEntry."Document Type"::Payment);
//                   IF DetailedVendLedEntry.FINDFIRST THEN
//                     REPEAT
//                       RemainingAmount1+=DetailedVendLedEntry.Amount;
//                     UNTIL DetailedVendLedEntry.NEXT=0;
//                  */
//                 //NB End

//                 //PCPL 38
//                 CLEAR(vGSTEx);
//                 recDGST.RESET;
//                 recDGST.SETRANGE(recDGST."Document No.", VendorLedgerEntry."Document No.");
//                 IF recDGST.FINDFIRST THEN;
//                 //PCPL 38



//                 //YSR
//                 //Excel BEGIN
//                 //Invoice
//                 ExcelBuffer.NewRow;
//                 ExcelBuffer.AddColumn(VendorLedgerEntry."Posting Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
//                 ExcelBuffer.AddColumn(VendorLedgerEntry."Document Type", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
//                 ExcelBuffer.AddColumn(VendorLedgerEntry."Document No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
//                 ExcelBuffer.AddColumn(VendorLedgerEntry."Vendor No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
//                 ExcelBuffer.AddColumn(Vend.Name, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);//NB
//                 ExcelBuffer.AddColumn(VendorLedgerEntry."Vendor Posting Group", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
//                 ExcelBuffer.AddColumn(Vend."GST Registration No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
//                 ExcelBuffer.AddColumn(Vend."GST Vendor Type", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
//                 //ExcelBuffer.AddColumn(DimValueCode,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);    //PCPL 38
//                 ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);    //PCPL 38
//                 ExcelBuffer.AddColumn(VendorLedgerEntry."GST Reverse Charge", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
//                 ExcelBuffer.AddColumn(recDGST."GST Exempted Goods", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);     //PCPL 38
//                 ExcelBuffer.AddColumn(VendorLedgerEntry."Global Dimension 1 Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
//                 ExcelBuffer.AddColumn(VendorLedgerEntry."External Document No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
//                 ExcelBuffer.AddColumn(VendorLedgerEntry."Document Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
//                 ExcelBuffer.AddColumn(VendorLedgerEntry."Original Amount", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
//                 ExcelBuffer.AddColumn(PaymentDesc, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
//                 ExcelBuffer.AddColumn(VendorLedgerEntry."Due Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
//                 //ExcelBuffer.AddColumn(RemainingAmount1,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Number);//nb
//                 CALCFIELDS("Remaining Amount");//NB
//                 ExcelBuffer.AddColumn(VendorLedgerEntry."Remaining Amount", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);//nb
//                 //Excel END

//             end;

//             trigger OnPreDataItem()
//             var
//                 i: Integer;
//             begin
//                 CompanyInfo.GET;
//                 FormatAddr.Company(CompanyAddr, CompanyInfo);
//                 GLSetup.GET;

//                 Filter[1] := GETFILTER("Posting Date");
//                 Filter[2] := GETFILTER("Global Dimension 1 Code");
//                 Filter[3] := GETFILTER("Vendor No.");
//                 Filter[4] := GETFILTER("Vendor Posting Group");
//                 Filter[5] := GETFILTER(Open);

//                 //Excel
//                 ExcelBuffer.DELETEALL(TRUE);
//                 IntTotalAppEntry := 0;

//                 //Filters
//                 ExcelBuffer.NewRow;
//                 ExcelBuffer.AddColumn('Posting Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
//                 ExcelBuffer.AddColumn(Filter[1], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

//                 ExcelBuffer.NewRow;
//                 ExcelBuffer.AddColumn('Unit', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
//                 ExcelBuffer.AddColumn(Filter[2], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

//                 ExcelBuffer.NewRow;
//                 ExcelBuffer.AddColumn('Vendor No.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
//                 ExcelBuffer.AddColumn(Filter[3], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

//                 ExcelBuffer.NewRow;
//                 ExcelBuffer.AddColumn('Vendor Posting Group', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
//                 ExcelBuffer.AddColumn(Filter[4], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

//                 ExcelBuffer.NewRow;
//                 ExcelBuffer.AddColumn('Open', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
//                 ExcelBuffer.AddColumn(Filter[5], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
//                 ExcelBuffer.NewRow;


//                 ExcelBuffer.NewRow;
//                 ExcelBuffer.AddColumn('Posting Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
//                 ExcelBuffer.AddColumn('Document Type', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
//                 ExcelBuffer.AddColumn('Document No.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
//                 ExcelBuffer.AddColumn('Vendor No.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
//                 ExcelBuffer.AddColumn('Vendor Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);   //NB
//                 ExcelBuffer.AddColumn('Vendor Posting Group', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
//                 ExcelBuffer.AddColumn('GST No.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
//                 ExcelBuffer.AddColumn('GST Vendor Type', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
//                 //ExcelBuffer.AddColumn('Excise Type',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);      //PCPL 38
//                 ExcelBuffer.AddColumn('MSME Type', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);        //PCPL 38
//                 ExcelBuffer.AddColumn('Reverse Charge', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
//                 ExcelBuffer.AddColumn('GST Exempted', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);     //PCPL 38
//                 ExcelBuffer.AddColumn('Unit', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
//                 ExcelBuffer.AddColumn('External Document No.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
//                 ExcelBuffer.AddColumn('Document Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
//                 ExcelBuffer.AddColumn('Amount to Vendor (INR)', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
//                 ExcelBuffer.AddColumn('Payment Terms Description', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
//                 ExcelBuffer.AddColumn('Due Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
//                 ExcelBuffer.AddColumn('Remaining Amount', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);//NB
//                 //Excel
//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//         CurrencyCodeCaption = 'Currency Code';
//         PageCaption = 'Page';
//         DocDateCaption = 'Document Date';
//         EmailCaption = 'E-Mail';
//         HomePageCaption = 'Home Page';
//     }

//     trigger OnPostReport()
//     var
//         i: Integer;
//         intCurrentCol: Integer;
//     begin
//         //Excel
//         intCurrentCol := 19;

//         FOR i := 1 TO IntTotalAppEntry DO BEGIN

//             ExcelBuffer.AddColumnV2('Application Document Type  ' + FORMAT(i), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, 7, intCurrentCol);
//             intCurrentCol += 1;
//             ExcelBuffer.AddColumnV2('Application Document No.  ' + FORMAT(i), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, 7, intCurrentCol);
//             intCurrentCol += 1;
//             ExcelBuffer.AddColumnV2('Application Posting Date  ' + FORMAT(i), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, 7, intCurrentCol);
//             intCurrentCol += 1;
//             ExcelBuffer.AddColumnV2('Applied Amount (INR)  ' + FORMAT(i), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text, 7, intCurrentCol);
//             intCurrentCol += 1;
//         END;
//         CreateExcelbook;
//         //Excel
//     end;

//     var
//         CompanyInfo: Record "Company Information";
//         GLSetup: Record "General Ledger Setup";
//         Vend: Record Vendor;
//         Currency: Record Currency;
//         FormatAddr: Codeunit "Format Address";
//         ReportTitle: Text[30];
//         PaymentDiscountTitle: Text[30];
//         CompanyAddr: array[8] of Text[50];
//         VendAddr: array[8] of Text[50];
//         RemainingAmount: Decimal;
//         AppliedAmount: Decimal;
//         NegPmtDiscInvCurrVendLedgEntry1: Decimal;
//         NegPmtTolInvCurrVendLedgEntry1: Decimal;
//         PmtDiscPmtCurr: Decimal;
//         Text003: Label 'Payment Receipt';
//         Text004: Label 'Payment Voucher';
//         Text006: Label 'Payment Discount Given';
//         Text007: Label 'Payment Discount Received';
//         PmtTolPmtCurr: Decimal;
//         NegShowAmountVendLedgEntry1: Decimal;
//         CompanyInfoPhoneNoCaptionLbl: Label 'Phone No.';
//         CompanyInfoGiroNoCaptionLbl: Label 'Giro No.';
//         CompanyInfoBankNameCaptionLbl: Label 'Bank';
//         CompanyInfoBankAccNoCaptionLbl: Label 'Account No.';
//         RcptNoCaptionLbl: Label 'Receipt No.';
//         CompanyInfoVATRegNoCaptionLbl: Label 'GST Registration No.';
//         PostingDateCaptionLbl: Label 'Posting Date';
//         AmtCaptionLbl: Label 'Amount';
//         PymtAmtSpecCaptionLbl: Label 'Payment Amount Specification';
//         PymtTolInvCurrCaptionLbl: Label 'Payment Total';
//         PymtAmtNotAllocatedCaptionLbl: Label 'Payment Amount Not Allocated';
//         PymtAmtCaptionLbl: Label 'Payment Amount';
//         ExternalDocNoCaptionLbl: Label 'External Document No.';
//         PurchInvHeader: Record "Purch. Inv. Header";
//         PaymentTerms: Record "Payment Terms";
//         PaymentDesc: Text[50];
//         DimSetEntry: Record "Dimension Set Entry";
//         DimValueCode: Code[20];
//         "Filter": array[10] of Text[250];
//         intEntryNo: Integer;
//         recTempVLE: Record "Vendor Ledger Entry" temporary;
//         y: Integer;
//         ExcelBuffer: Record "Excel Buffer" temporary;
//         IntTotalAppEntry: Integer;
//         sT: Integer;
//         Sdate: Date;
//         Edate: Date;
//         VendorLedgerEntry: Record "Vendor Ledger Entry";
//         DetailedVendLedEntry: Record "Detailed Vendor Ledg. Entry";
//         RemainingAmount1: Integer;
//         recDGST: Record "16419";
//         vGSTEx: Text;

//     local procedure CurrencyCode(SrcCurrCode: Code[10]): Code[10]
//     begin
//         IF SrcCurrCode = '' THEN
//             EXIT(GLSetup."LCY Code");

//         EXIT(SrcCurrCode);
//     end;

//     [Scope('Internal')]
//     procedure CreateExcelbook()
//     var
//         Text002: Label 'Data.xlsx';
//     begin
//         ExcelBuffer.CreateBook('', 'Payment1');
//         ExcelBuffer.CreateBookAndOpenExcel('', 'Payment1', Text003, COMPANYNAME, USERID);
//         ExcelBuffer.GiveUserControl;
//         ERROR('');
//     end;
// }

