HA$PBExportHeader$testobject.sru
$PBExportComments$Ancestor object for testing classes
forward
global type testobject from nonvisualobject
end type
end forward

global type testobject from nonvisualobject
end type
global testobject testobject

forward prototypes
public function string tostring ()
end prototypes

public function string tostring ();return "a " + ClassName()
end function

on testobject.create
TriggerEvent( this, "constructor" )
end on

on testobject.destroy
TriggerEvent( this, "destructor" )
end on

