Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028C7606A32A
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 14:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=r7j4VLWF;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nktXgpeQ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D44C740AF6;
	Thu, 19 Nov 2026 14:11:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1lVMaW0F16Eb; Thu, 19 Nov 2026 14:11:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 872CF40AE0
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795097460;
	b=TeQysiLoi0SO5DI0VXWbMuwHF3JZ7E//gCNQYGyYsCNUdVm62PWyrq7TL7+PESfLwY/p
	 EtQtu8SDbz0AR1Z+RIegUdZrojT3fkoGi+/Kq3W1csirT8aGCgemiyCAamCqjHYnVKkKJ
	 PtE38LJw+NShAgeN06GmrRxVHNubzKoYMaSsoeg5CPjR6bbQ3zwNHLp/mYuhMHNn69Vcd
	 ZVNJJsd94XqJdHD71Lf0VgkkQ8CATBfE2+S/yxuGt47WjAlVN86/yOrcpgrhNCqjR+Xiv
	 FzLWREy108QKbQUGg2Bl7xjZHjv4rI48Ju3ISlH5IqLS+Jbr4VG6c4h2hJ0rGU80oMQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795097460;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6SvA+pkRBMRpq24NpX9HZNQOq8KgZn46Uhy234I9+b0=;
	b=qdQyh0LhJ+0cG7eWYng8TwOB+O1U1SRTqU+Gwry7NfkPaYhPTl6V7YPYJeWgNB4zlh2r
	 c6cxTde8cxq3i/TTp+2W5ImJ+mwlzqPO3dHucxRjNLa8gCbfqGUj0CQ/0B/PDk3RkhJNw
	 Es8D/vLprv3d0wtf8W85G2Wohh6PjVjJQdVnDfwf6yyQ+nX1RXpMEARKpkJ3J3Le7TpJe
	 Nib8ZgFU8fbXij8BlAYWRIc6PajG8KejClK+pv8dymUYEO7utiG/bCJFq0EHnZKA+qQJY
	 ThnT5PyInxtz86hfDFBDchCzb+t4VX/Jd8en0/i/u9EvfJGrLLC932qCYzy24QiuEvg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795097460;
	bh=6SvA+pkRBMRpq24NpX9HZNQOq8KgZn46Uhy234I9+b0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=r7j4VLWFTsBh51WL0Sp3DyCCwAF7HExsxaLmpDplOJT/t1pdGQtrbhm4+S7LDec9b
	 fxEkfFREWCjQ38wD3HbM0ESGa2WmElGN6wl7Fy//B088Jox6KPeKOCfDFYlmA2F8tk
	 3eHNGfG+rBFTxbuxxchCXeJy2MkIoJj1dvVecHMeWjbakrgKGXDK04Q3a1GTz0yFgK
	 8wvxudyeT9QmJ6Upr4LvK2NZxCF84BKa6jydYnW9BxpITLGz0Bp7TvDV8AHIsD0gBm
	 YXa9jVOAnkj0bqIvuBm65JRsKGqPk8LspecHE5o76fyhiXn1ejUvVhbIaN98tmF71t
	 ZPMAHpZoJGoeA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 872CF40AE0;
	Thu, 19 Nov 2026 14:11:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1FE7722B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 14:10:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0537940544
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 14:10:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CdOA8MrpVh19 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 14:10:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 83D5D40542
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=magnus.karlsson@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=nktXgpeQ
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 83D5D40542
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 14:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795097458; x=1826633458;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=UMw6ARRAFAVP+Ou5ERAkRodfC7ut/ARXjq2NLsx6cKo=;
 b=nktXgpeQpk1WMFAab8rnk4M1Mhg2981d1nrU/nO1NvLM1/0kDilmt7Gd
 Uf9QDzrz6qZCow5bp+RnqW3upHnsapJNR4bdEl0DZZKQ43HulRtjmgb7x
 jhT+nM6PRBSB3yzxro4TVG0wiwOV5Gur3rSkV3t9cb0meA5dINNtT7/6n
 VTgxbz52BREhAI92H1TR4/JAOeO/nZ83j30n0KfCRJ+c4NMUHFw/1i42A
 q7f5pHZxqeH3c56UeI5h0sYB7UUowavVnbYCT82E5Iup5nWmM09eWPkd5
 W7/cBeXcJ2uDhM1iAguXlhOh7ZBhKobXFdyifYRJKOSRw64orNkx/cORG g==;
