$regfile = "m32def.dat"
$crystal = 8000000
$baud = 9600
'Enable Interrupts


Config Timer1 = Pwm , Pwm = 8 , Prescale = 64 , Compare A Pwm = Clear Up , Compare B Pwm = Clear Up
Config Portd.6 = Output

Config Timer0 = Timer0 , Prescale = 1024
Config Portb.4 = Output
Config Pina.5 = Input
Config Portb.0 = Output
Config Pinb.1 = Input
Config Portb.2 = Output
Config Pinb.3 = Input

Triger1 Alias Portb.4                                       'trigger
Echo1 Alias Pina.5                                          'aktif srf04
Triger2 Alias Portb.0                                       'trigger
Echo2 Alias Pinb.1
Triger3 Alias Portb.2                                       'trigger
Echo3 Alias Pinb.3

Declare Sub Cek_jarak_kanan
Declare Sub Cek_jarak_depan
Declare Sub Cek_jarak_kiri

Dim Data_jarak As Word , Data_jarak2 As Word , Data_jarak3 As Word
Dim Data_jarak_olah As Word , Data_jarak_olah2 As Word , Data_jarak_olah3 As Word
Dim Data_jarak_fix As Word , Data_jarak_fix2 As Word , Data_jarak_fix3 As Word
Dim Pv As Integer , Kp As Integer , Eror As Integer , Maju As Integer , P As Integer,



Print "assalamualaikum"

 'ECHO1=KANAN
 'ECHO2=DEPAN
 'ECHO3=KIRI

   'Pwm1a = 255                                              'KANAN
   'Pwm1b = 255                                              'KIRI
   Portd.6 = 0

   Kp = 50
   Maju = 0


Do

   Pwm1a = 255
   Pwm1b = 255

Loop

Do

   Call Cek_jarak_depan
   Call Cek_jarak_kanan
   Call Cek_jarak_kiri
   Data_jarak_olah = Data_jarak * 100
   Data_jarak_fix = Data_jarak_olah / 256

   Data_jarak_olah2 = Data_jarak2 * 100
   Data_jarak_fix2 = Data_jarak_olah2 / 256

   Data_jarak_olah3 = Data_jarak3 * 100
   Data_jarak_fix3 = Data_jarak_olah3 / 256












   Print Data_jarak_fix3 ; "  " ; Data_jarak_fix2 ; "  " ; Data_jarak_fix

   Waitms 50

Loop










Sub Cek_jarak_kanan:
    Reset Triger1
    Waitus 10
    Set Triger1
    Waitus 20
    Reset Triger1

    Tcnt0 = 0
    Bitwait Echo1 , Set
    Start Timer0

    Do
      If Echo1 = 0 Then
          Data_jarak = Tcnt0
          Stop Timer0
          Exit Do
      End If

      If Tifr.0 = 1 Then
         Stop Timer0
         Tifr.0 = 1
         Data_jarak = &HFF
         Exit Do
      End If
    Loop
    Stop Timer0
    Waitms 15
End Sub

Sub Cek_jarak_depan:
    Reset Triger2
    Waitus 10
    Set Triger2
    Waitus 20
    Reset Triger2

    Tcnt0 = 0
    Bitwait Echo2 , Set
    Start Timer0

    Do
      If Echo2 = 0 Then
          Data_jarak2 = Tcnt0
          Stop Timer0
          Exit Do
      End If

      If Tifr.0 = 1 Then
         Stop Timer0
         Tifr.0 = 1
         Data_jarak2 = &HFF
         Exit Do
      End If
    Loop
    Stop Timer0
    Waitms 15
End Sub

Sub Cek_jarak_kiri:
    Reset Triger3
    Waitus 10
    Set Triger3
    Waitus 20
    Reset Triger3

    Tcnt0 = 0
    Bitwait Echo3 , Set
    Start Timer0

    Do
      If Echo3 = 0 Then
          Data_jarak3 = Tcnt0
          Stop Timer0
          Exit Do
      End If

      If Tifr.0 = 1 Then
         Stop Timer0
         Tifr.0 = 1
         Data_jarak3 = &HFF
         Exit Do
      End If
    Loop
    Stop Timer0
    Waitms 15
End Sub


















