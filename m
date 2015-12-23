From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Wed, 23 Dec 2015 12:05:45 -0800
Subject: [Intel-wired-lan] [next PATCH S25 05/16] i40e: Bump AQ minor
	version to 1.5 for new FW features
In-Reply-To: <1450901156-30904-1-git-send-email-deepthi.kavalur@intel.com>
References: <1450901156-30904-1-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <1450901156-30904-6-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

Bump AQ minor version to 1.5 for new FW features.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Acked-by: Kevin Scott <kevin.c.scott@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Change-ID: I5a790f7f519a2a8921aaa1c5663727dd1897ffec
---
Testing-Hints:
Apply and compile cleanly on driver load with old NVMs, should
see log message: 
The driver for the device detected an older version of the NVM 
image than expected. Please update the NVM image.

 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h   | 2 +-
 drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index 9684572..5699299 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -34,7 +34,7 @@
  */
 
 #define I40E_FW_API_VERSION_MAJOR	0x0001
-#define I40E_FW_API_VERSION_MINOR	0x0004
+#define I40E_FW_API_VERSION_MINOR	0x0005
 
 struct i40e_aq_desc {
 	__le16 flags;
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
index 6468537..ed963bc 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
@@ -34,7 +34,7 @@
  */
 
 #define I40E_FW_API_VERSION_MAJOR	0x0001
-#define I40E_FW_API_VERSION_MINOR	0x0004
+#define I40E_FW_API_VERSION_MINOR	0x0005
 
 struct i40e_aq_desc {
 	__le16 flags;
-- 
2.1.0

