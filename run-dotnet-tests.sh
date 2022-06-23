set -e 

if [[ "$CREATE_REPORTS" == "true" ]]; then
    dotnet test $SLN -c Release --collect:"XPlat Code Coverage" --results-directory $UT_RESULTS_FOLDER
else
    dotnet test $SLN -c Release
fi