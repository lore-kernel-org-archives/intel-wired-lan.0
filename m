From: Benjamin Poirier <bpoirier@suse.com>
Date: Fri, 21 Jul 2017 11:36:23 -0700
Subject: [Intel-wired-lan] [PATCH 1/5] e1000e: Fix error path in link
	detection
In-Reply-To: <20170721160937.GA22632@csclub.uwaterloo.ca>
References: <20170721160937.GA22632@csclub.uwaterloo.ca>
Message-ID: <20170721183627.13373-1-bpoirier@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In case of error from e1e_rphy(), the loop will exit early and "success"
will be set to true erroneously.

Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
---
 drivers/net/ethernet/intel/e1000e/phy.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/phy.c b/drivers/net/ethernet/intel/e1000e/phy.c
index d78d47b41a71..86ff0969efb6 100644
--- a/drivers/net/ethernet/intel/e1000e/phy.c
+++ b/drivers/net/ethernet/intel/e1000e/phy.c
@@ -1744,6 +1744,7 @@ s32 e1000e_phy_has_link_generic(struct e1000_hw *hw, u32 iterations,
 	s32 ret_val = 0;
 	u16 i, phy_status;
 
+	*success = false;
 	for (i = 0; i < iterations; i++) {
 		/* Some PHYs require the MII_BMSR register to be read
 		 * twice due to the link bit being sticky.  No harm doing
@@ -1763,16 +1764,16 @@ s32 e1000e_phy_has_link_generic(struct e1000_hw *hw, u32 iterations,
 		ret_val = e1e_rphy(hw, MII_BMSR, &phy_status);
 		if (ret_val)
 			break;
-		if (phy_status & BMSR_LSTATUS)
+		if (phy_status & BMSR_LSTATUS) {
+			*success = true;
 			break;
+		}
 		if (usec_interval >= 1000)
 			msleep(usec_interval / 1000);
 		else
 			udelay(usec_interval);
 	}
 
-	*success = (i < iterations);
-
 	return ret_val;
 }
 
-- 
2.13.2