X-CSE-ConnectionGUID: l90LHmwvT1OYhaqmyPR21Q==
X-CSE-MsgGUID: fK8cXD25S9+CjI9A3xdxYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3835316"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3835316"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 06:10:56 -0800
X-CSE-ConnectionGUID: SShlM7ndQIudLu51ITv1kQ==
X-CSE-MsgGUID: erbl2PUKQVuEIPIaAVHwow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; d="scan'208";a="10775460"
Received: from boxer.igk.intel.com ([10.102.20.173])
 by fmviesa006.fm.intel.com with ESMTP; 19 Nov 2026 06:10:52 -0800
From: Magnus Karlsson <magnus.karlsson@intel.com>
To: magnus.karlsson@intel.com, magnus.karlsson@gmail.com,
 maciej.fijalkowski@intel.com, sdf@fomichev.me, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bjorn@kernel.org, kerneljasonxing@gmail.com
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com
Subject: [PATCH net-next 0/5] xsk: ice: USO support for AF_XDP
Date: Thu, 19 Nov 2026 15:10:27 +0100
Message-Id: <20261119141032.1070446-1-magnus.karlsson@intel.com>
X-Mailer: git-send-email 2.38.1
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds UDP Segmentation Offload (USO) to AF_XDP. An
application submits one Ethernet frame holding a single IP and UDP
header followed by the aggregate UDP payload, and the device emits a
train of MTU-sized UDP datagrams. Patch 1 implements it for copy mode
(the skb path). Patch 2 is an ice preparation that adds Tx descriptor
builders, and patch 3 implements USO for zero-copy mode in the ice
driver.

AF_XDP never segments these packets itself: a request is rejected
unless the device offers USO. For the ice zero-copy path, the
segmentation is done in HW. In copy mode, the packet is passed
unsegmented to the bound device's driver, and as with UDP_SEGMENT
sockets, how the driver carries out the segmentation is up to it.
Stacked devices (VLAN, bonding, macvlan) forward the packet to a lower
device that may segment it in SW.

The design extends the existing Tx metadata support in AF_XDP. One new
flag, XDP_TXMD_FLAGS_USO, is added, and the reserved u32 in the request
part of struct xsk_tx_metadata is split into two u16 fields called
gso_size and network_offset. Zero-copy support is advertised through
the new tx-uso-zc netdev XSK feature.

network_offset is part of the uAPI because csum_start only locates L4,
while segmentation also needs the start of L3: the device rewrites the
IP header of every datagram and needs the L2 and L3 lengths, and on
the skb path it becomes the network header. With it, the kernel does
not need to understand the link layer, and the fields can be reused
later. Any future extension for tunnel segmentation would treat
network_offset as the outer L3 offset and csum_start as the inner L4
offset, adding only the outer L4 and inner L3 offsets.

To request USO, bind the socket in XDP_COPY mode, or in XDP_ZEROCOPY
mode on a driver advertising tx-uso-zc, and set XDP_TXMD_FLAGS_USO |
XDP_TXMD_FLAGS_CHECKSUM in the Tx metadata. Reserve at least 16 bytes
of metadata and set XDP_TX_METADATA on the first descriptor of the
packet.

Submit an Ethernet frame containing one IP header, one UDP header, and
the aggregate UDP payload. Set network_offset to the IP header offset,
csum_start to the UDP header offset, and csum_offset to the UDP
checksum field offset (6 bytes). Header offsets are measured from the
first descriptor's packet-data address, excluding metadata. Set
gso_size to the number of UDP payload bytes per output datagram,
excluding headers; the last datagram may of course be shorter.

USO is only available on Ethernet devices. IPv4 headers may carry
options but must not be fragmented. In IPv6, the UDP header must
directly follow the fixed header; extension headers are not supported.

The IP and UDP lengths must describe the aggregate packet. Initialize
the UDP checksum field with the partial pseudoheader checksum seed for
that packet. The device generates the per-datagram lengths and UDP
checksums and, for IPv4 segmentation, the IP header checksums. You must
supply a valid IPv4 header checksum as well, since a request that fits
in one datagram uses ordinary checksum offload without segmentation.

