From: Scott Peterson <scott.d.peterson@intel.com>
Date: Fri, 18 Nov 2016 11:25:42 -0800
Subject: [Intel-wired-lan] [net-next PATCH 2] ixgbe/ixgbevf: Enables TSO for
 MPLS encapsulated packets
Message-ID: <147949699683.18376.16266711523851563132.stgit@sdpeters-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch advertises TSO & GSO features in netdev->mpls_features.
In ixgbe(vf)_tso() where we set up segmentation offload, the IP
header will be the inner network header when eth_p_mpls() indicates
the Ethernet protocol is MPLS (UC or MC).

We're submitting this upstream first, because it depends on related
upstream changes not yet present in the OOT drivers.

Suggested-by: Alexander Duyck <alexander.h.duyck@intel.com>
Signed-off-by: Scott Peterson <scott.d.peterson@intel.com>
---
V2: Patch formatting de-fubared. It applies for me now.  Sorry, Jeff.

Testing Hints:

I did basic testing of this by setting up a simple MPLS tunnel (one label)
between two nodes. I sent a megabyte of random data with ncat from the node
with this patch, and verified the rx pattern matched the tx pattern. There is
no TSO stat in ixgbe AFAIK. To confirm TSO occurred in the test, I ran it once
with a pr_err() added to the clause below that detects MPLS. I repeated the
verification test after removing the debug logging.  This was done for each
driver. I would not be surprised to discover there is a better way to verify
TSO occurs on ixgbe.

A more complete test would verify that all the GSO features supported by
ixgbe/ixgbevf (see IXGBE_GSO_PARTIAL_FEATURES) work correctly when nested
inside MPLS. This needs to be done at least once on both drivers.

Clues for setting up an MPLS tunnel follow.  This may be obvious, but note the
rp_filter step was required.

On both nodes:

modprobe mpls-router
modprobe mpls-iptunnel
modprobe mpls-gso
echo 1 > /proc/sys/net/mpls/conf/<your ixgbe>/input
echo 1 > /proc/sys/net/mpls/conf/lo/input
echo 1048575 > /proc/sys/net/mpls/platform_labels
#Relax reverse path filtering
echo 2 > /proc/sys/net/ipv4/conf/all/rp_filter

On both nodes add a /32 address outside the range of all local subnets to lo
for use as the MPLS endpoint addresses.

Add a route over MPLS with tag 101 from each node, like:

ip route add <other mpls ip>/32 encap mpls 101 via inet <other ixgbe ip>

Add an MPLS decapsulation (deliver tag 101 to lo) route on both nodes:

ip -f mpls route add 101 dev lo

Now from either end ping <other mpls ip> will work, and wireshark on ixgbe will
show MPLS encapsulated ICMP messages exchanged.

When you unload/load ixgbe/ixgbevf, these need to be repeated:

echo 1 > /proc/sys/net/mpls/conf/<your ixgbe>/input
ip route add <other mpls ip>/32 encap mpls 101 via inet <other ixgbe ip>

When you transfer the file with ncat, use the <other mpls ip>, of course.
It will work if you use <other ixgbe>, but that won't be MPLS encapsulated.

 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     |   12 ++++++++++--
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   12 ++++++++++--
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 2436984..04b2ceb 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -55,6 +55,7 @@
 #include <net/tc_act/tc_gact.h>
 #include <net/tc_act/tc_mirred.h>
 #include <net/vxlan.h>
+#include <net/mpls.h>
 
 #include "ixgbe.h"
 #include "ixgbe_common.h"
@@ -7279,7 +7280,10 @@ static int ixgbe_tso(struct ixgbe_ring *tx_ring,
 	if (err < 0)
 		return err;
 
-	ip.hdr = skb_network_header(skb);
+	if (eth_p_mpls(first->protocol))
+		ip.hdr = skb_inner_network_header(skb);
+	else
+		ip.hdr = skb_network_header(skb);
 	l4.hdr = skb_checksum_start(skb);
 
 	/* ADV DTYP TUCMD MKRLOC/ISCSIHEDLEN */
@@ -9653,7 +9657,11 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	netdev->vlan_features |= netdev->features | NETIF_F_TSO_MANGLEID;
 	netdev->hw_enc_features |= netdev->vlan_features;
-	netdev->mpls_features |= NETIF_F_HW_CSUM;
+	netdev->mpls_features |= NETIF_F_SG |
+				 NETIF_F_TSO |
+				 NETIF_F_TSO6 |
+				 NETIF_F_HW_CSUM;
+	netdev->mpls_features |= IXGBE_GSO_PARTIAL_FEATURES;
 
 	/* set this bit last since it cannot be part of vlan_features */
 	netdev->features |= NETIF_F_HW_VLAN_CTAG_FILTER |
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index d316f50..8498eed 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -49,6 +49,7 @@
 #include <linux/if.h>
 #include <linux/if_vlan.h>
 #include <linux/prefetch.h>
+#include <net/mpls.h>
 
 #include "ixgbevf.h"
 
@@ -3327,7 +3328,10 @@ static int ixgbevf_tso(struct ixgbevf_ring *tx_ring,
 	if (err < 0)
 		return err;
 
-	ip.hdr = skb_network_header(skb);
+	if (eth_p_mpls(first->protocol))
+		ip.hdr = skb_inner_network_header(skb);
+	else
+		ip.hdr = skb_network_header(skb);
 	l4.hdr = skb_checksum_start(skb);
 
 	/* ADV DTYP TUCMD MKRLOC/ISCSIHEDLEN */
@@ -4083,7 +4087,11 @@ static int ixgbevf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		netdev->features |= NETIF_F_HIGHDMA;
 
 	netdev->vlan_features |= netdev->features | NETIF_F_TSO_MANGLEID;
-	netdev->mpls_features |= NETIF_F_HW_CSUM;
+	netdev->mpls_features |= NETIF_F_SG |
+				 NETIF_F_TSO |
+				 NETIF_F_TSO6 |
+				 NETIF_F_HW_CSUM;
+	netdev->mpls_features |= IXGBEVF_GSO_PARTIAL_FEATURES;
 	netdev->hw_enc_features |= netdev->vlan_features;
 
 	/* set this bit last since it cannot be part of vlan_features */

