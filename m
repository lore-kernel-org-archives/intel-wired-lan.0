From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Date: Mon, 16 Aug 2021 18:07:12 +0200
Subject: [Intel-wired-lan] [RFC net-next 2/7] selftests/ptp: Add usage of
 PTP_DPLL_GETSTATE ioctl in testptp
In-Reply-To: <20210816160717.31285-1-arkadiusz.kubalewski@intel.com>
References: <20210816160717.31285-1-arkadiusz.kubalewski@intel.com>
Message-ID: <20210816160717.31285-3-arkadiusz.kubalewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Allow get Digital Phase Locked Loop state of ptp enabled device
through ptp related ioctl PTP_DPLL_GETSTATE.

Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 tools/testing/selftests/ptp/testptp.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index f7911aaeb007..67de96cf0962 100644
--- a/tools/testing/selftests/ptp/testptp.c
+++ b/tools/testing/selftests/ptp/testptp.c
@@ -141,6 +141,7 @@ static void usage(char *progname)
 		" -S         set the system time from the ptp clock time\n"
 		" -t val     shift the ptp clock time by 'val' seconds\n"
 		" -T val     set the ptp clock time to 'val' seconds\n"
+		" -u         get list of available DPLLs and their state values"
 		" -z         test combinations of rising/falling external time stamp flags\n",
 		progname);
 }
@@ -156,6 +157,7 @@ int main(int argc, char *argv[])
 	struct timex tx;
 	struct ptp_clock_time *pct;
 	struct ptp_sys_offset *sysoff;
+	struct ptp_dpll_state *ds;
 
 	char *progname;
 	unsigned int i;
@@ -177,6 +179,7 @@ int main(int argc, char *argv[])
 	int pps = -1;
 	int seconds = 0;
 	int settime = 0;
+	int dpll_state = 0;
 
 	int64_t t1, t2, tp;
 	int64_t interval, offset;
@@ -186,7 +189,7 @@ int main(int argc, char *argv[])
 
 	progname = strrchr(argv[0], '/');
 	progname = progname ? 1+progname : argv[0];
-	while (EOF != (c = getopt(argc, argv, "cd:e:f:ghH:i:k:lL:p:P:sSt:T:w:z"))) {
+	while (EOF != (c = getopt(argc, argv, "cd:e:f:ghH:i:k:lL:p:P:sSt:T:uw:z"))) {
 		switch (c) {
 		case 'c':
 			capabilities = 1;
@@ -242,6 +245,9 @@ int main(int argc, char *argv[])
 			settime = 3;
 			seconds = atoi(optarg);
 			break;
+		case 'u':
+			dpll_state = 1;
+			break;
 		case 'w':
 			pulsewidth = atoi(optarg);
 			break;
@@ -506,6 +512,25 @@ int main(int argc, char *argv[])
 		free(sysoff);
 	}
 
+	if (dpll_state) {
+		ds = calloc(1, sizeof(*ds));
+		if (!ds) {
+			perror("calloc");
+			return -1;
+		}
+
+		if (ioctl(fd, PTP_DPLL_GETSTATE, ds))
+			perror("PTP_DPLL_GETSTATE");
+		else
+			puts("get dpll state request okay");
+
+		printf("dpll state:\n");
+		for (i = 0; i < ds->dpll_num; i++)
+			printf("dpll id:%i state:%u\n", i, ds->state[i]);
+
+		free(ds);
+	}
+
 	close(fd);
 	return 0;
 }
-- 
2.24.0

