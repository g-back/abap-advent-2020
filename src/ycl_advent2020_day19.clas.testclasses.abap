CLASS ltcl_test DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS FINAL.

  PUBLIC SECTION.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA mo_cut TYPE REF TO ycl_advent2020_day19.
    DATA m_input TYPE string_table.

    METHODS setup.
    METHODS given_the_example.
    METHODS given_the_input.

    METHODS part_one_example FOR TESTING.
    METHODS part_one_input FOR TESTING.

    METHODS part_two_example FOR TESTING.
    METHODS part_two_input FOR TESTING.


ENDCLASS.

CLASS ltcl_test IMPLEMENTATION.

  METHOD setup.
    mo_cut = NEW #( ).
  ENDMETHOD.

  METHOD part_one_example.
    given_the_example( ).
    DATA(act) = mo_cut->solve_part_one( input = m_input ).
    cl_abap_unit_assert=>assert_equals( exp = -1 act = act ).
  ENDMETHOD.

  METHOD part_one_input.
    given_the_input( ).
    DATA(act) = mo_cut->solve_part_one( input = m_input ).

    cl_abap_unit_assert=>assert_equals( exp = -1 act = act ).
  ENDMETHOD.

  METHOD part_two_example.
    given_the_example( ).
    DATA(act) = mo_cut->solve_part_two( input = m_input ).
    cl_abap_unit_assert=>assert_equals( exp = -1 act = act ).
  ENDMETHOD.

  METHOD part_two_input.
    given_the_input( ).
    DATA(act) = mo_cut->solve_part_two( input = m_input ).
    cl_abap_unit_assert=>assert_equals( exp = -1 act = act ).
  ENDMETHOD.

  METHOD given_the_example.
    m_input = VALUE #(
    ).
  ENDMETHOD.

  METHOD given_the_input.
    m_input = VALUE #(
    ).
  ENDMETHOD.

ENDCLASS.
