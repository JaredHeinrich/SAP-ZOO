CLASS zoo_person DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  TYPES: ty_name TYPE c LENGTH 20,
         ty_items TYPE STANDARD TABLE OF string WITH EMPTY KEY.



    METHODS: feed
      IMPORTING
        io_animal TYPE REF TO zoo_animal
        iv_food   TYPE string,

      curse
        RETURNING VALUE(returning_curse) TYPE string,

      add_item
        IMPORTING
            iv_add TYPE String,

      remove_item
        IMPORTING
            iv_remove TYPE String,

      constructor
        IMPORTING
            iv_name TYPE ty_name
            iv_is_pissed TYPE abap_boolean
            it_items TYPE ty_items,

      set_pissed
        IMPORTING
            iv_is_pissed TYPE abap_boolean,

      get_name RETURNING VALUE(ev_name) TYPE ty_name,

      get_is_pissed RETURNING VALUE(ev_is_pissed) TYPE abap_boolean,

      get_items RETURNING VALUE(et_items) TYPE ty_items.


  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: name      TYPE ty_name,
          is_pissed TYPE abap_boolean,
          items     TYPE ty_items.

ENDCLASS.

CLASS zoo_person IMPLEMENTATION.

  METHOD curse.
    if is_pissed = abap_true.
        returning_curse = 'hate this fucking job.'.
    ELSE.
        returning_curse = 'what a wonderfull day to be a zookeeper'.
    ENDIF.
  ENDMETHOD.


  METHOD feed.
    if is_pissed = abap_false.
        io_animal->eat( food = iv_food ).
        remove_item( iv_remove = iv_food ).
*        WRITE 'wrong food'.
    Else.
        WRITE 'nothing to eat for you'.
    ENDIF.
  ENDMETHOD.


  METHOD constructor.
    name = iv_name.
    is_pissed = iv_is_pissed.
    items = it_items.
  ENDMETHOD.


  METHOD add_item.
    items = VALUE #( BASE items ( iv_add ) ).
  ENDMETHOD.


  METHOD remove_item.
    DATA ind TYPE i.
    ind = 1.
    LOOP at items INTO DATA(item).
        IF item EQ iv_remove.
            DELETE items INDEX ind.
            exit.
        ELSE.
            ind += ind.
        ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD get_is_pissed.
    ev_is_pissed = is_pissed.
  ENDMETHOD.

  METHOD get_items.
    et_items = items.
  ENDMETHOD.

  METHOD get_name.
    ev_name = name.
  ENDMETHOD.

  METHOD set_pissed.
    is_pissed = iv_is_pissed.
    if is_pissed = abap_true.
        WRITE |{ name } is now angry|.
    ELSE.
        WRITE |{ name } is now happy|.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
