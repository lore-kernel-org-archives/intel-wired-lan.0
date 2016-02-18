From: Avinash Dayanand <avinash.dayanand@intel.com>
Date: Wed, 17 Feb 2016 16:12:14 -0800
Subject: [Intel-wired-lan] [next PATCH S29 04/14] i40e: Add a client
	definition of I40E_MAX_USER_PRIORITY
In-Reply-To: <1455754344-6372-1-git-send-email-avinash.dayanand@intel.com>
References: <1455754344-6372-1-git-send-email-avinash.dayanand@intel.com>
Message-ID: <1455754344-6372-5-git-send-email-avinash.dayanand@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Catherine Sullivan <catherine.sullivan@intel.com>

IWARP uses I40E_MAX_USER_PRIORITY in i40e_client.h but it is not defined
there so add a I40E_CLIENT_MAX_USER_PRIORITY definition to i40e_client.h
and a comment to i40e.h that we need to keep the two definitions synced.


Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
Change-ID: I0fc8868c2b090f54914ab738ec52b48ae4f523e2
---
Testing Hints: Make sure it compiles.

 drivers/net/ethernet/intel/i40e/i40e.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index e7fcb81..44ec1f7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -90,6 +90,9 @@
 #define I40E_MAX_AQ_BUF_SIZE          4096
 #define I40E_AQ_LEN                   256
 #define I40E_AQ_WORK_LIMIT            66 /* max number of VFs + a little */
+/* If I40E_MAX_USER_PRIORITY is updated please also update
+ * I40E_CLIENT_MAX_USER_PRIORITY in i40e_client.h
+ */
 #define I40E_MAX_USER_PRIORITY        8
 #define I40E_DEFAULT_MSG_ENABLE       4
 #define I40E_QUEUE_WAIT_RETRY_LIMIT   10
-- 
2.1.0

