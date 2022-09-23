CLASS zoo_bird DEFINITION ABSTRACT
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES ZOO_ANIMAL.

    TYPES: name_type    TYPE c  LENGTH 20,
           gender_type  TYPE c  LENGTH 1,
           color_type   TYPE c  LENGTH 20.

    METHODS: fly_down
                IMPORTING
                    height  TYPE i,
             fly_up
                IMPORTING
                    height  TYPE i,
             constructor
                IMPORTING
                    name    TYPE name_type
                    gender  TYPE gender_type
                    color   TYPE color_type
                    height  TYPE i
                    span    TYPE i.


  PROTECTED SECTION.
    DATA: span_cm   TYPE p LENGTH 6 DECIMALS 2,
          height_m  TYPE i.
  PRIVATE SECTION.
ENDCLASS.



CLASS zoo_bird IMPLEMENTATION.


  "Fill food table with correct food"
  METHOD constructor.
    zoo_animal~name = name.
    zoo_animal~gender = gender.
    zoo_animal~food = VALUE #( BASE zoo_animal~food
                                 ( |Berries| )
                                 ( |Insects| )
                             ).
    height_m = height.
    span_cm = span.
  ENDMETHOD.


  METHOD zoo_animal~eat.

    "Check if food is legitimate"
    LOOP AT zoo_animal~food INTO data(single_food).
       "Eat food
        IF single_food EQ food.
            zoo_animal~is_hungry = abap_false.
            WRITE / zoo_animal~name && ' is not hungry anymore.'.
            "Ends loop, because bird ate."
            EXIT.
        ENDIF.
    ENDLOOP.

    IF zoo_animal~is_hungry = abap_true.
        WRITE / zoo_animal~name && ' is still hungry, because the food was not legitimate.'.
    ENDIF.

  ENDMETHOD.

  METHOD zoo_animal~move.
    IF zoo_animal~is_hungry = abap_true.
        WRITE / zoo_animal~name && ' is too hungry to move.'.
    ELSE.
        zoo_animal~is_hungry = abap_true.
        WRITE / zoo_animal~name && ' moved and is now hungry.'.
    ENDIF.

  ENDMETHOD.

  METHOD zoo_animal~sleep.
    IF zoo_animal~is_hungry = abap_true.
        WRITE / zoo_animal~name && ' dies in his sleep, because he was too hungry'.
    ELSE.
        zoo_animal~is_hungry = abap_true.
        WRITE / zoo_animal~name && ' slept and is now hungry.'.
    ENDIF.
  ENDMETHOD.

  METHOD fly_down.
    "Reduces height by imported value*
    height_m -= height.

    "Feedback"
    IF height_m < 0.
        "Bird dies"
        write / zoo_animal~name && ' dies.' .
        ELSE.
        "Bird flies down"
        write / zoo_animal~name && ' flies down to:' && height_m && 'm.'.
    ENDIF.

  ENDMETHOD.

  METHOD fly_up.
    "Increases height by imported value"
    height_m += height.

    IF height_m > 20000.
        "Bird dies"
        WRITE / zoo_animal~name && ' dies.'.
    ELSE.
        "Bird flies up"
        WRITE / zoo_animal~name && ' flies up to:' && height_m && 'm.'.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
