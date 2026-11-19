Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6000606A32F
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 16:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=R3qXCHab;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ez7LCYet
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A627C40CE8;
	Thu, 19 Nov 2026 16:54:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2ges2lZE1K42; Thu, 19 Nov 2026 16:54:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A92FC40B39
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795107243;
	b=UZM9pNXKc3JrIFAtubkvdpmT9qmXRtNIqgcoEUgDj7VrOd1MUgjX6Zs6bzY2wzmcjOUr
	 QxRYu0Y13PJzAr+xsjGt0C4A2P0omrGWmVBUTfD+XtthsV4PESGV9Owe3OGAg98bGADLv
	 TYJnldXrwULCMeBZFeOW8HNZzDiOcOvipqGjyYiF5Zk7Ocint+NS9aTIZvIoWPvo+KA/h
	 US63a16kkESxm8Tw+XNYY6Ub/zmPSyKPNzAfpYkOMW4xOpT0kAXTBvy/qjV1zvOE/aHRr
	 v1157xm4LncAvVp13X6fWx+pXDWL9FPgIv52yFtBFgcyljTECzAJjtQt1wvyxU/55CA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795107243;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rEUO4Xnhlw5pZxAHra6X4FJbjw6YK4GH2E9iuAdvmBk=;
	b=JpQdlY1uUbGn0Qg22RN4EJb2LXZO/mMnNtFdUwiLBp3PBBLewe+NcszX7qRqIpvNirZg
	 8R0Yaf12cCGpfVfWtRVV+75Rk4InMm5FWh2CiLftbiCZwFR6jf5hEFQuwMchwpnnIYZt4
	 pz5b4yib3Md7/YBL0T2Fgm2RSDR5f4o+DqzsCRd7rkajlP+UD0+mg0dN6o1R0Enj6DBdV
	 b+3U9ZihMDHeSz/Mm8Gqhz42q2Kogce9gWjNHnzlhAYMv6Iat+UxueSqHcprxCQTH07hm
	 CSQBKfXqVo+TAj/gqd+SzLpCXDPvahyTTmo814CBAyar1IFeeWd5c5aLuqPbe4LZEkw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795107243;
	bh=rEUO4Xnhlw5pZxAHra6X4FJbjw6YK4GH2E9iuAdvmBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R3qXCHabVthOVSp25j1KgHQvkFPwx9rLPdKEOSjhqrI+Y69roofVckAxhMZtU3Wm8
	 p4UM8ENBslZ1AIEQ9U0efl99ymz3tbD7bkyqWembEOHCI6iBIGoPea7TzY/sMKBgVB
	 7ycKFsAiY86mskoiXrrqDBgGezWS06ODEwbX26uzn5jTKJSqAwttvI6EzLeSxX8ocS
	 EggbLw9ir6yOAY+jVUxJAJZFH9M9Fjjk3yanJpjcqliuJhvsYvguf379p1yK8265p6
	 lTLsZyXBHhxHi7JRDamPtceP5cMj+yzkkeWBt9pW9CbucirISftclLll/hP4HhxA1U
	 jTaDok6be+ZEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A92FC40B39;
	Thu, 19 Nov 2026 16:54:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 93D3B1C9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 16:54:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 854B28128B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 16:54:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ah7ndROWP1v6 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 16:54:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DE3D581106
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.21
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=magnus.karlsson@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ez7LCYet
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DE3D581106
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 16:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795107240; x=1826643240;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=O+NqIih+4FaYftDDkwzFH6qDPE+0B7GtbBlW4KfNad4=;
 b=ez7LCYetP05cszPwYdVd1F4svPRWelb/aerK5MjoTr8aM1qe+EQaLyM4
 VZk40IlRqR44HMUn/x6DWvI/IVLZ8hHvPVhnJdlApWd/mrbxV2sctHfMn
 1m6N6EOBTWzSpihR6p/XeQgKdHplgyXWWWIPsV/2dvITxGCZ4gyRMXnm1
 NKDiCE1FC4/cSL9nDiWAXAzv/DcHTrV+vrymUKl2HSye3lfUdE8GgNOr4
 CFy5keHaWdPhBbqH4O4YmDvkm8nm9FogshfwGadpja0tTBTEvKe8mKuTI
 DXM+VMPN8qn0w0YSrn5GuTOXvyPMsfR7+/20GyZ6T7YqL9xtNGtH2zn9y g==;
