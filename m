From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed,  8 Jan 2020 17:08:19 -0800
Subject: [Intel-wired-lan] [PATCH 4/4] devlink: add support for
 DEVLINK_CMD_REGION_TRIGGER_SNAPSHOT
In-Reply-To: <20200109010818.1326575-1-jacob.e.keller@intel.com>
References: <20200109010818.1326575-1-jacob.e.keller@intel.com>
Message-ID: <20200109010818.1326575-5-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add support for the devlink command to trigger a snapshot if the region
supports it.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 devlink/devlink.c            | 20 ++++++++++++++++++++
 include/uapi/linux/devlink.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 95f05a0b..3a473531 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -4200,6 +4200,7 @@ static const char *cmd_obj(uint8_t cmd)
 	case DEVLINK_CMD_REGION_SET:
 	case DEVLINK_CMD_REGION_NEW:
 	case DEVLINK_CMD_REGION_DEL:
+	case DEVLINK_CMD_REGION_TRIGGER_SNAPSHOT:
 		return "region";
 	case DEVLINK_CMD_FLASH_UPDATE:
 	case DEVLINK_CMD_FLASH_UPDATE_END:
@@ -6362,12 +6363,28 @@ static int cmd_region_read(struct dl *dl)
 	return err;
 }
 
+static int cmd_region_trigger(struct dl *dl)
+{
+	struct nlmsghdr *nlh;
+	int err;
+
+	nlh = mnlg_msg_prepare(dl->nlg, DEVLINK_CMD_REGION_TRIGGER_SNAPSHOT,
+			NLM_F_REQUEST | NLM_F_ACK);
+
+	err = dl_argv_parse_put(nlh, dl, DL_OPT_HANDLE_REGION, 0);
+	if (err)
+		return err;
+
+	return _mnlg_socket_sndrcv(dl->nlg, nlh, NULL, NULL);
+}
+
 static void cmd_region_help(void)
 {
 	pr_err("Usage: devlink region show [ DEV/REGION ]\n");
 	pr_err("       devlink region del DEV/REGION snapshot SNAPSHOT_ID\n");
 	pr_err("       devlink region dump DEV/REGION [ snapshot SNAPSHOT_ID ]\n");
 	pr_err("       devlink region read DEV/REGION [ snapshot SNAPSHOT_ID ] address ADDRESS length LENGTH\n");
+	pr_err("       devlink region trigger DEV/REGION\n");
 }
 
 static int cmd_region(struct dl *dl)
@@ -6389,6 +6406,9 @@ static int cmd_region(struct dl *dl)
 	} else if (dl_argv_match(dl, "read")) {
 		dl_arg_inc(dl);
 		return cmd_region_read(dl);
+	} else if (dl_argv_match(dl, "trigger")) {
+		dl_arg_inc(dl);
+		return cmd_region_trigger(dl);
 	}
 	pr_err("Command \"%s\" not found\n", dl_argv(dl));
 	return -ENOENT;
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 3f82dedd..37348f84 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -117,6 +117,8 @@ enum devlink_command {
 	DEVLINK_CMD_TRAP_GROUP_NEW,
 	DEVLINK_CMD_TRAP_GROUP_DEL,
 
+	DEVLINK_CMD_REGION_TRIGGER_SNAPSHOT,
+
 	/* add new commands above here */
 	__DEVLINK_CMD_MAX,
 	DEVLINK_CMD_MAX = __DEVLINK_CMD_MAX - 1
-- 
2.21.0

