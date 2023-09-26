report 50101 "thingQ report"
{
    Caption = 'thingQ report';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'thingQ report.rdl';
    DefaultLayout = RDLC;
    dataset
    {
        dataitem("Transfer Shipment Header"; "Transfer Shipment Header")
        {
            RequestFilterFields = "No.", "Posting Date", "Transfer-from Code", "Transfer-to Code";
            column(No_; "No.") { }
            //company
            column(Name; companyinfo.Name) { }
            column(address; companyinfo.Address) { }
            column(address1; companyinfo."Address 2") { }
            column(city; companyinfo.City) { }
            column("PostCode"; companyinfo."Post Code") { }
            column(coutnry; companyinfo."Country/Region Code") { }
            column("companyEMail"; companyinfo."E-Mail") { }
            column(PhoneNo; companyinfo."Phone No.") { }
            column(GSTno; companyinfo."GST Registration No.") { }
            column(PanCard; companyinfo."P.A.N. No.") { }

            //company
            column(srNo; srNo) { }
            column(LR_RR_No_; "LR/RR No.") { }
            column(LR_RR_Date; "LR/RR Date") { }
            column(Posting_Date; "Posting Date") { }

            column(Nameofconsigee; Nameofconsigee) { }
            column(consingee_city; consingee_city) { }
            column(consingee_PhoneNo; consingee_PhoneNo) { }
            column(consingee_state; consingee_state) { }
            column(Consingee_Address; Consingee_Address) { }
            column(consingee_GSTNo; consingee_GSTNo) { }
            column(consingee_Email; consingee_Email) { }
            column(consingee_PanNo; consingee_PanNo) { }


            dataitem("Transfer Shipment Line"; "Transfer Shipment Line")
            {
                DataItemLinkReference = "Transfer Shipment Header";
                DataItemLink = "Document No." = field("No.");
                column(Description; Description) { }
                column(HSN_SAC_Code; "HSN/SAC Code") { }
                column(Quantity; Quantity)
                { }
                column(Unit_Price; "Unit Price") { }
                column(vCGSTRate3; vCGSTRate3) { }
                column(vSGSTRate3; vSGSTRate3) { }
                column(vIGSTRate3; vIGSTRate3) { }
                column(Amount; Amount) { }
                column(AmountInWords; AmountInWords) { }
                column(Notext1; Notext1[1]) { }
                trigger OnAfterGetRecord()
                begin
                    srNo += 1;

                    CLEAR(vCGST3);
                    CLEAR(vSGST3);
                    CLEAR(vIGST3);
                    CLEAR(vCGSTRate3);
                    vSGSTRate3 := 0;
                    vIGSTRate3 := 0;
                    vCGSTRate3 := 0;
                    CLEAR(vSGSTRate3);
                    CLEAR(vIGSTRate3);
                    DetailGSTEntry.RESET;
                    DetailGSTEntry.SETCURRENTKEY("Document No.", "Document Line No.", "GST Component Code", "HSN/SAC Code");
                    DetailGSTEntry.SETRANGE("Document Line No.", "Transfer Shipment Line"."Line No.");
                    DetailGSTEntry.SETRANGE("HSN/SAC Code", "Transfer Shipment Line"."HSN/SAC Code");
                    // DetailGSTEntry.SETRANGE("No.", "No.");
                    IF DetailGSTEntry.FINDSET THEN
                        REPEAT
                            IF DetailGSTEntry."GST Component Code" = 'CGST' THEN BEGIN
                                vCGST3 += ABS(DetailGSTEntry."GST Amount");
                                vCGSTRate3 := DetailGSTEntry."GST %";
                            END;
                            IF DetailGSTEntry."GST Component Code" = 'SGST' THEN BEGIN
                                vSGST3 += ABS(DetailGSTEntry."GST Amount");
                                vSGSTRate3 := DetailGSTEntry."GST %";
                            END;
                            IF DetailGSTEntry."GST Component Code" = 'IGST' THEN BEGIN
                                vIGST3 += ABS(DetailGSTEntry."GST Amount");
                                vIGSTRate3 := DetailGSTEntry."GST %";
                            END;
                        UNTIL DetailGSTEntry.NEXT = 0;

                    Amount += Quantity * "Unit Price" * vCGSTRate3 / 100 + Quantity * "Unit Price" * vSGSTRate3 / 100 + Quantity * "Unit Price" * vIGSTRate3;
                    AmountToCustomer += Amount;
                    cu.InitTextVariable();
                    cu.FormatNoText(Notext1, AmountToCustomer, '');
                    AmountInWords := Notext1[1];

                end;

            }
            trigger OnAfterGetRecord()
            begin

                Location.SetRange(code, "Transfer-to Code");
                if Location.FindFirst() then begin
                    Nameofconsigee := Location.Name;
                    Consingee_Address := Location.Address;
                    consingee_city := Location.City;
                    consingee_PhoneNo := Location."Phone No.";
                    consingee_state := Location."Country/Region Code";
                    consingee_Email := Location."E-Mail";
                    consingee_GSTNo := Location."GST Registration No.";
                    consingee_PanNo := Location."T.A.N. No.";
                end;
            end;

            trigger OnPreDataItem()
            begin
                companyinfo.Get();
                CurrReport.Skip();
                srNo := 0;
            end;

        }

    }

    var
        companyinfo: Record "Company Information";
        srNo: Integer;


        DetailGSTEntry: Record "Detailed GST Ledger Entry";

        Notext: array[2] of Text[150];
        RepCheck: Report 1401;
        recITEM: Record 27;
        AmtToCust: Decimal;
        GSTAMt: Decimal;
        SGSTnew: Decimal;
        CGSTnew: Decimal;
        IGSTnew: Decimal;
        GSTLedCnt: Integer;
        vCGST3: Decimal;
        vSGST3: Decimal;
        vIGST3: Decimal;
        vCGSTRate3: Decimal;
        vSGSTRate3: Decimal;
        vIGSTRate3: Decimal;
        DetGSTLdgEntry2: Record "Detailed GST Ledger Entry";
        TotalBaseAmt: Decimal;
        DetGSTLdgEntry1: Record "Detailed GST Ledger Entry";
        AmountToCustomer: Decimal;
        AmountInWords: Text[250];
        Notext1: array[2] of Text[250];
        Cu: Report Check;
        Location: Record Location;
        Nameofconsigee: text[20];
        Consingee_Address: Text[50];
        consingee_city: Text[20];
        consingee_state: text[20];
        consingee_PhoneNo: text[30];
        consingee_GSTNo: Code[20];
        consingee_Email: text[50];
        consingee_PanNo: Code[30];

}
