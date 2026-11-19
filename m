Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE39760A2621
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 16:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=K62PThvK;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Vooc/QVU
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 977E440D20;
	Thu, 19 Nov 2026 16:54:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SwmJQH2TEWLO; Thu, 19 Nov 2026 16:54:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C67B940CBC
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795107252;
	b=oeZUUSjdoreHW6O3KIgn++LNoypiaNf5G+EXSCU8MDs/uubXdaxBILrXess4jDzuJ/T1
	 oWTObiWrF0ybL5p+VeGV0k+tQz7Pu0qQuzXLHw3wYR9dL2K4sMdLdd9/yKDANFW1JGW9F
	 HBwr/rz7kNMGcuZM82o5TbDIpeZ3Zn6Z6lN5074LXu7v4d62YC66DzkADFo5GwxWEUWk3
	 acN4CwLcfVlmtL5xM4czgCswsA8pv47M9Rmb4COnFDgI0Fl6AkI+Y2CU+B9ySGka+85oS
	 3qRedq/qFC1dKOWSDsZhXTshnbpaVdN1/6AMB+slZwgbXKsiSTA+qezO8Usdd05DZgw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795107252;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=V0Hk/TSxfMVkrw1lhJpdCzSPNOSdzdWJTn3W+vxXF48=;
	b=qbrEAVdZpuphcxdgUIVFNoIuod3j6oTKopIYMnomhlvQhDfR0jSnh1FXxFp/9AK7Qp92
	 S6tqpp3/g61ChWp6mhJeUAByQwCakZsMuoWrWnFRUZjLlVxA3TZyDvvpKmPh7v9JkXqni
	 lnnDPQDK6XHhGwP/xAOLzQIge4eLEzLf3ijT87CiJgzAVIH3kmX7zfUeR3xiqlWaqw1b0
	 sWRo1ppW/5mG8tbqgzq5/FqB9EjS2z8qEEiDtW6lFdeaa9jUCfrY+95a2QVSnzboHDf87
	 vcBiai+z3tZnEG+9cLaoD7FwZU5r3T1iqRiUWISXkETs71fnxY/NrExRgDVCfASz1ZQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795107252;
	bh=V0Hk/TSxfMVkrw1lhJpdCzSPNOSdzdWJTn3W+vxXF48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K62PThvKJ7iv1TKSnPQJsr8DbXOt2obm79FkjS1SxV3HzvzGDRLxqMbEQ9bqXdPQO
	 +kZ9GZUWu4KubA+o9TBCJEfLMNb0deCWnfq6rH50nX1lnpaAvY9ho3XqxOmeYkLWNF
	 mrOP60C+AzsAnu4EvcIUlyW6khNrAjB1JUyamVGOqZlyryHv6jLasNdEVd9/C1DPK+
	 COLm5ZdwLb2e4vkqIk30DwtCdaqYT6MUxBAmzowsW+C5nGNDua1jJD4V17ISWSr4w0
	 IW7slaUdEVfSUhdKE3HqgQdKsahtwlmZXP38GRJh0AmidIA0zoGeUGwM3DLYLFAtVA
	 Z++o47LXqZCKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C67B940CBC;
	Thu, 19 Nov 2026 16:54:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E02C1C9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 16:54:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 53FCF8136F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 16:54:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OYbONKwjtVz6 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 16:54:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9B5FF8110A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.21
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=magnus.karlsson@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Vooc/QVU
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9B5FF8110A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 16:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795107248; x=1826643248;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LujYkeQASlQaohVAn1x10vbEebixklnvFIlFkKAmE/0=;
 b=Vooc/QVU6dv1dl1mcH0BFWBOw0IW/F9RPXHT1hIYK9Ys+Xx3NzYk/JG0
 NfxRyn4dgZa4fpF9/cJTjI1pqQ1q8ulpH0cZD4zU3mjEd7ChvbKEvlRTV
 m13Bc3XOjihPr4RQiR9wqrgmMe1IboAXLXjUADGRUbCOpJ8Chx+bsDDG4
 Y3pV+e93i/YNOxfQvu8S+w0tddnmAmHPIMHH6tSfYXgMth9WQbnfg2kwG
 Yh2H3IufIlAVoFWRnBX8rZLmvTazGk8ZRQ2gfghDBE5tm4OvZy86H5VO8
 0SoPjnpSot2oY4q9MOY3YExUUZtuKdSOXlRuxEbs+alQ6z4Ox77MZjnE3 A==;
X-CSE-ConnectionGUID: MGSIM1NITV+WlOd5CP9G1A==
X-CSE-MsgGUID: oleP90eCS5W4fUdQls0dnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4045446"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="4045446"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 08:54:07 -0800
X-CSE-ConnectionGUID: JcjhNrMPRX2OFljOqYP3Sg==
X-CSE-MsgGUID: zDRWNE1WR5eG08qiLrEjfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; d="scan'208";a="10774971"
Received: from boxer.igk.intel.com ([10.102.20.173])
 by orviesa009.jf.intel.com with ESMTP; 19 Nov 2026 08:54:04 -0800
From: Magnus Karlsson <magnus.karlsson@intel.com>
To: netdev@vger.kernel.org, magnus.karlsson@intel.com,
 magnus.karlsson@gmail.com, maciej.fijalkowski@intel.com, sdf@fomichev.me,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, bjorn@kernel.org,
 kerneljasonxing@gmail.com
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com
Subject: [PATCH net-next 3/5] xsk: ice: add USO zero-copy support
Date: Thu, 19 Nov 2026 17:53:38 +0100
Message-Id: <20261119165340.1071525-4-magnus.karlsson@intel.com>
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

Add UDP Segmentation Offload (USO) for AF_XDP zero-copy and implement
it in the ice driver. Drivers advertise support with tmo_supports_uso,
which is reported to user space as the tx-uso-zc netdev XSK feature.

The core exports xsk_tx_uso_parse() and xsk_tx_uso_prepare_headers() for
drivers, which snapshot, validate and prepare the packet header, and
xsk_tx_invalid_descs() for accounting dropped requests. Drivers without
tmo_supports_uso keep handling a USO request as invalid metadata, so
xsk_tx_metadata_request() ignores the packet's metadata. As in copy
mode, requests that produce more than one datagram also need
NETIF_F_GSO_UDP_L4 on the device.

Packet headers are copied into kernel-owned memory before they are
validated and handed to the NIC, so that user space cannot change them
afterwards. ice keeps a DMA-mapped header slot for every two
descriptors of the XDP Tx ring, as a USO packet takes at least a
context and a header descriptor. The slots hold only header bytes and
are allocated page by page to avoid a large contiguous
allocation. They belong to the ring: they are allocated when a pool
that can carry USO requests is assigned to the ring, and freed with
the ring. They therefore follow XDP attach and detach, ring rebuilds
and netdev unregistration rather than the pool. Only the copied header
bytes are synced for the device. With fewer XDP rings than CPUs,
queues share XDP rings and would share their slots, so no slots are
allocated and USO requests are ignored for now, though support for
this could be added as a separate patch set in the future. tx-uso-zc
is still reported in this case, as documented. The slots are only
set up when an XDP program is attached. If they cannot be allocated
when a ring is reconfigured, the ring keeps its pool without USO and a
warning is logged, while a bind fails.

When the slots exist, ice_xmit_zc() processes descriptors one packet
at a time. A USO packet gets a context and a header descriptor, then
shares the data-descriptor loop with ordinary packets. The Tx budget
reserves worst-case descriptors per packet. The per-packet path is used
for every pool with a Tx metadata area that can carry USO requests,
whether or not it sends them. Other pools keep the existing batched
fast path. Both paths share the budget, tail, stats and wakeup
handling. If the Tx ring cannot hold a maximum-size packet in this
worst case, such a packet could never be peeked and Tx would stall, so
no header slots are allocated, USO requests are ignored and a warning
is logged. The pool flag is not cleared, as the pool may still fall
back to copy mode. This is only possible when PAGE_SIZE is 64K and the
Tx ring is set to its minimum size.

Packets that exceed the hardware limits are dropped and counted in
tx_invalid_descs through the new xsk_tx_invalid_descs() helper. Their
completions are deferred behind in-flight descriptors to keep the
completion ring in order. Packets without USO are dropped as well if
they would exceed the eight buffers, which is possible when chunks
larger than a data descriptor are split. A batch from the shared-umem
fallback can end inside a packet. That packet is dropped, and so is
its remainder in the next batch.

