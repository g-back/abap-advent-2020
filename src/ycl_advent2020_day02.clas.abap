CLASS ycl_advent2020_day02 DEFINITION
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



CLASS ycl_advent2020_day02 IMPLEMENTATION.
  METHOD solve_part_one.
    LOOP AT input ASSIGNING FIELD-SYMBOL(<i>).
      SPLIT <i> AT ' ' INTO DATA(range) DATA(letter) DATA(password).
      SPLIT range AT '-' INTO DATA(min) DATA(max).
      letter = letter+0(1).
      DATA(amount) = count( val = password sub = letter ).
      IF amount BETWEEN min AND max.
        ADD 1 TO result.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD solve_part_two.
    LOOP AT input ASSIGNING FIELD-SYMBOL(<i>).
      SPLIT <i> AT ' ' INTO DATA(positions) DATA(letter) DATA(password).
      SPLIT positions AT '-' INTO DATA(pos_1) DATA(pos_2).
      SUBTRACT 1 FROM pos_1.
      SUBTRACT 1 FROM pos_2.
      letter = letter+0(1).
      DATA(count) = 0.
      TRY.
          IF password+pos_1(1) = letter.
            ADD 1 TO  count.
          ENDIF.
          IF password+pos_2(1) = letter.
            ADD 1 TO  count.
          ENDIF.
        CATCH cx_sy_range_out_of_bounds.
          CONTINUE.
      ENDTRY.
      IF count = 1.
        ADD 1 TO result.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
