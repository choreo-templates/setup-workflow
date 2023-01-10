# Setup Workflow Action

Initial setup of the Choreo workflow.

## Inputs

### `type`

**Required** Type of the workflow. Default `"byoc"`.

### `envList`

**Required** Environment Varibale Lsit.

### `updatedEnvList`

**Required** Updated Environment Varibale Lsit.

### `privateAppToken`

Private App Token for Ballerina. Default `""`.


## Example usage

```yaml
uses: choreo-templates/setup-workflow@v1
with:
  type: 'byoc'
  envList: ${{ secrets.ENV_LIST }}
  updatedEnvList: ${{ secrets.UPDATED_ENV_LIST }}
  privateAppToken: ${{ secrets.PRIVATE_APP_TOKEN }}
```