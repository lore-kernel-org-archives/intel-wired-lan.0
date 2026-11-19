Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA26606A337
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 16:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=TP99Imr0;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AO94A2v5
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E7EC60749;
	Thu, 19 Nov 2026 16:54:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UOpJ_1iEkeRO; Thu, 19 Nov 2026 16:54:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2512E6069F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795107255;
	b=iCAOrz6Y7jyfrakgIlR1WQCalD5evxzlwiVL9rmMNYvMNuZxfQ774W9BdpiQBrWJwkH/
	 cIFSL6SoIuNt3ngGjHQnVvDgxXYIWC5yI42vfwTu4CxGYq3oCpA+8xeRvHzXkz6/t3mSO
	 qRyZSCqxkQr4wwUMea2TsCN8a5rftV19tcarVQpizsia996b+6n8cnoRInAQHi/WJ/MPW
	 dTH/n+C4mxSXeaFO1mqGPqShwrxS8XBaBdxk5sGoTPOgVJU9RiNKfvVMjsyi/PHvp3Ar2
	 HGrz3BKXKNRnrg6+yPWYcF9uCdJdhBS8Ge8397kQLxeLoxM1R6JVPTftdHub4rXyGxQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795107255;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3a/4iVoMyX+imSqLnnb1dUVm1CzUkONqRQpiuKSwmiI=;
	b=POZ6Fw0LGrV/F6X2Xexcpi6tXHqisEUgcBSQx77JxVlAzAp/QpasyjDBiskWGbI0ew+L
	 ZA31UIJ8NGCGWh+xCN9ysWYkcepRQ+RrTGk49SOuLbdFfFpJ1v7k2qowBX6oTveHhYj03
	 iwt+hapUlzwceptRfr7q6xm7PWb/DwWKah///9hWGw97EZHxqYoCUoWNNEaBT0PTXsZex
	 dwJgDGCa/FfMnKZfRnzGLjq3qAtc0hK1HX7w5tm5INn+PLh0KEbnbJ6AodYW6YtONKlL5
	 OUABWMwtDyCSPSzSTjX0zNdd6w5VDkqhCbiShf4HESEt2UirSaND/mD86mvgAwAk97w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795107255;
	bh=3a/4iVoMyX+imSqLnnb1dUVm1CzUkONqRQpiuKSwmiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TP99Imr0IXTCurkdgfYCwsNo6JY5HQJiMSiBP2JGYFVaDi5j8XXwu20fnbmP/Homk
	 UtDuhU3YaKaMnxTXdlcp505kLxLUSas1nUawtQUi5DrK4zjy2l47U7jItE/LGkx5Qt
	 aqRJdMWJfcTyMAl8lCeA5Bi499udka3+fTGfqEMpx5EjlXzcoObzVrOH8RMUgjhzlG
	 0Jzvm8Z4Au2k0kIV0HO24NWRbluasC6u7GHK39w31C3fYgmdhDjx+pEJv195V/velh
	 YqN3/RQ0hu9Tty0U+YbBV62sqLGeHnQPrEzX+Fh8r/Vbg5w2SFWu6lvIReCnPFQKsq
	 KoYuN7hQoU+sA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2512E6069F;
	Thu, 19 Nov 2026 16:54:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B9951C9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 16:54:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8D3CD8110A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 16:54:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pl5FcKOuV6rp for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 16:54:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D510281106
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.21
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=magnus.karlsson@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=AO94A2v5
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D510281106
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 16:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795107252; x=1826643252;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vlCzwpAk1/VQVK7t4fVrf+Kzxiafq/9oYdpcA29fgNc=;
 b=AO94A2v5Ysp5kw8foDgwp5ZSNWlyyjezdh7WHfYWvL6bY9cJ/gyXDBeD
 go0nU/BySHXQHa8C1qstQ1U7igQ40CD3vEiqPiaHLQoE3UQqlBvRaNQQB
 E2pzu5kn0c2MIjiBaGXY8E2d3A0i0nuhe0khbgEcHNtiuc/VxqdAOkUYb
 UIGiiFyLhcjARji6T63t6GYmI4X34Gs+Yuf20bkjjqfj5OfLsIrnqcnn4
 wLZtIHie9aaEtsGYAmCaLfv5v7U6yXTmgOFYANsnBRtQEWoHKrVcOgnTF
 vWu9R8oBkEs9IWEL4eY6rXrO44yN4YCxgZktmB1RSe3Z7kcdWTzEJisDu w==;
X-CSE-ConnectionGUID: P4M4BlYdSNeFbClq2+snxQ==
X-CSE-MsgGUID: OGpLWv/4SD+eAahMf3hIKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4045462"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="4045462"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 08:54:12 -0800
X-CSE-ConnectionGUID: sEbvZt8SSQSX2pph6jfSkQ==
X-CSE-MsgGUID: BtS3mduhSyCsNUfD7WYU2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; d="scan'208";a="10774992"
Received: from boxer.igk.intel.com ([10.102.20.173])
 by orviesa009.jf.intel.com with ESMTP; 19 Nov 2026 08:54:08 -0800
