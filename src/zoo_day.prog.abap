*&---------------------------------------------------------------------*
*& Report zoo_day
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zoo_day.

DATA maurice TYPE REF TO zoo_dove.
maurice = NEW #( volume_in = '10' name = 'Maurice' gender = 'M' color = 'Blue' height = '150' span = '10').

DATA max TYPE REF TO zoo_person.
max = NEW #( iv_name = 'Max' iv_is_pissed = abap_false it_items = VALUE #( (  ) )  ).

maurice->curr(  ).
maurice->shit( person = max ).


DATA mag TYPE REF TO zoo_magpie.
mag = NEW #( name = 'Mag' gender = 'M' color = 'Blue' height = '150' span = '10').

max->add_item( 'Berries' ).
max->add_item( 'Chocolate' ).
max->add_item( 'Gun' ).
max->add_item( 'Coin' ).
mag->steal( max ).
mag->fly_down( 1000 ).
