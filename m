From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu,  4 Oct 2018 16:28:52 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: allow IPsec Tx offload in VEPA mode
Message-ID: <1538695732-10203-1-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When it's possible that the PF might end up trying to send a
packet to one of its own VFs, we have to forbid IPsec offload
because the device drops the packets into a black hole.
See commit 47b6f50077e6 ("ixgbe: disallow IPsec Tx offload
when in SR-IOV mode") for more info.

This really is only necessary when the device is in the default
VEB mode.  If instead the device is running in VEPA mode,
the packets will go through the encryption engine and out the
MAC/PHY as normal, and get "hairpinned" as needed by the switch.

So let's not block IPsec offload when in VEPA mode.  To get
there with the ixgbe device, use the handy 'bridge' command:
	bridge link set dev eth1 hwmode vepa

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index fd1b054..4d77f42 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -4,6 +4,7 @@
 #include "ixgbe.h"
 #include <net/xfrm.h>
 #include <crypto/aead.h>
+#include <linux/if_bridge.h>
 
 #define IXGBE_IPSEC_KEY_BITS  160
 static const char aes_gcm_name[] = "rfc4106(gcm(aes))";
@@ -693,7 +694,8 @@ static int ixgbe_ipsec_add_sa(struct xfrm_state *xs)
 	} else {
 		struct tx_sa tsa;
 
-		if (adapter->num_vfs)
+		if (adapter->num_vfs &&
+		    adapter->bridge_mode != BRIDGE_MODE_VEPA)
 			return -EOPNOTSUPP;
 
 		/* find the first unused index */
-- 
2.7.4

