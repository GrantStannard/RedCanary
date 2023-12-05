
# Goal
This project should run certain actions and log the information to a file.

This log file can be compared to the data from Red Canary's _Endpoint Detection and Response_ (EDR) agents as a regression
test. This is useful to verify everything is working as intended after an update.

# Modules
There are two core pieces to the program:
1. `Command` module
2. `Main` module

## Command Module
The `Command` module contains the commands that need to be tested during regression testing (per the handout).

### Commands
1. `run_process`
2. `create_file`
3. `modify_file`
4. `delete_file`
5. `send_data`

### Logging
It logs what command ran with some additional information (process start time, PID, etc.). This information varies
based on which command was run. Different processes log slightly different information.

#### Sample Log File
```txt
{"date":"2023-12-04 22:19:55","pid":"#54577","user":1000,"process_name":"-e","file_path":"/home/grant/RubymineProjects/RedCanary/test.txt","activity":"File Creation"}
{"date":"2023-12-04 22:19:55","pid":"#54577","user":1000,"process_name":"-e","file_path":"/home/grant/RubymineProjects/RedCanary/test.txt","activity":"File Modification"}
{"date":"2023-12-04 22:19:55","pid":"#54577","user":1000,"process_name":"-e","file_path":"/home/grant/RubymineProjects/RedCanary/test.txt","activity":"File Deletion"}
{"date":"2023-12-04 22:19:56","pid":"#54577","user":1000,"process_name":"-e","address":"https://httpbin.org/anything","port":443,"data_size":8}
{"date":"2023-12-04 22:19:56","pid":"#54577","user":1000,"process_name":"-e","process":"ls "}
```

## Main Module
The `Main` module is the entry point to the application. Each command (`run_process`, `create_file`, `modify_file`,
`delete_file`, and `send_data`) is run when the `run` method is called and logged to either a default log file or the
provided log file.

`Main.run` is designed to be called from the command line.

#### Default Log File
```bash
ruby -r ./main.rb -e "Main.run()"
````

#### Custom Log File
A file location (either relative or absolute) can be passed to the run method via `file_location` if a different log file location is desired:
```bash
ruby -r ./main.rb -e "Main.run(file_location: './testing.txt')"
```

**Note:** The current user must have permission to write to the provided folder/file location.