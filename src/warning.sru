HA$PBExportHeader$warning.sru
$PBExportComments$A test which will fail and log a warning message
forward
global type warning from testcase
end type
end forward

global type warning from testcase
end type
global warning warning

forward prototypes
public function string tostring ()
end prototypes

public function string tostring ();return "Warning"
end function

on warning.create
TriggerEvent( this, "constructor" )
end on

on warning.destroy
TriggerEvent( this, "destructor" )
end on

event runtest;// overriden

fail(is_name)
end event

