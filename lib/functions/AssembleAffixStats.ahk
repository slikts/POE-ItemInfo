SortArray(Array, Order="A") {
    ;Order A: Ascending, D: Descending, R: Reverse
    MaxIndex := ObjMaxIndex(Array)
    If (Order = "R") {
        count := 0
        Loop, % MaxIndex 
            ObjInsert(Array, ObjRemove(Array, MaxIndex - count++))
        Return
    }
    Partitions := "|" ObjMinIndex(Array) "," MaxIndex
    Loop {
        comma := InStr(this_partition := SubStr(Partitions, InStr(Partitions, "|", False, 0)+1), ",")
        spos := pivot := SubStr(this_partition, 1, comma-1) , epos := SubStr(this_partition, comma+1)    
        if (Order = "A") {    
            Loop, % epos - spos {
                if (Array[pivot] > Array[A_Index+spos])
                    ObjInsert(Array, pivot++, ObjRemove(Array, A_Index+spos))    
            }
        } else {
            Loop, % epos - spos {
                if (Array[pivot] < Array[A_Index+spos])
                    ObjInsert(Array, pivot++, ObjRemove(Array, A_Index+spos))    
            }
        }
        Partitions := SubStr(Partitions, 1, InStr(Partitions, "|", False, 0)-1)
        if (pivot - spos) > 1    ;if more than one elements
            Partitions .= "|" spos "," pivot-1        ;the left partition
        if (epos - pivot) > 1    ;if more than one elements
            Partitions .= "|" pivot+1 "," epos        ;the right partition
    } Until !Partitions
}

StringJoin(array, delimiter = ";")
{
  Loop
    If Not %array%%A_Index% Or Not t .= (t ? delimiter : "") %array%%A_Index%
      Return t
}

AssembleAffixStats()
{
  Global Opts, AffixLines
  NumAffixLines := AffixLines.MaxIndex()
  Tiers := Object()
  Total := 0
  Loop, %NumAffixLines%
  {
    CurLine := AffixLines[A_Index]
    Loop, %AffixLineParts0%
    {
        AffixLineParts%A_Index% =
    }
    StringSplit, AffixLineParts, CurLine, |
    Total += AffixLineParts4
    Tiers.Insert(AffixLineParts4) 
  }
  SortArray(Tiers)
  SetFormat, float, 0.1
  Average := Round(Total / Tiers.MaxIndex() * 100) / 100
  Median := Tiers[Round(Tiers.MaxIndex() / 2)]
  ;return "`n" . Median . " median`n" . Average . " average"
  return "`n" . Median . " / " . Average
}