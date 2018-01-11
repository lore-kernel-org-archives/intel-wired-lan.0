From: Avinash Dayanand <avinash.dayanand@intel.com>
Date: Thu, 11 Jan 2018 14:35:59 -0800
Subject: [Intel-wired-lan] [PATCH next-queue 09/12] virtchnl: Add a macro to
 check the size of a union
In-Reply-To: <20180111223602.9082-1-avinash.dayanand@intel.com>
References: <20180111223602.9082-1-avinash.dayanand@intel.com>
Message-ID: <20180111223602.9082-10-avinash.dayanand@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>

This patch adds a macro to check if the size of a union is correct.
It throws a divide by zero error if the union is not of the correct
size.

Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
---
 include/linux/avf/virtchnl.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index b6aaecd..3bbe6e0 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -140,13 +140,15 @@ enum virtchnl_ops {
 	VIRTCHNL_OP_DISABLE_CHANNELS = 31,
 };
 
-/* This macro is used to generate a compilation error if a structure
+/* These macros are used to generate compilation errors if a structure/union
  * is not exactly the correct length. It gives a divide by zero error if the
- * structure is not of the correct size, otherwise it creates an enum that is
- * never used.
+ * structure/union is not of the correct size, otherwise it creates an enum
+ * that is never used.
  */
 #define VIRTCHNL_CHECK_STRUCT_LEN(n, X) enum virtchnl_static_assert_enum_##X \
 	{ virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
+#define VIRTCHNL_CHECK_UNION_LEN(n, X) enum virtchnl_static_asset_enum_##X \
+	{ virtchnl_static_assert_##X = (n)/((sizeof(union X) == (n)) ? 1 : 0) }
 
 /* Virtual channel message descriptor. This overlays the admin queue
  * descriptor. All other data is passed in external buffers.
-- 
2.9.4

