From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 28 Sep 2015 14:12:43 -0400
Subject: [Intel-wired-lan] [next PATCH S16 14/15] i40e: increase AQ work
	limit
In-Reply-To: <1443463964-148204-1-git-send-email-catherine.sullivan@intel.com>
References: <1443463964-148204-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1443463964-148204-15-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

With 64 VFs, we can easily overwhelm the AQ on the PF if we have too low
a limit on the number of AQ requests. This leads to ARQ overflow errors,
and occasionally VFs that fail to initialize.

Since we really only hit this condition on initial VF driver load, the
requests that we process are lightweight, so this extra work doesn't
cause problems for the PF driver.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I620221520d8af987df6ace9ba938ffaf22107681
---
 drivers/net/ethernet/intel/i40e/i40e.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index c714822..666f7a5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -93,7 +93,7 @@
 #endif /* I40E_FCOE */
 #define I40E_MAX_AQ_BUF_SIZE          4096
 #define I40E_AQ_LEN                   256
-#define I40E_AQ_WORK_LIMIT            32
+#define I40E_AQ_WORK_LIMIT            66 /* max number of VFs + a little */
 #define I40E_MAX_USER_PRIORITY        8
 #define I40E_DEFAULT_MSG_ENABLE       4
 #define I40E_QUEUE_WAIT_RETRY_LIMIT   10
-- 
1.9.3

