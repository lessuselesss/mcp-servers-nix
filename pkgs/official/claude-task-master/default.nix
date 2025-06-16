{
  lib,
  fetchFromGitHub,
  buildNpmPackage,
}:

buildNpmPackage rec {
  pname = "claude-task-master";
  version = "YOUR_CLAUDE_TASK_MASTER_VERSION"; # You'll need to find the latest version or a specific tag
  
  # Fetch the source code from the GitHub repository
  src = fetchFromGitHub {
    owner = "eyaltoledano"; # The owner of the claude-task-master repository
    repo = "claude-task-master"; # The repository name
    rev = "v${version}"; # Assuming releases are tagged with 'v' prefix
    # You will need to calculate the hash. Replace with the actual hash.
    # To get the hash, you can temporarily set it to "" and Nix will tell you the expected hash during build.
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"; 
  };

  # npmDepsHash is for the node_modules directory's content hash
  # You will need to calculate this hash. It's often found in a package-lock.json or similar.
  # If claude-task-master itself doesn't provide a package-lock.json for its root,
  # you might need to run `npm install` and `npm ls` to generate one and then hash it.
  # For now, temporarily set to "" and Nix will tell you the expected hash.
  npmDepsHash = "sha256-BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB";

  # Set the main program executable
  # Based on the usage, it's likely `task-master-ai`
  # You might need to check the project's package.json for the 'bin' entry.
  mainProgram = "task-master-ai";

  meta = {
    description = "AI-powered task management system, designed as an MCP server.";
    homepage = "https://github.com/eyaltoledano/claude-task-master";
    license = lib.licenses.mit; # Or whatever license claude-task-master uses
    maintainers = with lib.maintainers; [ /* your-github-username-here */ ];
  };
}
