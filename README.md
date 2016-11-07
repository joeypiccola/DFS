# DFSConfig

A demo DSC configuration for managing DFS with the xDFS resource.

## DSC
> DSC is a new management platform in Windows PowerShell that enables deploying and managing configuration data for software services and managing the environment in which these services run.
> DSC provides a set of Windows PowerShell language extensions, new Windows PowerShell cmdlets, and resources that you can use to declaratively specify how you want your software environment to be configured.

DSC works by defining configurations that are either pushed or pulled to endpoints. These configurations are natively applied to systems. DSC is intended to be a platform for configuration management, IT IS NOT AN END TO END SOLUTION. Tooling, standards, and processes must be used.

### Declarative what?
DSC works by building declarative configuration files. These configuration files describe the configuration and do not actually contain the code to execute the configuration.

```PowerShell
File Namespace_directory
{
    Ensure          = 'Present'
    DestinationPath = 'c:\dfsroots\files'
    Type            = 'Directory'
}

xSMBShare Namespace_share
{
    Name       = 'Files'
    FullAccess = 'ad\domain admins'
    ReadAccess = 'Everyone'
    Path       = 'C:\DFSRoots\Files'
    Ensure     = 'Present'
}

xDFSNamespaceRoot Namespace_root
{
    Path       = '\\ad.piccola.us\Files'
    TargetPath = '\\dfs01.ad.piccola.us\Files'
    Type       = 'DomainV2'
    Ensure     = 'present'
}
```

## Demo

### Uh-oh

1. go and delete the entire File domain-based namespace
2. initiate an 'Invoke-DscPull dfs0x -Verbose' on each DFS server
3. be patient and check dfsmgmt.msc

### Create a new namespace server for the Offices and Files namespace

1. add dfs04 to our configuration data
2. publish our updated configuration (this generates our mofs)
3. generate our LCM configs (this generates our meta.mofs)
4. initiate a 'Set-DscLocalConfigurationManager -Path .\meta.mofs\ -Verbose -Force' (tells dfs04, this is how you get your configuration)
5. initiate an 'Update-DscConfiguration -wait -Verbose -ComputerName dfs04' (we can use update and no invoke bc no config exists yet)
6. be patient and check dfsmgmt.msc

### Source control
Lets talk about source control.
