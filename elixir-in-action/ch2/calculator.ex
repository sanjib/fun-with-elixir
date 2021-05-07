defmodule Calculator do

  # Default values generate multiple functions of same name
  # with different arities
  def sum(a, b \\ 0), do: a + b

  # Following generates a compile error because sum/2 also
  # generates sum/1 where b has a default value 0
  # def sum(a), do: sum a, 0

end
