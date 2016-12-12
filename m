From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 12 Dec 2016 15:44:16 -0800
Subject: [Intel-wired-lan] [next PATCH S57 10/11] i40e: Error handling for
	link event
In-Reply-To: <1481586257-28872-1-git-send-email-bimmy.pujari@intel.com>
References: <1481586257-28872-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1481586257-28872-11-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>

There exists an intermittent bug which causes the 'Link Detected'
field reported by the 'ethtool <iface>' command to be 'Yes' when
in fact, there is no link. This patch fixes the problem by
enabling temporary link polling when i40e_get_link_status returns
an error. This causes the driver to remember that an admin queue
command failed and polls, until the function returns with a success.

Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Change-Id: I64c69b008db4017b8729f3fc27b8f65c8fe2eaa0
---
 drivers/net/ethernet/intel/i40e/i40e.h      |  1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 0f13d19..19a296d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -388,6 +388,7 @@ struct i40e_pf {
 #define I40E_FLAG_HAVE_CRT_RETIMER		BIT_ULL(52)
 #define I40E_FLAG_PTP_L4_CAPABLE		BIT_ULL(53)
 #define I40E_FLAG_WOL_MC_MAGIC_PKT_WAKE		BIT_ULL(54)
+#define I40E_FLAG_TEMP_LINK_POLLING		BIT_ULL(55)
 
 	/* tracks features that get auto disabled by errors */
 	u64 auto_disable_flags;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 99ea5652..ef8dc28 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6367,7 +6367,16 @@ static void i40e_link_event(struct i40e_pf *pf)
 	old_link = (pf->hw.phy.link_info_old.link_info & I40E_AQ_LINK_UP);
 
 	status = i40e_get_link_status(&pf->hw, &new_link);
-	if (status) {
+
+	/* On success, disable temp link polling */
+	if (status == I40E_SUCCESS) {
+		if (pf->flags & I40E_FLAG_TEMP_LINK_POLLING)
+			pf->flags &= ~I40E_FLAG_TEMP_LINK_POLLING;
+	} else {
+		/* Enable link polling temporarily until i40e_get_link_status
+		 * returns I40E_SUCCESS
+		 */
+		pf->flags |= I40E_FLAG_TEMP_LINK_POLLING;
 		dev_dbg(&pf->pdev->dev, "couldn't get link state, status: %d\n",
 			status);
 		return;
@@ -6419,7 +6428,8 @@ static void i40e_watchdog_subtask(struct i40e_pf *pf)
 		return;
 	pf->service_timer_previous = jiffies;
 
-	if (pf->flags & I40E_FLAG_LINK_POLLING_ENABLED)
+	if ((pf->flags & I40E_FLAG_LINK_POLLING_ENABLED) ||
+	    (pf->flags & I40E_FLAG_TEMP_LINK_POLLING))
 		i40e_link_event(pf);
 
 	/* Update the stats for active netdevs so the network stack
-- 
2.4.11

