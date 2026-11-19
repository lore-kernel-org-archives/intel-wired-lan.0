Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2C7606A32F
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 16:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=bjkJhy1y;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RWnenj52
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 128054062A;
	Thu, 19 Nov 2026 16:54:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2gAduzarY_Ti; Thu, 19 Nov 2026 16:54:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E22E040B39
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795107259;
	b=d1OCN0bA0wi0ojYty7692nFstrpJvNv82wqp/i1Cs+YIs3e6psqGktYZppnN7lf8K+8n
	 lU3DWhPm85/I7GHy5RSchfVKRlZN7qatizEfsczqThvMczkE3r8hpbKDL317pGdz0p/Mu
	 4x22MixBjDFWb9Iep1c3U/XeEML0RbkYRtm+0HWMzzPsbW2XjykMIi3mSgAHU1RqB72DH
	 2SQn8+yREv7/W1TV0RToUEpM6kfOEphZFyfnMpJQzckOFvSRd+g9U/ZmMQhGANsVZXXP3
	 fO9zw+t0Ox+oJ/QvEF9cIGXH2dS3YhlgjwHjWvATxRxNuSmmTr9jiQM58RbM4LFPhpg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795107259;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=I6ueF8ltV78eKvEUnHHfXi42A6xUIUTqkyV9CNwByEE=;
	b=gK1wjNNqZH6IU7c3EQnqR53Ucd+Eqnd5dsjMLpzH+wL0BjoeXZXZhKR6f/433Z5lVXFt
	 ir3Zq/H5gmVIfs+ljMmkc+d9IAmx1xQgk04Ocw7ERcXNFYLbTmyrpFbTd7jcrpflRoN0x
	 uGqmE42FTnqmgnVOBCDuCxKQEyJvBEoyAss9njlSxc6mHQ2nc7GfJmAOoIfui9ziTo6Fv
	 FZQdgxdgKxKqDVyEYzhNzGrPpRxOtIEFDhk7udVQBYuK1xdbTgcBwtfKl7IWUgK5y6w4j
	 45aoofTjK2tsEZklhdqeNNBR0l5oF0tbduQQK6kg9yT8tKkaNGxVRF3qpNUiUt+It9A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795107258;
	bh=I6ueF8ltV78eKvEUnHHfXi42A6xUIUTqkyV9CNwByEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bjkJhy1y+yH+H/b7lspNKCvpAw9LMkCjRaxP0+kT+37MNiMQ8P16Ech/AUPg04DHQ
	 ZGF08br1OjedwJH74qBj4a3yjP0GPmeNqNpAsD3rXxfb1BT+rZ7u3UYfuvncDJ4FWw
	 OZ35XE+nvXPt6IH19YG5esBj3ZPqGvo0ZnGZ0pm9YFbWrUg55wA5iZmWPgj6zI+ucB
	 Ub9g7fLpzfNxYEI4Ja6LWvwnw4+8ERmFW0liEajWUklToH8m/uUSlPpxTWp6LdkEqe
	 0fuGshrde5lR/fMPxJO6pFukwjsDYlw4zzdjDDP/Hpzybe+0tMW/7fIJdSj8yK5tQA
	 5XvoiC4AoGXuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E22E040B39;
	Thu, 19 Nov 2026 16:54:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EEE739F8
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 16:54:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E049281106
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 16:54:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rzuTzHhJrOLr for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 16:54:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D58688136F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.21
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=magnus.karlsson@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=RWnenj52
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D58688136F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 16:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795107256; x=1826643256;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=k+Ubnv5W8bAdkgha88wOu/A9VFJ8e5eqDpYAEgsMq6o=;
 b=RWnenj52pJUnpopitGm6X4yuLGgevYzqw8r+eHQo9rYC4hEBI7+wztPB
 c078NE1YjLuoieE48DIqXjUxhm7bJxwSCLgQGafMc2mam6d9jHNiqp5Zj
 SHgWbMMr2BTWv3jjytcBd1/T/Z/wasRoBn+GXGG/Zyxn9c4fNN3+gmQLW
 nDlPcdcjjbsApTsrUa3+/ItOquHIAJHLmfkm7BS6Fw3lEvtW1cY2e24ZJ
 3yn2rT1TQJdwbCkYTkjZx76I/A/9Ge+4Oc8E7kGP1Fy4IWkAQg59RW+6z
 nNenCj7SEVKT10z7BXZtPe1whiuPcAJLTm2bzjmcagDQl5A3X7zsTwsIC w==;
X-CSE-ConnectionGUID: QYLK7u4DSQm6km7IXLoiVw==
X-CSE-MsgGUID: NGumjLn2RfqN7z38rNSwTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4045476"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="4045476"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 08:54:16 -0800
X-CSE-ConnectionGUID: RZ5+qPi3QXuIKsOec9MFcQ==
X-CSE-MsgGUID: f/gaLoIaQ6em9roKCwh3yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; d="scan'208";a="10775004"
Received: from boxer.igk.intel.com ([10.102.20.173])
 by orviesa009.jf.intel.com with ESMTP; 19 Nov 2026 08:54:12 -0800
From: Magnus Karlsson <magnus.karlsson@intel.com>
To: netdev@vger.kernel.org, magnus.karlsson@intel.com,
 magnus.karlsson@gmail.com, maciej.fijalkowski@intel.com, sdf@fomichev.me,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, bjorn@kernel.org,
 kerneljasonxing@gmail.com
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com
Subject: [PATCH net-next 5/5] selftests: net: add AF_XDP USO test
Date: Thu, 19 Nov 2026 17:53:40 +0100
Message-Id: <20261119165340.1071525-6-magnus.karlsson@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20261119165340.1071525-1-magnus.karlsson@intel.com>
References: <20261119165340.1071525-1-magnus.karlsson@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add xsk_uso, a functional test for AF_XDP UDP segmentation offload in
copy and zero-copy mode. It sends USO requests from an AF_XDP socket
and checks the datagrams received on a packet socket: the number of
datagrams, the IP and UDP lengths, the checksums and the payload, for
IPv4 and IPv6, and single and multi-buffer requests. It also checks
that invalid requests are dropped and counted in tx_invalid_descs.

The test needs root and physical NICs with an MTU of at least 1448,
either two connected ports (-i TX_IFACE -r RX_IFACE) or one in NIC
loopback (-l -i IFACE). Virtual devices such as veth pass the packet on
without segmenting it. Zero copy (-z) also needs a native XDP program on
the interface. Standalone checksum offload cases run only with -C, as
they test the existing checksum offload rather than USO. As it needs
real hardware, it is built but not run by default, like xdp_hw_metadata.
It uses the AF_XDP library in net/lib/xsk.

