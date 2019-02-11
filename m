From: Nicholas Nunley <nicholas.d.nunley@intel.com>
Date: Mon, 11 Feb 2019 11:22:22 -0800
Subject: [Intel-wired-lan] [PATCH v3 1/6] ethtool: move option parsing
 related code into function
Message-ID: <20190211192227.34960-1-nicholas.d.nunley@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Move option parsing code into find_option function.

No behavior changes.

Based on patch by Kan Liang <kan.liang@intel.com>

Signed-off-by: Nicholas Nunley <nicholas.d.nunley@intel.com>
---
 ethtool.c | 49 +++++++++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/ethtool.c b/ethtool.c
index fb4c088..917626f 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -5268,6 +5268,29 @@ static int show_usage(struct cmd_context *ctx)
 	return 0;
 }
 
+static int find_option(int argc, char **argp)
+{
+	const char *opt;
+	size_t len;
+	int k;
+
+	for (k = 0; args[k].opts; k++) {
+		opt = args[k].opts;
+		for (;;) {
+			len = strcspn(opt, "|");
+			if (strncmp(*argp, opt, len) == 0 &&
+			    (*argp)[len] == 0)
+				return k;
+
+			if (opt[len] == 0)
+				break;
+			opt += len + 1;
+		}
+	}
+
+	return -1;
+}
+
 int main(int argc, char **argp)
 {
 	int (*func)(struct cmd_context *);
@@ -5287,24 +5310,14 @@ int main(int argc, char **argp)
 	 */
 	if (argc == 0)
 		exit_bad_args();
-	for (k = 0; args[k].opts; k++) {
-		const char *opt;
-		size_t len;
-		opt = args[k].opts;
-		for (;;) {
-			len = strcspn(opt, "|");
-			if (strncmp(*argp, opt, len) == 0 &&
-			    (*argp)[len] == 0) {
-				argp++;
-				argc--;
-				func = args[k].func;
-				want_device = args[k].want_device;
-				goto opt_found;
-			}
-			if (opt[len] == 0)
-				break;
-			opt += len + 1;
-		}
+
+	k = find_option(argc, argp);
+	if (k >= 0) {
+		argp++;
+		argc--;
+		func = args[k].func;
+		want_device = args[k].want_device;
+		goto opt_found;
 	}
 	if ((*argp)[0] == '-')
 		exit_bad_args();
-- 
2.14.4

