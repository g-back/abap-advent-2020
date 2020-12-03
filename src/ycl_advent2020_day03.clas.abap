CLASS ycl_advent2020_day03 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS solve_part_one
      IMPORTING
        input         TYPE string_table
      RETURNING
        VALUE(result) TYPE int8.

    METHODS solve_part_two
      IMPORTING
        input         TYPE string_table
      RETURNING
        VALUE(result) TYPE int8.

  PROTECTED SECTION.

  PRIVATE SECTION.
    TYPES:
      BEGIN OF ty_traverse_map,
        down  TYPE i,
        right TYPE i,
      END OF ty_traverse_map.
    TYPES ty_traverse_map_t TYPE STANDARD TABLE OF ty_traverse_map WITH EMPTY KEY.

    DATA m_input TYPE string_table.

    METHODS traverse
      IMPORTING
        down          TYPE i
        right         TYPE i
      RETURNING
        VALUE(result) TYPE int8.
ENDCLASS.



CLASS ycl_advent2020_day03 IMPLEMENTATION.
  METHOD solve_part_one.

    m_input = input.
    result = traverse( down = 1 right = 3 ).
  ENDMETHOD.

  METHOD solve_part_two.

    m_input = input.
    DATA(traverse_map) = VALUE ty_traverse_map_t(
      ( down = 1 right = 1 )
      ( down = 1 right = 3 )
      ( down = 1 right = 5 )
      ( down = 1 right = 7 )
      ( down = 2 right = 1 )
     ).
    result = 1.
    LOOP AT traverse_map ASSIGNING FIELD-SYMBOL(<m>).
      DATA(trav)  = traverse( down = <m>-down right = <m>-right ).
      result = result * trav.
    ENDLOOP.

  ENDMETHOD.


  METHOD traverse.
    DATA(x) = 0.
    DATA(y) = 1.
    DATA(rows) = lines( m_input ).
    DATA(factor) = 1.

    DO.
      DATA(line) = m_input[ y ].
      line = repeat( val = line occ = factor ).

      IF line+x(1) = '#'.
        ADD 1 TO result.
      ENDIF.
      ADD right TO x.
      ADD down TO y.

      IF y > rows.
        EXIT.
      ENDIF.

      IF x >= strlen( line ).
        ADD 1 TO factor.
      ENDIF.
    ENDDO.

  ENDMETHOD.

ENDCLASS.