X-CSE-ConnectionGUID: QWP3yD8cQKmYaRYQJ4fctA==
X-CSE-MsgGUID: Do9m5askQF6L690TVU8vWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4045416"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="4045416"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 08:54:00 -0800
X-CSE-ConnectionGUID: 18ApFFbISyycU91uQ0V4fQ==
X-CSE-MsgGUID: Mwgs2JdaR9Sq/RF2nM/7ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; d="scan'208";a="10774904"
Received: from boxer.igk.intel.com ([10.102.20.173])
 by orviesa009.jf.intel.com with ESMTP; 19 Nov 2026 08:53:56 -0800
From: Magnus Karlsson <magnus.karlsson@intel.com>
To: netdev@vger.kernel.org, magnus.karlsson@intel.com,
 magnus.karlsson@gmail.com, maciej.fijalkowski@intel.com, sdf@fomichev.me,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, bjorn@kernel.org,
 kerneljasonxing@gmail.com
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com
Subject: [PATCH net-next 1/5] xsk: add USO support for skb path
Date: Thu, 19 Nov 2026 17:53:36 +0100
Message-Id: <20261119165340.1071525-2-magnus.karlsson@intel.com>
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

Add UDP Segmentation Offload (USO) to the AF_XDP Tx metadata interface
and implement it for copy mode. An application submits one Ethernet
frame holding a single IP and UDP header followed by the aggregate UDP
payload, and the device emits a train of MTU-sized UDP datagrams.

The uAPI adds the XDP_TXMD_FLAGS_USO flag and splits the reserved u32
in the request part of struct xsk_tx_metadata into two u16 fields:
gso_size, the UDP payload bytes per output datagram, and
network_offset, the IP header offset. USO requires
XDP_TXMD_FLAGS_CHECKSUM, with csum_start pointing at the UDP header,
csum_offset at its checksum field and the checksum field seeded with
the partial pseudoheader checksum of the aggregate packet. It cannot
be combined with XDP_TXMD_FLAGS_TIMESTAMP or
XDP_UMEM_TX_SW_CSUM. Launch time is supported and applies to the start
of the segmented packet.

The request is turned into a GSO skb of type SKB_GSO_UDP_L4. Before
transmission, the headers are validated. The link layer is not parsed:
the IP header starts at network_offset and its version selects
unfragmented IPv4 or IPv6 without extension headers, followed by UDP.
The IP and UDP lengths must describe the aggregate packet, every output
datagram must fit the MTU, and the number of segments is limited to
UDP_MAX_SEGMENTS. As skb drivers find L3 through the EtherType, the skb
path also requires the EtherType, after any VLAN tags, to lead to the
same IP header. A request that fits in one datagram is sent as an
ordinary checksum offload request.

network_offset is part of the uAPI because csum_start only locates L4,
while segmentation also needs the start of L3: the device rewrites the
IP header of every datagram and needs the L2 and L3 lengths, and on
the skb path it becomes the network header. With it, the kernel does
not need to understand the link layer, and the fields can be reused
later. Any future tunnel segmentation extension to the uAPI could then
treat network_offset as the outer L3 offset and csum_start as the
inner L4 offset, adding only the outer L4 and inner L3 offsets.

AF_XDP never segments these packets itself. A request that produces more
than one datagram is rejected unless the bound device advertises
NETIF_F_GSO_UDP_L4, and the GSO skb is passed to its driver unsegmented.
As with UDP_SEGMENT sockets, how the segmentation is carried out is up
to the driver. Stacked devices such as VLAN or bonding forward the
packet to a lower device that may segment it in software.

A new pool field, tx_uso_supported, records whether USO requests are
accepted on a pool. It is set only for Ethernet devices (ARPHRD_ETHER)
and is cleared when XDP_UMEM_TX_SW_CSUM is used.

A USO request that fails validation is dropped: its buffers are
completed and counted in tx_invalid_descs. Errors in other Tx metadata
keep failing sendmsg() and leave the descriptor on the Tx ring, so the
existing behaviour for non-USO requests is unchanged. A USO request
that cannot be processed for lack of memory is also left on the Tx
ring, and sendmsg() fails with -EAGAIN, unless part of it was already
released to user space, either by an earlier call or while peeking
further descriptors. That part may already have been reused, so the
request is then dropped.

