CLASS zoo_mammal DEFINITION ABSTRACT
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES zoo_animal.
    TYPES:


            ty_children            TYPE STANDARD TABLE OF REF TO zoo_mammal WITH DEFAULT KEY.

    METHODS:
      constructor IMPORTING
          iv_name      type c "LENGTH 20
          iv_is_hungry type abap_boolean
          iv_gender    type c "LENGTH 1
          iv_color     TYPE c, "LENGTH 20,,


      Feed_Offspring  IMPORTING   food TYPE string EXCEPTIONS wrong_food,
      child_success RETURNING VALUE(bool) type abap_boolean,

      get_blood_temperature   RETURNING VALUE(r_result)   TYPE i,
      set_blood_temperature   IMPORTING blood_temperature TYPE i,
      get_mother              RETURNING VALUE(r_result)   TYPE REF TO zoo_mammal,
      set_mother              IMPORTING mother            TYPE REF TO zoo_mammal,
      get_father              RETURNING VALUE(r_result)   TYPE REF TO zoo_mammal,
      set_father              IMPORTING father            TYPE REF TO zoo_mammal,
      get_children            RETURNING VALUE(r_result)   TYPE ty_children,
      set_children            IMPORTING children          TYPE ty_children,
      get_is_pregnant         RETURNING VALUE(r_result)   TYPE abap_boolean,
      set_is_pregnant         IMPORTING is_pregnant       TYPE abap_boolean.
    CLASS-METHODS:
      Try_Make_Child  IMPORTING  mammal1 TYPE REF TO zoo_mammal
                                 mammal2 TYPE REF TO zoo_mammal
                      EXCEPTIONS homosexual
                                 unlucky,
      Give_Birth      IMPORTING  mammal1 TYPE REF TO zoo_mammal "Mammal 1 is mum
                                 mammal2 TYPE REF TO zoo_mammal
                      EXCEPTIONS no_birth.


  PROTECTED SECTION.
    DATA: blood_temperature TYPE i,
          mother            TYPE REF TO zoo_mammal,
          father            TYPE REF TO zoo_mammal,
          children          TYPE STANDARD TABLE OF REF TO zoo_mammal,
          is_pregnant       TYPE abap_boolean.
  PRIVATE SECTION.
ENDCLASS.



CLASS zoo_mammal IMPLEMENTATION.

  METHOD zoo_animal~eat.
    DATA(already_eaten)  = abap_false .
    LOOP AT zoo_animal~food INTO DATA(single_food).
      "Eat food
      IF single_food = food.
        zoo_animal~is_hungry = abap_false.
        WRITE / |{ zoo_animal~name } is not hungry anymore.|.
        already_eaten = abap_true.
        "Ends loop, because mammal ate."
        EXIT.
      ENDIF.
    ENDLOOP.
    IF already_eaten = abap_false.
      WRITE / |{ zoo_animal~name } can't eat|.
      RAISE wrong_food.
    ENDIF.
  ENDMETHOD.

  METHOD zoo_animal~move.
    IF zoo_animal~is_hungry = abap_true.
      WRITE / |{ zoo_animal~name } can't move|.
      RAISE hungry.
    ELSE.
      WRITE / |{ zoo_animal~name } is moving|.
      zoo_animal~is_hungry = abap_true.
    ENDIF.
  ENDMETHOD.

  METHOD zoo_animal~sleep.
    IF zoo_animal~is_hungry = abap_true.
      WRITE / |{ zoo_animal~name } can't sleep and dies |.
      RAISE exhausted.
      "must delete itself and any reference
    ELSE.
      WRITE / |{ zoo_animal~name } is sleeping|.
      zoo_animal~is_hungry = abap_true.
    ENDIF.
  ENDMETHOD.

  METHOD feed_offspring.
    LOOP AT children INTO DATA(child).
*      TRY .
      child->zoo_animal~eat( food = food
*                    EXCEPTIONS wrong_food = 1 others = 2 ).
*      CASE sy-subrc.
*      WHEN 1.
*
*      WHEN 2.
*
*      ENDCASE.
).

    ENDLOOP.
  ENDMETHOD.

  METHOD give_birth.
    IF mammal1->zoo_animal~gender = 'F' AND mammal1->is_pregnant = abap_true AND mammal1->zoo_animal~is_hungry = abap_false AND mammal2->zoo_animal~gender = 'M'.

      DO cl_abap_random_int8=>create( seed = CONV i( sy-uzeit ) min  = 1 max = 6 )->get_next( ) TIMES.

*        IF mammal1 IS INSTANCE OF Z00_elephant
        DATA child TYPE REF TO zoo_mammal.
*           child = new z00_elephant( ).
        child->mother = mammal1.
        child->father = mammal2.
        mammal1->set_children( children = VALUE #( BASE mammal1->get_children(  ) ( child ) ) ).
        mammal2->set_children( children = VALUE #( BASE mammal2->get_children(  ) ( child ) ) ).
        WRITE |Happy Birthday { child->zoo_animal~name }|.
      ENDDO.
*        ENDIF.
    ELSE.
      RAISE no_birth.
    ENDIF.
  ENDMETHOD.


  METHOD try_make_child.
    IF mammal1->zoo_animal~gender = 'M' AND mammal2->zoo_animal~gender = 'F' .
        IF mammal2->child_success(  ) = abap_true.
            mammal2->is_pregnant = abap_true.
        ENDIF.
    ELSEIF mammal1->zoo_animal~gender = 'F' AND mammal2->zoo_animal~gender = 'M'.
        IF mammal2->child_success(  ) = abap_true.
            mammal1->is_pregnant = abap_true.
        ENDIF.
    ELSE.
        RAISE homosexual.
    ENDIF.
  ENDMETHOD.

  METHOD get_blood_temperature.
    r_result = me->blood_temperature.
  ENDMETHOD.

  METHOD set_blood_temperature.
    me->blood_temperature = blood_temperature.
  ENDMETHOD.

  METHOD get_mother.
    r_result = me->mother.
  ENDMETHOD.

  METHOD set_mother.
    me->mother = mother.
  ENDMETHOD.

  METHOD get_father.
    r_result = me->father.
  ENDMETHOD.

  METHOD set_father.
    me->father = father.
  ENDMETHOD.

  METHOD get_children.
    r_result = me->children.
  ENDMETHOD.

  METHOD set_children.
    me->children = children.
  ENDMETHOD.

  METHOD get_is_pregnant.
    r_result = me->is_pregnant.
  ENDMETHOD.

  METHOD set_is_pregnant.
    me->is_pregnant = is_pregnant.
  ENDMETHOD.

  METHOD child_success.
    IF cl_abap_random_int8=>create( seed = CONV i( sy-uzeit ) min  = 1 max = 2 )->get_next( ) = 1.
        bool = abap_true.
    ELSE.
        bool = abap_false.
    ENDIF.
  ENDMETHOD.

  METHOD constructor.
          zoo_animal~name       = iv_name.
          zoo_animal~is_hungry  = iv_is_hungry.
          zoo_animal~gender     = iv_gender.
          zoo_animal~color      = iv_color.
  ENDMETHOD.

ENDCLASS.
