From: Alice Michael <alice.michael@intel.com>
Date: Tue, 29 Aug 2017 05:32:38 -0400
Subject: [Intel-wired-lan] [next PATCH S79-V2 09/13] i40e: Properly maintain
	flow director filters list
In-Reply-To: <20170829093242.41026-1-alice.michael@intel.com>
References: <20170829093242.41026-1-alice.michael@intel.com>
Message-ID: <20170829093242.41026-9-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Filip Sadowski <filip.sadowski@intel.com>

When there is no space for more flow director filters and user requested to
add a new one it is rejected by firmware and automatically removed from the
filter list maintained by driver. This behaviour is correct. Afterwards
existing filter can be removed making free slot for the new one. This
however causes the newly added filter to be accepted by firmware but
removed from driver filter list resulting in not showing after issuing
'ethtool -n <dev_name>'.

This happended due to not clearing the variable pf->fd_inv which stores
filter number to be removed from the list when firmware refused to add the
requested filter. It caused the filter with this specific ID to be
constantly removed once it was added to the list although it has been
accepted by firmware and effectively applied to the NIC.
It was fixed by clearing pf->fd_inv variable after removal of the filter
from the list when it was rejected by firmware.

Signed-off-by: Filip Sadowski <filip.sadowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index b1712b4..2fdd130 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6233,6 +6233,7 @@ void i40e_fdir_check_and_reenable(struct i40e_pf *pf)
 				hlist_del(&filter->fdir_node);
 				kfree(filter);
 				pf->fdir_pf_active_filters--;
+				pf->fd_inv = 0;
 			}
 		}
 	}
-- 
2.9.4

