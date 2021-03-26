From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Date: Fri, 26 Mar 2021 19:43:42 +0100
Subject: [Intel-wired-lan] [PATCH net] i40e: Fix sparse error: 'vsi->netdev'
 could be null
In-Reply-To: <20210326184343.133396-1-arkadiusz.kubalewski@intel.com>
References: <20210326184343.133396-1-arkadiusz.kubalewski@intel.com>
Message-ID: <20210326184343.133396-3-arkadiusz.kubalewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Remove vsi->netdev->name from the trace.
This is redundant information. With the devinfo trace, the adapter
is already identifiable.

Previously following error was produced when compiling against sparse.
i40e_main.c:2571 i40e_sync_vsi_filters() error:
	we previously assumed 'vsi->netdev' could be null (see line 2323)

Fixes: b603f9dc20af ("i40e: Log info when PF is entering and leaving Allmulti mode.")
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d0feb47..2e9c22c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2568,8 +2568,7 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 				 i40e_stat_str(hw, aq_ret),
 				 i40e_aq_str(hw, hw->aq.asq_last_status));
 		} else {
-			dev_info(&pf->pdev->dev, "%s is %s allmulti mode.\n",
-				 vsi->netdev->name,
+			dev_info(&pf->pdev->dev, "%s allmulti mode.\n",
 				 cur_multipromisc ? "entering" : "leaving");
 		}
 	}

base-commit: ca4303103f33952646218db4e0869e6f6aa1c840
-- 
2.26.0

