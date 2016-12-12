From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 12 Dec 2016 15:44:07 -0800
Subject: [Intel-wired-lan] [next PATCH S57 01/11] i40e: fix disable overflow
	promiscuous mode
In-Reply-To: <1481586257-28872-1-git-send-email-bimmy.pujari@intel.com>
References: <1481586257-28872-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1481586257-28872-2-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alan Brady <alan.brady@intel.com>

There exists a bug in which the driver is unable to exit overflow
promiscuous mode after having added "too many" mac filters.  It is
expected that after triggering overflow promiscuous, removing the
failed/extra filters should then disable overflow promiscuous mode.

The bug exists because we were intentionally skipping the sync_vsi_filter
path in cases where we were removing failed filters since they shouldn't
have been added to the firmware in the first place, however we still
need to go through the sync_vsi_filter code path to determine whether or
not it is ok to exit overflow promiscuous mode.  This patch fixes the
bug by making sure we go through the sync_vsi_filter path in cases of
failed filters.

Signed-off-by: Alan Brady <alan.brady@intel.com>
Change-ID: I634d249ca3e5fa50729553137c295e73e7722143
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 69a51a4..cb62a1e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1453,18 +1453,20 @@ void __i40e_del_filter(struct i40e_vsi *vsi, struct i40e_mac_filter *f)
 	if (!f)
 		return;
 
+	/* If the filter was never added to firmware then we can just delete it
+	 * directly and we don't want to set the status to remove or else an
+	 * admin queue command will unnecessarily fire.
+	 */
 	if ((f->state == I40E_FILTER_FAILED) ||
 	    (f->state == I40E_FILTER_NEW)) {
-		/* this one never got added by the FW. Just remove it,
-		 * no need to sync anything.
-		 */
 		hash_del(&f->hlist);
 		kfree(f);
 	} else {
 		f->state = I40E_FILTER_REMOVE;
-		vsi->flags |= I40E_VSI_FLAG_FILTER_CHANGED;
-		vsi->back->flags |= I40E_FLAG_FILTER_SYNC;
 	}
+
+	vsi->flags |= I40E_VSI_FLAG_FILTER_CHANGED;
+	vsi->back->flags |= I40E_FLAG_FILTER_SYNC;
 }
 
 /**
-- 
2.4.11

