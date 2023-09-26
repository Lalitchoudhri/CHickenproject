report 50102 ShipmentReport
{
    Caption = 'ShipmentReport';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'ShipmentReport.rdl';
    DefaultLayout = RDLC;
    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            column(Sell_to_Customer_No_; "Sell-to Customer No.") { }
            column(Document_Date; "Document Date") { }
            column(ShipmentNo; "No.")
            { }
            column(Shipment_Date; "Shipment Date") { }
            column(Order_No_; "Order No.") { }
            column(Sell_to_Phone_No_; "Sell-to Phone No.") { }
            //companyinfo
            column(picture; companyinfo.Picture) { }
            column(Name; companyinfo.Name) { }
            column(address; companyinfo.Address) { }
            column(address1; companyinfo."Address 2") { }
            column(city; companyinfo.City) { }
            column("PostCode"; companyinfo."Post Code") { }
            column(coutnry; companyinfo."Country/Region Code") { }
            column("companyEMail"; companyinfo."E-Mail") { }
            column(PhoneNo; companyinfo."Phone No.") { }
            column(Homepage; companyinfo."Home Page") { }
            column(VAT_Registration_No_; "VAT Registration No.") { }
            column(BAnk; companyinfo."Bank Name") { }
            column(Account; companyinfo."Bank Account No.") { }
            column(barcode; barcode) { }



            //companyinfo
            dataitem("Sales Shipment Line"; "Sales Shipment Line")
            {
                DataItemLinkReference = "Sales Shipment Header";
                DataItemLink = "Document No." = field("No.");
                column(Line_No_; "Line No.") { }
                column(Description; Description) { }
                column(Quantity; Quantity) { }
                column(Unit_of_Measure; "Unit of Measure") { }
            }
            trigger OnAfterGetRecord()
            var

            begin
                barcode := "No.";
                Barcodeprovepro := Enum::"Barcode Font Provider"::IDAutomation1D;
                barcodesybol := enum::"Barcode Symbology"::Code39;
                Barcodeprovepro.ValidateInput(barcode, barcodesybol);
                barcode := Barcodeprovepro.EncodeFont(barcode, barcodesybol);
            end;

            trigger OnPreDataItem()
            begin
                companyinfo.Get();
                companyinfo.CalcFields(Picture);
                CurrReport.Skip();
            end;

        }

    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        companyinfo: Record "Company Information";
        barcode: Code[20];
        barcodesybol: Enum "Barcode Symbology";
        Barcodeprovepro: Interface "Barcode Font Provider";

}
