CLASS zoo_magpie DEFINITION INHERITING FROM zoo_bird
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
        constructor
            IMPORTING
                    name    TYPE name_type
                    gender  TYPE gender_type
                    color   TYPE color_type
                    height  TYPE i
                    span    TYPE i,
        steal
            IMPORTING
                person TYPE REF TO zoo_person,
        put_item_in_nest.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: current_item TYPE string,
          items TYPE STANDARD TABLE OF string.

ENDCLASS.


CLASS zoo_magpie IMPLEMENTATION.
    METHOD constructor.
        super->constructor( name = name
                            gender = gender
                            color = color
                            height = height
                            span = span ).
    ENDMETHOD.

    METHOD steal.
        IF zoo_animal~is_hungry = abap_true.
            "Magpie is too hungry to steal"
            WRITE / |{ zoo_animal~name } is too hungry to steal something.|.
        ELSEIF current_item EQ ''.
            IF lines( person->get_items( ) ) = 0.
                WRITE / |{ person->get_name(  ) } hat keine Items.|.
            ELSE.
                DATA: random            TYPE i,
                      stolen_item       TYPE string,
                      stolen_items      TYPE STANDARD TABLE OF string WITH EMPTY KEY.



                random = cl_abap_random_int8=>create( seed = CONV i( sy-uzeit ) min  = 1 max = lines( person->get_items(  ) ) )->get_next( ).
                "Gets items from person"
                stolen_items = person->get_items(  ).
                stolen_item = stolen_items[ random ].

                "Delete Item from persons list"
                person->remove_item( stolen_item ).

                "Take item into current_item and delete item from person list"
                current_item = stolen_item.

                WRITE / |{ zoo_animal~name } stole { current_item } from { person->get_name(  ) }|.
            ENDIF.

        ELSEIF current_item <> ' '.

            WRITE / |{ zoo_animal~name } is currently carrying { current_item } and can't steal.|.
        ENDIF.
    ENDMETHOD.

    METHOD put_item_in_nest.

        "Checks if magpie has item"
        IF current_item EQ ''.

            WRITE / |{ zoo_animal~name } has no item.|.
        ELSE.
            "Adds current item to nest*
            items = VALUE #( BASE items ( current_item ) ).

            "Clears current items*
            current_item = ''.

            WRITE / |{ zoo_animal~name } puts the item into the nest.|.

        ENDIF.

    ENDMETHOD.
ENDCLASS.
