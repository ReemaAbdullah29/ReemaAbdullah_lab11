:- dynamic letters/1.

letters([a, b, c]).

start :-
    nl,
    writeln('Hi, This is the "Name Game".'),
    writeln('You will be given a set of English letters in which you will add, delete or move to create your name.'),
    menu.

menu :-
    nl,
    writeln('Choose from the following:'),
    writeln('1- Display the current set of letters'),
    writeln('2- Add a letter'),
    writeln('3- Add a letter at the top'),
    writeln('4- Add a letter at the bottom'),
    writeln('5- Delete a letter'),
    writeln('6- Delete all letters'),
    writeln('7- Exit'),
    write('Enter your choice....'), nl,
    write('|: '),
    read(Option),
    process(Option).

process(1) :-
    letters(C),
    write('Current set of letters: '), writeln(C),
    menu.

process(2) :-
    write('Enter the letter to add: '),
    read(X),
    letters(C),
    append(X, [C], NewL),
    retractall(letters(_)),
    assertz(letters(NewL)),
    write('Added '), write(C), writeln(' successfully.'),
    menu.

process(3) :-
    write('Enter the letter to add at the top: '),
    read(X),
    letters(C),
    NewL = [X | C],
    retractall(letters(_)),
    assertz(letters(NewL)),
    write('Added '), write(X), writeln(' at the top successfully.'),
    menu.

process(4) :-
    write('Enter the letter to add at the bottom: '),
    read(X),
    letters(C),
    append(C, [X], NewL),
    retractall(letters(_)),
    assertz(letters(NewL)),
    write('Added '), write(X), writeln(' at the bottom successfully.'),
    menu.

process(5) :-
    write('Enter the letter to delete: '),
    read(X),
    letters(C),
    (   select(X, C, NewL)
    ->  retractall(letters(_)),
        assertz(letters(NewL)),
        write('Deleted '), write(X), writeln(' successfully.')
    ;   write('Letter '), write(X), writeln(' not found in the set.')
    ),
    menu.

process(6) :-
    retractall(letters(_)),
    assertz(letters([])),
    writeln('All cleared.'),
    menu.

process(7) :-
    writeln('bye').

process(_) :-
    writeln('Invalid choice'),
    menu.
