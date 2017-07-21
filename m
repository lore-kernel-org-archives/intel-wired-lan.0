From: Benjamin Poirier <bpoirier@suse.com>
Date: Fri, 21 Jul 2017 11:36:24 -0700
Subject: [Intel-wired-lan] [PATCH 2/5] e1000e: Fix wrong comment related to
	link detection
In-Reply-To: <20170721183627.13373-1-bpoirier@suse.com>
References: <20170721160937.GA22632@csclub.uwaterloo.ca>
 <20170721183627.13373-1-bpoirier@suse.com>
Message-ID: <20170721183627.13373-2-bpoirier@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Reading e1000e_check_for_copper_link() shows that get_link_status is set to
false after link has been detected. Therefore, it stays TRUE until then.

Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 2dcb5463d9b8..58a87134d2e5 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -5074,7 +5074,7 @@ static bool e1000e_has_link(struct e1000_adapter *adapter)
 
 	/* get_link_status is set on LSC (link status) interrupt or
 	 * Rx sequence error interrupt.  get_link_status will stay
-	 * false until the check_for_link establishes link
+	 * true until the check_for_link establishes link
 	 * for copper adapters ONLY
 	 */
 	switch (hw->phy.media_type) {
@@ -5092,7 +5092,7 @@ static bool e1000e_has_link(struct e1000_adapter *adapter)
 		break;
 	case e1000_media_type_internal_serdes:
 		ret_val = hw->mac.ops.check_for_link(hw);
-		link_active = adapter->hw.mac.serdes_has_link;
+		link_active = hw->mac.serdes_has_link;
 		break;
 	default:
 	case e1000_media_type_unknown:
-- 
2.13.2

