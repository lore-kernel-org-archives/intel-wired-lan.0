From: Richard Cochran <richardcochran@gmail.com>
Date: Thu, 14 Nov 2019 10:45:07 -0800
Subject: [Intel-wired-lan] [PATCH net 13/13] ptp: Extend the test program to
 check the external time stamp flags.
Message-ID: <20191114184507.18937-14-richardcochran@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Because each driver and hardware has different capabilities, the test
cannot provide a simple pass/fail result, but it can at least show what
combinations of flags are supported.

Signed-off-by: Richard Cochran <richardcochran@gmail.com>
---
 tools/testing/selftests/ptp/testptp.c | 53 ++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index bd4a7247b44f..c0dd10257df5 100644
--- a/tools/testing/selftests/ptp/testptp.c
+++ b/tools/testing/selftests/ptp/testptp.c
@@ -44,6 +44,46 @@ static int clock_adjtime(clockid_t id, struct timex *tx)
 }
 #endif
 
+static void show_flag_test(int rq_index, unsigned int flags, int err)
+{
+	printf("PTP_EXTTS_REQUEST%c flags 0x%08x : (%d) %s\n",
+	       rq_index ? '1' + rq_index : ' ',
+	       flags, err, strerror(errno));
+	/* sigh, uClibc ... */
+	errno = 0;
+}
+
+static void do_flag_test(int fd, unsigned int index)
+{
+	struct ptp_extts_request extts_request;
+	unsigned long request[2] = {
+		PTP_EXTTS_REQUEST,
+		PTP_EXTTS_REQUEST2,
+	};
+	unsigned int enable_flags[5] = {
+		PTP_ENABLE_FEATURE,
+		PTP_ENABLE_FEATURE | PTP_RISING_EDGE,
+		PTP_ENABLE_FEATURE | PTP_FALLING_EDGE,
+		PTP_ENABLE_FEATURE | PTP_RISING_EDGE | PTP_FALLING_EDGE,
+		PTP_ENABLE_FEATURE | (PTP_EXTTS_VALID_FLAGS + 1),
+	};
+	int err, i, j;
+
+	memset(&extts_request, 0, sizeof(extts_request));
+	extts_request.index = index;
+
+	for (i = 0; i < 2; i++) {
+		for (j = 0; j < 5; j++) {
+			extts_request.flags = enable_flags[j];
+			err = ioctl(fd, request[i], &extts_request);
+			show_flag_test(i, extts_request.flags, err);
+
+			extts_request.flags = 0;
+			err = ioctl(fd, request[i], &extts_request);
+		}
+	}
+}
+
 static clockid_t get_clockid(int fd)
 {
 #define CLOCKFD 3
@@ -96,7 +136,8 @@ static void usage(char *progname)
 		" -s         set the ptp clock time from the system time\n"
 		" -S         set the system time from the ptp clock time\n"
 		" -t val     shift the ptp clock time by 'val' seconds\n"
-		" -T val     set the ptp clock time to 'val' seconds\n",
+		" -T val     set the ptp clock time to 'val' seconds\n"
+		" -z         test combinations of rising/falling external time stamp flags\n",
 		progname);
 }
 
@@ -122,6 +163,7 @@ int main(int argc, char *argv[])
 	int adjtime = 0;
 	int capabilities = 0;
 	int extts = 0;
+	int flagtest = 0;
 	int gettime = 0;
 	int index = 0;
 	int list_pins = 0;
@@ -138,7 +180,7 @@ int main(int argc, char *argv[])
 
 	progname = strrchr(argv[0], '/');
 	progname = progname ? 1+progname : argv[0];
-	while (EOF != (c = getopt(argc, argv, "cd:e:f:ghi:k:lL:p:P:sSt:T:v"))) {
+	while (EOF != (c = getopt(argc, argv, "cd:e:f:ghi:k:lL:p:P:sSt:T:z"))) {
 		switch (c) {
 		case 'c':
 			capabilities = 1;
@@ -191,6 +233,9 @@ int main(int argc, char *argv[])
 			settime = 3;
 			seconds = atoi(optarg);
 			break;
+		case 'z':
+			flagtest = 1;
+			break;
 		case 'h':
 			usage(progname);
 			return 0;
@@ -322,6 +367,10 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (flagtest) {
+		do_flag_test(fd, index);
+	}
+
 	if (list_pins) {
 		int n_pins = 0;
 		if (ioctl(fd, PTP_CLOCK_GETCAPS, &caps)) {
-- 
2.20.1

