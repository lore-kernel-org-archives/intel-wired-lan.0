From: Nicholas Nunley <nicholas.d.nunley@intel.com>
Date: Mon,  4 Feb 2019 13:12:05 -0800
Subject: [Intel-wired-lan] [PATCH v2 3/6] ethtool: introduce new ioctl for
 per-queue settings
In-Reply-To: <20190204211208.57516-1-nicholas.d.nunley@intel.com>
References: <20190204211208.57516-1-nicholas.d.nunley@intel.com>
Message-ID: <20190204211208.57516-3-nicholas.d.nunley@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Introduce a new ioctl for setting per-queue parameters.
Users can apply commands to specific queues by setting SUB_COMMAND and
queue_mask with the following ethtool command:

 ethtool --set-perqueue-command DEVNAME [queue_mask %x] SUB_COMMAND

If queue_mask is not set, the SUB_COMMAND will be applied to all queues.

SUB_COMMANDs for per-queue settings will be implemented in following
patches.

Based on patch by Kan Liang <kan.liang@intel.com>

Signed-off-by: Nicholas Nunley <nicholas.d.nunley@intel.com>
---
 ethtool.8.in |  20 ++++++++++++
 ethtool.c    | 101 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+)

diff --git a/ethtool.8.in b/ethtool.8.in
index 5a26cff..0aaca2c 100644
--- a/ethtool.8.in
+++ b/ethtool.8.in
@@ -391,6 +391,14 @@ ethtool \- query or control network driver and hardware settings
 .I devname
 .B encoding
 .BR auto | off | rs | baser \ [...]
+.HP
+.B ethtool \-\-set\-perqueue\-command
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
+.B \-\-set\-perqueue\-command
+Sets sub command to specific queues.
+.RS 4
+.TP
+.B queue_mask %x
+Sets the specific queues which the sub command is applied to.
+If queue_mask is not set, the sub command will be applied to all queues.
+.TP
+.B sub_command
+Sets the sub command.
+.RE
 .SH BUGS
 Not supported (in part or whole) on all network drivers.
 .SH AUTHOR
diff --git a/ethtool.c b/ethtool.c
index af266c5..4dc725c 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -5048,6 +5048,8 @@ static int do_sfec(struct cmd_context *ctx)
 	return 0;
 }
 
+static int do_perqueue(struct cmd_context *ctx);
+
 #ifndef TEST_ETHTOOL
 int send_ioctl(struct cmd_context *ctx, void *cmd)
 {
@@ -5243,6 +5245,8 @@ static const struct option {
 	{ "--show-fec", 1, do_gfec, "Show FEC settings"},
 	{ "--set-fec", 1, do_sfec, "Set FEC settings",
 	  "		[ encoding auto|off|rs|baser [...]]\n"},
+	{ "--set-perqueue-command", 1, do_perqueue, "Set per queue command",
+	  "             [queue_mask %x] SUB_COMMAND\n"},
 	{ "-h|--help", 0, show_usage, "Show this help" },
 	{ "--version", 0, do_version, "Show version number" },
 	{}
@@ -5294,6 +5298,103 @@ static int find_option(int argc, char **argp)
 	return -1;
 }
 
+static int set_queue_mask(u32 *queue_mask, char *str)
+{
+	int len = strlen(str);
+	int index = __KERNEL_DIV_ROUND_UP(len * 4, 32);
+	char tmp[9];
+	char *end = str + len;
+	int i, num;
+	__u32 mask;
+	int n_queues = 0;
+
+	if (len > MAX_NUM_QUEUE)
+		return -EINVAL;
+
+	for (i = 0; i < index; i++) {
+		num = end - str;
+
+		if (num >= 8) {
+			end -= 8;
+			num = 8;
+		} else {
+			end = str;
+		}
+		strncpy(tmp, end, num);
+		tmp[num] = '\0';
+
+		queue_mask[i] = strtoul(tmp, NULL, 16);
+
+		mask = queue_mask[i];
+		while (mask > 0) {
+			if (mask & 0x1)
+				n_queues++;
+			mask = mask >> 1;
+		}
+	}
+
+	return n_queues;
+}
+
+#define MAX(x, y) (x > y ? x : y)
+
+static int find_max_num_queues(struct cmd_context *ctx)
+{
+	struct ethtool_channels echannels;
+
+	echannels.cmd = ETHTOOL_GCHANNELS;
+	if (send_ioctl(ctx, &echannels))
+		return -1;
+
+	return MAX(MAX(echannels.rx_count, echannels.tx_count),
+		   echannels.combined_count);
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
+	if (strncmp(*ctx->argp, "queue_mask", 10)) {
+		n_queues = find_max_num_queues(ctx);
+		if (n_queues < 0) {
+			perror("Cannot get number of queues");
+			return -EFAULT;
+		}
+		for (i = 0; i < n_queues / 32; i++)
+			queue_mask[i] = ~0;
+		queue_mask[i] = (1 << (n_queues - i * 32)) - 1;
+		fprintf(stdout,
+			"The sub commands will be applied to all %d queues\n",
+			n_queues);
+	} else {
+		ctx->argc--;
+		ctx->argp++;
+		n_queues = set_queue_mask(queue_mask, *ctx->argp);
+		if (n_queues < 0) {
+			perror("Invalid queue mask");
+			return n_queues;
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
+	return 0;
+}
+
 int main(int argc, char **argp)
 {
 	int (*func)(struct cmd_context *);
-- 
2.14.4

