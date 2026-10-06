{ pkgs, tg-ws-proxy-src, ... }:

let
  pythonEnv = pkgs.python3.withPackages (
    ps: with ps; [
      websockets
      requests
      cryptography
      httpx
      h2
    ]
  );

  tg-ws-proxy = pkgs.writeShellApplication {
    name = "tg-ws-proxy";
    runtimeInputs = [ pythonEnv ];

    text = ''
      export PYTHONPATH="${tg-ws-proxy-src}"

      exec ${pythonEnv}/bin/python \
        ${tg-ws-proxy-src}/proxy/tg_ws_proxy.py "$@"
    '';
  };
in
{
  home.packages = [ tg-ws-proxy ];

systemd.user.services.tg-ws-proxy = {
  Unit = {
    Description = "Telegram MTProto WebSocket Bridge Proxy";
    After = [ "network-online.target" ];
    Wants = [ "network-online.target" ];
  };

  Service = {
    ExecStart = "${tg-ws-proxy}/bin/tg-ws-proxy --port 1443 --secret 00112233445566778899aabbccddeeff";
    Restart = "on-failure";
    RestartSec = 5;
  };

  Install = {
    WantedBy = [ "default.target" ];
  };
};
}