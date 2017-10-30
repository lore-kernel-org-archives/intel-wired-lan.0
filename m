From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 30 Oct 2017 10:27:30 -0700
Subject: [Intel-wired-lan] ixgbe: Remove an obsolete comment about ITR
Message-ID: <20171030172730.8314-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Tonghao Zhang <xiangxia.m.yue@gmail.com>

The InterruptThrottleRate has been removed from ixgbe. Then Update
the comment.

Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 7f503d3..2a4ff0c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2534,8 +2534,6 @@ enum latency_range {
  *      based on theoretical maximum wire speed and thresholds were set based
  *      on testing data as well as attempting to minimize response time
  *      while increasing bulk throughput.
- *      this functionality is controlled by the InterruptThrottleRate module
- *      parameter (see ixgbe_param.c)
  **/
 static void ixgbe_update_itr(struct ixgbe_q_vector *q_vector,
 			     struct ixgbe_ring_container *ring_container)
