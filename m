From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 25 Jun 2020 22:21:41 -0700
Subject: [Intel-wired-lan] [next-queue] ixgbe: Cleanup unneeded delay in
 ethtool test
Message-ID: <20200626052141.1310945-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

There is a 4 seconds delay in ixgbe_diag_test() that is holding up other
ioctls such as SIOCGIFCONF that Oracle database applications use.
One of Oracle's product runs "ethtool -t ethX online" periodically for
system monitoring and that is impacting database applications that use
SIOCGIFCONF at that same time.

This 4 second delay was needed in out early 1GbE parts to give the PHY
time to recover from a reset.  This code was carried forward to the 10 GbE
driver even it was not needed for the supported PHYs in the ixgbe driver.

CC: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
CC: Jack Vogel <jack.vogel@oracle.com>
Reported-by: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index c4e4aa33c91d..121a3a3a76b6 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -2156,7 +2156,7 @@ static void ixgbe_diag_test(struct net_device *netdev,
 					eth_test->flags |= ETH_TEST_FL_FAILED;
 					clear_bit(__IXGBE_TESTING,
 						  &adapter->state);
-					goto skip_ol_tests;
+					return;
 				}
 			}
 		}
@@ -2228,9 +2228,6 @@ static void ixgbe_diag_test(struct net_device *netdev,
 
 		clear_bit(__IXGBE_TESTING, &adapter->state);
 	}
-
-skip_ol_tests:
-	msleep_interruptible(4 * 1000);
 }
 
 static int ixgbe_wol_exclusion(struct ixgbe_adapter *adapter,
-- 
2.26.2

