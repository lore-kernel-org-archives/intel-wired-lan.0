From: Alice Michael <alice.michael@intel.com>
Date: Wed,  6 Feb 2019 11:36:21 -0800
Subject: [Intel-wired-lan] [next PATCH S2 12/13] i40e: Able to add up to 16
 MAC filters on an untrusted VF
In-Reply-To: <20190206193622.69370-1-alice.michael@intel.com>
References: <20190206193622.69370-1-alice.michael@intel.com>
Message-ID: <20190206193622.69370-12-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Adam Ludkiewicz <adam.ludkiewicz@intel.com>

This patch fixes the problem with the driver being able to add only 7
multicast MAC address filters instead of 16. The problem is fixed by
changing the maximum number of MAC address filters to 16+1+1 (two extra
are needed because the driver uses 1 for unicast MAC address and 1 for
broadcast).

Signed-off-by: Adam Ludkiewicz <adam.ludkiewicz@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 831d52bc3c9a..d804320eb476 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2454,8 +2454,11 @@ static int i40e_vc_get_stats_msg(struct i40e_vf *vf, u8 *msg)
 				      (u8 *)&stats, sizeof(stats));
 }
 
-/* If the VF is not trusted restrict the number of MAC/VLAN it can program */
-#define I40E_VC_MAX_MAC_ADDR_PER_VF 12
+/**
+ * If the VF is not trusted restrict the number of MAC/VLAN it can program
+ * MAC filters: 16 for multicast, 1 for MAC, 1 for broadcast
+ **/
+#define I40E_VC_MAX_MAC_ADDR_PER_VF (16 + 1 + 1)
 #define I40E_VC_MAX_VLAN_PER_VF 8
 
 /**
-- 
2.19.2

