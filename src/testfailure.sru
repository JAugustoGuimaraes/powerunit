HA$PBExportHeader$testfailure.sru
$PBExportComments$A TestFailure collects a failed test together with the error message
forward
global type testfailure from testobject
end type
end forward

global type testfailure from testobject
end type
global testfailure testfailure

type variables
Protected Test inv_failedTest
Protected String is_errorMessage

end variables

forward prototypes
public function string tostring ()
public subroutine initialize (test anv_test, string as_message)
public function string getErrorMessage ()
public function test getFailedTest ()
end prototypes

public function string tostring ();return inv_failedTest.toString() + ": " + is_errorMessage
end function

public subroutine initialize (test anv_test, string as_message);inv_failedTest = anv_test
is_errorMessage = as_message
end subroutine

public function string getErrorMessage ();return is_errorMessage
end function

public function test getFailedTest ();return inv_failedTest
end function

on testfailure.create
TriggerEvent( this, "constructor" )
end on

on testfailure.destroy
TriggerEvent( this, "destructor" )
end on

