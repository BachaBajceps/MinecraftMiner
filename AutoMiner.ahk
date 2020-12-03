#NoEnv ; 
#SingleInstance force ;
#InstallMouseHook ;
#InstallKeybdHook ;
SendMode Input ;
SetWorkingDir %A_ScriptDir% ;
ListLines Off ;

RotateSpeed := 0 ;

KomendaTimer := [] ;
KomendaTime := [] ;
Komenda := [] ;
KomendaTEXT := [] ;

Tryb := "Obracanie" ;

; --Wstepna deklaracja Komenda
Loop, 8
{ 
    KomendaTimer[A_Index] := 0 ;
    KomendaTime[A_Index] := 0 ;
    Komenda[A_Index] := 0 ;
    KomendaTEXT[A_Index] := "" ;
    KomendaTime%A_Index% := KomendaTime[A_Index] ;
    Komenda%A_Index% := Komenda[A_Index] ;
    KomendaTEXT%A_Index% := KomendaTEXT[A_Index] ;
}

; ---GUI---
Gui, +AlwaysOnTop ;
Gui, +ToolWindow ;

Gui, Add, Tab3,, Generalne|Komendy

; ---Zakladka Generalne---
Gui, Add, Slider, gSubmitAll vRotateSpeed Range-30-30 w170 , 0 ;
Gui, Add, Text, +Center w170 ca1a1a1, Predkosc Obrotu ;

Gui, Add, Text,w70 , Tryb Kopania: ;
Gui, Add, DropDownList, Choose1 vTryb w85 yp x100 gSubmitAll , Obracanie|Lewo-Prawo|Kwadrat ;

Gui, Add, Text, x30 y150 vSzerokoscTEXT, Szerokosc: ;
Gui, Add, Edit, vSzerokosc yp x100 w25 gSubmitAll, 10 ;
Gui, Add, Text, x30 y175 vDlugoscTEXT, Dlugosc: ;
Gui, Add, Edit, vDlugosc yp x100 w25 gSubmitAll, 10 ;

Gui, Add, Button, x20 y250 w90 gStart, Start ;
Gui, Add, Button, yp x110 w90 gStop, Stop ;

Gui, Add, Button, x20 y275 w90 gSave, Zapisz ;
Gui, Add, Button, yp x110 w90 gLoad, Wczytaj ;

Gui, Add, Button, x20 y340 w50 gHelp, Pomoc ;

Gui, Font, s7 ;
Gui, Add, Text, ca1a1a1 +Right w180 , Pajacuwa AutoMiner ;
Gui, Add, Text, ca1a1a1 +Right w180 , Autor Bacha_Bajceps ;
Gui, Font, s9 ;

; ----Zakladka Komendy-----
Gui, Tab, Komendy ;
Gui, Font, s7 ;
Gui, Add, Text, x20 y35 ca1a1a1, Wl? ;
Gui, Add, Text, x70 y35 ca1a1a1, Komenda ;
Gui, Add, Text, x170 y35 ca1a1a1, Czas ;

Loop, 8
{
    y_pos := % 35 + A_Index*25 ;
    Gui, Add, Checkbox, x20 y%y_pos% vKomenda%A_Index% gSubmitAll ;
    Gui, Add, Edit, yp x50 -Wrap h15 w100 vKomendaTEXT%A_Index% gSubmitAll, %KomendaTEXT% ;
    Gui, Add, Edit, yp x160 -Wrap Number h15 w40 vKomendaTime%A_Index% gSubmitAll, %KomendaTime1% ;  
}

; ----Okno Pomocy----
Gui, 2: +AlwaysOnTop ;
Gui, 2: +ToolWindow ;
Gui, 2:Add, Text,, F7 - Wlaczanie ;
Gui, 2:Add, Text,, F8 - Pauza ;
Gui, 2:Add, Text,, F9 - Wyjscie ;


Gui, Show, xCenter yCenter AutoSize , Pajacuwa AutoMiner ;
Goto, SubmitAll ;

; ---Logika---

Start:

    Stopped := 0 ;
    Click down ;
    While, Stopped != 1 ;
    {
        ; ---Komendy---
        For i, timer in KomendaTimer
        {
            if(timer > (KomendaTime[i]*100) && Komenda[i] = 1)
            {
                Komenda(KomendaTEXT[i]) ;
                KomendaTimer[i] := 0 ;
            }
        }
        Kop(Tryb,KomendaTimer,Szerokosc,Dlugosc,RotateSpeed) ;
    }
return

