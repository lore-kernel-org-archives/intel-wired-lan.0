From: Nicholas Nunley <nicholas.d.nunley@intel.com>
Date: Fri,  1 Mar 2019 15:31:51 -0800
Subject: [Intel-wired-lan] [PATCH v4 3/6] ethtool: introduce new ioctl for
 per-queue settings
In-Reply-To: <20190301233154.46636-1-nicholas.d.nunley@intel.com>
References: <20190301233154.46636-1-nicholas.d.nunley@intel.com>
Message-ID: <20190301233154.46636-3-nicholas.d.nunley@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Introduce a new ioctl for applying per-queue parameters.
Users can apply commands to specific queues by setting SUB_COMMAND and
queue_mask with the following ethtool command:

 ethtool -Q|--per-queue DEVNAME [queue_mask %x] SUB_COMMAND

If queue_mask is not set, the SUB_COMMAND will be applied to all queues.

SUB_COMMANDs for per-queue settings will be implemented in following
patches.

Based on patch by Kan Liang <kan.liang@intel.com>

Signed-off-by: Nicholas Nunley <nicholas.d.nunley@intel.com>
---
 ethtool.8.in | 20 +++++++++++++++
 ethtool.c    | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/ethtool.8.in b/ethtool.8.in
index 5a26cff..10f24db 100644
--- a/ethtool.8.in
+++ b/ethtool.8.in
@@ -391,6 +391,14 @@ ethtool \- query or control network driver and hardware settings
 .I devname
 .B encoding
 .BR auto | off | rs | baser \ [...]
+.HP
+.B ethtool \-Q|\-\-per\-queue
+.I devname
+.RB [ queue_mask
+.IR %x ]
+.I sub_command
+.RB ...
+ .
 .
 .\" Adjust lines (i.e. full justification) and hyphenate.
 .ad
@@ -1135,6 +1143,18 @@ RS	Force RS-FEC encoding
 BaseR	Force BaseR encoding
 .TE
 .RE
+.TP
+.B \-Q|\-\-per\-queue
+Applies provided sub command to specific queues.
+.RS 4
+.TP
+.B queue_mask %x
+Sets the specific queues which the sub command is applied to.
+If queue_mask is not set, the sub command will be applied to all queues.
+.TP
+.B sub_command
+Sub command to apply.
+.RE
 .SH BUGS
 Not supported (in part or whole) on all network drivers.
 .SH AUTHOR
diff --git a/ethtool.c b/ethtool.c
index d9850f4..08976b7 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -5051,6 +5051,8 @@ static int do_sfec(struct cmd_context *ctx)
 	return 0;
 }
 
+static int do_perqueue(struct cmd_context *ctx);
+
 #ifndef TEST_ETHTOOL
 int send_ioctl(struct cmd_context *ctx, void *cmd)
 {
@@ -5246,6 +5248,8 @@ static const struct option {
 	{ "--show-fec", 1, do_gfec, "Show FEC settings"},
 	{ "--set-fec", 1, do_sfec, "Set FEC settings",
 	  "		[ encoding auto|off|rs|baser [...]]\n"},
+	{ "-Q|--per-queue", 1, do_perqueue, "Apply per-queue command",
+	  "             [queue_mask %x] SUB_COMMAND\n"},
 	{ "-h|--help", 0, show_usage, "Show this help" },
 	{ "--version", 0, do_version, "Show version number" },
 	{}
@@ -5297,6 +5301,81 @@ static int find_option(int argc, char **argp)
 	return -1;
 }
 
+#define MAX(x, y) ((x) > (y) ? (x) : (y))
+
+static int find_max_num_queues(struct cmd_context *ctx)
+{
+	struct ethtool_channels echannels;
+
+	echannels.cmd = ETHTOOL_GCHANNELS;
+	if (send_ioctl(ctx, &echannels))
+		return -1;
+
+	return MAX(echannels.rx_count, echannels.tx_count) +
+		echannels.combined_count;
+}
+
+static int do_perqueue(struct cmd_context *ctx)
+{
+	__u32 queue_mask[__KERNEL_DIV_ROUND_UP(MAX_NUM_QUEUE, 32)] = {0};
+	int i, n_queues = 0;
+
+	if (ctx->argc == 0)
+		exit_bad_args();
+
+	/*
+	 * The sub commands will be applied to
+	 * all queues if no queue_mask set
+	 */
+	if (strncmp(*ctx->argp, "queue_mask", 11)) {
+		n_queues = find_max_num_queues(ctx);
+		if (n_queues < 0) {
+			perror("Cannot get number of queues");
+			return -EFAULT;
+		} else if (n_queues > MAX_NUM_QUEUE) {
+			n_queues = MAX_NUM_QUEUE;
+			fprintf(stdout,
+				"The sub command will be applied to only the first %d queues\n",
+				n_queues);
+		} else {
+			fprintf(stdout,
+				"The sub command will be applied to all %d queues\n",
+				n_queues);
+		}
+		for (i = 0; i < n_queues / 32; i++)
+			queue_mask[i] = ~0;
+		if (n_queues % 32)
+			queue_mask[i] = (1 << (n_queues - i * 32)) - 1;
+	} else {
+		ctx->argc--;
+		ctx->argp++;
+		if (parse_hex_u32_bitmap(*ctx->argp, MAX_NUM_QUEUE,
+		    queue_mask)) {
+			fprintf(stdout, "Invalid queue mask\n");
+			return -1;
+		}
+		for (i = 0; i < __KERNEL_DIV_ROUND_UP(MAX_NUM_QUEUE, 32); i++) {
+			__u32 mask = queue_mask[i];
+
+			while (mask > 0) {
+				if (mask & 0x1)
+					n_queues++;
+				mask = mask >> 1;
+			}
+		}
+		ctx->argc--;
+		ctx->argp++;
+	}
+
+	i = find_option(ctx->argc, ctx->argp);
+	if (i < 0)
+		exit_bad_args();
+
+	/* no sub_command support yet */
+
+	return -EOPNOTSUPP;
+}
+
 int main(int argc, char **argp)
 {
 	int (*func)(struct cmd_context *);
-- 
2.14.4

