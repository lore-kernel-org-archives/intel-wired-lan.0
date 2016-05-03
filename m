From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue,  3 May 2016 15:13:17 -0700
Subject: [Intel-wired-lan] [next PATCH S36 09/12] i40e: set context to use
	VSI RSS Lut for SR-IOV
In-Reply-To: <1462313600-3123-1-git-send-email-bimmy.pujari@intel.com>
References: <1462313600-3123-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1462313600-3123-10-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: "Ashish Shah" <ashish.n.shah@intel.com>

For the SR-IOV VSIs, when the queue filtering section is valid,
the RSS LUT needs to be set to use the VSI specific lookup table
(otherwise it will use the PF RSS LUT table).

Signed-off-by: Ashish Shah <ashish.n.shah@intel.com>
Change-ID: Ia9377cc818078238a75c3bdeade1b593a91b3480
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 3d3c70c..e75bf94 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9362,7 +9362,8 @@ static int i40e_add_vsi(struct i40e_vsi *vsi)
 			ctxt.info.valid_sections |=
 				cpu_to_le16(I40E_AQ_VSI_PROP_QUEUE_OPT_VALID);
 			ctxt.info.queueing_opt_flags |=
-						I40E_AQ_VSI_QUE_OPT_TCP_ENA;
+				(I40E_AQ_VSI_QUE_OPT_TCP_ENA |
+				 I40E_AQ_VSI_QUE_OPT_RSS_LUT_VSI);
 		}
 
 		ctxt.info.valid_sections |= cpu_to_le16(I40E_AQ_VSI_PROP_VLAN_VALID);
-- 
2.4.11

