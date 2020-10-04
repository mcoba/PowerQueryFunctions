/* Загрузка фактических рабочих часов */

let
    Источник =
        Excel.Workbook(
            File.Contents("Y:\Проекты\01_ИТСК\U160000653 EHP8\02_PRJ.19335_HANA\p06_Отчётность\06_Факт ТРЗ\PRJ.19335 факт ТРЗ.xlsx"),
            null,
            true
        ),
    TDSheet_Sheet =
        Источник{[
            Item = "TDSheet",
            Kind = "Sheet"
        ]}
            [Data],
    #"Повышенные заголовки" =
        Table.PromoteHeaders(
            TDSheet_Sheet,
            [PromoteAllScalars = true]
        ),
    #"Измененный тип" =
        Table.TransformColumnTypes(
            #"Повышенные заголовки",
            {
                {
                    "Проект",
                    type text
                },
                {
                    "Регион",
                    type text
                },
                {
                    "ЦФО",
                    type text
                },
                {
                    "Период месяц",
                    type date
                },
                {
                    "Сотрудник.Наименование",
                    type text
                },
                {
                    "Сотрудник.Код",
                    type text
                },
                {
                    "Вид РВ",
                    type text
                },
                {
                    "Часы",
                    type number
                }
            }
        ),
    #"Период месяц" =
        Table.TransformColumns(
            #"Измененный тип",
            {
                {
                    "Период месяц",
                    each Date.ToText(_, "MM.yyyy"),
                    type text
                }
            }
        ),
    #"Переупорядоченные столбцы" =
        Table.ReorderColumns(
            #"Период месяц",
            {
                "Проект",
                "Период месяц",
                "Регион",
                "ЦФО",
                "Сотрудник.Наименование",
                "Сотрудник.Код",
                "Вид РВ",
                "Часы"
            }
        ),
    #"Сортированные строки" =
        Table.Sort(
            #"Переупорядоченные столбцы",
            {
                {
                    "Период месяц",
                    Order.Ascending
                },
                {
                    "Регион",
                    Order.Ascending
                },
                {
                    "ЦФО",
                    Order.Ascending
                },
                {
                    "Сотрудник.Наименование",
                    Order.Ascending
                },
                {
                    "Вид РВ",
                    Order.Ascending
                }
            }
        )
in
    #"Сортированные строки"