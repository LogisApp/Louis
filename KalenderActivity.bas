B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=7.3
@EndOfDesignText@
#Region Module Attributes
	#FullScreen: False
	#IncludeTitle: True
#End Region

'Activity module
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
    
	'TimeValue holds a random day in the month to be displayed
	'On start, this must be set accordingly to which month to be displayed
	'In this demo it is set to DateTime.Now which is todays date
	'and the calendar shows the current month
	Dim TimeValue As Long
	
	Dim FirstDayOfMonth As Long
	Dim LastDayOfMonth As Long 
    Dim Day(7) As String
    Dim Month(12) As String
	Dim DaySelected As Long 'Return value to the calling Activity
	Dim FirstDayOfWeek As Int
	
	DaySelected = 0

End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	Dim Panel1 As Panel
	Dim Label1 As Label
	Dim Label4 As Label
	Dim Label5 As Label
	Dim Label6 As Label
	Dim Label7 As Label
	Dim Label8 As Label
	Dim Label9 As Label
	Dim Label10 As Label
	Dim Label2 As Label
	Dim NextMonth As Button
	Dim PrevMonth As Button
	Dim Cancel As Button
	Dim CurrentMonth As Button
End Sub

Sub Activity_Create(FirstTime As Boolean)
 Dim lv As LayoutValues
 lv = GetDeviceLayoutValues
 Dim i As Int 
 
 'Set which day is the first day of the week
 '0 = Sunday
 '1 = Monday
 FirstDayOfWeek = 1
 
 If FirstTime Then
  'Change according to your language
  Day(0) = "Do"
  Day(1) = "Lu"
  Day(2) = "Ma"
  Day(3) = "Mi"
  Day(4) = "Ju"
  Day(5) = "Vi"
  Day(6) = "Sa"
  Month(0) = "Enero"
  Month(1) = "Febrero"
  Month(2) = "Marzo"
  Month(3) = "Abril"
  Month(4) = "Mayo"
  Month(5) = "Junio"
  Month(6) = "Julio"
  Month(7) = "Agosto"
  Month(8) = "Septiembre"
  Month(9) = "Octubre"
  Month(10) = "Noviembre"
  Month(11) = "Diciembre"
 End If
 DaySelected = 0
 TimeValue = DateTime.Now 
 Activity.LoadLayout("Kalender")	
 Activity.Title = "Elije Dia " & DateTime.Date(TimeValue)
 Panel1.Height = 340 * lv.Scale 
 Panel1.Left = (100%x - Panel1.Width) / 2
 If FirstDayOfWeek = 1 Then
  Label4.Text = Day(1)
  Label5.Text = Day(2)
  Label6.Text = Day(3)
  Label7.Text = Day(4)
  Label8.Text = Day(5)
  Label9.Text = Day(6)
  Label10.Text = Day(0)
 Else
  Label4.Text = Day(0)
  Label5.Text = Day(1)
  Label6.Text = Day(2)
  Label7.Text = Day(3)
  Label8.Text = Day(4)
  Label9.Text = Day(5)
  Label10.Text = Day(6)
 End If
 Label4.Width = -2
 Label5.Width = -2
 Label6.Width = -2
 Label7.Width = -2
 Label8.Width = -2
 Label9.Width = -2
 Label10.Width = -2
 DoEvents
 i = 10 * lv.Scale 
 Label4.Left = i + (7 * lv.Scale)
 i = i + (40 * lv.Scale)
 Label5.Left = i + (7 * lv.Scale)
 i = i + (40 * lv.Scale)
 Label6.Left = i + (7 * lv.Scale)
 i = i + (40 * lv.Scale)
 Label7.Left = i + (7 * lv.Scale)
 i = i + (40 * lv.Scale)
 Label8.Left = i + (7 * lv.Scale) 
 i = i + (40 * lv.Scale)
 Label9.Left = i + (7 * lv.Scale) 
 i = i + (40 * lv.Scale)
 Label10.Left = i + (7 * lv.Scale) 
 Cancel.Top = Panel1.Top + Panel1.Height + (15 * lv.Scale)
 CurrentMonth.Top = Panel1.Top + Panel1.Height + (15 * lv.Scale)
 Cancel.Left = (100%x / 2) - (Cancel.Width + CurrentMonth.Width + 15) / 2 
 CurrentMonth.Left = Cancel.Left + Cancel.Width + 15
 CreateCalendar
 
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub CreateCalendar
 Dim i As Int
 Dim OffsetX As Int
 Dim OffsetY As Int
 Dim TempDay As Long 
 Dim StartDate As Long
 Dim EndDate As Long 
 Dim bDay As Long
 Dim Today As Long 
 Dim lv As LayoutValues
 lv = GetDeviceLayoutValues

 Today = DateTime.Now 
'-- DateTime.DateFormat="ddMMyyyy"
 DateTime.DateFormat="MMddyyyy"
 'Calculate the first day of the month according
