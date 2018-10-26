From: Alice Michael <alice.michael@intel.com>
Date: Fri, 26 Oct 2018 14:33:31 -0700
Subject: [Intel-wired-lan] [next PATCH S98 4/6] virtchnl: Fix off by one
 error
In-Reply-To: <20181026213333.51495-1-alice.michael@intel.com>
References: <20181026213333.51495-1-alice.michael@intel.com>
Message-ID: <20181026213333.51495-4-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When calculating the valid length for a VIRTCHNL_OP_ENABLE_CHANNELS
message, we accidentally allowed messages with one extra
virtchnl_channel_info structure on the end. This happened due
to an off by one error, because we forgot that valid_len already
accounted for one virtchnl_channel_info structure, so we need to
subtract one from the num_tc value.

Signed-off-by: Alice Michael <alice.michael@intel.com>
---
 include/linux/avf/virtchnl.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index 3130dec..7605b59 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -819,8 +819,8 @@ virtchnl_vc_validate_vf_msg(struct virtchnl_version_info *ver, u32 v_opcode,
 		if (msglen >= valid_len) {
 			struct virtchnl_tc_info *vti =
 				(struct virtchnl_tc_info *)msg;
-			valid_len += vti->num_tc *
-				sizeof(struct virtchnl_channel_info);
+			valid_len += (vti->num_tc - 1) *
+				     sizeof(struct virtchnl_channel_info);
 			if (vti->num_tc == 0)
 				err_msg_format = true;
 		}
-- 
2.9.5

