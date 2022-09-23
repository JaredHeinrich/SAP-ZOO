interface ZOO_ANIMAL
  public .
    DATA: name      type c LENGTH 20,
          is_hungry type abap_boolean,
          gender    type c LENGTH 1,
          color     TYPE c LENGTH 20,
          food      TYPE STANDARD TABLE OF string WITH EMPTY KEY.

    METHODS: eat IMPORTING food type string EXCEPTIONS wrong_food,
             move                           EXCEPTIONS hungry,
             sleep                          EXCEPTIONS exhausted.
endinterface.
