HA$PBExportHeader$pbunit_collection.sru
forward
global type pbunit_collection from testobject
end type
end forward

global type pbunit_collection from testobject
end type
global pbunit_collection pbunit_collection

type variables
Protected Boolean initialized
Protected PowerObject objects[]

end variables

forward prototypes
public function boolean initialize ()
public function integer size ()
public function integer first_null ()
public function integer objects (ref powerobject an_array[])
public function powerobject remove (integer position)
public subroutine remove_destroy (integer position)
public function integer add (powerobject an_object)
public function powerobject at (integer position)
public function integer at_put (integer position, powerobject an_object)
public function integer compress ()
public function integer find (powerobject object_to_find)
public function string tostring ()
public function boolean iterate_into (ref pbunit_iterator an_iterator, ref powerobject an_object)
end prototypes

public function boolean initialize ();PowerObject	empty[]

initialized = true
objects = empty

return true

end function

public function integer size ();return upperBound(objects)

end function

public function integer first_null ();Integer	i, max

max = size()
for i = 1 to max
 	if isValid(at(i)) then 
	 else
		return i
	end if
next

return i

end function

public function integer objects (ref powerobject an_array[]);an_array = objects
return size()

end function

public function powerobject remove (integer position);PowerObject	the_object, null_object

setNull(null_object)
the_object = at(position)
at_put(position, null_object)
return the_object

end function

public subroutine remove_destroy (integer position);PowerObject	the_object

the_object = remove(position)
if isValid(the_object) then 
	DESTROY the_object
end if

end subroutine

public function integer add (powerobject an_object);Integer	i

i = first_null()
at_put(i, an_object)
return i

end function

public function powerobject at (integer position);PowerObject	null_object

if position > 0 and position <= size() then
	return objects[position]
else
	setNull(null_object)
	return null_object
end if

end function

public function integer at_put (integer position, powerobject an_object);objects[position] = an_object
return position

end function

public function integer compress ();PowerObject	new_array[], an_object
Integer		i, j, max

max = size()
for i = 1 to max
	an_object = at(i)
	if isValid(an_object) and not isNull(an_object) then
		j ++
		new_array[j] = an_object
	end if 
next

objects = new_array

return size()

end function

public function integer find (powerobject object_to_find);pbunit_Iterator		anIterator
PowerObject	anObject
Integer		i

do while iterate_into(anIterator, anObject)
	i++
	if anObject = object_to_find then 
		return i
	end if
loop

return 0

end function

public function string tostring ();pbunit_Iterator				theIterator
PowerObject			theObject
String				stringValue
String				args[]
ClassDefinition 	theClass

do while iterate_into(theIterator, theObject)
	
	if len(stringValue) > 0 then
		stringValue += ", "
	end if
	
	theClass = theObject.classDefinition
	if isValid(theClass.findMatchingFunction("toString", args)) then
		stringValue += theObject.dynamic toString()
	else
		stringValue += "a " + theObject.className()
	end if
	
loop 

if len(stringValue) > 0 then
else
	stringValue = "an Empty Collection"
end if

return "( " + stringValue + " )"
end function

public function boolean iterate_into (ref pbunit_iterator an_iterator, ref powerobject an_object);pbunit_iterator	the_iterator
Integer	position

if isValid(an_iterator) then
	the_iterator = an_iterator
else 
	the_iterator = CREATE pbunit_iterator 
end if

do
	position = the_iterator.next_index()
	an_object = at(position)
	if isValid(an_object) then
		exit
	end if
loop until position > size()

if position > size() then 
	destroy the_iterator
end if

an_iterator = the_iterator

return isValid(the_iterator)


/***********

Example usage of this function:

collection				a_collection
powerobject				a_dummy_object
<any_object_class>	an_object

do while a_collection.iterate_into(a_dummy_object, an_object)
	an_object.<some_function>(...)
loop 

**********/

end function

event constructor;initialize()

end event

on pbunit_collection.create
TriggerEvent( this, "constructor" )
end on

on pbunit_collection.destroy
TriggerEvent( this, "destructor" )
end on

