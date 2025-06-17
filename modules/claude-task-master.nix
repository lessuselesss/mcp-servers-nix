{ mkServerModule, ... }:
{
  imports = [ (mkServerModule { name = "claude-task-master"; }) ];
}
