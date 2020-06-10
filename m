From: Sasha Neftin <sasha.neftin@intel.com>
Date: Wed, 10 Jun 2020 09:12:27 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Refactor the
 igc_power_up_link()
Message-ID: <20200610061227.3315-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

PHY of the i225 device support only copper mode.
There is no point to check media type in the
igc_power_up_link() method.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index af5e1686f7f2..83c94fa58c40 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -115,8 +115,7 @@ static void igc_power_up_link(struct igc_adapter *adapter)
 {
 	igc_reset_phy(&adapter->hw);
 
-	if (adapter->hw.phy.media_type == igc_media_type_copper)
-		igc_power_up_phy_copper(&adapter->hw);
+	igc_power_up_phy_copper(&adapter->hw);
 
 	igc_setup_link(&adapter->hw);
 }
-- 
2.11.0

