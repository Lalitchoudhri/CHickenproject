tableextension 50103 EntrySummary extends "Entry Summary"
{
    fields
    {
        field(50100; "Comment"; Text[100])
        {

            Caption = 'Comment';
            DataClassification = ToBeClassified;
            trigger OnLookup()
            var
                note1: Label 'Please select this Entry';
            begin

                // rec.Reset();
                // if rec.FindFirst() then
                //     Message('%1,%2,%3', rec."Lot No.", Rec."Expiration Date", note1);
            end;
        }
        // modify("Lot No.")
        // {
        //     trigger OnBeforeValidate()
        //     var
        //         note1: Label 'Please select this Entry';
        //     begin
        //         rec.Reset();
        //         if rec.FindFirst() then
        //             Message('%1,%2,%3', rec."Lot No.", Rec."Expiration Date", note1);

        //     end;
        // }
    }
}
tableextension 50104 TrackingSpecification extends "Tracking Specification"
{
    fields
    {
        field(50100; Comment; text[250])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                SALESCOOME: Record "Sales Comment Line";
                salesline: Record "Sales Line";
            begin
                salesline.Reset();
                salesline.SetRange(salesline."Document No.", REC."Source ID");
                IF salesline.FindFirst() then begin
                    salesline.Comment := REC.Comment;
                end;

            end;
        }
    }

}
tableextension 50106 SalesLine extends "Sales Line"
{
    fields
    {
        field(50100; Comment; text[250])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                SALESCOOME: Record "Sales Comment Line";
                salesline: Record "Sales Line";
            begin
                // SALESCOOME.Reset();
                // SALESCOOME.SetRange("No.", REC."Source ID");
                // IF SALESCOOME.FindFirst() then begin
                //     SALESCOOME.Comment := REC.Comment;
                // end;

            end;
        }
    }

}

