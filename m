From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 29 Jan 2018 15:57:48 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: prevent ptp_rx_hang from running
 when in FILTER_ALL mode
Message-ID: <20180129235748.21304-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On hardware which supports timestamping all packets, the timestamps are
recorded in the packet buffer, and the driver no longer uses or reads
the registers. This makes the logic for checking and clearing Rx
timestmap hangs meaningless.

If we run the ixgbe_ptp_rx_hang() function in this case, then the driver
will continuously spam the log output with "Clearing Rx timestamp hang".
These messages are spurious, and confusing to end users.

The original code in commit a9763f3cb54c ("ixgbe: Update PTP to support
X550EM_x devices", 2015-12-03) did have a flag PTP_RX_TIMESTAMP_IN_REGISTER
which was intended to be used to avoid the Rx timestamp hang check,
however it did not actually check the flag before calling the function.

Do so now in order to stop the checks and prevent the spurious log
messages.

Fixes: a9763f3cb54c ("ixgbe: Update PTP to support X550EM_x devices", 2015-12-03)
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Apparently this fix was not squashed into Mark's upstreaming effort for
the PTP updates for X550. Here it is now.

 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 0da5aa2c8aba..b032091022a8 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7703,7 +7703,8 @@ static void ixgbe_service_task(struct work_struct *work)
 
 	if (test_bit(__IXGBE_PTP_RUNNING, &adapter->state)) {
 		ixgbe_ptp_overflow_check(adapter);
-		ixgbe_ptp_rx_hang(adapter);
+		if (adapter->flags & IXGBE_FLAG_RX_HWTSTAMP_IN_REGISTER)
+			ixgbe_ptp_rx_hang(adapter);
 		ixgbe_ptp_tx_hang(adapter);
 	}
 
-- 
2.15.1.478.ga1e07cd25f8b

