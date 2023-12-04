codeunit 50101 "payment transfer"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnAfterReleasePurchaseDoc', '', false, false)]
    local procedure OnAfterManualReleasePurchaseDoc(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; SkipWhseRequestOperations: Boolean; var LinesWereModified: Boolean)
    var
        PurchInvHeader: Record "Purchase Header";
        GenJournalLine: Record "Gen. Journal Line";
        Lineno: Integer;
        PurchInvLine: Record "Purchase Line";
        GenJournalBatch: Record "Gen. Journal Batch";
        PurchInvHdrNo: Code[20];
        NoSeriesManagement: Codeunit NoSeriesManagement;
        vendor: Record Vendor;
        AccountNo: Code[20];
        DocumentNo: Code[20];

    begin

        PurchInvHeader.Reset();
        PurchInvHeader.SetRange("No.", PurchaseHeader."No.");
        if PurchInvHeader.FindFirst() then begin

            GenJournalLine.SETRANGE(GenJournalLine."Journal Template Name", 'BANKPYMTV');
            GenJournalLine.SETRANGE(GenJournalLine."Journal Batch Name", 'USER-A');
            IF GenJournalLine.FINDLAST THEN BEGIN
                Lineno := GenJournalLine."Line No." + 10000;
                GenJournalLine."Line No." := Lineno;
            END;
            repeat
                GenJournalLine.RESET;
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name" := 'BANKPYMTV';
                GenJournalLine."Journal Batch Name" := 'USER-A';
                GenJournalLine."Posting No. Series" := 'BNKPYV-P';
                GenJournalLine.Amount := PurchInvHeader."Advance payment";
                GenJournalLine."Document Date" := PurchInvHeader."Order Date";
                PurchInvHdrNo := PurchInvHeader."Pay-to Vendor No.";

                GenJournalLine.Description := PurchInvHeader."Buy-from Vendor Name";
                GenJournalLine."Document Type" := GenJournalLine."Document Type"::Payment;
                GenJournalLine."Bal. Account No." := 'CHECKING';

                GenJournalBatch.Reset();//Noseries
                GenJournalBatch.SETRANGE(GenJournalBatch."Journal Template Name", GenJournalLine."Journal Template Name");
                GenJournalBatch.SETRANGE(Name, GenJournalLine."Journal Batch Name");
                GenJournalBatch.SETFILTER("No. Series", '<>%1', '');
                IF GenJournalBatch.FINDFIRST THEN
                    DocumentNo := NoSeriesManagement.GetNextNo(GenJournalBatch."No. Series", TODAY, TRUE);
                GenJournalLine.VALIDATE("Document No.", DocumentNo);
                GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"Bank Account";
                GenJournalLine."External Document No." := PurchInvHeader."Vendor Invoice No.";
                GenJournalLine.Validate(GenJournalLine."Bill-to/Pay-to No.", PurchInvHeader."Buy-from Vendor No.");
                GenJournalLine."Gen. Bus. Posting Group" := 'DOMESTIC';
                GenJournalLine."Posting Date" := PurchInvHeader."Posting Date";
                GenJournalLine.VALIDATE(GenJournalLine."Account Type", GenJournalLine."Account Type"::Vendor);
                GenJournalLine.VALIDATE(GenJournalLine.Description, PurchInvHeader."Buy-from Vendor Name");
                GenJournalLine."Currency Code" := PurchInvHeader."Currency Code";
                GenJournalLine."Currency Factor" := PurchInvHeader."Currency Factor";
                GenJournalLine."Sell-to/Buy-from No." := PurchInvHdrNo;
                GenJournalLine.VALIDATE(GenJournalLine."Gen. Prod. Posting Group", PurchInvLine."Gen. Prod. Posting Group");
                GenJournalLine."Credit Amount" := PurchInvLine."Line Amount";
                GenJournalLine."Credit Amount" := PurchInvLine."Direct Unit Cost";
                GenJournalLine.VALIDATE("Credit Amount", PurchInvLine."Direct Unit Cost");
                GenJournalLine."Source Code" := 'BANKPYMTV';

                vendor.Reset();//vendor
                vendor.SETRANGE(Name, GenJournalLine.Description);
                IF vendor.FINDLAST THEN BEGIN
                    GenJournalLine."Account No." := vendor."No.";
                    GenJournalLine."Location Code" := vendor."Location Code";
                end;
                GenJournalLine.Insert;
            until GenJournalLine.Next = 0;
        end
    end;

}
