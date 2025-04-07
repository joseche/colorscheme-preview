# colorscheme-preview

A neovim plugin to preview all installed colorschemes

## Installation

### Lazy

#### Basic Config

```lua
return {
  "joseche/colorscheme-preview",
  config = function()
    require("colorscheme-preview").setup()
  end
}
```


#### Custom Config

```lua
return {
  "joseche/colorscheme-preview",
  config = function()
    require("colorscheme-preview").setup({
        up_keys = { "<Up>", "k" },
        down_keys = { "<Down>", "j" },
        enter_keys = "<Enter>",
        close_keys = { "q", "<Esc>" },
        dialog_width = 20,
        dialog_height = 10,
        verbose = true,  -- prints the current colorscheme
    })
}

```

### Packer

```lua
use({
  "joseche/colorscheme-preview",
  config = function()
    require("colorscheme-preview").setup({
        -- up_keys = { "<Up>", "k" },
        -- down_keys = { "<Down>", "j" },
        -- enter_keys = "<Enter>",
        -- close_keys = { "q", "<Esc>" },
        -- dialog_width = 20,
        -- dialog_height = 10,
        -- verbose = true,  -- prints the current colorscheme
        })
  end
})
```



