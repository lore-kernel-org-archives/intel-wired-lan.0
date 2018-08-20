From: Alice Michael <alice.michael@intel.com>
Date: Mon, 20 Aug 2018 08:12:32 -0700
Subject: [Intel-wired-lan] [next PATCH S95 11/12] virtchnl: use u8 type for
 a field in the virtchnl_filter struct
In-Reply-To: <20180820151233.14629-1-alice.michael@intel.com>
References: <20180820151233.14629-1-alice.michael@intel.com>
Message-ID: <20180820151233.14629-11-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>

The virtchnl_filter struct has a field called field_flags. A previous
commit mistakenly had the type to be a __u8. What we want is for the
field to be an unsigned 8 bit value, so let's just use the existing
kernel type u8 for that.

Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
---
 include/linux/avf/virtchnl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index 7cd2290..2c9756b 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -575,7 +575,7 @@ struct virtchnl_filter {
 	enum	virtchnl_flow_type flow_type;
 	enum	virtchnl_action action;
 	u32	action_meta;
-	__u8	field_flags;
+	u8	field_flags;
 };
 
 VIRTCHNL_CHECK_STRUCT_LEN(272, virtchnl_filter);
-- 
2.9.5

