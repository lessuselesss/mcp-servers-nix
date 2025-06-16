{ config, pkgs, lib, mkServerModule, ... }:
let
  cfg = config.programs.claude-task-master;
in
{
  imports = [
    (mkServerModule {
      name = "claude-task-master";
      packageName = "claude-task-master"; # This refers to the package name you defined
      # Default arguments for task-master-ai can be added here if needed
      # args = [ ];
    })
  ];

  options.programs.claude-task-master = {
    enable = lib.mkEnableOption "claude-task-master MCP server";
    # Define specific options for claude-task-master, like API keys
    anthropicApiKey = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Anthropic API Key for claude-task-master.";
      # Consider making this a sensitive option if possible in your NixOS setup
    };
    perplexityApiKey = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Perplexity API Key for claude-task-master.";
    };
    openaiApiKey = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "OpenAI API Key for claude-task-master.";
    };
    googleApiKey = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Google API Key for claude-task-master.";
    };
    # Add other custom options for claude-task-master if it supports them
  };

  config = lib.mkIf cfg.enable {
    settings.servers."claude-task-master" = {
      enable = true; # Enable the server within the MCP configuration
      # Pass API keys as environment variables
      env = {
        ANTHROPIC_API_KEY = cfg.anthropicApiKey;
        PERPLEXITY_API_KEY = cfg.perplexityApiKey;
        OPENAI_API_KEY = cfg.openaiApiKey;
        GOOGLE_API_KEY = cfg.googleApiKey;
      };
      # You may need to specify the full path to the executable if mainProgram doesn't work directly
      # command = "${pkgs.claude-task-master}/bin/task-master-ai";
    };
  };
}
