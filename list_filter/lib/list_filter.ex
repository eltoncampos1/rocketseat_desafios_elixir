defmodule ListFilter do
  def call(list) do
    filtered_list = Enum.filter(list, fn elem -> parse_and_check_is_odd(Integer.parse(elem)) end)

    length(filtered_list)
  end

  defp parse_and_check_is_odd(:error), do: false

  defp parse_and_check_is_odd({intVal, _}), do: rem(intVal, 2) == 1
end
