From: Mitch Williams <mitch.a.williams@intel.com>
Date: Mon, 22 Jun 2015 17:26:38 -0700
Subject: [Intel-wired-lan] [net PATCH] i40evf: don't configure unused RSS
	queues
Message-ID: <1435019198-10957-1-git-send-email-mitch.a.williams@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The driver will only configure as many queues as there are available
CPUs, up the the maximum number of queues. However, it always configures
RSS as though it is using the maximum number of queues. This can cause
the device to drop a lot of RX traffic, as the packets get assigned to
nonfunctional queues.

Fix this by only configuring RSS with the number of active queues.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 7c53aca..fef4843 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1460,7 +1460,7 @@ static void i40evf_configure_rss(struct i40evf_adapter *adapter)
 	for (i = 0; i <= I40E_VFQF_HLUT_MAX_INDEX; i++) {
 		lut = 0;
 		for (j = 0; j < 4; j++) {
-			if (cqueue == adapter->vsi_res->num_queue_pairs)
+			if (cqueue == adapter->num_active_queues)
 				cqueue = 0;
 			lut |= ((cqueue) << (8 * j));
 			cqueue++;
-- 
2.1.0

