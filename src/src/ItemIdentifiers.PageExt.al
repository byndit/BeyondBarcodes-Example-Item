pageextension 60000 "PTE Item Identifiers" extends "Item Identifiers"
{
    layout
    {
        modify(Code)
        {
            trigger OnAssistEdit()
            var
                EAN13Barcode: Codeunit "PTE EAN 13 Barcode";
            begin
                if EAN13Barcode.Create(Rec) then
                    Rec.Validate(Code);
            end;
        }
        addfirst(factboxes)
        {
            part("PTE Barcode"; "BYD Barcode")
            {
                ApplicationArea = All;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage."PTE Barcode".Page.SetSourceTable(Rec);
    end;
}