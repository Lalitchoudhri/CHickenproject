// pageextension 60100 postedpurchase extends "Posted Purchase Invoice"
// {
//     layout
//     {
//         addfirst("Buy-from")
//         {
//             field("E-Mail Sent"; rec."E-Mail Sent")
//             {
//                 ApplicationArea = all;
//             }
//         }
//     }




//     actions
//     {
//         addlast(navigation)
//         {
//             action(Email)
//             {
//                 ApplicationArea = All;
//                 Promoted = true;
//                 PromotedCategory = New;
//                 trigger OnAction()
//                 var
//                     codeunit1: Codeunit "Email Integration";
//                 begin
//                     codeunit1.EmailAttachment(rec);
//                 end;
//             }
//         }
//     }
// }

