From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon,  8 Apr 2019 16:51:58 -0700
Subject: [Intel-wired-lan] [PATCH 1/5] ixgbe: reduce PTP Tx timestamp
 timeout to 1 second
Message-ID: <20190408235202.10676-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Previously we waited for a whole 15 seconds before we cleared the Tx
timestamp state. This is astronomically long compared to the worst case
timings expected by our devices. In addition, this is longer than the
wait in ptp4l when it detects a fault (caused by missing Tx timestamps).
Thus, reduce the timer to only 1 second, which is well after the maximum
expected delay. This should reduce user frustration when a timestamp
does get dropped for some reason.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
index d81a50dc9535..dbe84a4d2f7f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
@@ -72,7 +72,7 @@
 #define IXGBE_INCPER_SHIFT_82599 24
 
 #define IXGBE_OVERFLOW_PERIOD    (HZ * 30)
-#define IXGBE_PTP_TX_TIMEOUT     (HZ * 15)
+#define IXGBE_PTP_TX_TIMEOUT     (HZ)
 
 /* half of a one second clock period, for use with PPS signal. We have to use
  * this instead of something pre-defined like IXGBE_PTP_PPS_HALF_SECOND, in
-- 
2.21.0.564.g2d7e7e4d310b

