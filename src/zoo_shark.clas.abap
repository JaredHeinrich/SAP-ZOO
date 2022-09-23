CLASS zoo_shark DEFINITION
  INHERITING FROM zoo_fish
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
    bite
        IMPORTING
            person TYPE REF TO zoo_person.


  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA teeth TYPE i.
ENDCLASS.



CLASS zoo_shark IMPLEMENTATION.
  METHOD bite.
    If zoo_animal~is_hungry = abap_true.
    WRITE |shark bites { person->get_name( ) }|.
    person->set_pissed( abap_true ).
    zoo_animal~is_hungry = abap_false.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
