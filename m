From: Henrik Austad <henrik@austad.us>
Date: Wed, 19 Oct 2016 14:37:59 +0200
Subject: [Intel-wired-lan] [PATCH] igb: add missing fields to TXDCTL-register
Message-ID: <1476880679-16221-1-git-send-email-henrik@austad.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The current list of E1000_TXDCTL-registers is incomplete. This adds the
missing parts for the Transmit Descriptor Control (TXDCTL) register.

The rest of these values (threshold for descriptor read/write) for
TXDCTL seems to be defined in igb/igb.h, not sure why this is split
though.

It seems that this was left out in the commit that added support for
82575 Gigabit Ethernet driver 9d5c8243 (igb: PCI-Express 82575 Gigabit
Ethernet driver).

Signed-off-by: Henrik Austad <henrik@austad.us>
Cc: linux-kernel at vger.kernel.org
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: intel-wired-lan at lists.osuosl.org
Signed-off-by: Henrik Austad <henrik@austad.us>
---
 drivers/net/ethernet/intel/igb/e1000_82575.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.h b/drivers/net/ethernet/intel/igb/e1000_82575.h
index 199ff98..212dbb8 100644
--- a/drivers/net/ethernet/intel/igb/e1000_82575.h
+++ b/drivers/net/ethernet/intel/igb/e1000_82575.h
@@ -158,7 +158,11 @@ struct e1000_adv_tx_context_desc {

 /* Additional Transmit Descriptor Control definitions */
 #define E1000_TXDCTL_QUEUE_ENABLE  0x02000000 /* Enable specific Tx Queue */
+
+/* Transmit Software Flush, sw-triggered desc writeback */
+#define E1000_TXDCTL_SWFLSH        0x04000000
 /* Tx Queue Arbitration Priority 0=low, 1=high */
+#define E1000_TXDCTL_PRIORITY      0x08000000

 /* Additional Receive Descriptor Control definitions */
 #define E1000_RXDCTL_QUEUE_ENABLE  0x02000000 /* Enable specific Rx Queue */
--
2.7.4

