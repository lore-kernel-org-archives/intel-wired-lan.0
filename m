From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 28 Jan 2019 09:45:01 -0800
Subject: [Intel-wired-lan] [net] ixgbe: fix older devices that do not
 support IXGBE_MRQC_L3L4TXSWEN
Message-ID: <20190128174501.26421-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The enabling L3/L4 filtering for transmit switched packets for all
devices caused unforeseen issue on older devices when trying to send UDP
traffic in an ordered sequence.  This bit was originally intended for X550
devices, which supported this feature, so limit the scope of this bit to
only X550 devices.

Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index daff8183534b..3cbb7e0324fd 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -3953,8 +3953,11 @@ static void ixgbe_setup_mrqc(struct ixgbe_adapter *adapter)
 			else
 				mrqc = IXGBE_MRQC_VMDQRSS64EN;
 
-			/* Enable L3/L4 for Tx Switched packets */
-			mrqc |= IXGBE_MRQC_L3L4TXSWEN;
+			/* Enable L3/L4 for Tx Switched packets only for X550,
+			 * older devices do not support this feature
+			 */
+			if (hw->mac.type >= ixgbe_mac_X550)
+				mrqc |= IXGBE_MRQC_L3L4TXSWEN;
 		} else {
 			if (tcs > 4)
 				mrqc = IXGBE_MRQC_RTRSS8TCEN;
-- 
2.20.1

