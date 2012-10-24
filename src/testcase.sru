HA$PBExportHeader$testcase.sru
$PBExportComments$A test case defines the fixture to run multiple tests.
forward
global type testcase from test
end type
end forward

global type testcase from test
event setup ( )
event teardown ( )
event runtest ( )
end type
global testcase testcase

type variables
Protected TestResult inv_result
Protected String is_name
Private Boolean ib_stop
Private Boolean ib_error
end variables

forward prototypes
public subroutine runbare ()
public subroutine initialize (string as_name)
public function string tostring ()
public subroutine run (TestResult anv_result)
public subroutine fail (string as_message)
public function integer counttestcases ()
protected function testresult createresult ()
protected function testresult getresult ()
public function string name ()
public function testresult run ()
public subroutine stop ()
public function boolean shouldstop ()
public subroutine error (error anv_error)
public function boolean error ()
public function test suite ()
public function boolean assert (boolean ab_condition)
public function boolean assert (string as_message, boolean ab_condition)
public function boolean assertisvalid (string as_message, powerobject apo_object)
public function boolean assertisvalid (powerobject apo_object)
public function boolean assertnotnull (string as_message, any aa_value)
public function boolean assertnotnull (any aa_value)
public function boolean assertequal (readonly any expected, readonly any actual)
end prototypes

event runtest;if triggerEvent(is_name) = -1 and not error() then
	fail("Test " + is_name + " was not found.")
end if
end event

public subroutine runbare ();this.event setUp()
this.event runTest()
this.event tearDown()
end subroutine

public subroutine initialize (string as_name);is_name = as_name
end subroutine

public function string tostring ();return super::toString() + "." + is_name
end function

public subroutine run (TestResult anv_result);inv_result = anv_result
anv_result.run(this)
setNull(inv_result)
end subroutine

public subroutine fail (string as_message);if isValid(inv_result) then
	inv_result.addFailure(this, as_message)
end if
end subroutine

public function integer counttestcases ();return 1
end function

protected function testresult createresult ();TestResult theResult

theResult = create TestResult
return theResult

end function

protected function testresult getresult ();return inv_result
end function

public function string name ();return is_name
end function

public function testresult run ();TestResult theResult 

theResult = createResult()
run(theResult)
return theResult
end function

public subroutine stop ();ib_stop = true
end subroutine

public function boolean shouldstop ();return ib_stop
end function

public subroutine error (error anv_error);String	ls_message

ib_error = true

if isValid(inv_result) and isValid(anv_error) then
	ls_message = "Error Number " + string(anv_error.number) + & 
					 ".~r~nError text = " + anv_error.text + &
					 ".~r~nWindow/Menu/Object = " + anv_error.windowMenu + &
					 ".~r~nError Object/Control = " + anv_error.object + &
					 ".~r~nScript = " + anv_error.objectEvent + &
					 ".~r~nLine in Script = " + string(anv_error.line) + "."
	inv_result.addError(this, ls_message)
end if
end subroutine

public function boolean error ();return ib_error
end function

public function test suite ();TestSuite	lnv_suite
 
lnv_suite = create TestSuite

n_pbunit_objectservice  lnv_objectservice
 
if lnv_objectservice.of_get_current_test_method_name() = '' then
	lnv_suite.initialize( className() )
else
 
	lnv_suite.initialize(className(), lnv_objectservice.of_get_current_test_method_name())
end if
 

return lnv_suite
end function

public function boolean assert (boolean ab_condition);assert("Condition failed", ab_condition)
return ab_condition
end function

public function boolean assert (string as_message, boolean ab_condition);inv_result.addassert( )


if ab_condition then
else
	fail(as_message)
end if

return ab_condition
end function

public function boolean assertisvalid (string as_message, powerobject apo_object);inv_result.addassert( )


if isValid(apo_object) then
	return true
end if

fail(as_message)

return false
end function

public function boolean assertisvalid (powerobject apo_object);return assertIsValid("Object is not valid", apo_object)
end function

public function boolean assertnotnull (string as_message, any aa_value);inv_result.addassert( )


if isNull(aa_value) then
	fail(as_message)
	return false
end if

return true
end function

public function boolean assertnotnull (any aa_value);return assertNotNull("Value is null", aa_value)
end function

public function boolean assertequal (readonly any expected, readonly any actual);inv_result.addassert( )

if (expected = actual) then
else
	fail("Assertion failed, expected " + String(expected) + " but was " + String(actual))
end if

return true
end function

on testcase.create
call super::create
end on

on testcase.destroy
call super::destroy
end on

event constructor;call super::constructor;setNull(inv_result)
ib_stop = false
end event

