HA$PBExportHeader$test.sru
$PBExportComments$A Test can be run and collect its results.
forward
global type test from testobject
end type
end forward

global type test from testobject
end type
global test test

type variables
 
end variables

forward prototypes
public function integer counttestcases ()
public subroutine run (testresult inv_result)
public function boolean shouldrerun ()
public function test suite ()
end prototypes

public function integer counttestcases ();return 0
end function

public subroutine run (testresult inv_result);
end subroutine

public function boolean shouldrerun ();return false
end function

public function test suite ();return this
end function

on test.create
call super::create
end on

on test.destroy
call super::destroy
end on

