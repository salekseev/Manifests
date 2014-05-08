import json, sys

tasks = json.load(sys.stdin)["tasks"]
for task in tasks:
    status = task["Tasks"]["status"]
    if status == "IN_PROGRESS":
        sys.stdout.write("Executing task %s\n" % task["Tasks"]["command_detail"])
    if status == "FAILED":
        sys.stderr.write("Task %s failed: %s\n" % (task["Tasks"]["command_detail"], task["Tasks"]["stderr"]))
        sys.exit(2)
    if status != "COMPLETED":
        sys.exit(1)
