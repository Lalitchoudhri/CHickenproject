// report 50100 "purchase report"
// {
//     ApplicationArea = All;
//     Caption = 'Purchase report';
//     UsageCategory = ReportsAndAnalysis;
//     RDLCLayout = 'purchase.rdl';
//     DefaultLayout = RDLC;
//     dataset
//     {
//         dataitem(PurchaseHeader; "Purchase Header")
//         {
//             column(No_; "No.") { }
//             column(Buy_from_Vendor_Name; "Buy-from Vendor Name") { }
//             column(Buy_from_Address_2; "Buy-from Address 2") { }
//         }
//     }
//     requestpage
//     {
//         layout
//         {
//             area(content)
//             {
//                 group(GroupName)
//                 {
//                 }
//             }
//         }
//         actions
//         {
//             area(processing)
//             {
//             }
//         }
//     }
// }