The header validator works on a raw header copy instead of an skb, so
that the zero-copy path in a later patch can reuse it. It lives in
the new files net/xdp/xsk_tx_uso.c and include/net/xsk_tx_uso.h.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 Documentation/networking/xsk-tx-metadata.rst |  91 +++++++++++++
 MAINTAINERS                                  |   1 +
 include/net/xdp_sock_drv.h                   |  12 ++
 include/net/xsk_buff_pool.h                  |   4 +
 include/net/xsk_tx_uso.h                     |  30 +++++
 include/uapi/linux/if_xdp.h                  |  13 +-
 net/xdp/Makefile                             |   1 +
 net/xdp/xsk.c                                | 130 +++++++++++++++++--
 net/xdp/xsk_buff_pool.c                      |   4 +
 net/xdp/xsk_queue.h                          |   6 +
 net/xdp/xsk_tx_uso.c                         |  77 +++++++++++
 tools/include/uapi/linux/if_xdp.h            |  13 +-
 12 files changed, 371 insertions(+), 11 deletions(-)
 create mode 100644 include/net/xsk_tx_uso.h
 create mode 100644 net/xdp/xsk_tx_uso.c

diff --git a/Documentation/networking/xsk-tx-metadata.rst b/Documentation/networking/xsk-tx-metadata.rst
index ac15e5fddc6b..41cfc5482b15 100644
--- a/Documentation/networking/xsk-tx-metadata.rst
+++ b/Documentation/networking/xsk-tx-metadata.rst
@@ -55,6 +55,9 @@ The flags field enables the particular offload:
   packet for transmission at a pre-determined time called launch time. The
   value of launch time is indicated by ``request.launch_time`` field of
   ``struct xsk_tx_metadata``.
+- ``XDP_TXMD_FLAGS_USO``: requests UDP segmentation offload.
+  ``request.gso_size`` specifies UDP payload bytes per output datagram;
+  ``request.network_offset`` identifies the IP header.
 
 Besides the flags above, in order to trigger the offloads, the first
 packet's ``struct xdp_desc`` descriptor should set ``XDP_TX_METADATA``
@@ -70,6 +73,69 @@ In this case, when running in ``XDP_COPY`` mode, the TX checksum
 is calculated on the CPU. Do not enable this option in production because
 it will negatively affect performance.
 
+UDP Segmentation
+================
+
+To request UDP segmentation offload (USO), bind the socket in
+``XDP_COPY`` mode and set ``XDP_TXMD_FLAGS_USO | XDP_TXMD_FLAGS_CHECKSUM``
+in the Tx metadata. Reserve at least 16 bytes of metadata and set
+``XDP_TX_METADATA`` on the first descriptor of the packet.
+
+Submit an Ethernet frame containing one IP header, one UDP header, and the
+aggregate UDP payload. Set ``request.network_offset`` to the IP header
+offset, ``request.csum_start`` to the UDP header offset, and
+``request.csum_offset`` to the UDP checksum field offset (6 bytes).
+Header offsets are measured from the first descriptor's packet-data address,
+excluding metadata. Set ``request.gso_size`` to the number of UDP payload
+bytes per output datagram, excluding headers; the last datagram may be
+shorter.
+
+USO is only available on Ethernet devices. ``request.network_offset``
+locates the IP header, and its version selects IPv4 or IPv6. In copy mode,
+the EtherType, after up to six VLAN tags, must lead to the same IP header,
+since drivers rely on it. IPv4 headers may carry options but must not be
+fragmented. In IPv6, the UDP header must directly follow the fixed header;
+extension headers are not supported.
+
+The IP and UDP lengths must describe the aggregate packet. Initialize the
+UDP checksum field with the partial pseudoheader checksum seed for that
+packet. The device generates the per-datagram lengths and UDP checksums and,
+for IPv4 segmentation, the IP header checksums. Supply a valid IPv4 header
+checksum as well, since a request that fits in one datagram uses ordinary
+checksum offload without segmentation.
+
+All headers through UDP must be in the first buffer. Multi-buffer packets
+use ``XDP_USE_SG`` and ``XDP_PKT_CONTD``, with metadata only on the first
+descriptor. Each output IP packet must fit the device MTU, and requests
+remain subject to the device's segmentation limits. Query
+``tx-udp-segmentation`` through ethtool to check whether skb UDP segmentation
+offload is enabled.
+
+AF_XDP never segments the packet itself. In copy mode, a request that
+produces more than one datagram is rejected unless the bound device
+advertises UDP segmentation offload, and the packet is passed to its driver
+unsegmented. A request that fits in one datagram does not need the offload,
+so its success does not show that the device supports USO. As with
+``UDP_SEGMENT`` sockets, how the segmentation is carried out is up to the
+driver, which may build the per-datagram headers in software. Stacked
+devices such as VLAN, bonding, or macvlan advertise UDP segmentation
+regardless of the lower device and forward the packet through the lower
+device's qdisc, where it is segmented in software if the lower device lacks
+the offload.
+
+A USO request that is rejected is dropped: its buffers are returned
+through the completion ring and counted in the socket's ``tx_invalid_descs``
+statistic. This is the only indication of the failure, whatever its cause:
+invalid metadata or headers, the MTU, segmentation limits, or a device
+without the offload. A request that cannot be processed for lack of memory
+is instead left on the Tx ring, and ``sendmsg()`` fails with ``EAGAIN``,
+unless part of a multi-buffer request was already released to user space;
+it is then dropped. Errors in other Tx metadata also fail ``sendmsg()`` and
+leave the descriptor on the Tx ring.
+
+USO cannot be combined with ``XDP_UMEM_TX_SW_CSUM`` or
+``XDP_TXMD_FLAGS_TIMESTAMP``.
+
 Launch Time
 ===========
 
