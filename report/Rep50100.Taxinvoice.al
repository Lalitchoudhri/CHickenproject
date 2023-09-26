report 50100 "Taxinvoice"
{
    ApplicationArea = All;
    Caption = 'Sales Tax Invoice';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'taxinvoive.rdl';
    DefaultLayout = RDLC;
    // LAlit Pal
    dataset
    {
        dataitem(SalesInvoiceHeader; "Sales Invoice Header")
        {
            RequestFilterFields = "No.";
            column(salinw; salinw) { }
            column(Invoice_Disc__Code; "Invoice Disc. Code") { }
            column(InvoiceNo_; "No.") { }
            column(Vehicle_No_; "Vehicle No.") { }
            column(E_Way_Bill_No_; "E-Way Bill No.") { }
            column(Sell_to_City; "Sell-to City") { }
            column(Payment_Method_Code; "Payment Method Code") { }
            column(Salesperson_Code; "Salesperson Code") { }
            column(Posting_Date; "Posting Date") { }
            column(Transport_Method; "Transport Method") { }
            column(Bill_to_Name; "Bill-to Name") { }
            column(Bill_to_Address; "Bill-to Address") { }
            column(Bill_to_Address_2; "Bill-to Address 2") { }
            column(Bill_to_City; "Bill-to City") { }
            column(Bill_to_County; "Bill-to County") { }
            column(Bill_to_Post_Code; "Bill-to Post Code") { }
            column(Bill_to_Contact_No_; "Bill-to Contact No.") { }
            column(Sell_to_E_Mail; "Sell-to E-Mail") { }
            column(Ship_to_Name; "Ship-to Name") { }
            column(Ship_to_Address; "Ship-to Address") { }
            column(Ship_to_Address_2; "Ship-to Address 2") { }
            column(Ship_to_City; "Ship-to City") { }
            column(Ship_to_County; "Ship-to County") { }
            column(Ship_to_Post_Code; "Ship-to Post Code") { }
            column(Ship_to_Contact; "Ship-to Contact") { }
            column(name; comp.Name) { }
            column(adress; comp.Address) { }
            column(Address_2; comp."Address 2") { }
            column(GST; comp."GST Registration No.") { }
            column(ARN; comp."ARN No.") { }
            column(Phone_No_; comp."Phone No.") { }
            column(Picture; comp.Picture) { }
            column(E_Mail; comp."E-Mail") { }
            column(City; comp.City) { }
            column(Post_Code; comp."Post Code") { }
            column(AmountInWords; AmountInWords) { }
            column(Bankname; comp."Bank Name") { }
            column(ACC; comp."Bank Account No.") { }
            column(compBNo; comp."Bank Branch No.") { }
            column(compARN; comp."ARN No.") { }
            column(CurrencyCode; CurrencyCode) { }
            column(desc; desc) { }
            column(code1; code1) { }
            column(salp; salp) { }
            column(amout; amout) { }
            column(AMt1; AMt1) { }
            column(AmountInWords1; AmountInWords1) { }
            column(CheckAmount; CheckAmount) { }
            column(VoidText; VoidText) { }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemLinkReference = SalesInvoiceHeader;
                DataItemTableView = sorting("Document No.", "Line No.");
                column(No_; "No.") { }
                column(Description; Description) { }
                column(VAT__; "VAT %") { }
                column(Quantity; Quantity) { }
                column(Unit_Price; "Unit Price") { }
                column(Line_Amount; "Line Amount") { }
                column(Line_Discount__; "Line Discount %") { }
                column(HSN_SAC_Code; "HSN/SAC Code") { }
                column(sr_No; sr_No) { }
                column(Amount; Amount) { }
                column(NETamount; NETamount) { }
                trigger OnAfterGetRecord()
                begin
                    transport.SetRange(Code, SalesInvoiceHeader."Transport Method");
                    if transport.FindSet() then
                        desc := transport.Description;
                    payment.SetRange(Code, SalesInvoiceHeader."Payment Method Code");
                    if payment.FindSet() then
                        code1 := payment.Code;
                    saleper.SetRange(Code, SalesInvoiceHeader."Salesperson Code");
                    if saleper.FindSet() then
                        salp := saleper.Name;
                    Amount := Quantity * "Unit Price";
                    NETamount := Amount - "Line Amount";
                    "Sales Invoice Line".Reset();
                    if transport.Code = '458521' then
                        salinw := 00 + salesinvodeline."VAT %";
                    AMt1 := (Amount * "VAT %") / 100;
                    amout := (Amount) - (AMt1);
                    AmountToCustomer += Amount;

                    AmountVendor := ROUND("Sales Invoice Line".Amount, 0.01);
                    cu.InitTextVariable();
                    cu.FormatNoText(Notext1, AmountToCustomer, CurrencyCode);
                    AmountInWords := Notext1[1];

                    // sr_No += 1;
                    // repocheck.InitTextVariable;
                    // repocheck.FormatNoText(NoText, AmountVendor, SalesInvoiceHeader."Currency Code");
                    // AmountInWords1 := Notext[1];
                    // CheckAmount := "Sales Invoice Line".Amount;
                    // myDecimal := "Sales Invoice Line".Amount - Round("Sales Invoice Line".Amount, 1, '<');
                    // if StrLen(Format(myDecimal)) < StrLen(Format(currency."Amount Rounding Precision")) then
                    //     if myDecimal = 0 then
                    //         CheckAmountText := Format(CheckAmount, 0, 0) + CopyStr(Format(0.01), 2, 1) +
                    //         PadStr('', StrLen(Format(currency."Amount Rounding Precision")) - 2, '0')
                    //     else
                    //         CheckAmountText := Format(CheckAmount, 0, 0) +
                    //           PadStr('', StrLen(Format(Currency."Amount Rounding Precision")) - StrLen(Format(myDecimal)), '0')
                    // else
                    //     CheckAmountText := Format(CheckAmount, 0, 0);
                    // cu.FormatNoText(Notext, "Sales Invoice Line".Amount, bank."Currency Code");
                    // VoidText := Notext[1];
                end;

                trigger OnPreDataItem()
                begin// dataitem("GST Ledger Entry"; "GST Ledger Entry")
                     // {
                     //     DataItemLinkReference = "Sales Invoice Line";
                     //     column(GST_Amount; "GST Amount") { }
                     // }
                    sr_No := 0;
                end;
            }
            trigger OnPreDataItem()
            begin
                comp.Get();
                comp.CalcFields(Picture);
            end;
        }
    }
    var
        payment: Record "Payment Method";
        code1: Code[10];
        comp: Record "Company Information";
        Amount: Integer;
        NETamount: Decimal;
        sr_No: Integer;
        Recheck: Report Check;
        AmountToCustomer: Decimal;
        AmountInWords: Text[250];
        Notext: array[2] of Text[250];
        Notext1: array[2] of Text[250];
        Cu: Codeunit AmountToWords;
        repocheck: Report Check;
        abc: Report 50100;
        CurrencyCode: Code[10];
        transport: Record "Transport Method";
        desc: Text[100];
        saleper: Record "Salesperson/Purchaser";
        salp: Text[100];
        AMt1: Decimal;
        amout: Decimal;
        salesinvodeline: Record "Sales Invoice Line";
        salinw: Decimal;
        AmountInWords1: Text[250];
        CheckAmount: Decimal;
        myDecimal: Decimal;
        currency: Record Currency;
        CheckAmountText: Text[30];
        VoidText: Text[100];
        bank: Record "Bank Account";
        DescriptionLine: array[2] of Text[80];
        AmountVendor: Decimal;
    // "GST Ledger Entry": Record "GST Ledger Entry";
    // "Tax Component Summary": tr"Tax Component Summary";
    //LAlIt Pal
}