All headers through UDP must be in the first buffer. Multi-buffer
packets use XDP_USE_SG and XDP_PKT_CONTD, with metadata only on the
first descriptor. Each output IP packet must fit the device MTU, and
requests remain subject to the device's segmentation limits. Query
tx-udp-segmentation through ethtool to check whether skb UDP
segmentation offload is enabled.

USO cannot be combined with XDP_UMEM_TX_SW_CSUM or
XDP_TXMD_FLAGS_TIMESTAMP. Launch time can be combined with USO in copy
mode, but not in zero-copy mode as that has not been implemented on
ice or tested on any other device for that matter.

A USO request that is rejected is dropped: its buffers are completed
and counted in tx_invalid_descs. This is the only indication of the
failure, whatever its cause: invalid metadata or headers, the MTU,
segmentation limits, or a device without the offload. Errors in other
Tx metadata keep failing sendmsg() in copy mode, so the behaviour for
existing non-USO users is unchanged. Zero-copy drivers without
tx-uso-zc do not drop USO requests; they ignore the Tx metadata and
send the frame unsegmented and without offloads. ice behaves the same
way when it has fewer XDP Tx rings than CPUs, as queues then share XDP
Tx rings. This can be supported in a follow up patch series as it
would require quite some changes to the driver. Note that tx-uso-zc is
still reported in this case, since it is a static driver capability.

In both modes, requests that produce more than one datagram need
tx-udp-segmentation to be enabled; tx-uso-zc only reports driver
capability. In zero-copy mode, a packet may use at most
xdp-zc-max-segs descriptors, and ice specifically allows at most eight
buffers per output datagram, counting the copied header.

The header validator works on a raw header copy instead of an skb, so
that it can be shared by the skb and zero-copy paths. It lives in
net/xdp/xsk_tx_uso.c and include/net/xsk_tx_uso.h. In zero-copy mode,
ice copies the headers into kernel-owned memory before validating them
and handing them to the NIC, while the payload stays in the UMEM. I
tried finding an existing packet header validator that works on raw
buffers that could be reused, but I could not find one. Therefore this
small validator was added.

Testing was done on an ice NIC in loopback mode with a USO selftest,
in both copy and zero-copy mode. Patch 5 adds it as
selftests/net/xsk_uso. It checks the segment count, lengths, checksums
and payload of the received datagrams for IPv4 and IPv6, single and
multi-buffer requests, and that invalid requests are rejected. Patch 4
adds KUnit tests for the header validation helpers. Note that patch 5
should really be integrated into either xskxceiver or Stan's
xdp_hw_metadata tests. But as these are currently being modified to
fit into selftests/net and maybe even merged, I kept the USO tests
separate for now.

The tables below show the UDP packet rate achieved by a single socket
on my rather old 2.1 GHz Cascade Lake server with PCIe3, relative to
no offloads at 1472 bytes. Each request carries a UDP payload that is
segmented into 1472-byte datagrams, either in user space (no offloads,
so UDP checksum is also performed in SW using the kernel's
csum_partial() algorithm) or by the NIC (USO). The application and the
queue's interrupt are pinned to the same core, and the socket is
driven by preferred busy polling with napi_defer_hard_irqs=100 and
gro_flush_timeout=2000000, so there are virtually no device
interrupts. Each table's performance numbers are normalized to the
performance for 1472 byte packets with no offloads in that table.

SKB mode - write all packet data for each packet

+---------------+-------------+---------------+
| Payload bytes | No offloads | USO + HW csum |
+---------------+-------------+---------------+
|          1472 |       +0.0% |        +86.2% |
|          4416 |       +2.2% |       +192.1% |
|          7360 |       +2.6% |       +290.0% |
|         10304 |       +2.4% |       +301.5% |
|         13248 |       +2.4% |       +322.2% |
|         16192 |       +2.1% |       +355.6% |
+---------------+-------------+---------------+

SKB mode - write only headers for each packet

+---------------+-------------+---------------+
| Payload bytes | No offloads | USO + HW csum |
+---------------+-------------+---------------+
|          1472 |       +0.0% |        +88.7% |
|          4416 |       +2.3% |       +211.3% |
|          7360 |       +2.5% |       +342.0% |
|         10304 |       +2.6% |       +367.7% |
|         13248 |       +2.8% |       +394.1% |
|         16192 |       +2.8% |       +444.8% |
+---------------+-------------+---------------+

ZC mode - write all packet data for each packet