Missing prerequisites are reported as skips. In zero-copy mode, the
device must report xsk-zerocopy and tx-uso-zc, and checksum-only cases
need tx-checksum. In both modes, cases that produce more than one
datagram need tx-udp-segmentation, including the invalid ones, which
would otherwise be dropped for lack of the offload whatever their
headers. Cases that need more descriptors than xdp-zc-max-segs are
skipped, and so are binds that the device refuses with EOPNOTSUPP.
Receive-side UDP GRO (rx-udp-gro-forwarding, rx-gro-list) must be off,
as it would merge the segments again before the packet socket sees them.
USO with launch time must succeed in copy mode and be dropped in
zero-copy mode.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 tools/testing/selftests/net/.gitignore |   1 +
 tools/testing/selftests/net/Makefile   |  10 +-
 tools/testing/selftests/net/xsk_uso.c  | 954 +++++++++++++++++++++++++
 3 files changed, 964 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/net/xsk_uso.c

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 83d68e2dd4ac..e40a97618cdc 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -64,3 +64,4 @@ udpgso_bench_rx
 udpgso_bench_tx
 xdp_hw_metadata
 xdp_hw_metadata.skel.h
+xsk_uso
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index c80dabbcc907..afe839db2a45 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -219,7 +219,8 @@ TEST_FILES := \
 # end of TEST_FILES
 
 # YNL files, must be before "include ..lib.mk"
-YNL_GEN_FILES := busy_poller
+# xsk_uso needs root and a NIC with loopback or a connected peer; see the source.
+YNL_GEN_FILES := busy_poller xsk_uso
 YNL_GEN_PROGS := \
 	netlink-dumps \
 	tun \
@@ -273,3 +274,10 @@ $(OUTPUT)/xdp_hw_metadata: xdp_hw_metadata.c xdp_metadata.h lib/xsk/xsk.c \
 	$(Q)$(CC) -I$(top_srcdir)/tools/include $(CFLAGS) -I$(OUTPUT) \
 		-I$(SCRATCH_DIR)/include \
 		$(filter %.c,$^) $(BPFOBJ) $(LDLIBS) -lelf -lz -o $@
