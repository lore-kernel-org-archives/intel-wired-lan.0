From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Wed, 21 Oct 2015 19:47:09 -0400
Subject: [Intel-wired-lan] [next PATCH S19 08/15] i40e: Move the saving of
	old link info from handle_link_event to link_event
In-Reply-To: <1445471236-35918-1-git-send-email-catherine.sullivan@intel.com>
References: <1445471236-35918-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1445471236-35918-9-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The watchdog only calls link_event not handle_link_event which means
that we need to save the old information in link_event.

Previously when polling we were comparing current data to the old data
saved the last time we actually received a link event. This means that
the polling would only fix link status changes in one direction
depending on what the last old data saved off was.

Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
Change-ID: Ie590f30fdbcb133d0ddad4e07e3eb1aad58255b3

---
Testing-hints: Play with link a bit (forcing it up and down and such)
and make sure htat it is reporting the expected state in ethtool <dev>.
 drivers/net/ethernet/intel/i40e/i40e_main.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index ae63539..26e5ed0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6036,6 +6036,9 @@ static void i40e_link_event(struct i40e_pf *pf)
 	i40e_status status;
 	bool new_link, old_link;
 
+	/* save off old link status information */
+	pf->hw.phy.link_info_old = pf->hw.phy.link_info;
+
 	/* set this to force the get_link_status call to refresh state */
 	pf->hw.phy.get_link_info = true;
 
@@ -6170,13 +6173,9 @@ unlock:
 static void i40e_handle_link_event(struct i40e_pf *pf,
 				   struct i40e_arq_event_info *e)
 {
-	struct i40e_hw *hw = &pf->hw;
 	struct i40e_aqc_get_link_status *status =
 		(struct i40e_aqc_get_link_status *)&e->desc.params.raw;
 
-	/* save off old link status information */
-	hw->phy.link_info_old = hw->phy.link_info;
-
 	/* Do a new status request to re-enable LSE reporting
 	 * and load new status information into the hw struct
 	 * This completely ignores any state information
-- 
1.9.3

