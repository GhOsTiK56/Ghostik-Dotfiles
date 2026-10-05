{ ... }:

{
  programs.bash = {
    enable = true;

    shellAliases = {
      ll = "ls -lah";
      la = "ls -A";
      ".." = "cd ..";
    };
  };

}