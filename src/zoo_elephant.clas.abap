CLASS zoo_elephant DEFINITION
  PUBLIC
  INHERITING FROM zoo_mammal
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:    stamp EXCEPTIONS unable,
                swap_Tail IMPORTING person type REF TO zoo_person
                        EXCEPTIONS unable,
                absorb_Water IMPORTING amount type i
                        EXCEPTIONS no_amount,
                splash_Water IMPORTING person type ref to zoo_person.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: Force type i,
          trunk_capacity type i.
ENDCLASS.



CLASS zoo_elephant IMPLEMENTATION.
  METHOD absorb_water.
    IF trunk_capacity + amount >= 200.
        trunk_capacity = 200.
    ELSEIF amount > 0.
        trunk_capacity += amount.
    ELSE.
        RAISE no_amount.
    ENDIF.
  ENDMETHOD.

  METHOD splash_water.
    IF trunk_capacity >= 75.
        person->set_pissed( iv_is_pissed = abap_true ).
        write |platsch platsch|.
        trunk_capacity -= 75.
    ENDIF.
  ENDMETHOD.

  METHOD stamp.
    IF force > 50 AND zoo_animal~is_hungry = abap_false.
        zoo_animal~is_hungry = abap_false.
    ELSE.
        RAISE unable.
    ENDIF.
  ENDMETHOD.

  METHOD swap_tail.
    IF force > 30.
    person->set_pissed( iv_is_pissed = abap_true ).
    endif.
  ENDMETHOD.

ENDCLASS.
