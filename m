From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri,  5 Jun 2020 10:09:46 -0700
Subject: [Intel-wired-lan] [PATCH 4/4] iavf: increase reset complete wait
 time
In-Reply-To: <20200605170946.23494-1-anthony.l.nguyen@intel.com>
References: <20200605170946.23494-1-anthony.l.nguyen@intel.com>
Message-ID: <20200605170946.23494-4-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Paul Greenwalt <paul.greenwalt@intel.com>

With an increased number of VFs, it's possible to encounter the following
issue during reset.

    iavf b8d4:00:02.0: Hardware reset detected
    iavf b8d4:00:02.0: Reset never finished (0)
    iavf b8d4:00:02.0: Reset task did not complete, VF disabled

Increase the reset complete wait count to allow for 128 VFs to complete
reset.

Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf.h      |  4 ++++
 drivers/net/ethernet/intel/iavf/iavf_main.c | 12 +++++-------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 56cd1a39a4b5..8a65525a7c0d 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -219,6 +219,10 @@ struct iavf_cloud_filter {
 	bool add;		/* filter needs to be added */
 };
 
+#define IAVF_RESET_WAIT_MS 10
+#define IAVF_RESET_WAIT_DETECTED_COUNT 500
+#define IAVF_RESET_WAIT_COMPLETE_COUNT 2000
+
 /* board specific private data structure */
 struct iavf_adapter {
 	struct work_struct reset_task;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 3f3c6260c5df..78bd9e3df3ac 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2035,8 +2035,6 @@ static void iavf_disable_vf(struct iavf_adapter *adapter)
 	dev_info(&adapter->pdev->dev, "Reset task did not complete, VF disabled\n");
 }
 
-#define IAVF_RESET_WAIT_MS 10
-#define IAVF_RESET_WAIT_COUNT 500
 /**
  * iavf_reset_task - Call-back task to handle hardware reset
  * @work: pointer to work_struct
@@ -2090,20 +2088,20 @@ static void iavf_reset_task(struct work_struct *work)
 	adapter->flags |= IAVF_FLAG_RESET_PENDING;
 
 	/* poll until we see the reset actually happen */
-	for (i = 0; i < IAVF_RESET_WAIT_COUNT; i++) {
+	for (i = 0; i < IAVF_RESET_WAIT_DETECTED_COUNT; i++) {
 		reg_val = rd32(hw, IAVF_VF_ARQLEN1) &
 			  IAVF_VF_ARQLEN1_ARQENABLE_MASK;
 		if (!reg_val)
 			break;
 		usleep_range(5000, 10000);
 	}
-	if (i == IAVF_RESET_WAIT_COUNT) {
+	if (i == IAVF_RESET_WAIT_DETECTED_COUNT) {
 		dev_info(&adapter->pdev->dev, "Never saw reset\n");
 		goto continue_reset; /* act like the reset happened */
 	}
 
 	/* wait until the reset is complete and the PF is responding to us */
-	for (i = 0; i < IAVF_RESET_WAIT_COUNT; i++) {
+	for (i = 0; i < IAVF_RESET_WAIT_COMPLETE_COUNT; i++) {
 		/* sleep first to make sure a minimum wait time is met */
 		msleep(IAVF_RESET_WAIT_MS);
 
@@ -2115,7 +2113,7 @@ static void iavf_reset_task(struct work_struct *work)
 
 	pci_set_master(adapter->pdev);
 
-	if (i == IAVF_RESET_WAIT_COUNT) {
+	if (i == IAVF_RESET_WAIT_COMPLETE_COUNT) {
 		dev_err(&adapter->pdev->dev, "Reset never finished (%x)\n",
 			reg_val);
 		iavf_disable_vf(adapter);
@@ -3418,7 +3416,7 @@ static int iavf_check_reset_complete(struct iavf_hw *hw)
 	u32 rstat;
 	int i;
 
-	for (i = 0; i < 100; i++) {
+	for (i = 0; i < IAVF_RESET_WAIT_COMPLETE_COUNT; i++) {
 		rstat = rd32(hw, IAVF_VFGEN_RSTAT) &
 			     IAVF_VFGEN_RSTAT_VFR_STATE_MASK;
 		if ((rstat == VIRTCHNL_VFR_VFACTIVE) ||
-- 
2.20.1

