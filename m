From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 20 Jun 2017 15:17:01 -0700
Subject: [Intel-wired-lan] [next PATCH S73-V2 9/9] i40evf: add some missing
	includes
In-Reply-To: <20170620221701.46765-1-jeffrey.t.kirsher@intel.com>
References: <20170620221701.46765-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20170620221701.46765-9-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

These includes were all being used in the driver, but weren't
being directly included.

Since the current advised method is to directly include anything
that you need, this implements that.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf.h b/drivers/net/ethernet/intel/i40evf/i40evf.h
index 6cc9208..7901cc8 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf.h
+++ b/drivers/net/ethernet/intel/i40evf/i40evf.h
@@ -39,6 +39,17 @@
 #include <linux/tcp.h>
 #include <linux/sctp.h>
 #include <linux/ipv6.h>
+#include <linux/kernel.h>
+#include <linux/bitops.h>
+#include <linux/timer.h>
+#include <linux/workqueue.h>
+#include <linux/delay.h>
+#include <linux/gfp.h>
+#include <linux/skbuff.h>
+#include <linux/dma-mapping.h>
+#include <linux/etherdevice.h>
+#include <linux/socket.h>
+#include <linux/jiffies.h>
 #include <net/ip6_checksum.h>
 #include <net/udp.h>
 
-- 
2.9.3

