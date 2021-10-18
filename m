From: Shiraz Saleem <shiraz.saleem@intel.com>
Date: Mon, 18 Oct 2021 18:16:01 -0500
Subject: [Intel-wired-lan] [net-next 1/3] devlink: Add 'enable_iwarp'
 generic device param
In-Reply-To: <20211018231603.1690-1-shiraz.saleem@intel.com>
References: <20211018231603.1690-1-shiraz.saleem@intel.com>
Message-ID: <20211018231603.1690-2-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add a new device generic parameter to enable and disable
iWARP functionality on a multi-protocol RDMA device.

Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 Documentation/networking/devlink/devlink-params.rst | 3 +++
 include/net/devlink.h                               | 4 ++++
 net/core/devlink.c                                  | 5 +++++
 3 files changed, 12 insertions(+)

diff --git a/Documentation/networking/devlink/devlink-params.rst b/Documentation/networking/devlink/devlink-params.rst
index 4878907..b7dfe69 100644
--- a/Documentation/networking/devlink/devlink-params.rst
+++ b/Documentation/networking/devlink/devlink-params.rst
@@ -109,6 +109,9 @@ own name.
      - Boolean
      - When enabled, the device driver will instantiate VDPA networking
        specific auxiliary device of the devlink device.
+   * - ``enable_iwarp``
+     - Boolean
+     - Enable handling of iWARP traffic in the device.
    * - ``internal_err_reset``
      - Boolean
      - When enabled, the device driver will reset the device on internal
diff --git a/include/net/devlink.h b/include/net/devlink.h
index a7852a2..9f39f38 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -524,6 +524,7 @@ enum devlink_param_generic_id {
 	DEVLINK_PARAM_GENERIC_ID_ENABLE_ETH,
 	DEVLINK_PARAM_GENERIC_ID_ENABLE_RDMA,
 	DEVLINK_PARAM_GENERIC_ID_ENABLE_VNET,
+	DEVLINK_PARAM_GENERIC_ID_ENABLE_IWARP,
 
 	/* add new param generic ids above here*/
 	__DEVLINK_PARAM_GENERIC_ID_MAX,
@@ -573,6 +574,9 @@ enum devlink_param_generic_id {
 #define DEVLINK_PARAM_GENERIC_ENABLE_VNET_NAME "enable_vnet"
 #define DEVLINK_PARAM_GENERIC_ENABLE_VNET_TYPE DEVLINK_PARAM_TYPE_BOOL
 
+#define DEVLINK_PARAM_GENERIC_ENABLE_IWARP_NAME "enable_iwarp"
+#define DEVLINK_PARAM_GENERIC_ENABLE_IWARP_TYPE DEVLINK_PARAM_TYPE_BOOL
+
 #define DEVLINK_PARAM_GENERIC(_id, _cmodes, _get, _set, _validate)	\
 {									\
 	.id = DEVLINK_PARAM_GENERIC_ID_##_id,				\
diff --git a/net/core/devlink.c b/net/core/devlink.c
index 4917112..9803fb0 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -4358,6 +4358,11 @@ static int devlink_nl_cmd_flash_update(struct sk_buff *skb,
 		.name = DEVLINK_PARAM_GENERIC_ENABLE_VNET_NAME,
 		.type = DEVLINK_PARAM_GENERIC_ENABLE_VNET_TYPE,
 	},
+	{
+		.id = DEVLINK_PARAM_GENERIC_ID_ENABLE_IWARP,
+		.name = DEVLINK_PARAM_GENERIC_ENABLE_IWARP_NAME,
+		.type = DEVLINK_PARAM_GENERIC_ENABLE_IWARP_TYPE,
+	},
 };
 
 static int devlink_param_generic_verify(const struct devlink_param *param)
-- 
1.8.3.1

