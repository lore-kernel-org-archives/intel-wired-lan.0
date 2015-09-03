From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu,  3 Sep 2015 17:18:48 -0400
Subject: [Intel-wired-lan] [next PATCH S15 01/15] i40e: Add missing
	parameter comment to ndo_bridge_setlink
In-Reply-To: <1441315142-173025-1-git-send-email-catherine.sullivan@intel.com>
References: <1441315142-173025-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1441315142-173025-2-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

Add nlflags to the function comment for ndo_bridge_setlink.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Change-ID: I34c704f307f2a3f7bac3ca4b44e2a094d3d082d6
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index bb21be2..fee2127 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8331,6 +8331,7 @@ static int i40e_ndo_bridge_setlink(struct net_device *dev,
  * @seq: RTNL message seq #
  * @dev: the netdev being configured
  * @filter_mask: unused
+ * @nlflags: netlink flags passed in
  *
  * Return the mode in which the hardware bridge is operating in
  * i.e VEB or VEPA.
-- 
1.9.3

