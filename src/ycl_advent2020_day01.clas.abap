CLASS ycl_advent2020_day01 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS solve_part_one
      IMPORTING
        input         TYPE string_table
      RETURNING
        VALUE(result) TYPE i.

    METHODS solve_part_two
      IMPORTING
        input         TYPE string_table
      RETURNING
        VALUE(result) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS YCL_ADVENT2020_DAY01 IMPLEMENTATION.


  METHOD solve_part_one.

    LOOP AT input ASSIGNING FIELD-SYMBOL(<i>).
      DATA(diff) = 2020 - <i>.
      DATA(found) = VALUE i( input[ table_line =  |{ diff }| ] OPTIONAL ).
      IF found IS NOT INITIAL.
        result = diff * <i>.
        RETURN.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD solve_part_two.
    LOOP AT input ASSIGNING FIELD-SYMBOL(<i>).
      LOOP AT input ASSIGNING FIELD-SYMBOL(<j>).
        DATA(diff) = 2020 - ( <i> + <j> ) .
        DATA(found) = VALUE i( input[ table_line =  |{ diff }| ] OPTIONAL ).
        IF found IS NOT INITIAL.
          result = diff * <i> * <j>.
          RETURN.
        ENDIF.
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
