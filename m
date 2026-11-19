Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B91E606A324
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 14:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=k/3M6/SI;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mXBK9/3y
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F357040B27;
	Thu, 19 Nov 2026 14:12:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4cPmHR-a8AIv; Thu, 19 Nov 2026 14:12:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C485240B18
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795097533;
	b=Ot+f8gP8v+yNGsrbucT8GXhNIVrlr/8GIq8ca7wZtFfEEdeInQkMpmyutpBDdS+KRRAe
	 wLlL/Vc7UhaK6tw53Mv8aj1ArLnIIhRK1w21ogy3e36kRcNeVWIiwoVufoQnAA8lk54gO
	 2IyqwLyRd0FfkkA54W1BnCdzx1oxJF43Ae45E9PzeoIPEe92u6IhhxJkzmRBx65ih5aw/
	 qBflsh92e1HAC3pKEUR5wXssTcU0lrIlGxqc3M8mrJGBz17lsDn9QWMFsQIHfvlDJd+N9
	 OKqIPnL04lg1ABwt2Qak2+POXWkgU9FJgEr/JTecFR2cubJ84oOLfZcjkUm7bJrUIBQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795097533;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=W93NO4isUy0OiwgBG+w+VjIFNgj+RuRlDvCUykjIlfs=;
	b=sz2u3R5tgjWmCcQDYrPCvfrWn9KQ52BREh98wtDzoORZunJB2LqXGYhKfvtJ4GgQ+rDh
	 wE33w6FdTn2oK9xgn3e9aN3bCT5jpua9u376dvUj7Dce9RQ6rjLCSkJ16oGIsoAGEQTdP
	 8TTI/cz2ECvXCmTTiSODcYgp8QVa6opOs5ES7LGaMMYtSmSuSfoWErxNsftz9rLG7IE9E
	 uQvb2pxKKFxok8gbud3hnDXlF4+mJee15z4Dh8P+umdLj0HaMBfan3g/9Qpl3Mx3nXbc5
	 dyMD5mBGcTzAKf6MNqPVjxoOVXjDR0jU4uQpmgdQi5vIRF/NgvY8dkVW/uW+2t7cWnw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795097533;
	bh=W93NO4isUy0OiwgBG+w+VjIFNgj+RuRlDvCUykjIlfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k/3M6/SIzLh0yGp27fH9N4Ww+vkPbovLsHdpPaY7nCMC4tUNrhWgIGmzFxSu2XDZz
	 GrR5o3xX3WTM91F4hdvmbIKMbXLckdRfc+JqGjYcwZ+470AbuWClWu+jScphvNGTM9
	 nYuoZL7JTGoxcvG+NIRLBVKadQd6Nop46JVhddPV9JMhULwHclBuuzmlpkYWDoeALj
	 mf2kvy5B6oJJBA9yKuuXRl6rairvQAgFc0EUAlrSQ2ICAMSS2uoscxhbvswr4BayFO
	 iaXXCRapwTLdz8SSGMYCA5vR3xBnP9MdQvX7Saj+jPZNPM6r0nbF/+DvcNkBd0TglX
	 CDd/AVE+2uXcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C485240B18;
	Thu, 19 Nov 2026 14:12:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B83941C9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 14:12:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A9DD840544
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 14:12:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0aB6Tu3-W6yF for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 14:12:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8744E40542
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=aleksander.lobakin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=mXBK9/3y
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8744E40542
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 14:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795097531; x=1826633531;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=W7TpKnjl2mcPF5Sy4OW9j1RFLWHb2bqVvX3ejaRohno=;
 b=mXBK9/3yBAzRarMWwS7jmzJm47xzy4T6QROM/XQ3YxuzwxCWwYVL9j5E
 QnEShtVaY3fz1xf+PM3IS6fY7CDxN3Pih1N1/gc7/x7PCBlrfZ3jw1qGi
 OEsIi4IlE/YoyJBKuvQREfBijtUzgNfrpxjwdb1gbQFD3cE+JHtlar+eu
 wE3z7hfCmLUrtD2GdKOZ2KdfdOJ54ZpQBV6Qx08o9GwJjrurhVkJr7a3x
 FIXvAr7AqP72fchyFeqjLYD4iK/WJn/PUCpoPLM+8yeUhksAyfEmItOrD
 mqjql3S0yLi3rwjE597eUgo5KOf0PRCYxH2jLDCZNtXTUEUI3pYyb5Gew g==;
