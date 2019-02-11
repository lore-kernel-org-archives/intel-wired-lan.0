From: Nicholas Nunley <nicholas.d.nunley@intel.com>
Date: Mon, 11 Feb 2019 11:22:25 -0800
Subject: [Intel-wired-lan] [PATCH v3 4/6] ethtool: support per-queue sub
 command --show-coalesce
In-Reply-To: <20190211192227.34960-1-nicholas.d.nunley@intel.com>
References: <20190211192227.34960-1-nicholas.d.nunley@intel.com>
Message-ID: <20190211192227.34960-4-nicholas.d.nunley@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Get all masked queues' coalesce settings from kernel and dump them one by
one.

Example:

 $ sudo ./ethtool --per-queue eth5 queue_mask 0x11 --show-coalesce
 Queue: 0
 Adaptive RX: off  TX: off
 stats-block-usecs: 0
 sample-interval: 0
 pkt-rate-low: 0
 pkt-rate-high: 0

 rx-usecs: 222
 rx-frames: 0
 rx-usecs-irq: 0
 rx-frames-irq: 256

 tx-usecs: 222
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

 Queue: 4
 Adaptive RX: off  TX: off
 stats-block-usecs: 0
 sample-interval: 0
 pkt-rate-low: 0
 pkt-rate-high: 0

 rx-usecs: 222
 rx-frames: 0
 rx-usecs-irq: 0
 rx-frames-irq: 256

 tx-usecs: 222
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
 ethtool.8.in |  2 +-
 ethtool.c    | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/ethtool.8.in b/ethtool.8.in
index 10f24db..b4e240e 100644
--- a/ethtool.8.in
+++ b/ethtool.8.in
@@ -1153,7 +1153,7 @@ Sets the specific queues which the sub command is applied to.
 If queue_mask is not set, the sub command will be applied to all queues.
 .TP
 .B sub_command
-Sub command to apply.
+Sub command to apply. The supported sub commands include --show-coalesce.
 .RE
 .SH BUGS
 Not supported (in part or whole) on all network drivers.
diff --git a/ethtool.c b/ethtool.c
index 5f72741..1abf7c0 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -1410,6 +1410,31 @@ static int dump_coalesce(const struct ethtool_coalesce *ecoal)
 	return 0;
 }
 
+void dump_per_queue_coalesce(struct ethtool_per_queue_op *per_queue_opt,
+			     __u32 *queue_mask, int n_queues)
+{
+	struct ethtool_coalesce *ecoal;
+	int i, idx = 0;
+
+	ecoal = (struct ethtool_coalesce *)(per_queue_opt + 1);
+	for (i = 0; i < __KERNEL_DIV_ROUND_UP(MAX_NUM_QUEUE, 32); i++) {
+		int queue = i * 32;
+		__u32 mask = queue_mask[i];
+
+		while (mask > 0) {
+			if (mask & 0x1) {
+				fprintf(stdout, "Queue: %d\n", queue);
+				dump_coalesce(ecoal + idx);
+				idx++;
+			}
+			mask = mask >> 1;
+			queue++;
+		}
+		if (idx == n_queues)
+			break;
+	}
+}
+
 struct feature_state {
 	u32 off_flags;
 	struct ethtool_gfeatures features;
@@ -5248,7 +5273,8 @@ static const struct option {
 	{ "--show-fec", 1, do_gfec, "Show FEC settings"},
 	{ "--set-fec", 1, do_sfec, "Set FEC settings",
 	  "		[ encoding auto|off|rs|baser [...]]\n"},
-	{ "-Q|--per-queue", 1, do_perqueue, "Apply per-queue command",
+	{ "-Q|--per-queue", 1, do_perqueue, "Apply per-queue command."
+	  "The supported sub commands include --show-coalesce",
 	  "             [queue_mask %x] SUB_COMMAND\n"},
 	{ "-h|--help", 0, show_usage, "Show this help" },
 	{ "--version", 0, do_version, "Show version number" },
@@ -5315,8 +5341,32 @@ static int find_max_num_queues(struct cmd_context *ctx)
 		echannels.combined_count;
 }
 
+static struct ethtool_per_queue_op *
+get_per_queue_coalesce(struct cmd_context *ctx, __u32 *queue_mask, int n_queues)
+{
+	struct ethtool_per_queue_op *per_queue_opt;
+
+	per_queue_opt = malloc(sizeof(*per_queue_opt) + n_queues *
+			sizeof(struct ethtool_coalesce));
+	if (!per_queue_opt)
+		return NULL;
+
+	memcpy(per_queue_opt->queue_mask, queue_mask,
+	       __KERNEL_DIV_ROUND_UP(MAX_NUM_QUEUE, 32) * sizeof(__u32));
+	per_queue_opt->cmd = ETHTOOL_PERQUEUE;
+	per_queue_opt->sub_command = ETHTOOL_GCOALESCE;
+	if (send_ioctl(ctx, per_queue_opt)) {
+		free(per_queue_opt);
+		perror("Cannot get device per queue parameters");
+		return NULL;
+	}
+
+	return per_queue_opt;
+}
+
 static int do_perqueue(struct cmd_context *ctx)
 {
+	struct ethtool_per_queue_op *per_queue_opt;
 	__u32 queue_mask[__KERNEL_DIV_ROUND_UP(MAX_NUM_QUEUE, 32)] = {0};
 	int i, n_queues = 0;
 
@@ -5367,9 +5417,21 @@ static int do_perqueue(struct cmd_context *ctx)
 	if (i < 0)
 		exit_bad_args();
 
-	/* no sub_command support yet */
+	if (strstr(args[i].opts, "--show-coalesce") != NULL) {
+		per_queue_opt = get_per_queue_coalesce(ctx, queue_mask,
+						       n_queues);
+		if (per_queue_opt == NULL) {
+			perror("Cannot get device per queue parameters");
+			return -EFAULT;
+		}
+		dump_per_queue_coalesce(per_queue_opt, queue_mask, n_queues);
+		free(per_queue_opt);
+	} else {
+		perror("The subcommand is not supported yet");
+		return -EOPNOTSUPP;
+	}
 
-	return -EOPNOTSUPP;
+	return 0;
 }
 
 int main(int argc, char **argp)
-- 
2.14.4

