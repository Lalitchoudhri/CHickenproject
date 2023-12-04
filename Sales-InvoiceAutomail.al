report 50113 "Sales-InvoiceReport"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Sales-invoiceReport.rdl';



    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            RequestFilterFields = "No.";
            column(Compname; Compinfo.Name)
            {
            }
            column(Compaddress; Compinfo.Address)
            {
            }
            column(CompPostCode; Compinfo."Post Code")
            {
            }
            column(CompCity; Compinfo.City)
            {
            }
            column(CompinfoStateCode; Compinfo."State Code")
            {
            }

            //CutomerInformation
            column(No_; "No.") { }
            column(Bill_to_Contact; "Bill-to Contact") { }  //Contavt Person Name
            column(Bill_to_Address; "Bill-to Address") { }
            column(Bill_to_Name; "Bill-to Name") { }
            column(Bill_to_Customer_No_; "Bill-to Customer No.") { }
            column(Bill_to_City; "Bill-to City") { }
            column(Bill_to_Country_Region_Code; "Bill-to Country/Region Code") { }
            column(Bill_to_Post_Code; "Bill-to Post Code") { }
            column(Bill_Of_Export_Date; "Bill Of Export Date") { }
            column(Your_Reference; "Your Reference") { }
            column(Salesperson_Code; "Salesperson Code") { }
            column(SalesPersonName; SalesPersonName) { }
            column(Terms; Terms) { }
            column(Due_Date; "Due Date") { }
            column(Order_Date; "Order Date") { }
            column(Shipment_Method_Code; "Shipment Method Code") { }
            column(Payment_Method_Code; "Payment Method Code") { }
            column(ShipmentMethodDesc; ShipmentMethodDesc) { }
            column(Shipping_Agent_Code; "Shipping Agent Code") { }
            column(Package_Tracking_No_; "Package Tracking No.") { }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                //SalesPersonName
                SalesPerson.Reset();
                SalesPerson.SetRange(Code, "Sales Header"."Salesperson Code");
                if SalesPerson.FindFirst() then begin
                    SalesPersonName := SalesPerson.Name;
                end;
                //Payment terms
                Paymentterms.reset();
                Paymentterms.SetRange(Code, "Sales Header"."Payment Terms Code");
                if Paymentterms.FindFirst() then begin
                    Terms := Paymentterms.Description;
                end;
                //Shipment Method Description
                ShipmentMethod.Reset();
                ShipmentMethod.SetRange(Code, "Sales Header"."Shipment Method Code");
                if ShipmentMethod.FindFirst() then begin
                    ShipmentMethodDesc := ShipmentMethod.Description;
                end;

            end;

        }
    }


    trigger OnInitReport()
    var
        myInt: Integer;
    begin
        Compinfo.get();
        compinfo.CalcFields(Picture);


    end;



    var
        myInt: Integer;
        Compinfo: Record "Company Information";
        SalesPerson: Record 13;
        SalesPersonName: Text[100];
        Paymentterms: Record "Payment Terms";
        Terms: Code[20];
        ShipmentMethod: record 10;
        ShipmentMethodDesc: text[100];

}