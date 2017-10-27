From: Alice Michael <alice.michael@intel.com>
Date: Fri, 27 Oct 2017 11:06:53 -0400
Subject: [Intel-wired-lan] [next PATCH S81-V3 6/9] i40e: update VFs of link
	state after GET_VF_RESOURCES
In-Reply-To: <20171027150656.68250-1-alice.michael@intel.com>
References: <20171027150656.68250-1-alice.michael@intel.com>
Message-ID: <20171027150656.68250-6-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

We currently notify a VF of the link state after ENABLE_QUEUES, which is
the last thing a VF does after being configured. Guests may not actually
ENABLE_QUEUES until they get configured, and thus between driver load
and device configuration the VF may show inaccurate link status.

Fix this by also sending the link state after GET_VF_RESOURCES. Although
we could remove the message following ENABLE_QUEUES, it's not that
significant of a loss, so this patch just keeps both to ensure maximum
compatibility with guests on various OSes.

Specifically, without this patch guests running FreeBSD will display
inaccurate link state until the device is brought up. This is mostly
a cosmetic issue but can be confusing to system administrators.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 56dd1e8..5c5113c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2748,6 +2748,7 @@ int i40e_vc_process_vf_msg(struct i40e_pf *pf, s16 vf_id, u32 v_opcode,
 		break;
 	case VIRTCHNL_OP_GET_VF_RESOURCES:
 		ret = i40e_vc_get_vf_resources_msg(vf, msg);
+		i40e_vc_notify_vf_link_state(vf);
 		break;
 	case VIRTCHNL_OP_RESET_VF:
 		i40e_vc_reset_vf_msg(vf);
-- 
2.9.5

