HA$PBExportHeader$asynctestcase.sru
$PBExportComments$Extends the test case to support rerunning in an async environment
forward
global type asynctestcase from testcase
end type
end forward

global type asynctestcase from testcase
end type
global asynctestcase asynctestcase

type variables
Private Boolean ib_rerun
end variables

forward prototypes
public subroutine runbare ()
public subroutine rerun ()
public function boolean shouldrerun ()
public function test suite ()
end prototypes

public subroutine runbare ();
if not shouldRerun() then
	this.event setUp()
end if

ib_rerun = false

this.event runTest()

if not shouldRerun() then
	this.event tearDown()
end if
end subroutine

public subroutine rerun ();ib_rerun = true
end subroutine

public function boolean shouldrerun ();return ib_rerun
end function

public function test suite ();AsyncTestSuite	lnv_suite

lnv_suite = create AsyncTestSuite
lnv_suite.initialize(className())
return lnv_suite
end function

on asynctestcase.create
TriggerEvent( this, "constructor" )
end on

on asynctestcase.destroy
TriggerEvent( this, "destructor" )
end on

