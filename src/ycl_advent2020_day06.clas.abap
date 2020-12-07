CLASS ycl_advent2020_day06 DEFINITION
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
    METHODS count_any_answers
      IMPORTING
        answers       TYPE string
      RETURNING
        VALUE(result) TYPE i.

    METHODS count_every_answers
      IMPORTING
        answers       TYPE string
        persons       TYPE i
      RETURNING
        VALUE(result) TYPE i.

ENDCLASS.


CLASS ycl_advent2020_day06 IMPLEMENTATION.
  METHOD solve_part_one.
    DATA(in) = input.
    APPEND || TO in.
    DATA(answers) = ||.
    LOOP AT in ASSIGNING FIELD-SYMBOL(<i>).
      IF <i> = || AND answers <> ||.
        result = result + count_any_answers( answers ).
        answers = ||.
        CONTINUE.
      ENDIF.
      answers = |{ answers }{ <i> }|.
    ENDLOOP.
  ENDMETHOD.

  METHOD solve_part_two.
    DATA(in) = input.
    APPEND || TO in.
    DATA(answers) = ||.
    DATA(persons) = 0.
    LOOP AT in ASSIGNING FIELD-SYMBOL(<i>).
      IF <i> = || AND answers <> ||.
        result = result + count_every_answers( answers = answers persons = persons ).
        answers = ||.
        persons = 0.
        CONTINUE.
      ENDIF.
      answers = |{ answers }{ <i> }|.
      ADD 1 TO persons.
    ENDLOOP.
  ENDMETHOD.


  METHOD count_any_answers.
    DATA answer_tab TYPE HASHED TABLE OF string WITH UNIQUE KEY table_line.
    DO strlen( answers ) TIMES.
      DATA(index) = sy-index - 1.
      INSERT answers+index(1) INTO TABLE answer_tab.
    ENDDO.
    result = lines( answer_tab ).
  ENDMETHOD.


  METHOD count_every_answers.
    TYPES:
      BEGIN OF ty_count,
        answer TYPE string,
        count  TYPE i,
      END OF ty_count.
    TYPES ty_count_t TYPE HASHED TABLE OF ty_count WITH UNIQUE KEY answer.

    DATA counts TYPE ty_count_t.
    DO strlen( answers ) TIMES.
      DATA(index) = sy-index - 1.
      DATA(answer) = answers+index(1).

      DATA(count) = VALUE #( counts[ answer = answer ] OPTIONAL ).
      IF count IS INITIAL.
        INSERT VALUE #( answer = answer count = 1 ) INTO TABLE counts.
      ELSE.
        ADD 1 TO count-count.
        MODIFY TABLE counts FROM count.
      ENDIF.
    ENDDO.

    DELETE counts WHERE count <> persons.
    result = lines( counts ).

  ENDMETHOD.

ENDCLASS.
