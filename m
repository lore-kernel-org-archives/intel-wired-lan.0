From: Alice Michael <alice.michael@intel.com>
Date: Wed,  1 Aug 2018 17:40:32 -0700
Subject: [Intel-wired-lan] [next PATCH S94 09/13] i40e: Set
 netdev_registered when registering netdev in recovery mode
In-Reply-To: <20180802004036.89363-1-alice.michael@intel.com>
References: <20180802004036.89363-1-alice.michael@intel.com>
Message-ID: <20180802004036.89363-9-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Patryk Ma?ek <patryk.malek@intel.com>

When initializing adapter in recovery mode we've forgotten to set
netdev_registered to true causing kernel BUGs when we unload the module
after successful recovery. This patch sets this flag correctly as it was
supposed to be set.

Signed-off-by: Patryk Ma?ek <patryk.malek@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 725b2de..ca701e0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13694,6 +13694,7 @@ static int i40e_init_recovery_mode(struct i40e_pf *pf, struct i40e_hw *hw)
 	err = register_netdev(vsi->netdev);
 	if (err)
 		goto err_switch_setup;
+	vsi->netdev_registered = true;
 	i40e_dbg_pf_init(pf);
 
 	err = i40e_setup_misc_vector_for_recovery_mode(pf);
-- 
2.9.5

