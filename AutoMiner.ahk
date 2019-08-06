#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance force ;
#InstallMouseHook ;
#InstallKeybdHook ;
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2 ;

Emerald = 0 ;

RotateSpeed = 0 ;

Komenda1Timer = 0 ;
Komenda2Timer = 0 ;
Komenda3Timer = 0 ;
Komenda4Timer = 0 ;
Komenda5Timer = 0 ;
Komenda6Timer = 0 ;
Komenda7Timer = 0 ;

Komenda1Time = 0 ;
Komenda2Time = 0 ;
Komenda3Time = 0 ;
Komenda4Time = 0 ;
Komenda5Time = 0 ;
Komenda6Time = 0 ;
Komenda7Time = 0 ;

Komenda1 = 0 ;
Komenda2 = 0 ;
Komenda3 = 0 ;
Komenda4 = 0 ;
Komenda5 = 0 ;
Komenda6 = 0 ;
Komenda7 = 0 ;

Komenda1TEXT = 0 ;
Komenda2TEXT = 0 ;
Komenda3TEXT = 0 ;
Komenda4TEXT = 0 ;
Komenda5TEXT = 0 ;
Komenda6TEXT = 0 ;
Komenda7TEXT = 0 ;

Tryb = "Obracanie" ;

; ---GUI---
Gui,+AlwaysOnTop ;
Gui, +ToolWindow ;

Gui, Add, Tab3,, Generalne|Komendy

; ---Generalne---
Gui, Add, Checkbox, vEmerald gSubmitAll, Wyrzucanie Emeradow ;
Gui, Add, Slider, gSubmitAll vRotateSpeed Range-20-20 w170 , 0 ;
Gui, Add, Text, +Center w170 ca1a1a1, Predkosc Obrotu ;

Gui, Add, Text,w70 , Tryb Kopania: ;
Gui, Add, DropDownList, Choose1 vTryb w85 yp x100 gSubmitAll , Obracanie|Lewo-Prawo|Kwadrat ;

Gui, Add, Text, x30 y150 vSzerokoscTEXT, Szerokosc: ;
Gui, Add, Edit, vSzerokosc yp x100 w25 gSubmitAll, 10 ;
Gui, Add, Text, x30 y175 vDlugoscTEXT, Dlugosc: ;
Gui, Add, Edit, vDlugosc yp x100 w25 gSubmitAll, 10 ;

Gui, Add, Button, x20 w180 y210 gPos1, Pozycja1 ;

Gui, Add, Button, x20 y250 w90 gStart, Start ;
Gui, Add, Button, yp x110 w90 gStop, Stop ;

Gui, Add, Button, x20 y275 w90 gSave, Zapisz ;
Gui, Add, Button, yp x110 w90 gLoad, Wczytaj ;

Gui, Add, Button, x20 y305 w180 gUpdate, Aktualizuj ;
Gui, Add, Button, x15 y340 w40 gHelp, Pomoc ;

Gui, Font, s7 ;
Gui, Add, Text, ca1a1a1 +Right w180 , Pajacuwa AutoMiner ;
Gui, Add, Text, ca1a1a1 +Right w180 , Autor Bacha_Bajceps ;
Gui, Font, s9 ;

; ----Komendy-----
Gui, Tab, Komendy ;
Gui, Font, s7 ;
Gui, Add, Text, x20 y35 ca1a1a1, Wl? ;
Gui, Add, Text, x70 y35 ca1a1a1, Komenda ;
Gui, Add, Text, x170 y35 ca1a1a1, Czas ;

Gui, Add, Checkbox, x20 y55 vKomenda1 gSubmitAll
Gui, Add, Edit, yp x50 -Wrap h15 w100 vKomenda1TEXT gSubmitAll, cobblex ;
Gui, Add, Edit, yp x160 -Wrap Number h15 w40 vKomenda1Time gSubmitAll, %Komenda1Time% ;

Gui, Add, Checkbox, x20 y75 vKomenda2 gSubmitAll
Gui, Add, Edit, yp x50 -Wrap h15 w100 vKomenda2TEXT gSubmitAll, sellall ;
Gui, Add, Edit, yp x160 -Wrap Number h15 w40 vKomenda2Time gSubmitAll, %Komenda2Time% ;

