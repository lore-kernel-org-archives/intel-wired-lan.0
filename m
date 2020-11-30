From: Sasha Neftin <sasha.neftin@intel.com>
Date: Mon, 30 Nov 2020 19:43:00 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove igc_set_fw_version
 method
Message-ID: <20201130174300.2784292-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

i225 device not supported and do not plan to support
configuration of fw version string for ethtool

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 831f2f09de5f..8d0085c03635 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -544,7 +544,6 @@ static int igc_ethtool_set_eeprom(struct net_device *netdev,
 	if (ret_val == 0)
 		hw->nvm.ops.update(hw);
 
-	/* check if need: igc_set_fw_version(adapter); */
 	kfree(eeprom_buff);
 	return ret_val;
 }
-- 
2.25.1

