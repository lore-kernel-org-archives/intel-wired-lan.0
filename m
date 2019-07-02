From: Alice Michael <alice.michael@intel.com>
Date: Tue,  2 Jul 2019 08:22:52 -0400
Subject: [Intel-wired-lan] [next PATCH S7 2/9] i40e: make visible changed vf
 mac on host
In-Reply-To: <20190702122259.79070-1-alice.michael@intel.com>
References: <20190702122259.79070-1-alice.michael@intel.com>
Message-ID: <20190702122259.79070-2-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

This patch makes changed vm mac address visible on host via
ip link show command. This problem is fixed by copying last
unicast mac filter to vf->default_lan_addr.addr. Without
this patch if vf mac was not set from host side and
if you run ip link show $pf, on host side you'd always
see a zero mac, not the real vf mac that vf assigned to
itself.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 02b09a8ad54c..21f7ac514d1f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2629,6 +2629,9 @@ static int i40e_vc_add_mac_addr_msg(struct i40e_vf *vf, u8 *msg)
 			} else {
 				vf->num_mac++;
 			}
+			if (is_valid_ether_addr(al->list[i].addr))
+				ether_addr_copy(vf->default_lan_addr.addr,
+						al->list[i].addr);
 		}
 	}
 	spin_unlock_bh(&vsi->mac_filter_hash_lock);
-- 
2.21.0

