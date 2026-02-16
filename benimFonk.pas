(* 
   RUNG 0
   EnableIn -> EnableOut
*)
EnableOut := EnableIn;


(* 
   RUNG 1
   Pulse YÜKSELENKENAR-edge yakala ve Sayici artır
   (Filtreleme_Start TRUE iken)
*)
Pulse_edge := Pulse AND NOT Pulse_prev;
Pulse_prev := Pulse;

IF Filtreleme_Start AND Pulse_edge THEN
    Sayici := Sayici + INT#1;
END_IF;


(* 
   RUNG 2–6 (Optimize)
   Sayici değiştiğinde (Up mantığı gibi tek sefer) ve 1..5 aralığındaysa
   AnalogArry[Sayici] := AnalogInput
 *)
IF NOT InitDone THEN
    Sayici_chg := FALSE;        (* ilk task'ta tetik üretme *)
    Sayici_prev := Sayici;      (* başlangıç referansı *)
    InitDone := TRUE;
ELSE
    Sayici_chg := (Sayici <> Sayici_prev);
    Sayici_prev := Sayici;
END_IF;

IF Sayici_chg AND (Sayici >= INT#1) AND (Sayici <= INT#5) THEN
    AnalogArry[Sayici] := AnalogInput;

    (* 
       RUNG 6 içindeki AryMean
 *)
    IF Sayici = INT#5 THEN
        AverageValue :=
            (AnalogArry[1] + AnalogArry[2] + AnalogArry[3] + AnalogArry[4] + AnalogArry[5]) / REAL#5.0;
    END_IF;
END_IF;


(* 
   RUNG 7
   Sayici > 5 olunca Sayici'yi 1'e çek
   (Ladder'da Up+MOVE var; burada wrap mantığıyla aynı sonucu verir)
 *)
IF Sayici > INT#5 THEN
    Sayici := INT#1;
END_IF;
