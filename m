From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 26 Oct 2015 19:44:31 -0400
Subject: [Intel-wired-lan] [next PATCH S20 05/15] i40evf: rename vf adapter
	specific rss function
In-Reply-To: <1445903081-155893-1-git-send-email-catherine.sullivan@intel.com>
References: <1445903081-155893-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1445903081-155893-6-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Helin Zhang <helin.zhang@intel.com>

This patch renames old VF adapter specific rss function to clarify
its scope.

Signed-off-by: Helin Zhang <helin.zhang@intel.com>
Change-ID: Ie5253083a44c677ebb7709a8a3a18402ad2dc6a6

---
Testing-hints: Test compile only, no functional change.
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 506c08d..a8f67d3 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1295,10 +1295,10 @@ static void i40evf_configure_rss_reg(struct i40evf_adapter *adapter,
 }
 
 /**
- * i40evf_configure_rss - Prepare for RSS
+ * i40evf_init_rss - Prepare for RSS
  * @adapter: board private structure
  **/
-static void i40evf_configure_rss(struct i40evf_adapter *adapter)
+static void i40evf_init_rss(struct i40evf_adapter *adapter)
 {
 	struct i40e_hw *hw = &adapter->hw;
 	u8 seed[I40EVF_HKEY_ARRAY_SIZE];
@@ -1564,7 +1564,7 @@ static void i40evf_watchdog_task(struct work_struct *work)
 		 * PF, so we don't have to set current_op as we will
 		 * not get a response through the ARQ.
 		 */
-		i40evf_configure_rss(adapter);
+		i40evf_init_rss(adapter);
 		adapter->aq_required &= ~I40EVF_FLAG_AQ_CONFIGURE_RSS;
 		goto watchdog_done;
 	}
@@ -2312,7 +2312,7 @@ static void i40evf_init_task(struct work_struct *work)
 		    I40E_VIRTCHNL_VF_OFFLOAD_WB_ON_ITR)
 		adapter->flags |= I40EVF_FLAG_WB_ON_ITR_CAPABLE;
 	if (!RSS_AQ(adapter))
-		i40evf_configure_rss(adapter);
+		i40evf_init_rss(adapter);
 	err = i40evf_request_misc_irq(adapter);
 	if (err)
 		goto err_sw_init;
@@ -2342,7 +2342,7 @@ static void i40evf_init_task(struct work_struct *work)
 		adapter->aq_required |= I40EVF_FLAG_AQ_CONFIGURE_RSS;
 		mod_timer_pending(&adapter->watchdog_timer, jiffies + 1);
 	} else {
-		i40evf_configure_rss(adapter);
+		i40evf_init_rss(adapter);
 	}
 	return;
 restart:
-- 
1.9.3

