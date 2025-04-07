# colorscheme-preview

A neovim plugin to preview all installed colorschemes



https://github.com/user-attachments/assets/29597ab5-33e7-40e7-9eec-a9a5c89bd90c



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