On completion, a buffer of the existing fast path still stands for one
completion, so that path writes nothing to tx_buf[] and struct
ice_tx_buf keeps its size. Buffers of the USO path carry an explicit
completion count in a union with fields that zero-copy rings do not use.
USO header slots, deferred drops and buffers split into several
descriptors are tracked with a per-ring counter, so ordinary traffic
keeps the fast cleanup path. The header slot of a context descriptor is
found from its position in the ring.

The descriptors are built with the descriptor builders that the
previous patch added for ice_tso().

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 Documentation/netlink/specs/netdev.yaml       |   4 +
 Documentation/networking/xsk-tx-metadata.rst  |  47 +-
 drivers/net/ethernet/intel/ice/ice.h          |  10 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   2 +
 .../net/ethernet/intel/ice/ice_lan_tx_rx.h    |   1 +
 drivers/net/ethernet/intel/ice/ice_main.c     |   1 +
 drivers/net/ethernet/intel/ice/ice_sf_eth.c   |   1 +
 drivers/net/ethernet/intel/ice/ice_txrx.c     |   3 +
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  22 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c      | 502 ++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_xsk.h      |  13 +
 include/net/xdp_sock.h                        |   5 +
 include/net/xdp_sock_drv.h                    |   6 +
 include/net/xsk_tx_uso.h                      |  20 +
 include/uapi/linux/if_xdp.h                   |   5 +-
 include/uapi/linux/netdev.h                   |   3 +
 net/core/netdev-genl.c                        |   2 +
 net/xdp/xsk.c                                 |  24 +
 net/xdp/xsk_buff_pool.c                       |   4 +-
 net/xdp/xsk_tx_uso.c                          |  97 ++++
 tools/include/uapi/linux/if_xdp.h             |   5 +-
 tools/include/uapi/linux/netdev.h             |   3 +
 22 files changed, 729 insertions(+), 51 deletions(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 0de7f93f0c4c..a19512be1798 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -85,6 +85,10 @@ definitions:
         name: tx-launch-time-fifo
         doc: >-
           Launch time HW offload is supported by the driver.
+      -
+        name: tx-uso-zc
+        doc: >-
+          UDP segmentation HW offload is supported for AF_XDP zero-copy.
   -
     name: queue-type
     type: enum
diff --git a/Documentation/networking/xsk-tx-metadata.rst b/Documentation/networking/xsk-tx-metadata.rst
index 41cfc5482b15..1f44fcce3e3d 100644
--- a/Documentation/networking/xsk-tx-metadata.rst
+++ b/Documentation/networking/xsk-tx-metadata.rst
@@ -77,7 +77,8 @@ UDP Segmentation
 ================
 
 To request UDP segmentation offload (USO), bind the socket in
-``XDP_COPY`` mode and set ``XDP_TXMD_FLAGS_USO | XDP_TXMD_FLAGS_CHECKSUM``
+``XDP_COPY`` mode, or ``XDP_ZEROCOPY`` mode on a supporting driver, and set
+``XDP_TXMD_FLAGS_USO | XDP_TXMD_FLAGS_CHECKSUM``
 in the Tx metadata. Reserve at least 16 bytes of metadata and set
 ``XDP_TX_METADATA`` on the first descriptor of the packet.
 
@@ -127,15 +128,33 @@ A USO request that is rejected is dropped: its buffers are returned
 through the completion ring and counted in the socket's ``tx_invalid_descs``
 statistic. This is the only indication of the failure, whatever its cause:
 invalid metadata or headers, the MTU, segmentation limits, or a device
-without the offload. A request that cannot be processed for lack of memory
-is instead left on the Tx ring, and ``sendmsg()`` fails with ``EAGAIN``,
-unless part of a multi-buffer request was already released to user space;
-it is then dropped. Errors in other Tx metadata also fail ``sendmsg()`` and
-leave the descriptor on the Tx ring.
+without the offload. In zero-copy mode, dropped requests are only counted
+when a single socket transmits on the UMEM. In copy mode, a request that
+cannot be processed for lack of memory is instead left on the Tx ring, and
+``sendmsg()`` fails with ``EAGAIN``, unless part of a multi-buffer request
+was already released to user space; it is then dropped. Errors in other Tx
+metadata also fail ``sendmsg()`` and leave the descriptor on the Tx ring.
 
 USO cannot be combined with ``XDP_UMEM_TX_SW_CSUM`` or
 ``XDP_TXMD_FLAGS_TIMESTAMP``.
 
+For zero-copy mode, query ``tx-uso-zc`` through the netdev netlink interface
+before submitting requests. Supporting drivers copy headers into
+kernel-owned memory for validation and hardware preparation while leaving
+payload bytes in UMEM. The link-layer header before
+``request.network_offset`` is not checked against the IP header and is sent
+as is. Completion returns each submitted buffer address once, regardless of
+the number of generated datagrams. Zero-copy drivers without ``tx-uso-zc``
+do not drop USO requests; they ignore the Tx metadata and send the frame
+unsegmented and without offloads.
+
+In both modes, requests that produce more than one datagram also need
+``tx-udp-segmentation`` to be enabled on the device. In zero-copy mode, a
+packet may use at most ``xdp-zc-max-segs`` descriptors, as reported through
+the netdev netlink interface, and drivers may have further limits. For
+example, ice allows at most eight buffers per output datagram, counting the
+copied header.
+
 Launch Time
 ===========
 
@@ -198,7 +217,8 @@ USO with launch time
 
 Add ``XDP_TXMD_FLAGS_LAUNCH_TIME`` to the USO and checksum flags and set
 ``request.launch_time`` to schedule the segmented packet. This combination
-requires at least 24 bytes of Tx metadata.
+requires at least 24 bytes of Tx metadata and is only supported in copy
+mode; zero-copy mode rejects it.
 
 The launch time applies to the start of the segmented packet: the first
 output UDP datagram is scheduled, and subsequent datagrams follow according
@@ -229,6 +249,19 @@ Query the ``xsk-features`` attribute in
 - ``tx-timestamp``: device supports ``XDP_TXMD_FLAGS_TIMESTAMP``
 - ``tx-checksum``: device supports ``XDP_TXMD_FLAGS_CHECKSUM``
 - ``tx-launch-time-fifo``: device supports ``XDP_TXMD_FLAGS_LAUNCH_TIME``
+- ``tx-uso-zc``: driver supports ``XDP_TXMD_FLAGS_USO`` in zero-copy mode
+
+``tx-uso-zc`` reports driver capability. In both modes, segmentation is
+also switched by the device's ``tx-udp-segmentation`` feature, subject to
+the limits described in the UDP Segmentation section. A driver may also be
+unable to offer USO in some configurations and then ignores USO requests,
+as drivers without ``tx-uso-zc`` do. ice does so when it has fewer XDP Tx
+rings than CPUs, as queues then share XDP Tx rings, when its Tx ring is too
+small for a maximum-size USO packet with the UMEM chunk size, and when it
+cannot allocate its header buffers while reconfiguring a ring with a bound
+socket. The last two are reported in the kernel log. If the header buffers
+cannot be allocated at bind time, the zero-copy bind fails instead, and a
+bind without ``XDP_ZEROCOPY`` falls back to copy mode.
 
 See ``tools/net/ynl/samples/netdev.c`` on how to query this information.
 
diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 432da05c48c0..e19929b37e11 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -833,16 +833,24 @@ static inline void ice_rx_xsk_pool(struct ice_rx_ring *ring)
  * carries a pointer to one of these XDP rings for its own purposes, such as
  * handling XDP_TX action, therefore we can piggyback here on the
  * rx_ring->xdp_ring assignment that was done during XDP rings initialization.
+ * The ring must be stopped, as its USO header slots are matched to the pool.
+ * If they cannot be allocated, the ring keeps the pool without USO.
  */
 static inline void ice_tx_xsk_pool(struct ice_vsi *vsi, u16 qid)
 {
+	struct xsk_buff_pool *pool;
 	struct ice_tx_ring *ring;
 
 	ring = vsi->rx_rings[qid]->xdp_ring;
 	if (!ring)
 		return;
 
-	WRITE_ONCE(ring->xsk_pool, ice_get_xp_from_qid(vsi, qid));
+	pool = ice_get_xp_from_qid(vsi, qid);
+	if (ice_xsk_cfg_uso_slots(ring, pool))
+		netdev_warn(vsi->netdev,
+			    "Failed to allocate USO header buffers, USO requests on queue %u are ignored\n",
+			    qid);
+	WRITE_ONCE(ring->xsk_pool, pool);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index dffa213734f1..423abdf2960d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3309,6 +3309,8 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 		xdp_rings[i].count = new_tx_cnt;
 		xdp_rings[i].desc = NULL;
 		xdp_rings[i].tx_buf = NULL;
+		xdp_rings[i].xsk_uso_pages = NULL;
+		xdp_rings[i].xsk_uso_nr_pages = 0;
 		err = ice_setup_tx_ring(&xdp_rings[i]);
 		if (err) {
 			while (i--)
diff --git a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
index 185672c7e17d..d4d02c2466d2 100644
--- a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
+++ b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
@@ -499,6 +499,7 @@ struct ice_tx_ctx_desc {
 
 #define ICE_TXD_CTX_QW1_MSS_S	50
 #define ICE_TXD_CTX_MIN_MSS	64
+#define ICE_TXD_CTX_MAX_MSS	0x3FFF
 
 #define ICE_TXD_CTX_QW1_VSI_S	50
 #define ICE_TXD_CTX_QW1_VSI_M	(0x3FFULL << ICE_TXD_CTX_QW1_VSI_S)
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 41bcac642291..d32a466869a9 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3464,6 +3464,7 @@ static void ice_set_ops(struct ice_vsi *vsi)
 			       NETDEV_XDP_ACT_XSK_ZEROCOPY |
 			       NETDEV_XDP_ACT_RX_SG;
 	netdev->xdp_zc_max_segs = ICE_MAX_BUF_TXD;
+	ice_xsk_setup_metadata(netdev);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
index a730aa368c92..d2a76a3e2cd3 100644
--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
@@ -54,6 +54,7 @@ static int ice_sf_cfg_netdev(struct ice_dynamic_port *dyn_port,
 			       NETDEV_XDP_ACT_XSK_ZEROCOPY |
 			       NETDEV_XDP_ACT_RX_SG;
 	netdev->xdp_zc_max_segs = ICE_MAX_BUF_TXD;
+	ice_xsk_setup_metadata(netdev);
 
 	eth_hw_addr_set(netdev, dyn_port->hw_addr);
 	ether_addr_copy(netdev->perm_addr, dyn_port->hw_addr);
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 7877c27293a6..8fb76652837c 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -228,6 +228,8 @@ void ice_clean_tx_ring(struct ice_tx_ring *tx_ring)
 
 	tx_ring->next_to_use = 0;
 	tx_ring->next_to_clean = 0;
+	tx_ring->xsk_uso_active = 0;
+	tx_ring->xsk_drain = false;
 
 	if (!tx_ring->netdev)
 		return;
@@ -250,6 +252,7 @@ void ice_free_tx_ring(struct ice_tx_ring *tx_ring)
 	u32 size;
 
 	ice_clean_tx_ring(tx_ring);
+	ice_xsk_free_uso_slots(tx_ring);
 	devm_kfree(tx_ring->dev, tx_ring->tx_buf);
 	tx_ring->tx_buf = NULL;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index 5e517f219379..68cb588d7ed3 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -76,13 +76,17 @@
 
 /**
  * enum ice_tx_buf_type - type of &ice_tx_buf to act on Tx completion
- * @ICE_TX_BUF_EMPTY: unused OR XSk frame, no action required
+ * @ICE_TX_BUF_EMPTY: unused OR XSk frame, no action required, one completion
  * @ICE_TX_BUF_DUMMY: dummy Flow Director packet, unmap and kfree()
  * @ICE_TX_BUF_FRAG: mapped skb OR &xdp_buff frag, only unmap DMA
  * @ICE_TX_BUF_SKB: &sk_buff, unmap and consume_skb(), update stats
  * @ICE_TX_BUF_XDP_TX: &xdp_buff, unmap and page_frag_free(), stats
  * @ICE_TX_BUF_XDP_XMIT: &xdp_frame, unmap and xdp_return_frame(), stats
  * @ICE_TX_BUF_XSK_TX: &xdp_buff on XSk queue, xsk_buff_free(), stats
+ * @ICE_TX_BUF_XSK_USO: XSk USO context, sync header slot for the CPU
+ * @ICE_TX_BUF_XSK_DROP: XSk frame whose completions differ from its descriptor
+ *                       count, from dropped frames or split buffers
+ * @ICE_TX_BUF_XSK_DESC: XSk metadata-path frame, @xsk_completions completions
  */
 enum ice_tx_buf_type {
 	ICE_TX_BUF_EMPTY	= 0U,
@@ -92,6 +96,9 @@ enum ice_tx_buf_type {
 	ICE_TX_BUF_XDP_TX,
 	ICE_TX_BUF_XDP_XMIT,
 	ICE_TX_BUF_XSK_TX,
+	ICE_TX_BUF_XSK_USO,
+	ICE_TX_BUF_XSK_DROP,
+	ICE_TX_BUF_XSK_DESC,
 };
 
 struct ice_tx_buf {
@@ -109,6 +116,7 @@ struct ice_tx_buf {
 	union {
 		unsigned int gso_segs;
 		unsigned int nr_frags;	/* used for mbuf XDP */
+		u32 xsk_completions;	/* used for XSk metadata path */
 	};
 	u32 tx_flags:12;
 	u32 type:4;			/* &ice_tx_buf_type */
@@ -346,12 +354,22 @@ struct ice_rx_ring {
 	__cacheline_group_end_aligned(cold);
 } ____cacheline_internodealigned_in_smp;
 
+/* One DMA-mapped page of USO header slots. */
+struct ice_xsk_uso_page {
+	void *addr;
+	dma_addr_t dma;
+};
+
 struct ice_tx_ring {
 	__cacheline_group_begin_aligned(read_mostly);
 	void *desc;			/* Descriptor ring memory */
 	struct device *dev;		/* Used for DMA mapping */
 	u8 __iomem *tail;
 	struct ice_tx_buf *tx_buf;
+	struct ice_xsk_uso_page *xsk_uso_pages;	/* USO header slots */
+	u16 xsk_uso_slot_stride;
+	u16 xsk_uso_slots_per_page;
+	u32 xsk_uso_nr_pages;
 
 	struct ice_q_vector *q_vector;	/* Backreference to associated vector */
 	struct net_device *netdev;	/* netdev ring maps to */
@@ -377,6 +395,8 @@ struct ice_tx_ring {
 	u16 next_to_clean;
 
 	u16 xdp_tx_active;
+	u16 xsk_uso_active;
+	bool xsk_drain;			/* drop XSk descriptors up to EOP */
 	spinlock_t tx_lock;
 	__cacheline_group_end_aligned(read_write);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 0c1ce3e86a45..7fa1127480b6 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -5,6 +5,7 @@
 #include <linux/unroll.h>
 #include <net/libeth/xdp.h>
 #include <net/xdp_sock_drv.h>
+#include <net/xsk_tx_uso.h>
 #include <net/xdp.h>
 #include "ice.h"
 #include "ice_base.h"
@@ -133,6 +134,22 @@ static int ice_xsk_pool_disable(struct ice_vsi *vsi, u16 qid)
 	return 0;
 }
 
+/* Worst-case HW descriptors per AF_XDP descriptor on the USO path: the data
+ * split into maximum-size buffers plus a context and a header descriptor.
+ */
+static u32 ice_xsk_uso_desc_cost(const struct xsk_buff_pool *pool)
+{
+	return DIV_ROUND_UP(pool->chunk_size, ICE_MAX_DATA_PER_TXD_ALIGNED) + 2;
+}
+
+/* The Tx budget must fit a maximum-size packet, or it is never peeked. */
+static bool ice_xsk_uso_ring_fits(const struct ice_vsi *vsi, u16 count,
+				  const struct xsk_buff_pool *pool)
+{
+	return (count - 1) / ice_xsk_uso_desc_cost(pool) >=
+	       vsi->netdev->xdp_zc_max_segs;
+}
+
 /**
  * ice_xsk_pool_enable - enable a buffer pool region
  * @vsi: Current VSI
@@ -144,6 +161,7 @@ static int ice_xsk_pool_disable(struct ice_vsi *vsi, u16 qid)
 static int
 ice_xsk_pool_enable(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
 {
+	struct ice_tx_ring *xdp_ring;
 	int err;
 
 	if (vsi->type != ICE_VSI_PF && vsi->type != ICE_VSI_SF)
@@ -153,14 +171,129 @@ ice_xsk_pool_enable(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
 	    qid >= vsi->netdev->real_num_tx_queues)
 		return -EINVAL;
 
-	err = xsk_pool_dma_map(pool, ice_pf_to_dev(vsi->back),
-			       ICE_RX_DMA_ATTR);
-	if (err)
-		return err;
+	/* No header slots are allocated then, see ice_xsk_cfg_uso_slots(). The
+	 * pool flag is left alone, as copy mode is a fallback if this fails.
+	 */
+	if (pool->tx_metadata_len && pool->tx_uso_supported &&
+	    !ice_xsk_uso_ring_fits(vsi, vsi->num_tx_desc, pool))
+		netdev_warn(vsi->netdev, "Tx ring too small for USO with %u byte chunks, USO requests on queue %u are ignored\n",
+			    pool->chunk_size, qid);
+
+	/* Allocate the header slots before the pool is DMA mapped and can be
+	 * published to the rings, so that a failure leaves them without it.
+	 * Without XDP, rx_ring->xdp_ring is stale, and the slots are allocated
+	 * when the XDP rings are set up.
+	 */
+	xdp_ring = ice_is_xdp_ena_vsi(vsi) ? vsi->rx_rings[qid]->xdp_ring : NULL;
+	if (xdp_ring) {
+		err = ice_xsk_cfg_uso_slots(xdp_ring, pool);
+		if (err)
+			return err;
+	}
+
+	err = xsk_pool_dma_map(pool, ice_pf_to_dev(vsi->back), ICE_RX_DMA_ATTR);
+	if (err && xdp_ring)
+		ice_xsk_cfg_uso_slots(xdp_ring, NULL);
+	return err;
+}
+
+/**
+ * ice_xsk_free_uso_slots - free the USO header slots of an XDP Tx ring
+ * @ring: XDP Tx ring without outstanding descriptors
+ */
+void ice_xsk_free_uso_slots(struct ice_tx_ring *ring)
+{
+	u32 i;
+
+	if (!ring->xsk_uso_pages)
+		return;
+
+	for (i = 0; i < ring->xsk_uso_nr_pages; i++) {
+		struct ice_xsk_uso_page *page = &ring->xsk_uso_pages[i];
+
+		if (page->addr)
+			dma_free_noncoherent(ring->dev, PAGE_SIZE, page->addr,
+					     page->dma, DMA_TO_DEVICE);
+	}
+	kfree(ring->xsk_uso_pages);
+	ring->xsk_uso_pages = NULL;
+	ring->xsk_uso_nr_pages = 0;
+	ring->xsk_uso_slots_per_page = 0;
+	ring->xsk_uso_slot_stride = 0;
+}
+
+/**
+ * ice_xsk_cfg_uso_slots - match the USO header slots of a ring to its pool
+ * @ring: XDP Tx ring without outstanding descriptors
+ * @pool: buffer pool bound to the ring, or NULL
+ *
+ * Header slots are only needed when USO requests can be submitted. They
+ * belong to the ring, one per two descriptors, and are freed with it. They
+ * are allocated in single pages to avoid a large contiguous allocation.
+ *
+ * Return: 0 on success, -ENOMEM on allocation failure.
+ */
+int ice_xsk_cfg_uso_slots(struct ice_tx_ring *ring, struct xsk_buff_pool *pool)
+{
+	u32 stride = ALIGN(NET_IP_ALIGN + XSK_TX_USO_MAX_HEADER,
+			   dma_get_cache_alignment());
+	u32 per_page = PAGE_SIZE / stride;
+	u32 nr_pages = DIV_ROUND_UP(ring->count / 2, per_page);
+	u32 i;
+
+	/* With fewer XDP rings than CPUs, queues share XDP rings and so would
+	 * share their slots. USO requests are then ignored, as by drivers
+	 * without USO support. The same goes for a Tx ring too small for a
+	 * maximum-size USO packet.
+	 */
+	if (!pool || !pool->tx_metadata_len || !pool->tx_uso_supported ||
+	    ring->vsi->num_xdp_txq < num_possible_cpus() ||
+	    !ice_xsk_uso_ring_fits(ring->vsi, ring->count, pool)) {
+		ice_xsk_free_uso_slots(ring);
+		return 0;
+	}
+	if (ring->xsk_uso_pages && ring->xsk_uso_nr_pages == nr_pages)
+		return 0;
+
+	ice_xsk_free_uso_slots(ring);
+	ring->xsk_uso_pages = kcalloc(nr_pages, sizeof(*ring->xsk_uso_pages),
+				      GFP_KERNEL);
+	if (!ring->xsk_uso_pages)
+		return -ENOMEM;
+	ring->xsk_uso_nr_pages = nr_pages;
+
+	for (i = 0; i < nr_pages; i++) {
+		struct ice_xsk_uso_page *page = &ring->xsk_uso_pages[i];
+
+		page->addr = dma_alloc_noncoherent(ring->dev, PAGE_SIZE,
+						   &page->dma, DMA_TO_DEVICE,
+						   GFP_KERNEL);
+		if (!page->addr) {
+			ice_xsk_free_uso_slots(ring);
+			return -ENOMEM;
+		}
+	}
+	ring->xsk_uso_slot_stride = stride;
+	ring->xsk_uso_slots_per_page = per_page;
 
 	return 0;
 }
 
+/* Every USO packet takes a context and a header descriptor, so in-flight
+ * context descriptors are never adjacent and, as the ring size is even, half
+ * the context index is a unique header slot. Return the page and set the slot
+ * offset within it.
+ */
+static struct ice_xsk_uso_page *
+ice_xsk_uso_slot(const struct ice_tx_ring *ring, u16 ctx_idx, u32 *offset)
+{
+	u32 slot = ctx_idx >> 1;
+
+	*offset = slot % ring->xsk_uso_slots_per_page *
+		  ring->xsk_uso_slot_stride;
+	return &ring->xsk_uso_pages[slot / ring->xsk_uso_slots_per_page];
+}
+
 /**
  * ice_realloc_rx_xdp_bufs - reallocate for either XSK or normal buffer
  * @rx_ring: Rx ring
@@ -354,6 +487,36 @@ bool ice_alloc_rx_bufs_zc(struct ice_rx_ring *rx_ring,
 	return __ice_alloc_rx_bufs_zc(rx_ring, xsk_pool, leftover);
 }
 
+static u32 ice_clean_xsk_buf(struct ice_tx_ring *ring, struct ice_tx_buf *buf)
+{
+	u32 completed = buf->xsk_completions;
+	struct ice_xsk_uso_page *page;
+	u32 offset;
+
+	switch (buf->type) {
+	case ICE_TX_BUF_EMPTY:
+		return 1;
+	case ICE_TX_BUF_XSK_TX:
+		xsk_buff_free(buf->xdp);
+		ring->xdp_tx_active--;
+		break;
+	case ICE_TX_BUF_XSK_USO:
+		page = ice_xsk_uso_slot(ring, buf - ring->tx_buf, &offset);
+		dma_sync_single_range_for_cpu(ring->dev, page->dma, offset,
+					      ring->xsk_uso_slot_stride,
+					      DMA_TO_DEVICE);
+		ring->xsk_uso_active--;
+		break;
+	case ICE_TX_BUF_XSK_DROP:
+		ring->xsk_uso_active--;
+		break;
+	default:
+		break;
+	}
+	buf->type = ICE_TX_BUF_EMPTY;
+	return completed;
+}
+
 /**
  * ice_clean_xdp_irq_zc - produce AF_XDP descriptors to CQ
  * @xdp_ring: XDP Tx ring
@@ -365,9 +528,8 @@ static u32 ice_clean_xdp_irq_zc(struct ice_tx_ring *xdp_ring,
 	u16 ntc = xdp_ring->next_to_clean;
 	struct ice_tx_desc *tx_desc;
 	u16 cnt = xdp_ring->count;
-	struct ice_tx_buf *tx_buf;
 	u16 completed_frames = 0;
-	u16 xsk_frames = 0;
+	u32 xsk_frames = 0;
 	u16 last_rs;
 	int i;
 
@@ -384,22 +546,14 @@ static u32 ice_clean_xdp_irq_zc(struct ice_tx_ring *xdp_ring,
 	if (!completed_frames)
 		return 0;
 
-	if (likely(!xdp_ring->xdp_tx_active)) {
+	if (likely(!xdp_ring->xsk_uso_active && !xdp_ring->xdp_tx_active)) {
 		xsk_frames = completed_frames;
 		goto skip;
 	}
 
 	ntc = xdp_ring->next_to_clean;
 	for (i = 0; i < completed_frames; i++) {
-		tx_buf = &xdp_ring->tx_buf[ntc];
-
-		if (tx_buf->type == ICE_TX_BUF_XSK_TX) {
-			tx_buf->type = ICE_TX_BUF_EMPTY;
-			xsk_buff_free(tx_buf->xdp);
-			xdp_ring->xdp_tx_active--;
-		} else {
-			xsk_frames++;
-		}
+		xsk_frames += ice_clean_xsk_buf(xdp_ring, &xdp_ring->tx_buf[ntc]);
 
 		ntc++;
 		if (ntc >= xdp_ring->count)
@@ -469,6 +623,7 @@ static int ice_xmit_xdp_tx_zc(struct xdp_buff *xdp,
 
 		tx_buf->xdp = xdp;
 		tx_buf->type = ICE_TX_BUF_XSK_TX;
+		tx_buf->xsk_completions = 0;
 		tx_desc->buf_addr = cpu_to_le64(dma);
 		tx_desc->cmd_type_offset_bsz = ice_build_ctob(0, 0, size, 0);
 		/* account for each xdp_buff from xsk_buff_pool */
@@ -791,6 +946,272 @@ static void ice_fill_tx_hw_ring(struct ice_tx_ring *xdp_ring,
 		ice_xmit_pkt(xdp_ring, xsk_pool, &descs[i], total_bytes);
 }
 
+static void ice_xsk_data_desc(struct ice_tx_ring *ring, dma_addr_t dma,
+			      u32 len, u32 cmd, u32 offset, u32 completions)
+{
+	struct ice_tx_desc *desc = ICE_TX_DESC(ring, ring->next_to_use);
+	struct ice_tx_buf *buf = &ring->tx_buf[ring->next_to_use];
+
+	buf->type = ICE_TX_BUF_XSK_DESC;
+	buf->xsk_completions = completions;
+	desc->buf_addr = cpu_to_le64(dma);
+	desc->cmd_type_offset_bsz = ice_build_ctob(cmd, offset, len, 0);
+	if (++ring->next_to_use == ring->count)
+		ring->next_to_use = 0;
+}
+
+/* Include the copied header in the eight-buffer limit for every wire segment. */
+static bool ice_xsk_uso_fits(const struct xdp_desc *descs, u32 nr,
+			     const struct xsk_tx_uso_info *uso)
+{
+	u16 network_offset = uso->metadata.request.network_offset;
+	u16 transport_offset = uso->metadata.request.csum_start;
+	u16 gso_size = uso->metadata.request.gso_size;
+	u32 remaining = gso_size, buffers = 1, i;
+
+	/* The core does not know the width of the descriptor length fields. */
+	if (!ice_tx_hdr_lens_ok(network_offset,
+				transport_offset - network_offset) ||
+	    (uso->gso_segs > 1 &&
+	     (gso_size < ICE_TXD_CTX_MIN_MSS || gso_size > ICE_TXD_CTX_MAX_MSS)))
+		return false;
+
+	for (i = 0; i < nr; i++) {
+		u32 len = descs[i].len - (i ? 0 : uso->header_len);
+
+		while (len) {
+			u32 chunk = min_t(u32, len, ICE_MAX_DATA_PER_TXD_ALIGNED);
+			u32 left = chunk;
+
+			len -= chunk;
+			while (left) {
+				u32 bytes = min(left, remaining);
+
+				if (++buffers > ICE_MAX_BUF_TXD)
+					return false;
+				left -= bytes;
+				remaining -= bytes;
+				if (!remaining) {
+					remaining = gso_size;
+					buffers = 1;
+				}
+			}
+		}
+	}
+	return true;
+}
+
+/* A buffer longer than one data descriptor is split, so a packet without USO
+ * can then need more data descriptors than the hardware allows.
+ */
+static bool ice_xsk_bufs_fit(const struct xsk_buff_pool *pool,
+			     const struct xdp_desc *descs, u32 nr)
+{
+	u32 buffers = 0, i;
+
+	if (likely(pool->chunk_size <= ICE_MAX_DATA_PER_TXD_ALIGNED))
+		return true;
+	for (i = 0; i < nr; i++)
+		buffers += DIV_ROUND_UP(descs[i].len,
+					ICE_MAX_DATA_PER_TXD_ALIGNED);
+	return buffers <= ICE_MAX_BUF_TXD;
+}
+
+/* Write the context and header descriptors of a USO packet and return the
+ * command and offset fields for its payload descriptors.
+ */
+static int ice_xsk_xmit_uso_hdr(struct ice_tx_ring *ring,
+				const struct xdp_desc *descs, u32 nr,
+				const struct xsk_tx_uso_info *info, u32 *cmd,
+				u32 *offset)
+{
+	const struct xsk_tx_metadata *meta = &info->metadata;
+	u16 slot_idx = ring->next_to_use;
+	u64 qw1 = ICE_TX_DESC_DTYPE_CTX;
+	struct ice_xsk_uso_page *page;
+	struct ice_tx_ctx_desc *ctx;
+	struct ice_tx_buf *buf;
+	dma_addr_t header_dma;
+	u32 slot_offset;
+	bool eop;
+
+	if (!ice_xsk_uso_fits(descs, nr, info))
+		return -EOPNOTSUPP;
+
+	page = ice_xsk_uso_slot(ring, slot_idx, &slot_offset);
+	header_dma = page->dma + slot_offset + NET_IP_ALIGN;
+
+	xsk_tx_uso_prepare_headers(info, page->addr + slot_offset + NET_IP_ALIGN);
+	dma_sync_single_range_for_device(ring->dev, page->dma, slot_offset,
+					 NET_IP_ALIGN + info->header_len,
+					 DMA_TO_DEVICE);
+
+	*cmd = ICE_TX_DESC_CMD_L4T_EOFT_UDP;
+	if (info->protocol == htons(ETH_P_IP))
+		*cmd |= info->gso_segs > 1 ? ICE_TX_DESC_CMD_IIPT_IPV4_CSUM :
+					  ICE_TX_DESC_CMD_IIPT_IPV4;
+	else
+		*cmd |= ICE_TX_DESC_CMD_IIPT_IPV6;
+	*offset = ice_build_tx_desc_offset(meta->request.network_offset,
+					   meta->request.csum_start -
+					   meta->request.network_offset,
+					   sizeof(struct udphdr));
+
+	/* The context owns the header until the whole submitted batch completes. */
+	buf = &ring->tx_buf[slot_idx];
+	buf->type = ICE_TX_BUF_XSK_USO;
+	buf->xsk_completions = 0;
+	ring->xsk_uso_active++;
+
+	if (info->gso_segs > 1)
+		qw1 |= ice_build_tso_ctx_qw1(info->len - info->header_len,
+					     meta->request.gso_size);
+	ctx = (struct ice_tx_ctx_desc *)ICE_TX_DESC(ring, slot_idx);
+	memset(ctx, 0, sizeof(*ctx));
+	ctx->qw1 = cpu_to_le64(qw1);
+	if (++ring->next_to_use == ring->count)
+		ring->next_to_use = 0;
+
+	eop = info->len == info->header_len;
+	ice_xsk_data_desc(ring, header_dma, info->header_len,
+			  *cmd | (eop ? ICE_TX_DESC_CMD_EOP : 0), *offset,
+			  eop ? nr : 0);
+	return 0;
+}
+
+/* Write the data descriptors of a packet, skipping its first @skip bytes. */
+static void ice_xsk_xmit_descs(struct ice_tx_ring *ring,
+			       struct xsk_buff_pool *pool,
+			       const struct xdp_desc *descs, u32 nr, u32 skip,
+			       u32 cmd, u32 offset)
+{
+	bool split = false;
+	u32 i;
+
+	for (i = 0; i < nr; i++, skip = 0) {
+		u32 len = descs[i].len - skip;
+		dma_addr_t dma;
+
+		if (!len)
+			continue;
+		dma = xsk_buff_raw_get_dma(pool, descs[i].addr) + skip;
+		xsk_buff_raw_dma_sync_for_device(pool, dma, len);
+		while (len) {
+			u32 chunk = min_t(u32, len, ICE_MAX_DATA_PER_TXD_ALIGNED);
+			bool eop = i == nr - 1 && len == chunk;
+
+			split |= len > chunk;
+			ice_xsk_data_desc(ring, dma, chunk,
+					  cmd | (eop ? ICE_TX_DESC_CMD_EOP : 0),
+					  offset, eop ? nr : 0);
+			dma += chunk;
+			len -= chunk;
+		}
+	}
+	/* Split buffers break the one-completion-per-descriptor cleanup
+	 * shortcut, so make the cleanup walk this packet.
+	 */
+	if (unlikely(split)) {
+		u16 last = ring->next_to_use ? ring->next_to_use - 1 : ring->count - 1;
+
+		ring->tx_buf[last].type = ICE_TX_BUF_XSK_DROP;
+		ring->xsk_uso_active++;
+	}
+}
+
+static void ice_xsk_drop_packet(struct ice_tx_ring *ring,
+				struct xsk_buff_pool *pool, u32 nr)
+{
+	xsk_tx_invalid_descs(pool, nr);
+	/* Completion queue entries are published in submission order, so a
+	 * dropped packet must not be completed ahead of descriptors still in
+	 * flight. The ring always keeps one descriptor unused, so equal
+	 * indices mean that nothing is outstanding.
+	 */
+	if (ring->next_to_use != ring->next_to_clean) {
+		u16 last = ring->next_to_use ? ring->next_to_use - 1 : ring->count - 1;
+		struct ice_tx_buf *buf = &ring->tx_buf[last];
+
+		/* XSK_TX buffers already force the slow cleanup path. */
+		if (buf->type == ICE_TX_BUF_EMPTY) {
+			buf->xsk_completions = 1;
+			buf->type = ICE_TX_BUF_XSK_DROP;
+			ring->xsk_uso_active++;
+		} else if (buf->type == ICE_TX_BUF_XSK_DESC) {
+			buf->type = ICE_TX_BUF_XSK_DROP;
+			ring->xsk_uso_active++;
+		}
+		buf->xsk_completions += nr;
+	} else {
+		xsk_tx_completed(pool, nr);
+	}
+}
+
+/* Returns the number of packets queued on the ring. */
+static u32 ice_xmit_zc_metadata(struct ice_tx_ring *ring, struct xsk_buff_pool *pool,
+				u32 count, unsigned int *total_bytes)
+{
+	struct xdp_desc *descs = pool->tx_descs;
+	u32 i = 0, packets = 0;
+
+	/* Drop the rest of a packet whose start was dropped in an earlier batch. */
+	if (unlikely(ring->xsk_drain)) {
+		while (i < count && ring->xsk_drain)
+			ring->xsk_drain = !xsk_is_eop_desc(&descs[i++]);
+		ice_xsk_drop_packet(ring, pool, i);
+	}
+
+	while (i < count) {
+		u32 cmd = 0, offset = 0, skip = 0, slot_offset;
+		u32 len = descs[i].len, nr = 1;
+		struct ice_xsk_uso_page *page;
+		struct xsk_tx_uso_info info;
+		int uso;
+
+		while (!xsk_is_eop_desc(&descs[i + nr - 1]) && i + nr < count)
+			len += descs[i + nr++].len;
+		/* The shared-umem fallback can end a batch inside a packet. */
+		if (unlikely(!xsk_is_eop_desc(&descs[i + nr - 1]))) {
+			ice_xsk_drop_packet(ring, pool, nr);
+			ring->xsk_drain = true;
+			break;
+		}
+		page = ice_xsk_uso_slot(ring, ring->next_to_use, &slot_offset);
+		uso = xsk_tx_uso_parse(pool, &descs[i], nr, &info,
+				       page->addr + slot_offset + NET_IP_ALIGN);
+		if (uso < 0 || (!uso && !ice_xsk_bufs_fit(pool, &descs[i], nr)) ||
+		    (uso && ice_xsk_xmit_uso_hdr(ring, &descs[i], nr, &info,
+						 &cmd, &offset))) {
+			ice_xsk_drop_packet(ring, pool, nr);
+			i += nr;
+			continue;
+		}
+		if (uso) {
+			skip = info.header_len;
+			*total_bytes += (info.gso_segs - 1) * skip;
+			packets += info.gso_segs - 1;
+		}
+		ice_xsk_xmit_descs(ring, pool, &descs[i], nr, skip, cmd, offset);
+		*total_bytes += len;
+		packets++;
+		i += nr;
+	}
+	return packets;
+}
+
+/**
+ * ice_xsk_setup_metadata - register AF_XDP Tx metadata operations
+ * @netdev: net_device
+ */
+void ice_xsk_setup_metadata(struct net_device *netdev)
+{
+	static const struct xsk_tx_metadata_ops ops = {
+		.tmo_supports_uso = true,
+	};
+
+	netdev->xsk_tx_metadata_ops = &ops;
+}
+
 /**
  * ice_xmit_zc - take entries from XSK Tx ring and place them onto HW Tx ring
  * @xdp_ring: XDP ring to produce the HW Tx descriptors on
@@ -801,9 +1222,9 @@ static void ice_fill_tx_hw_ring(struct ice_tx_ring *xdp_ring,
 bool ice_xmit_zc(struct ice_tx_ring *xdp_ring, struct xsk_buff_pool *xsk_pool)
 {
 	struct xdp_desc *descs = xsk_pool->tx_descs;
-	u32 nb_pkts, nb_processed = 0;
+	u32 nb_pkts, nb_processed = 0, packets;
 	unsigned int total_bytes = 0;
-	int budget;
+	u32 budget, cost = 1;
 
 	ice_clean_xdp_irq_zc(xdp_ring, xsk_pool);
 
@@ -811,26 +1232,38 @@ bool ice_xmit_zc(struct ice_tx_ring *xdp_ring, struct xsk_buff_pool *xsk_pool)
 	    !netif_running(xdp_ring->vsi->netdev))
 		return true;
 
-	budget = ICE_DESC_UNUSED(xdp_ring);
-	budget = min_t(u16, budget, ICE_RING_QUARTER(xdp_ring));
+	/* Reserve worst-case descriptors for each potential USO packet. */
+	if (xdp_ring->xsk_uso_pages)
+		cost = ice_xsk_uso_desc_cost(xsk_pool);
+	budget = min_t(u32, ICE_DESC_UNUSED(xdp_ring) / cost,
+		       ICE_RING_QUARTER(xdp_ring));
 
 	nb_pkts = xsk_tx_peek_release_desc_batch(xsk_pool, budget);
 	if (!nb_pkts)
 		return true;
 
-	if (xdp_ring->next_to_use + nb_pkts >= xdp_ring->count) {
-		nb_processed = xdp_ring->count - xdp_ring->next_to_use;
-		ice_fill_tx_hw_ring(xdp_ring, xsk_pool, descs, nb_processed,
-				    &total_bytes);
-		xdp_ring->next_to_use = 0;
-	}
+	if (xdp_ring->xsk_uso_pages) {
+		packets = ice_xmit_zc_metadata(xdp_ring, xsk_pool, nb_pkts,
+					       &total_bytes);
+	} else {
+		if (xdp_ring->next_to_use + nb_pkts >= xdp_ring->count) {
+			nb_processed = xdp_ring->count - xdp_ring->next_to_use;
+			ice_fill_tx_hw_ring(xdp_ring, xsk_pool, descs, nb_processed,
+					    &total_bytes);
+			xdp_ring->next_to_use = 0;
+		}
 
-	ice_fill_tx_hw_ring(xdp_ring, xsk_pool, &descs[nb_processed],
-			    nb_pkts - nb_processed, &total_bytes);
+		ice_fill_tx_hw_ring(xdp_ring, xsk_pool, &descs[nb_processed],
+				    nb_pkts - nb_processed, &total_bytes);
+		packets = nb_pkts;
+	}
 
-	ice_set_rs_bit(xdp_ring);
-	ice_xdp_ring_update_tail(xdp_ring);
-	ice_update_tx_ring_stats(xdp_ring, nb_pkts, total_bytes);
+	/* Metadata packets may all have been dropped. */
+	if (packets) {
+		ice_set_rs_bit(xdp_ring);
+		ice_xdp_ring_update_tail(xdp_ring);
+		ice_update_tx_ring_stats(xdp_ring, packets, total_bytes);
+	}
 
 	if (xsk_uses_need_wakeup(xsk_pool))
 		xsk_set_tx_need_wakeup(xsk_pool);
@@ -939,12 +1372,7 @@ void ice_xsk_clean_xdp_ring(struct ice_tx_ring *xdp_ring)
 	while (ntc != ntu) {
 		struct ice_tx_buf *tx_buf = &xdp_ring->tx_buf[ntc];
 
-		if (tx_buf->type == ICE_TX_BUF_XSK_TX) {
-			tx_buf->type = ICE_TX_BUF_EMPTY;
-			xsk_buff_free(tx_buf->xdp);
-		} else {
-			xsk_frames++;
-		}
+		xsk_frames += ice_clean_xsk_buf(xdp_ring, tx_buf);
 
 		ntc++;
 		if (ntc >= xdp_ring->count)
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.h b/drivers/net/ethernet/intel/ice/ice_xsk.h
index 5275fcedc9e1..30f759cfaf9b 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.h
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.h
@@ -22,6 +22,9 @@ bool ice_xsk_any_rx_ring_ena(struct ice_vsi *vsi);
 void ice_xsk_clean_rx_ring(struct ice_rx_ring *rx_ring);
 void ice_xsk_clean_xdp_ring(struct ice_tx_ring *xdp_ring);
 bool ice_xmit_zc(struct ice_tx_ring *xdp_ring, struct xsk_buff_pool *xsk_pool);
+void ice_xsk_setup_metadata(struct net_device *netdev);
+int ice_xsk_cfg_uso_slots(struct ice_tx_ring *ring, struct xsk_buff_pool *pool);
+void ice_xsk_free_uso_slots(struct ice_tx_ring *ring);
 int ice_realloc_rx_xdp_bufs(struct ice_rx_ring *rx_ring, bool pool_present);
 void ice_qvec_cfg_msix(struct ice_vsi *vsi, struct ice_q_vector *q_vector,
 		       u16 qid);
@@ -75,6 +78,16 @@ ice_xsk_wakeup(struct net_device __always_unused *netdev,
 
 static inline void ice_xsk_clean_rx_ring(struct ice_rx_ring *rx_ring) { }
 static inline void ice_xsk_clean_xdp_ring(struct ice_tx_ring *xdp_ring) { }
+static inline void ice_xsk_setup_metadata(struct net_device *netdev) { }
+
+static inline int
+ice_xsk_cfg_uso_slots(struct ice_tx_ring __always_unused *ring,
+		      struct xsk_buff_pool __always_unused *pool)
+{
+	return 0;
+}
+
+static inline void ice_xsk_free_uso_slots(struct ice_tx_ring *ring) { }
 
 static inline int
 ice_realloc_rx_xdp_bufs(struct ice_rx_ring *rx_ring,
diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 6e70b320b399..7b9f449c275a 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -113,12 +113,17 @@ struct xdp_sock {
  *     Called when AF_XDP frame requested launch time HW offload support.
  *     launch_time indicates the PTP time at which the device can schedule the
  *     packet for transmission.
+ *
+ * bool tmo_supports_uso
+ *     The driver handles USO using a kernel-owned header snapshot rather than
+ *     the optional metadata callback dispatcher.
  */
 struct xsk_tx_metadata_ops {
 	void	(*tmo_request_timestamp)(void *priv);
 	u64	(*tmo_fill_timestamp)(void *priv);
 	void	(*tmo_request_checksum)(u16 csum_start, u16 csum_offset, void *priv);
 	void	(*tmo_request_launch_time)(u64 launch_time, void *priv);
+	bool	tmo_supports_uso;
 };
 
 #ifdef CONFIG_XDP_SOCKETS
diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 6b5bb7b29f87..fb5ffe8cfc52 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -28,6 +28,7 @@ void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries);
 bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc);
 u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 max);
 void xsk_tx_release(struct xsk_buff_pool *pool);
+void xsk_tx_invalid_descs(struct xsk_buff_pool *pool, u32 nb_descs);
 struct xsk_buff_pool *xsk_get_pool_from_qid(struct net_device *dev,
 					    u16 queue_id);
 void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool);
@@ -387,6 +388,11 @@ static inline void xsk_tx_release(struct xsk_buff_pool *pool)
 {
 }
 
+static inline void xsk_tx_invalid_descs(struct xsk_buff_pool *pool,
+					u32 nb_descs)
+{
+}
+
 static inline struct xsk_buff_pool *
 xsk_get_pool_from_qid(struct net_device *dev, u16 queue_id)
 {
diff --git a/include/net/xsk_tx_uso.h b/include/net/xsk_tx_uso.h
index f23384077712..99c7ef631f59 100644
--- a/include/net/xsk_tx_uso.h
+++ b/include/net/xsk_tx_uso.h
@@ -6,6 +6,8 @@
 #include <linux/types.h>
 #include <net/xsk_buff_pool.h>
 
+#define XSK_TX_USO_MAX_HEADER 256
+
 /* Header offsets are relative to the start of the supplied Ethernet frame. */
 struct xsk_tx_uso_info {
 	struct xsk_tx_metadata metadata;
@@ -19,12 +21,30 @@ struct xsk_tx_uso_info {
 #ifdef CONFIG_XDP_SOCKETS
 int xsk_tx_uso_validate(const void *header, struct xsk_tx_uso_info *uso,
 			u32 mtu);
+int xsk_tx_uso_parse(struct xsk_buff_pool *pool, const struct xdp_desc *descs,
+		     u32 nr, struct xsk_tx_uso_info *info, void *header);
+void xsk_tx_uso_prepare_headers(const struct xsk_tx_uso_info *info,
+				void *header);
+
 #else
+
 static inline int
 xsk_tx_uso_validate(const void *header, struct xsk_tx_uso_info *uso, u32 mtu)
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int
+xsk_tx_uso_parse(struct xsk_buff_pool *pool, const struct xdp_desc *descs,
+		 u32 nr, struct xsk_tx_uso_info *info, void *header)
+{
+	return 0;
+}
+
+static inline void
+xsk_tx_uso_prepare_headers(const struct xsk_tx_uso_info *info, void *header)
+{
+}
 #endif
 
 #endif
diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
index 0f7ba4859218..c9d99f988b33 100644
--- a/include/uapi/linux/if_xdp.h
+++ b/include/uapi/linux/if_xdp.h
@@ -134,9 +134,10 @@ struct xdp_options {
  */
 #define XDP_TXMD_FLAGS_LAUNCH_TIME		(1 << 2)
 
-/* Request UDP segmentation offload in XDP_COPY mode. Requires CHECKSUM.
+/* Request UDP segmentation offload. Requires CHECKSUM.
  * Segment size and IP header offset are in request.
- * With LAUNCH_TIME, scheduling applies to the start of the segmented packet.
+ * With LAUNCH_TIME (copy mode only), scheduling applies to the start of the
+ * segmented packet.
  */
 #define XDP_TXMD_FLAGS_USO			(1 << 3)
 
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 9026e0414fbe..bd52893adcac 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -62,11 +62,14 @@ enum netdev_xdp_rx_metadata {
  *   driver.
  * @NETDEV_XSK_FLAGS_TX_LAUNCH_TIME_FIFO: Launch time HW offload is supported
  *   by the driver.
+ * @NETDEV_XSK_FLAGS_TX_USO_ZC: UDP segmentation HW offload is supported for
+ *   AF_XDP zero-copy transmission.
  */
 enum netdev_xsk_flags {
 	NETDEV_XSK_FLAGS_TX_TIMESTAMP = 1,
 	NETDEV_XSK_FLAGS_TX_CHECKSUM = 2,
 	NETDEV_XSK_FLAGS_TX_LAUNCH_TIME_FIFO = 4,
+	NETDEV_XSK_FLAGS_TX_USO_ZC = 8,
 };
 
 enum netdev_queue_type {
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index d2ccb1090496..cee2f9d391d1 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -58,6 +58,8 @@ XDP_METADATA_KFUNC_xxx
 			xsk_features |= NETDEV_XSK_FLAGS_TX_CHECKSUM;
 		if (netdev->xsk_tx_metadata_ops->tmo_request_launch_time)
 			xsk_features |= NETDEV_XSK_FLAGS_TX_LAUNCH_TIME_FIFO;
+		if (netdev->xsk_tx_metadata_ops->tmo_supports_uso)
+			xsk_features |= NETDEV_XSK_FLAGS_TX_USO_ZC;
 	}
 
 	if (nla_put_u32(rsp, NETDEV_A_DEV_IFINDEX, netdev->ifindex) ||
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 14be62b8de5f..e830bee4d1fc 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -560,6 +560,30 @@ void xsk_tx_release(struct xsk_buff_pool *pool)
 }
 EXPORT_SYMBOL(xsk_tx_release);
 
+/**
+ * xsk_tx_invalid_descs - account Tx descriptors rejected by the driver
+ * @pool: buffer pool the descriptors were consumed from
+ * @nb_descs: number of rejected descriptors
+ *
+ * Report descriptors that were consumed from the Tx ring but rejected by the
+ * driver in the tx_invalid_descs statistic. The driver must still complete
+ * them. With a shared umem the owning socket is unknown, so the descriptors
+ * are only accounted when a single socket transmits on @pool.
+ */
+void xsk_tx_invalid_descs(struct xsk_buff_pool *pool, u32 nb_descs)
+{
+	struct xdp_sock *xs;
+
+	rcu_read_lock();
+	xs = list_first_or_null_rcu(&pool->xsk_tx_list, struct xdp_sock,
+				    tx_list);
+	if (xs && !list_next_or_null_rcu(&pool->xsk_tx_list, &xs->tx_list,
+					 struct xdp_sock, tx_list))
+		xs->tx->invalid_descs += nb_descs;
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL(xsk_tx_invalid_descs);
+
 bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc)
 {
 	bool budget_exhausted = false;
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index e62f3c2b3362..f20f3e84bbd6 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -263,7 +263,9 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 		goto err_unreg_xsk;
 	}
 	pool->umem->zc = true;
-	pool->tx_uso_supported = false;
+	if (!netdev->xsk_tx_metadata_ops ||
+	    !netdev->xsk_tx_metadata_ops->tmo_supports_uso)
+		pool->tx_uso_supported = false;
 	pool->xdp_zc_max_segs = netdev->xdp_zc_max_segs;
 	return 0;
 
diff --git a/net/xdp/xsk_tx_uso.c b/net/xdp/xsk_tx_uso.c
index a7313ade1092..1cec1ed30dd1 100644
--- a/net/xdp/xsk_tx_uso.c
+++ b/net/xdp/xsk_tx_uso.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <net/gso.h>
 #include <net/ip.h>
 #include <net/ipv6.h>
 #include <net/udp.h>
+#include <net/xdp_sock_drv.h>
 #include <net/xsk_tx_uso.h>
 
 /**
@@ -75,3 +77,98 @@ int xsk_tx_uso_validate(const void *header, struct xsk_tx_uso_info *uso,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(xsk_tx_uso_validate);
+
+/**
+ * xsk_tx_uso_parse - snapshot and validate an AF_XDP USO packet
+ * @pool: pool owning the validated descriptors
+ * @descs: kernel-owned descriptors, starting at the beginning of a packet
+ * @nr: nonzero number of descriptors, including the final EOP descriptor
+ * @info: receives the snapshotted metadata and the parsed header layout
+ * @header: storage for at least XSK_TX_USO_MAX_HEADER bytes of packet header
+ *
+ * Metadata is snapshotted before using its offsets. The packet header is
+ * copied exactly once, before any parsing. @header must remain valid until
+ * DMA completes if this packet is transmitted.
+ *
+ * Return: 1 for a valid USO request, 0 without USO, or a negative error code.
+ */
+int xsk_tx_uso_parse(struct xsk_buff_pool *pool, const struct xdp_desc *descs,
+		     u32 nr, struct xsk_tx_uso_info *info, void *header)
+{
+	struct xsk_tx_metadata *meta = &info->metadata;
+	struct xsk_tx_metadata *user_meta;
+	u32 header_len, len = 0, i;
+	u64 flags;
+	int err;
+
+	user_meta = xsk_buff_get_metadata(pool, descs->addr, descs->options);
+	if (!user_meta)
+		return 0;
+	memcpy(meta, user_meta,
+	       min_t(size_t, pool->tx_metadata_len, sizeof(*meta)));
+	if (!(meta->flags & XDP_TXMD_FLAGS_USO))
+		return 0;
+	if (!xsk_buff_valid_tx_metadata(pool, meta, &flags) ||
+	    !xsk_tx_uso_flags_valid(flags) ||
+	    (flags & XDP_TXMD_FLAGS_LAUNCH_TIME))
+		return -EOPNOTSUPP;
+
+	if (!meta->request.gso_size || meta->request.gso_size == GSO_BY_FRAGS ||
+	    meta->request.network_offset < ETH_HLEN ||
+	    meta->request.csum_start < meta->request.network_offset ||
+	    meta->request.csum_offset != offsetof(struct udphdr, check))
+		return -EINVAL;
+	header_len = (u32)meta->request.csum_start + sizeof(struct udphdr);
+	if (header_len > XSK_TX_USO_MAX_HEADER || header_len > descs->len)
+		return -EINVAL;
+	for (i = 0; i < nr; i++) {
+		if (check_add_overflow(len, descs[i].len, &len) ||
+		    xsk_is_eop_desc(&descs[i]) != (i == nr - 1))
+			return -EINVAL;
+	}
+
+	info->header_len = header_len;
+	info->len = len;
+	memcpy(header, xsk_buff_raw_get_data(pool, descs->addr), header_len);
+	err = xsk_tx_uso_validate(header, info, READ_ONCE(pool->netdev->mtu));
+	if (err)
+		return err;
+	/* As in copy mode, segmentation follows the device feature. */
+	if (info->gso_segs > 1 &&
+	    !(READ_ONCE(pool->netdev->features) & NETIF_F_GSO_UDP_L4))
+		return -EOPNOTSUPP;
+	return 1;
+}
+EXPORT_SYMBOL_GPL(xsk_tx_uso_parse);
+
+/**
+ * xsk_tx_uso_prepare_headers - prepare the copied header for hardware USO
+ * @info: layout of a request validated by xsk_tx_uso_parse()
+ * @header: header copied by xsk_tx_uso_parse()
+ *
+ * Call once after validation and before syncing the header for DMA. Removes
+ * the aggregate length from the partial UDP checksum seed and clears IP
+ * length/checksum fields for the segmentation engine. Single-datagram headers
+ * are unchanged.
+ */
+void xsk_tx_uso_prepare_headers(const struct xsk_tx_uso_info *info,
+				void *header)
+{
+	const struct xsk_tx_metadata *meta = &info->metadata;
+	struct udphdr *uh = header + meta->request.csum_start;
+	struct iphdr *iph = header + meta->request.network_offset;
+
+	if (info->gso_segs == 1)
+		return;
+
+	if (iph->version == 4) {
+		iph->tot_len = 0;
+		iph->check = 0;
+	} else {
+		((struct ipv6hdr *)iph)->payload_len = 0;
+	}
+	csum_replace_by_diff(&uh->check,
+			     (__force __wsum)htonl(info->len -
+						   meta->request.csum_start));
+}
+EXPORT_SYMBOL_GPL(xsk_tx_uso_prepare_headers);
diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
index 0f7ba4859218..c9d99f988b33 100644
--- a/tools/include/uapi/linux/if_xdp.h
+++ b/tools/include/uapi/linux/if_xdp.h
@@ -134,9 +134,10 @@ struct xdp_options {
  */
 #define XDP_TXMD_FLAGS_LAUNCH_TIME		(1 << 2)
 
-/* Request UDP segmentation offload in XDP_COPY mode. Requires CHECKSUM.
+/* Request UDP segmentation offload. Requires CHECKSUM.
  * Segment size and IP header offset are in request.
- * With LAUNCH_TIME, scheduling applies to the start of the segmented packet.
+ * With LAUNCH_TIME (copy mode only), scheduling applies to the start of the
+ * segmented packet.
  */
 #define XDP_TXMD_FLAGS_USO			(1 << 3)
 
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 9026e0414fbe..bd52893adcac 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -62,11 +62,14 @@ enum netdev_xdp_rx_metadata {
  *   driver.
  * @NETDEV_XSK_FLAGS_TX_LAUNCH_TIME_FIFO: Launch time HW offload is supported
  *   by the driver.
+ * @NETDEV_XSK_FLAGS_TX_USO_ZC: UDP segmentation HW offload is supported for
+ *   AF_XDP zero-copy transmission.
  */
 enum netdev_xsk_flags {
 	NETDEV_XSK_FLAGS_TX_TIMESTAMP = 1,
 	NETDEV_XSK_FLAGS_TX_CHECKSUM = 2,
 	NETDEV_XSK_FLAGS_TX_LAUNCH_TIME_FIFO = 4,
+	NETDEV_XSK_FLAGS_TX_USO_ZC = 8,
 };
 
 enum netdev_queue_type {
-- 
2.38.1

