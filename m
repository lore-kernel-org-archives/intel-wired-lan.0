From: Alice Michael <alice.michael@intel.com>
Date: Wed, 27 Dec 2017 07:32:37 -0500
Subject: [Intel-wired-lan] [next PATCH S84-V2 08/13] i40e: fix FW_LLDP flag
 on init
In-Reply-To: <20171227123242.22356-1-alice.michael@intel.com>
References: <20171227123242.22356-1-alice.michael@intel.com>
Message-ID: <20171227123242.22356-8-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alan Brady <alan.brady@intel.com>

Using ethtool --set-priv-flags disable-fw-lldp <on/off> is persistent
across reboots/reloads so we need some mechanism in the driver to detect
if it's on or off on init so we can set the ethtool private flag
appropriately.  Without this, every time the driver is reloaded the flag
will default to off regardless of whether it's on or off in FW.

We detect this by first attempting to program DCB and if AQ fails
returning I40E_AQ_RC_EPERM, we know that LLDP is disabled in FW.

Signed-off-by: Alan Brady <alan.brady@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index be24d9e..3c3cdcd 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6336,6 +6336,9 @@ static int i40e_init_pf_dcb(struct i40e_pf *pf)
 			dev_dbg(&pf->pdev->dev,
 				"DCBX offload is supported for this PF.\n");
 		}
+	} else if (pf->hw.aq.asq_last_status == I40E_AQ_RC_EPERM) {
+		dev_info(&pf->pdev->dev, "FW LLDP disabled for this PF.\n");
+		pf->flags |= I40E_FLAG_DISABLE_FW_LLDP;
 	} else {
 		dev_info(&pf->pdev->dev,
 			 "Query for DCB configuration failed, err %s aq_err %s\n",
-- 
2.9.5

