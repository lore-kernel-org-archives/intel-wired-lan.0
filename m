From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 12 Jan 2017 15:59:41 -0800
Subject: [Intel-wired-lan] [PATCH 4/5] fm10k: update function header comment
	for fm10k_get_stats64
In-Reply-To: <20170112235942.5767-1-jacob.e.keller@intel.com>
References: <20170112235942.5767-1-jacob.e.keller@intel.com>
Message-ID: <20170112235942.5767-4-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Re-word the comment to avoid stating that we return a value for this
void function. Additionally, there is no need to mention older kernels,
since this is the upstream kernel.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index 5e10296b1723..1aa0f7aabcc0 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -1115,8 +1115,8 @@ void fm10k_reset_rx_state(struct fm10k_intfc *interface)
  * @netdev: network interface device structure
  * @stats: storage space for 64bit statistics
  *
- * Returns 64bit statistics, for use in the ndo_get_stats64 callback. This
- * function replaces fm10k_get_stats for kernels which support it.
+ * Obtain 64bit statistics in a way that is safe for both 32bit and 64bit
+ * architectures.
  */
 static void fm10k_get_stats64(struct net_device *netdev,
 			      struct rtnl_link_stats64 *stats)
-- 
2.11.0.403.g196674b8396b

