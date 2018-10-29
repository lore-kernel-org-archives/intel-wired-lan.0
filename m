From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 29 Oct 2018 10:52:42 -0700
Subject: [Intel-wired-lan] [net 1/2] i40e: restore NETIF_F_GSO_IPXIP[46] to
 netdev features
Message-ID: <20181029175243.13453-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Since commit bacd75cfac8a ("i40e/i40evf: Add capability exchange for
outer checksum", 2017-04-06) the i40e driver has not reported support
for IP-in-IP offloads. This likely occurred due to a bad rebase, as the
commit extracts hw_enc_features into its own variable. As part of this
change, it dropped the NETIF_F_FSO_IPXIP flags from the
netdev->hw_enc_features. This was unfortunately not caught during code
review.

Fix this by adding back the missing feature flags.

For reference, NETIF_F_GSO_IPXIP4 was added in commit 7e13318daa4a
("net: define gso types for IPx over IPv4 and IPv6", 2016-05-20),
replacing NETIF_F_GSO_IPIP and NETIF_F_GSO_SIT.

NETIF_F_GSO_IPXIP6 was added in commit bf2d1df39502 ("intel: Add support
for IPv6 IP-in-IP offload", 2016-05-20).

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index bc71a21c1dc2..3ff5ee49818b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -12249,6 +12249,8 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
 			  NETIF_F_GSO_GRE		|
 			  NETIF_F_GSO_GRE_CSUM		|
 			  NETIF_F_GSO_PARTIAL		|
+			  NETIF_F_GSO_IPXIP4		|
+			  NETIF_F_GSO_IPXIP6		|
 			  NETIF_F_GSO_UDP_TUNNEL	|
 			  NETIF_F_GSO_UDP_TUNNEL_CSUM	|
 			  NETIF_F_SCTP_CRC		|
-- 
2.18.0.219.gaf81d287a9da

