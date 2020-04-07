From: Andre Guedes <andre.guedes@intel.com>
Date: Tue,  7 Apr 2020 14:07:11 -0700
Subject: [Intel-wired-lan] [PATCH 5/5] igc: Dump ETQF registers
In-Reply-To: <20200407210711.24371-1-andre.guedes@intel.com>
References: <20200407210711.24371-1-andre.guedes@intel.com>
Message-ID: <20200407210711.24371-6-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch adds the EType Queue Filter (ETQF) registers to the list of
registers dumped by igc_get_regs().

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 5a53bf6ee1e5..eb7a6932dae2 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -318,6 +318,9 @@ static void igc_get_regs(struct net_device *netdev,
 		regs_buff[188 + i] = rd32(IGC_RAH(i));
 
 	regs_buff[204] = rd32(IGC_VLANPQF);
+
+	for (i = 0; i < 8; i++)
+		regs_buff[205 + i] = rd32(IGC_ETQF(i));
 }
 
 static void igc_get_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
-- 
2.26.0

