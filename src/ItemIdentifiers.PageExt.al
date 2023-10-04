pageextension 60000 "PTE Item Identifiers" extends "Item Identifiers"
{
    layout
    {
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