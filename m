From: Nicholas Krause <xerofoify@gmail.com>
Date: Tue, 26 May 2015 14:50:01 -0400
Subject: [Intel-wired-lan] [PATCH] e1000e: Fix comment for the function,
	e1000e_setup_copper_link
Message-ID: <1432666201-2011-1-git-send-email-xerofoify@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This changes the comment about checking link status to state that
we wait at least 10 microseconds rather then 100 as the third
agrument passed to the function, e1000e_phy_has_link_generic
for time delayed in microseconds is not 100 but 10 in this
particular call to the function.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 drivers/net/ethernet/intel/e1000e/phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/phy.c b/drivers/net/ethernet/intel/e1000e/phy.c
index b2005e1..456cd3f 100644
--- a/drivers/net/ethernet/intel/e1000e/phy.c
+++ b/drivers/net/ethernet/intel/e1000e/phy.c
@@ -1169,7 +1169,7 @@ s32 e1000e_setup_copper_link(struct e1000_hw *hw)
 		}
 	}
 
-	/* Check link status. Wait up to 100 microseconds for link to become
+	/* Check link status. Wait up to 10 microseconds for link to become
 	 * valid.
 	 */
 	ret_val = e1000e_phy_has_link_generic(hw, COPPER_LINK_UP_LIMIT, 10,
-- 
2.1.4

