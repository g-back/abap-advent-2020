CLASS ycl_advent2020_day04 DEFINITION
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
    DATA m_valid_eye_colors TYPE RANGE OF string.

    METHODS is_passport_valid
      IMPORTING
        passport      TYPE string
      RETURNING
        VALUE(result) TYPE string.

    METHODS is_passport_valid_strict
      IMPORTING
        passport      TYPE string
      RETURNING
        VALUE(result) TYPE abap_bool.

    METHODS is_field_valid
      IMPORTING
        field         TYPE string
      RETURNING
        VALUE(result) TYPE string.

ENDCLASS.


CLASS ycl_advent2020_day04 IMPLEMENTATION.
  METHOD solve_part_one.
    DATA(in) = input.
    APPEND VALUE #( ) TO in.

    DATA(passport) = ||.
    LOOP AT in ASSIGNING FIELD-SYMBOL(<i>).
      IF <i> = || AND passport <> ||.
        IF is_passport_valid( passport ).
          ADD 1 TO result.
        ENDIF.
        passport = ||.
        CONTINUE.
      ENDIF.
      passport = |{ passport } { <i> }|.
    ENDLOOP.
  ENDMETHOD.

  METHOD solve_part_two.
    m_valid_eye_colors = VALUE #( sign = 'I' option = 'EQ'
      ( low = 'amb' ) ( low = 'blu' ) ( low = 'brn' ) ( low = 'gry' )
      ( low = 'grn' ) ( low = 'hzl' ) ( low = 'oth' )
    ).

    DATA(in) = input.
    APPEND VALUE #( ) TO in.

    DATA(passport) = ||.
    LOOP AT in ASSIGNING FIELD-SYMBOL(<i>).
      IF <i> = || AND passport <> ||.
        IF is_passport_valid_strict( passport ).
          ADD 1 TO result.
        ENDIF.
        passport = ||.
        CONTINUE.
      ENDIF.
      passport = |{ passport } { <i> }|.
    ENDLOOP.
  ENDMETHOD.


  METHOD is_passport_valid.
    SPLIT passport AT ' ' INTO TABLE DATA(fields).
    DELETE fields WHERE table_line CP 'cid:*' OR table_line = ||.
    result = xsdbool( lines( fields ) = 7 ).
  ENDMETHOD.


  METHOD is_passport_valid_strict.
    SPLIT passport AT ' ' INTO TABLE DATA(fields).
    DELETE fields WHERE table_line CP 'cid:*' OR table_line = ||.
    IF lines( fields ) <> 7.
      result = abap_false.
      RETURN.
    ENDIF.

    LOOP AT fields ASSIGNING FIELD-SYMBOL(<f>).
      IF NOT is_field_valid( field = <f> ).
        result = abap_false.
        RETURN.
      ENDIF.
    ENDLOOP.
    result = abap_true.
  ENDMETHOD.


  METHOD is_field_valid.
    SPLIT field AT ':' INTO DATA(key) DATA(value).
    CASE key.
      WHEN 'byr'.
        result = xsdbool( value BETWEEN 1920 AND 2002 ).
      WHEN 'iyr'.
        result = xsdbool( value BETWEEN 2010 AND 2020 ).
      WHEN 'eyr'.
        result = xsdbool( value BETWEEN 2020 AND 2030 ).
      WHEN 'hgt'.
        IF value CP '*cm'.
          result = xsdbool( substring( val = value len = strlen( value ) - 2 ) BETWEEN 150 AND 193 ).
        ELSEIF value CP '*in'.
          result = xsdbool( substring( val = value len = strlen( value ) - 2 ) BETWEEN 59 AND 76 ).
        ELSE.
          result = abap_false.
        ENDIF.
      WHEN 'hcl'.
        result = cl_abap_matcher=>contains( pattern = '^#[0-9a-f]{6}' text = value ).
      WHEN 'ecl'.
        result = xsdbool( value IN m_valid_eye_colors ).
      WHEN 'pid'.
        result = xsdbool( strlen( value ) = 9 ).
    ENDCASE.
  ENDMETHOD.

ENDCLASS.
