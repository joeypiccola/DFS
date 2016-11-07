[DscLocalConfigurationManager()]
Configuration DFS_LCM_Config
{
    node $allnodes.nodename
    {
        Settings
        {
            RefreshFrequencyMins            = 30;
            RefreshMode                     = "PULL";
            ConfigurationMode               ="ApplyAndAutocorrect";
            AllowModuleOverwrite            = $true;
            RebootNodeIfNeeded              = $true;
            ConfigurationModeFrequencyMins  = 15;
            CertificateID                   = $node.thumbprint
            ActionAfterReboot               = 'ContinueConfiguration'
        }
        ConfigurationRepositoryWeb jpiPullServer
        {
            ServerURL                       = 'https://dscpull01.ad.piccola.us:8080/PSDSCPullServer.svc'    
            RegistrationKey                 = '2b3fa01b-9ee4-452d-94c3-2f637502e761'  
            ConfigurationNames              = $node.nodename
        }     
    }
}

DFS_LCM_Config -OutputPath '.\meta.mofs\' -ConfigurationData '.\ConfigurationData.psd1'