From: Magnus Karlsson <magnus.karlsson@intel.com>
To: netdev@vger.kernel.org, magnus.karlsson@intel.com,
 magnus.karlsson@gmail.com, maciej.fijalkowski@intel.com, sdf@fomichev.me,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, bjorn@kernel.org,
 kerneljasonxing@gmail.com
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com
Subject: [PATCH net-next 4/5] xsk: add KUnit tests for AF_XDP USO header
 helpers
Date: Thu, 19 Nov 2026 17:53:39 +0100
Message-Id: <20261119165340.1071525-5-magnus.karlsson@intel.com>
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

Add KUnit tests for the helpers that AF_XDP uses to validate and prepare
USO requests, as these run on headers supplied by user space and are
shared by the copy and zero-copy paths:

- xsk_tx_uso_validate(): IPv4 and IPv6, link-layer headers of different
  lengths, IPv4 options, malformed IP and UDP headers, an IPv6
  destination options header, a non-UDP IPv6 next header, a UDP header
  that does not directly follow the IPv6 header, bad offsets and
  lengths, the MTU and the segment count limit.
  The link layer is not parsed, so the IP header is found at
  network_offset whatever the EtherType says.
- xsk_tx_uso_parse(): the header and metadata are snapshotted, so later
  changes to the UMEM do not reach the copy; invalid metadata, offsets
  and descriptor layouts are rejected; flag combinations that USO does
  not support are rejected; segmentation needs NETIF_F_GSO_UDP_L4 while
  a single datagram does not; requests without USO are left alone.
- xsk_tx_uso_prepare_headers(): the checksum seeds are compared with
  pseudo-header checksums computed independently with
  csum_tcpudp_magic() and csum_ipv6_magic(), and a single datagram
  keeps its headers.
- xsk_buff_valid_tx_metadata() and xsk_tx_uso_flags_valid() for USO.

The tests are in net/xdp/tests/xsk_tx_uso_kunit.c, following the KUnit
naming convention. Run with:

  ./tools/testing/kunit/kunit.py run --kunitconfig=net/xdp

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 net/xdp/.kunitconfig             |   6 +
 net/xdp/Kconfig                  |  12 +
 net/xdp/Makefile                 |   1 +
 net/xdp/tests/xsk_tx_uso_kunit.c | 620 +++++++++++++++++++++++++++++++
 4 files changed, 639 insertions(+)
 create mode 100644 net/xdp/.kunitconfig
 create mode 100644 net/xdp/tests/xsk_tx_uso_kunit.c

diff --git a/net/xdp/.kunitconfig b/net/xdp/.kunitconfig
new file mode 100644
index 000000000000..d88b8e3643f1
--- /dev/null
+++ b/net/xdp/.kunitconfig
@@ -0,0 +1,6 @@
+CONFIG_KUNIT=y
+CONFIG_NET=y
+CONFIG_BPF=y
+CONFIG_BPF_SYSCALL=y
+CONFIG_XDP_SOCKETS=y
+CONFIG_XDP_SOCKETS_USO_KUNIT_TEST=y
diff --git a/net/xdp/Kconfig b/net/xdp/Kconfig
index 71af2febe72a..f230b9049ef0 100644
--- a/net/xdp/Kconfig
+++ b/net/xdp/Kconfig
@@ -14,3 +14,15 @@ config XDP_SOCKETS_DIAG
 	help
 	  Support for PF_XDP sockets monitoring interface used by the ss tool.
 	  If unsure, say Y.
+
+config XDP_SOCKETS_USO_KUNIT_TEST
+	tristate "AF_XDP USO header validation tests" if !KUNIT_ALL_TESTS
+	depends on XDP_SOCKETS && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  KUnit tests for the helpers that validate and prepare AF_XDP UDP
+	  segmentation offload (USO) requests in copy and zero-copy mode:
+	  header validation, metadata snapshots, segment limits and the
+	  preparation of headers and checksum seeds for segmentation.
+
+	  If unsure, say N.
diff --git a/net/xdp/Makefile b/net/xdp/Makefile
index b6109e0e5547..aef2e70f7a6f 100644
--- a/net/xdp/Makefile
+++ b/net/xdp/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_XDP_SOCKETS) += xsk.o xdp_umem.o xsk_queue.o xskmap.o
 obj-$(CONFIG_XDP_SOCKETS) += xsk_buff_pool.o
 obj-$(CONFIG_XDP_SOCKETS) += xsk_tx_uso.o
 obj-$(CONFIG_XDP_SOCKETS_DIAG) += xsk_diag.o
