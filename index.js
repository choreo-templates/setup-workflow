const core = require('@actions/core');
// const github = require('@actions/github');
// const exec = require("child_process").exec;
const exec = require('@actions/exec').exec;
const path = require('path');

try {
    const workflowType = core.getInput('type');
    // const workflowType = "byoc";
    if (workflowType === "byoc") {
        const filePath = path.resolve(__dirname, 'shell-scripts/byoc.sh');
        exec(`chmod 0777 ${filePath}`);
        exec(`sh ${filePath}`);
    }
} catch (error) {
    core.setFailed(error.message);
}