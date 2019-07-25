From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 25 Jul 2019 02:53:58 -0700
Subject: [Intel-wired-lan] [PATCH S25 09/12] ice: Don't clog kernel debug
 log with VF MDD events errors
In-Reply-To: <20190725095401.24590-1-anthony.l.nguyen@intel.com>
References: <20190725095401.24590-1-anthony.l.nguyen@intel.com>
Message-ID: <20190725095401.24590-9-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>

In case of MDD events on VF, don't clog kernel log with unlimited VF mdd
events message "VF 0 has had 1018 MDD events since last boot" - limit
events log message to 30, based on the observation in some experimenation
with sending malicious packet once, and number of events reported before
device stopped observing MDD events.

Also removed defunct macro "ICE_DFLT_NUM_MDD_EVENTS_ALLOWED" for tracking
number of MDD events allowed before disabling the interface...

Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c        | 6 ++++--
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index f8746609f065..60b48ab177ea 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1315,8 +1315,10 @@ static void ice_handle_mdd_event(struct ice_pf *pf)
 
 		if (vf_mdd_detected) {
 			vf->num_mdd_events++;
-			if (vf->num_mdd_events > 1)
-				dev_info(&pf->pdev->dev, "VF %d has had %llu MDD events since last boot\n",
+			if (vf->num_mdd_events &&
+			    vf->num_mdd_events <= ICE_MDD_EVENTS_THRESHOLD)
+				dev_info(&pf->pdev->dev,
+					 "VF %d has had %llu MDD events since last boot, Admin might need to reload AVF driver with this number of events\n",
 					 i, vf->num_mdd_events);
 		}
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
index 4d94853f119a..13f45f37d75e 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
@@ -15,8 +15,8 @@
 #define ICE_MAX_MACADDR_PER_VF		12
 
 /* Malicious Driver Detection */
-#define ICE_DFLT_NUM_MDD_EVENTS_ALLOWED		3
 #define ICE_DFLT_NUM_INVAL_MSGS_ALLOWED		10
+#define ICE_MDD_EVENTS_THRESHOLD		30
 
 /* Static VF transaction/status register def */
 #define VF_DEVICE_STATUS		0xAA
-- 
2.20.1

