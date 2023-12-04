pageextension 50103 itemtrakingline extends "Item Tracking Summary"
{


    trigger OnClosePage()
    var
        // TrackingSpecification: Record "Tracking Specification";
        note1: Label 'Please select this Entry';
        EntrySummary: Record "Entry Summary" temporary;
        TrackingSpecification: Record "Tracking Specification";
        date1: Code[20];
        cooment: Text[100];
        salescommet_line: Record "Sales Comment Line";
    begin

        EntrySummary.Reset();
        if rec.FindSet(false) then
            repeat
                EntrySummary.Copy(rec);
                EntrySummary.Insert();
            until rec.Next() = 0;
        // Message(Format(Rec.Count));
        // Message(Format(EntrySummary.Count));
        if EntrySummary.FindFirst() then
            Message('%1,%2,%3', EntrySummary."Lot No.", EntrySummary."Expiration Date", note1);
        date1 := Format(Rec."Expiration Date");
        cooment := Format(rec."Lot No.") + date1 + note1;
        TrackingSpecification.Reset();
        TrackingSpecification.SetRange("Lot No.", rec."Lot No.");
        // if TrackingSpecification.FindFirst() then
        TrackingSpecification.Comment := cooment;

    end;




}
pageextension 50104 ItemTrackingLines extends "Item Tracking Lines"
{
    layout
    {
        addafter("Appl.-from Item Entry")
        {
            field(Comment; Rec.Comment)
            {
                ApplicationArea = all;
                // trigger OnValidate()
                // var
                //     SalesCommentLine: Record "Sales Comment Line";
                //     TrackingSpecification: Record "Tracking Specification";
                // begin
                //     SalesCommentLine.Reset();
                //     SalesCommentLine.SetRange("No.", rec."Source ID");
                //     if SalesCommentLine.FindFirst() then begin
                //         SalesCommentLine.Comment := rec.Comment

                //     end;

                // end;
            }
        }

        // modify("Lot No.")
        // {
        //     trigger OnAfterValidate()
        //     var
        //         note1: Label 'Please select this Entry';
        //         EntrySummary: Record "Entry Summary" temporary;
        //         TrackingSpecification: Record "Tracking Specification";
        //         date1: Code[20];
        //         cooment: Text[100];
        //     begin

        //         // EntrySummary.Reset();
        //         // if rec.FindSet(false) then
        //         //     repeat
        //         //         EntrySummary.Copy(rec);
        //         //         EntrySummary.Insert();

        //         //     until rec.Next() = 0;
        //         // Message(Format(Rec.Count));
        //         // Message(Format(EntrySummary.Count));
        //         // if EntrySummary.FindFirst() then
        //         //     repeat
        //         //         date1 := Format(Rec."Expiration Date");
        //         //         cooment := Format(rec."Lot No.") + date1 + note1;
        //         //         Message('%1,%2,%3', EntrySummary."Lot No.", EntrySummary."Expiration Date", note1);
        //         //     until EntrySummary.Next() = 0;
        //         // TrackingSpecification.Reset();
        //         // TrackingSpecification.SetRange("Lot No.", rec."Lot No.");
        //         // if TrackingSpecification.FindFirst() then begin
        //         //TrackingSpecification.Comment := cooment;
        //         // end;
        //         //  repeat
        //         // date1 := Format(Rec."Expiration Date");

        //         // until TrackingSpecification.Next() = 0;

        //     end;
        // }
    }
    trigger OnClosePage()
    var
        SalesCommentLine: Record "Sales Comment Line";
        TrackingSpecification: Record "Tracking Specification";
    begin
        // SalesCommentLine.Reset();
        // SalesCommentLine.SetRange("No.", rec."Source ID");
        // if SalesCommentLine.FindFirst() then begin
        //     SalesCommentLine.Comment := rec.Comment

        // end;

    end;

}
