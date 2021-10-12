-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/karim/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?.lua;/home/karim/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?/init.lua;/home/karim/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?.lua;/home/karim/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/karim/.cache/nvim/packer_hererocks/2.0.5/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Catppuccino.nvim"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/Catppuccino.nvim"
  },
  ["asl-vim"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/asl-vim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/cmp-buffer"
  },
  ["cmp-latex-symbols"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/cmp-latex-symbols"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua"
  },
  ["cmp-nvim-tags"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/cmp-nvim-tags"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/cmp-path"
  },
  ["cmp-spell"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/cmp-spell"
  },
  ["cmp-treesitter"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/cmp-treesitter"
  },
  ["cmp-vsnip"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/cmp-vsnip"
  },
  ["compe-tmux"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/compe-tmux"
  },
  delimitMate = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/delimitMate"
  },
  ["emmet-vim"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/emmet-vim"
  },
  ["gina.vim"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/gina.vim"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  kommentary = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/kommentary"
  },
  ["lazygit.nvim"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/lazygit.nvim"
  },
  ["lsp-trouble.nvim"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/lsp-trouble.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ["lush.nvim"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/lush.nvim"
  },
  ["nabla.nvim"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/nabla.nvim"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/nvim-dap"
  },
  ["nvim-dap-virtual-text"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/nvim-dap-virtual-text"
  },
  ["nvim-lightbulb"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/nvim-lightbulb"
  },
  ["nvim-lint"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/nvim-lint"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lspinstall"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/nvim-lspinstall"
  },
  ["nvim-luaref"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/nvim-luaref"
  },
  ["nvim-nonicons"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/nvim-nonicons"
  },
  ["nvim-toggleterm.lua"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/nvim-toggleterm.lua"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["nvim-workbench"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/nvim-workbench"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["pest.vim"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/pest.vim"
  },
  playground = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["telescope-dap.nvim"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/telescope-dap.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  terminus = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/terminus"
  },
  ["vim-blade"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/vim-blade"
  },
  ["vim-dirvish"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/vim-dirvish"
  },
  ["vim-eunuch"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/vim-eunuch"
  },
  ["vim-gap"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/vim-gap"
  },
  ["vim-glsl"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/vim-glsl"
  },
  ["vim-gtfo"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/vim-gtfo"
  },
  ["vim-magma"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/vim-magma"
  },
  ["vim-prisma"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/vim-prisma"
  },
  ["vim-singular"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/vim-singular"
  },
  ["vim-sleuth"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/vim-sleuth"
  },
  ["vim-sneak"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/vim-sneak"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/vim-unimpaired"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/vim-vsnip"
  },
  vimtex = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/vimtex"
  },
  ["vs-snippets"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/vs-snippets"
  },
  ["zen-mode.nvim"] = {
    loaded = true,
    path = "/home/karim/.local/share/nvim/site/pack/packer/start/zen-mode.nvim"
  }
}

time([[Defining packer_plugins]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
