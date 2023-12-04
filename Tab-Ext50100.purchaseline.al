tableextension 50100 "purchase line1" extends "Purchase Header"
{


    fields
    {

        field(50100; "Advance"; Decimal)
        {
            Caption = 'Advance';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                purchaseheasder: Record "Purchase Header";
                purchaseline: Record "Purchase Line";
            begin

                purchaseline.Reset();
                purchaseline.SetRange("Document No.", Rec."No.");
                purchaseline.SetRange("Buy-from Vendor No.", Rec."Buy-from Vendor No.");
                if purchaseline.FindFirst() then begin
                    repeat
                        //Validate("Advance payment", PurchLine.Quantity * PurchLine."Unit Cost" * rec.Advance);
                        rec."Advance payment" += purchaseline."Amount Including VAT" * rec.Advance / 100;
                    until purchaseline.Next = 0;
                end;
            end;
        }

        field(50101; "Advance payment"; Decimal)
        {
            Caption = 'Advance payment';
            DataClassification = ToBeClassified;
        }
        modify(Status)
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
                recGenLine: Record "Gen. Journal Line";
            begin
                if Rec.Status = Status::Released then begin
                    Validate("No.", recGenLine."External Document No.");
                end;
            end;
        }


    }
    // local procedure totaladvanceAmount(var RecgenjoulLine: Record 81)
    // var
    //     Purchase_Header: Record 38;
    // begin
    //     Purchase_Header.Init();
    //     Purchase_Header.Status := Purchase_Header.Status::Released;
    //     Purchase_Header.Validate("No.", RecgenjoulLine."External Document No.");

    // end;
#pragma warning disable AL0414

    // local procedure totaladvanceAmount(var purchaseheasder: Record "Purchase Header" , 
#pragma warning restore AL0414
    //   purchaseline: Record "Purchase Line")
}
tableextension 50101 Gen_Jou_line extends "Gen. Journal Line"
{
    fields
    {
        // field(50100; "Document Type1"; text[100])
        // {
        //     Caption = ' Document Type';
        //     DataClassification = ToBeClassified;
        // }



        modify("Account No.")
        {


            trigger OnAfterValidate()
            var
                GenJournalLine: Record "Gen. Journal Line";
            begin

                // GenJournalLine.SetRange("Account Type", rec."Account Type"::Vendor);
                // if GenJournalLine.FindFirst()
                //  then begin
                //     Rec."Account No." := Account;
                // end;
            end;

        }

    }

}
tableextension 50102 purchaseheaer extends "Purch. Inv. Header"
{

    fields
    {
        field(60100; "E-Mail Sent"; Boolean)
        {
            Caption = 'E-Mail Sent';
            DataClassification = ToBeClassified;
        }
    }
}





