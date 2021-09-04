# Powershell information

From the shell to open the ISE use

`PSEdit [-FileNames] <string[]>`

## Remoting

* https://docs.microsoft.com/en-us/powershell/scripting/learn/remoting/running-remote-commands?view=powershell-7
* https://docs.microsoft.com/en-us/powershell/scripting/learn/remoting/winrmsecurity?view=powershell-7
* https://techcommunity.microsoft.com/t5/premier-field-engineering/what-port-does-powershell-remoting-use/ba-p/571480

WINRM

TCP

    HTTP: 5985
    HTTPS: 5986

From the Technet article above use:

> You can set PowerShell remoting to use 80 (HTTP and 443 (HTTPS) by running the following commands
>
> ```
> Set-Item WSMan:\localhost\Service\EnableCompatibilityHttpListener -Value true
> Set-Item WSMan:\localhost\Service\EnableCompatibilityHttpsListener -Value true
> ```


## Examples

### Maps (Dict) and List

```
$d = @{
    't'= 'lista', 'listb'
    'a'= 'boo'
    'test'= @{
        name='foo item 1'
    },
    @{
        name='foo item 2'
    }
}