+obj-$(CONFIG_XDP_SOCKETS_USO_KUNIT_TEST) += tests/xsk_tx_uso_kunit.o
diff --git a/net/xdp/tests/xsk_tx_uso_kunit.c b/net/xdp/tests/xsk_tx_uso_kunit.c
new file mode 100644
index 000000000000..53d763aa53dc
--- /dev/null
+++ b/net/xdp/tests/xsk_tx_uso_kunit.c
@@ -0,0 +1,620 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <kunit/test.h>
+#include <linux/if_vlan.h>
+#include <net/ip.h>
+#include <net/ip6_checksum.h>
+#include <net/udp.h>
+#include <net/xdp_sock_drv.h>
+#include <net/xsk_tx_uso.h>
+
+#define USO_META_LEN	sizeof(struct xsk_tx_metadata)
+
+static const __be32 uso_saddr = cpu_to_be32(0xc0a80001);
+static const __be32 uso_daddr = cpu_to_be32(0xc0a80002);
+
+/* Build an Ethernet frame with @l2_len bytes of link layer, one IP header and
+ * a UDP header carrying @payload bytes, and describe it in @uso.
+ */
+static void uso_packet(void *header, struct xsk_tx_uso_info *uso,
+		       bool ipv6, u32 l2_len, u32 payload)
+{
+	u32 iplen = ipv6 ? sizeof(struct ipv6hdr) : sizeof(struct iphdr);
+	struct xsk_tx_metadata *meta = &uso->metadata;
+	struct ethhdr *eth = header;
+	struct udphdr *uh;
+
+	memset(header, 0, XSK_TX_USO_MAX_HEADER);
+	memset(uso, 0, sizeof(*uso));
+	meta->request.network_offset = l2_len;
+	meta->request.csum_start = l2_len + iplen;
+	meta->request.csum_offset = offsetof(struct udphdr, check);
+	meta->request.gso_size = 1400;
+	uso->header_len = meta->request.csum_start + sizeof(*uh);
+	uso->len = uso->header_len + payload;
+	eth->h_proto = htons(ipv6 ? ETH_P_IPV6 : ETH_P_IP);
+	if (ipv6) {
+		struct ipv6hdr *ip6h = header + l2_len;
+
+		ip6h->version = 6;
+		ip6h->nexthdr = IPPROTO_UDP;
+		ip6h->payload_len = htons(sizeof(*uh) + payload);
+		ip6h->saddr.s6_addr32[0] = uso_saddr;
+		ip6h->daddr.s6_addr32[0] = uso_daddr;
+	} else {
+		struct iphdr *iph = header + l2_len;
+
+		iph->version = 4;
+		iph->ihl = 5;
+		iph->protocol = IPPROTO_UDP;
+		iph->tot_len = htons(iplen + sizeof(*uh) + payload);
+		iph->saddr = uso_saddr;
+		iph->daddr = uso_daddr;
+	}
+	uh = header + meta->request.csum_start;
+	uh->len = htons(sizeof(*uh) + payload);
+}
+
+/* The header copy, at the alignment that drivers give it. Kept off the stack,
+ * as KASAN builds pad every on-stack buffer.
+ */
+static void *uso_header(struct kunit *test)
+{
+	u8 *storage = kunit_kzalloc(test, NET_IP_ALIGN + XSK_TX_USO_MAX_HEADER,
+				    GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, storage);
+	return storage + NET_IP_ALIGN;
+}
+
+/* Partial pseudo-header checksum over a UDP length, as an application seeds it. */
+static __sum16 uso_pseudo_csum(void *header, const struct xsk_tx_uso_info *uso,
+			       bool ipv6, u32 udp_len)
+{
+	void *ip = header + uso->metadata.request.network_offset;
+
+	if (ipv6) {
+		struct ipv6hdr *ip6h = ip;
+
+		return ~csum_ipv6_magic(&ip6h->saddr, &ip6h->daddr, udp_len,
+					IPPROTO_UDP, 0);
+	}
+	return ~csum_tcpudp_magic(((struct iphdr *)ip)->saddr,
+				  ((struct iphdr *)ip)->daddr, udp_len,
+				  IPPROTO_UDP, 0);
+}
+
+static void uso_valid(struct kunit *test)
+{
+	static const u32 l2_lens[] = { ETH_HLEN, ETH_HLEN + VLAN_HLEN,
+				       ETH_HLEN + 8 };
+	void *header = uso_header(test);
+	struct xsk_tx_uso_info uso;
+	int ipv6, i;
+
+	for (ipv6 = 0; ipv6 < 2; ipv6++)
+		for (i = 0; i < ARRAY_SIZE(l2_lens); i++) {
+			uso_packet(header, &uso, ipv6, l2_lens[i], 4000);
+			KUNIT_ASSERT_EQ_MSG(test,
+					    xsk_tx_uso_validate(header, &uso, 1500),
+					    0, "ipv6 %d l2 %u", ipv6, l2_lens[i]);
+			KUNIT_EXPECT_EQ(test, uso.gso_segs, 3);
+			KUNIT_EXPECT_EQ(test, ntohs(uso.protocol),
+					ipv6 ? ETH_P_IPV6 : ETH_P_IP);
+			KUNIT_EXPECT_EQ(test, uso.l4_protocol, IPPROTO_UDP);
+			uso_packet(header, &uso, ipv6, l2_lens[i], 0);
+			KUNIT_ASSERT_EQ(test, xsk_tx_uso_validate(header, &uso, 1500),
+					0);
+			KUNIT_EXPECT_EQ(test, uso.gso_segs, 1);
+		}
+}
+
+enum uso_invalid_kind {
+	USO_INVALID_IPV6_VERSION,
+	USO_INVALID_IHL,
+	USO_INVALID_TOT_LEN,
+	USO_INVALID_FRAGMENT,
+	USO_INVALID_PROTOCOL,
+	USO_INVALID_UDP_LEN,
+	USO_INVALID_NETWORK_OFFSET,
+	USO_INVALID_NO_IP_HEADER,
+	USO_INVALID_LEN,
+	/* IPv6 cases from here on. */
+	USO_INVALID_IPV6_NEXTHDR,
+	USO_INVALID_IPV6_EXT_HEADER,
+	USO_INVALID_IPV6_UDP_OFFSET,
+};
+
+struct uso_invalid_case {
+	const char *name;
+	enum uso_invalid_kind kind;
+};
+
+static const struct uso_invalid_case uso_invalid_cases[] = {
+	{ "ipv4_header_with_ipv6_version", USO_INVALID_IPV6_VERSION },
+	{ "short_ihl", USO_INVALID_IHL },
+	{ "short_tot_len", USO_INVALID_TOT_LEN },
+	{ "fragment", USO_INVALID_FRAGMENT },
+	{ "not_udp", USO_INVALID_PROTOCOL },
+	{ "short_udp_len", USO_INVALID_UDP_LEN },
+	{ "short_network_offset", USO_INVALID_NETWORK_OFFSET },
+	{ "no_ip_header", USO_INVALID_NO_IP_HEADER },
+	{ "len_below_header", USO_INVALID_LEN },
+	{ "ipv6_non_udp_nexthdr", USO_INVALID_IPV6_NEXTHDR },
+	{ "ipv6_extension_header", USO_INVALID_IPV6_EXT_HEADER },
+	{ "ipv6_udp_offset_past_header", USO_INVALID_IPV6_UDP_OFFSET },
+};
+
+KUNIT_ARRAY_PARAM_DESC(uso_invalid, uso_invalid_cases, name);
+
+static void uso_invalid(struct kunit *test)
+{
+	const struct uso_invalid_case *param = test->param_value;
+	bool ipv6 = param->kind >= USO_INVALID_IPV6_NEXTHDR;
+	void *header = uso_header(test);
+	struct xsk_tx_uso_info uso;
+	struct iphdr *iph;
+	struct udphdr *uh;
+
+	uso_packet(header, &uso, ipv6, ETH_HLEN, 4000);
+	iph = header + uso.metadata.request.network_offset;
+	uh = header + uso.metadata.request.csum_start;
+	switch (param->kind) {
+	case USO_INVALID_IPV6_VERSION:
+		/* An IPv6 version needs a 40-byte network header. */
+		iph->version = 6;
+		break;
+	case USO_INVALID_IHL:
+		iph->ihl = 4;
+		break;
+	case USO_INVALID_TOT_LEN:
+		iph->tot_len = htons(40);
+		break;
+	case USO_INVALID_FRAGMENT:
+		iph->frag_off = htons(IP_MF);
+		break;
+	case USO_INVALID_PROTOCOL:
+		iph->protocol = IPPROTO_TCP;
+		break;
+	case USO_INVALID_UDP_LEN:
+		uh->len = htons(8);
+		break;
+	case USO_INVALID_NETWORK_OFFSET:
+		uso.metadata.request.network_offset = ETH_HLEN - 1;
+		break;
+	case USO_INVALID_NO_IP_HEADER:
+		uso.metadata.request.network_offset =
+			uso.metadata.request.csum_start;
+		break;
+	case USO_INVALID_LEN:
+		uso.len = uso.header_len - 1;
+		break;
+	case USO_INVALID_IPV6_NEXTHDR:
+		((struct ipv6hdr *)iph)->nexthdr = IPPROTO_DSTOPTS;
+		break;
+	case USO_INVALID_IPV6_EXT_HEADER: {
+		/* An otherwise valid 8-byte destination options header between
+		 * the IPv6 and UDP headers, with csum_start past it.
+		 */
+		struct ipv6hdr *ip6h = (struct ipv6hdr *)iph;
+		u8 *opts = (u8 *)uh;
+
+		memmove(opts + 8, uh, sizeof(*uh));
+		memset(opts, 0, 8);
+		opts[0] = IPPROTO_UDP;		/* next header */
+		opts[2] = IPV6_TLV_PADN;	/* pad the remaining 6 bytes */
+		opts[3] = 4;
+		ip6h->nexthdr = IPPROTO_DSTOPTS;
+		be16_add_cpu(&ip6h->payload_len, 8);
+		uso.metadata.request.csum_start += 8;
+		uso.header_len += 8;
+		uso.len += 8;
+		break;
+	}
+	case USO_INVALID_IPV6_UDP_OFFSET:
+		/* The same layout, but with nexthdr naming UDP, so that only
+		 * the IPv6 header length check can reject it.
+		 */
+		memmove((u8 *)uh + 8, uh, sizeof(*uh));
+		memset(uh, 0, 8);
+		be16_add_cpu(&((struct ipv6hdr *)iph)->payload_len, 8);
+		uso.metadata.request.csum_start += 8;
+		uso.header_len += 8;
+		uso.len += 8;
+		break;
+	}
+	KUNIT_EXPECT_EQ(test, xsk_tx_uso_validate(header, &uso, 1500), -EINVAL);
+}
+
+static void uso_limits(struct kunit *test)
+{
+	void *header = uso_header(test);
+	struct xsk_tx_uso_info uso;
+
+	uso_packet(header, &uso, false, ETH_HLEN, 8192);
+	uso.metadata.request.gso_size = 64;
+	KUNIT_EXPECT_EQ(test, xsk_tx_uso_validate(header, &uso, 1500), 0);
+	KUNIT_EXPECT_EQ(test, uso.gso_segs, UDP_MAX_SEGMENTS);
+	uso_packet(header, &uso, false, ETH_HLEN, 8193);
+	uso.metadata.request.gso_size = 64;
+	KUNIT_EXPECT_EQ(test, xsk_tx_uso_validate(header, &uso, 1500), -EINVAL);
+	uso_packet(header, &uso, false, ETH_HLEN, 4000);
+	uso.metadata.request.gso_size = 1472;
+	KUNIT_EXPECT_EQ(test, xsk_tx_uso_validate(header, &uso, 1500), 0);
+	uso.metadata.request.gso_size++;
+	KUNIT_EXPECT_EQ(test, xsk_tx_uso_validate(header, &uso, 1500), -EINVAL);
+	/* A single datagram must fit the MTU as well. */
+	uso_packet(header, &uso, false, ETH_HLEN, 1473);
+	uso.metadata.request.gso_size = 4000;
+	KUNIT_EXPECT_EQ(test, xsk_tx_uso_validate(header, &uso, 1500), -EINVAL);
+}
+
+static void uso_header_layout(struct kunit *test)
+{
+	void *header = uso_header(test);
+	struct xsk_tx_uso_info uso;
+	struct udphdr *uh;
+	struct iphdr *iph;
+
+	/* IPv4 options are accepted when csum_start points past them. */
+	uso_packet(header, &uso, false, ETH_HLEN, 4000);
+	iph = header + uso.metadata.request.network_offset;
+	memmove(header + uso.metadata.request.csum_start + 4,
+		header + uso.metadata.request.csum_start, sizeof(*uh));
+	memset(header + uso.metadata.request.csum_start, 0, 4);
+	iph->ihl++;
+	iph->tot_len = htons(ntohs(iph->tot_len) + 4);
+	uso.metadata.request.csum_start += 4;
+	uso.header_len += 4;
+	uso.len += 4;
+	KUNIT_EXPECT_EQ(test, xsk_tx_uso_validate(header, &uso, 1500), 0);
+
+	/* The link layer is not parsed: the IP header is found at
+	 * network_offset whatever the EtherType says. Copy mode checks the
+	 * EtherType separately.
+	 */
+	uso_packet(header, &uso, false, ETH_HLEN + VLAN_HLEN, 4000);
+	((struct ethhdr *)header)->h_proto = htons(ETH_P_ARP);
+	KUNIT_EXPECT_EQ(test, xsk_tx_uso_validate(header, &uso, 1500), 0);
+	KUNIT_EXPECT_EQ(test, ntohs(uso.protocol), ETH_P_IP);
+
+	/* The IP version selects the protocol. */
+	uso_packet(header, &uso, false, ETH_HLEN, 4000);
+	((struct iphdr *)(header + ETH_HLEN))->version = 5;
+	KUNIT_EXPECT_EQ(test, xsk_tx_uso_validate(header, &uso, 1500),
+			-EPROTONOSUPPORT);
+}
+
+static void uso_prepare_headers(struct kunit *test)
+{
+	void *header = uso_header(test);
+	struct xsk_tx_uso_info uso;
+	int ipv6;
+
+	for (ipv6 = 0; ipv6 < 2; ipv6++) {
+		void *ip = header + ETH_HLEN;
+		struct udphdr *uh;
+		u32 udp_len;
+
+		uso_packet(header, &uso, ipv6, ETH_HLEN, 4000);
+		/* Start from a valid IPv4 checksum, so that clearing it shows. */
+		if (!ipv6) {
+			struct iphdr *iph = ip;
+
+			iph->check = ip_fast_csum(iph, iph->ihl);
+			KUNIT_ASSERT_NE(test, (__force u16)iph->check, 0);
+		}
+		KUNIT_ASSERT_EQ(test, xsk_tx_uso_validate(header, &uso, 1500), 0);
+		uh = header + uso.metadata.request.csum_start;
+		udp_len = uso.len - uso.metadata.request.csum_start;
+		uh->check = uso_pseudo_csum(header, &uso, ipv6, udp_len);
+
+		/* The seed must cover the pseudo header without the length. */
+		xsk_tx_uso_prepare_headers(&uso, header);
+		KUNIT_EXPECT_EQ_MSG(test, (__force u16)uh->check,
+				    (__force u16)uso_pseudo_csum(header, &uso, ipv6, 0),
+				    "ipv6 %d", ipv6);
+		if (ipv6) {
+			KUNIT_EXPECT_EQ(test,
+					ntohs(((struct ipv6hdr *)ip)->payload_len), 0);
+		} else {
+			KUNIT_EXPECT_EQ(test, ntohs(((struct iphdr *)ip)->tot_len), 0);
+			KUNIT_EXPECT_EQ(test,
+					(__force u16)((struct iphdr *)ip)->check, 0);
+		}
+	}
+}
+
+/* A single datagram uses ordinary checksum offload, so its headers stay. */
+static void uso_prepare_single(struct kunit *test)
+{
+	u8 *orig = kunit_kzalloc(test, XSK_TX_USO_MAX_HEADER, GFP_KERNEL);
+	void *header = uso_header(test);
+	struct xsk_tx_uso_info uso;
+	struct udphdr *uh;
+
+	KUNIT_ASSERT_NOT_NULL(test, orig);
+	uso_packet(header, &uso, false, ETH_HLEN, 1000);
+	KUNIT_ASSERT_EQ(test, xsk_tx_uso_validate(header, &uso, 1500), 0);
+	KUNIT_ASSERT_EQ(test, uso.gso_segs, 1);
+	uh = header + uso.metadata.request.csum_start;
+	uh->check = uso_pseudo_csum(header, &uso, false, ntohs(uh->len));
+	memcpy(orig, header, uso.header_len);
+	xsk_tx_uso_prepare_headers(&uso, header);
+	KUNIT_EXPECT_MEMEQ(test, header, orig, uso.header_len);
+}
+
+static void uso_metadata_flags(struct kunit *test)
+{
+	struct xsk_tx_metadata meta = {
+		.flags = XDP_TXMD_FLAGS_USO | XDP_TXMD_FLAGS_CHECKSUM,
+	};
+	struct xsk_buff_pool *pool;
+	u64 flags;
+
+	pool = kunit_kzalloc(test, sizeof(*pool), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, pool);
+	pool->tx_metadata_len = USO_META_LEN;
+	pool->tx_uso_supported = true;
+
+	KUNIT_ASSERT_TRUE(test, xsk_buff_valid_tx_metadata(pool, &meta, &flags));
+	KUNIT_EXPECT_TRUE(test, xsk_tx_uso_flags_valid(flags));
+
+	/* USO needs checksum offload and cannot report a Tx timestamp. */
+	meta.flags = XDP_TXMD_FLAGS_USO;
+	KUNIT_ASSERT_TRUE(test, xsk_buff_valid_tx_metadata(pool, &meta, &flags));
+	KUNIT_EXPECT_FALSE(test, xsk_tx_uso_flags_valid(flags));
+	meta.flags = XDP_TXMD_FLAGS_USO | XDP_TXMD_FLAGS_CHECKSUM |
+		     XDP_TXMD_FLAGS_TIMESTAMP;
+	KUNIT_ASSERT_TRUE(test, xsk_buff_valid_tx_metadata(pool, &meta, &flags));
+	KUNIT_EXPECT_FALSE(test, xsk_tx_uso_flags_valid(flags));
+
+	/* Launch time is allowed here; zero-copy rejects it when parsing. */
+	meta.flags = XDP_TXMD_FLAGS_USO | XDP_TXMD_FLAGS_CHECKSUM |
+		     XDP_TXMD_FLAGS_LAUNCH_TIME;
+	KUNIT_ASSERT_TRUE(test, xsk_buff_valid_tx_metadata(pool, &meta, &flags));
+	KUNIT_EXPECT_TRUE(test, xsk_tx_uso_flags_valid(flags));
+
+	/* USO requests are refused on pools that cannot carry them. */
+	meta.flags = XDP_TXMD_FLAGS_USO | XDP_TXMD_FLAGS_CHECKSUM;
+	pool->tx_uso_supported = false;
+	KUNIT_EXPECT_FALSE(test, xsk_buff_valid_tx_metadata(pool, &meta, &flags));
+	pool->tx_uso_supported = true;
+	pool->tx_metadata_len =
+		offsetofend(struct xsk_tx_metadata, request.network_offset) - 1;
+	KUNIT_EXPECT_FALSE(test, xsk_buff_valid_tx_metadata(pool, &meta, &flags));
+	pool->tx_metadata_len = USO_META_LEN;
+	meta.flags |= BIT_ULL(63);
+	KUNIT_EXPECT_FALSE(test, xsk_buff_valid_tx_metadata(pool, &meta, &flags));
+}
+
+struct uso_parse_ctx {
+	struct xsk_buff_pool *pool;
+	struct xdp_desc descs[2];
+	u32 nr;
+	struct xsk_tx_metadata meta;
+	struct xsk_tx_uso_info orig;
+	void *orig_header;
+	void *umem_header;
+};
+
+/* Place a packet with @payload bytes in a UMEM, split over two descriptors
+ * when it does not fit in the first 2048 bytes.
+ */
+static void uso_parse_init(struct kunit *test, struct uso_parse_ctx *ctx,
+			   u32 payload)
+{
+	struct xsk_buff_pool *pool;
+
+	memset(ctx, 0, sizeof(*ctx));
+	pool = kunit_kzalloc(test, sizeof(*pool), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, pool);
+	pool->netdev = kunit_kzalloc(test, sizeof(*pool->netdev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, pool->netdev);
+	pool->netdev->mtu = 1500;
+	pool->netdev->features = NETIF_F_GSO_UDP_L4;
+	pool->tx_metadata_len = USO_META_LEN;
+	pool->tx_uso_supported = true;
+	pool->addrs = kunit_kzalloc(test, 8192, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, pool->addrs);
+	ctx->pool = pool;
+	ctx->orig_header = uso_header(test);
+
+	uso_packet(ctx->orig_header, &ctx->orig, false, ETH_HLEN, payload);
+	ctx->nr = ctx->orig.len > 2048 ? 2 : 1;
+	ctx->descs[0] = (struct xdp_desc) {
+		.addr = 128, .len = min(ctx->orig.len, 2048U),
+		.options = XDP_TX_METADATA | (ctx->nr > 1 ? XDP_PKT_CONTD : 0),
+	};
+	ctx->descs[1] = (struct xdp_desc) {
+		.addr = 4096, .len = ctx->orig.len - ctx->descs[0].len,
+	};
+	ctx->meta = ctx->orig.metadata;
+	ctx->meta.flags = XDP_TXMD_FLAGS_USO | XDP_TXMD_FLAGS_CHECKSUM;
+	ctx->umem_header = pool->addrs + ctx->descs[0].addr;
+	memcpy(ctx->umem_header, ctx->orig_header, ctx->orig.header_len);
+}
+
+static struct uso_parse_ctx *uso_parse_ctx(struct kunit *test)
+{
+	struct uso_parse_ctx *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+	return ctx;
+}
+
+static int uso_parse(struct uso_parse_ctx *ctx, struct xsk_tx_uso_info *info,
+		     void *header)
+{
+	memcpy(ctx->umem_header - USO_META_LEN, &ctx->meta, USO_META_LEN);
+	return xsk_tx_uso_parse(ctx->pool, ctx->descs, ctx->nr, info, header);
+}
+
+static void uso_snapshot(struct kunit *test)
+{
+	struct uso_parse_ctx *ctx = uso_parse_ctx(test);
+	void *header = uso_header(test);
+	struct xsk_tx_uso_info info;
+	struct udphdr *uh;
+
+	uso_parse_init(test, ctx, 4000);
+	KUNIT_ASSERT_EQ(test, uso_parse(ctx, &info, header), 1);
+	KUNIT_EXPECT_EQ(test, info.len, ctx->orig.len);
+	KUNIT_EXPECT_EQ(test, info.header_len, ctx->orig.header_len);
+	KUNIT_EXPECT_EQ(test, info.gso_segs, 3);
+
+	/* Changes to the UMEM after parsing do not reach the copy. */
+	memset(ctx->umem_header - USO_META_LEN, 0xff,
+	       USO_META_LEN + ctx->orig.header_len);
+	KUNIT_EXPECT_MEMEQ(test, header, ctx->orig_header, ctx->orig.header_len);
+	KUNIT_EXPECT_EQ(test, info.metadata.request.gso_size, 1400);
+
+	/* Preparing the copy leaves the UMEM alone. */
+	xsk_tx_uso_prepare_headers(&info, header);
+	uh = header + info.metadata.request.csum_start;
+	KUNIT_EXPECT_EQ(test, ntohs(((struct iphdr *)(header + ETH_HLEN))->tot_len),
+			0);
+	KUNIT_EXPECT_EQ(test, ntohs(uh->len), 4008);
+	KUNIT_EXPECT_EQ(test, *(u8 *)ctx->umem_header, 0xff);
+}
+
+enum uso_parse_kind {
+	USO_PARSE_NO_GSO_SIZE,
+	USO_PARSE_GSO_BY_FRAGS,
+	USO_PARSE_NO_NETWORK_OFFSET,
+	USO_PARSE_CSUM_START,
+	USO_PARSE_CSUM_OFFSET,
+	USO_PARSE_SPLIT_HEADER,
+	USO_PARSE_EARLY_EOP,
+	USO_PARSE_NO_CSUM,
+	USO_PARSE_TIMESTAMP,
+	USO_PARSE_LAUNCH_TIME,
+	USO_PARSE_BAD_HEADER,
+};
+
+struct uso_parse_case {
+	const char *name;
+	enum uso_parse_kind kind;
+	int err;
+};
+
+static const struct uso_parse_case uso_parse_cases[] = {
+	{ "no_gso_size", USO_PARSE_NO_GSO_SIZE, -EINVAL },
+	{ "gso_by_frags", USO_PARSE_GSO_BY_FRAGS, -EINVAL },
+	{ "no_network_offset", USO_PARSE_NO_NETWORK_OFFSET, -EINVAL },
+	{ "csum_start_past_max_header", USO_PARSE_CSUM_START, -EINVAL },
+	{ "bad_csum_offset", USO_PARSE_CSUM_OFFSET, -EINVAL },
+	{ "header_split_over_buffers", USO_PARSE_SPLIT_HEADER, -EINVAL },
+	{ "early_end_of_packet", USO_PARSE_EARLY_EOP, -EINVAL },
+	{ "no_checksum_flag", USO_PARSE_NO_CSUM, -EOPNOTSUPP },
+	{ "timestamp_flag", USO_PARSE_TIMESTAMP, -EOPNOTSUPP },
+	{ "launch_time_flag", USO_PARSE_LAUNCH_TIME, -EOPNOTSUPP },
+	{ "invalid_header", USO_PARSE_BAD_HEADER, -EINVAL },
+};
+
+KUNIT_ARRAY_PARAM_DESC(uso_parse_invalid, uso_parse_cases, name);
+
+static void uso_parse_invalid(struct kunit *test)
+{
+	const struct uso_parse_case *param = test->param_value;
+	struct uso_parse_ctx *ctx = uso_parse_ctx(test);
+	void *header = uso_header(test);
+	struct xsk_tx_uso_info info;
+
+	uso_parse_init(test, ctx, 4000);
+	switch (param->kind) {
+	case USO_PARSE_NO_GSO_SIZE:
+		ctx->meta.request.gso_size = 0;
+		break;
+	case USO_PARSE_GSO_BY_FRAGS:
+		ctx->meta.request.gso_size = GSO_BY_FRAGS;
+		break;
+	case USO_PARSE_NO_NETWORK_OFFSET:
+		ctx->meta.request.network_offset = 0;
+		break;
+	case USO_PARSE_CSUM_START:
+		ctx->meta.request.csum_start = XSK_TX_USO_MAX_HEADER;
+		break;
+	case USO_PARSE_CSUM_OFFSET:
+		ctx->meta.request.csum_offset = 0;
+		break;
+	case USO_PARSE_SPLIT_HEADER:
+		/* All headers through UDP must be in the first buffer. */
+		ctx->descs[0].len = ctx->orig.header_len - 1;
+		ctx->descs[1].len = ctx->orig.len - ctx->descs[0].len;
+		break;
+	case USO_PARSE_EARLY_EOP:
+		/* Only the last descriptor may end the packet. */
+		ctx->descs[0].options &= ~XDP_PKT_CONTD;
+		break;
+	case USO_PARSE_NO_CSUM:
+		ctx->meta.flags = XDP_TXMD_FLAGS_USO;
+		break;
+	case USO_PARSE_TIMESTAMP:
+		ctx->meta.flags |= XDP_TXMD_FLAGS_TIMESTAMP;
+		break;
+	case USO_PARSE_LAUNCH_TIME:
+		ctx->meta.flags |= XDP_TXMD_FLAGS_LAUNCH_TIME;
+		break;
+	case USO_PARSE_BAD_HEADER:
+		((struct iphdr *)(ctx->umem_header + ETH_HLEN))->protocol =
+			IPPROTO_TCP;
+		break;
+	}
+	KUNIT_EXPECT_EQ(test, uso_parse(ctx, &info, header), param->err);
+}
+
+static void uso_parse_feature(struct kunit *test)
+{
+	struct uso_parse_ctx *ctx = uso_parse_ctx(test);
+	void *header = uso_header(test);
+	struct xsk_tx_uso_info info;
+
+	/* Segmentation follows NETIF_F_GSO_UDP_L4. */
+	uso_parse_init(test, ctx, 4000);
+	ctx->pool->netdev->features = 0;
+	KUNIT_EXPECT_EQ(test, uso_parse(ctx, &info, header), -EOPNOTSUPP);
+
+	/* A single datagram does not need it. */
+	uso_parse_init(test, ctx, 1000);
+	ctx->pool->netdev->features = 0;
+	KUNIT_EXPECT_EQ(test, uso_parse(ctx, &info, header), 1);
+	KUNIT_EXPECT_EQ(test, info.gso_segs, 1);
+}
+
+static void uso_parse_no_uso(struct kunit *test)
+{
+	struct uso_parse_ctx *ctx = uso_parse_ctx(test);
+	void *header = uso_header(test);
+	struct xsk_tx_uso_info info;
+
+	uso_parse_init(test, ctx, 4000);
+	ctx->meta.flags = XDP_TXMD_FLAGS_CHECKSUM;
+	KUNIT_EXPECT_EQ(test, uso_parse(ctx, &info, header), 0);
+	ctx->meta.flags = XDP_TXMD_FLAGS_USO | XDP_TXMD_FLAGS_CHECKSUM;
+	ctx->descs[0].options &= ~XDP_TX_METADATA;
+	KUNIT_EXPECT_EQ(test, uso_parse(ctx, &info, header), 0);
+}
+
+static struct kunit_case xsk_tx_uso_cases[] = {
+	KUNIT_CASE(uso_valid),
+	KUNIT_CASE_PARAM(uso_invalid, uso_invalid_gen_params),
+	KUNIT_CASE(uso_limits),
+	KUNIT_CASE(uso_header_layout),
+	KUNIT_CASE(uso_prepare_headers),
+	KUNIT_CASE(uso_prepare_single),
+	KUNIT_CASE(uso_metadata_flags),
+	KUNIT_CASE(uso_snapshot),
+	KUNIT_CASE_PARAM(uso_parse_invalid, uso_parse_invalid_gen_params),
+	KUNIT_CASE(uso_parse_feature),
+	KUNIT_CASE(uso_parse_no_uso),
+	{}
+};
+
+static struct kunit_suite xsk_tx_uso_suite = {
+	.name = "xsk_tx_uso",
+	.test_cases = xsk_tx_uso_cases,
+};
+
+kunit_test_suite(xsk_tx_uso_suite);
+MODULE_DESCRIPTION("KUnit tests for AF_XDP USO header helpers");
+MODULE_LICENSE("GPL");
-- 
2.38.1

