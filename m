From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri,  3 Apr 2015 13:27:01 -0700
Subject: [Intel-wired-lan] [net-next 11/25] fm10k: remove extraneous "Reset
	interface" message
In-Reply-To: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1428092835-16834-11-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Since we already print this message when a reset is requested via the
RESET_REQUESTED flag, we do not need to print it before setting the
flag.

Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Acked-by: Matthew Vick <matthew.vick@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index e2c27ba..5022a45 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -1191,7 +1191,6 @@ void fm10k_tx_timeout_reset(struct fm10k_intfc *interface)
 {
 	/* Do the reset outside of interrupt context */
 	if (!test_bit(__FM10K_DOWN, &interface->state)) {
-		netdev_err(interface->netdev, "Reset interface\n");
 		interface->tx_timeout_count++;
 		interface->flags |= FM10K_FLAG_RESET_REQUESTED;
 		fm10k_service_event_schedule(interface);
-- 
1.9.3

