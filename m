Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494F1C5DF81
	for <intel-wired-lan@archiver.kernel.org>; Tue, 18 Aug 2026 15:55:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F33D8408A5;
	Tue, 18 Aug 2026 15:55:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qeHEXtjTWUPH; Tue, 18 Aug 2026 15:55:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5AAB44089A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787068535;
	bh=0UrsHYpwduIVRiS+hgmK00Mxc2GcJS9MAz23YRB0is4=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QxTg2EFSiqDVEz4/FHT6bwjxOVysavvk6tNo2BSUlUIlyVB1/bXxKP9y8qKhrttnh
	 ySxBzgAHQ9JkmTZBavhJtdr5DFlIqAiV1OpG3T+ILPd/e+O0udoNSgR8r4o7dwwS7O
	 jSs/Hbc5MX9WjnzGXdv8dkvfRJJKbq2Ur8tpSyXaieu0z1Dn1fUAfUvTUg4lc/hkwb
	 yO7jaFq2nrdA+t987iJlbmSTsKEPGuxNlsswmEteN8UY7kh45wrWgVeQdBS1E8zirs
	 AyYznTBQc9VbDPsJGBU9sGrLlnv/JrlidX7x6XTqznxJoOu+CAwX8ztQVXw9Ydcqyt
	 HiFGNM5jrzB+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5AAB44089A;
	Tue, 18 Aug 2026 15:55:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AA677282
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Aug 2026 15:55:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8B341401E9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Aug 2026 15:55:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kYvyIdbKC_LZ for <intel-wired-lan@lists.osuosl.org>;
 Tue, 18 Aug 2026 15:55:33 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=aleksander.lobakin@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7589C40333
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7589C40333
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Yp27KGD2
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7589C40333
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Aug 2026 15:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787068533; x=1818604533;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=yEi0XZpOkgFPsaJijaL4IkH0cSsDe0QMWkd8OkfTQP4=;
 b=Yp27KGD2MK5P/blMkj40ZN0hhE5s9HlCADzwx075zoBi+dX5LAttSXP5
 8wbfbh1vkFa8dNP8Scv0iGafMa/8/gu+w0MApSHEmo2RVCF71FgpgyUX4
 uXBoovI59x7ZK6FTN96UBtgFjz6UCUNShfEzA395ARVXeEIB3Qrqp9hVT
 IuAnFKU9Cb93ZTU4H9fept7uapQIew4sKWw+TPYsO9vbL4rj9ctH3doXK
 dLc0YRNDYQ7BYdLPCzVAoxTdOC4uack157LA7j8sNvsTPr20l7beP2KFT
 Ksd6jVWGpMZyz+YUYwe1t3HlIyxvWjgTOkNUvPBxV8BvXZZJtyBshikG8 g==;
X-CSE-ConnectionGUID: WLSqJW39QWichEGup6GI7w==
X-CSE-MsgGUID: 5l+jLr5rSvWQv0t9woB0Jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="97903376"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208,223";a="97903376"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 08:55:31 -0700
X-CSE-ConnectionGUID: 2EUtB9HyT6GtDYXaqoWdog==
X-CSE-MsgGUID: 68K4VxMpRRmK27v/GQiB9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
 d="scan'208,223";a="261059294"
Received: from newjersey.igk.intel.com ([10.102.20.203])
 by fmviesa006.fm.intel.com with ESMTP; 18 Aug 2026 08:55:27 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 YiFei Zhu <zhuyifei@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 18 Aug 2026 17:51:01 +0200
Message-ID: <20260818155101.2416665-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Intel-wired-lan] [PATCH iwl-next v2] idpf: add flow-based XDP
 fallback for FWs without Tx FIFO support
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Unsubscribe: <https://lists.osuosl.org/mailman/options/intel-wired-lan>, 
 <mailto:intel-wired-lan-request@osuosl.org?subject=unsubscribe>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From the first days of XDP implementation in idpf, it relied and
