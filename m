From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Tue, 25 Apr 2017 13:55:25 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Correct thermal sensor event check
Message-ID: <20170425205525.47399-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mark Rustad <mark.d.rustad@intel.com>

The thermal sensor event logic is messed up, because it can execute
the code when there is no thermal event. The current logic is that
it will exit when !capable && !event whereas it really should exit
when !capable || !event. For one thing, it means that the service
task is doing too much work. It probably has some other symptoms as
well. So, correct the logic, simplifying to only execute when there
is a thermal event. The capable check is redundant.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index c2c4de2..c9c1b5e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2639,8 +2639,7 @@ static void ixgbe_check_overtemp_subtask(struct ixgbe_adapter *adapter)
 	if (test_bit(__IXGBE_DOWN, &adapter->state))
 		return;
 
-	if (!(adapter->flags2 & IXGBE_FLAG2_TEMP_SENSOR_CAPABLE) &&
-	    !(adapter->flags2 & IXGBE_FLAG2_TEMP_SENSOR_EVENT))
+	if (!(adapter->flags2 & IXGBE_FLAG2_TEMP_SENSOR_EVENT))
 		return;
 
 	adapter->flags2 &= ~IXGBE_FLAG2_TEMP_SENSOR_EVENT;
-- 
2.9.3