@@ -127,6 +193,31 @@ cycle time is set to 1 second, the horizon of the launch time ranges
 from 1 second to 2 seconds, depending on where the Qbv cycle is currently
 running.
 
+USO with launch time
+====================
+
+Add ``XDP_TXMD_FLAGS_LAUNCH_TIME`` to the USO and checksum flags and set
+``request.launch_time`` to schedule the segmented packet. This combination
+requires at least 24 bytes of Tx metadata.
+
+The launch time applies to the start of the segmented packet: the first
+output UDP datagram is scheduled, and subsequent datagrams follow according
+to the device's scheduling rules. This does not request per-datagram pacing
+or separate launch times.
+
+The skb path passes one unsegmented GSO skb and its launch time directly to
+the bound device's driver, bypassing that device's qdisc, including ETF.
+On stacked devices, the lower device's qdisc and software segmentation
+may still apply, as described above. The driver and selected queue
+must support UDP segmentation and launch time together. Separate support
+for either offload does not establish support for their combination.
+As with ordinary launch-time requests, drivers may ignore the time when
+scheduling is disabled or unsupported. Acceptance or Tx completion alone
+does not prove that a packet was transmitted at the requested time.
+
+The clock, queue configuration, and scheduling horizon requirements above
+also apply to USO launch-time requests.
+
 Querying Device Capabilities
 ============================
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 40bb77cbc6b0..9b5f6f307d53 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -30588,6 +30588,7 @@ F:	Documentation/networking/af_xdp.rst
 F:	include/net/netns/xdp.h
 F:	include/net/xdp_sock*
 F:	include/net/xsk_buff_pool.h
+F:	include/net/xsk_tx_uso.h
 F:	include/uapi/linux/if_xdp.h
 F:	include/uapi/linux/xdp_diag.h
 F:	net/xdp/
diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index a40ad3f90f13..6b5bb7b29f87 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -263,6 +263,7 @@ xsk_buff_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr, u32 options)
 		XDP_TXMD_FLAGS_TIMESTAMP | \
 		XDP_TXMD_FLAGS_CHECKSUM | \
 		XDP_TXMD_FLAGS_LAUNCH_TIME | \
+		XDP_TXMD_FLAGS_USO | \
 	0)
 
 static inline bool
