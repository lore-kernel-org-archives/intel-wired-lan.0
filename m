From: Matteo Croce <mcroce@linux.microsoft.com>
Date: Fri, 14 May 2021 20:39:51 +0200
Subject: [Intel-wired-lan] [PATCH net-next 0/3] net: use XDP helpers
Message-ID: <20210514183954.7129-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Matteo Croce <mcroce@microsoft.com>

The commit 43b5169d8355 ("net, xdp: Introduce xdp_init_buff utility
routine") and commit be9df4aff65f ("net, xdp: Introduce xdp_prepare_buff
utility routine") introduces two useful helpers to populate xdp_buff.
Use it in drivers which still open codes that routines.

Matteo Croce (3):
  stmmac: use XDP helpers
  igc: use XDP helpers
  vhost_net: use XDP helpers

 drivers/net/ethernet/intel/igc/igc_main.c         | 9 +++------
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 9 +++------
 drivers/vhost/net.c                               | 6 ++----
 3 files changed, 8 insertions(+), 16 deletions(-)

-- 
2.31.1

