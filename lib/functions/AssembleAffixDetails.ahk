AssembleAffixDetails()
{
    Global Opts, AffixLines
    
    AffixLine =
    AffixType =
    ValueRange =
    AffixTier =
    NumAffixLines := AffixLines.MaxIndex()
    AffixLineParts := 0
    Loop, %NumAffixLines%
    {
        CurLine := AffixLines[A_Index]
        ProcessedLine =
        Loop, %AffixLineParts0%
        {
            AffixLineParts%A_Index% =
        }
        StringSplit, AffixLineParts, CurLine, |
        AffixLine := AffixLineParts1
        ValueRange := AffixLineParts2
        AffixType := AffixLineParts3
        AffixTier := AffixLineParts4

        Delim := Opts.AffixDetailDelimiter
        Ellipsis := Opts.AffixDetailEllipsis

        If (Opts.ValueRangeFieldWidth > 0)
        {
            ValueRange := StrPad(ValueRange, Opts.ValueRangeFieldWidth, "left")
        }
        If (Opts.MirrorAffixLines == 1)
        {
            If (Opts.MirrorLineFieldWidth > 0)
            {
                If(StrLen(AffixLine) > Opts.MirrorLineFieldWidth)
                {   
                    AffixLine := StrTrimSpaceRight(SubStr(AffixLine, 1, Opts.MirrorLineFieldWidth)) . Ellipsis
                }
                AffixLine := StrPad(AffixLine, Opts.MirrorLineFieldWidth + StrLen(Ellipsis))
            }
            ProcessedLine := AffixLine . Delim
        }
        IfInString, ValueRange, *
        {
            ValueRangeString := StrPad(ValueRange, (Opts.ValueRangeFieldWidth * 2) + (StrLen(Opts.AffixDetailDelimiter)))
        }
        Else
        {
            ValueRangeString := ValueRange
        }
        ProcessedLine := ProcessedLine . ValueRangeString . Delim
        If (Opts.ShowAffixBracketTier == 1 and Not (ItemDataRarity == "Unique") and Not StrLen(AffixTier) = 0)
        {
            If (InStr(ValueRange, "*") and Opts.ShowAffixBracketTier)
            {
                TierString := "   "
                AdditionalPadding := ""
                If (Opts.ShowAffixLevel or Opts.ShowAffixBracketTotalTier)
                {
                    TierString := ""
                }
                If (Opts.ShowAffixLevel) 
                {
                    AdditionalPadding := AdditionalPadding . StrMult(" ", Opts.ValueRangeFieldWidth)
                }
                If (Opts.ShowAffixBracketTierTotal)
                {
                    AdditionalPadding := AdditionalPadding . StrMult(" ", Opts.ValueRangeFieldWidth)

                }
                TierString := TierString . AdditionalPadding
            }
            Else 
            {
                AddedWidth := 0
                If (Opts.ShowAffixBracketTierTotal)
                {
                    AddedWidth += 2

                }
                TierString := StrPad("T" . AffixTier, 3+AddedWidth, "left")
            }
            ProcessedLine := ProcessedLine . TierString . Delim
        }
        ProcessedLine := ProcessedLine . AffixType . Delim
        Result := Result . "`n" . ProcessedLine
    }
    return Result
}