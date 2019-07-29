#SingleInstance force ;
    SetWorkingDir %A_ScriptDir%  ;
SendMode Input ;
SetTitleMatchMode, 2 ;

MakeCobbleX = 0 ;
Sell = 0 ;
Bloki = 0 ;
Emerald = 0 ;
Repair = 0 ;

RotateSpeed = 0 ;

TimerCobbleX = 0 ;
TimerSell = 0 ;
TimerBloki = 0 ;
TimerRepair = 0 ;

SellTime = 10 ;
CobbleXTime = 10 ;
RepairTime = 10 ;
BlokiTime = 10 ;

Tryb = "Obracanie" ;

; ---GUI---
Gui,+AlwaysOnTop ;
Gui, +ToolWindow ;
Gui, Add, Checkbox, vMakeCobbleX gSubmitAll, Tworzenie Cobblex ;
Gui, Add, Checkbox, vSell gSubmitAll, Sprzedawnie ;
Gui, Add, Checkbox, vBloki gSubmitAll, Tworzenie Blokow ;
Gui, Add, Checkbox, vRepair gSubmitAll, Heal/repair ;
Gui, Add, Checkbox, vEmerald gSubmitAll, Wyrzucanie Emeradow ;
Gui, Add, Slider, gSubmitAll vRotateSpeed Range-20-20 w170 , 0 ;
Gui, Add, Text, +Center w170 ca1a1a1, Predkosc Obrotu ;

Gui, Add, Text,w70 , Tryb Kopania: ;
Gui, Add, DropDownList, Choose1 vTryb w85 yp x80 gSubmitAll , Obracanie|Lewo-Prawo|Kwadrat ;

Gui, Add, Text,x10 vID, Pauza Miedzy: ;
Gui, Add, Text, vSellTEXT, Sprzedaniem: ;
Gui, Add, Edit, vSellTime yp x78 w25 gSubmitAll, 10 ;
Gui, Add, Text, vCobbleXTEXT xs, Cobblex: ;
Gui, Add, Edit, vCobbleXTime yp x78 w25 gSubmitAll, 10 ;
Gui, Add, Text, vRepairTEXT xs, Repair: ;
Gui, Add, Edit, vRepairTime yp x78 w25 gSubmitAll, 10 ;
Gui, Add, Text, vBlokiTEXT xs, Bloki: ;
Gui, Add, Edit, vBlokiTime yp x78 w25 gSubmitAll, 10 ;

Gui, Add, Text, xs vSzerokoscTEXT, Szerokosc: ;
Gui, Add, Edit, vSzerokosc yp x78 w25 gSubmitAll, 10 ;
Gui, Add, Text, xs vDlugoscTEXT, Dlugosc: ;
Gui, Add, Edit, vDlugosc yp x78 w25 gSubmitAll, 10 ;

Gui, Add, Button, x0 w200 gPos1, Pozycja1 ;

Gui, Add, Button, x0 w100 gStart, Start ;
Gui, Add, Button, yp x100 w100 gStop, Stop ;

Gui, Add, Button, x10 y470 w180 gUpdate, Aktualizuj ;
Gui, Add, Button, x5 y520 w40 gHelp, Pomoc ;

Gui, Font, s7 ;
Gui, Add, Text, ca1a1a1 +Right w180 , Pajacuwa AutoMiner ;
Gui, Add, Text, ca1a1a1 +Right w180 , Autor Bacha_Bajceps ;
Gui, Font, s9 ;

Gui, Show, xCenter yCenter w200 h600 , Pajacuwa  AutoMiner ;

; id minecraft?w
Winget, id, list, Minecraft

Goto, SubmitAll ;
return

; ---Funkcje---

Start:
    Stopped = 0 ;
    Click down ;
    While, Stopped != 1 ;
    {
        ; Timery
        if(TimerCobbleX > (CobbleXTime*100) && MakeCobbleX = 1)
        {
            Goto, Cobblex ;
        }
        
        if(TimerSell > (SellTime*100) && Sell = 1)
        {
            Goto, Sell ;
        }
        
        if(TimerRepair > (RepairTime*100) && Repair = 1)
        {
            Goto, Repair ;
        }
        
        if(TimerBloki > (BlokiTime*100) && Bloki = 1)
        {
            Goto, Bloki ;
        }
        
        
        ; Tryby Kopania
        if (Tryb = "Obracanie") ; Tryb Obracanie
        {
            MouseMove, RotateSpeed,0, 100, R ;
            Sleep, 10 ;
            TimerCobbleX++ ;
            TimerSell++ ;
            TimerRepair++ ;
            TimerBloki++ ;
        }
        
        if (Tryb = "Lewo-Prawo") ; Tryb Lewo-Prawo
        {
            Click down ;
            Send, {a down} ; 
            Sleep, Szerokosc*100 ;
            Send, {a up}; ;d
            Sleep 50 ;
            Send, {d down} ; 
            Sleep, Szerokosc*100 ;
            Send, {d up} ; 
            Sleep 50 ;
            TimerCobbleX += 20 ;
            TimerSell += 20 ;
            TimerRepair += 20 ;
            TimerBloki += 20 ;
        }
        
        if (Tryb = "Kwadrat") ; Tryb Kwadrat
        {
            Click down ;
            Send, {a down} ;
            Sleep, Szerokosc*100 ;
            Send, {a up} ;
            Sleep 50 ;
            Send, {w down} ;
            Sleep, Dlugosc*100 ;
            Send, {w up} ;
            Sleep 50 ;
            Send, {d down} ;
            Sleep, Szerokosc*100 ;
            Send, {d up} ;
            Sleep 50 ;
            Send, {s down} ;
            Sleep, Dlugosc*100 ;
            Send, {s up} ;
            Sleep 50 ;
            TimerCobbleX += 40 ;
            TimerSell += 40 ;
            TimerRepair += 40 ;
            TimerBloki += 40 ;
        }
    }
    
