class Repository_Nuget : Repository
{
    [String] $Name
    [String] $PackageManagementProvider
    [String] $InstallationPolicy
    [String] $SourceLocation
        
    <#
     # Constructor
     #>    
    Repository_Nuget([String]$Name, [String] $SourceLocation)
    {
        $this.Name = $Name
        $this.PackageManagementProvider = "NuGet"
        $this.InstallationPolicy = "Trusted"
        $this.SourceLocation = $SourceLocation
    }

    <#
     # Check if Repository Exists
     # May want to check [SourceLocation] are properly set as well
     #>
    [bool] Exists()
    {
        if(!(Get-PSRepository -Name $this.Name -ErrorAction SilentlyContinue))
        {
            return $false
        }

        return $true
    }

    [void] Register ()
    {
        if(!$this.Exists())
        {
            $parms = $this.Splat(("Name", "SourceLocation", "InstallationPolicy"))
            Register-PSRepository @parms
        }
    }

    [void] Set ()
    {
        if($this.Exists())
        {
            $parms = $this.Splat(("Name", "SourceLocation", "InstallationPolicy"))
            Set-PSRepository @parms
        }
    }

    [void] Unregister ()
    {
        if($this.Exists())
        {
            Unregister-PSRepository -Name $this.Name
        }
    }

    [PSCustomObject] Get ()
    {
        return Get-PSRepository -Name $this.Name
    }

}