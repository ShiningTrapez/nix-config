# Shared Config between Git and JJ
{
  lib,
  config,
  ...
}:
with lib; {
  options = {
    vcs = mkOption {
      type = types.uniq (types.submodule {
        options = {
          user = mkOption {
            type = types.submodule {
              options = {
                name = mkOption {type = types.str;};
                email = mkOption {type = types.str;};
                signingKey = mkOption {type = types.str;};
              };
            };
          };

          workUser = mkOption {
            type = types.submodule {
              options = {
                name = mkOption {type = types.str;};
                email = mkOption {type = types.str;};
                signingKey = mkOption {type = types.str;};
              };
            };
          };

          diffContext = mkOption {type = types.ints.positive;};
          editor = mkOption {type = types.str;};
          allowedSigners = mkOption {type = types.str;};
        };
      });
    };
  };

  config = {
    vcs = {
      user = {
        name = "Sophia Bitterstar";
        email = "sophia@shiningtrapezohedron.com";
        signingKey = "${config.home.homeDirectory}/.ssh/id_github.pub";
      };

      workUser = {
        name = "Sophia Lydia Morris-Hind";
        email = "sophia.morris-hind@bbc.co.uk";
        signingKey = "${config.home.homeDirectory}/.ssh/id_github_work.pub";
      };

      diffContext = 10;
      editor = "code -w";
      allowedSigners = "${config.home.homeDirectory}/.ssh/allowed_signers";
    };
  };
}
