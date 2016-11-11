From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Fri, 11 Nov 2016 12:39:34 -0800
Subject: [Intel-wired-lan] [next PATCH S54 10/15] i40e: no need to check
	is_vsi_in_vlan before calling i40e_del_mac_all_vlan
In-Reply-To: <1478896779-13697-1-git-send-email-bimmy.pujari@intel.com>
References: <1478896779-13697-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1478896779-13697-11-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

This function won't be appreciably slower when in VLAN mode, so there is
no real reason to not just call it directly. In either case, we still
must search the full table for a MAC/VLAN pair. We do get to stop
searching a tiny bit early in the case of knowing we are not in VLAN
mode, but this is a minor savings and we can avoid the code complexity
by not having to worry about the check.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-ID: I533412195b3a42f51cf629e3675dd5145aea8625
---
Testing-hints:
  Add and delete many MAC filters with and without VLANs.

 drivers/net/ethernet/intel/i40e/i40e_main.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index aa61bbb..3812966 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1784,10 +1784,7 @@ static int i40e_addr_unsync(struct net_device *netdev, const u8 *addr)
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_vsi *vsi = np->vsi;
 
-	if (i40e_is_vsi_in_vlan(vsi))
-		i40e_del_mac_all_vlan(vsi, addr);
-	else
-		i40e_del_filter(vsi, addr, I40E_VLAN_ANY);
+	i40e_del_mac_all_vlan(vsi, addr);
 
 	return 0;
 }
-- 
2.4.11

