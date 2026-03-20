Add-Type @"
using System;
using System.Runtime.InteropServices;

public class ShutdownBlocker {
    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool ShutdownBlockReasonCreate(IntPtr hWnd, string pwszReason);

    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool ShutdownBlockReasonDestroy(IntPtr hWnd);
}
"@

Add-Type -AssemblyName System.Windows.Forms

$global:isManualShutdown = $false

$form = New-Object System.Windows.Forms.Form
$form.WindowState = "Minimized"
$form.ShowInTaskbar = $false

[ShutdownBlocker]::ShutdownBlockReasonCreate($form.Handle, "My custom reason for the block.")

$form.add_FormClosing({
    param($sender, $e)

    if ($e.CloseReason -eq "WindowsShutDown") {

        # If we started the shutdown -> don't block
        if ($global:isManualShutdown) {
            return
        }

        # Interrupt and prevent shutdown
        shutdown /a

        $result = [System.Windows.Forms.MessageBox]::Show(
            "My custom reminder before shutdown!",
            "Alert box title",
            "OKCancel",
            "Warning"
        )

        if ($result -eq "OK") {
            $global:isManualShutdown = $true

            # Remove our block
            [ShutdownBlocker]::ShutdownBlockReasonDestroy($form.Handle)

            # Shutdown
            shutdown /s /t 0
        } else {
            $e.Cancel = $true
        }
    }
})

[System.Windows.Forms.Application]::Run($form)
