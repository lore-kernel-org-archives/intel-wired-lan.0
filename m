From: Lihong Yang <lihong.yang@intel.com>
Date: Wed, 21 Nov 2018 09:15:37 -0800
Subject: [Intel-wired-lan] [PATCH] i40e: Fix deletion of MAC filters
Message-ID: <20181121171537.36459-1-lihong.yang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In __i40e_del_filter function, the flag __I40E_MACVLAN_SYNC_PENDING for
the PF state is wrongly set for the VSI. Deleting any of the MAC filters
has caused the incorrect syncing for the PF. Fix it by setting this state
flag to the intended PF.

Signed-off-by: Lihong Yang <lihong.yang@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 2c65a0337594..060e78f7ab1b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1422,7 +1422,7 @@ void __i40e_del_filter(struct i40e_vsi *vsi, struct i40e_mac_filter *f)
 	}
 
 	vsi->flags |= I40E_VSI_FLAG_FILTER_CHANGED;
-	set_bit(__I40E_MACVLAN_SYNC_PENDING, vsi->state);
+	set_bit(__I40E_MACVLAN_SYNC_PENDING, vsi->back->state);
 }
 
 /**
-- 
2.13.6

