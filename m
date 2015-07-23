From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu, 23 Jul 2015 16:54:30 -0400
Subject: [Intel-wired-lan] [next PATCH S9 01/15] i40e/i40evf: fix up type
	clash in i40e_aq_rc_to_posix conversion
In-Reply-To: <1437684884-222825-1-git-send-email-catherine.sullivan@intel.com>
References: <1437684884-222825-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1437684884-222825-2-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

The error code sent into i40e_aq_rc_to_posix() are signed values, so we
really need to treat them as such.

Reported-by: Helin Zhang <helin.zhang@intel.com>
Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: I3d1ae0ee9ae0b1b6f5fc424f8b8cc58b0ea93203
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.h   | 9 ++++++---
 drivers/net/ethernet/intel/i40evf/i40e_adminq.h | 9 ++++++---
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.h b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
index 28e519a..299e3d3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
@@ -108,9 +108,10 @@ struct i40e_adminq_info {
 
 /**
  * i40e_aq_rc_to_posix - convert errors to user-land codes
- * aq_rc: AdminQ error code to convert
+ * aq_ret: AdminQ handler error code can override aq_rc
+ * aq_rc: AdminQ firmware error code to convert
  **/
-static inline int i40e_aq_rc_to_posix(u32 aq_ret, u16 aq_rc)
+static inline int i40e_aq_rc_to_posix(int aq_ret, int aq_rc)
 {
 	int aq_to_posix[] = {
 		0,           /* I40E_AQ_RC_OK */
@@ -142,8 +143,10 @@ static inline int i40e_aq_rc_to_posix(u32 aq_ret, u16 aq_rc)
 	if (aq_ret == I40E_ERR_ADMIN_QUEUE_TIMEOUT)
 		return -EAGAIN;
 
-	if (aq_rc >= ARRAY_SIZE(aq_to_posix))
+	if (aq_rc >= (sizeof(aq_to_posix) / sizeof((aq_to_posix)[0])) ||
+	    aq_rc < 0)
 		return -ERANGE;
+
 	return aq_to_posix[aq_rc];
 }
 
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq.h b/drivers/net/ethernet/intel/i40evf/i40e_adminq.h
index ef43d68..c4efa6b 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_adminq.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq.h
@@ -108,9 +108,10 @@ struct i40e_adminq_info {
 
 /**
  * i40e_aq_rc_to_posix - convert errors to user-land codes
- * aq_rc: AdminQ error code to convert
+ * aq_ret: AdminQ handler error code can override aq_rc
+ * aq_rc: AdminQ firmware error code to convert
  **/
-static inline int i40e_aq_rc_to_posix(u32 aq_ret, u16 aq_rc)
+static inline int i40e_aq_rc_to_posix(int aq_ret, int aq_rc)
 {
 	int aq_to_posix[] = {
 		0,           /* I40E_AQ_RC_OK */
@@ -142,8 +143,10 @@ static inline int i40e_aq_rc_to_posix(u32 aq_ret, u16 aq_rc)
 	if (aq_ret == I40E_ERR_ADMIN_QUEUE_TIMEOUT)
 		return -EAGAIN;
 
-	if (aq_rc >= ARRAY_SIZE(aq_to_posix))
+	if (aq_rc >= (sizeof(aq_to_posix) / sizeof((aq_to_posix)[0])) ||
+	    aq_rc < 0)
 		return -ERANGE;
+
 	return aq_to_posix[aq_rc];
 }
 
-- 
1.9.3

