HA$PBExportHeader$pbunit_iterator.sru
forward
global type pbunit_iterator from testobject
end type
end forward

global type pbunit_iterator from testobject
end type
global pbunit_iterator pbunit_iterator

type variables
Protected Integer current_position

end variables

forward prototypes
public function integer next_index ()
public function integer decrement ()
public function integer value ()
public function integer value (integer position)
end prototypes

public function integer next_index ();current_position++
return current_position

end function

public function integer decrement ();current_position --
return current_position

end function

public function integer value ();return current_position

end function

public function integer value (integer position);current_position = position
return current_position

end function

on pbunit_iterator.create
TriggerEvent( this, "constructor" )
end on

on pbunit_iterator.destroy
TriggerEvent( this, "destructor" )
end on

