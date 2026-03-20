# ShutdownAlert
An alert that prevents shutdown for a custom reminder.

# Install
1. Copy the ```shutdown-blocker``` script to ```C:\scripts```.
2. Win + R
3. ```shell:startup```
4. Create a shotcut with ```powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File C:\scripts\shutdown-blocker.ps1```
5. Restart

# How it works
1. Upon startup, the script gets picked up and run
2. Upon shutdown, the script blocks shutdown. (Similar to how unsaved documents block)
3. (Force shutdown still works)
4. Cancel shutdown
5. Alert is shown
6. Press cancel -> showdown is cancelled
7. Press OK -> Shutdown is initiated again without blockage

# TODO
- [ ] OK always shuts down, but sometimes we want a restart or other?
- [ ] Test if other actions - logout, restart - get blocked, or if only shutdown?
- [ ] Keep force and not force shutdowns. Using this blocker seem to result in slower turn ons due to losing quick shutdowns (memory/cache is cleared?) - but not sure.
