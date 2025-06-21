# My Neovim Configuration
A modern, feature-rich Neovim setup optimized for development workflow with LSP, autocompletion, and custom plugins.

## 📦 Plugin Manager

This configuration uses [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management.


## Quick setup

```
# Backup existing config (optional)
mv ~/.config/nvim ~/.config/nvim.backup

# Clone this repository
git clone https://github.com/umkh/nvim-config.git ~/.config/nvim 

# Start Neovim (plugins will auto-install)
nvim
```

## 🛠️ Key Mappings

### Buffer Navigation
- `<C-[>` - Previous buffer 
- `<C-]>` - Next buffer 
- `<C-c>` - Close current buffer 

## 🙏 Acknowledgments
- [lazy.nvim](https://github.com/folke/lazy.nvim) - Plugin manager
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - LSP configurations
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy finder
- All other amazing plugin authors