@@ -270,6 +271,10 @@ xsk_buff_valid_tx_metadata(const struct xsk_buff_pool *pool,
 			   const struct xsk_tx_metadata *meta, u64 *flags)
 {
 	*flags = READ_ONCE(meta->flags);
+	if (*flags & XDP_TXMD_FLAGS_USO)
+		if (!pool->tx_uso_supported || pool->tx_metadata_len <
+		    offsetofend(struct xsk_tx_metadata, request.network_offset))
+			return false;
 	if (*flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
 		if (pool->tx_metadata_len <
 		    offsetofend(struct xsk_tx_metadata, request.launch_time))
@@ -277,6 +282,13 @@ xsk_buff_valid_tx_metadata(const struct xsk_buff_pool *pool,
 	return !(*flags & ~XDP_TXMD_FLAGS_VALID);
 }
 
+/* USO requires checksum offload and cannot report a Tx timestamp. */
+static inline bool xsk_tx_uso_flags_valid(u64 flags)
+{
+	return (flags & XDP_TXMD_FLAGS_CHECKSUM) &&
+	       !(flags & XDP_TXMD_FLAGS_TIMESTAMP);
+}
+
 /**
  *  xsk_tx_metadata_request - Evaluate AF_XDP TX metadata at submission
  *  and call appropriate xsk_tx_metadata_ops operation.
diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index 02e89350faf9..ea2ff3680efa 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -89,6 +89,10 @@ struct xsk_buff_pool {
 	bool uses_need_wakeup;
 	bool unaligned;
 	bool tx_sw_csum;
+	/* USO requests accepted: Ethernet device without SW checksum, and
+	 * driver support in zero-copy mode. Set when the pool is bound.
+	 */
+	bool tx_uso_supported;
 	void *addrs;
 	/* Mutual exclusion of the completion ring in the SKB mode.
 	 * Protect: NAPI TX thread and sendmsg error paths in the SKB
diff --git a/include/net/xsk_tx_uso.h b/include/net/xsk_tx_uso.h
new file mode 100644
index 000000000000..f23384077712
--- /dev/null
+++ b/include/net/xsk_tx_uso.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _NET_XSK_TX_USO_H
+#define _NET_XSK_TX_USO_H
+
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <net/xsk_buff_pool.h>
+
+/* Header offsets are relative to the start of the supplied Ethernet frame. */
+struct xsk_tx_uso_info {
+	struct xsk_tx_metadata metadata;
+	u32 len;
+	u16 header_len;
+	u16 gso_segs;
+	__be16 protocol;
+	u8 l4_protocol;
+};
+
+#ifdef CONFIG_XDP_SOCKETS
+int xsk_tx_uso_validate(const void *header, struct xsk_tx_uso_info *uso,
+			u32 mtu);
+#else
+static inline int
+xsk_tx_uso_validate(const void *header, struct xsk_tx_uso_info *uso, u32 mtu)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
+#endif
diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
index 50d67df78911..0f7ba4859218 100644
--- a/include/uapi/linux/if_xdp.h
+++ b/include/uapi/linux/if_xdp.h
@@ -134,6 +134,12 @@ struct xdp_options {
  */
 #define XDP_TXMD_FLAGS_LAUNCH_TIME		(1 << 2)
 
+/* Request UDP segmentation offload in XDP_COPY mode. Requires CHECKSUM.
+ * Segment size and IP header offset are in request.
+ * With LAUNCH_TIME, scheduling applies to the start of the segmented packet.
+ */
+#define XDP_TXMD_FLAGS_USO			(1 << 3)
+
 /* AF_XDP offloads request. 'request' union member is consumed by the driver
  * when the packet is being transmitted. 'completion' union member is
  * filled by the driver when the transmit completion arrives.
@@ -149,7 +155,12 @@ struct xsk_tx_metadata {
 			__u16 csum_start;
 			/* Offset from csum_start where checksum should be stored. */
 			__u16 csum_offset;
-			__u32 reserved;
+
+			/* XDP_TXMD_FLAGS_USO */
+			/* UDP payload bytes per output datagram. */
+			__u16 gso_size;
+			/* IP header offset from desc->addr. */
+			__u16 network_offset;
 
 			/* XDP_TXMD_FLAGS_LAUNCH_TIME */
 			/* Launch time in nanosecond against the PTP HW Clock */
diff --git a/net/xdp/Makefile b/net/xdp/Makefile
index 30cdc4315f42..b6109e0e5547 100644
--- a/net/xdp/Makefile
+++ b/net/xdp/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_XDP_SOCKETS) += xsk.o xdp_umem.o xsk_queue.o xskmap.o
 obj-$(CONFIG_XDP_SOCKETS) += xsk_buff_pool.o
+obj-$(CONFIG_XDP_SOCKETS) += xsk_tx_uso.o
 obj-$(CONFIG_XDP_SOCKETS_DIAG) += xsk_diag.o
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f22f9a2cdbbe..14be62b8de5f 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -11,6 +11,8 @@
 
 #define pr_fmt(fmt) "AF_XDP: %s: " fmt, __func__
 
+#include <linux/if_arp.h>
+#include <linux/if_vlan.h>
 #include <linux/if_xdp.h>
 #include <linux/init.h>
 #include <linux/sched/mm.h>
@@ -22,6 +24,7 @@
 #include <linux/net.h>
 #include <linux/netdevice.h>
 #include <linux/rculist.h>
+#include <linux/udp.h>
 #include <linux/uio.h>
 #include <linux/vmalloc.h>
 
@@ -31,6 +34,7 @@
 #include <net/netdev_lock.h>
 #include <net/netdev_rx_queue.h>
 #include <net/xdp.h>
+#include <net/xsk_tx_uso.h>
 
 #include "../core/dev.h"
 
@@ -986,12 +990,62 @@ static void xsk_drop_skb(struct sk_buff *skb)
 	xs->skb = NULL;
 }
 
+static int xsk_skb_uso(struct sk_buff *skb)
+{
+	struct xsk_tx_uso_info uso = {
+		.metadata.request = {
+			.gso_size = skb_shinfo(skb)->gso_size,
+			.csum_start = skb_transport_offset(skb),
+			.network_offset = skb_network_offset(skb),
+		},
+		.header_len = skb_transport_offset(skb) + sizeof(struct udphdr),
+		.len = skb->len,
+	};
+	int depth, err;
+
+	/* Best effort: a bond or team device can change type while the pool
+	 * is bound, also after this check.
+	 */
+	if (READ_ONCE(skb->dev->type) != ARPHRD_ETHER)
+		return -EINVAL;
+	if (!pskb_may_pull(skb, uso.header_len))
+		return -ENOMEM;
+
+	err = xsk_tx_uso_validate(skb->data, &uso, READ_ONCE(skb->dev->mtu));
+	if (err)
+		return err;
+
+	skb_reset_mac_header(skb);
+	skb->protocol = eth_hdr(skb)->h_proto;
+	/* skb drivers find L3 through the EtherType and VLAN tags. Parse them
+	 * from the end of the Ethernet header, not from network_offset.
+	 */
+	skb->mac_len = ETH_HLEN;
+	if (__vlan_get_protocol(skb, skb->protocol, &depth) != uso.protocol ||
+	    depth != skb_network_offset(skb))
+		return -EINVAL;
+	skb_reset_mac_len(skb);
+	if (uso.gso_segs == 1) {
+		skb_gso_reset(skb);
+		return 0;
+	}
+
+	skb_shinfo(skb)->gso_segs = uso.gso_segs;
+	if (netif_needs_gso(skb, netif_skb_features(skb)))
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+/* A failed USO request returns -EOVERFLOW, so that the packet is dropped. Other
+ * metadata errors are returned to user space.
+ */
 static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 			    struct xdp_desc *desc, struct xsk_buff_pool *pool,
 			    u32 hr)
 {
 	struct xsk_tx_metadata *meta = NULL;
-	u16 csum_start, csum_offset;
+	int err = -EINVAL;
 	u64 flags;
 
 	if (unlikely(pool->tx_metadata_len == 0))
@@ -999,18 +1053,43 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 
 	meta = buffer - pool->tx_metadata_len;
 	if (unlikely(!xsk_buff_valid_tx_metadata(pool, meta, &flags)))
-		return -EINVAL;
+		goto err;
+
+	if (flags & XDP_TXMD_FLAGS_USO) {
+		u16 nhoff = READ_ONCE(meta->request.network_offset);
+		u16 offset = READ_ONCE(meta->request.csum_offset);
+		u16 thoff = READ_ONCE(meta->request.csum_start);
+		u16 size = READ_ONCE(meta->request.gso_size);
+
+		if (!xsk_tx_uso_flags_valid(flags))
+			goto err;
+		if (!size || size == GSO_BY_FRAGS ||
+		    nhoff < ETH_HLEN || thoff < nhoff ||
+		    thoff + sizeof(struct udphdr) > desc->len ||
+		    offset != offsetof(struct udphdr, check) ||
+		    hr + thoff >= U16_MAX)
+			goto err;
+
+		skb_set_network_header(skb, nhoff);
+		skb_set_transport_header(skb, thoff);
+		skb_shinfo(skb)->gso_size = size;
+		skb_shinfo(skb)->gso_type = SKB_GSO_UDP_L4;
+	}
 
 	if (flags & XDP_TXMD_FLAGS_CHECKSUM) {
-		csum_start = READ_ONCE(meta->request.csum_start);
-		csum_offset = READ_ONCE(meta->request.csum_offset);
+		if (flags & XDP_TXMD_FLAGS_USO) {
+			skb->csum_start = skb_transport_offset(skb);
+			skb->csum_offset = offsetof(struct udphdr, check);
+		} else {
+			skb->csum_start = READ_ONCE(meta->request.csum_start);
+			skb->csum_offset = READ_ONCE(meta->request.csum_offset);
+		}
 
-		if (unlikely(csum_start + csum_offset +
+		if (unlikely(skb->csum_start + skb->csum_offset +
 			     sizeof(__sum16) > desc->len))
-			return -EINVAL;
+			goto err;
 
-		skb->csum_start = hr + csum_start;
-		skb->csum_offset = csum_offset;
+		skb->csum_start += hr;
 		skb->ip_summed = CHECKSUM_PARTIAL;
 	}
 
@@ -1021,6 +1100,9 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 	xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
 
 	return 0;
+
+err:
+	return flags & XDP_TXMD_FLAGS_USO ? -EOVERFLOW : err;
 }
 
 static int xsk_skb_sw_csum(struct sk_buff *skb, struct xsk_buff_pool *pool)
@@ -1108,6 +1190,10 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 	return skb;
 }
 
+/* On -EOVERFLOW, the packet was dropped and its descriptors were consumed and
+ * completed as invalid. Other errors leave the descriptor on the Tx ring for
+ * the application to retry.
+ */
 static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 				     struct xdp_desc *desc)
 {
@@ -1196,13 +1282,17 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 	if (skb && !xs->skb)
 		kfree_skb(skb);
 
+	/* Too many descriptors and invalid USO requests drop the packet. Only
+	 * the latter can fail on the first descriptor, which is completed
+	 * here. Other errors are returned so that the application can retry.
+	 */
 	if (err == -EOVERFLOW) {
 		if (xs->skb) {
 			/* Drop the packet */
 			xsk_inc_num_desc(xs->skb);
 			xsk_drop_skb(xs->skb);
 		} else {
-			xsk_cq_cancel_locked(xs->pool, 1);
+			xsk_cq_submit_addr_single_locked(xs->pool, desc);
 			xs->tx->invalid_descs++;
 		}
 		xskq_cons_release(xs->tx);
@@ -1279,6 +1369,28 @@ static int __xsk_generic_xmit(struct sock *sk)
 			continue;
 		}
 
+		if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) {
+			err = xsk_skb_uso(skb);
+			/* Descriptors already released to user space may be
+			 * reused, so the packet can only be put back if none
+			 * of them has been released. Otherwise it is dropped.
+			 */
+			if (err == -ENOMEM &&
+			    xskq_cons_nb_unreleased(xs->tx) >=
+			    xsk_get_num_desc(skb)) {
+				/* Tell user-space to retry the send */
+				xskq_cons_cancel_n(xs->tx, xsk_get_num_desc(skb));
+				xsk_consume_skb(skb);
+				err = -EAGAIN;
+				goto out;
+			}
+			if (err) {
+				xsk_drop_skb(skb);
+				err = 0;
+				continue;
+			}
+		}
+
 		err = xsk_skb_sw_csum(skb, xs->pool);
 		if (unlikely(err)) {
 			xsk_drop_skb(skb);
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 5ec092f7cb6f..e62f3c2b3362 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/if_arp.h>
 #include <linux/netdevice.h>
 #include <net/netdev_lock.h>
 #include <net/xsk_buff_pool.h>
@@ -192,6 +193,8 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 	err = xsk_reg_pool_at_qid(netdev, pool, queue_id);
 	if (err)
 		return err;
+	pool->tx_uso_supported = !pool->tx_sw_csum &&
+				 netdev->type == ARPHRD_ETHER;
 
 	if (mbuf)
 		pool->umem->flags |= XDP_UMEM_SG_FLAG;
@@ -260,6 +263,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 		goto err_unreg_xsk;
 	}
 	pool->umem->zc = true;
+	pool->tx_uso_supported = false;
 	pool->xdp_zc_max_segs = netdev->xdp_zc_max_segs;
 	return 0;
 
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 1bc42c8902f4..182cd1cccb74 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -390,6 +390,12 @@ static inline void xskq_cons_release(struct xsk_queue *q)
 	q->cached_cons++;
 }
 
