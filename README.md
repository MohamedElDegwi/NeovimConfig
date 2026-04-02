# Neovim Config

## What is this?

This is a live track of my Neovim config and how it improves over time.

## Disclosure

This config is not a finished product, it needs **a lot** of improvemnts and refinements. But its working for
now out of the box.
However, I **HIGHLY** recommend against using it unless you are **AWARE** of what you are doing.

Neovim configuration is a beautiful journey, so make sure to learn how to do it yourself, that's the skill that
counts. It's also a good break from the headaches of coding ;)

## How to make it work

1. **Neovim Version:** You need Neovim 0.11+.
2. **Fonts:** You need a Nerd Font. You can download one [here](https://www.nerdfonts.com/font-downloads).
   * Personally, I recommend [JetBrains Mono](https://www.programmingfonts.org/#jetbrainsmono).
   * Here is an
   [article](https://medium.com/@almatins/install-nerdfont-or-any-fonts-using-the-command-line-in-debian-or-other-linux-f3067918a88c)
   on how to install them on Linux.
3. **Prerequisites:** there are some packages you need to make it work,
```bash
sudo apt install xclip ripgrep 
```
Note: there is some more, you will figure it out anyway too lazy to list it all to be honest haha.

4. **Installation:** Place the `nvim` directory under `~/.config/` and run `nvim`.

```bash
# Example
git clone https://github.com/MohamedElDegwi/NeovimConfig.git ~/.config/nvim
nvim
```
## LSP

Neovim v0.11+ has native support for [LSPs](https://neovim.io/doc/user/lsp.html).

This configuration sets up **Lua**, **Go**, and **Rust** by default.

However, they won't work unless `rust-analyzer`, `lua-language-server`, and `gopls` are readable from your
`$PATH`. If you are working with Rust or Go, just make sure you have those binaries installed and
you are ready to go.

**For other languages:**
1. Install the language server binary for that specific language (language servers are third-party tools).
2. Copy the community configuration for that server from 
    [here](https://github.com/neovim/nvim-lspconfig/tree/master/lsp).
3. Place the file in `~/.config/nvim/lsp`.
4. Enable it with `vim.lsp.enable('name_of_server')` in `~/.config/nvim/lua/lsp/init.lua` and whop! It's working :)
