From: Alice Michael <alice.michael@intel.com>
Date: Tue,  2 Jul 2019 08:22:57 -0400
Subject: [Intel-wired-lan] [next PATCH S7 7/9] i40e: Log info when PF is
 entering and leaving Allmulti mode.
In-Reply-To: <20190702122259.79070-1-alice.michael@intel.com>
References: <20190702122259.79070-1-alice.michael@intel.com>
Message-ID: <20190702122259.79070-7-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Czeslaw Zagorski <czeslawx.zagorski@intel.com>

Add log when PF is entering and leaving Allmulti mode. The
change of PF state is visible in dmesg now. Without this commit,
entering and leaving Allmulti mode is not logged in dmesg.

Signed-off-by: Czeslaw Zagorski <czeslawx.zagorski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index db3ecb8e7051..452cbc423cb3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2530,6 +2530,10 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 				 vsi_name,
 				 i40e_stat_str(hw, aq_ret),
 				 i40e_aq_str(hw, hw->aq.asq_last_status));
+		} else {
+			dev_info(&pf->pdev->dev, "%s is %s allmulti mode.\n",
+				 vsi->netdev->name,
+				 cur_multipromisc ? "entering" : "leaving");
 		}
 	}
 
-- 
2.21.0

