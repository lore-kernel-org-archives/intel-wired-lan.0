From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Wed, 26 Aug 2015 15:14:15 -0400
Subject: [Intel-wired-lan] [next PATCH S11 09/15] i40e: Fix for truncated
	interrupt name
In-Reply-To: <1440616461-110869-1-git-send-email-catherine.sullivan@intel.com>
References: <1440616461-110869-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1440616461-110869-10-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Carolyn Wyborny <carolyn.wyborny@intel.com>

This patch extends the size of the text available for the interrupt names.
Without this patch, all the descriptive data available for the Flow
Director interrupts is truncated.

Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
Change-ID: I2ac458f23ac3b4ea8f1edf73edc283b1d3704c7f
---
 drivers/net/ethernet/intel/i40e/i40e.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 5e546f9..3d4f2e4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -97,7 +97,7 @@
 #define I40E_MAX_USER_PRIORITY        8
 #define I40E_DEFAULT_MSG_ENABLE       4
 #define I40E_QUEUE_WAIT_RETRY_LIMIT   10
-#define I40E_INT_NAME_STR_LEN        (IFNAMSIZ + 9)
+#define I40E_INT_NAME_STR_LEN        (IFNAMSIZ + 16)
 
 /* Ethtool Private Flags */
 #define I40E_PRIV_FLAGS_NPAR_FLAG	BIT(0)
-- 
1.9.3

