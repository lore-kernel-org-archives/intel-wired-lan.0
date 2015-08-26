From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Wed, 26 Aug 2015 15:14:11 -0400
Subject: [Intel-wired-lan] [next PATCH S11 05/15] i40e/i40evf: fix a
	potential type compare issue
In-Reply-To: <1440616461-110869-1-git-send-email-catherine.sullivan@intel.com>
References: <1440616461-110869-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1440616461-110869-6-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

Rework an if expression to assure there is no type compare problem between
a size and a possible negative number.

Reported-by: Helin Zhang <helin.zhang@intel.com>
Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: I4921fcc96abfcf69490efce020a9e4007f251c99
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.h   | 3 +--
 drivers/net/ethernet/intel/i40evf/i40e_adminq.h | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.h b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
index 299e3d3..fa5c2cd 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
@@ -143,8 +143,7 @@ static inline int i40e_aq_rc_to_posix(int aq_ret, int aq_rc)
 	if (aq_ret == I40E_ERR_ADMIN_QUEUE_TIMEOUT)
 		return -EAGAIN;
 
-	if (aq_rc >= (sizeof(aq_to_posix) / sizeof((aq_to_posix)[0])) ||
-	    aq_rc < 0)
+	if (!((u32)aq_rc < (sizeof(aq_to_posix) / sizeof((aq_to_posix)[0]))))
 		return -ERANGE;
 
 	return aq_to_posix[aq_rc];
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq.h b/drivers/net/ethernet/intel/i40evf/i40e_adminq.h
index c4efa6b..81f9ffa 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_adminq.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq.h
@@ -143,8 +143,7 @@ static inline int i40e_aq_rc_to_posix(int aq_ret, int aq_rc)
 	if (aq_ret == I40E_ERR_ADMIN_QUEUE_TIMEOUT)
 		return -EAGAIN;
 
-	if (aq_rc >= (sizeof(aq_to_posix) / sizeof((aq_to_posix)[0])) ||
-	    aq_rc < 0)
+	if (!((u32)aq_rc < (sizeof(aq_to_posix) / sizeof((aq_to_posix)[0]))))
 		return -ERANGE;
 
 	return aq_to_posix[aq_rc];
-- 
1.9.3

