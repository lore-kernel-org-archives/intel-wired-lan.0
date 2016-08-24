From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Wed, 24 Aug 2016 11:33:49 -0700
Subject: [Intel-wired-lan] [next PATCH S44 4/6] i40e: return correct opcode
	to VF
In-Reply-To: <1472063631-9033-1-git-send-email-bimmy.pujari@intel.com>
References: <1472063631-9033-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1472063631-9033-5-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

This conditional is backward, so the driver responds back to the VF with
the wrong opcode. Do the old switcheroo to fix this.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I384035b0fef8a3881c176de4b4672009b3400b25
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index fe73bae..27df091 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2365,8 +2365,8 @@ static int i40e_vc_iwarp_qvmap_msg(struct i40e_vf *vf, u8 *msg, u16 msglen,
 error_param:
 	/* send the response to the VF */
 	return i40e_vc_send_resp_to_vf(vf,
-			       config ? I40E_VIRTCHNL_OP_RELEASE_IWARP_IRQ_MAP :
-			       I40E_VIRTCHNL_OP_CONFIG_IWARP_IRQ_MAP,
+			       config ? I40E_VIRTCHNL_OP_CONFIG_IWARP_IRQ_MAP :
+			       I40E_VIRTCHNL_OP_RELEASE_IWARP_IRQ_MAP,
 			       aq_ret);
 }
 
-- 
2.4.11