worked solely on top of the queue-based scheduling Tx mode, which
basically means simple FIFO. However, turned out not every firmware
supports this mode and XDP doesn't work there at all.

Since the flow-based scheduling Tx mode is mandatory and supported
by every FW, introduce a simple fallback guarded by a static key
to not hurt the more performant mode. The FB mode generates a
completion for each Tx descriptor and never guarantees that there
won't be any out-of-order completions. Serialize that using a
bitmap of completed descriptors and report contiguous blocks of
free bits to match XDP and XSk expectations and avoid further
code complication.

The usage of a bitmap on hotpath might sound scary, but this
fallback is able to reach around 70% of the QB mode's performance,
which is comparable to what ice gives us. The main bottlenecks are
unlikely()s and one completion per each descriptor, while in the QB
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
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
I know the window is closed, this is to trigger the validation and
for eventual reviews.

From v1[0]:
* rework static key management: move to idpf_xdpsqs_{get,put}() to
  avoid refcount imbalance issues as .ndo_bpf() is not always called
  in pairs (hardware reset etc.) (Sashiko, internal Sashiko);
* don't zero the whole pending window but only the frames sent since
  the last batch to avoid missed OOO completions (internal Sashiko);
* micro-optimize idpf_xdpsq_set_rs{,_fb}().

Regarding the rest of comments:

> Could this sentinel bit cause a deadlock if the queue is completely full?
> When full, next_to_use equals next_to_clean. If the hardware just completed
> the oldest descriptor, its bit would be cleared, but this __set_bit would
> blindly overwrite it back to 1. The completion would be ignored and the
> queue might permanently stall.

Intel HW works that way that we can't fill the ring completely. We need to
always leave at least one descriptor free, otherwise ntc will equal ntu
in the HW and the queue will stall. So in all sending routines, our budget
is limited to `free - 1`, meaning the situation described above can't happen
(next_to_use never has its bit set to 1, so it's safe to use this bit as a
guard and reset it after the bitmap search is complete).

> Is ret bounded before it is used as a bitmap index here?
> idpf_xdp_parse_cqe() returns upper_16_bits(val) straight from the device
> completion descriptor, so ret can be anywhere in [0, 65535].  pending_mask
> is allocated with bitmap_zalloc_node(desc_count), where desc_count is at
> most IDPF_MAX_DESCS.

No cards under this driver have ever been seen writing garbage instead of
the completion tag.

