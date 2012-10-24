HA$PBExportHeader$testsetup.sru
$PBExportComments$A Decorator to set up and tear down additional fixture state.  Subclass TestSetup and insert it into your tests when you want to set up additional state once before the tests are run.
forward
global type testsetup from testdecorator
end type
end forward

global type testsetup from testdecorator
event setup ( )
event teardown ( )
end type
global testsetup testsetup

forward prototypes
public subroutine run (TestResult anv_result)
end prototypes

public subroutine run (TestResult anv_result);this.event setUp()
super::run(anv_result)
this.event tearDown()
end subroutine

on testsetup.create
TriggerEvent( this, "constructor" )
end on

on testsetup.destroy
TriggerEvent( this, "destructor" )
end on

