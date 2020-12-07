CLASS ycl_advent2020_day05 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

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

    METHODS binary
      IMPORTING
        upper_bound   TYPE i
        directive     TYPE string
      RETURNING
        VALUE(result) TYPE i.

    METHODS determine_seat_id
      IMPORTING
        seat          TYPE string
      RETURNING
        VALUE(result) TYPE i.
    METHODS determine_row
      IMPORTING
        row_str       TYPE string
      RETURNING
        VALUE(result) TYPE i.
    METHODS determine_column
      IMPORTING
        col_str       TYPE string
      RETURNING
        VALUE(result) TYPE i.


ENDCLASS.



CLASS ycl_advent2020_day05 IMPLEMENTATION.


  METHOD binary.
    DATA(str) = directive.
    str = replace( val = str sub = 'R' with = 'B' occ = 0 ).
    str = replace( val = str sub = 'L' with = 'F' occ = 0 ).
    DATA(lower) = 0.
    DATA(upper) = upper_bound.
    DO strlen( str ) TIMES.
      DATA(index) = sy-index - 1.
      DATA(current) = str+index(1).
      DATA(half) = ( ( upper - lower ) / 2 ).
      IF current = 'F'.
        upper = upper - half.
      ELSEIF current = 'B'.
        lower = lower + half.
      ENDIF.
    ENDDO.
    result = lower.
  ENDMETHOD.


  METHOD determine_column.
    result = binary( upper_bound = 7 directive = col_str ).
  ENDMETHOD.


  METHOD determine_row.
    result = binary( upper_bound = 127 directive = row_str ).
  ENDMETHOD.


  METHOD determine_seat_id.
    DATA(row_str) = seat+0(7).
    DATA(col_str) = seat+7(3).
    result = ( 8 * determine_row( row_str ) ) + determine_column( col_str ).
  ENDMETHOD.


  METHOD solve_part_one.
    LOOP AT input ASSIGNING FIELD-SYMBOL(<i>).
      DATA(seat_id) = determine_seat_id( <i> ).
      IF seat_id > result.
        result = seat_id.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD solve_part_two.
    DATA seats TYPE STANDARD TABLE OF i.
    LOOP AT input ASSIGNING FIELD-SYMBOL(<i>).
      DATA(seat_id) = determine_seat_id( <i> ).
      APPEND seat_id TO seats.
    ENDLOOP.
    SORT seats ASCENDING.

    LOOP AT seats ASSIGNING FIELD-SYMBOL(<s>).
      IF NOT line_exists( seats[ table_line = <s> - 1 ] ).
        result = <s> - 1.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