[0] https://lore.kernel.org/intel-wired-lan/20260708151327.1091570-1-aleksander.lobakin@intel.com
---
 drivers/net/ethernet/intel/idpf/idpf.h      |   1 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |  18 +--
 drivers/net/ethernet/intel/idpf/xdp.h       |  73 ++++++++++-
 include/net/libeth/xdp.h                    |  13 ++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c |  12 +-
 drivers/net/ethernet/intel/idpf/xdp.c       | 131 +++++++++++++++++++-
 6 files changed, 229 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 470bc23c844c..1e897e131cb2 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -383,6 +383,7 @@ struct idpf_vport {
 	struct idpf_tx_queue **txqs;
 	u16 num_txq;
 	u16 num_xdp_txq;
+	bool xdpsq_fb;
 	bool xdpsq_share;
 	struct bpf_prog *xdp_prog;
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index e8a632ffa61e..bd31151f0a89 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -625,12 +625,14 @@ libeth_cacheline_set_assert(struct idpf_rx_queue,
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
+ * @last_ntu: @next_to_use from the previous batch in the FB XDP mode
  * @stats_sync: See struct u64_stats_sync
  * @q_stats: See union idpf_tx_queue_stats
  * @q_id: Queue id
@@ -689,6 +691,9 @@ struct idpf_tx_queue {
 			u16 cleaned_pkts;
 
 			struct idpf_sw_queue *refillq;
+
+			struct idpf_ptp_vport_tx_tstamp_caps *cached_tstamp_caps;
+			struct work_struct *tstamp_task;
 		};
 		struct {
 			u32 pending;
@@ -696,12 +701,12 @@ struct idpf_tx_queue {
 
 			struct libeth_xdpsq_timer *timer;
 			struct libeth_xdpsq_lock xdp_lock;
+
+			unsigned long *pending_mask;
+			u32 last_ntu;
 		};
 	};
 
-	struct idpf_ptp_vport_tx_tstamp_caps *cached_tstamp_caps;
-	struct work_struct *tstamp_task;
-
 	struct u64_stats_sync stats_sync;
 	struct idpf_tx_queue_stats q_stats;
 	__cacheline_group_end_aligned(read_write);
@@ -718,8 +723,7 @@ struct idpf_tx_queue {
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
index 63e56f7d43e0..95e47ea2ccba 100644
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
@@ -15,12 +19,40 @@ void idpf_xdp_rxq_info_deinit_all(const struct idpf_q_vec_rsrc *rsrc);
 void idpf_xdp_copy_prog_to_rqs(const struct idpf_q_vec_rsrc *rsrc,
 			       struct bpf_prog *xdp_prog);
 
-int idpf_xdpsqs_get(const struct idpf_vport *vport);
-void idpf_xdpsqs_put(const struct idpf_vport *vport);
+int idpf_xdpsqs_get(struct idpf_vport *vport);
+void idpf_xdpsqs_put(struct idpf_vport *vport);
 
 u32 idpf_xdpsq_poll(struct idpf_tx_queue *xdpsq, u32 budget);
 bool idpf_xdp_tx_flush_bulk(struct libeth_xdp_tx_bulk *bq, u32 flags);
 
+static inline void idpf_xdp_tx_xmit_fb(struct libeth_xdp_tx_desc desc, u32 i,
+				       const struct libeth_xdpsq *sq, u64 priv)
+{
+	struct idpf_flex_tx_sched_desc *tx_desc = sq->descs;
+	u32 cmd;
+
+	cmd = FIELD_PREP(IDPF_TXD_FLEX_FLOW_DTYPE_M,
+			 IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE);
+	if (desc.flags & LIBETH_XDP_TX_LAST)
+		cmd |= IDPF_TXD_FLEX_FLOW_CMD_EOP;
+	if (priv && (desc.flags & LIBETH_XDP_TX_CSUM))
+		cmd |= IDPF_TXD_FLEX_FLOW_CMD_CS_EN;
+
+	tx_desc = &tx_desc[i];
+	tx_desc->buf_addr = cpu_to_le64(desc.addr);
+
+#ifdef __LIBETH_WORD_ACCESS
+	*(u64 *)&tx_desc->qw1 = ((u64)desc.len << 48) | ((u64)i << 32) | cmd;
+#else
+	tx_desc->qw1.rxr_bufsize = cpu_to_le16(desc.len);
+	tx_desc->qw1.compl_tag = cpu_to_le16(i);
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
@@ -34,6 +66,14 @@ static inline void idpf_xdp_tx_xmit(struct libeth_xdp_tx_desc desc, u32 i,
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
@@ -53,12 +93,34 @@ static inline void idpf_xdp_tx_xmit(struct libeth_xdp_tx_desc desc, u32 i,
 #endif
 }
 
-static inline void idpf_xdpsq_set_rs(const struct idpf_tx_queue *xdpsq)
+static inline void idpf_xdpsq_set_rs_fb(struct idpf_tx_queue *xdpsq)
+{
+	u32 ntu = xdpsq->next_to_use;
+	u32 old = xdpsq->last_ntu;
+
+	if (old > ntu) {
+		bitmap_set(xdpsq->pending_mask, old, xdpsq->desc_count - old);
+		if (ntu)
+			bitmap_set(xdpsq->pending_mask, 0, ntu);
+	} else {
+		bitmap_set(xdpsq->pending_mask, old, ntu - old);
+	}
+
+	xdpsq->last_ntu = ntu;
+}
+
+static __always_inline void idpf_xdpsq_set_rs(struct idpf_tx_queue *xdpsq)
 {
 	u32 ntu, cmd;
 
+	if (static_branch_unlikely(&idpf_xdp_fb) &&
+	    idpf_queue_has(FLOW_SCH_EN, xdpsq)) {
+		idpf_xdpsq_set_rs_fb(xdpsq);
+		return;
+	}
+
 	ntu = xdpsq->next_to_use;
-	if (unlikely(!ntu))
+	if (!ntu)
 		ntu = xdpsq->desc_count;
 
 	cmd = FIELD_PREP(IDPF_FLEX_TXD_QW1_CMD_M, IDPF_TX_DESC_CMD_RS);
@@ -84,7 +146,8 @@ static inline void idpf_xdpsq_update_tail(const struct idpf_tx_queue *xdpsq)
  * Set the RS bit ("end of batch"), bump the tail, and queue the cleanup timer.
  * To be called after a NAPI polling loop, at the end of .ndo_xdp_xmit() etc.
  */
-static inline void idpf_xdp_tx_finalize(void *_xdpsq, bool sent, bool flush)
+static __always_inline void idpf_xdp_tx_finalize(void *_xdpsq, bool sent,
+						 bool flush)
 {
 	struct idpf_tx_queue *xdpsq = _xdpsq;
 
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
index 89355368c3b3..209764a8070c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -227,7 +227,7 @@ static int idpf_tx_desc_alloc(const struct idpf_vport *vport,
 
 	idpf_xsk_setup_queue(vport, tx_q, VIRTCHNL2_QUEUE_TYPE_TX);
 
-	if (!idpf_queue_has(FLOW_SCH_EN, tx_q))
+	if (!idpf_queue_has(FLOW_SCH_EN, tx_q) || idpf_queue_has(XDP, tx_q))
 		return 0;
 
 	refillq = tx_q->refillq;
@@ -1058,6 +1058,13 @@ static void idpf_clean_queue_set(const struct idpf_queue_set *qs)
 			if (idpf_queue_has(XDP, q->txq)) {
 				q->txq->pending = 0;
 				q->txq->xdp_tx = 0;
+
+				if (static_branch_unlikely(&idpf_xdp_fb) &&
+				    idpf_queue_has(FLOW_SCH_EN, q->txq)) {
+					bitmap_zero(q->txq->pending_mask,
+						    q->txq->desc_count);
+					q->txq->last_ntu = 0;
+				}
 			} else {
 				q->txq->txq_grp->num_completions_pending = 0;
 			}
@@ -1320,7 +1327,8 @@ static void idpf_txq_group_rel(struct idpf_q_vec_rsrc *rsrc)
 			if (!txq_grp->txqs[j])
 				continue;
 
-			if (idpf_queue_has(FLOW_SCH_EN, txq_grp->txqs[j])) {
+			if (idpf_queue_has(FLOW_SCH_EN, txq_grp->txqs[j]) &&
+			    !idpf_queue_has(XDP, txq_grp->txqs[j])) {
 				kfree(txq_grp->txqs[j]->refillq);
 				txq_grp->txqs[j]->refillq = NULL;
 			}
diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
index cbccd4546768..c771663677a5 100644
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
@@ -149,10 +151,12 @@ void idpf_xdp_copy_prog_to_rqs(const struct idpf_q_vec_rsrc *rsrc,
 
 static void idpf_xdp_tx_timer(struct work_struct *work);
 
-int idpf_xdpsqs_get(const struct idpf_vport *vport)
+int idpf_xdpsqs_get(struct idpf_vport *vport)
 {
 	struct libeth_xdpsq_timer **timers __free(kvfree) = NULL;
-	struct net_device *dev;
+	unsigned long **masks __free(kvfree) = NULL;
+	const struct net_device *dev;
+	bool warn;
 	u32 sqs;
 
 	if (!idpf_xdp_enabled(vport))
@@ -176,6 +180,34 @@ int idpf_xdpsqs_get(const struct idpf_vport *vport)
 	dev = vport->netdev;
 	sqs = vport->dflt_qv_rsrc.xdp_txq_offset;
 
+	vport->xdpsq_fb = !idpf_is_cap_ena(vport->adapter, IDPF_OTHER_CAPS,
+					   VIRTCHNL2_CAP_SPLITQ_QSCHED);
+	if (!vport->xdpsq_fb)
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
 
@@ -183,8 +215,8 @@ int idpf_xdpsqs_get(const struct idpf_vport *vport)
 		kfree(xdpsq->refillq);
 		xdpsq->refillq = NULL;
 
-		idpf_queue_clear(FLOW_SCH_EN, xdpsq);
-		idpf_queue_clear(FLOW_SCH_EN, xdpsq->complq);
+		idpf_queue_assign(FLOW_SCH_EN, xdpsq, vport->xdpsq_fb);
+		idpf_queue_assign(FLOW_SCH_EN, xdpsq->complq, vport->xdpsq_fb);
 		idpf_queue_set(NOIRQ, xdpsq);
 		idpf_queue_set(XDP, xdpsq);
 		idpf_queue_set(XDP, xdpsq->complq);
@@ -197,12 +229,25 @@ int idpf_xdpsqs_get(const struct idpf_vport *vport)
 		xdpsq->pending = 0;
 		xdpsq->xdp_tx = 0;
 		xdpsq->thresh = libeth_xdp_queue_threshold(xdpsq->desc_count);
+
+		if (static_branch_unlikely(&idpf_xdp_fb) && vport->xdpsq_fb) {
+			xdpsq->pending_mask = masks[i - sqs];
+			xdpsq->last_ntu = 0;
+		}
 	}
 
 	return 0;
+
+err_masks:
+	vport->xdpsq_fb = false;
+
+	for (u32 i = 0; i < vport->num_xdp_txq; i++)
+		kfree(timers[i]);
+
+	return -ENOMEM;
 }
 
-void idpf_xdpsqs_put(const struct idpf_vport *vport)
+void idpf_xdpsqs_put(struct idpf_vport *vport)
 {
 	struct net_device *dev;
 	u32 sqs;
@@ -222,10 +267,23 @@ void idpf_xdpsqs_put(const struct idpf_vport *vport)
 		libeth_xdpsq_deinit_timer(xdpsq->timer);
 		libeth_xdpsq_put(&xdpsq->xdp_lock, dev);
 
+		if (static_branch_unlikely(&idpf_xdp_fb) &&
+		    idpf_queue_has(FLOW_SCH_EN, xdpsq)) {
+			bitmap_free(xdpsq->pending_mask);
+			xdpsq->pending_mask = NULL;
+			xdpsq->last_ntu = 0;
+		}
+
 		kfree(xdpsq->timer);
 		xdpsq->refillq = NULL;
 		idpf_queue_clear(NOIRQ, xdpsq);
 	}
+
+	if (!vport->xdpsq_fb)
+		return;
+
+	static_branch_dec(&idpf_xdp_fb);
+	vport->xdpsq_fb = false;
 }
 
 static int idpf_xdp_parse_cqe(const struct idpf_splitq_4b_tx_compl_desc *desc,
@@ -250,6 +308,65 @@ static int idpf_xdp_parse_cqe(const struct idpf_splitq_4b_tx_compl_desc *desc,
 	return upper_16_bits(val);
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
@@ -260,6 +377,10 @@ u32 idpf_xdpsq_poll(struct idpf_tx_queue *xdpsq, u32 budget)
 	u32 done_frames;
 	bool gen;
 
+	if (static_branch_unlikely(&idpf_xdp_fb) &&
+	    idpf_queue_has(FLOW_SCH_EN, xdpsq))
+		return idpf_xdpsq_poll_fb(xdpsq, budget);
+
 	gen = idpf_queue_has(GEN_CHK, cq);
 
 	for (done_frames = 0; done_frames < budget; ) {
-- 
2.55.0

