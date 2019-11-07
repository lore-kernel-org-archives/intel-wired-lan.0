From: Florian Fainelli <f.fainelli@gmail.com>
Date: Thu,  7 Nov 2019 14:35:35 -0800
Subject: [Intel-wired-lan] [PATCH net-next 0/2] net: Demote MTU change
 prints to debug
Message-ID: <20191107223537.23440-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi David, Jeff, Timur,

This patch series demotes several drivers that printed MTU change and
could therefore spam the kernel console if one has a test that it's all
about testing the values. Intel drivers were not also particularly
consistent in how they printed the same message, so now they are.

Thanks

Florian Fainelli (2):
  net: ethernet: intel: Demote MTU change prints to debug
  net: qcom/emac: Demote MTU change print to debug

 drivers/net/ethernet/intel/e1000/e1000_main.c | 4 ++--
 drivers/net/ethernet/intel/e1000e/netdev.c    | 3 ++-
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 4 ++--
 drivers/net/ethernet/intel/igb/igb_main.c     | 5 ++---
 drivers/net/ethernet/intel/igbvf/netdev.c     | 4 ++--
 drivers/net/ethernet/intel/igc/igc_main.c     | 5 ++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 3 ++-
 drivers/net/ethernet/qualcomm/emac/emac.c     | 6 +++---
 8 files changed, 17 insertions(+), 17 deletions(-)

-- 
2.17.1

