HA$PBExportHeader$testsuite.sru
$PBExportComments$A TestSuite is a Composite of Tests.  It runs a collection of test cases.
forward
global type testsuite from test
end type
end forward

global type testsuite from test
event preaddtest ( ref test anv_test )
end type
global testsuite testsuite

type variables
Protected pbunit_Collection inv_testCollection
end variables

forward prototypes
public subroutine addtest (test anv_test)
public function integer counttestcases ()
public subroutine run (testresult anv_result)
protected function classdefinition getclassdefinition (string as_classname)
public subroutine initialize (string as_classname, string as_methodname)
public subroutine initialize (string as_classname)
end prototypes

public subroutine addtest (test anv_test);this.event preAddTest(anv_test)
inv_testCollection.add(anv_test)
end subroutine

public function integer counttestcases ();pbunit_Iterator	lnv_iterator
Test					lnv_test
Integer				li_count

do while inv_testCollection.iterate_into(lnv_iterator, lnv_test)
	li_count += lnv_test.countTestCases()
loop

return li_count
end function

public subroutine run (testresult anv_result);pbunit_Iterator	lnv_iterator
Test					lnv_test

do while inv_testCollection.iterate_into(lnv_iterator, lnv_test)
	Yield()
	if anv_result.shouldStop() then
		return
	end if
	lnv_test.run(anv_result)
loop
end subroutine

protected function classdefinition getclassdefinition (string as_classname);ClassDefinition	lcd_notATestClass
ClassDefinition	lcd_class
ClassDefinition	lcd_ancestor

lcd_class = findClassDefinition(as_className)
if isValid(lcd_class) then
else
	return lcd_notATestClass
end if

lcd_ancestor = lcd_class.ancestor
do while IsValid(lcd_ancestor)
	if lower(lcd_ancestor.name) = "test" then
		exit
	end if
	lcd_ancestor = lcd_ancestor.ancestor
loop

if isValid(lcd_ancestor) then
else
	return lcd_notATestClass
end if	

return lcd_class
end function

public subroutine initialize (string as_classname, string as_methodname);ClassDefinition	lcd_class
Integer				li, li_scriptCount, li_testCount
TestCase				lnv_testCase

lcd_class = getClassDefinition(as_className)
if isValid(lcd_class) then
else
	lnv_testCase = create Warning
	lnv_testCase.initialize("Class name " + as_className + " is not a valid test class.")
	addTest(lnv_testCase)
	return 
end if

n_pbunit_objectservice  lnv_helper
 
li_scriptCount = upperBound(lcd_class.scriptList)
for li = 1 to li_scriptCount
	if lnv_helper.of_is_a_test_method(lcd_class.scriptList[li]) then
 		if as_methodname <> '' then
			if as_methodname <> lcd_class.scriptList[li].name then continue
		end if
			
		li_testCount ++
		lnv_testCase = create using as_className
		lnv_testCase.initialize(lcd_class.scriptList[li].name)
		addTest(lnv_testCase)
	end if
next

 

if li_testCount = 0 then
	lnv_testCase = create Warning
	lnv_testCase.initialize("No tests found in " + as_className + ".")
	addTest(lnv_testCase)
	return 
end if
end subroutine

public subroutine initialize (string as_classname);ClassDefinition	lcd_class
Integer				li, li_scriptCount, li_testCount
TestCase				lnv_testCase

lcd_class = getClassDefinition(as_className)
if isValid(lcd_class) then
else
	lnv_testCase = create Warning
	lnv_testCase.initialize("Class name " + as_className + " is not a valid test class.")
	addTest(lnv_testCase)
	return 
end if

n_pbunit_objectservice  lnv_helper
 
li_scriptCount = upperBound(lcd_class.scriptList)
for li = 1 to li_scriptCount
	if lnv_helper.of_is_a_test_method(lcd_class.scriptList[li]) then

		li_testCount ++
		lnv_testCase = create using as_className
		lnv_testCase.initialize(lcd_class.scriptList[li].name)
		addTest(lnv_testCase)
	end if
next

if li_testCount = 0 then
	lnv_testCase = create Warning
	lnv_testCase.initialize("Not tests found in " + as_className + ".")
	addTest(lnv_testCase)
	return 
end if
end subroutine

on testsuite.create
call super::create
end on

on testsuite.destroy
call super::destroy
end on

event constructor;call super::constructor;inv_testCollection = create pbunit_Collection
end event