X-CSE-ConnectionGUID: 8k626zAeTsm0pEiF0f5Zlw==
X-CSE-MsgGUID: Y7t/PjaOQEC54WUlIrGQxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3835643"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; d="scan'208,223";a="3835643"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 06:12:11 -0800
X-CSE-ConnectionGUID: pRwE00dFR0ShscyRdhJaWg==
X-CSE-MsgGUID: bZ/pUFf+RNqmhT8oCWdD4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; d="scan'208,223";a="10476165"
Received: from newjersey.igk.intel.com ([10.102.20.203])
 by orviesa002.jf.intel.com with ESMTP; 19 Nov 2026 06:12:08 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 YiFei Zhu <zhuyifei@google.com>, Patryk Holda <patryk.holda@intel.com>
Subject: [PATCH iwl-next v3 3/3] idpf: add flow-based XDP fallback for FWs
 without Tx FIFO support
Date: Thu, 19 Nov 2026 15:09:38 +0100
Message-ID: <20261119140938.1363722-4-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119140938.1363722-1-aleksander.lobakin@intel.com>
References: <20261119140938.1363722-1-aleksander.lobakin@intel.com>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From the first days of XDP implementation in idpf, it relied and
worked solely on top of the queue-based scheduling Tx mode, which
basically means simple FIFO. However, turned out not every firmware
supports this mode and XDP doesn't work there at all.

Since the flow-based scheduling Tx mode is mandatory and supported
by every FW, introduce a simple fallback guarded by a static key
to not hurt the more performant mode. The FB mode generates a
completion for each packet and never guarantees that there won't
be any out-of-order completions. Serialize that using a bitmap of
completed descriptors and report contiguous blocks of free bits to
match XDP and XSk expectations and avoid further code complication.
In case of multi-buffer frames, only the bit corresponding to the
first descriptor is toggled as there will be only one completion
for the entire packet carrying the index of this first descriptor.

The usage of a bitmap on hotpath might sound scary, but this
fallback is able to reach around 70% of the QB mode's performance,
which is comparable to what ice gives us. The main bottlenecks are
unlikely()s and one completion per each packet, while in the QB
mode we have one completion per batch (which might contain 64 or
even 128 frames), plus the size of the completion descriptor is
8 bytes in this mode (4 bytes in the QB mode), which means a lot
of additional PCI traffic.

