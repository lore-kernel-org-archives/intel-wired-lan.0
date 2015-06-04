From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu,  4 Jun 2015 16:24:00 -0400
Subject: [Intel-wired-lan] [intel-wired-lan][net-next PATCH 6/8] i40e:
	provide correct API version to older VF drivers
In-Reply-To: <1433449442-31420-1-git-send-email-catherine.sullivan@intel.com>
References: <1433449442-31420-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1433449442-31420-7-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

This driver fully supports VF drivers using both the 1.0 and 1.1
versions of the virtual channel API. However, VF drivers using
version 1.0 get upset if we provide them with a version other than
that, and refuse to play with us.

Correct this by checking the VFs API version at the time that we
store it off, and provide the correct version number back to the VF
so we can all get along.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I86dfe02e67b2bef336b4b49a1bb072f3e7229abc
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 1bfc4d0..4f13619 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1120,6 +1120,9 @@ static int i40e_vc_get_version_msg(struct i40e_vf *vf, u8 *msg)
 	};
 
 	vf->vf_ver = *(struct i40e_virtchnl_version_info *)msg;
+	/* VFs running the 1.0 API expect to get 1.0 back or they will cry. */
+	if (VF_IS_V10(vf))
+		info.minor = I40E_VIRTCHNL_VERSION_MINOR_NO_VF_CAPS;
 	return i40e_vc_send_msg_to_vf(vf, I40E_VIRTCHNL_OP_VERSION,
 				      I40E_SUCCESS, (u8 *)&info,
 				      sizeof(struct
-- 
1.9.3

