pageextension 50105 salesheader extends "Sales Invoice"
{
    layout
    {
        addafter("Applies-to Doc. No.")
        {
            field("E-Mail sent"; Rec."E-Mail sent")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addafter("&Invoice")
        {
            action(emaial)
            {
                Promoted = true;
                PromotedCategory = New;
                ApplicationArea = all;
                trigger OnAction()
                var
                    salesheader: Record "Sales Header";
                // "EmailIntegration": Codeunit "Email Integration1";

                begin
                    // "EmailIntegration".EmailAttachment(Rec);
                    // salesheader.Reset();
                    // salesheader.SetRange("No.", Rec."No.");
                    // Report.RunModal(50113, true, true, salesheader);

                end;
            }
        }
    }
}

