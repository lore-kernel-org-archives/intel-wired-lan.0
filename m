From: Nicholas Nunley <nicholas.d.nunley@intel.com>
Date: Mon, 11 Feb 2019 11:22:26 -0800
Subject: [Intel-wired-lan] [PATCH v3 5/6] ethtool: support per-queue sub
 command --coalesce
In-Reply-To: <20190211192227.34960-1-nicholas.d.nunley@intel.com>
References: <20190211192227.34960-1-nicholas.d.nunley@intel.com>
Message-ID: <20190211192227.34960-5-nicholas.d.nunley@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch adds the ability to configure the coalesce settings from
do_scoalesce on a per-queue basis.

For each masked queue the current settings are read, modified, and written
back to the kernel.

Example:

 $ sudo ./ethtool --per-queue eth5 queue_mask 0x1 --coalesce
 rx-usecs 10 tx-usecs 5
 $ sudo ./ethtool --per-queue eth5 queue_mask 0x1 --show-coalesce

 Queue: 0
 Adaptive RX: on  TX: on
 stats-block-usecs: 0
 sample-interval: 0
 pkt-rate-low: 0
 pkt-rate-high: 0

 rx-usecs: 10
 rx-frames: 0
 rx-usecs-irq: 0
 rx-frames-irq: 256

 tx-usecs: 5
 tx-frames: 0
 tx-usecs-irq: 0
 tx-frames-irq: 256

 rx-usecs-low: 0
 rx-frame-low: 0
 tx-usecs-low: 0
 tx-frame-low: 0

 rx-usecs-high: 0
 rx-frame-high: 0
 tx-usecs-high: 0
 tx-frame-high: 0

Based on patch by Kan Liang <kan.liang@intel.com>

Signed-off-by: Nicholas Nunley <nicholas.d.nunley@intel.com>
---
 ethtool.8.in |  3 ++-
 ethtool.c    | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/ethtool.8.in b/ethtool.8.in
index b4e240e..2f788f3 100644
--- a/ethtool.8.in
+++ b/ethtool.8.in
@@ -1153,7 +1153,8 @@ Sets the specific queues which the sub command is applied to.
 If queue_mask is not set, the sub command will be applied to all queues.
 .TP
 .B sub_command
-Sub command to apply. The supported sub commands include --show-coalesce.
+Sub command to apply. The supported sub commands include --show-coalesce and
+--coalesce.
 .RE
 .SH BUGS
 Not supported (in part or whole) on all network drivers.
diff --git a/ethtool.c b/ethtool.c
index 1abf7c0..2296578 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -5274,7 +5274,7 @@ static const struct option {
 	{ "--set-fec", 1, do_sfec, "Set FEC settings",
 	  "		[ encoding auto|off|rs|baser [...]]\n"},
 	{ "-Q|--per-queue", 1, do_perqueue, "Apply per-queue command."
-	  "The supported sub commands include --show-coalesce",
+	  "The supported sub commands include --show-coalesce, --coalesce",
 	  "             [queue_mask %x] SUB_COMMAND\n"},
 	{ "-h|--help", 0, show_usage, "Show this help" },
 	{ "--version", 0, do_version, "Show version number" },
@@ -5364,6 +5364,57 @@ get_per_queue_coalesce(struct cmd_context *ctx, __u32 *queue_mask, int n_queues)
 	return per_queue_opt;
 }
 
+static void set_per_queue_coalesce(struct cmd_context *ctx,
+				   struct ethtool_per_queue_op *per_queue_opt,
+				   int n_queues)
+{
+	struct ethtool_coalesce ecoal;
+	DECLARE_COALESCE_OPTION_VARS();
+	struct cmdline_info cmdline_coalesce[] = COALESCE_CMDLINE_INFO(ecoal);
+	__u32 *queue_mask = per_queue_opt->queue_mask;
+	struct ethtool_coalesce *ecoal_q;
+	int gcoalesce_changed = 0;
+	int i, idx = 0;
+
+	parse_generic_cmdline(ctx, &gcoalesce_changed,
+			      cmdline_coalesce, ARRAY_SIZE(cmdline_coalesce));
+
+	ecoal_q = (struct ethtool_coalesce *)(per_queue_opt + 1);
+	for (i = 0; i < __KERNEL_DIV_ROUND_UP(MAX_NUM_QUEUE, 32); i++) {
+		int queue = i * 32;
+		__u32 mask = queue_mask[i];
+
+		while (mask > 0) {
+			if (mask & 0x1) {
+				int changed = 0;
+
+				memcpy(&ecoal, ecoal_q + idx,
+				       sizeof(struct ethtool_coalesce));
+				do_generic_set(cmdline_coalesce,
+					       ARRAY_SIZE(cmdline_coalesce),
+					       &changed);
+				if (!changed)
+					fprintf(stderr,
+						"Queue %d, no coalesce parameters changed\n",
+						queue);
+				memcpy(ecoal_q + idx, &ecoal,
+				       sizeof(struct ethtool_coalesce));
+				idx++;
+			}
+			mask = mask >> 1;
+			queue++;
+		}
+		if (idx == n_queues)
+			break;
+	}
+
+	per_queue_opt->cmd = ETHTOOL_PERQUEUE;
+	per_queue_opt->sub_command = ETHTOOL_SCOALESCE;
+
+	if (send_ioctl(ctx, per_queue_opt))
+		perror("Cannot set device per queue parameters");
+}
+
 static int do_perqueue(struct cmd_context *ctx)
 {
 	struct ethtool_per_queue_op *per_queue_opt;
@@ -5426,6 +5477,17 @@ static int do_perqueue(struct cmd_context *ctx)
 		}
 		dump_per_queue_coalesce(per_queue_opt, queue_mask, n_queues);
 		free(per_queue_opt);
+	} else if (strstr(args[i].opts, "--coalesce") != NULL) {
+		ctx->argc--;
+		ctx->argp++;
+		per_queue_opt = get_per_queue_coalesce(ctx, queue_mask,
+						       n_queues);
+		if (per_queue_opt == NULL) {
+			perror("Cannot get device per queue parameters");
+			return -EFAULT;
+		}
+		set_per_queue_coalesce(ctx, per_queue_opt, n_queues);
+		free(per_queue_opt);
 	} else {
 		perror("The subcommand is not supported yet");
 		return -EOPNOTSUPP;
-- 
2.14.4

