From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu, 27 Aug 2015 11:42:41 -0400
Subject: [Intel-wired-lan] [next PATCH S12 13/15] i40e/i40evf: Explicitly
	assign enum index for VSI type
In-Reply-To: <1440690163-128213-1-git-send-email-catherine.sullivan@intel.com>
References: <1440690163-128213-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1440690163-128213-14-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Serey Kong <serey.kong@intel.com>

Ran into an issue where PF's VSI type list was different from VF's,
which was resulted in different enum index. The VSI type list can
be different depending on what build flag is used for PF and VF.

The change is to explicitly assign enum index for each VSI type
so that PF and VF always reference to the same VSI type event if the
enum lists are different.

Signed-off-by: Serey Kong <serey.kong@intel.com>
Change-ID: I8c0e5fdb515f324f7964df863a458073cf467e57
---
 drivers/net/ethernet/intel/i40e/i40e_type.h   | 16 ++++++++--------
 drivers/net/ethernet/intel/i40evf/i40e_type.h | 16 ++++++++--------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index b1ee6ce..4d88224 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -160,14 +160,14 @@ enum i40e_set_fc_aq_failures {
 };
 
 enum i40e_vsi_type {
-	I40E_VSI_MAIN = 0,
-	I40E_VSI_VMDQ1,
-	I40E_VSI_VMDQ2,
-	I40E_VSI_CTRL,
-	I40E_VSI_FCOE,
-	I40E_VSI_MIRROR,
-	I40E_VSI_SRIOV,
-	I40E_VSI_FDIR,
+	I40E_VSI_MAIN	= 0,
+	I40E_VSI_VMDQ1	= 1,
+	I40E_VSI_VMDQ2	= 2,
+	I40E_VSI_CTRL	= 3,
+	I40E_VSI_FCOE	= 4,
+	I40E_VSI_MIRROR	= 5,
+	I40E_VSI_SRIOV	= 6,
+	I40E_VSI_FDIR	= 7,
 	I40E_VSI_TYPE_UNKNOWN
 };
 
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_type.h b/drivers/net/ethernet/intel/i40evf/i40e_type.h
index 919516a..b7ef8aa 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_type.h
@@ -160,14 +160,14 @@ enum i40e_set_fc_aq_failures {
 };
 
 enum i40e_vsi_type {
-	I40E_VSI_MAIN = 0,
-	I40E_VSI_VMDQ1,
-	I40E_VSI_VMDQ2,
-	I40E_VSI_CTRL,
-	I40E_VSI_FCOE,
-	I40E_VSI_MIRROR,
-	I40E_VSI_SRIOV,
-	I40E_VSI_FDIR,
+	I40E_VSI_MAIN	= 0,
+	I40E_VSI_VMDQ1	= 1,
+	I40E_VSI_VMDQ2	= 2,
+	I40E_VSI_CTRL	= 3,
+	I40E_VSI_FCOE	= 4,
+	I40E_VSI_MIRROR	= 5,
+	I40E_VSI_SRIOV	= 6,
+	I40E_VSI_FDIR	= 7,
 	I40E_VSI_TYPE_UNKNOWN
 };
 
-- 
1.9.3

