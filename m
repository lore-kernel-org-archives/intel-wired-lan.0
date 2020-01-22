From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 22 Jan 2020 07:21:37 -0800
Subject: [Intel-wired-lan] [PATCH S38 14/15] ice: add function argument
 description to function header comment
In-Reply-To: <20200122152138.41585-1-anthony.l.nguyen@intel.com>
References: <20200122152138.41585-1-anthony.l.nguyen@intel.com>
Message-ID: <20200122152138.41585-14-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

Commit 0290bd291cc0 ("netdev: pass the stuck queue to the timeout handler")
introduced a new argument to the function but missed adding the description
of the argument to the function header comment.  Add it now.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index bfc79a5a92ed..3857e3f7a3f2 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5121,6 +5121,7 @@ ice_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
 /**
  * ice_tx_timeout - Respond to a Tx Hang
  * @netdev: network interface device structure
+ * @txqueue: Tx queue
  */
 static void ice_tx_timeout(struct net_device *netdev, unsigned int txqueue)
 {
-- 
2.20.1

