CLASS ycl_advent2020_day08 DEFINITION
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
      BEGIN OF ty_acc,
        index   TYPE i,
        instruc TYPE string,
        value   TYPE i,
      END OF ty_acc.
    TYPES ty_acc_t TYPE STANDARD TABLE OF ty_acc WITH EMPTY KEY.
    TYPES:
      BEGIN OF ty_result,
        acc    TYPE i,
        looped TYPE abap_bool,
      END OF ty_result.

    DATA m_instruc TYPE ty_acc_t.

    METHODS parse_input
      IMPORTING
        input TYPE string_table.

    METHODS execute_instructions
      RETURNING
        VALUE(result) TYPE ty_result.

    METHODS brute_force
      RETURNING
        VALUE(result) TYPE int8.
ENDCLASS.


CLASS ycl_advent2020_day08 IMPLEMENTATION.
  METHOD solve_part_one.
    parse_input( input ).
    result = execute_instructions( )-acc.
  ENDMETHOD.

  METHOD solve_part_two.
    parse_input( input ).
    result = brute_force( ).
  ENDMETHOD.


  METHOD parse_input.
    LOOP AT input ASSIGNING FIELD-SYMBOL(<i>).
      SPLIT <i> AT ' ' INTO DATA(instruction) DATA(value).
      value = condense( replace( val = value sub = '+' with = '' ) ).
      APPEND VALUE #(
        index   = sy-tabix
        instruc = instruction
        value   = value )
      TO m_instruc.
    ENDLOOP.
  ENDMETHOD.


  METHOD execute_instructions.
    IF lines( m_instruc ) IS INITIAL.
      RETURN.
    ENDIF.

    DATA executed TYPE HASHED TABLE OF i WITH UNIQUE KEY table_line.
    DATA(ptr) = 1.
    DO.
      DATA(instruc) = VALUE #( m_instruc[ ptr ] OPTIONAL ).
      IF instruc IS INITIAL.
        RETURN.
      ENDIF.

      INSERT instruc-index INTO TABLE executed.
      IF sy-subrc = 4.
        result-looped = abap_true.
        RETURN.
      ENDIF.
      IF instruc-instruc = 'acc'.
        result-acc = result-acc + instruc-value.
        ADD 1 TO ptr.
      ELSEIF instruc-instruc = 'jmp'.
        ADD instruc-value TO ptr.
      ELSE.
        ADD 1 TO ptr.
      ENDIF.
    ENDDO.
  ENDMETHOD.

  METHOD brute_force.
    LOOP AT m_instruc ASSIGNING FIELD-SYMBOL(<i>).
      DATA(state_before) = <i>.
      IF <i>-instruc = 'jmp'.
        <i>-instruc = 'nop'.
      ELSEIF <i>-instruc = 'nop'.
        <i>-instruc = 'jmp'.
      ENDIF.
      DATA(exec) = execute_instructions( ).
      IF exec-looped = abap_false.
        result = exec-acc.
        RETURN.
      ELSE.
        <i> = state_before.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
