defmodule GenReport do
  alias GenReport.Parser

  @avariable_persons [
    "daniele",
    "mayk",
    "giuliano",
    "cleiton",
    "jakeliny",
    "joseph",
    "diego",
    "danilo",
    "rafael",
    "vinicius"
  ]
  def build(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(report_acc(), &sum_values(&1, &2))
  end

  def build do
    {:error, "Insira o nome de um arquivo"}
  end

  defp sum_values([person, hour, _day, month, year], %{
         "all_hours" => all_hours,
         "hours_per_month" => hours_per_month,
         "hours_per_year" => hours_per_year
       }) do
    all_hours = Map.put(all_hours, person, all_hours[person] + hour)
    months = hours_per_month[person]
    months = Map.put(months, month, months[month] + hour)
    hours_per_month = Map.put(hours_per_month, person, months)
    years = hours_per_year[person]
    years = Map.put(years, year, years[year] + hour)
    hours_per_year = Map.put(hours_per_year, person, years)
    build_reports(all_hours, hours_per_month, hours_per_year)
  end

  defp report_acc() do
    all_hours = build_acc(@avariable_persons)
    months = Enum.into(1..12, %{}, &{Parser.month_name(&1), 0})
    years = build_acc(2016..2020)
    hours_per_month = build_acc(@avariable_persons, months)
    hours_per_year = build_acc(@avariable_persons, years)
    build_reports(all_hours, hours_per_month, hours_per_year)
  end

  defp build_reports(all_hours, hours_per_month, hours_per_year) do
    %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_year" => hours_per_year
    }
  end

  defp build_acc(acc, param \\ 0) do
    Enum.into(acc, %{}, &{&1, param})
  end
end
