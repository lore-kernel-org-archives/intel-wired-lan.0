From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Fri, 10 Jul 2015 19:36:03 -0400
Subject: [Intel-wired-lan] [intel-wired-lan][next PATCH S8 08/15] i40e: Fix
	comment for ethtool diagnostic link test
In-Reply-To: <1436571370-103673-1-git-send-email-catherine.sullivan@intel.com>
References: <1436571370-103673-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1436571370-103673-8-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Greg Rose <gregory.v.rose@intel.com>

The existing comment is incorrect.  Add new comment to point out that the
PF reset does not affect link but if the reset is changed to a different
type that does affect link then the link test would need to be moved to
before the reset.

Reported-by: Jeremiah Kyle <jeremiah.kyle@intel.com>
Signed-off-by: Greg Rose <gregory.v.rose@intel.com>
Change-ID: I28d786f46e9465860babdee61c1dba51016464df
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 74c16a1..62824f5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1626,11 +1626,13 @@ static void i40e_diag_test(struct net_device *netdev,
 			/* indicate we're in test mode */
 			dev_close(netdev);
 		else
+			/* This reset does not affect link - if it is
+			 * changed to a type of reset that does affect
+			 * link then the following link test would have
+			 * to be moved to before the reset
+			 */
 			i40e_do_reset(pf, BIT(__I40E_PF_RESET_REQUESTED));
 
-		/* Link test performed before hardware reset
-		 * so autoneg doesn't interfere with test result
-		 */
 		if (i40e_link_test(netdev, &data[I40E_ETH_TEST_LINK]))
 			eth_test->flags |= ETH_TEST_FL_FAILED;
 
-- 
1.9.3

