# DFSConfig

A demo DSC configuration for managing DFS with the xDFS resource.

## DSC
DSC provides a set of Windows PowerShell language extensions, new Windows PowerShell cmdlets, and resources that you can use to declaratively specify how you want your system to be configured. DSC works by defining configurations that are either pushed or pulled to endpoints. These configurations are natively applied to the system.  

### Declarative what?
DSC works by building declarative configuration files. These configuration files declare the desired configuration and do not actually list how to do it.

```PowerShell
File Namespace_directory
{
    Ensure          = 'Present'
    DestinationPath = 'c:\dfsroots\files'
    Type            = 'Directory'
}

xSMBShare Namespace_DFSShare
{
    Name       = 'Files'
    FullAccess = 'ad\domain admins'
    ReadAccess = 'Everyone'
    Path       = 'C:\DFSRoots\Files'
    Ensure     = 'Present'
}

xDFSNamespaceRoot Namespace_root
{
    Path                 = '\\ad.piccola.us\Files'
    TargetPath           = "\\dfs01.ad.piccola.us\Files"
    Ensure               = 'present'
    Type                 = 'DomainV2'
}
```

## Demo

### Uh-oh

1. go and delete the entire File domain-based namespace
2. initiate an 'Update-DSCConfiguration -ComputerName dfs01' on our DFS server
3. be patient

### Create a new namespace server for the Offices and Files namespace

1. add dfs04 to our configuration data
2. publish our updated configuration (this generates our mofs)
3. generate our LCM configs (this generates our meta.mofs)
4. initiate a 'Set-DscLocalConfigurationManager -Path .\meta.mofs\ -Verbose -Force' (tells dfs04, this is how you get your configuration)
5. initiate an 'Update-DscConfiguration -wait -Verbose -ComputerName dfs04'
6. be patient
