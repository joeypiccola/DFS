# DFSConfig

A demo DSC configuration for managing DFS with the XDFS resource.

## DSC



## Demo

### "Uh-oh"

1. go and delete the entire File domain-based namespace
2. initiate an 'Update-DSCConfiguration -ComputerName dfs01' on our DFS server
3. be patient

### 'Create a new namespace server for the Offices and Files namespace"

1. add dfs04 to our configuration data
2. publish our updated configuration (this generates our mofs)
3. generate our LCM configs (this generates our meta.mofs)
4. initiate a 'Set-DscLocalConfigurationManager -Path .\meta.mofs\ -Verbose -Force' (tells dfs04, this is how you get your configuration)
5. initiate an 'Update-DscConfiguration -wait -Verbose -ComputerName dfs04'
6. be patient
