permissionset 60000 "PTE All"
{
    Access = Internal;
    Assignable = true;
    Caption = 'All permissions', Locked = true;

    Permissions =
         codeunit "PTE EAN 13 Barcode" = X;
}