codeunit 50103 RushabhWalaCode2
{
    // trigger OnRun()
    // begin
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnBeforeSendPostedDocumentRecord, '', false, false)]
    local procedure "Sales-Post_OnBeforeSendPostedDocumentRecord"(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean; var DocumentSendingProfile: Record "Document Sending Profile");
    begin
        IsHandled := true;
        SalesHeader.EmailRFQAttachment(SalesHeader);
    end;
    // [EventSubscriber(ObjectType::Table, Database::"Purchase Header", OnBeforeSendRecords, '', false, false)]
    // local procedure OnBeforeSendRecords(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean);
    // begin
    //     IsHandled := true;
    //     PurchaseHeader.SentMailAttachmnet(PurchaseHeader);
    // end;

    var
        myInt: Integer;
}

tableextension 50105 MyExtension2 extends "Sales Header"
{
    fields
    {
        field(60100; "E-Mail Sent"; Boolean)
        {
            Caption = 'E-Mail Sent';
            DataClassification = ToBeClassified;
        }
        // Add changes to table fields here
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }


    // procedure SentMailAttachmnet(var SalesHeader: Record "Sales Header")
    // var
    //     EmailAccount: Record "Email Account";
    //     EmailMsg: Codeunit "Email Message";
    //     flag: Boolean;
    //     BodyText: text;
    //     outstream: OutStream;
    //     instream: InStream;
    //     reportPO: report 1306;
    //     tempblob: Codeunit "Temp Blob";
    //     Vendor: record Customer;
    //     VendEmail: text;
    //     CompanyInfo: Record "Company Information";


    // begin

    //     if Vendor.get(SalesHeader."Sell-to Customer No.") then
    //         VendEmail := Vendor."E-Mail";
    //     // BodyText := '<B>Greetings from Kwality Foods</B>' + '<br><br>' + '<br>Dear Sir/Madam,' + '<br>Please find the attached Purchase Order.'
    //     //  + '<br>Kindly arrange to despatch the Material along with COA .';
    //     // BodyText := 'Dear ' + 'SIR' + ',<br>' + '<br>Please find the below mentioned Details of PO.';
    //     // EmailMsg.Create(VendEmail, 'Purchase Order ' + SalesHeader."No.", BodyText, TRUE);
    //     EmailMsg.Create(VendEmail, 'New Confirm Order Invoice Copy', BodyText, TRUE);
    //     reportPO.SetTableView(SalesHeader);
    //     tempblob.CreateOutStream(outstream);
    //     flag := reportPO.SaveAs('', ReportFormat::Pdf, outstream);
    //     tempblob.CreateInStream(instream);

    //     EmailMsg.AppendToBody('Dear Sir / Madam, <BR><BR>');
    //     EmailMsg.AppendToBody(Vendor.Name + ' <BR><BR>');
    //     //RecLoc.SETFILTER(Code, RecSalesInv."Location Code");
    //     //EmailMsg.AppendToBody('THANK YOU DR FOR SHARING YOUR VALUABLE ORDER RECEIVED AT OUR OFFICE ON:',RecSalesInv."Posting Date", ' Dated.<BR>');
    //     EmailMsg.AppendToBody('THANK YOU DR FOR SHARING YOUR VALUABLE ORDER RECEIVED AT OUR OFFICE ON:' + SalesHeader."No." + ' and Date: ' + FORMAT(SalesHeader."Posting Date"));
    //     EmailMsg.AppendToBody('<BR><BR>');
    //     EmailMsg.AppendToBody('WE ARE SHARING YOU THE INVOICE COPY ATTACHED TO THIS MAIL. THEDETAILS OF CONFIRMED ORDER WITH PRODUCTS IS AS FOLLOWS:<BR><BR>');
    //     EmailMsg.AppendToBody('INVOICE NO.' + SalesHeader."No." + '<BR>' + 'DATE OF BILLING' + Format(SalesHeader."Order Date") + '<BR>' + 'AmountRs' + '<BR>' + 'Due Date For Period' + Format(SalesHeader."Due Date") + '<BR>' + 'CREDIT PERIOD' + SalesHeader."Payment Terms Code");
    //     EmailMsg.AppendToBody('WE LOOK FORWARD TO YOUR CONTINOUS SUPPORT FOR OUR ESTEEMED GLOBAL BRANDS., <BR>');
    //     EmailMsg.AppendToBody('DR SHARING YOU OUR COMPANY CURRENT ACCOUNT BANK DETAILS BANK DETAILS/ QR CODE IMAGE');
    //     EmailMsg.AppendToBody(' BANK Name' + CompanyInfo."Bank Name" + ' BANK NO.' + CompanyInfo."Bank Account No.");
    //     EmailMsg.AppendToBody('Regards, <BR>');
    //     EmailMsg.AppendToBody(CompanyInfo.Name + '<BR>');
    //     // EmailMsg.AddAttachment('Purchase Order ' + SalesHeader."No." + '.pdf', 'PDF', instream);
    //     // EmailMsg.AppendToBody('<br><br>');
    //     // EmailMsg.AppendToBody('<p style="color:red;"><U>1.Note : COA is Mandatory without COA material will not unloaded</U></p>');
    //     // EmailMsg.AppendToBody('<br>1.Delivery Location :Harohalli ( Industrial Area 2ND Phase)');
    //     // // EmailMsg.AppendToBody('<br><B>2.Dispatch date:' + Format(SalesHeader."Delivery Date") + '</B>');
    //     // EmailMsg.AppendToBody('<br><B>3.Payment Terms :' + SalesHeader."Payment Terms Code" + '</B>');
    //     // EmailMsg.AppendToBody('<br><B>4.Delivery :Harohalli Industrial area</B>');
    //     // EmailMsg.AppendToBody('<br>5.Special Note : Material should be delivery before 4.30 to factory if its reached after 4.30 Material will be unloaded next day.');
    //     // EmailMsg.AppendToBody('<br>6.No Hamali ( Unloaders )  allowed inside till Covid -19 clear');
    //     // EmailMsg.AppendToBody('<br>7.Material Should be as per Specification only.');
    //     // EmailMsg.AppendToBody('<br>8.RM above one ton Weighment is Mandatory');
    //     // EmailMsg.AppendToBody('<br>9.RM materials Should be Free from Foreign particles');
    //     // EmailMsg.AppendToBody('<br>10.Any quality deviation Entire lot will be rejected');
    //     // EmailMsg.AppendToBody('<br><br>');
    //     // EmailMsg.AppendToBody('<U><B>11.Billing and Delivery Address :</U></B>');
    //     // EmailMsg.AppendToBody('<br><br>');
    //     // EmailMsg.AppendToBody('<B>Pagariya Food Products Pvt Ltd.,</B>');
    //     // EmailMsg.AppendToBody('<br><B>Factory:</B>' + 'Unit Plot No # 302 A, Phase -2,');
    //     // EmailMsg.AppendToBody('<br>KIADB Industrial Estate, Harohalli');
    //     // EmailMsg.AppendToBody('<br>Taluka Kanakapura, Dist Ramanagara,');
    //     // EmailMsg.AppendToBody('<br>Pin Code: 562 112, Karnataka State, India.');
    //     // EmailMsg.AppendToBody('<br>GST :' + '<B>29AAFCP2699J1ZQ .');
    //     if flag then begin
    //         Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
    //         // SMTPMail.Send;
    //         MESSAGE('mail Sent Successfuly');

    //     end;
    // end;
    // procedure SentMailAttachmnet123(var SalesHeader: Record "Sales Header")
    // var
    //     EmailAccount: Record "Email Account";
    //     EmailMsg: Codeunit "Email Message";
    //     flag: Boolean;
    //     BodyText: text;
    //     outstream: OutStream;
    //     instream: InStream;
    //     reportPO: report 50113;
    //     tempblob: Codeunit "Temp Blob";
    //     Vendor: record Customer;
    //     VendEmail: text;
    //     CompanyInfo: Record "Company Information";


    // begin

    //     if Vendor.get(SalesHeader."Sell-to Customer No.") then
    //         VendEmail := Vendor."E-Mail";

    //     // EmailMsg.Create(VendEmail, 'Purchase Order ' + SalesHeader."No.", BodyText, TRUE);
    //     EmailMsg.Create(VendEmail, 'New Confirm Order Invoice Copy', BodyText, TRUE);
    //     reportPO.SetTableView(SalesHeader);
    //     tempblob.CreateOutStream(outstream);
    //     flag := reportPO.SaveAs('', ReportFormat::Pdf, outstream);
    //     tempblob.CreateInStream(instream);

    //     EmailMsg.AppendToBody('Dear Sir / Madam, <BR><BR>');
    //     EmailMsg.AppendToBody(Vendor.Name + ' <BR><BR>');
    //     //ndToBody('THANK YOU DR FOR SHARING YOUR VALUABLE ORDER RECEIVED AT OUR OFFICE ON:',RecSalesInv."Posting Date", ' Dated.<BR>');
    //     EmailMsg.AppendToBody('THANK YOU DR FOR SHARING YOUR VALUABLE ORDER RECEIVED AT OUR OFFICE ON:' + SalesHeader."No." + ' and Date: ' + FORMAT(SalesHeader."Posting Date"));
    //     EmailMsg.AppendToBody('<BR><BR>');
    //     EmailMsg.AppendToBody('WE ARE SHARING YOU THE INVOICE COPY ATTACHED TO THIS MAIL. THEDETAILS OF CONFIRMED ORDER WITH PRODUCTS IS AS FOLLOWS:<BR><BR>');
    //     EmailMsg.AppendToBody('INVOICE NO.' + SalesHeader."No." + '<BR>' + 'DATE OF BILLING' + Format(SalesHeader."Order Date") + '<BR>' + 'AmountRs' + '<BR>' + 'Due Date For Period' + Format(SalesHeader."Due Date") + '<BR>' + 'CREDIT PERIOD' + SalesHeader."Payment Terms Code");
    //     EmailMsg.AppendToBody('WE LOOK FORWARD TO YOUR CONTINOUS SUPPORT FOR OUR ESTEEMED GLOBAL BRANDS., <BR>');
    //     EmailMsg.AppendToBody('DR SHARING YOU OUR COMPANY CURRENT ACCOUNT BANK DETAILS BANK DETAILS/ QR CODE IMAGE');
    //     EmailMsg.AppendToBody(' BANK Name' + CompanyInfo."Bank Name" + ' BANK NO.' + CompanyInfo."Bank Account No." + '<BR>');
    //     EmailMsg.AppendToBody('Regards, <BR>');
    //     EmailMsg.AppendToBody(CompanyInfo.Name + '<BR>');

    //     // EmailMsg.AppendToBody('<br>Pin Code: 562 112, Karnataka State, India.');
    //     // EmailMsg.AppendToBody('<br>GST :' + '<B>29AAFCP2699J1ZQ .');
    //     if flag then begin
    //         Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
    //         // SMTPMail.Send;
    //         MESSAGE('mail Sent Successfuly');

    //     end;
    // end;


    // var
    //     myInt: Integer;
    //     Email: Codeunit "Email";
    procedure EmailRFQAttachment(PurchHeader: Record "Sales Header")
    var
        Vendor: Record Customer;
        PurchHdr: Record "Sales Header";
        Subject: Text[100];
        AttachementTempBlob: Codeunit "Temp Blob";
        AttachmentInstream: InStream;
        AttachementOutstream: OutStream;
        FileMgt: Codeunit "File Management";
        recPurchref: RecordRef;
        repRequestForQuote: Report 50113;
        //new
        MailSent: Boolean;
        FilePath: Text;
    //PurchaseInvoiceHeaderEdit: Codeunit 50002;
    begin
        if PurchHeader."E-Mail sent" = true then
            Error('Mail has been already sent so you can not sent again');

        IF (PurchHeader."Sell-to Customer No." <> '') THEN BEGIN
            Vendor.GET(PurchHeader."Sell-to Customer No.");
            Vendor.TESTFIELD(Vendor."E-Mail");
            AttachementTempBlob.CreateOutStream(AttachementOutstream);
            repRequestForQuote.SetTableView(PurchHeader);
            // repRequestForQuote.SetDocNo(PurchHeader."No.");
            repRequestForQuote.SaveAs('', ReportFormat::Pdf, AttachementOutstream);
            AttachementTempBlob.CreateInStream(AttachmentInstream);
            // Receipent.Add(Contact."E-Mail");Receipent.Add(Vendor."E-Mail");
            CC.Add('lalitchoudhri7071@gmail.com');

            //  Receipent.Add('pradeep.maurya@robo-soft.net');
            //  Receipent.Add('neha.borse@robo-soft.net');
            CLEAR(Subject);
            // IF PurchHeader."Requisition No." <> '' THEN
            //    Subject := 'IMR No.: ' + PurchHeader."Requisition No." + ' ';
            Subject += 'NEW CONFIRMED ORDER INVOICE COPY' + PurchHeader."No.";
            Body := 'DEAR ,' + PurchHeader."Sell-to Customer Name" + '</br>';
            Body += '</br>';
            Body += 'THANK YOU DR FOR SHARING YOUR VALUABLE ORDER RECEIVED AT OUR OFFICE ON ' + PurchHeader."No." + ' AND DATE.' + Format(PurchHeader."Posting Date") + '</br>';
            Body += '</br>';
            Body += 'WE ARE SHARING YOU THE INVOICE COPY ATTACHED TO THIS MAIL.' + '</br>';
            Body += 'THEDETAILS OF CONFIRMED ORDER WITH PRODUCTS IS AS FOLLOWS:' + '</br>';
            Body += ('INVOICE NO.' + PurchHeader."No." + '<BR>' + 'DATE OF BILLING' + Format(PurchHeader."Order Date") + '<BR>' + 'AmountRs' + '<BR>' + 'Due Date For Period' + Format(PurchHeader."Due Date") + '<BR>' + 'CREDIT PERIOD' + PurchHeader."Payment Terms Code");
            Body += ('WE LOOK FORWARD TO YOUR CONTINOUS SUPPORT FOR OUR ESTEEMED GLOBAL BRANDS., <BR>');
            Body += ('DR SHARING YOU OUR COMPANY CURRENT ACCOUNT BANK DETAILS BANK DETAILS/ QR CODE IMAGE');
            Body += (' BANK Name' + CompanyInfo."Bank Name" + ' BANK NO.' + CompanyInfo."Bank Account No." + '<BR>');
            Body += ('Regards, <BR>');
            Body += (CompanyInfo.Name + '<BR>');
            Body += USERID;
            EmailMessage.Create(Receipent, Subject, Body, true, CC, CC);
            EmailMessage.AddAttachment('Report.Pdf', 'PDF', AttachmentInstream);
            if Email.Send(EmailMessage, Enum::"Email Scenario"::Default) then
                MailSent := true;
            Message('%1', MailSent);
            CompanyInfo.get();
            // if MailSent then//     PurchaseInvoiceHeaderEdit.UpdatePurchaseInvoiceHeader(PurchHeader, MailSent, TODAY);
        end;
    end;


    var
        CompanyInfo: Record "Company Information";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Receipent: List of [Text];
        Body: Text;

        Contact: Record 5050;
        CC: List of [Text];
}
// reportextension 50100 PurchaseInvoiceReportExt1 extends 50113
// {
//     dataset
//     {
//         modify(Header)
//         {
//             trigger OnBeforePreDataItem()
//             var
//             begin
//                 if glDocNo <> '' then
//                     SetRange("No.", glDocNo);
//             end;
//         }
//     }
//     procedure setdocno(DocNo: Code[20])
//     begin
//         glDocNo := DocNo;
//     end;

//     var
//         glDocNo: Code[20];
// }