+/* Entries consumed locally but not yet released to the producer. */
+static inline u32 xskq_cons_nb_unreleased(struct xsk_queue *q)
+{
+	return q->cached_cons - q->ring->consumer;
+}
+
 static inline void xskq_cons_cancel_n(struct xsk_queue *q, u32 cnt)
 {
 	q->cached_cons -= cnt;
diff --git a/net/xdp/xsk_tx_uso.c b/net/xdp/xsk_tx_uso.c
new file mode 100644
index 000000000000..a7313ade1092
--- /dev/null
+++ b/net/xdp/xsk_tx_uso.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <net/ip.h>
+#include <net/ipv6.h>
+#include <net/udp.h>
+#include <net/xsk_tx_uso.h>
+
+/**
+ * xsk_tx_uso_validate - validate a kernel-owned plain UDP header
+ * @header: kernel-owned buffer containing at least uso->header_len bytes
+ * @uso: packet length and metadata offsets; receives protocol and segment count
+ * @mtu: maximum output IP packet length
+ *
+ * The link-layer header is not parsed. The IP header starts at network_offset
+ * and its version selects IPv4 or IPv6. The caller must provide a nonzero
+ * gso_size other than GSO_BY_FRAGS and header_len equal to transport_offset
+ * plus the UDP header size.
+ *
+ * Return: zero on success or a negative error code.
+ */
+int xsk_tx_uso_validate(const void *header, struct xsk_tx_uso_info *uso,
+			u32 mtu)
+{
+	const struct xsk_tx_metadata *meta = &uso->metadata;
+	u32 nhoff = meta->request.network_offset;
+	u32 thoff = meta->request.csum_start;
+	u32 udp_len, payload_len, network_len;
+	const struct udphdr *uh;
+	__be16 protocol;
+
+	if (nhoff < ETH_HLEN || thoff <= nhoff || uso->header_len < thoff ||
+	    uso->len < uso->header_len)
+		return -EINVAL;
+
+	network_len = uso->len - nhoff;
+	switch (((const struct iphdr *)(header + nhoff))->version) {
+	case 4: {
+		const struct iphdr *iph = header + nhoff;
+
+		if (thoff - nhoff < sizeof(*iph) ||
+		    iph->ihl < 5 || iph->ihl * 4 != thoff - nhoff ||
+		    ip_is_fragment(iph) ||
+		    ntohs(iph->tot_len) != network_len)
+			return -EINVAL;
+		protocol = htons(ETH_P_IP);
+		uso->l4_protocol = iph->protocol;
+		break;
+	}
+	case 6: {
+		const struct ipv6hdr *ip6h = header + nhoff;
+
+		if (thoff - nhoff != sizeof(*ip6h) ||
+		    ntohs(ip6h->payload_len) != network_len - sizeof(*ip6h))
+			return -EINVAL;
+		protocol = htons(ETH_P_IPV6);
+		uso->l4_protocol = ip6h->nexthdr;
+		break;
+	}
+	default:
+		return -EPROTONOSUPPORT;
+	}
+	uso->protocol = protocol;
+	udp_len = uso->len - thoff;
+	uh = header + thoff;
+	if (uso->l4_protocol != IPPROTO_UDP || udp_len > U16_MAX ||
+	    ntohs(uh->len) != udp_len)
+		return -EINVAL;
+	payload_len = udp_len - sizeof(*uh);
+	if (payload_len > meta->request.gso_size * UDP_MAX_SEGMENTS ||
+	    uso->header_len - nhoff +
+	    min_t(u32, payload_len, meta->request.gso_size) > mtu)
+		return -EINVAL;
+
+	uso->gso_segs = max_t(u32, 1, DIV_ROUND_UP(payload_len,
+						   meta->request.gso_size));
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xsk_tx_uso_validate);
diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
index 50d67df78911..0f7ba4859218 100644
--- a/tools/include/uapi/linux/if_xdp.h
+++ b/tools/include/uapi/linux/if_xdp.h
@@ -134,6 +134,12 @@ struct xdp_options {
  */
 #define XDP_TXMD_FLAGS_LAUNCH_TIME		(1 << 2)
 
+/* Request UDP segmentation offload in XDP_COPY mode. Requires CHECKSUM.
+ * Segment size and IP header offset are in request.
+ * With LAUNCH_TIME, scheduling applies to the start of the segmented packet.
+ */
+#define XDP_TXMD_FLAGS_USO			(1 << 3)
+
 /* AF_XDP offloads request. 'request' union member is consumed by the driver
  * when the packet is being transmitted. 'completion' union member is
  * filled by the driver when the transmit completion arrives.
@@ -149,7 +155,12 @@ struct xsk_tx_metadata {
 			__u16 csum_start;
 			/* Offset from csum_start where checksum should be stored. */
 			__u16 csum_offset;
-			__u32 reserved;
+
+			/* XDP_TXMD_FLAGS_USO */
+			/* UDP payload bytes per output datagram. */
+			__u16 gso_size;
+			/* IP header offset from desc->addr. */
+			__u16 network_offset;
 
 			/* XDP_TXMD_FLAGS_LAUNCH_TIME */
 			/* Launch time in nanosecond against the PTP HW Clock */
-- 
2.38.1

