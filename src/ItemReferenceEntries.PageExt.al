pageextension 60001 "PTE Item Reference Entries" extends "Item Reference Entries"
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