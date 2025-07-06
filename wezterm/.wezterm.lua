local wezterm = require('wezterm')
local config = wezterm.config_builder()

-- Color scheme
config.color_scheme = 'Catppuccin Mocha'

-- Font configuration
config.font = wezterm.font_with_fallback({
  {
    -- Primary font - Adjust weight as needed
    family = 'JetBrainsMono Nerd Font',
    weight = 'Medium',
    harfbuzz_features = { 'calt', 'liga' },
  },
  -- Fallback fonts for different scripts
  {
    -- Thai
    family = 'Ayuthaya',
    -- On Windows, use 'Leelawadee UI'
    -- family = 'Leelawadee UI',
  },
  {
    -- Chinese
    family = 'PingFang SC',
    -- On Windows, use Microsoft YaHei
    -- family = 'Microsoft YaHei',
  },
  {
    -- Myanmar
    family = 'Myanmar Text',
  },
})

-- Font size
config.font_size = 14

-- Better font rendering
config.freetype_load_target = 'Light'
config.freetype_render_target = 'HorizontalLcd'

-- Use GPU for rendering
config.front_end = 'WebGpu'
config.webgpu_power_preference = 'HighPerformance'

-- Window appearance
config.window_padding = {
  left = 2,
  right = 2,
  top = 0,
  bottom = 0,
}

-- Platform-specific configurations
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  -- Windows-specific settings
  config.default_prog = { 'pwsh.exe' }
  config.font_dirs = { 'C:\\Windows\\Fonts' }
  -- Adjust DPI scaling
  config.win32_system_backdrop = 'Acrylic'
else
  -- macOS/Linux settings
  config.font_dirs = { '~/Library/Fonts', '/System/Library/Fonts' }
end

-- Tab bar style
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

-- Better unicode support
config.warn_about_missing_glyphs = false
config.allow_square_glyphs_to_overflow_width = 'Never'

return config
