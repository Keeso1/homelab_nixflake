# LSP servers, formatters, and other CLI tools nvim's LazyVim config expects
# on $PATH, installed via Nix instead of Mason (Mason's prebuilt binaries
# don't run on NixOS -- see https://nix.dev/permalink/stub-ld).
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lua-language-server           # lua_ls (LazyVim core default)
    stylua                        # lua formatter
    shfmt                         # shell formatter
    vtsls                         # TS/JS LSP (lang.typescript.vtsls extra)
    vscode-langservers-extracted  # jsonls/html/css (lang.json extra)
    ember-language-server         # lang.ember extra
    prettier                      # ts/js/html/css/json formatter
  ];
}

