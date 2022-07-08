log_action() {
    local PURPLE='\033[0;35m'
    local NC='\033[0m' # No Color
    echo -e "\n${PURPLE}$1 ${NC}..."
}
export -f log_action

log_action_success() {
    local PURPLE='\033[0;35m'
    local NC='\033[0m' # No Color
    echo -e "\n${PURPLE}$1 ${NC}..."
}
export -f log_action_success

log_key_value_pair() {
    echo -e "\t\t$1: $2"
}
export -f log_key_value_pair

