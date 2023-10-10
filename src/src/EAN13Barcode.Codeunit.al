codeunit 60000 "PTE EAN 13 Barcode"
{
    procedure Create(var ItemIdentifier: Record "Item Identifier"): Boolean
    var
        NewCode: Code[13];
        Times: Integer;
    begin
        if ItemIdentifier.Code <> '' then
            exit(false);

        repeat
            NewCode := CalculateCheckDigit();
            Times += 1;
        until (not ItemIdentifier.Get(NewCode)) or (Times = 10000);

        if times = 10000 then
            exit(false);

        ItemIdentifier.Code := NewCode;
        exit(true);
    end;

    procedure CalculateCheckDigit(): Code[13]
    var
        NewCode: Code[13];
        CheckDigit: Integer;
        CountryCode: Integer;
        EvenSum: Integer;
        i: Integer;
        OddSum: Integer;
        ProductCode: Integer;
        RandomManufacturer: Integer;
        Sum: Integer;
        Times: Integer;
    begin
        Clear(Times);
        while not (RandomManufacturer in [10000 .. 99999]) do begin
            RandomManufacturer := Random(99999);
            Times += 1;
            if times = 10000 then
                break;
        end;

        Clear(Times);
        while not (CountryCode in [20 .. 29]) do begin
            CountryCode := Random(29);
            Times += 1;
            if times = 10000 then
                break;
        end;

        Clear(Times);
        while not (ProductCode in [10000 .. 99999]) do begin
            ProductCode := Random(99999);
            Times += 1;
            if times = 10000 then
                break;
        end;

        NewCode := format(CountryCode) + format(RandomManufacturer) + Format(ProductCode);
        EvenSum := 0;
        OddSum := 0;

        for i := 1 to 12 do begin
            Evaluate(Sum, NewCode[i]);
            if i mod 2 = 0 then
                EvenSum += Sum  // Digits in even positions
            else
                OddSum += Sum;  // Digits in odd positions (except the last one)
        end;

        EvenSum := EvenSum * 3;
        OddSum := OddSum + EvenSum;

        if (OddSum mod 10) = 0 then
            CheckDigit := 0
        else
            CheckDigit := 10 - (OddSum mod 10);

        NewCode += CopyStr(FORMAT(CheckDigit), 1, 20);
        exit(NewCode);
    end;
}