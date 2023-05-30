import data.real.basic


/- TEXT:

Getting Started
---------------



TEXT. -/

-- QUOTE:
#eval "Hello, World!"
-- QUOTE.

/- TEXT:

*Kursive* Schrift geht mit einfachen \*.

``Code`` Schrift geht mit einfachen \´.




Let's try out ``rw``.

.. index:: real numbers
TEXT. -/


/- This comment appears in the lean file -/

-- QUOTE:
import data.real.basic
example (a b c : ℝ) : (a * b) * c = b * (a * c) :=
begin
  rw mul_comm a b,
  rw mul_assoc b a c
end
-- QUOTE.

/- TEXT:

.. index:: proof state, local context, goal

.. code-block::

    1 goal
    x y : ℕ,
    h₁ : prime x,
    h₂ : ¬even x,
    h₃ : y > x
    ⊢ y ≥ 4


TEXT. -/

-- QUOTE:
example (a b c : ℝ) : (c * b) * a = b * (a * c) :=
begin
  sorry
end

example (a b c : ℝ) : a * (b * c) = b * (a * c) :=
begin
  sorry
end
-- QUOTE.

-- SOLUTIONS:
example (a b c : ℝ) : (c * b) * a = b * (a * c) :=
begin
  rw mul_comm c b,
  rw mul_assoc b c a,
  rw mul_comm c a
end

example (a b c : ℝ) : a * (b * c) = b * (a * c) :=
begin
  rw ←mul_assoc a b c,
  rw mul_comm a b,
  rw mul_assoc b a c
end