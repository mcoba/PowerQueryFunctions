(fnName as text, optional BasePath as text, optional ForcePullFromWeb as logical) as function =>
    let
        //If you wish to hardcode the path to load the queries from, you can edit the following line:
        DefaultPath = "C:\PQuery\",
        GitHubPath = "https://raw.githubusercontent.com/mcoba/PowerQueryFunctions/",
        BasePath =
            if (BasePath <> null) then
                BasePath
            else
                DefaultPath,
        Path =
            BasePath
            & (
                if Text.End(BasePath, 1) <> "\" then
                    "\"
                else
                    ""
            ),
        File = Path & fnName & ".pq",
        WebPath = GitHubPath & fnName & ".pq",
        /*Function = try Expression.Evaluate(Text.FromBinary(Binary.Buffer(File.Contents(File))), #shared)
	otherwise Expression.Evaluate( Text.FromBinary(Binary.Buffer(Web.Contents(GitHubPath & fnName & ".pq"))), #shared)*/
        Function =
            if (ForcePullFromWeb = true) then
                Expression.Evaluate(
                    Text.FromBinary(Binary.Buffer(Web.Contents(GitHubPath & fnName & ".pq"))),
                    #shared
                )
            else
                Expression.Evaluate(
                    Text.FromBinary(Binary.Buffer(File.Contents(File))),
                    #shared
                )
    in
        Function