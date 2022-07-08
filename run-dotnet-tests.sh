set -e 

log_action "testing"
SLN_FOLDER=$1
log_key_value_pair "sln-folder" $SLN_FOLDER

REGEX="$SLN_FOLDER/*.sln"
log_key_value_pair "regex" "$SLN_FOLDER/*.sln"
REPORTS_FILES=""

for sln_path in $REGEX; do 
    PROJECT=${sln_path##*/}     # get file name
    PROJECT=${PROJECT%%.*}      # remove file extension
    log_action "testing solution ($PROJECT)"

    echo "::group::testing $PROJECT"
    if [[ "$ADD_REPORTS_TO_JOB_SUMMARY" == "true" ]]; then
        report_folder="./REPORTS/$PROJECT"
        dotnet test $sln_path -c Release --collect:"XPlat Code Coverage" --results-directory $report_folder

        new_path="./REPORTS/$PROJECT.coverage.cobertura.xml"    
        cp $report_folder/**/coverage.cobertura.xml $new_path   # moving report file to a common folder REPORTS
        rm -rf $report_folder

        REPORTS_FILES+="$new_path,"
    else
        dotnet test $sln_path -c Release
    fi
    echo "::endgroup::"
done

if [[ "$ADD_REPORTS_TO_JOB_SUMMARY" == "true" ]]; then
    log_action_success "reports saved at"
    REPORTS_FILES=${REPORTS_FILES::-1}
    log_key_value_pair "REPORTS_FILES" $REPORTS_FILES
    echo "REPORTS_FILES=$REPORTS_FILES" >> $GITHUB_ENV
fi