Gui, Add, Checkbox, x20 y95 vKomenda3 gSubmitAll
Gui, Add, Edit, yp x50 -Wrap h15 w100 vKomenda3TEXT  gSubmitAll, ;
Gui, Add, Edit, yp x160 -Wrap Number h15 w40 vKomenda3Time gSubmitAll, %Komenda3Time% ;

Gui, Add, Checkbox, x20 y115 vKomenda4 gSubmitAll
Gui, Add, Edit, yp x50 -Wrap h15 w100 vKomenda4TEXT  gSubmitAll, ;
Gui, Add, Edit, yp x160 -Wrap Number h15 w40 vKomenda4Time gSubmitAll, %Komenda4Time% ;

Gui, Add, Checkbox, x20 y135 vKomenda5 gSubmitAll
Gui, Add, Edit, yp x50 -Wrap h15 w100 vKomenda5TEXT gSubmitAll, ;
Gui, Add, Edit, yp x160 -Wrap Number h15 w40 vKomenda5Time gSubmitAll, %Komenda5Time% ;

Gui, Add, Checkbox, x20 y155 vKomenda6 gSubmitAll
Gui, Add, Edit, yp x50 -Wrap h15 w100 vKomenda6TEXT  gSubmitAll, ;
Gui, Add, Edit, yp x160 -Wrap Number h15 w40 vKomenda6Time gSubmitAll, %Komenda6Time% ;

Gui, Add, Checkbox, x20 y175 vKomenda7 gSubmitAll
Gui, Add, Edit, yp x50 -Wrap h15 w100 vKomenda7TEXT  gSubmitAll, ;
Gui, Add, Edit, yp x160 -Wrap Number h15 w40 vKomenda7Time gSubmitAll, %Komenda7Time% ;



Gui, Show, xCenter yCenter AutoSize , Pajacuwa  AutoMiner ;

; id minecraftow
Winget, id, list, Minecraft

Goto, SubmitAll ;
return

; ---Funkcje---

Start:
    Stopped = 0 ;
    Click down ;
    While, Stopped != 1 ;
    {
        ; ---Przekierowania---
        
        if(Komenda1Timer > (Komenda1Time*100) && Komenda1 = 1)
        {
            Goto, Komenda1 ;
        }
        
        if(Komenda2Timer > (Komenda2Time*100) && Komenda2 = 1)
        {
            Goto, Komenda2 ;
        }
        
        if(Komenda3Timer > (Komenda3Time*100) && Komenda3 = 1)
        {
            Goto, Komenda3 ;
        }
        
        if(Komenda4Timer > (Komenda4Time*100) && Komenda4 = 1)
        {
            Goto, Komenda4 ;
        }
        
        if(Komenda5Timer > (Komenda5Time*100) && Komenda5 = 1)
        {
            Goto, Komenda5 ;
        }
        
        if(Komenda6Timer > (Komenda6Time*100) && Komenda6 = 1)
        {
            Goto, Komenda6 ;
        }
        
        if(Komenda7Timer > (Komenda7Time*100) && Komenda7 = 1)
        {
            Goto, Komenda7 ;
        }
        
        ; Tryby Kopania
        if (Tryb = "Obracanie") ; Tryb Obracanie
        {
            MouseMove, RotateSpeed,0, 100, R ;
            Sleep, 10 ;
            Komenda1Timer++ ;
            Komenda2Timer++ ;
            Komenda3Timer++ ;
            Komenda4Timer++ ;
            Komenda5Timer++ ;
            Komenda6Timer++ ;
            Komenda7Timer++ ;
        }
        
        if (Tryb = "Lewo-Prawo") ; Tryb Lewo-Prawo
        {
            Click down ;
            Send, {a down} ; 
            Sleep, Szerokosc*100 ;
            Send, {a up} ; 
            Sleep 50 ;
            Send, {d down} ; 
            Sleep, Szerokosc*100 ;
            Send, {d up} ; 
            Sleep 50 ;
            Komenda1Timer += 20 ;
            Komenda2Timer += 20 ;
            Komenda3Timer += 20 ;
            Komenda4Timer += 20 ;
            Komenda5Timer += 20 ;
            Komenda6Timer += 20 ;
            Komenda7Timer += 20 ;
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
            Komenda1Timer += 40 ;
            Komenda2Timer += 40 ;
            Komenda3Timer += 40 ;
            Komenda4Timer += 40 ;
            Komenda5Timer += 40 ;
            Komenda6Timer += 40 ;
            Komenda7Timer += 40 ;
        }
    }
    