+---------------+-------------+---------------+
| Payload bytes | No offloads | USO + HW csum |
+---------------+-------------+---------------+
|          1472 |       +0.0% |       +185.6% |
|          4416 |       +4.1% |       +279.6% |
|          7360 |       +4.8% |       +332.1% |
|         10304 |       +4.4% |       +325.5% |
|         13248 |       +3.6% |       +333.4% |
|         16192 |       +3.5% |       +339.1% |
+---------------+-------------+---------------+

ZC mode - write only headers for each packet

+---------------+-------------+---------------+
| Payload bytes | No offloads | USO + HW csum |
+---------------+-------------+---------------+
|          1472 |       +0.0% |       +163.9% |
|          4416 |       +2.9% |       +260.0% |
|          7360 |       +3.1% |       +291.9% |
|         10304 |       +3.6% |       +303.9% |
|         13248 |       +4.2% |       +307.6% |
|         16192 |       +4.1% |       +315.8% |
+---------------+-------------+---------------+

At 1472 bytes the request fits in one datagram, so USO is not
segmenting anything and the gain comes from the checksum offload
alone. As soon as multiple UDP packets have to be produced on the
wire, USO becomes really beneficial.

For the zero-copy tests, my system seems to bottleneck at around 50
Gbps (about 4 Mpps) with 7K payloads or above. The board only has x8
lanes of PCIe3, though the slot is x16. In any case, there is a
benefit to USO even on this system.

Patch series:
1: Implements USO for skb path
2: Adds Tx descriptor builders and a header length check to ice
3: Implements USO for ice zero-copy driver
4: KUnit tests for the USO header helpers
5: selftests/net: AF_XDP USO functional test


Magnus Karlsson (5):
  xsk: add USO support for skb path
  ice: add Tx descriptor builders and header length check
  xsk: ice: add USO zero-copy support
  xsk: add KUnit tests for AF_XDP USO header helpers
  selftests: net: add AF_XDP USO test

 Documentation/netlink/specs/netdev.yaml       |   4 +
 Documentation/networking/xsk-tx-metadata.rst  | 124 +++
 MAINTAINERS                                   |   1 +
 drivers/net/ethernet/intel/ice/ice.h          |  10 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   2 +
 .../net/ethernet/intel/ice/ice_lan_tx_rx.h    |   1 +
 drivers/net/ethernet/intel/ice/ice_main.c     |  13 +-
 drivers/net/ethernet/intel/ice/ice_sf_eth.c   |   1 +
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  23 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  22 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h |  48 +
 drivers/net/ethernet/intel/ice/ice_xsk.c      | 502 ++++++++-
 drivers/net/ethernet/intel/ice/ice_xsk.h      |  13 +
 include/net/xdp_sock.h                        |   5 +
 include/net/xdp_sock_drv.h                    |  18 +
 include/net/xsk_buff_pool.h                   |   4 +
 include/net/xsk_tx_uso.h                      |  50 +
 include/uapi/linux/if_xdp.h                   |  14 +-
 include/uapi/linux/netdev.h                   |   3 +
 net/core/netdev-genl.c                        |   2 +
 net/xdp/.kunitconfig                          |   6 +
 net/xdp/Kconfig                               |  12 +
 net/xdp/Makefile                              |   2 +
 net/xdp/tests/xsk_tx_uso_kunit.c              | 620 ++++++++++++
 net/xdp/xsk.c                                 | 154 ++-
 net/xdp/xsk_buff_pool.c                       |   6 +
 net/xdp/xsk_queue.h                           |   6 +
 net/xdp/xsk_tx_uso.c                          | 174 ++++
 tools/include/uapi/linux/if_xdp.h             |  14 +-
 tools/include/uapi/linux/netdev.h             |   3 +
 tools/testing/selftests/net/.gitignore        |   1 +
 tools/testing/selftests/net/Makefile          |  10 +-
 tools/testing/selftests/net/xsk_uso.c         | 954 ++++++++++++++++++
 33 files changed, 2751 insertions(+), 71 deletions(-)
 create mode 100644 include/net/xsk_tx_uso.h
 create mode 100644 net/xdp/.kunitconfig
 create mode 100644 net/xdp/tests/xsk_tx_uso_kunit.c
 create mode 100644 net/xdp/xsk_tx_uso.c
 create mode 100644 tools/testing/selftests/net/xsk_uso.c

-- 
2.38.1

