Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9669DC5AC67
	for <intel-wired-lan@archiver.kernel.org>; Thu,  6 Aug 2026 23:29:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 60A9380F8E;
	Thu,  6 Aug 2026 23:29:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QAvkFGiFpRFd; Thu,  6 Aug 2026 23:29:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 29CF280F8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786058970;
	bh=uk1DBhl2SjEAtDClBoBuZQ0iwRCMwuffCjBsfq5FWJI=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=9lECIN+oI1o3gk5C4qNvKUMjnWGUpw1SP2AXcsljgu5o64RzuRxpooBVxKLgWLCfG
	 CRwZsKvZZf4/zXsWP4D5Xxa+m6pYJXeRjXiNQ3o34O/7YbznpRVaY5VCm9inWfyU76
	 vzfyH0U+EQfNntQdNcdcpZsskG0j7RpaUWxnzY7CZ7SQ8j/n61Zg3Rn4HTyFppXM83
	 J29ZbhbBB58Lb5yTQxE3SC0n1Fbv4U6w1IPgB6Rtceh3j1fAWDiY0aSkOJMMcUcUUt
	 xQIVMH8xxXWiRYuyZYqYjq6r7YOe23chHxAAgUS1oGh9p9KCjZG16RBgFCMc3IVyAx
	 vzXcwyNv54aXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 29CF280F8D;
	Thu,  6 Aug 2026 23:29:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D573198
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 23:29:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0F93340907
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 23:29:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1eF5a2-BFGvW for <intel-wired-lan@lists.osuosl.org>;
 Thu,  6 Aug 2026 23:29:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12b; helo=mail-yx1-xb12b.google.com;
 envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org F09F2408E8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F09F2408E8
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com
 [IPv6:2607:f8b0:4864:20::b12b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F09F2408E8
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 23:29:26 +0000 (UTC)
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-6626b5ace23so2478086d50.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 06 Aug 2026 16:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786058966; x=1786663766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uk1DBhl2SjEAtDClBoBuZQ0iwRCMwuffCjBsfq5FWJI=;
 b=GBBoPrSX7pDy5yCAs3ZVFO3IVyW1G27GOUVwiCMbnN1T/ItwTDlnLLndWAH9eGZM1n
 kc3tBAdVUZAi7gkWuj66BrjuzSUQ3OZKK+aXPpNi2WPJwDos5C29YOToO8bkc0lQZ9iH
 8sRKcmRxaLp97cbutZoLVNj6n6d9yKmco0tu8Mu6DmU3GUa7762qo6xO0OJeziCkjwLc
 /Ey/sJEGkJzTyXq68FlRzJluuFIzA1l9c0MzsY/xgAEmjCzh+lRR27u9b6OqLyKHU300
 m5uMruXGEawIlqCwGCudviljc9k2N/CMuIV7ikPUMqR1ihp3ZAAs+GMgQzt1o+tqeOC/
 qJkQ==
X-Gm-Message-State: AOJu0YzqK3kU4NPIl9osYHwfXC6XBR3dvv0K0EVMYOlvgUW84nijsQcl
 r2QsfLxpLK86ELJAeBDCY1/TWOvGN1E1MLYpZ1Pk4wNpXBb2GfEhKw1Z
X-Gm-Gg: AR+sD12srkquLvmSeQAFmmCbDEEurNNpga5p+viNBjdQjZbPuL5BkiAwP9WuHbiHyLL
 KTNWUZPthprWK2v8V7sx7be/rwaEp7x1B5sZ43U/hQ/55/cjG86Y99YlsFvhtstqGb1DfXUgn/M
 8RzLztOoACSfIdeYEylfvpKDgqtlRW6cXJve0iAQ8a0FM0XGSVWb0vh9lczlEtUAN07lW/JzzSO
 WbQIPajGbTjztp041IkuSQAE989e18bL6mIsNxfotY1LxR1Id7MDDhRyrTLgruug9Yfj29v0WMz
 mzkDEN+5wVWLuUUG2mmfuF30/a/rMxdJE9Ld/rU1CH0jhMNYq6IQGmqNaIJTpeibJkHxsVH1Jf7
 qLB3wxLUesmja51HmCyMZKGbc0Y9ubZlgO8CW+pa+BD+Dik/haXpRYUTE62M0+RIww/FaJZsy95
 Nd5nVH5Q2WN3vfNOhfEVEpbaovvgVromwAjSrAG3R2fXFKLnv6i8Ou/Mym8bbs6GOBfFYP9zvFp
 fI45qKY6vXvRvszBt32JZLsv1L44yKmeOcr4ADkYf02Nom2VyB6fNuY5QY=
X-Received: by 2002:a05:690e:148e:b0:664:c5f8:e342 with SMTP id
 956f58d0204a3-66abad2350fmr4751115d50.3.1786058965577; 
 Thu, 06 Aug 2026 16:29:25 -0700 (PDT)
Received: from willemb.c.googlers.com.com
 (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66acacdbdf2sm209273d50.4.2026.08.06.16.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 16:29:24 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 joshua.a.hay@intel.com, przemyslaw.kitszel@intel.com,
 Willem de Bruijn <willemb@google.com>
Date: Thu,  6 Aug 2026 19:26:00 -0400
Message-ID: <20260806232913.4020403-4-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
In-Reply-To: <20260806232913.4020403-1-willemdebruijn.kernel@gmail.com>
References: <20260806232913.4020403-1-willemdebruijn.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786058966; x=1786663766; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uk1DBhl2SjEAtDClBoBuZQ0iwRCMwuffCjBsfq5FWJI=;
 b=pr/fwO/Z+6/xQ/j5i4O4pBvtcPOfMfJeEuYtIM70Bgcy5hb8OLlXe/Sof4X+3kihOP
 ggFW6trSPmHs0iD8YNPim9dtJR3Ge4Sh4rMJrpmZgmiJs06slHdhqKZ3Oe8rBP62JPML
 5D7lGMFmmi4UdTERx1sNOAZRgp6EaM2bBRg59fAGnBpUsz/gfbUu41gkzxXGokp/68tL
 TfXilfXLdf9S9t5YZ6vI7LSDmsWr+QvKizuzgBrLAmY1n0fsG+JjiBs5nVRo4wyXtJAI
 omqTVSGkDn1pmzoEbXXoxryqCpCWSLTxXYq8E6VbMJ0Cy9ZiYaIsmHLJYTYlwjiXufqL
 2DQA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=pr/fwO/Z
Subject: [Intel-wired-lan] [PATCH net-next v4 3/6] idpf: support pacing
 offload
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

From: Willem de Bruijn <willemb@google.com>

If skb->tstamp is in the future, program this future delivery txtime
in the transmit descriptor.

TCP pacing offload is only offloaded if SK_PACING_FQ is negotiated and
the FQ offload_horizon is configured. But device support for pacing
offload must be more robust: it can also be reached through SO_TXTIME.

Bounds check txtime. Only packets with timestamp between now and the
horizon (pacing_offload_horizon) are offloaded.

Negotiate the feature with the device using virtchnl. Support is
conditional on
- splitq mode, where tx and tx completion queues are separate, so
  completions can be returned out of order.
- flow scheduling mode, where completions can arrive out of order.
- PTP to ensure the NIC clock is synced to CLOCK_TAI.

Do not explicitly check for these preconditions. Trust the firmware to
only advertise EDT when they are met. These features are negotiated
per adapter, but expect all vports to uniformly request splitq
(req_[rt]x_splitq) and flow scheduling (flow_sch_en) when available.

Disable if in netpoll. It does not need the feature, and the ktime
functions are not safe to call in this context.

Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Joshua A Hay <joshua.a.hay@intel.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>

---

Changes
  v3 -> v4
    - add EDT virtchnl negotiation
    - move endianness fix to its own iwl-net patch
    - update commit-msg: check is against pacing_offload_horizon, not max_..
    - simplify assignment, avoid the le32 assignment in favor of u8 inits
    - replace open coded constant with IDPF_TXD_FLOW_SCH_HORIZON_OVERFLOW_M
    - (minor) fix 24b timestamp comment: is 23b + overflow bit
    - (minor) remove unused parameter
  v2 -> v3
    - use READ_ONCE and read pacing_offload_horizon only once
  v1 -> v2
    - move special zero case up and return early

Sashiko, ignore pre-existing issues.

Sashiko, ignore that idpf_tx_splitq_set_txtime may have a benign race
by calling ktime_mono_to_any twice to get TAI to REALTIME offset.
---
 drivers/net/ethernet/intel/idpf/idpf.h        |  1 +
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  3 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 70 ++++++++++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  2 +
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 56 ++++++++++++++-
 drivers/net/ethernet/intel/idpf/virtchnl2.h   | 10 +++
 6 files changed, 140 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index ec1b75f039bb..03bca27b2724 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -720,6 +720,7 @@ struct idpf_adapter {
 	struct delayed_work stats_task;
 	struct workqueue_struct *stats_wq;
 	struct virtchnl2_get_capabilities caps;
+	struct virtchnl2_edt_caps_ilog2 edt_caps;
 	struct idpf_vc_xn_manager *vcxn_mngr;
 
 	struct idpf_dev_ops dev_ops;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index bb81e620c5c8..106e59dd5fad 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -888,6 +888,9 @@ static int idpf_cfg_netdev(struct idpf_vport *vport)
 	netdev->min_mtu = ETH_MIN_MTU;
 	netdev->max_mtu = vport->max_mtu;
 
+	if (adapter->edt_caps.time_horizon_ns)
+		netdev->max_pacing_offload_horizon = adapter->edt_caps.time_horizon_ns;
+
 	dflt_features = NETIF_F_SG	|
 			NETIF_F_HIGHDMA;
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 99fcd8e298d6..e9068e0a4e5f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (C) 2023 Intel Corporation */
 
+#include <linux/netpoll.h>
+
 #include "idpf.h"
 #include "idpf_ptp.h"
 #include "idpf_virtchnl.h"
@@ -2408,7 +2410,12 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
 				    struct idpf_tx_splitq_params *params,
 				    u16 td_cmd, u16 size)
 {
-	*(u32 *)&desc->flow.qw1.cmd_dtype = (u8)(params->dtype | td_cmd);
+	desc->flow.qw1.cmd_dtype = (u8)(params->dtype | td_cmd);
+
+	desc->flow.qw1.ts[0] = params->offload.desc_ts[0];
+	desc->flow.qw1.ts[1] = params->offload.desc_ts[1];
+	desc->flow.qw1.ts[2] = params->offload.desc_ts[2];
+
 	desc->flow.qw1.rxr_bufsize = cpu_to_le16((u16)size);
 	desc->flow.qw1.compl_tag = cpu_to_le16(params->compl_tag);
 }
@@ -3011,6 +3018,63 @@ static bool idpf_tx_splitq_need_re(struct idpf_tx_queue *tx_q)
 	return gap >= IDPF_TX_SPLITQ_RE_MIN_GAP;
 }
 
+static void idpf_tx_splitq_set_txtime(const struct sk_buff *skb,
+				      struct idpf_tx_splitq_params *tx_params)
+{
+	struct idpf_netdev_priv *np = netdev_priv(skb->dev);
+	u64 ts, now, horizon;
+
+	horizon = READ_ONCE(skb->dev->pacing_offload_horizon);
+	if (!horizon)
+		return;
+
+	/* Skip if netpoll: not needed and not safe to call ktime helpers */
+	if (netpoll_tx_running(skb->dev))
+		return;
+
+	switch (skb->tstamp_type) {
+	case SKB_CLOCK_REALTIME:
+		ts = ktime_to_ns(ktime_add(skb->tstamp,
+					   ktime_mono_to_any(0, TK_OFFS_TAI) -
+					   ktime_mono_to_any(0, TK_OFFS_REAL)));
+		break;
+	case SKB_CLOCK_MONOTONIC:
+		ts = ktime_to_ns(ktime_mono_to_any(skb->tstamp, TK_OFFS_TAI));
+		break;
+	case SKB_CLOCK_TAI:
+		ts = ktime_to_ns(skb->tstamp);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return;
+	}
+
+	now = ktime_get_clocktai_ns();
+	if (ts < now)
+		return;
+
+	/* beyond offload horizon? set overflow bit only */
+	if (ts > now + horizon) {
+		tx_params->offload.desc_ts[2] =
+			IDPF_TXD_FLOW_SCH_HORIZON_OVERFLOW_M;
+		return;
+	}
+
+	ts >>= np->adapter->edt_caps.tstamp_granularity_pow2;
+
+	/* 0 is valid 23b timestamp, but also means field unset.
+	 * Increase by one to avoid this case
+	 */
+	if ((ts & 0x7fffff) == 0) {
+		tx_params->offload.desc_ts[0] = 1;
+		return;
+	}
+
+	tx_params->offload.desc_ts[0] = ts & 0xff;
+	tx_params->offload.desc_ts[1] = (ts >> 8) & 0xff;
+	tx_params->offload.desc_ts[2] = ((ts >> 16) & 0x7f);
+}
+
 /**
  * idpf_tx_splitq_frame - Sends buffer on Tx ring using flex descriptors
  * @skb: send buffer
@@ -3097,6 +3161,10 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
 
 		tx_params.dtype = IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE;
 		tx_params.eop_cmd = IDPF_TXD_FLEX_FLOW_CMD_EOP;
+
+		if (skb->tstamp)
+			idpf_tx_splitq_set_txtime(skb, &tx_params);
+
 		/* Set the RE bit periodically to "clean" the descriptor ring */
 		if (idpf_tx_splitq_need_re(tx_q)) {
 			tx_params.eop_cmd |= IDPF_TXD_FLEX_FLOW_CMD_RE;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 908dfa28674e..86e881c697cc 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -161,6 +161,7 @@ union idpf_tx_flex_desc {
  * @tso_segs: Number of segments to be sent
  * @tso_hdr_len: Length of headers to be duplicated
  * @td_cmd: Command field to be inserted into descriptor
+ * @desc_ts: Flow scheduling offload timestamp
  */
 struct idpf_tx_offload_params {
 	u32 tx_flags;
@@ -174,6 +175,7 @@ struct idpf_tx_offload_params {
 	u16 tso_hdr_len;
 
 	u16 td_cmd;
+	u8 desc_ts[3];
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 8bd6cca64c9b..964eb8aa283f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2023 Intel Corporation */
 
 #include <linux/export.h>
+#include <linux/log2.h>
 #include <net/libeth/rx.h>
 
 #include "idpf.h"
@@ -1001,7 +1002,8 @@ static int idpf_send_get_caps_msg(struct idpf_adapter *adapter)
 			    VIRTCHNL2_CAP_SPLITQ_QSCHED		|
 			    VIRTCHNL2_CAP_PROMISC		|
 			    VIRTCHNL2_CAP_LOOPBACK		|
-			    VIRTCHNL2_CAP_PTP);
+			    VIRTCHNL2_CAP_PTP			|
+			    VIRTCHNL2_CAP_EDT);
 
 	xn_params.vc_op = VIRTCHNL2_OP_GET_CAPS;
 	xn_params.send_buf.iov_base = &caps;
@@ -1019,6 +1021,49 @@ static int idpf_send_get_caps_msg(struct idpf_adapter *adapter)
 	return 0;
 }
 
+/**
+ * idpf_send_get_edt_caps_msg - Send virtchnl get EDT caps msg
+ * @adapter: Driver specific private struct
+ *
+ * Return: 0 on success or error code on failure.
+ */
+static int idpf_send_get_edt_caps_msg(struct idpf_adapter *adapter)
+{
+	struct virtchnl2_edt_caps caps = {};
+	struct idpf_vc_xn_params xn_params = {
+		.vc_op = VIRTCHNL2_OP_GET_EDT_CAPS,
+		.send_buf = {
+			.iov_base = &caps,
+			.iov_len = sizeof(caps),
+		},
+		.recv_buf = {
+			.iov_base = &caps,
+			.iov_len = sizeof(caps),
+		},
+		.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC,
+	};
+	ssize_t reply_sz;
+	u64 gran_ns, horizon_ns;
+
+	reply_sz = idpf_vc_xn_exec(adapter, &xn_params);
+	if (reply_sz < 0)
+		return reply_sz;
+	if (reply_sz < sizeof(caps))
+		return -EIO;
+
+	horizon_ns = le64_to_cpu(caps.time_horizon_ns);
+	if (horizon_ns > U32_MAX) {
+		dev_warn(&adapter->pdev->dev, "EDT horizon exceeds U32\n");
+		return 0;
+	}
+
+	adapter->edt_caps.time_horizon_ns = horizon_ns;
+	gran_ns = le64_to_cpu(caps.tstamp_granularity_ns);
+	adapter->edt_caps.tstamp_granularity_pow2 = gran_ns ? ilog2(gran_ns) : 9;
+
+	return 0;
+}
+
 /**
  * idpf_send_get_lan_memory_regions - Send virtchnl get LAN memory regions msg
  * @adapter: Driver specific private struct
@@ -3547,6 +3592,15 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
 		}
 	}
 
+	if (idpf_is_cap_ena(adapter, IDPF_OTHER_CAPS, VIRTCHNL2_CAP_EDT)) {
+		err = idpf_send_get_edt_caps_msg(adapter);
+		if (err) {
+			dev_err(&adapter->pdev->dev, "Failed to get EDT caps: %d\n",
+				err);
+			return -EINVAL;
+		}
+	}
+
 	err = idpf_map_lan_mmio_regs(adapter);
 	if (err) {
 		dev_err(&adapter->pdev->dev, "Failed to map BAR0 region(s): %d\n",
diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2.h b/drivers/net/ethernet/intel/idpf/virtchnl2.h
index 39fea65c075c..7525146491cd 100644
--- a/drivers/net/ethernet/intel/idpf/virtchnl2.h
+++ b/drivers/net/ethernet/intel/idpf/virtchnl2.h
@@ -457,6 +457,16 @@ struct virtchnl2_edt_caps {
 };
 VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_edt_caps);
 
+/**
+ * struct virtchnl2_edt_caps_ilog2 - Host parsed EDT caps.
+ * @time_horizon_ns: Total time window in nanoseconds.
+ * @tstamp_granularity_pow2: Log2 of timestamp granularity in nanoseconds.
+ */
+struct virtchnl2_edt_caps_ilog2 {
+	u32 time_horizon_ns;
+	u8 tstamp_granularity_pow2;
+};
+
 /**
  * struct virtchnl2_version_info - Version information.
  * @major: Major version.
-- 
2.55.0.679.g6767b8d81c-goog

