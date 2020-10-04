let
    Источник =
        Access.Database(
            File.Contents("\\Mac\Home\Documents\Рабочие\ГПН\14_Ставки ФРС\Категории со ставками.accdb"),
            [CreateNavigationProperties = true]
        ),
    #"_Справочник ставок" =
        Источник{[
            Schema = "",
            Item = "Справочник ставок"
        ]}
            [Data],
    #"Удаленные столбцы" =
        Table.RemoveColumns(
            #"_Справочник ставок",
            {"Код"}
        ),
    #"Период ставки" =
        Table.TransformColumns(
            #"Удаленные столбцы",
            {
                {
                    "Дата ставки",
                    each DateTime.ToText(_, "MM.yyyy"),
                    type text
                }
            }
        )
in
    #"Период ставки"