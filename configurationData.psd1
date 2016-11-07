 @{
    AllNodes = @(
        @{
            Nodename             = 'dfs01'
            NameSpacesToHost     = 'Files','Offices'
            CertificateFile      = "C:\DSC\configs\dfs\certs\dfsconfig.cer"
            Thumbprint           = 'D41C581A53F35CF1CB30A6C91BFB8B28F5B747F0'
            PSDscAllowDomainUser = $true
        }
        @{
            Nodename             = 'dfs02'
            NameSpacestoHost     = 'Files','Regions'
            CertificateFile      = "C:\DSC\configs\dfs\certs\dfsconfig.cer"
            Thumbprint           = 'D41C581A53F35CF1CB30A6C91BFB8B28F5B747F0'
            PSDscAllowDomainUser = $true
        }
        @{
            Nodename             = 'dfs03'
            NameSpacestoHost     = 'Files','Regions','Offices'
            CertificateFile      = "C:\DSC\configs\dfs\certs\dfsconfig.cer"
            Thumbprint           = 'D41C581A53F35CF1CB30A6C91BFB8B28F5B747F0'
            PSDscAllowDomainUser = $true
        }
    )

    BaseSettings = @{
        RootsFilePath = 'c:\DFSRoots'
        Features = 'FS-DFS-Namespace','RSAT-DFS-Mgmt-Con'
    }

    NameSpaceFolders = @(
        #region files
        @{
            Name      = 'files-stuff-docs'
            Folder    = '\\ad.piccola.us\files\stuff\docs'
            Target    = '\\box.ad.piccola.us\docs\New folder'
            NameSpace = 'Files'
            State     = 'Absent'
        }
        @{
            Name      = 'files-stuff-scripts'
            Folder    = '\\ad.piccola.us\files\stuff\docs'
            Target    = '\\box.ad.piccola.us\dscmodules\scripts'
            NameSpace = 'Files'
            State     = 'Present'
        }
        @{
            Name      = 'files-stuff-one'
            Folder    = '\\ad.piccola.us\files\stuff\one'
            Target    = '\\box.ad.piccola.us\dscmodules\dummyShare'
            NameSpace = 'Files'
            State     = 'Present'
        }
        @{
            Name      = 'files-stuff-two'
            Folder    = '\\ad.piccola.us\files\stuff\two'
            Target    = '\\box.ad.piccola.us\dscmodules\dummyShare'
            NameSpace = 'Files'
            State     = 'Present'
        }
        @{
            Name      = 'files-stuff-three'
            Folder    = '\\ad.piccola.us\files\stuff\three'
            Target    = '\\box.ad.piccola.us\dscmodules\dummyShare'
            NameSpace = 'Files'
            State     = 'Present'
        }
        @{
            Name      = 'files-stuff-four'
            Folder    = '\\ad.piccola.us\files\stuff\four'
            Target    = '\\box.ad.piccola.us\dscmodules\dummyShare'
            NameSpace = 'Files'
            State     = 'Present'
        }
        #endregion
        #region offices
        @{
            Name      = 'offices-denver'
            Folder    = '\\ad.piccola.us\offices\Denver'
            Target    = '\\box.ad.piccola.us\dscmodules\dummyShare'
            NameSpace = 'Offices'
            State     = 'Present'
        }
        @{
            Name      = 'offices-dallas'
            Folder    = '\\ad.piccola.us\offices\Dallas'
            Target    = '\\box.ad.piccola.us\dscmodules\dummyShare'
            NameSpace = 'Offices'
            State     = 'Present'
        }
        @{
            Name      = 'offices-miami'
            Folder    = '\\ad.piccola.us\offices\Miami'
            Target    = '\\box.ad.piccola.us\dscmodules\dummyShare'
            NameSpace = 'Offices'
            State     = 'Present'
        }
        @{
            Name      = 'offices-sanjose'
            Folder    = '\\ad.piccola.us\offices\SanJose'
            Target    = '\\box.ad.piccola.us\dscmodules\dummyShare'
            NameSpace = 'Offices'
            State     = 'Present'
        }
        @{
            Name      = 'offices-ashburn'
            Folder    = '\\ad.piccola.us\offices\Ashburn'
            Target    = '\\box.ad.piccola.us\dscmodules\dummyShare'
            NameSpace = 'Offices'
            State     = 'Present'
        }
        #endregion
        #region regions
        @{
            Name      = 'regions-docs'
            Folder    = '\\ad.piccola.us\regions\docs'
            Target    = '\\box.ad.piccola.us\dscmodules\dummyShare'
            NameSpace = 'Regions'
            State     = 'Present'
        }
        @{
            Name      = 'regions-training'
            Folder    = '\\ad.piccola.us\regions\training'
            Target    = '\\box.ad.piccola.us\dscmodules\dummyShare'
            NameSpace = 'Regions'
            State     = 'Present'
        }
        @{
            Name      = 'regions-shared'
            Folder    = '\\ad.piccola.us\regions\shared'
            Target    = '\\box.ad.piccola.us\dscmodules\dummyShare'
            NameSpace = 'Regions'
            State     = 'Present'
        }
        @{
            Name      = 'regions-field'
            Folder    = '\\ad.piccola.us\regions\field'
            Target    = '\\box.ad.piccola.us\dscmodules\dummyShare'
            NameSpace = 'Regions'
            State     = 'Present'
        }
        #endregion
    )
}