HA$PBExportHeader$testdecorator.sru
$PBExportComments$A Decorator for Tests. Use TestDecorator as the base class for defining new test decorators. Test decorator subclasses can be introduced to add behaviour before or after a test is run.
forward
global type testdecorator from test
end type
end forward

global type testdecorator from test
end type
global testdecorator testdecorator

type variables
Protected Test inv_test
end variables

forward prototypes
public subroutine initialize (Test anv_test)
public function integer counttestcases ()
public subroutine run (TestResult anv_result)
public function string tostring ()
end prototypes

public subroutine initialize (Test anv_test);inv_test = anv_test
end subroutine

public function integer counttestcases ();return inv_test.countTestCases()
end function

public subroutine run (TestResult anv_result);inv_test.run(anv_result)
end subroutine

public function string tostring ();return inv_test.toString()
end function

on testdecorator.create
TriggerEvent( this, "constructor" )
end on

on testdecorator.destroy
TriggerEvent( this, "destructor" )
end on