Kop(tryb,KomendaTimer,Szerokosc,Dlugosc,RotateSpeed)
{
    ; ----Tryby Kopania----
    Switch tryb
    {
    Case "Obracanie":
        MouseMove, RotateSpeed,0, 100, R ;
        Sleep, 10 ;
        For i, x in KomendaTimer
        {
            KomendaTimer[i] += 1 ;
        }
    return

    Case "Lewo-Prawo":
        Send, {a down} ; 
        Sleep, Szerokosc*200 ;
        Send, {a up} ; 
        Sleep 50 ;
        Send, {d down} ; 
        Sleep, Szerokosc*200 ;
        Send, {d up} ; 
        Sleep 50 ;
        For i, x in KomendaTimer
        {
            KomendaTimer[i] += 100 ;
        }
    return

    Case "Kwadrat":
        Send, {a down} ;
        Sleep, Szerokosc*200 ;
        Send, {a up} ;
        Sleep 50 ;
        Send, {w down} ;
        Sleep, Dlugosc*200 ;
        Send, {w up} ;
        Sleep 50 ;
        Send, {d down} ;
        Sleep, Szerokosc*200 ;
        Send, {d up} ;
        Sleep 50 ;
        Send, {s down} ;
        Sleep, Dlugosc*200 ;
        Send, {s up} ;
        Sleep 50 ;
        For i, x in KomendaTimer
        {
            KomendaTimer[i] += 200 ;
        }
    return
}
return
}
;   ----Wpisywanie Komend----
Komenda(KomendaTEXT)
{
    Click up ;
    Send, {Raw}/ ;
    Sleep 100 ;
    Send, % KomendaTEXT ;
    Sleep 300 ;
    Send, {Enter} ;
    Sleep 300 ;
    Click down ;
return
}

Stop:
    Stopped := 1 ;
return

SubmitAll:
    Gui, Submit, NoHide ;
    ;  ----Wyloczanie przyciskow----
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
    Loop, 8
    {
        Komenda[A_Index] := Komenda%A_Index% ;
        KomendaTEXT[A_Index] := KomendaTEXT%A_Index% ;
        KomendaTime[A_Index] := KomendaTime%A_Index% ;
    }
    Gui Show ;
Return

Help:
    Gui, 2:Show, xCenter yCenter w200 h300, Pomoc ;
return
;    ----Zapisywanie do pliku Config.ini
Save:
    For i, value in KomendaTime{
        IniWrite,% value, %A_WorkingDir%\Config.ini, KomendaTime, KomendaTime%i% ;
    }
    For i, value in Komenda{
        IniWrite,% value, %A_WorkingDir%\Config.ini, Komenda, Komenda%i% ;
    }
    For i, value in KomendaTEXT{
        IniWrite,% value, %A_WorkingDir%\Config.ini, KomendaTEXT, KomendaTEXT%i% ;
    }
    IniWrite, %Szerokosc%, %A_WorkingDir%\Config.ini, Inne, Szerokosc ;
    IniWrite, %Dlugosc%, %A_WorkingDir%\Config.ini, Inne, Dlugosc ;
    IniWrite, %RotateSpeed%, %A_WorkingDir%\Config.ini, Inne, RotateSpeed ;
return
;       ---Ladowanie zmiennych z pliku---
Load:
    For i, value in KomendaTime{
        IniRead, variable, %A_WorkingDir%\Config.ini, KomendaTime, KomendaTime%i% ;
        KomendaTime[i] := variable ;
    }
    For i, value in Komenda{
        IniRead, variable, %A_WorkingDir%\Config.ini, Komenda, Komenda%i% ;
        Komenda[i] := variable ;
    }
    For i, value in KomendaTEXT{
        IniRead, variable, %A_WorkingDir%\Config.ini, KomendaTEXT, KomendaTEXT%i% ;
        KomendaTEXT[i] := variable ;
    }
    IniRead, Szerokosc, %A_WorkingDir%\Config.ini, Inne, Szerokosc ;
    IniRead, Dlugosc, %A_WorkingDir%\Config.ini, Inne, Dlugosc ;
    IniRead, RotateSpeed, %A_WorkingDir%\Config.ini, Inne, RotateSpeed ;

    ; ----Aktualizowanie elementow gui----
    For i, value in KomendaTime{
        GuiControl,, KomendaTime%i%,% value ;
    }
    For i, value in Komenda{
        GuiControl,, Komenda%i%,% value ;
    }
    For i, value in KomendaTEXT{
        GuiControl,, KomendaTEXT%i%,% value ;
    }

    GuiControl,, Szerokosc, %Szerokosc% ;
    GuiControl,, Dlugosc, %Dlugosc% ;
    GuiControl,, RotateSpeed, %RotateSpeed% ;

    MsgBox, , Wczytano!, Ustawienia wczytane!, 1
return

F7::
    Goto, Start ;
return

F8::
    if(Stopped = 0)
    {
        Stopped := 1 ;
    }Else
    {
        Stopped := 0 ;
        Goto, Start ;
    }
return

F9::ExitApp

GuiClose:
ExitApp