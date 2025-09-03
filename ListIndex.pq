let
    Source = Csv.Document(File.Contents("C:\MontBlancData\FULL_DATA_AIGLETON_CSV.csv"),[Delimiter=",", Columns=89, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"En-têtes promus" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Type modifié" = Table.TransformColumnTypes(#"En-têtes promus",{{"__id", Int64.Type}, {"NUM_POSTE", Int64.Type}, {"NOM_USUEL", type text}, {"LAT", type text}, {"LON", type text}, {"ALTI", Int64.Type}, {"AAAAMMJJ", type date}, {"DHUMEC", type text}, {"QDHUMEC", type text}, {"PMERM", type text}, {"QPMERM", type text}, {"PMERMIN", type text}, {"QPMERMIN", type text}, {"INST", type text}, {"QINST", type text}, {"GLOT", type text}, {"QGLOT", type text}, {"DIFT", type text}, {"QDIFT", type text}, {"DIRT", type text}, {"QDIRT", type text}, {"INFRART", type text}, {"QINFRART", type text}, {"UV", type text}, {"QUV", type text}, {"UV_INDICEX", type text}, {"QUV_INDICEX", type text}, {"SIGMA", type text}, {"QSIGMA", type text}, {"UN", type text}, {"QUN", type text}, {"HUN", type text}, {"QHUN", type text}, {"UX", type text}, {"QUX", type text}, {"HUX", type text}, {"QHUX", type text}, {"UM", Int64.Type}, {"QUM", Int64.Type}, {"DHUMI40", type text}, {"QDHUMI40", type text}, {"DHUMI80", type text}, {"QDHUMI80", type text}, {"TSVM", type text}, {"QTSVM", Int64.Type}, {"ETPMON", type text}, {"QETPMON", type text}, {"ETPGRILLE", type text}, {"QETPGRILLE", Int64.Type}, {"ECOULEMENTM", type text}, {"QECOULEMENTM", type text}, {"HNEIGEF", type text}, {"QHNEIGEF", type text}, {"NEIGETOTX", Int64.Type}, {"QNEIGETOTX", Int64.Type}, {"NEIGETOT06", Int64.Type}, {"QNEIGETOT06", Int64.Type}, {"NEIG", type text}, {"QNEIG", type text}, {"BROU", type text}, {"QBROU", type text}, {"ORAG", type text}, {"QORAG", type text}, {"GRESIL", type text}, {"QGRESIL", type text}, {"GRELE", type text}, {"QGRELE", type text}, {"ROSEE", type text}, {"QROSEE", type text}, {"VERGLAS", type text}, {"QVERGLAS", type text}, {"SOLNEIGE", type text}, {"QSOLNEIGE", type text}, {"GELEE", type text}, {"QGELEE", type text}, {"FUMEE", type text}, {"QFUMEE", type text}, {"BRUME", type text}, {"QBRUME", type text}, {"ECLAIR", type text}, {"QECLAIR", type text}, {"NB300", type text}, {"QNB300", type text}, {"BA300", type text}, {"QBA300", type text}, {"TMERMIN", type text}, {"QTMERMIN", type text}, {"TMERMAX", type text}, {"QTMERMAX", type text}}),
    #"Autres colonnes supprimées" = Table.SelectColumns(#"Type modifié",{"NOM_USUEL", "AAAAMMJJ", "NEIGETOTX"}),
    #"Lignes filtrées" = Table.SelectRows(#"Autres colonnes supprimées", each [AAAAMMJJ] >= #date(2024, 10, 1) and [AAAAMMJJ] <= #date(2025, 6, 1)),
    #"Index ajouté" = Table.AddIndexColumn(#"Lignes filtrées", "Index", 0, 1, Int64.Type),
    #"Diff_J+1-MOINS_J" = Table.AddColumn(
            #"Index ajouté",
            "NEIGETOTX_J+1_MOINS_J",
            each if [Index] = 0 then null 
                else #"Index ajouté"[NEIGETOTX]{ [Index]} - #"Index ajouté"[NEIGETOTX]{ [Index] - 1},
            type number
        ),
    #"Colonnes supprimées" = Table.RemoveColumns(#"Diff_J+1-MOINS_J",{"Index"})
in
    #"Colonnes supprimées"