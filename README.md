# unraid_vm_icons

A docker container that downloads and installs additional custom VM icons to the Unraid VM Manager.

Please install this from the Unraid community applications plugin.

I hope that people will submit custom icons to this repo which once approved will be added to the icons available to download for all.

### Agent icons

Select **agent icons** in the container template to install the icons in `icons/Agents/`.
This category includes coding agents, coding assistants, and agent runtime tools.
The `agents` environment variable accepts `yes` or `no`; if omitted, this category is skipped.

All agent icons are 512 × 512 PNGs, preserving the source artwork's colors and backgrounds.
Newly rendered icons have transparent padding. Codex has a dark tile behind its white mark for visibility on light backgrounds.

| Icon | Artwork source |
| --- | --- |
| `Aider.png` | [Aider app icon](https://raw.githubusercontent.com/Aider-AI/aider/main/aider/website/assets/icons/android-chrome-384x384.png) |
| `Claude_Code.png` | [Claude Code mark distributed by Herdr](https://herdr.dev/assets/agent-icons/claude.svg) |
| `Codex.png` | [Codex mark distributed by Herdr](https://herdr.dev/assets/agent-icons/codex-mask.svg) |
| `Continue.png` | [Continue extension icon](https://raw.githubusercontent.com/continuedev/continue/main/extensions/vscode/media/icon.png) |
| `Cursor.png` | [Cursor website icon](https://cursor.com/marketing-static/favicon-light.svg) |
| `Gemini_CLI.png` | [Gemini CLI website icon](https://geminicli.com/icon.png) |
| `GitHub_Copilot.png` | [GitHub Copilot extension icon](https://raw.githubusercontent.com/microsoft/vscode-copilot-chat/main/assets/copilot.png) |
| `Goose.png` | [Goose desktop icon](https://raw.githubusercontent.com/block/goose/main/ui/desktop/src/images/icon.svg) |
| `Herdr.png` | [Herdr logo](https://herdr.dev/assets/logo.png) |
| `Hermes_Agent.png` | [Hermes Agent website icon](https://raw.githubusercontent.com/NousResearch/hermes-agent/main/website/static/img/favicon.svg) |
| `OpenCode.png` | [OpenCode square logo](https://raw.githubusercontent.com/anomalyco/opencode/dev/packages/console/app/src/asset/brand/opencode-logo-light-square.svg) |
| `OpenHands.png` | [OpenHands app icon](https://raw.githubusercontent.com/OpenHands/OpenHands/main/public/favicon.svg) |

When updating an existing installation, add the `agents` variable (set to `yes`) if the
template does not already expose it, and enable **Clear all icons & redownload** to refresh
the cached icon selection on the next container start.

Usage

After install Container should be set to auto start so icons are synced everytime the server or array starts.

Basic
Unraid template settings
1. Choose which custom icons you want to be installed from the drop downs. (Windows, Linux, macOS, FreeBSD based (pfSense Freenas etc), 'Other' Oses, and Agents)
2. Choose wether you want to keep the existing stock vm icons (recommended to keep)
   Setting this to no will remove the stock unraid vm icons from the vm manager.
3. Set wether all icons are redownloaded when container starts.
    Setting this as yes will clear all vm icons then redownload all choosen icons from github repo. 
    Setting to yes will on every start download any new icons in selected sections.
    (This is also useful if you deceide you no longer want a choosen section of icons anymore)
 The default is set to 'no'    
    
4. If your server has a beep speaker you can enable a tune to be played each time icons are synced. Yeah silly but fun! :)

Advanced settings (under show more settings)
1. You can set how long the container should wait before exiting after syncing icons (default 30 seconds)
Useful only to keep container running for longer if you need to bash into the container for debugging.

Other options dont change
