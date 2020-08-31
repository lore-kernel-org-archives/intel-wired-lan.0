From: Sasha Neftin <sasha.neftin@intel.com>
Date: Mon, 31 Aug 2020 14:53:29 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove reset disable flag
Message-ID: <20200831115329.1238812-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Boolean reset disable flag not applicable for i225 device and
could be removed.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_hw.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/ethernet/intel/igc/igc_hw.h
index b70253fb8ebc..17d6669959db 100644
--- a/drivers/net/ethernet/intel/igc/igc_hw.h
+++ b/drivers/net/ethernet/intel/igc/igc_hw.h
@@ -158,7 +158,6 @@ struct igc_phy_info {
 	u8 mdix;
 
 	bool is_mdix;
-	bool reset_disable;
 	bool speed_downgraded;
 	bool autoneg_wait_to_complete;
 };
-- 
2.18.4

