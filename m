From: Sasha Neftin <sasha.neftin@intel.com>
Date: Mon,  2 Dec 2019 09:56:26 +0200
Subject: [Intel-wired-lan] [PATCH v1] igc: Remove serdes comments from a
 description of methods
Message-ID: <20191202075626.42061-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Serdes interface is not applicable for i225 devices.
Remove this from comments and make comments more clearly.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index d01ed6c55033..9c8abca08b90 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -59,7 +59,7 @@ enum latency_range {
 };
 
 /**
- * igc_power_down_link - Power down the phy/serdes link
+ * igc_power_down_link - Power down the phy link
  * @adapter: address of board private structure
  */
 static void igc_power_down_link(struct igc_adapter *adapter)
@@ -106,7 +106,7 @@ void igc_reset(struct igc_adapter *adapter)
 }
 
 /**
- * igc_power_up_link - Power up the phy/serdes link
+ * igc_power_up_link - Power up the phy link
  * @adapter: address of board private structure
  */
 static void igc_power_up_link(struct igc_adapter *adapter)
-- 
2.11.0

