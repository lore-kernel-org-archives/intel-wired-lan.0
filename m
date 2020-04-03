From: Andre Guedes <andre.guedes@intel.com>
Date: Fri,  3 Apr 2020 11:17:41 -0700
Subject: [Intel-wired-lan] [PATCH 2/4] igc: Dump VLANPQF register
In-Reply-To: <20200403181743.23447-1-andre.guedes@intel.com>
References: <20200403181743.23447-1-andre.guedes@intel.com>
Message-ID: <20200403181743.23447-3-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch adds the VLAN Priority Queue Filter Register (VLANPQF) to the
list of registers dumped by igc_get_regs().

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 9811b26f3c59..dfc21908347d 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -316,6 +316,8 @@ static void igc_get_regs(struct net_device *netdev,
 		regs_buff[172 + i] = rd32(IGC_RAL(i));
 	for (i = 0; i < 16; i++)
 		regs_buff[188 + i] = rd32(IGC_RAH(i));
+
+	regs_buff[204] = rd32(IGC_VLANPQF);
 }
 
 static void igc_get_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
-- 
2.26.0

