CLASS zoo_fish DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES zoo_animal.

    TYPES: name_type   TYPE c  LENGTH 20,
           gender_type TYPE c  LENGTH 1,
           color_type  TYPE c  LENGTH 20.

    METHODS: get_vegetarian RETURNING VALUE(r_result) TYPE abap_boolean,
      dive_up
        IMPORTING
          name TYPE name_type,
      dive
        IMPORTING
          name TYPE name_type,
      constructor
        IMPORTING
          name          TYPE name_type
          gender        TYPE gender_type
          color         TYPE color_type
          iv_vegetarian TYPE abap_boolean
          iv_depth      TYPE i.

  PROTECTED SECTION.
    DATA: vegetarian TYPE abap_boolean,
          depth      TYPE i.
  PRIVATE SECTION.
ENDCLASS.



CLASS zoo_fish IMPLEMENTATION.
  METHOD zoo_animal~eat.
    LOOP AT zoo_animal~food INTO DATA(single_food).
      "Eat food
      IF single_food EQ food.
        zoo_animal~is_hungry = abap_false.
        WRITE zoo_animal~name && ' is not hungry anymore.'.
        "Ends loop, because fish ate."
        EXIT.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD zoo_animal~move.
    IF zoo_animal~is_hungry = abap_true.
      WRITE zoo_animal~name && ' is too hungry to move.'.
    ELSE.
      zoo_animal~is_hungry = abap_true.
      WRITE zoo_animal~name && ' moved and is now hungry.'.
    ENDIF.
  ENDMETHOD.

  METHOD zoo_animal~sleep.
    IF zoo_animal~is_hungry = abap_true.
      WRITE zoo_animal~name && ' dies in his sleep, because he was too hungry'.
    ELSE.
      zoo_animal~is_hungry = abap_true.
      WRITE zoo_animal~name && ' slept and is now hungry.'.
    ENDIF.
  ENDMETHOD.

  METHOD get_vegetarian.
    r_result = me->vegetarian.
  ENDMETHOD.

  METHOD dive.
    depth += depth.
    IF depth <= 0 .
      WRITE |fish { name } ist gestorben|.
    ELSE.
      WRITE |fish { name } dove up and is now on depth { depth }|.
    ENDIF.



  ENDMETHOD.

  METHOD dive_up.
    depth -= depth.
    IF depth >= 0 .
      WRITE |fish { name } ist gestorben|.
    ELSE.
      WRITE |fish { name } dove down and is now on depth { depth }|.
    ENDIF.

  ENDMETHOD.


  METHOD constructor.
    zoo_animal~color = color.
    zoo_animal~gender = gender.
    zoo_animal~name = name.
    zoo_animal~is_hungry = abap_false.
    depth = iv_depth.
    vegetarian = iv_vegetarian.
    zoo_animal~food = VALUE #( ( `FLEISCH` ) ( `ALGEN` ) ).
  ENDMETHOD.

ENDCLASS.
