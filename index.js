const core = require('@actions/core');
const github = require('@actions/github');
const exec = require("child_process").exec;

try {
    const workflowType = core.getInput('type');
    if (workflowType === "byoc") {
        exec('sudo sh ./shell-scripts/byoc.sh', function (error, stdout, stderr) {
            console.log(error, stdout, stderr);
        })
    }
} catch (error) {
    core.setFailed(error.message);
}