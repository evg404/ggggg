male(ivan). male(petr). male(stepan). male(vladimir). male(dmitry). male(alex). male(boris). male(igor).
female(anna). female(maria). female(olga). female(elena). female(tatyana). female(ira). female(lera).

% --- Супруги ---
spouse(ivan, anna). spouse(anna, ivan).
spouse(petr, maria). spouse(maria, petr).
spouse(dmitry, elena). spouse(elena, dmitry).

% --- Родители ---
% Поколение (Прадеды)
parent(ivan, petr). parent(anna, petr).
parent(ivan, olga). parent(anna, olga).
parent(ivan, stepan). parent(anna, stepan).
parent(ivan, vladimir). parent(anna, vladimir).

% Поколение (Деды/Родители)
parent(petr, dmitry). parent(maria, dmitry).
parent(olga, boris).
parent(vladimir, igor).

% Поколение (Родители/Дети)
parent(dmitry, alex).
parent(boris, ira).
parent(igor, lera).

% Поколение (Правнуки)
parent(alex, tatyana).


% --- Вспомогательные правила ---
father(X, Y) :- parent(X, Y), male(X).
mother(X, Y) :- parent(X, Y), female(X).

% Родные братья и сестры (через отца, чтобы избежать дублей)
sibling(X, Y) :- father(P, X), father(P, Y), X \= Y.

% Двоюродные братья и сестры (дети родных братьев/сестер)
cousin(X, Y) :- parent(PX, X), parent(PY, Y), sibling(PX, PY).

% --- А. Близкие кровные родственники ---
% Сестра (sister)
sister(X, Y) :- female(X), sibling(X, Y).

% --- Б. Неблизкие кровные родственники ---
% Правнучка (great_granddaughter)
great_granddaughter(X, Y) :- female(X), parent(G, X), parent(P, G), parent(Y, P).

% Двоюродная тетя (first_cousin_aunt) - двоюродная сестра отца или матери
first_cousin_aunt(X, Y) :- female(X), parent(P, Y), cousin(X, P).

% Двоюродная племянница (n_cousin_niece) - дочь двоюродного брата или сестры
n_cousin_niece(X, Y) :- female(X), parent(P, X), cousin(P, Y).

% --- С. Родственники по закону ---
% Деверь (husbands_brother) - брат мужа
husbands_brother(X, Woman) :- female(Woman), spouse(Woman, Husband), male(X), sibling(X, Husband).