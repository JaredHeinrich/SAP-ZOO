CLASS zoo_dove DEFINITION INHERITING FROM zoo_bird
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
        constructor
            IMPORTING
                volume_in TYPE i
                name    TYPE name_type
                gender  TYPE gender_type
                color   TYPE color_type
                height  TYPE i
                span    TYPE i,
        shit
            IMPORTING
                person TYPE REF TO zoo_person,
        curr.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: volume type i.
ENDCLASS.



CLASS zoo_dove IMPLEMENTATION.
    METHOD constructor.
        super->constructor( name = name
                            gender = gender
                            color = color
                            height = height
                            span = span ).
        volume = volume_in.
    ENDMETHOD.

    METHOD shit.
        person->set_pissed( abap_true ).
        WRITE / |{ zoo_animal~name } pissed { person->get_name( ) } off.|.
    ENDMETHOD.

    METHOD curr.
        DO volume TIMES.
            WRITE / 'curr'.
        ENDDO.

    ENDMETHOD.
ENDCLASS.
