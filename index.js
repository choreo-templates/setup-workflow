const core = require('@actions/core');
// const github = require('@actions/github');
// const exec = require("child_process").exec;
const exec = require('@actions/exec').exec;
const path = require('path');

try {
    // const workflowType = "byoc";
    const workflowType = core.getInput('type', { required: true });
    const envListSecret = core.getInput('envList', { required: true });
    const updatedEnvListSecret = core.getInput('updatedEnvList', { required: true });
    const scriptFileName = workflowType === "byoc" ? "shell-scripts/byoc.sh" : "shell-scripts/ballerina-workflows.sh";

    let inputList = [envListSecret, updatedEnvListSecret];
    if (workflowType != "byoc") {
        const privateAppToken = core.getInput('privateAppToken', { required: true });
        inputList.push(privateAppToken);
    }
    const filePath = path.resolve(__dirname, scriptFileName);
    exec(`chmod 0777 ${filePath}`);
    exec(`sh ${filePath}`, inputList);

} catch (error) {
    core.setFailed(error.message);
}