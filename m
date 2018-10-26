From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri, 26 Oct 2018 10:40:51 -0700
Subject: [Intel-wired-lan] [PATCH S8 02/16] ice: Check for reset in progress
 during remove
In-Reply-To: <20181026174105.11628-1-anirudh.venkataramanan@intel.com>
References: <20181026174105.11628-1-anirudh.venkataramanan@intel.com>
Message-ID: <20181026174105.11628-3-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The remove path does not currently check to see if a
reset is in progress before proceeding.  This can cause
a resource collision resulting in various types of errors.

Check for reset in progress and wait for a reasonable
amount of time before allowing the remove to progress.

Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h      | 2 ++
 drivers/net/ethernet/intel/ice/ice_main.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 4c4b5717a627..e5b37fa60884 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -76,6 +76,8 @@ extern const char ice_drv_ver[];
 #define ICE_MIN_INTR_PER_VF		(ICE_MIN_QS_PER_VF + 1)
 #define ICE_DFLT_INTR_PER_VF		(ICE_DFLT_QS_PER_VF + 1)
 
+#define ICE_MAX_RESET_WAIT		20
+
 #define ICE_VSIQF_HKEY_ARRAY_SIZE	((VSIQF_HKEY_MAX_INDEX + 1) *	4)
 
 #define ICE_DFLT_NETIF_M (NETIF_MSG_DRV | NETIF_MSG_PROBE | NETIF_MSG_LINK)
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 6d31ffb64940..aee22f11a41a 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2182,6 +2182,12 @@ static void ice_remove(struct pci_dev *pdev)
 	if (!pf)
 		return;
 
+	for (i = 0; i < ICE_MAX_RESET_WAIT; i++) {
+		if (!ice_is_reset_in_progress(pf->state))
+			break;
+		msleep(100);
+	}
+
 	set_bit(__ICE_DOWN, pf->state);
 	ice_service_task_stop(pf);
 
-- 
2.14.3