bloat-o-meter shows .text increase in about 2 Kb without adding new
functions or uninlining any of the existing ones. I played a bunch
with inlining and uninlining certain pieces or the whole fallback,
but the compiler collapses and optimizes libeth templates so hardly
so that each additional external call only makes things worse.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: YiFei Zhu <zhuyifei@google.com>
Tested-by: Patryk Holda <patryk.holda@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |  18 ++-
 drivers/net/ethernet/intel/idpf/xdp.h       |  60 +++++++++
 include/net/libeth/xdp.h                    |  13 ++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c |  19 ++-
 drivers/net/ethernet/intel/idpf/xdp.c       | 141 +++++++++++++++++++-
 5 files changed, 233 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 4e67837cf35f..283ed9bdf933 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -628,12 +628,14 @@ libeth_cacheline_set_assert(struct idpf_rx_queue,
  * @clean_budget: singleq only, queue cleaning budget
  * @cleaned_pkts: Number of packets cleaned for the above said case
  * @refillq: Pointer to refill queue
+ * @cached_tstamp_caps: Tx timestamp capabilities negotiated with the CP
+ * @tstamp_task: Work that handles Tx timestamp read
  * @pending: number of pending descriptors to send in QB
  * @xdp_tx: number of pending &xdp_buff or &xdp_frame buffers
  * @timer: timer for XDP Tx queue cleanup
  * @xdp_lock: lock for XDP Tx queues sharing
- * @cached_tstamp_caps: Tx timestamp capabilities negotiated with the CP
- * @tstamp_task: Work that handles Tx timestamp read
+ * @pending_mask: mask of buffers waiting for completion in the FB XDP mode
+ * @curr_tag: current completion tag written to Tx descs in the FB XDP mode
  * @stats_sync: See struct u64_stats_sync
  * @q_stats: See union idpf_tx_queue_stats
  * @q_id: Queue id
@@ -695,6 +697,9 @@ struct idpf_tx_queue {
 			u16 cleaned_pkts;
 
 			struct idpf_sw_queue *refillq;
+
+			struct idpf_ptp_vport_tx_tstamp_caps *cached_tstamp_caps;
+			struct work_struct *tstamp_task;
 		};
 		struct {
 			u32 pending;
@@ -702,12 +707,12 @@ struct idpf_tx_queue {
 
 			struct libeth_xdpsq_timer *timer;
 			struct libeth_xdpsq_lock xdp_lock;
+
+			unsigned long *pending_mask;
+			u32 curr_tag;
 		};
 	};
 
-	struct idpf_ptp_vport_tx_tstamp_caps *cached_tstamp_caps;
-	struct work_struct *tstamp_task;
-
 	struct u64_stats_sync stats_sync;
 	struct idpf_tx_queue_stats q_stats;
 	__cacheline_group_end_aligned(read_write);
@@ -724,8 +729,7 @@ struct idpf_tx_queue {
 	__cacheline_group_end_aligned(cold);
 };
 libeth_cacheline_set_assert(struct idpf_tx_queue, 64,
-			    104 +
-			    offsetof(struct idpf_tx_queue, cached_tstamp_caps) -
+			    96 + offsetof(struct idpf_tx_queue, tstamp_task) -
 			    offsetofend(struct idpf_tx_queue, timer) +
 			    offsetof(struct idpf_tx_queue, q_stats) -
 			    offsetofend(struct idpf_tx_queue, tstamp_task),
diff --git a/drivers/net/ethernet/intel/idpf/xdp.h b/drivers/net/ethernet/intel/idpf/xdp.h
index 63e56f7d43e0..1a657feb6d5b 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.h
+++ b/drivers/net/ethernet/intel/idpf/xdp.h
@@ -8,6 +8,10 @@
 
 #include "idpf_txrx.h"
 
+struct idpf_q_vec_rsrc;
+
+DECLARE_STATIC_KEY_FALSE(idpf_xdp_fb);
+
 int idpf_xdp_rxq_info_init(struct idpf_rx_queue *rxq);
 int idpf_xdp_rxq_info_init_all(const struct idpf_q_vec_rsrc *rsrc);
 void idpf_xdp_rxq_info_deinit(struct idpf_rx_queue *rxq, u32 model);
@@ -21,6 +25,50 @@ void idpf_xdpsqs_put(const struct idpf_vport *vport);
 u32 idpf_xdpsq_poll(struct idpf_tx_queue *xdpsq, u32 budget);
 bool idpf_xdp_tx_flush_bulk(struct libeth_xdp_tx_bulk *bq, u32 flags);
 
+static inline void idpf_xdp_tx_xmit_fb(struct libeth_xdp_tx_desc desc, u32 i,
+				       const struct libeth_xdpsq *sq, u64 priv)
+{
+	struct idpf_tx_queue *xdpsq = libeth_xdpsq_to_sq(sq,
+							 struct idpf_tx_queue,
+							 next_to_use);
+	struct idpf_flex_tx_sched_desc *tx_desc = sq->descs;
+	bool last = !!(desc.flags & LIBETH_XDP_TX_LAST);
+	u32 tag = xdpsq->curr_tag;
+	u32 cmd;
+
+	if (tag == U32_MAX) {
+		__set_bit(i, xdpsq->pending_mask);
+		xdpsq->curr_tag = i;
+		tag = i;
+	}
+
+	if (last)
+		xdpsq->curr_tag = U32_MAX;
+
+	cmd = FIELD_PREP(IDPF_TXD_FLEX_FLOW_DTYPE_M,
+			 IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE);
+	if (last)
+		cmd |= IDPF_TXD_FLEX_FLOW_CMD_EOP;
+	if (priv && (desc.flags & LIBETH_XDP_TX_CSUM))
+		cmd |= IDPF_TXD_FLEX_FLOW_CMD_CS_EN;
+
+	desc.len &= IDPF_TXD_FLEX_FLOW_BUFSIZE_M;
+
+	tx_desc = &tx_desc[i];
+	tx_desc->buf_addr = cpu_to_le64(desc.addr);
+
+#ifdef __LIBETH_WORD_ACCESS
+	*(u64 *)&tx_desc->qw1 = ((u64)desc.len << 48) | ((u64)tag << 32) | cmd;
+#else
+	tx_desc->qw1.rxr_bufsize = cpu_to_le16(desc.len);
+	tx_desc->qw1.compl_tag = cpu_to_le16(tag);
+	tx_desc->qw1.ts[0] = 0;
+	tx_desc->qw1.ts[1] = 0;
+	tx_desc->qw1.ts[2] = 0;
+	tx_desc->qw1.cmd_dtype = cmd;
+#endif
+}
+
 /**
  * idpf_xdp_tx_xmit - produce a single HW Tx descriptor out of XDP desc
  * @desc: XDP descriptor to pull the DMA address and length from
@@ -34,6 +82,14 @@ static inline void idpf_xdp_tx_xmit(struct libeth_xdp_tx_desc desc, u32 i,
 	struct idpf_flex_tx_desc *tx_desc = sq->descs;
 	u32 cmd;
 
+	if (static_branch_unlikely(&idpf_xdp_fb) &&
+	    idpf_queue_has(FLOW_SCH_EN,
+			   libeth_xdpsq_to_sq(sq, struct idpf_tx_queue,
+					      next_to_use))) {
+		idpf_xdp_tx_xmit_fb(desc, i, sq, priv);
+		return;
+	}
+
 	cmd = FIELD_PREP(IDPF_FLEX_TXD_QW1_DTYPE_M,
 			 IDPF_TX_DESC_DTYPE_FLEX_L2TAG1_L2TAG2);
 	if (desc.flags & LIBETH_XDP_TX_LAST)
@@ -57,6 +113,10 @@ static inline void idpf_xdpsq_set_rs(const struct idpf_tx_queue *xdpsq)
 {
 	u32 ntu, cmd;
 
+	if (static_branch_unlikely(&idpf_xdp_fb) &&
+	    idpf_queue_has(FLOW_SCH_EN, xdpsq))
+		return;
+
 	ntu = xdpsq->next_to_use;
 	if (unlikely(!ntu))
 		ntu = xdpsq->desc_count;
diff --git a/include/net/libeth/xdp.h b/include/net/libeth/xdp.h
index 898723ab62e8..ed61d83bda2d 100644
--- a/include/net/libeth/xdp.h
+++ b/include/net/libeth/xdp.h
@@ -430,6 +430,19 @@ struct libeth_xdpsq {
 	struct libeth_xdpsq_lock	*lock;
 };
 
+/**
+ * libeth_xdpsq_to_sq - get SQ pointer from an XDPSQ pointer
+ * @xdpsq: &libeth_xdpsq corresponding to the queue
+ * @type: typeof() of the driver Tx queue structure
+ * @member: name of the NTU field inside @type
+ *
+ * Some of the sending callbacks take only &libeth_xdpsq pointer and no pointer
+ * to the actual driver Tx queue structure. Use this helper to quickly jump to
+ * the latter when needed.
+ */
+#define libeth_xdpsq_to_sq(xdpsq, type, member)				      \
+	container_of_const((xdpsq)->ntu, type, member)
+
 /**
  * struct libeth_xdp_tx_desc - abstraction for an XDP Tx descriptor
  * @addr: DMA address of the frame
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index e32e368209ee..169af2812fb3 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -179,10 +179,11 @@ static int idpf_tx_buf_alloc_all(struct idpf_tx_queue *tx_q)
 	/* Allocate book keeping buffers only. Buffers to be supplied to HW
 	 * are allocated by kernel network stack and received as part of skb
 	 */
-	if (idpf_queue_has(FLOW_SCH_EN, tx_q))
+	if (idpf_queue_has(FLOW_SCH_EN, tx_q) && !idpf_queue_has(XDP, tx_q))
 		tx_q->buf_pool_size = U16_MAX;
 	else
 		tx_q->buf_pool_size = tx_q->desc_count;
+
 	tx_q->tx_buf = kzalloc_objs(*tx_q->tx_buf, tx_q->buf_pool_size);
 	if (!tx_q->tx_buf)
 		return -ENOMEM;
@@ -227,7 +228,7 @@ static int idpf_tx_desc_alloc(const struct idpf_vport *vport,
 
 	idpf_xsk_setup_queue(vport, tx_q, VIRTCHNL2_QUEUE_TYPE_TX);
 
-	if (!idpf_queue_has(FLOW_SCH_EN, tx_q))
+	if (!idpf_queue_has(FLOW_SCH_EN, tx_q) || idpf_queue_has(XDP, tx_q))
 		return 0;
 
 	refillq = tx_q->refillq;
@@ -1057,6 +1058,13 @@ static void idpf_clean_queue_set(const struct idpf_queue_set *qs)
 			if (idpf_queue_has(XDP, q->txq)) {
 				q->txq->pending = 0;
 				q->txq->xdp_tx = 0;
+
+				if (static_branch_unlikely(&idpf_xdp_fb) &&
+				    idpf_queue_has(FLOW_SCH_EN, q->txq)) {
+					bitmap_zero(q->txq->pending_mask,
+						    q->txq->desc_count);
+					q->txq->curr_tag = U32_MAX;
+				}
 			} else {
 				q->txq->txq_grp->num_completions_pending = 0;
 			}
@@ -1319,7 +1327,8 @@ static void idpf_txq_group_rel(struct idpf_q_vec_rsrc *rsrc)
 			if (!txq_grp->txqs[j])
 				continue;
 
-			if (idpf_queue_has(FLOW_SCH_EN, txq_grp->txqs[j])) {
+			if (idpf_queue_has(FLOW_SCH_EN, txq_grp->txqs[j]) &&
+			    !idpf_queue_has(XDP, txq_grp->txqs[j])) {
 				kfree(txq_grp->txqs[j]->refillq);
 				txq_grp->txqs[j]->refillq = NULL;
 			}
@@ -1442,6 +1451,8 @@ static int idpf_vport_init_fast_path_txqs(struct idpf_vport *vport,
 {
 	struct idpf_ptp_vport_tx_tstamp_caps *caps = vport->tx_tstamp_caps;
 	struct work_struct *tstamp_task = &vport->tstamp_task;
+	/* __IDPF_Q_XDP is never set yet at this point */
+	u32 end = min_not_zero(rsrc->xdp_txq_offset, U32_MAX);
 	int k = 0;
 
 	vport->txqs = kzalloc_objs(*vport->txqs, rsrc->num_txq);
@@ -1456,7 +1467,7 @@ static int idpf_vport_init_fast_path_txqs(struct idpf_vport *vport,
 			vport->txqs[k] = tx_grp->txqs[j];
 			vport->txqs[k]->idx = k;
 
-			if (!caps)
+			if (!caps || k >= end)
 				continue;
 
 			vport->txqs[k]->cached_tstamp_caps = caps;
diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
index 48320ea004df..0b4ead7fbcaf 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.c
+++ b/drivers/net/ethernet/intel/idpf/xdp.c
@@ -7,6 +7,8 @@
 #include "xdp.h"
 #include "xsk.h"
 
+DEFINE_STATIC_KEY_FALSE(idpf_xdp_fb);
+
 static int idpf_rxq_for_each(const struct idpf_q_vec_rsrc *rsrc,
 			     int (*fn)(struct idpf_rx_queue *rxq, void *arg),
 			     void *arg)
@@ -151,11 +153,13 @@ static void idpf_xdp_tx_timer(struct work_struct *work);
 
 int idpf_xdpsqs_get(const struct idpf_vport *vport)
 {
-	struct libeth_xdpsq_timer **timers __free(kvfree) = NULL;
-	struct net_device *dev;
+	struct libeth_xdpsq_timer **timers;
+	const struct net_device *dev;
+	unsigned long **masks;
+	bool fb, warn;
 	u32 sqs;
 
-	if (!idpf_xdp_enabled(vport))
+	if (!idpf_xdp_enabled(vport) || !vport->num_xdp_txq)
 		return 0;
 
 	timers = kvzalloc_objs(*timers, vport->num_xdp_txq);
@@ -169,13 +173,42 @@ int idpf_xdpsqs_get(const struct idpf_vport *vport)
 			for (int j = i - 1; j >= 0; j--)
 				kfree(timers[j]);
 
-			return -ENOMEM;
+			goto err_timers;
 		}
 	}
 
 	dev = vport->netdev;
 	sqs = vport->dflt_qv_rsrc.xdp_txq_offset;
 
+	fb = !idpf_is_cap_ena(vport->adapter, IDPF_OTHER_CAPS,
+			      VIRTCHNL2_CAP_SPLITQ_QSCHED);
+	if (!fb)
+		goto setup;
+
+	masks = kvzalloc_objs(*masks, vport->num_xdp_txq);
+	if (!masks)
+		goto err_masks;
+
+	for (u32 i = 0; i < vport->num_xdp_txq; i++) {
+		masks[i] = bitmap_zalloc_node(vport->txqs[sqs + i]->desc_count,
+					      GFP_KERNEL, cpu_to_mem(i));
+		if (!masks[i]) {
+			for (int j = i - 1; j >= 0; j--)
+				bitmap_free(masks[j]);
+
+			kvfree(masks);
+			goto err_masks;
+		}
+	}
+
+	warn = !static_key_enabled(&idpf_xdp_fb);
+	static_branch_inc(&idpf_xdp_fb);
+
+	if (warn && net_ratelimit())
+		netdev_warn(dev,
+			    "The FW doesn't support Tx in FIFO mode, XDP Tx performance might be suboptimal\n");
+
+setup:
 	for (u32 i = sqs; i < vport->num_txq; i++) {
 		struct idpf_tx_queue *xdpsq = vport->txqs[i];
 
@@ -183,8 +216,8 @@ int idpf_xdpsqs_get(const struct idpf_vport *vport)
 		kfree(xdpsq->refillq);
 		xdpsq->refillq = NULL;
 
-		idpf_queue_clear(FLOW_SCH_EN, xdpsq);
-		idpf_queue_clear(FLOW_SCH_EN, xdpsq->complq);
+		idpf_queue_assign(FLOW_SCH_EN, xdpsq, fb);
+		idpf_queue_assign(FLOW_SCH_EN, xdpsq->complq, fb);
 		idpf_queue_set(NOIRQ, xdpsq);
 		idpf_queue_set(XDP, xdpsq);
 		idpf_queue_set(XDP, xdpsq->complq);
@@ -197,17 +230,36 @@ int idpf_xdpsqs_get(const struct idpf_vport *vport)
 		xdpsq->pending = 0;
 		xdpsq->xdp_tx = 0;
 		xdpsq->thresh = libeth_xdp_queue_threshold(xdpsq->desc_count);
+
+		if (static_branch_unlikely(&idpf_xdp_fb) && fb) {
+			xdpsq->pending_mask = masks[i - sqs];
+			xdpsq->curr_tag = U32_MAX;
+		}
 	}
 
+	kvfree(timers);
+	if (fb)
+		kvfree(masks);
+
 	return 0;
+
+err_masks:
+	for (u32 i = 0; i < vport->num_xdp_txq; i++)
+		kfree(timers[i]);
+
+err_timers:
+	kvfree(timers);
+
+	return -ENOMEM;
 }
 
 void idpf_xdpsqs_put(const struct idpf_vport *vport)
 {
 	struct net_device *dev;
+	bool fb = false;
 	u32 sqs;
 
-	if (!idpf_xdp_enabled(vport))
+	if (!idpf_xdp_enabled(vport) || !vport->num_xdp_txq)
 		return;
 
 	dev = vport->netdev;
@@ -222,10 +274,22 @@ void idpf_xdpsqs_put(const struct idpf_vport *vport)
 		libeth_xdpsq_deinit_timer(xdpsq->timer);
 		libeth_xdpsq_put(&xdpsq->xdp_lock, dev);
 
+		if (static_branch_unlikely(&idpf_xdp_fb) &&
+		    idpf_queue_has(FLOW_SCH_EN, xdpsq)) {
+			bitmap_free(xdpsq->pending_mask);
+			xdpsq->pending_mask = NULL;
+			xdpsq->curr_tag = 0;
+
+			fb = true;
+		}
+
 		kfree(xdpsq->timer);
 		xdpsq->refillq = NULL;
 		idpf_queue_clear(NOIRQ, xdpsq);
 	}
+
+	if (fb)
+		static_branch_dec(&idpf_xdp_fb);
 }
 
 static int idpf_xdp_parse_cqe(const struct idpf_splitq_4b_tx_compl_desc *desc,
@@ -255,6 +319,65 @@ static int idpf_xdp_parse_cqe(const struct idpf_splitq_4b_tx_compl_desc *desc,
 #endif
 }
 
+static u32 idpf_xdpsq_poll_fb(struct idpf_tx_queue *xdpsq, u32 budget)
+{
+	struct idpf_compl_queue *cq = xdpsq->complq;
+	unsigned long *mask = xdpsq->pending_mask;
+	u32 done_frames, tx_cnt, new_ntc;
+	u32 ntc = cq->next_to_clean;
+	u32 cnt = cq->desc_count;
+	bool gen;
+
+	gen = idpf_queue_has(GEN_CHK, cq);
+
+	for (done_frames = 0; done_frames < budget; ) {
+		int ret;
+
+		ret = idpf_xdp_parse_cqe(&cq->comp[ntc].common, gen);
+		if (ret >= 0) {
+			__clear_bit(ret, mask);
+			done_frames++;
+
+			goto next;
+		}
+
+		switch (ret) {
+		case -ENODATA:
+			goto out;
+		case -EINVAL:
+			break;
+		}
+
+next:
+		if (unlikely(++ntc == cnt)) {
+			ntc = 0;
+			gen = !gen;
+			idpf_queue_change(GEN_CHK, cq);
+		}
+	}
+
+out:
+	cq->next_to_clean = ntc;
+
+	if (unlikely(!done_frames))
+		return 0;
+
+	tx_cnt = xdpsq->desc_count;
+
+	/* Don't go past next_to_use */
+	__set_bit(xdpsq->next_to_use, mask);
+
+	new_ntc = find_next_bit(mask, tx_cnt, xdpsq->next_to_clean);
+	done_frames = new_ntc - xdpsq->next_to_clean;
+
+	if (new_ntc == tx_cnt)
+		done_frames += find_first_bit(mask, tx_cnt);
+
+	__clear_bit(xdpsq->next_to_use, mask);
+
+	return done_frames;
+}
+
 u32 idpf_xdpsq_poll(struct idpf_tx_queue *xdpsq, u32 budget)
 {
 	struct idpf_compl_queue *cq = xdpsq->complq;
@@ -265,6 +388,10 @@ u32 idpf_xdpsq_poll(struct idpf_tx_queue *xdpsq, u32 budget)
 	u32 done_frames;
 	bool gen;
 
+	if (static_branch_unlikely(&idpf_xdp_fb) &&
+	    idpf_queue_has(FLOW_SCH_EN, xdpsq))
+		return idpf_xdpsq_poll_fb(xdpsq, budget);
+
 	gen = idpf_queue_has(GEN_CHK, cq);
 
 	for (done_frames = 0; done_frames < budget; ) {
-- 
2.56.1

