From: Alice Michael <alice.michael@intel.com>
Date: Tue, 31 Jul 2018 03:41:40 -0700
Subject: [Intel-wired-lan] [next PATCH S93 03/11] i40e: Set fec_config when
 forcing link state
In-Reply-To: <20180731104148.11896-1-alice.michael@intel.com>
References: <20180731104148.11896-1-alice.michael@intel.com>
Message-ID: <20180731104148.11896-3-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mariusz Stachura <mariusz.stachura@intel.com>

This patch configures FEC setting in i40e_force_link_state().
For some reason setting this field was overlooked thus causing
25G link to be configured incorrectly.

Signed-off-by: Mariusz Stachura <mariusz.stachura@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 13940e0..a730f48 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6597,6 +6597,8 @@ static i40e_status i40e_force_link_state(struct i40e_pf *pf, bool is_up)
 	config.eee_capability = abilities.eee_capability;
 	config.eeer = abilities.eeer_val;
 	config.low_power_ctrl = abilities.d3_lpan;
+	config.fec_config = abilities.fec_cfg_curr_mod_ext_info &
+			    I40E_AQ_PHY_FEC_CONFIG_MASK;
 	err = i40e_aq_set_phy_config(hw, &config, NULL);
 
 	if (err) {
-- 
2.9.5