+
+$(OUTPUT)/xsk_uso: xsk_uso.c lib/xsk/xsk.c lib/xsk/xsk.h $(BPFOBJ) \
+		   $(OUTPUT)/libynl.a
+	$(call msg,CC,,$@)
+	$(Q)$(CC) -I$(top_srcdir)/tools/include $(CFLAGS) \
+		-I$(SCRATCH_DIR)/include \
+		$(filter %.c,$^) $(BPFOBJ) $(OUTPUT)/libynl.a $(LDLIBS) -lelf -lz -o $@
diff --git a/tools/testing/selftests/net/xsk_uso.c b/tools/testing/selftests/net/xsk_uso.c
new file mode 100644
index 000000000000..2e3228e2b2f8
--- /dev/null
+++ b/tools/testing/selftests/net/xsk_uso.c
@@ -0,0 +1,954 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* AF_XDP UDP segmentation offload (USO) test.
+ *
+ * Sends USO requests from an AF_XDP socket in copy or zero-copy mode and
+ * checks the datagrams received on a packet socket: their number, IP and
+ * UDP lengths, checksums and payload, for IPv4 and IPv6, and single and
+ * multi-buffer requests. Invalid requests must be dropped and counted in
+ * tx_invalid_descs.
+ *
+ * Needs root and physical NICs with an MTU of at least 1448, either two
+ * connected ports (-i TX_IFACE -r RX_IFACE) or one in NIC loopback
+ * (-l -i IFACE). Virtual devices such as veth pass the packet on without
+ * segmenting it, so they are skipped. An MTU too large for eight 4K buffers
+ * is also a skip. Zero-copy mode (-z) also needs a native XDP program on the
+ * interface and a driver reporting tx-uso-zc. Requests that produce more than one datagram
+ * need tx-udp-segmentation. Standalone checksum offload cases run only with
+ * -C, and in zero-copy mode only on drivers reporting tx-checksum. Missing
+ * prerequisites are reported as skips.
+ */
+
+#define _GNU_SOURCE
+#include <arpa/inet.h>
+#include <errno.h>
+#include <linux/ethtool.h>
+#include <linux/if_ether.h>
+#include <linux/if_link.h>
+#include <linux/if_packet.h>
+#include <linux/if_xdp.h>
+#include <linux/ipv6.h>
+#include <linux/netdev.h>
+#include <linux/sockios.h>
+#include <linux/udp.h>
+#include <net/if.h>
+#include <netinet/ip.h>
+#include <poll.h>
+#include <stdbool.h>
+#include <assert.h>
+#include <stddef.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sys/socket.h>
+#include <time.h>
+#include <unistd.h>
+#include <ynl.h>
+
+#include "kselftest.h"
+#include "lib/xsk/xsk.h"
+#include "netdev-user.h"
+
+#define RING_SIZE 1024
+#define NUM_FRAMES 1024
+#define FRAME_SIZE 4096
+#define META_LEN sizeof(struct xsk_tx_metadata)
+/* Each segment then fills an IPv4 or IPv6 packet of at most 1448 bytes, the
+ * smallest MTU that the test accepts.
+ */
+#define GSO_SIZE 1400
+#define MIN_MTU (sizeof(struct ipv6hdr) + sizeof(struct udphdr) + GSO_SIZE)
+/* Most buffers a test packet uses. In zero-copy mode, cases that need more
+ * descriptors than the driver's xdp-zc-max-segs are skipped.
+ */
+#define MAX_BUFFERS 8
+#define TEST_PORT 49732
+#define TIMEOUT_MS 2000
+
+static_assert(sizeof(struct xsk_tx_metadata) == 24, "metadata size");
+static_assert(offsetof(struct xsk_tx_metadata, request.gso_size) == 12,
+	      "segment size offset");
+static_assert(offsetof(struct xsk_tx_metadata, request.network_offset) == 14,
+	      "network header offset");
+static_assert(offsetof(struct xsk_tx_metadata, request.launch_time) == 16,
+	      "launch time offset");
+static_assert(offsetof(struct xsk_tx_metadata, completion.tx_timestamp) == 8,
+	      "timestamp offset");
+
+enum bad_request {
+	VALID, ZERO_SIZE, FRAGS_SIZE, NO_CHECKSUM, BAD_CSUM_OFFSET,
+	BAD_NETWORK_OFFSET, BAD_UDP_LENGTH, FRAGMENT, BAD_PROTOCOL,
+	EXT_HEADER, LARGE_SEGMENT, SHORT_HEADER, TIMESTAMP, LAUNCH_TIME,
+	SW_CHECKSUM, UNKNOWN_FLAG, BAD_IP_LENGTH, BAD_IP_VERSION, BAD_IHL,
+	BAD_TRANSPORT_OFFSET, TOO_MANY_SEGMENTS,
+};
+
+static const struct test_case {
+	const char *name;
+	bool ipv6;
+	unsigned int payload;
+	unsigned int first_len;
+	enum bad_request bad;
+	bool checksum_only;
+} cases[] = {
+	{ "IPv4 USO", false, 4000, 0, VALID, false },
+	{ "IPv6 USO", true, 4000, 0, VALID, false },
+	{ "IPv4 multi-buffer USO", false, 6000, 2048, VALID, false },
+	{ "IPv6 multi-buffer USO", true, 6000, 2048, VALID, false },
+	{ "single output datagram", false, GSO_SIZE, 0, VALID, false },
+	{ "empty IPv4 datagram", false, 0, 0, VALID, false },
+	{ "empty IPv6 datagram", true, 0, 0, VALID, false },
+	{ "checksum-only compatibility", false, 1000, 0, VALID, true },
+	{ "IPv6 checksum-only", true, 1000, 0, VALID, true },
+	{ "IPv4 multi-buffer checksum-only", false, 1400, 512, VALID, true },
+	{ "IPv6 multi-buffer checksum-only", true, 1400, 512, VALID, true },
+	{ "empty IPv4 checksum-only", false, 0, 0, VALID, true },
+	{ "empty IPv6 checksum-only", true, 0, 0, VALID, true },
+	{ "zero segment size", false, 4000, 0, ZERO_SIZE, false },
+	{ "GSO_BY_FRAGS segment size", false, 4000, 0, FRAGS_SIZE, false },
+	{ "missing checksum flag", false, 6000, 2048, NO_CHECKSUM, false },
+	{ "invalid checksum offset", false, 4000, 0, BAD_CSUM_OFFSET, false },
+	{ "invalid IP offset", false, 4000, 0, BAD_NETWORK_OFFSET, false },
+	{ "invalid UDP length", false, 6000, 2048, BAD_UDP_LENGTH, false },
+	{ "fragmented IPv4", false, 4000, 0, FRAGMENT, false },
+	{ "non-UDP protocol", false, 4000, 0, BAD_PROTOCOL, false },
+	{ "IPv6 extension header", true, 4000, 0, EXT_HEADER, false },
+	{ "segment exceeds MTU", false, 0, 0, LARGE_SEGMENT, false },
+	{ "headers split across buffers", true, 4000, 0, SHORT_HEADER, false },
+	{ "USO with timestamp", false, 4000, 0, TIMESTAMP, false },
+	{ "USO with launch time", false, 4000, 0, LAUNCH_TIME, false },
+	{ "IPv6 USO with launch time", true, 4000, 0, LAUNCH_TIME, false },
+	{ "multi-buffer USO with launch time", false, 6000, 2048, LAUNCH_TIME, false },
+	{ "USO with software checksum", false, 4000, 0, SW_CHECKSUM, false },
+	{ "unknown metadata flag", false, 4000, 0, UNKNOWN_FLAG, false },
+	{ "invalid IPv4 total length", false, 4000, 0, BAD_IP_LENGTH, false },
+	{ "invalid IPv6 payload length", true, 4000, 0, BAD_IP_LENGTH, false },
+	{ "invalid IPv4 version", false, 4000, 0, BAD_IP_VERSION, false },
+	{ "invalid IPv6 version", true, 4000, 0, BAD_IP_VERSION, false },
+	{ "invalid IPv4 header length", false, 4000, 0, BAD_IHL, false },
+	{ "UDP offset mismatch", false, 4000, 0, BAD_TRANSPORT_OFFSET, false },
+	{ "too many segments", false, 4000, 0, TOO_MANY_SEGMENTS, false },
+};
+
+struct xsk {
+	int fd;
+	void *umem;
+	struct xsk_umem *umem_handle;
+	struct xsk_socket *socket;
+	struct xsk_ring_prod fill;
+	struct xsk_ring_prod tx;
+	struct xsk_ring_cons cq;
+};
+
+static unsigned char tx_mac[ETH_ALEN], rx_mac[ETH_ALEN];
+static unsigned char tx_packet[MAX_BUFFERS * FRAME_SIZE];
+static unsigned int mtu;
+static bool zero_copy;
+static bool checksum_tests;
+
+static uint64_t now_ms(void)
+{
+	struct timespec ts;
+
+	if (clock_gettime(CLOCK_MONOTONIC, &ts))
+		ksft_exit_fail_msg("clock_gettime: %s\n", strerror(errno));
+	return ts.tv_sec * 1000ULL + ts.tv_nsec / 1000000;
+}
+
+static uint32_t sum_bytes(const void *data, unsigned int len)
+{
+	const unsigned char *p = data;
+	uint32_t sum = 0;
+
+	while (len > 1) {
+		sum += p[0] * 256 + p[1];
+		p += 2;
+		len -= 2;
+	}
+	if (len)
+		sum += p[0] * 256;
+	return sum;
+}
+
+static uint16_t fold(uint32_t sum)
+{
+	while (sum >> 16)
+		sum = (sum & 0xffff) + (sum >> 16);
+	return sum;
+}
+
+static uint32_t pseudo_sum(const void *ip, bool ipv6, unsigned int udp_len)
+{
+	const struct iphdr *h = ip;
+
+	if (ipv6) {
+		const struct ipv6hdr *h6 = ip;
+
+		return sum_bytes(&h6->saddr, 32) + IPPROTO_UDP + udp_len;
+	}
+	return sum_bytes(&h->saddr, 8) + IPPROTO_UDP + udp_len;
+}
+
+static void get_mac(const char *name, unsigned char *mac)
+{
+	struct ifreq ifr = {};
+	int fd = socket(AF_INET, SOCK_DGRAM, 0);
+
+	if (fd < 0)
+		ksft_exit_fail_msg("socket: %s\n", strerror(errno));
+	snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "%s", name);
+	if (ioctl(fd, SIOCGIFHWADDR, &ifr))
+		ksft_exit_fail_msg("MAC address for %s: %s\n", name, strerror(errno));
+	memcpy(mac, ifr.ifr_hwaddr.sa_data, ETH_ALEN);
+	close(fd);
+}
+
+static unsigned int get_mtu(const char *name)
+{
+	struct ifreq ifr = {};
+	int fd = socket(AF_INET, SOCK_DGRAM, 0);
+
+	snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "%s", name);
+	if (fd < 0 || ioctl(fd, SIOCGIFMTU, &ifr))
+		ksft_exit_fail_msg("MTU of %s: %s\n", name, strerror(errno));
+	close(fd);
+	return ifr.ifr_mtu;
+}
+
+/* Virtual devices have no backing device, and pass GSO packets on whole. */
+static bool is_physical(const char *name)
+{
+	char path[64];
+
+	snprintf(path, sizeof(path), "/sys/class/net/%s/device", name);
+	return !access(path, F_OK);
+}
+
+static int ethtool_ioctl(const char *name, void *cmd)
+{
+	struct ifreq ifr = { .ifr_data = cmd };
+	int fd = socket(AF_INET, SOCK_DGRAM, 0), err;
+
+	if (fd < 0)
+		return -1;
+	snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "%s", name);
+	err = ioctl(fd, SIOCETHTOOL, &ifr);
+	close(fd);
+	return err;
+}
+
+/* Returns whether the netdev feature called @feature is active on @name. */
+static bool feature_active(const char *name, const char *feature)
+{
+	struct ethtool_gfeatures *features = NULL;
+	struct ethtool_gstrings *strings = NULL;
+	struct ethtool_sset_info *sset;
+	unsigned int count, blocks, i;
+	bool active = false;
+
+	sset = calloc(1, sizeof(*sset) + sizeof(sset->data[0]));
+	if (!sset)
+		ksft_exit_fail_msg("calloc: %s\n", strerror(errno));
+	sset->cmd = ETHTOOL_GSSET_INFO;
+	sset->sset_mask = 1ULL << ETH_SS_FEATURES;
+	if (ethtool_ioctl(name, sset))
+		ksft_exit_fail_msg("ETHTOOL_GSSET_INFO: %s\n", strerror(errno));
+	if (!sset->sset_mask)
+		ksft_exit_fail_msg("%s reports no feature strings\n", name);
+	count = sset->data[0];
+	blocks = (count + 31) / 32;
+	strings = calloc(1, sizeof(*strings) + count * ETH_GSTRING_LEN);
+	features = calloc(1, sizeof(*features) +
+			  blocks * sizeof(features->features[0]));
+	if (!strings || !features)
+		ksft_exit_fail_msg("calloc: %s\n", strerror(errno));
+	strings->cmd = ETHTOOL_GSTRINGS;
+	strings->string_set = ETH_SS_FEATURES;
+	strings->len = count;
+	features->cmd = ETHTOOL_GFEATURES;
+	features->size = blocks;
+	if (ethtool_ioctl(name, strings) || ethtool_ioctl(name, features))
+		ksft_exit_fail_msg("ethtool features: %s\n", strerror(errno));
+	for (i = 0; i < count; i++)
+		if (!strncmp((char *)strings->data + i * ETH_GSTRING_LEN, feature,
+			     ETH_GSTRING_LEN)) {
+			active = features->features[i / 32].active & (1U << (i % 32));
+			break;
+		}
+	free(features);
+	free(strings);
+	free(sset);
+	return active;
+}
+
+static void get_xdp_features(unsigned int ifindex, uint64_t *xdp, uint64_t *xsk,
+			     unsigned int *zc_max_segs)
+{
+	struct netdev_dev_get_req *req;
+	struct netdev_dev_get_rsp *rsp;
+	struct ynl_error yerr;
+	struct ynl_sock *ys;
+
+	ys = ynl_sock_create(&ynl_netdev_family, &yerr);
+	if (!ys)
+		ksft_exit_fail_msg("YNL: %s\n", yerr.msg);
+	req = netdev_dev_get_req_alloc();
+	if (!req)
+		ksft_exit_fail_msg("netdev_dev_get_req_alloc failed\n");
+	netdev_dev_get_req_set_ifindex(req, ifindex);
+	rsp = netdev_dev_get(ys, req);
+	netdev_dev_get_req_free(req);
+	if (!rsp)
+		ksft_exit_fail_msg("netdev dev-get: %s\n", ys->err.msg);
+	*xdp = rsp->_present.xdp_features ? rsp->xdp_features : 0;
+	*xsk = rsp->_present.xsk_features ? rsp->xsk_features : 0;
+	*zc_max_segs = rsp->_present.xdp_zc_max_segs ? rsp->xdp_zc_max_segs : 1;
+	netdev_dev_get_rsp_free(rsp);
+	ynl_sock_destroy(ys);
+}
+
+/* Returns 0, or a negative error if the device refuses the bind. */
+static int open_xsk(struct xsk *xsk, unsigned int ifindex, bool sw_csum)
+{
+	struct xsk_socket_config config = {
+		.tx_size = RING_SIZE,
+		.bind_flags = (zero_copy ? XDP_ZEROCOPY : XDP_COPY) | XDP_USE_SG,
+	};
+	struct xsk_umem_config umem_config = {
+		.fill_size = RING_SIZE,
+		.comp_size = RING_SIZE,
+		.frame_size = FRAME_SIZE,
+		.flags = XDP_UMEM_TX_METADATA_LEN,
+		.tx_metadata_len = META_LEN,
+	};
+	uint64_t deadline;
+	int err;
+
+	memset(xsk, 0, sizeof(*xsk));
+	xsk->umem = mmap(NULL, NUM_FRAMES * FRAME_SIZE, PROT_READ | PROT_WRITE,
+			 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (xsk->umem == MAP_FAILED)
+		ksft_exit_fail_msg("mmap UMEM: %s\n", strerror(errno));
+	if (sw_csum)
+		umem_config.flags |= XDP_UMEM_TX_SW_CSUM;
+	err = xsk_umem__create(&xsk->umem_handle, xsk->umem, NUM_FRAMES * FRAME_SIZE,
+			       &xsk->fill, &xsk->cq, &umem_config);
+	if (err)
+		ksft_exit_fail_msg("UMEM creation: %s\n", strerror(-err));
+	/* A previous socket on the queue may still be going away. */
+	deadline = now_ms() + TIMEOUT_MS;
+	while ((err = xsk_socket__create(&xsk->socket, ifindex, 0,
+					 xsk->umem_handle, NULL, &xsk->tx,
+					 &config))) {
+		if (err != -EBUSY || now_ms() >= deadline) {
+			xsk_umem__delete(xsk->umem_handle);
+			munmap(xsk->umem, NUM_FRAMES * FRAME_SIZE);
+			return err;
+		}
+		usleep(10000);
+	}
+	xsk->fd = xsk_socket__fd(xsk->socket);
+	return 0;
+}
+
+static void close_xsk(struct xsk *xsk)
+{
+	int err;
+
+	xsk_socket__delete(xsk->socket);
+	err = xsk_umem__delete(xsk->umem_handle);
+	if (err)
+		ksft_exit_fail_msg("UMEM deletion: %s\n", strerror(-err));
+	munmap(xsk->umem, NUM_FRAMES * FRAME_SIZE);
+}
+
+/* An IPv4 segment size one byte larger than the MTU allows. */
+static unsigned int large_gso_size(void)
+{
+	return mtu - sizeof(struct iphdr) - sizeof(struct udphdr) + 1;
+}
+
+static unsigned int case_payload(const struct test_case *t)
+{
+	/* Two segments, each too large for the MTU. */
+	return t->bad == LARGE_SEGMENT ? 2 * large_gso_size() : t->payload;
+}
+
+static unsigned int
+make_packet(unsigned char *packet, const struct test_case *t, unsigned int id,
+	    struct xsk_tx_metadata *meta)
+{
+	struct ethhdr *eth = (void *)packet;
+	unsigned int ip_len = t->ipv6 ? sizeof(struct ipv6hdr) : sizeof(struct iphdr);
+	unsigned int start = sizeof(*eth) + ip_len;
+	unsigned int udp_len = sizeof(struct udphdr) + case_payload(t);
+	struct udphdr *uh = (void *)(packet + start);
+	void *ip = packet + sizeof(*eth);
+	unsigned int i;
+
+	memset(packet, 0, start + udp_len);
+	memcpy(eth->h_source, tx_mac, ETH_ALEN);
+	memcpy(eth->h_dest, rx_mac, ETH_ALEN);
+	eth->h_proto = htons(t->ipv6 ? ETH_P_IPV6 : ETH_P_IP);
+	if (t->ipv6) {
+		struct ipv6hdr *h = ip;
+
+		h->version = 6;
+		h->nexthdr = IPPROTO_UDP;
+		h->hop_limit = 64;
+		h->payload_len = htons(udp_len);
+		inet_pton(AF_INET6, "2001:db8::1", &h->saddr);
+		inet_pton(AF_INET6, "2001:db8::2", &h->daddr);
+	} else {
+		struct iphdr *h = ip;
+
+		h->version = 4;
+		h->ihl = 5;
+		h->ttl = 64;
+		h->protocol = IPPROTO_UDP;
+		h->tot_len = htons(ip_len + udp_len);
+		h->frag_off = htons(IP_DF);
+		inet_pton(AF_INET, "198.18.0.1", &h->saddr);
+		inet_pton(AF_INET, "198.18.0.2", &h->daddr);
+		h->check = htons((uint16_t)~fold(sum_bytes(h, ip_len)));
+	}
+	uh->source = htons(TEST_PORT);
+	uh->dest = htons(TEST_PORT);
+	uh->len = htons(udp_len);
+	uh->check = htons(fold(pseudo_sum(ip, t->ipv6, udp_len)));
+	for (i = 0; i < udp_len - sizeof(*uh); i++)
+		packet[start + sizeof(*uh) + i] = (i + id * 13) % 251;
+
+	memset(meta, 0, sizeof(*meta));
+	meta->flags = XDP_TXMD_FLAGS_USO | XDP_TXMD_FLAGS_CHECKSUM;
+	meta->request.csum_start = start;
+	meta->request.csum_offset = offsetof(struct udphdr, check);
+	meta->request.gso_size = GSO_SIZE;
+	meta->request.network_offset = sizeof(*eth);
+	if (t->checksum_only)
+		meta->flags &= ~XDP_TXMD_FLAGS_USO;
+	switch (t->bad) {
+	case ZERO_SIZE:
+		meta->request.gso_size = 0;
+		break;
+	case FRAGS_SIZE:
+		meta->request.gso_size = UINT16_MAX;
+		break;
+	case NO_CHECKSUM:
+		meta->flags &= ~XDP_TXMD_FLAGS_CHECKSUM;
+		break;
+	case BAD_CSUM_OFFSET:
+		meta->request.csum_offset = 0;
+		break;
+	case BAD_NETWORK_OFFSET:
+		meta->request.network_offset++;
+		break;
+	case BAD_UDP_LENGTH:
+		uh->len = htons(udp_len - 1);
+		break;
+	case FRAGMENT:
+		((struct iphdr *)ip)->frag_off = htons(IP_MF);
+		break;
+	case BAD_PROTOCOL:
+		((struct iphdr *)ip)->protocol = IPPROTO_TCP;
+		break;
+	case EXT_HEADER:
+		((struct ipv6hdr *)ip)->nexthdr = IPPROTO_DSTOPTS;
+		break;
+	case LARGE_SEGMENT:
+		meta->request.gso_size = large_gso_size();
+		break;
+	case TIMESTAMP:
+		meta->flags |= XDP_TXMD_FLAGS_TIMESTAMP;
+		break;
+	case LAUNCH_TIME:
+		meta->flags |= XDP_TXMD_FLAGS_LAUNCH_TIME;
+		break;
+	case UNKNOWN_FLAG:
+		meta->flags |= 1ULL << 63;
+		break;
+	case BAD_IP_LENGTH:
+		if (t->ipv6)
+			((struct ipv6hdr *)ip)->payload_len = htons(udp_len - 1);
+		else
+			((struct iphdr *)ip)->tot_len = htons(ip_len + udp_len - 1);
+		break;
+	case BAD_IP_VERSION:
+		if (t->ipv6)
+			((struct ipv6hdr *)ip)->version = 4;
+		else
+			((struct iphdr *)ip)->version = 6;
+		break;
+	case BAD_IHL:
+		((struct iphdr *)ip)->ihl = 4;
+		break;
+	case BAD_TRANSPORT_OFFSET:
+		meta->request.csum_start += 4;
+		break;
+	case TOO_MANY_SEGMENTS:
+		meta->request.gso_size = 1;
+		break;
+	default:
+		break;
+	}
+	return start + udp_len;
+}
+
+/* EAGAIN means no Tx progress until completions free resources, so return
+ * to the caller to reap them instead of sleeping.
+ */
+static bool kick_tx(struct xsk *xsk)
+{
+	if (sendto(xsk->fd, NULL, 0, MSG_DONTWAIT, NULL, 0) < 0 && errno != EAGAIN) {
+		ksft_print_msg("sendto: %s\n", strerror(errno));
+		return false;
+	}
+	return true;
+}
+
+/* Length of descriptor @n of a packet with @left bytes still to place. */
+static unsigned int desc_len(const struct test_case *t,
+			     const struct xsk_tx_metadata *meta, unsigned int n,
+			     unsigned int left)
+{
+	unsigned int amount = left;
+
+	if (amount > FRAME_SIZE - META_LEN)
+		amount = FRAME_SIZE - META_LEN;
+	if (!n && t->first_len && amount > t->first_len)
+		amount = t->first_len;
+	if (!n && t->bad == SHORT_HEADER)
+		amount = meta->request.csum_start + sizeof(struct udphdr) - 1;
+	return amount;
+}
+
+static unsigned int count_descs(const struct test_case *t,
+				const struct xsk_tx_metadata *meta,
+				unsigned int len)
+{
+	unsigned int n = 0, copied = 0;
+
+	while (copied < len)
+		copied += desc_len(t, meta, n++, len - copied);
+	return n;
+}
+
+/* Submits the packet and waits for its completions. Sets @nr_descs to the
+ * number of descriptors used.
+ */
+static bool transmit(struct xsk *xsk, unsigned char *packet, unsigned int len,
+		     const struct test_case *t, struct xsk_tx_metadata *meta,
+		     unsigned int *nr_descs)
+{
+	uint32_t index;
+	uint64_t deadline = now_ms() + TIMEOUT_MS;
+	uint64_t addrs[RING_SIZE];
+	unsigned int copied = 0, n = 0, completed = 0;
+	bool seen[RING_SIZE] = {};
+
+	while (copied < len) {
+		struct xdp_desc *desc;
+		unsigned int amount = desc_len(t, meta, n, len - copied);
+		uint64_t addr = n * FRAME_SIZE + META_LEN;
+
+		memcpy(xsk->umem + addr, packet + copied, amount);
+		if (!n)
+			memcpy(xsk->umem + addr - META_LEN, meta, META_LEN);
+		if (xsk_ring_prod__reserve(&xsk->tx, 1, &index) != 1) {
+			ksft_print_msg("functional Tx ring reservation failed\n");
+			return false;
+		}
+		desc = xsk_ring_prod__tx_desc(&xsk->tx, index);
+		*desc = (struct xdp_desc) {
+			.addr = addr,
+			.len = amount,
+			.options = (!n && meta->flags ? XDP_TX_METADATA : 0) |
+				   (copied + amount < len ? XDP_PKT_CONTD : 0),
+		};
+		addrs[n++] = addr;
+		copied += amount;
+	}
+	xsk_ring_prod__submit(&xsk->tx, n);
+	*nr_descs = n;
+	while (completed < n) {
+		unsigned int count, i;
+
+		if (!kick_tx(xsk))
+			return false;
+		count = xsk_ring_cons__peek(&xsk->cq, RING_SIZE, &index);
+		for (i = 0; i < count; i++) {
+			uint64_t addr = *xsk_ring_cons__comp_addr(&xsk->cq, index + i);
+			unsigned int j;
+
+			for (j = 0; j < n; j++)
+				if (addr == addrs[j])
+					break;
+			if (j == n || seen[j]) {
+				ksft_print_msg("functional Tx: invalid or duplicate completion\n");
+				return false;
+			}
+			seen[j] = true;
+		}
+		xsk_ring_cons__release(&xsk->cq, count);
+		completed += count;
+		if (completed < n && now_ms() > deadline) {
+			ksft_print_msg("completion timeout\n");
+			return false;
+		}
+	}
+	return true;
+}
+
+/* USO with launch time is copy mode only. */
+static bool valid_request(const struct test_case *t)
+{
+	return t->bad == VALID || (t->bad == LAUNCH_TIME && !zero_copy);
+}
+
+/* Requests that produce more than one datagram, valid or not. Without
+ * tx-udp-segmentation, invalid ones would be dropped for lack of the
+ * offload even if a header check were missing.
+ */
+static bool needs_segmentation(const struct test_case *t)
+{
+	return !t->checksum_only && case_payload(t) > GSO_SIZE;
+}
+
+/* Drop frames that a failed or late case left behind. */
+static void drain_packets(int fd)
+{
+	unsigned char packet[64];
+
+	while (recv(fd, packet, sizeof(packet), MSG_DONTWAIT | MSG_TRUNC) >= 0)
+		;
+}
+
+static bool receive_packets(int fd, const struct test_case *t, unsigned int id)
+{
+	unsigned int count = 0, received = 0;
+	unsigned int expected = valid_request(t) ? t->payload : 0;
+	unsigned int expected_count = 0;
+	uint64_t deadline;
+	unsigned char packet[8192];
+
+	if (valid_request(t)) {
+		expected_count = (expected + GSO_SIZE - 1) / GSO_SIZE;
+		if (t->checksum_only || !expected)
+			expected_count = 1;
+	}
+	deadline = now_ms() + (expected_count ? TIMEOUT_MS : 200);
+	while (now_ms() < deadline) {
+		unsigned int ip_len = t->ipv6 ? sizeof(struct ipv6hdr) : sizeof(struct iphdr);
+		unsigned int start = sizeof(struct ethhdr) + ip_len;
+		struct pollfd pfd = { .fd = fd, .events = POLLIN };
+		struct ethhdr *eth = (void *)packet;
+		struct udphdr *uh = (void *)(packet + start);
+		unsigned int payload, frame_len, max_frame_len, i;
+		ssize_t len;
+
+		if (poll(&pfd, 1, 20) < 0) {
+			ksft_print_msg("receive: poll: %s\n", strerror(errno));
+			return false;
+		}
+		len = recv(fd, packet, sizeof(packet), MSG_DONTWAIT);
+		if (len < 0) {
+			if (errno == EAGAIN)
+				continue;
+			ksft_print_msg("receive: recv: %s\n", strerror(errno));
+			return false;
+		}
+		if ((size_t)len < start + sizeof(*uh) ||
+		    memcmp(eth->h_source, tx_mac, ETH_ALEN) ||
+		    memcmp(eth->h_dest, rx_mac, ETH_ALEN) ||
+		    eth->h_proto != htons(t->ipv6 ? ETH_P_IPV6 : ETH_P_IP) ||
+		    uh->source != htons(TEST_PORT) || uh->dest != htons(TEST_PORT))
+			continue;
+		if (count >= expected_count) {
+			ksft_print_msg("receive: unexpected datagram, %u expected\n",
+				       expected_count);
+			return false;
+		}
+		payload = expected - received;
+		if (!t->checksum_only && payload > GSO_SIZE)
+			payload = GSO_SIZE;
+		frame_len = start + sizeof(*uh) + payload;
+		max_frame_len = frame_len < ETH_ZLEN ? ETH_ZLEN : frame_len;
+		if (ntohs(uh->len) != sizeof(*uh) + payload) {
+			ksft_print_msg("receive: datagram %u: UDP length %u, expected %zu\n",
+				       count, ntohs(uh->len), sizeof(*uh) + payload);
+			return false;
+		}
+		if ((size_t)len < frame_len || (size_t)len > max_frame_len) {
+			ksft_print_msg("receive: datagram %u: frame length %zd, expected %u\n",
+				       count, len, frame_len);
+			return false;
+		}
+		if (!uh->check ||
+		    fold(sum_bytes(uh, sizeof(*uh) + payload) +
+			 pseudo_sum(packet + sizeof(*eth), t->ipv6,
+				    sizeof(*uh) + payload)) != 0xffff) {
+			ksft_print_msg("receive: datagram %u: bad UDP checksum 0x%04x\n",
+				       count, ntohs(uh->check));
+			return false;
+		}
+		if (t->ipv6) {
+			struct ipv6hdr *h = (void *)(packet + sizeof(*eth));
+
+			if (ntohs(h->payload_len) != sizeof(*uh) + payload) {
+				ksft_print_msg("receive: datagram %u: IPv6 len %u, expected %zu\n",
+					       count, ntohs(h->payload_len),
+					       sizeof(*uh) + payload);
+				return false;
+			}
+		} else {
+			struct iphdr *h = (void *)(packet + sizeof(*eth));
+
+			if (ntohs(h->tot_len) != ip_len + sizeof(*uh) + payload) {
+				ksft_print_msg("receive: datagram %u: IPv4 len %u, expected %zu\n",
+					       count, ntohs(h->tot_len),
+					       ip_len + sizeof(*uh) + payload);
+				return false;
+			}
+			if (fold(sum_bytes(h, ip_len)) != 0xffff) {
+				ksft_print_msg("receive: datagram %u: bad IPv4 header checksum\n",
+					       count);
+				return false;
+			}
+		}
+		for (i = 0; i < payload; i++)
+			if (packet[start + sizeof(*uh) + i] !=
+			    (received + i + id * 13) % 251) {
+				ksft_print_msg("receive: datagram %u: bad payload byte %u\n",
+					       count, i);
+				return false;
+			}
+		received += payload;
+		count++;
+		if (count == expected_count)
+			deadline = now_ms() + 100;
+	}
+	if (received != expected || count != expected_count) {
+		ksft_print_msg("receive: %u/%u packets, %u/%u payload bytes\n",
+			       count, expected_count, received, expected);
+		return false;
+	}
+	return true;
+}
+
+/* Opens the default socket for case @i onwards. If that fails, the remaining
+ * cases cannot run.
+ */
+static void restore_xsk(struct xsk *xsk, unsigned int ifindex, unsigned int i)
+{
+	int err = open_xsk(xsk, ifindex, false);
+
+	if (!err)
+		return;
+	for (; i < ARRAY_SIZE(cases); i++)
+		ksft_test_result_error("%s: socket creation: %s\n", cases[i].name,
+				       strerror(-err));
+	ksft_finished();
+}
+
+static void reopen_xsk(struct xsk *xsk, unsigned int ifindex, unsigned int i)
+{
+	close_xsk(xsk);
+	restore_xsk(xsk, ifindex, i);
+}
+
+int main(int argc, char **argv)
+{
+	const char *tx_name = NULL, *rx_name = NULL;
+	struct sockaddr_ll addr = { .sll_family = AF_PACKET, .sll_protocol = htons(ETH_P_ALL) };
+	uint64_t xdp_features = 0, xsk_features = 0;
+	bool loopback = false, udp_segmentation;
+	struct xsk_tx_metadata meta;
+	unsigned int ifindex, i;
+	unsigned int zc_max_segs = 0;
+	bool sw_csum = false;
+	int err;
+	struct xsk xsk;
+	int fd, opt;
+
+	while ((opt = getopt(argc, argv, "i:r:zlC")) != -1) {
+		if (opt == 'i')
+			tx_name = optarg;
+		else if (opt == 'r')
+			rx_name = optarg;
+		else if (opt == 'z')
+			zero_copy = true;
+		else if (opt == 'l')
+			loopback = true;
+		else if (opt == 'C')
+			checksum_tests = true;
+		else
+			ksft_exit_fail_msg("Usage: %s [-z] [-l] [-C] -i TX_IFACE [-r RX_IFACE]\n",
+					   argv[0]);
+	}
+	if (loopback) {
+		if (rx_name && (!tx_name || strcmp(tx_name, rx_name)))
+			ksft_exit_fail_msg("Loopback needs one interface for Tx and Rx\n");
+		rx_name = tx_name;
+	}
+	ksft_print_header();
+	if (!tx_name || !rx_name || geteuid())
+		ksft_exit_skip("needs root and -i TX_IFACE -r RX_IFACE, or -l -i IFACE\n");
+	ifindex = if_nametoindex(tx_name);
+	addr.sll_ifindex = if_nametoindex(rx_name);
+	if (!addr.sll_ifindex || !ifindex ||
+	    (!loopback && !strcmp(tx_name, rx_name)))
+		ksft_exit_fail_msg("Use two connected interfaces, or -l\n");
+	get_mac(tx_name, tx_mac);
+	get_mac(rx_name, rx_mac);
+	if (loopback) {
+		/* Avoid sending the port's own source MAC back into its Rx filter. */
+		tx_mac[0] = (tx_mac[0] | 2) & ~1;
+		tx_mac[ETH_ALEN - 1] ^= 0x80;
+		memset(rx_mac, 0xff, ETH_ALEN);
+	}
+	if (!is_physical(tx_name) || !is_physical(rx_name))
+		ksft_exit_skip("%s and %s must be physical NICs that segment on the wire\n",
+			       tx_name, rx_name);
+	mtu = get_mtu(tx_name);
+	if (mtu < MIN_MTU || get_mtu(rx_name) < MIN_MTU)
+		ksft_exit_skip("%s and %s need an MTU of at least %zu\n",
+			       tx_name, rx_name, MIN_MTU);
+	/* The oversized-segment case must fit the buffers of a packet. */
+	if (sizeof(struct ethhdr) + sizeof(struct iphdr) +
+	    sizeof(struct udphdr) + 2 * large_gso_size() >
+	    MAX_BUFFERS * (FRAME_SIZE - META_LEN))
+		ksft_exit_skip("%s has MTU %u, too large for the test buffers\n",
+			       tx_name, mtu);
+	if (zero_copy) {
+		get_xdp_features(ifindex, &xdp_features, &xsk_features,
+				 &zc_max_segs);
+		if (!(xdp_features & NETDEV_XDP_ACT_XSK_ZEROCOPY))
+			ksft_exit_skip("%s does not support AF_XDP zero-copy\n", tx_name);
+		if (!(xsk_features & NETDEV_XSK_FLAGS_TX_USO_ZC))
+			ksft_exit_skip("%s does not report tx-uso-zc\n", tx_name);
+		if (!xsk_is_in_mode(ifindex, XDP_FLAGS_DRV_MODE))
+			ksft_exit_skip("%s has no native XDP program attached\n", tx_name);
+		if (zc_max_segs < 2)
+			ksft_exit_skip("%s does not support multi-buffer zero-copy\n",
+				       tx_name);
+	}
+	/* The packet socket sees received packets after GRO, which could merge
+	 * the segments back together.
+	 */
+	if (feature_active(rx_name, "rx-udp-gro-forwarding") ||
+	    feature_active(rx_name, "rx-gro-list"))
+		ksft_exit_skip("turn off rx-udp-gro-forwarding and rx-gro-list on %s\n",
+			       rx_name);
+	udp_segmentation = feature_active(tx_name, "tx-udp-segmentation");
+	fd = socket(AF_PACKET, SOCK_RAW | SOCK_NONBLOCK, htons(ETH_P_ALL));
+	if (fd < 0)
+		ksft_exit_fail_msg("packet socket: %s\n", strerror(errno));
+	{
+		int ignore_outgoing = 1;
+
+		if (setsockopt(fd, SOL_PACKET, PACKET_IGNORE_OUTGOING,
+			       &ignore_outgoing, sizeof(ignore_outgoing)) ||
+		    bind(fd, (void *)&addr, sizeof(addr)))
+			ksft_exit_fail_msg("packet socket setup: %s\n", strerror(errno));
+	}
+	err = open_xsk(&xsk, ifindex, false);
+	if (err == -EOPNOTSUPP)
+		ksft_exit_skip("%s does not support this AF_XDP bind\n", tx_name);
+	if (err)
+		ksft_exit_fail_msg("socket creation: %s\n", strerror(-err));
+	ksft_set_plan(ARRAY_SIZE(cases));
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		const struct test_case *t = &cases[i];
+		struct xdp_statistics before, after;
+		socklen_t size = sizeof(before);
+		unsigned int len, descs, expected_invalid = 0;
+		bool ok, want_sw_csum;
+
+		if (!checksum_tests && t->checksum_only) {
+			ksft_test_result_skip("%s: checksum offload cases need -C\n",
+					      t->name);
+			continue;
+		}
+		if (zero_copy && t->checksum_only &&
+		    !(xsk_features & NETDEV_XSK_FLAGS_TX_CHECKSUM)) {
+			ksft_test_result_skip("%s: %s does not report tx-checksum\n",
+					      t->name, tx_name);
+			continue;
+		}
+		if (zero_copy && t->bad == SW_CHECKSUM) {
+			ksft_test_result_skip("%s: software checksum is copy mode only\n",
+					      t->name);
+			continue;
+		}
+		if (needs_segmentation(t) && !udp_segmentation) {
+			ksft_test_result_skip("%s: tx-udp-segmentation is off on %s\n",
+					      t->name, tx_name);
+			continue;
+		}
+		len = make_packet(tx_packet, t, i, &meta);
+		if (zero_copy && count_descs(t, &meta, len) > zc_max_segs) {
+			ksft_test_result_skip("%s: needs more than %u descriptors\n",
+					      t->name, zc_max_segs);
+			continue;
+		}
+		want_sw_csum = t->bad == SW_CHECKSUM;
+		if (sw_csum && !want_sw_csum) {
+			sw_csum = false;
+			reopen_xsk(&xsk, ifindex, i);
+		} else if (want_sw_csum && !sw_csum) {
+			close_xsk(&xsk);
+			err = open_xsk(&xsk, ifindex, true);
+			if (err) {
+				/* open_xsk() released the socket on failure. */
+				if (err == -EOPNOTSUPP)
+					ksft_test_result_skip("%s: %s refuses %s\n", t->name,
+							      tx_name, "XDP_UMEM_TX_SW_CSUM");
+				else
+					ksft_test_result_error("%s: socket creation: %s\n",
+							       t->name, strerror(-err));
+				restore_xsk(&xsk, ifindex, i + 1);
+				continue;
+			}
+			sw_csum = true;
+		}
+		drain_packets(fd);
+		if (getsockopt(xsk.fd, SOL_XDP, XDP_STATISTICS, &before, &size)) {
+			ksft_test_result_error("%s: XDP_STATISTICS: %s\n", t->name,
+					       strerror(errno));
+			continue;
+		}
+		if (!transmit(&xsk, tx_packet, len, t, &meta, &descs)) {
+			ksft_test_result_fail("%s: submission or completion failed\n",
+					      t->name);
+			/* Start the next case from a clean socket. */
+			sw_csum = false;
+			reopen_xsk(&xsk, ifindex, i + 1);
+			continue;
+		}
+		ok = receive_packets(fd, t, i);
+		if (!valid_request(t))
+			expected_invalid = descs;
+		size = sizeof(after);
+		if (getsockopt(xsk.fd, SOL_XDP, XDP_STATISTICS, &after, &size)) {
+			ksft_test_result_error("%s: XDP_STATISTICS: %s\n", t->name,
+					       strerror(errno));
+			continue;
+		}
+		if (after.tx_invalid_descs - before.tx_invalid_descs != expected_invalid) {
+			ksft_print_msg("tx_invalid_descs grew by %llu, expected %u\n",
+				       after.tx_invalid_descs - before.tx_invalid_descs,
+				       expected_invalid);
+			ok = false;
+		}
+		if (!ok && zero_copy && valid_request(t))
+			ksft_print_msg("%s\n%s\n",
+				       "Drivers may ignore USO in some configurations,",
+				       "see Documentation/networking/xsk-tx-metadata.rst");
+		ksft_test_result(ok, "%s\n", t->name);
+	}
+	close_xsk(&xsk);
+	close(fd);
+	ksft_finished();
+}
-- 
2.38.1

