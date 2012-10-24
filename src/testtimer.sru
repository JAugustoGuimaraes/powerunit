HA$PBExportHeader$testtimer.sru
$PBExportComments$Trigger an event at a specific interval
forward
global type testtimer from timing
end type
end forward

global type testtimer from timing
end type
global testtimer testtimer

type variables
Private String is_eventName
Private PowerObject ipo_eventSubject
Private Integer ii_interval
end variables

forward prototypes
public subroutine initialize (PowerObject apo_eventSubject, String as_eventName, Integer ai_interval)
public function integer start ()
end prototypes

public subroutine initialize (PowerObject apo_eventSubject, String as_eventName, Integer ai_interval);
ipo_eventSubject = apo_eventSubject
is_eventName = as_eventName
ii_interval = ai_interval
end subroutine

public function integer start ();return start(ii_interval)
end function

on testtimer.create
call timing::create
TriggerEvent( this, "constructor" )
end on

on testtimer.destroy
call timing::destroy
TriggerEvent( this, "destructor" )
end on

event timer;
if isValid(ipo_eventSubject) then
	ipo_eventSubject.triggerEvent(is_eventName)
else
	stop()
end if

end event

