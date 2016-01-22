From: Alexander Duyck <aduyck@mirantis.com>
Date: Thu, 21 Jan 2016 16:28:17 -0800
Subject: [Intel-wired-lan] [next PATCH v2 13/15] i40e: Do not drop support
 for IPv6 VXLAN or GENEVE tunnels
In-Reply-To: <20160122002407.18278.95721.stgit@localhost.localdomain>
References: <20160122002407.18278.95721.stgit@localhost.localdomain>
Message-ID: <20160122002817.18278.25246.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

All of the documentation in the datasheets for the XL710 do not call out
any reason to exclude support for IPv6 based tunnels.  As such I am
dropping the code that was excluding these tunnel types from having their
port numbers recognized.  This way we can take advantage of things such as
checksum offload for inner headers over IPv6 based VXLAN or GENEVE
tunnels.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c |   12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 1316b9958e7e..e3a903f01d73 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8617,9 +8617,6 @@ static void i40e_add_vxlan_port(struct net_device *netdev,
 	u8 next_idx;
 	u8 idx;
 
-	if (sa_family == AF_INET6)
-		return;
-
 	idx = i40e_get_udp_port_idx(pf, port);
 
 	/* Check if port already exists */
@@ -8659,9 +8656,6 @@ static void i40e_del_vxlan_port(struct net_device *netdev,
 	struct i40e_pf *pf = vsi->back;
 	u8 idx;
 
-	if (sa_family == AF_INET6)
-		return;
-
 	idx = i40e_get_udp_port_idx(pf, port);
 
 	/* Check if port already exists */
@@ -8698,9 +8692,6 @@ static void i40e_add_geneve_port(struct net_device *netdev,
 	if (!(pf->flags & I40E_FLAG_GENEVE_OFFLOAD_CAPABLE))
 		return;
 
-	if (sa_family == AF_INET6)
-		return;
-
 	idx = i40e_get_udp_port_idx(pf, port);
 
 	/* Check if port already exists */
@@ -8742,9 +8733,6 @@ static void i40e_del_geneve_port(struct net_device *netdev,
 	struct i40e_pf *pf = vsi->back;
 	u8 idx;
 
-	if (sa_family == AF_INET6)
-		return;
-
 	if (!(pf->flags & I40E_FLAG_GENEVE_OFFLOAD_CAPABLE))
 		return;
 

