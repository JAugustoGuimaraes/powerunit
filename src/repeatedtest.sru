HA$PBExportHeader$repeatedtest.sru
$PBExportComments$A Decorator that runs a test repeatedly.
forward
global type repeatedtest from testdecorator
end type
end forward

global type repeatedtest from testdecorator
end type
global repeatedtest repeatedtest

type variables
Protected Integer ii_timesToRepeat
end variables

forward prototypes
public subroutine initialize (test anv_test, integer ai_timestorepeat)
public function integer counttestcases ()
public function string tostring ()
public subroutine run (TestResult anv_result)
end prototypes

public subroutine initialize (test anv_test, integer ai_timestorepeat);initialize(anv_test)
ii_timesToRepeat = ai_timesToRepeat
end subroutine

public function integer counttestcases ();return super::countTestCases() * ii_timesToRepeat
end function

public function string tostring ();return super::toString() + " (repeated " + string(ii_timesToRepeat) + " times)"
end function

public subroutine run (TestResult anv_result);Integer	li

for li = 1 to ii_timesToRepeat
	if anv_result.shouldStop() then
		return
	end if
	super::run(anv_result)
next

end subroutine

on repeatedtest.create
TriggerEvent( this, "constructor" )
end on

on repeatedtest.destroy
TriggerEvent( this, "destructor" )
end on