return

Pos1:
    Sleep 100 ;
    KeyWait, LButton, D
    MouseGetPos, Pos1x, Pos1y ;
    MsgBox, , Pozycja1, Pozycja pierwsza zostala zapisana %Pos1x% %Pos1y%, 2 ;
return

Komenda1:
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
        Stopped = 1;
        Send, {Raw}/ ;
        Sleep 100 ;
        Send, {Raw}%Komenda1TEXT% ;
        Sleep 300 ;
        Send, {Enter} ;
        Sleep 500 ;
        Komenda1Timer = 0 ;
        Sleep 100 ;
        Goto, Start ;
    }
return

Komenda2:
    if (Stopped != 1)
    {
        Stopped = 1;
        Send, {Raw}/ ;
        Sleep 100 ;
        Send, {Raw}%Komenda2TEXT% ;
        Sleep 300 ;
        Send, {Enter} ;
        Sleep 500 ;
        Komenda2Timer = 0 ;
        Sleep 100 ;
        Goto, Start ;
    }
return

Komenda3:
    if (Stopped != 1)
    {
        Stopped = 1;
        Send, {Raw}/ ;
        Sleep 100 ;
        Send, {Raw}%Komenda3TEXT% ;
        Sleep 300 ;
        Send, {Enter} ;
        Sleep 500 ;
        Komenda3Timer = 0 ;
        Sleep 100 ;
        Goto, Start ;
    }
return

Komenda4:
    if (Stopped != 1)
    {
        Stopped = 1;
        Send, {Raw}/ ;
        Sleep 100 ;
        Send, {Raw}%Komenda4TEXT% ;
        Sleep 300 ;
        Send, {Enter} ;
        Sleep 500 ;
        Komenda4Timer = 0 ;
        Sleep 100 ;
        Goto, Start ;
    }
return

Komenda5:
    if (Stopped != 1)
    {
        Stopped = 1;
        Send, {Raw}/ ;
        Sleep 100 ;
        Send, {Raw}%Komenda5TEXT% ;
        Sleep 300 ;
        Send, {Enter} ;
        Sleep 500 ;
        Komenda5Timer = 0 ;
        Sleep 100 ;
        Goto, Start ;
    }
return

Komenda6:
    if (Stopped != 1)
    {
        Stopped = 1;
        Send, {Raw}/ ;
        Sleep 100 ;
        Send, {Raw}%Komenda6TEXT% ;
        Sleep 300 ;
        Send, {Enter} ;
        Sleep 500 ;
        Komenda6Timer = 0 ;
        Sleep 100 ;
        Goto, Start ;
    }
return

Komenda7:
    if (Stopped != 1)
    {
        Stopped = 1;
        Send, {Raw}/ ;
        Sleep 100 ;
        Send, {Raw}%Komenda7TEXT% ;
        Sleep 300 ;
        Send, {Enter} ;
        Sleep 500 ;
        Komenda7Timer = 0 ;
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
    
Save:
FileDelete Config.txt ;
FileAppend,  ; The comma is required in this case.
(
    %Komenda1Time%
    %Komenda2Time%
    %Komenda3Time%
    %Komenda4Time%
    %Komenda5Time%
    %Komenda6Time%
    %Komenda7Time%
), Config.txt
return

Load:
FileReadLine, Komenda1Time, Config.txt, 1 ;
FileReadLine, Komenda2Time, Config.txt, 2 ;
FileReadLine, Komenda3Time, Config.txt, 3 ;
FileReadLine, Komenda4Time, Config.txt, 4 ;
FileReadLine, Komenda5Time, Config.txt, 5 ;
FileReadLine, Komenda6Time, Config.txt, 6 ;
FileReadLine, Komenda7Time, Config.txt, 7 ;

GuiControl,, Komenda1Time, %Komenda1Time% ;
GuiControl,, Komenda2Time, %Komenda2Time% ;
GuiControl,, Komenda3Time, %Komenda3Time% ;
GuiControl,, Komenda4Time, %Komenda4Time% ;
GuiControl,, Komenda5Time, %Komenda5Time% ;
GuiControl,, Komenda6Time, %Komenda6Time% ;
GuiControl,, Komenda7Time, %Komenda7Time% ;

MsgBox, , Zaladowano, Ustawienia wczytane!, 1
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