return

Pos1:
    Sleep 100 ;
    KeyWait, LButton, D
    MouseGetPos, Pos1x, Pos1y ;
    MsgBox, , Pozycja1, Pozycja pierwsza zostala zapisana %Pos1x% %Pos1y%, 2 ;
return


Sell:
    if (Stopped != 1)
    {
        if(Emerald = 1)
        {
            Send, { e } ;
            SendInput, {Control down} ;
            Sleep, 100 ;
            Loop, 
            {
                ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *70 %A_WorkingDir%/emerald.png ;
                Sleep, 50 ;
                MouseMove, %FoundX%, %FoundY% , 100 ;
                Sleep, 100 ;
                ;MsgBox The icon was found at %FoundX%x%FoundY%.
                if (ErrorLevel = 1)
                {
                    SendInput, {Control up} ;
                    Sleep, 30 ;
                    Send, { e } ;
                    Break ;
                }
                Else
                {
                    Send, { q } ;
                }
            }
        }
        Sleep, 200 ;
        Stopped = 1;
        Send, {Raw}/ ;
        Sleep 100 ;
        Send, {Raw}sellall ;
        Sleep 300 ;
        Send, {Enter} ;
        Sleep 400 ;
        TimerSell = 0 ;
        Goto, Start ;
    }
return

Cobblex:
    if (Stopped != 1)
    {
        Stopped = 1;
        Send, {Raw}/ ;
        Sleep 100 ;
        Send, {Raw}Cobblex ;
        Sleep 300 ;
        Send, {Enter} ;
        Sleep 500 ;
        TimerCobbleX = 0 ;
        Sleep 100 ;
        Goto, Start ;
    }
return

Repair:
    if (Stopped != 1)
    {
        Stopped = 1;
        Send, {Raw}/ ;
        Sleep 100 ;
        Send, {Raw}Repair ;
        Sleep 300 ;
        Send, {Enter} ;
        Sleep 500 ;
        TimerRepair = 0 ;
        Sleep 300 ;
        Send, {Raw}/ ;
        Sleep 100 ;
        Send, {Raw}heal ;
        Sleep 300 ;
        Send, {Enter} ;
        Sleep 500 ;
        TimerRepair = 0 ;
        Sleep 100 ;
        Goto, Start ;
    }
return

Bloki:
    if (Stopped != 1)
    {
        Stopped = 1;
        Send, {Raw}/ ;
        Sleep 100 ;
        Send, {Raw}bloki ;
        Sleep 300 ;
        Send, {Enter} ;
        Sleep 800 ;
        MouseMove, Pos1x, Pos1y, 50 ;
        Sleep 400 ;
        Click ;
        Sleep 200 ;
        TimerBloki = 0 ;
        Sleep 100 ;
        Goto, Start ;
    }
return

Stop:
    Stopped = 1 ;
return

Update:
    Run https://github.com/BachaBajceps/MinecraftMiner/releases ;
return

SubmitAll:
    Gui, Submit, NoHide ;
    ; Wy??czanie przycisk?w
    if(Tryb ="Obracanie") 
    {
        GuiControl, Disable, SzerokoscTEXT ;
        GuiControl, Disable, DlugoscTEXT ;
    }
    if(Tryb ="Lewo-Prawo") 
    {
        GuiControl, Enable, SzerokoscTEXT ;
        GuiControl, Disable, DlugoscTEXT ;
    }
    if(Tryb ="Kwadrat") 
    {
        GuiControl, Enable, SzerokoscTEXT ;
        GuiControl, Enable, DlugoscTEXT ;
    }
    
    if(MakeCobbleX = 0) 
    {
        GuiControl, Disable, CobbleXTEXT ;
    }
    if(MakeCobbleX = 1) 
    {
        GuiControl, Enable, CobbleXTEXT ;
    }
    
    if(Sell = 0) 
    {
        GuiControl, Disable, SellTEXT ;
    }
    if(Sell = 1) 
    {
        GuiControl, Enable, SellTEXT ;
    }
    
    if(Bloki = 0) 
    {
        GuiControl, Disable, BlokiTEXT ;
    }
    if(Bloki = 1) 
    {
        GuiControl, Enable, BlokiTEXT ;
    }
    
    if(repair = 0) 
    {
        GuiControl, Disable, RepairTEXT ;
    }
    if(repair = 1) 
    {
        GuiControl, Enable, RepairTEXT ;
    }
    
    
    Gui Show ;
    ;FileAppend, %MakeCobbleX% `n, %A_WorkingDir%\AutoMinerConfig.txt ;
Return

Help:
    Gui, 2:+AlwaysOnTop ;
    Gui, 2:+ToolWindow ;
    Gui, 2:Add, Text,, F7 - Wlaczanie ;
    Gui, 2:Add, Text,, F8 - Pauza ;
    Gui, 2:Add, Text,, F9 - Wyjscie ;
    Gui, 2:Show, xCenter yCenter w200 h300, Pomoc ;
return
    

F7::
    Goto, Start ;
return

F8::
    if(Stopped = 0)
    {
        Stopped = 1 ;
    }Else
    {
        Stopped = 0 ;
        Goto, Start ;
    }
return

GuiClose:
ExitApp

F9::ExitApp

