From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Thu, 11 Apr 2019 09:11:34 -0700
Subject: [Intel-wired-lan] [PATCH 2/4] i40e: Use LLDP ethertype define
 ETH_P_LLDP
In-Reply-To: <20190411161136.1541-1-anirudh.venkataramanan@intel.com>
References: <20190411161136.1541-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190411161136.1541-3-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Remove references to I40E_ETH_P_LLDP and use ETH_P_LLDP instead.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h         | 2 --
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 24ef1694ecb0..1da53c0d49ca 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -296,8 +296,6 @@ struct i40e_cloud_filter {
 	u8 tunnel_type;
 };
 
-#define I40E_ETH_P_LLDP			0x88cc
-
 #define I40E_DCB_PRIO_TYPE_STRICT	0
 #define I40E_DCB_PRIO_TYPE_ETS		1
 #define I40E_DCB_STRICT_PRIO_CREDITS	127
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 7ea4f09229e4..dc5b40013e61 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -1330,7 +1330,7 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 			}
 			ret = i40e_aq_add_rem_control_packet_filter(&pf->hw,
 						pf->hw.mac.addr,
-						I40E_ETH_P_LLDP, 0,
+						ETH_P_LLDP, 0,
 						pf->vsi[pf->lan_vsi]->seid,
 						0, true, NULL, NULL);
 			if (ret) {
@@ -1348,7 +1348,7 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 
 			ret = i40e_aq_add_rem_control_packet_filter(&pf->hw,
 						pf->hw.mac.addr,
-						I40E_ETH_P_LLDP, 0,
+						ETH_P_LLDP, 0,
 						pf->vsi[pf->lan_vsi]->seid,
 						0, false, NULL, NULL);
 			if (ret) {
-- 
2.20.1