' Msgbox(DateTime.Date(Today),"")
'-- FirstDayOfMonth = DateTime.DateParse("01" & DateTime.Date(TimeValue).SubString2(3))
 FirstDayOfMonth = DateTime.DateParse(DateTime.Date(TimeValue).SubString2(0,2) & "01" & DateTime.GetYear(Today) )
'--Msgbox(DateTime.Date(FirstDayOfMonth),"")
 'Calculate the last day of the month
 TempDay = DateTime.Add(TimeValue,0,0,1)
'--Msgbox(DateTime.Date(TempDay),"")
 TempDay = DateTime.DateParse(DateTime.Date(TempDay).SubString2(0,2) & "01" & DateTime.GetYear(TempDay))
 TempDay = DateTime.Add(TempDay,0,1,0)
'-Msgbox(DateTime.Date(TempDay),"")
 LastDayOfMonth = DateTime.Add(TempDay,0,0,-1)
'-Msgbox(DateTime.Date(LastDayOfMonth),"")
 
 
 Label1.Text = Month(DateTime.GetMonth(TimeValue) - 1) & "  " & DateTime.GetYear(TimeValue)
 OffsetX = 10 * lv.Scale
 OffsetY = 70 * lv.Scale
 
 'Calculate the first day to be displayed in the calendar
 If FirstDayOfWeek = 1 Then
  If (DateTime.GetDayOfWeek(FirstDayOfMonth) - 1) = 0 Then
   StartDate = DateTime.Add(FirstDayOfMonth,0,0,-6)
  Else
   StartDate = DateTime.Add(FirstDayOfMonth,0,0, 0-(DateTime.GetDayOfWeek(FirstDayOfMonth) - 2))
  End If
 Else
  StartDate = DateTime.Add(FirstDayOfMonth,0,0, 0-(DateTime.GetDayOfWeek(FirstDayOfMonth) - 1))
 End If
 
 bDay = StartDate
 
 'Calculate the last day to be displayed in the calendar
 If FirstDayOfWeek = 1 Then
  If (DateTime.GetDayOfWeek(LastDayOfMonth) - 1) = 0 Then
   EndDate = LastDayOfMonth
  Else
   EndDate = DateTime.Add(LastDayOfMonth,0,0, 8 - DateTime.GetDayOfWeek(LastDayOfMonth))
  End If  
 Else
  EndDate = DateTime.Add(LastDayOfMonth,0,0, 7 - DateTime.GetDayOfWeek(LastDayOfMonth))
 End If
 
 'Place a button for each day to be displayed.
 'Days in the previous and next month are grayed out and cannot be selected
 'Todays date is shown with a red bold text
 'Each buttons tag holds the day of the button
 For i = 1 To 42
  If bDay <= EndDate Then
   Dim bn As Button 
   bn.Initialize("ButtonPress")
   bn.Text = DateTime.GetDayOfMonth(bDay)
   If DateTime.GetMonth(bDay) <> DateTime.GetMonth(TimeValue) Then
	bn.Enabled = False
	bn.Tag = 0
   Else
	bn.Enabled = True
	bn.Tag = bDay
   End If
   If DateTime.Date(bDay) = DateTime.Date(Today)  Then
    bn.TextColor = Colors.Red 
	bn.Typeface = Typeface.DEFAULT_BOLD 
   End If
   'All buttons are placed on a panel
   Panel1.AddView(bn, OffsetX, OffsetY, 40 * lv.Scale, 40 * lv.Scale)
   OffsetX = OffsetX + (40 * lv.Scale)
   If OffsetX > (250 * lv.Scale) Then
    OffsetX = 10 * lv.Scale
    OffsetY = OffsetY + (40 * lv.Scale)
   End If
   bDay = DateTime.Add(bDay,0,0,1)
  End If
 Next

End Sub

Sub RemovePanelViews
 Dim i As Int
 Dim v As View 
 Dim ii As Long 
 
  For i=Panel1.NumberOfViews-1 To 0 Step -1
  v = Panel1.GetView(i)
  Try
  ii = v.Tag
  If ii >= 0 Then
   Panel1.RemoveViewAt(i)
  End If
  Catch
  End Try
 Next
End Sub

Sub ButtonPress_Click
 'Update DaySelected with the selected day and return to the calling activity
 Dim b As Button 
 b = Sender
 DaySelected = b.Tag 
 Activity.Finish 
 StartActivity(Main)		
End Sub

Sub PrevMonth_Click
 'Show previous month
 RemovePanelViews	
 TimeValue = DateTime.Add(FirstDayOfMonth,0,-1,0)
 CreateCalendar	
End Sub

Sub NextMonth_Click
 'Show next month
 RemovePanelViews 	
 TimeValue = DateTime.Add(FirstDayOfMonth,0,1,0)
 CreateCalendar	
End Sub
Sub CurrentMonth_Click
 'Show current month
 RemovePanelViews	
 TimeValue = DateTime.Now 	
 CreateCalendar	
End Sub
Sub Cancel_Click
 'Return to calling activity without selecting a day
 Activity.Finish 
 StartActivity(Main)			
End Sub