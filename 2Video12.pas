// E_Set_Ramp			E_Max_Rpm
// CycleTime			Step
// Ref_Rpm
// Hizlan ,,, Yavasla
// E_Max_Rpm - step = E_Max_Rpm_Minus
Stepp:=(E_Max_Rpm * CycleTime) /(E_Set_Ramp*REAL#1000.0);
Max_Rpm_Minus:=E_Max_Rpm-Stepp;
