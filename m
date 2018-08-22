From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Wed, 22 Aug 2018 16:47:14 -0700
Subject: [Intel-wired-lan] [PATCH next-queue 1/2] ixgbe: disallow ipsec tx
 offload when in sr-iov mode
Message-ID: <1534981635-27417-1-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

There seems to be a problem in the x540's internal switch wherein if SR/IOV
mode is enabled and an offloaded IPsec packet is sent to a local VF,
the packet is silently dropped.  This might never be a problem as it is
somewhat a corner case, but if someone happens to be using IPsec offload
from the PF to a VF that just happens to get migrated to the local box,
communication will mysteriously fail.

Not good.

A simple way to protect from this is to simply not allow any IPsec offloads
for outgoing packets when num_vfs != 0.  This doesn't help any offloads that
were created before SR/IOV was enabled, but we'll get to that later.

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index 68395ab..24076b4 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -697,6 +697,9 @@ static int ixgbe_ipsec_add_sa(struct xfrm_state *xs)
 	} else {
 		struct tx_sa tsa;
 
+		if (adapter->num_vfs)
+			return -EOPNOTSUPP;
+
 		/* find the first unused index */
 		ret = ixgbe_ipsec_find_empty_idx(ipsec, false);
 		if (ret < 0) {
-- 
2.7.4

