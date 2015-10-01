From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu,  1 Oct 2015 16:11:11 -0700
Subject: [Intel-wired-lan] [PATCH next v1] i40e: fix offload of GRE tunnels
Message-ID: <1443741071-16495-1-git-send-email-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The driver still was not offloading TSO on GRE tunnels because
it forgot to set the GSO_GRE flag, causing lots of retransmits.

This fixes generic GRE traffic (like a tunnel added like below)
whereas before it would get 1Gb/s or less, now on a 10G adapter
it gets 8.7Gb/s.

ip ad ad 11.1.0.2/24 dev ens2f0
ip l set ens2f0 up
ip link add gre2 type gretap remote 11.1.0.1 local 11.1.0.2 dev ens2f0
ip l set gre2 up
ip ad ad 192.168.124.2/24 dev gre2
ping 192.168.124.1
netperf -H 192.168.124.1

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index eda14cf..851dcec 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8642,6 +8642,7 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
 
 	netdev->hw_enc_features |= NETIF_F_IP_CSUM	 |
 				  NETIF_F_GSO_UDP_TUNNEL |
+				  NETIF_F_GSO_GRE	 |
 				  NETIF_F_TSO;
 
 	netdev->features = NETIF_F_SG		       |
@@ -8649,6 +8650,7 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
 			   NETIF_F_SCTP_CSUM	       |
 			   NETIF_F_HIGHDMA	       |
 			   NETIF_F_GSO_UDP_TUNNEL      |
+			   NETIF_F_GSO_GRE	       |
 			   NETIF_F_HW_VLAN_CTAG_TX     |
 			   NETIF_F_HW_VLAN_CTAG_RX     |
 			   NETIF_F_HW_VLAN_CTAG_FILTER |
-- 
1.8.3.1

