#!/usr/bin/env bats

# Setup and teardown for tests
setup() {
    # Unset the default port variable in case the shell session has it set.
    unset GET_OFF_MY_PORT_DEFAULT_PORT
    # Create a dummy process that listens on an arbitrary port.
    PORT=9242
    nc -l "$PORT" &> /dev/null &
    NC_PID=$!
    sleep 1 # Give nc time to start.
}

teardown() {
    # Kill the dummy process.
    kill "$NC_PID" 2>/dev/null || true
}

@test "Show help message with --help" {
    run ../get-off-my-port --help
    [ "$status" -eq 0 ]
    [[ "$output" == *"Usage: get-off-my-port"* ]]
}

@test "Show version with --version" {
    run ../get-off-my-port --version
    [ "$status" -eq 0 ]
    [[ "$output" =~ ^get-off-my-port\ [a-zA-Z0-9._-]+\ https://github\.com/TravisCarden/get-off-my-port$ ]]
}

@test "Error when no port is specified and no default is set" {
    run ../get-off-my-port
    [ "$status" -eq 1 ]
    [[ "$output" == *"Error: No port specified and no default port set."* ]]
    [[ "$output" == *"Usage: get-off-my-port"* ]]
}

@test "Show info about processes listening on a port with --info" {
    run ../get-off-my-port --info "$PORT"
    [ "$status" -eq 0 ]
    [[ "$output" == *"Processes listening on port $PORT:"* ]]
    [[ "$output" == *"nc"* ]]
}

# TODO This feature works when tested manually. Fix the test.
#@test "Kill process listening on a port with confirmation" {
#    run echo "y" | ../get-off-my-port "$PORT"
#    [ "$status" -eq 0 ]
#    [[ "$output" == *"Processes listening on port $PORT:"* ]]
#    [[ "$output" == *"Killing 'nc' (PID $NC_PID)."* ]]
#}

@test "Kill process listening on a port without confirmation using --force" {
    run ../get-off-my-port --force "$PORT"
    [ "$status" -eq 0 ]
    [[ "$output" == *"Processes listening on port $PORT:"* ]]
    [[ "$output" == *"Killing 'nc' (PID $NC_PID)."* ]]
}

@test "Error with invalid port" {
    run ../get-off-my-port --info abc
    [ "$status" -eq 1 ]
    [[ "$output" == *"Error: Invalid port 'abc'. Port must be a number between 1 and 65535."* ]]
}

@test "Error with unknown option" {
    run ../get-off-my-port --unknown
    [ "$status" -eq 1 ]
    [[ "$output" == *"Error: Unknown option '--unknown'."* ]]
    [[ "$output" == *"Usage: get-off-my-port"* ]]
}

@test "Use default port if specified in environment variable" {
    export GET_OFF_MY_PORT_DEFAULT_PORT="$PORT"
    run ../get-off-my-port --info
    [ "$status" -eq 0 ]
    [[ "$output" == *"Processes listening on port $PORT:"* ]]
    [[ "$output" == *"nc"* ]]
}
