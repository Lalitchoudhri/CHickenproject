// tableextension 50103 "" extends "Entry Summary"
// {
//     fields
//     {
//         modify("Expiration Date")
//         {
//             trigger OnAfterValidate()

//             begin
//                 rec.Reset();
//                 rec.SetRange("Entry No.");
//                 if rec.FindFirst() then
//                     Message('Please select the First value');

//             end;
//         }
//     }
// }
