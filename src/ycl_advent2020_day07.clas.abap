CLASS ycl_advent2020_day07 DEFINITION
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
      BEGIN OF ty_container,
        container TYPE string,
        includes  TYPE string,
        number    TYPE i,
      END OF ty_container.
    TYPES ty_container_t TYPE SORTED TABLE OF ty_container WITH UNIQUE KEY container includes.

    DATA m_containers TYPE ty_container_t.
    DATA searched TYPE HASHED TABLE OF ty_container WITH UNIQUE KEY container includes.

    METHODS parse_line
      IMPORTING
        line TYPE any.
    METHODS determine_bags_can_hold
      IMPORTING
        bag           TYPE string
      RETURNING
        VALUE(result) TYPE i.
    METHODS determine_bag_amount
      IMPORTING
        bag           TYPE string
      RETURNING
        VALUE(result) TYPE i.

    METHODS count_bags
      IMPORTING
        includes      TYPE string
      RETURNING
        VALUE(result) TYPE i.

ENDCLASS.


CLASS ycl_advent2020_day07 IMPLEMENTATION.
  METHOD solve_part_one.

    LOOP AT input ASSIGNING FIELD-SYMBOL(<i>).
      parse_line( line = <i> ).
    ENDLOOP.

    result = determine_bags_can_hold( bag = 'shiny gold' ).

  ENDMETHOD.

  METHOD solve_part_two.

    LOOP AT input ASSIGNING FIELD-SYMBOL(<i>).
      parse_line( line = <i> ).
    ENDLOOP.

    result = determine_bag_amount( bag = 'shiny gold' ).
  ENDMETHOD.


  METHOD parse_line.
    IF line CP '*no other*'.
      RETURN.
    ENDIF.

    SPLIT line AT ' ' INTO TABLE DATA(words).
    DATA(container) = ||.
    LOOP AT words ASSIGNING FIELD-SYMBOL(<w>).
      IF <w> CP 'bag*'.
        DATA(bag) = |{ words[ sy-tabix - 2 ] } { words[ sy-tabix - 1 ] }|.
        IF container IS INITIAL.
          container = bag.
        ELSE.
          INSERT VALUE #(
            container = container
            includes = bag
            number = words[ sy-tabix - 3 ] )
            INTO TABLE m_containers.
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD determine_bags_can_hold.
    DATA to_search TYPE HASHED TABLE OF string WITH UNIQUE KEY table_line.
    DATA searched TYPE HASHED TABLE OF string WITH UNIQUE KEY table_line.
    LOOP AT m_containers ASSIGNING FIELD-SYMBOL(<m>) WHERE includes = bag.
      INSERT <m>-container INTO TABLE to_search.
    ENDLOOP.

    LOOP AT to_search ASSIGNING FIELD-SYMBOL(<s>).
      LOOP AT m_containers ASSIGNING <m> WHERE includes = <s>.
        INSERT <m>-container INTO TABLE to_search.
      ENDLOOP.
      INSERT <s> INTO TABLE searched.
      DELETE to_search WHERE table_line = <s>.
    ENDLOOP.
    result = lines( searched ).

  ENDMETHOD.


  METHOD determine_bag_amount.
    DATA to_search TYPE HASHED TABLE OF ty_container WITH UNIQUE KEY container includes.

    LOOP AT m_containers ASSIGNING FIELD-SYMBOL(<m>) WHERE container = bag.
      INSERT <m> INTO TABLE to_search.
    ENDLOOP.

    LOOP AT to_search ASSIGNING FIELD-SYMBOL(<s>).
      LOOP AT m_containers ASSIGNING <m> WHERE container = <s>-includes.
        INSERT <m> INTO TABLE to_search.
      ENDLOOP.
      INSERT <s> INTO TABLE searched.
      DELETE to_search WHERE table_line = <s>.
    ENDLOOP.

    LOOP AT searched ASSIGNING <s> WHERE container = bag.
      result = result + <s>-number * count_bags( <s>-includes ).
    ENDLOOP.

  ENDMETHOD.

  METHOD count_bags.
    result = 1.
    LOOP AT searched ASSIGNING FIELD-SYMBOL(<s>) WHERE container = includes.
      result = result + <s>-number * count_bags( <s>-includes ).
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
