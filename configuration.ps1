Configuration DFS
{
    param
    (
        [Parameter(Mandatory)]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.CredentialAttribute()]
        $Credential
    )

    Import-DscResource -modulename xDFS, xSMBShare, PSDesiredStateConfiguration, xPSDesiredStateConfiguration

    Node $allnodes.nodename {

        $ConfigurationData.BaseSettings.Features.foreach({
            WindowsFeature $_ {
                Name = $_
                Ensure = 'Present'
            }
        })
        
        File DFSRootDirectory 
        {
            Ensure          = 'Present'
            DestinationPath = 'c:\dfsroots'
            Type            = 'Directory'
        }

        xDFSNamespaceServerConfiguration NamespaceConfig
        {
            IsSingleInstance     = 'Yes'
            UseFQDN              = $true
            PsDscRunAsCredential = $Credential
            DependsOn            = @('[WindowsFeature]RSAT-DFS-Mgmt-Con','[WindowsFeature]FS-DFS-Namespace')
        }
    }
    
    Node $allnodes.where({$_.NameSpacesToHost -contains 'Files'}).nodename {

        xSMBShare FileNamespaceShare
        {
            DependsOn  = '[File]FileNamespaceDirectory'
            Name       = 'Files'
            FullAccess = 'ad\domain admins'
            ReadAccess = 'Everyone'
            Path       = 'C:\DFSRoots\Files'
            Ensure     = 'Present'
        }
         
        File FileNamespaceDirectory 
        {
            Ensure          = 'Present'
            DestinationPath = 'c:\dfsroots\files'
            Type            = 'Directory'
            DependsOn       = '[File]DFSRootDirectory'
        }
            
        File FileStuffNamespaceDirectory
        {
            DestinationPath = 'c:\dfsroots\files\stuff'
            Ensure          = 'Present'
            Type            = 'Directory'
            DependsOn       = '[File]FileNamespaceDirectory'
        }

        xDFSNamespaceRoot FilesNamespace
        {
            DependsOn            = @('[xSMBShare]FileNamespaceShare','[WindowsFeature]RSAT-DFS-Mgmt-Con','[WindowsFeature]FS-DFS-Namespace','[xDFSNamespaceServerConfiguration]NamespaceConfig')
            Path                 = '\\ad.piccola.us\Files'
            TargetPath           = "\\$($node.nodename)`.ad.piccola.us\Files"
            Ensure               = 'present'
            Type                 = 'DomainV2'
            PsDscRunAsCredential = $Credential
        }
        
        $configurationData.NameSpaceFolders.where({$_.NameSpace -eq 'Files'}) | % {
            xDFSNamespaceFolder "DFSNamespaceFolder-$($_.name)"
            {
                Path                 = $_.folder 
                TargetPath           = $_.target
                Ensure               = $_.state
                PsDscRunAsCredential = $Credential
                DependsOn            = '[xDFSNamespaceRoot]FilesNamespace'
            }
        }              
    }

    Node $allnodes.where({$_.NameSpacesToHost -contains 'Offices'}).nodename {

        xSMBShare OfficesNamespaceShare
        {
            DependsOn  = '[File]OfficesNamespaceDirectory'
            Name       = 'Offices'
            FullAccess = 'ad\domain admins'
            ReadAccess = 'Everyone'
            Path       = 'C:\DFSRoots\Offices'
            Ensure     = 'Present'
        }
         
        File OfficesNamespaceDirectory 
        {
            Ensure          = 'Present'
            DestinationPath = 'c:\dfsroots\Offices'
            Type            = 'Directory'
            DependsOn       = '[File]DFSRootDirectory'
        }

        xDFSNamespaceRoot OfficesNamespace
        {
            DependsOn            = @('[xSMBShare]OfficesNamespaceShare',
                                     '[WindowsFeature]RSAT-DFS-Mgmt-Con',
                                     '[WindowsFeature]FS-DFS-Namespace',
                                     '[xDFSNamespaceServerConfiguration]NamespaceConfig')
            Path                 = '\\ad.piccola.us\Offices'
            TargetPath           = "\\$($node.nodename)`.ad.piccola.us\Offices"
            Ensure               = 'present'
            Type                 = 'DomainV2'
            PsDscRunAsCredential = $Credential
        }

        $configurationData.NameSpaceFolders.where({$_.NameSpace -eq 'Offices'}) | % {
            xDFSNamespaceFolder "DFSNamespaceFolder-$($_.name)"
            {
                Path                 = $_.folder 
                TargetPath           = $_.target
                Ensure               = $_.state
                PsDscRunAsCredential = $Credential
                DependsOn            = '[xDFSNamespaceRoot]OfficesNamespace'
            }
        }              
    }

    Node $allnodes.where({$_.NameSpacesToHost -contains 'Regions'}).nodename {

        xSMBShare RegionsNamespaceShare
        {
            DependsOn  = '[File]RegionsNamespaceDirectory'
            Name       = 'Regions'
            FullAccess = 'ad\domain admins'
            ReadAccess = 'Everyone'
            Path       = 'C:\DFSRoots\Regions'
            Ensure     = 'Present'
        }
         
        File RegionsNamespaceDirectory 
        {
            Ensure          = 'Present'
            DestinationPath = 'c:\dfsroots\Regions'
            Type            = 'Directory'
            DependsOn       = '[File]DFSRootDirectory'
        }

        xDFSNamespaceRoot RegionsNamespace
        {
            DependsOn            = @('[xSMBShare]RegionsNamespaceShare','[WindowsFeature]RSAT-DFS-Mgmt-Con','[WindowsFeature]FS-DFS-Namespace','[xDFSNamespaceServerConfiguration]NamespaceConfig')
            Path                 = '\\ad.piccola.us\Regions'
            TargetPath           = "\\$($node.nodename)`.ad.piccola.us\Regions"
            Ensure               = 'present'
            Type                 = 'DomainV2'
            PsDscRunAsCredential = $Credential
        }
        
        $configurationData.NameSpaceFolders.where({$_.NameSpace -eq 'Regions'}) | % {
            xDFSNamespaceFolder "DFSNamespaceFolder-$($_.name)"
            {
                Path                 = $_.folder 
                TargetPath           = $_.target
                Ensure               = $_.state
                PsDscRunAsCredential = $Credential
                DependsOn            = '[xDFSNamespaceRoot]RegionsNamespace'
            }
        }
    }
}