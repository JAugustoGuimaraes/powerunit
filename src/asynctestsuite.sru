HA$PBExportHeader$asynctestsuite.sru
$PBExportComments$Extends test suite to run test cases in an async environment
forward
global type asynctestsuite from testsuite
end type
end forward

global type asynctestsuite from testsuite
event processtest ( )
end type
global asynctestsuite asynctestsuite

type variables
Private TestTimer inv_timer
Private pbunit_Iterator inv_iterator
Private Boolean ib_running
Private Test inv_currentTest
Private TestResult inv_currentResult

end variables

forward prototypes
public subroutine run (testresult anv_result)
end prototypes

event processtest;Test					lnv_emptyTest
pbunit_Iterator	lnv_emptyIterator
Boolean				lb_testFound

inv_timer.stop()

if isValid(inv_currentTest) then
	if inv_currentTest.shouldRerun() then
		lb_testFound = true
	end if
end if

if not lb_testFound then
	lb_testFound = inv_testCollection.iterate_into(inv_iterator, inv_currentTest) 
end if

if lb_testFound then
	inv_currentTest.run(inv_currentResult)
end if

if not lb_testFound or inv_currentResult.shouldStop() then
	inv_currentTest = lnv_emptyTest
	inv_iterator = lnv_emptyIterator
	ib_running = false
else
	inv_timer.start()
end if



end event

public subroutine run (testresult anv_result);
inv_currentResult = anv_result

ib_running = true
inv_timer.start()

do while ib_running
	Yield()
loop

end subroutine

on asynctestsuite.create
TriggerEvent( this, "constructor" )
end on

on asynctestsuite.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;call super::constructor;inv_timer = create TestTimer
inv_timer.initialize(this, "processTest", 1)
end event

