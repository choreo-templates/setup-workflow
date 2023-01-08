const core = require('@actions/core');
// const github = require('@actions/github');
const exec = require("child_process").exec;
const path = require('path');

try {
    const workflowType = core.getInput('type');
    if (workflowType === "byoc") {
        const filePath = path.resolve(__dirname, 'shell-scripts/byoc.sh');
        exec(`chmod 0777 ${filePath} && sh ${filePath}`, function (error, stdout, stderr) {
            console.log(error, stdout, stderr);
        });
    }
} catch (error) {
    core.setFailed(error.message);
}