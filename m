From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Wed, 19 Sep 2018 17:23:07 -0700
Subject: [Intel-wired-lan] [PATCH 4/8] ice: update fw version check logic
In-Reply-To: <20180920002311.10891-1-anirudh.venkataramanan@intel.com>
References: <20180920002311.10891-1-anirudh.venkataramanan@intel.com>
Message-ID: <20180920002311.10891-5-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

We have MAX_FW_API_VER_BRANCH, MAX_FW_API_VER_MAJOR, and
MAX_FW_API_VER_MINOR that we use in ice_controlq.h to test when a
firmware version is newer than expected. This is currently tested by
comparing each field separately. Thus, we compare the branch field
against the MAX_FW_API_VER_BRANCH, and so forth.

This means that currently, if we suppose that the max firmware version
is defined as 0.2.1, i.e.

#define MAX_FW_API_VER_BRANCH 0
#define MAX_FW_API_VER_MAJOR 2
#define MAX_FW_API_VER_MINOR 1

Then firmware 0.1.3 will fail to load. This is because the minor version
3 is greater than the max minor version 1.

This is not intuitive, because of the notion that increasing the major
firmware version to 2 should mean any firmware version with a major
version is less than 2 sould be considered older than 2...

In order to allow both 0.2.1 and 0.1.3 to load, you would have to define
the "max" firmware version as 0.2.3.. It is possible that such
a firmware version doesn't even exist yet!

Fix this by replacing the current logic with an updated check that
behaves as follows:

First, we check the major version. If it is greater than the expected
version, then we prevent driver load. Additionally, a warning message is
logged to indicate to the system administrator that they need to update
their driver. This is now the only case where the driver will refuse to
load.

Second, if the major version is less than the expected version, we log
an information message indicating the NVM should be updated.

Third, if the major version is exact, we'll then check the minor
version. If the minor version is more than two versions less than
expected, we log an information message indicating the NVM should be
updated. If it is more than two versions greater than the expected
version, we log an information message that the driver should be
updated.

To support this, the ice_aq_ver_check function needs its signature
updated to pass the hw structure. Since we now pass this structure,
there is no need to pass the fw api versions separately.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned up commit message]
---
 drivers/net/ethernet/intel/ice/ice_controlq.c | 30 +++++++++++++++++----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.c b/drivers/net/ethernet/intel/ice/ice_controlq.c
index 6cd86cff6a23..b25ce4f587f5 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.c
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
@@ -518,22 +518,31 @@ ice_shutdown_sq(struct ice_hw *hw, struct ice_ctl_q_info *cq)
 
 /**
  * ice_aq_ver_check - Check the reported AQ API version.
- * @fw_branch: The "branch" of FW, typically describes the device type
- * @fw_major: The major version of the FW API
- * @fw_minor: The minor version increment of the FW API
+ * @hw: pointer to the hardware structure
  *
  * Checks if the driver should load on a given AQ API version.
  *
  * Return: 'true' iff the driver should attempt to load. 'false' otherwise.
  */
-static bool ice_aq_ver_check(u8 fw_branch, u8 fw_major, u8 fw_minor)
+static bool ice_aq_ver_check(struct ice_hw *hw)
 {
-	if (fw_branch != EXP_FW_API_VER_BRANCH)
-		return false;
-	if (fw_major != EXP_FW_API_VER_MAJOR)
-		return false;
-	if (fw_minor != EXP_FW_API_VER_MINOR)
+	if (hw->api_maj_ver > EXP_FW_API_VER_MAJOR) {
+		/* Major API version is newer than expected, don't load */
+		dev_warn(ice_hw_to_dev(hw),
+			 "The driver for the device stopped because the NVM image is newer than expected. You must install the most recent version of the network driver.\n");
 		return false;
+	} else if (hw->api_maj_ver == EXP_FW_API_VER_MAJOR) {
+		if (hw->api_min_ver > (EXP_FW_API_VER_MINOR + 2))
+			dev_info(ice_hw_to_dev(hw),
+				 "The driver for the device detected a newer version of the NVM image than expected. Please install the most recent version of the network driver.\n");
+		else if ((hw->api_min_ver + 2) < EXP_FW_API_VER_MINOR)
+			dev_info(ice_hw_to_dev(hw),
+				 "The driver for the device detected an older version of the NVM image than expected. Please update the NVM image.\n");
+	} else {
+		/* Major API version is older than expected, log a warning */
+		dev_info(ice_hw_to_dev(hw),
+			 "The driver for the device detected an older version of the NVM image than expected. Please update the NVM image.\n");
+	}
 	return true;
 }
 
@@ -588,8 +597,7 @@ static enum ice_status ice_init_check_adminq(struct ice_hw *hw)
 	if (status)
 		goto init_ctrlq_free_rq;
 
-	if (!ice_aq_ver_check(hw->api_branch, hw->api_maj_ver,
-			      hw->api_min_ver)) {
+	if (!ice_aq_ver_check(hw)) {
 		status = ICE_ERR_FW_API_VER;
 		goto init_ctrlq_free_rq;
 	}
-- 
2.14.3

