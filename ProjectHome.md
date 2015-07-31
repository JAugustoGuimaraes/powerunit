fork from maodd's [PowerUnit](http://sourceforge.net/projects/powerunit/) in turn based on [PBUnit](http://sourceforge.net/projects/pbunit/)

## How to Setup IDE and Bootstrap PBLs ##

Install the [PuskOK GIT SCC proxy](http://www.pushok.com/software/git.html)

Check out with external git tool

After checkout, uncheck read-only for the entire repository

1. Open the workspace
> It will complain in cannot open the target, this is OK

2. Fix the SCC settings
> Right Click on the Workspace,
> Go to Properties,
> Go to Source Control,
> Select PushOK GITSCC as the Source Control System,
> The Local Root Directory should be on the project folder (e.g. "pbunit") not in "src",
> Click Connect

3. Close the Workspace
> ORCAscript will fail if it is open

4. Fix scripts\bootstrap.orca with your information:
> SCC get connect properties "C:\kode\powerunit\src\pbunit.pbw",
> SCC set connect property userid "alarsen.cap@gmail.com"

5. Run the bootstrap script
> if orcascr125.exe is on your system path, just run scripts/bootstrap.cmd
> if not, find orcascr125.exe in "C:\Program Files (x86)\Sybase\Shared\PowerBuilder\"
> and use bootstrap.orca

6. Open the Workspace and add the target "pbunitgui.pbt"
> It might complain about not beeing checked out, just hit OK

7. Refresh Status
> Right click the target,
> Refresh Status


The Workspace and IDE is now in a state you can work with!