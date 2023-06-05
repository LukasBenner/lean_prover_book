# DEST REPO


The book is designed to be read as you
work through examples and exercises,
using a copy of this repository on your computer.
Alternatively, you can use Gitpod to tun Lean and VS Code in the cloud.

## To use this repository on your computer

Do the following:

1. Install Lean, VS Code, and the mathlib tools following
   the instructions on the
   [community web site](https://leanprover-community.github.io/).

2. Clone the repository.

3. Open in VS Code.


Opening any Lean file will simultaneously open this
book in a VS Code window.

Each section in the book has an associated Lean file
with examples and exercises.
You can find them in the folder `src`, organized by chapter.
We recommend making a copy of that folder,
naming it `my_files`.
That way you can experiment with the files as you go
while leaving the originals intact.

You can update to a newer version of this repository
by typing ``git pull`` followed by ``leanproject get-mathlib-cache``.
This will update the `src` folder, but will not change `my_files`.

## To use this repository with Gitpod

If you have a Gitpod account or are willing to sign up for one, you can use this repo in the cloud.
Alternatively you can use GitHub Codespaces.

To use GitPod, open the link [https://gitpod.io/#/https://github.com:DEST_REPO](https://gitpod.io/#/https://github.com:DEST_REPO)
This creates a virtual machine in the cloud,
and installs Lean and mathlib.
It then presents you with a VS Code window, running in a virtual
copy of the repository.
You can then make a copy of the `src` directory, and so on,
following the instructions above.

Gitpod gives you 50 free hours every month.
When you are done working, choose `Stop workspace` from the menu on the left.
The workspace should also stop automatically
30 minutes after the last interaction or 3 minutes after closing the tab.

To restart a previous workspace, go to [https://gitpod.io/workspaces/](https://gitpod.io/workspaces/).
If you change the filter from Active to All, you will see all your recent workspaces. You can pin a workspace to keep it on the list of active ones.