Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B0CC624D3
	for <intel-wired-lan@archiver.kernel.org>; Wed,  2 Sep 2026 18:18:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E448F40A4B;
	Wed,  2 Sep 2026 18:18:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m40AYcRSebmo; Wed,  2 Sep 2026 18:18:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788373080;
	bh=NHAQDq6vBiUnbuFOJFe77aW1ys7kP0t0k+chohCQ+QQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Fkl3CuOryBl42SxjXyGXxEtndrFisLKakMQ4z24gQUwD/tvEwvwPhL7mIftofWZnx
	 1NinSyU6gyACvLaNz/BCXceywvOV2q4AMyWx4LCk9GdZg5nGCpdi2vOBJaVuadEU0c
	 KxTQ588qo5tVsZYt7s5YYSnM4/p3wW60U8MJ0quxKxnrHxYlXlS84LPXwrYmb6fSu4
	 zlgQah+G2fCX332YlUsJRSABMGsLHanVaq95fThc9cmJLSVOyCXsUuKiFLAcuyJLEL
	 CcaVpSYAyxcOC+5zA56bl/xmSXPk+J9IAewEfAxk3QH4b0Y85zz6ND+v4znH6P3VNl
	 fBaViHFzsnv3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F010E40513;
	Wed,  2 Sep 2026 18:17:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DC7F82B2
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 18:17:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D1BF340191
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 18:17:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IkH_u2alB26W for <intel-wired-lan@lists.osuosl.org>;
 Wed,  2 Sep 2026 18:17:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112c; helo=mail-yw1-x112c.google.com;
 envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=X9/oBRaN
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9E47240177
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 18:17:57 +0000 (UTC)
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8565d77c277so20384197b3.0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 02 Sep 2026 11:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788373076; x=1788977876; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NHAQDq6vBiUnbuFOJFe77aW1ys7kP0t0k+chohCQ+QQ=;
 b=X9/oBRaNYnYd2Vp0WfKqElNeCOrf1LMaZsvURbggXaAOBOuOqu/Lr8KU5crqnxNJ+A
 h1KgWRogkanIsgJGffn6lzFq23qhJjzGxm3d44G0YfG/D0rZ4WezRoXoA2hf2vIl6bfV
 ANE6gVSsRl7ujHiAcIFGuSbOtW8ly2hcFk5G+RscKw0idt1MwYk5gVpFfcoSp7eYbXjA
 u+MrRfi+Aa9NTeFSm0IGV70O5zxd3/9T+QVcmGedmJ6UDiX7kFb8ZJaE15vFAOZclCnx
 W57rVUESAL4qI2gn5wHI6POMxx6PLnMznZ01sOAiw6U2q1fkLWvEZA1tDfxDXAi31i7I
 zzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788373076; x=1788977876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NHAQDq6vBiUnbuFOJFe77aW1ys7kP0t0k+chohCQ+QQ=;
 b=rWqFBciZ2R5qPsupPYuJh3MZN3ghGnmBLZ8gMB136F3LU8881dco3bmjt+ZykaWU0r
 om9D62co5czMdt61hermIMkSPBfdYLJ49DWQAcLU4R1PE/ErKndnpkB19BBgmV8GVyD+
 /bt/+GT2BnamU3Wen/uyvapD37DUfn04zuZjWLSyLA73mQ9O5WlSNJGQDgScFRssGIP8
 fHA0s++LDaZjTzOW83QCVYw9w8sHTCRHuQJrDHVtD7BD56csCzb/SFxvZ0TkdoBgVEkX
 jsOU3uUXJ06itZvJ6nN6RdLmeQNSJTxyLisBsVpLepen6NBw8zwjx+MoLHWsQRzykCRU
 i0WQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzXlD6eL+abgeobOFf9+YXJ1K4ByLbIlxrUbakFu6i/pjMYemQ7+WsjBG3fqkm7C5Tkgd/tKOTSrbfc8R8nDJY=@lists.osuosl.org
X-Gm-Message-State: AFuF++mTE3kCfGc4OJYdqdBlAuH1hRQGDoOxTQthhkoYFoelbWbdECdY
 fxn6fr+P5N48iOobG/INy7Yfkk8L35vt5dI2KrlveYX4x5lLQKMhhMt6
X-Gm-Gg: AYBFou1NOoqXEUE9DGiPqbD44s5rmBzrUfX7X8Eh2WtI2d49yjMr4newYyBFs75B3jW
 8PoD8yOIhhDzssIMELrZeWEN4NES/Uz1x1OM4MYSfAEVBv6/V5jxX/KAJOMI0LTmPl/VdDwwE+e
 fLR992TY4yXc/WVfDlm6Up6MSKv6OobKiiL2YAcbfE8bHFl504uAw9S/48g2qeqT45zUbpUv3z0
 mr/nYExVuQHQeCaq0pdRpYB/E+rs2HLsWTLTxNoUUK6J7npxqDt9kPkV+Wr0tZ2IX6fiJO5mIvE
 mpT6AhCfSv7/h3y1hgP12qYFKzWRUbH68KrkaHjpUIP2X2CSPwHSJsCgZ4CvQVfh3fVUTY74PPo
 hsWszGPm/iEG4Ih91dxqkxm6fdlDhllJ02ngimwbAMz+zreMuClZg3fED2mYAwT/Kk9uc4aIFQx
 nM4ArYbyxMDUm+JATpZTdKhRbKXo0Sr2caHumiPdFV4Hy0TpVu4R+FbwmjL2NgjBxFUpeEsrzFs
 I9rCcRzjP2342bYIFoaGDGQ8Bav2IYyJ+P/FyNsRP2HTkV8xSQfq4BVicBWGTYo
X-Received: by 2002:a05:690c:e3c2:b0:81f:238a:1709 with SMTP id
 00721157ae682-86c54f03a9emr33848597b3.34.1788373075960; 
 Wed, 02 Sep 2026 11:17:55 -0700 (PDT)
Received: from willemb.c.googlers.com.com
 (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-86c1784192bsm23162297b3.30.2026.09.02.11.17.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 11:17:55 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 Willem de Bruijn <willemb@google.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Joshua A Hay <joshua.a.hay@intel.com>, intel-wired-lan@lists.osuosl.org
Subject: [PATCH net-next v8 3/6] idpf: support pacing offload
Date: Wed,  2 Sep 2026 14:17:13 -0400
Message-ID: <20260902181747.2483351-4-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
In-Reply-To: <20260902181747.2483351-1-willemdebruijn.kernel@gmail.com>
References: <20260902181747.2483351-1-willemdebruijn.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

These features are negotiated per adapter, but expect all vports to
uniformly request splitq (req_[rt]x_splitq) and flow scheduling
(flow_sch_en) when available.

Do not explicitly check all preconditions. Trust the firmware to
only advertise EDT when all are met. In general, firmware response is
trusted to be correct. If not, EDT would be the least of the worries.
In particular, granularity is trusted to be a power of two. And
time_horizon_ns is a range expressible given the chosen granularity.

Packets beyond the horizon are sent immediately with the overflow bit
set.

On device reset, dev->pacing_offload_horizon, fq offload_horizon and
granularity are not re-negotiated. It is safe to assume that firmware
does not change these EDT capabilities across resets.

Must not be called from netpoll due to ktime_get. But netpoll does not
generate packets with EDT, so no explicit test is needed.

Do not fail device initialization on EDT init error. Log an error, but
continue without EDT, similar to PTP.

Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Joshua A Hay <joshua.a.hay@intel.com>
Cc: intel-wired-lan@lists.osuosl.org
Signed-off-by: Willem de Bruijn <willemb@google.com>

---

Changes
  v7 -> v8
    - remove unused variable np in idpf_tx_splitq_set_txtime
  v6 -> v7
    - rebase onto libie changes: adjust idpf_send_get_edt_caps_msg
    - only set horizon if splitq with flow scheduling
    - fail on illegal granularity 0, rather than use hardcoded default
    - zero edt_caps on negotation error, in case of call after reset
    - cache ts_gran_pow2 in idpf_tx_queue to be in hot cache line
    - similar to FQ, add offload slack to avoid pacing < 400ns of now
    - remove now superfluous include netpoll.h
    - reverse xmas tree (1x)
  v5 -> v6
    - move EDT caps from virtchnl2_edt_caps_ilog2 to idpf_edt_caps_ilog2
    - do not fail device init if EDT init failed, same as PTP
    - replace netpoll branch with commit-msg comment
    - add commit-msg comment about device reset
    - add commit-msg about behavior beyond horizon
    - add commit-msg about trusting EDT capability response
  v4 -> v5
    - fix kdoc: idpf.h:738 struct member 'edt_caps' not described..
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
 drivers/net/ethernet/intel/idpf/idpf.h        | 12 ++++
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  6 ++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 66 ++++++++++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  8 ++-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 60 ++++++++++++++++-
 5 files changed, 149 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 470bc23c844c..f214023095ee 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -604,6 +604,16 @@ struct idpf_vport_config {
 	DECLARE_BITMAP(flags, IDPF_VPORT_CONFIG_FLAGS_NBITS);
 };
 
+/**
+ * struct idpf_edt_caps_ilog2 - Host parsed EDT capabilities.
+ * @time_horizon_ns: Total time window in nanoseconds.
+ * @tstamp_granularity_pow2: Log2 of timestamp granularity in nanoseconds.
+ */
+struct idpf_edt_caps_ilog2 {
+	u32 time_horizon_ns;
+	u8 tstamp_granularity_pow2;
+};
+
 #define idpf_for_each_vport(adapter, iter) \
 	for (struct idpf_vport **__##iter = &(adapter)->vports[0], \
 	     *iter = (adapter)->max_vports ? *__##iter : NULL; \
@@ -657,6 +667,7 @@ struct idpf_vport_config {
  * @stats_task: Periodic statistics retrieval task
  * @stats_wq: Workqueue for statistics task
  * @caps: Negotiated capabilities with device
+ * @edt_caps: Negotiated EDT capabilities with device
  * @dev_ops: See idpf_dev_ops
  * @cdev_info: IDC core device info pointer
  * @num_vfs: Number of allocated VFs through sysfs. PF does not directly talk
@@ -720,6 +731,7 @@ struct idpf_adapter {
 	struct delayed_work stats_task;
 	struct workqueue_struct *stats_wq;
 	struct virtchnl2_get_capabilities caps;
+	struct idpf_edt_caps_ilog2 edt_caps;
 
 	struct idpf_dev_ops dev_ops;
 	struct iidc_rdma_core_dev_info *cdev_info;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 827c795afcb6..c2ad3fdf72aa 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -890,6 +890,12 @@ static int idpf_cfg_netdev(struct idpf_vport *vport)
 	netdev->min_mtu = ETH_MIN_MTU;
 	netdev->max_mtu = vport->max_mtu;
 
+	if (adapter->edt_caps.time_horizon_ns &&
+	    idpf_is_queue_model_split(vport->dflt_qv_rsrc.txq_model) &&
+	    !idpf_is_cap_ena(adapter, IDPF_OTHER_CAPS,
+			     VIRTCHNL2_CAP_SPLITQ_QSCHED))
+		netdev->max_pacing_offload_horizon = adapter->edt_caps.time_horizon_ns;
+
 	dflt_features = NETIF_F_SG	|
 			NETIF_F_HIGHDMA;
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 24b91be25676..d80b6f5a0fde 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -1742,6 +1742,7 @@ static int idpf_txq_group_alloc(struct idpf_vport *vport,
 			q->desc_count = rsrc->txq_desc_count;
 			q->tx_max_bufs = idpf_get_max_tx_bufs(adapter);
 			q->tx_min_pkt_len = idpf_get_min_tx_pkt_len(adapter);
+			q->ts_gran_pow2 = adapter->edt_caps.tstamp_granularity_pow2;
 			q->netdev = vport->netdev;
 			q->txq_grp = tx_qgrp;
 			q->rel_q_id = j;
@@ -2408,7 +2409,12 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
 				    struct idpf_tx_splitq_params *params,
 				    u16 td_cmd, u16 size)
 {
-	*(__le32 *)&desc->flow.qw1.cmd_dtype = cpu_to_le32((u8)(params->dtype | td_cmd));
+	desc->flow.qw1.cmd_dtype = (u8)(params->dtype | td_cmd);
+
+	desc->flow.qw1.ts[0] = params->offload.desc_ts[0];
+	desc->flow.qw1.ts[1] = params->offload.desc_ts[1];
+	desc->flow.qw1.ts[2] = params->offload.desc_ts[2];
+
 	desc->flow.qw1.rxr_bufsize = cpu_to_le16((u16)size);
 	desc->flow.qw1.compl_tag = cpu_to_le16(params->compl_tag);
 }
@@ -3011,6 +3017,60 @@ static bool idpf_tx_splitq_need_re(struct idpf_tx_queue *tx_q)
 	return gap >= IDPF_TX_SPLITQ_RE_MIN_GAP;
 }
 
+static void idpf_tx_splitq_set_txtime(const struct sk_buff *skb,
+				      const struct idpf_tx_queue *tx_q,
+				      struct idpf_tx_splitq_params *tx_params)
+{
+	const int offload_slack_ns = 400;
+	u64 ts, now, horizon;
+
+	horizon = READ_ONCE(skb->dev->pacing_offload_horizon);
+	if (!horizon)
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
+	if (ts < now + offload_slack_ns)
+		return;
+
+	/* beyond offload horizon? set overflow bit only */
+	if (ts > now + horizon) {
+		tx_params->offload.desc_ts[2] =
+			IDPF_TXD_FLOW_SCH_HORIZON_OVERFLOW_M;
+		return;
+	}
+
+	ts >>= tx_q->ts_gran_pow2;
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
@@ -3097,6 +3157,10 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
 
 		tx_params.dtype = IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE;
 		tx_params.eop_cmd = IDPF_TXD_FLEX_FLOW_CMD_EOP;
+
+		if (skb->tstamp)
+			idpf_tx_splitq_set_txtime(skb, tx_q, &tx_params);
+
 		/* Set the RE bit periodically to "clean" the descriptor ring */
 		if (idpf_tx_splitq_need_re(tx_q)) {
 			tx_params.eop_cmd |= IDPF_TXD_FLEX_FLOW_CMD_RE;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 93547597efd2..fe0c913f9bb9 100644
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
@@ -608,6 +610,7 @@ libeth_cacheline_set_assert(struct idpf_rx_queue,
  *	 hot path TX pointers stored in vport. Used in both singleq/splitq.
  * @desc_count: Number of descriptors
  * @tx_min_pkt_len: Min supported packet length
+ * @ts_gran_pow2: Txtime timestamp granularity in nanoseconds (log2).
  * @thresh: XDP queue cleaning threshold
  * @netdev: &net_device corresponding to this queue
  * @next_to_use: Next descriptor to use
@@ -666,7 +669,10 @@ struct idpf_tx_queue {
 	u16 desc_count;
 
 	union {
-		u16 tx_min_pkt_len;
+		struct {
+			u16 tx_min_pkt_len;
+			u8 ts_gran_pow2;
+		};
 		u32 thresh;
 	};
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 1caf52706973..030ecd9b6c41 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3,6 +3,7 @@
 
 #include <linux/export.h>
 #include <linux/net/intel/libie/pci.h>
+#include <linux/log2.h>
 #include <net/libeth/rx.h>
 
 #include "idpf.h"
@@ -553,7 +554,8 @@ static int idpf_send_get_caps_msg(struct idpf_adapter *adapter)
 			    VIRTCHNL2_CAP_SPLITQ_QSCHED		|
 			    VIRTCHNL2_CAP_PROMISC		|
 			    VIRTCHNL2_CAP_LOOPBACK		|
-			    VIRTCHNL2_CAP_PTP);
+			    VIRTCHNL2_CAP_PTP			|
+			    VIRTCHNL2_CAP_EDT);
 
 	err = idpf_send_mb_msg_stack(adapter, &xn_params, &caps);
 	if (err)
@@ -573,6 +575,54 @@ static int idpf_send_get_caps_msg(struct idpf_adapter *adapter)
 	return err;
 }
 
+/**
+ * idpf_send_get_edt_caps_msg - Send virtchnl get EDT caps msg
+ * @adapter: Driver specific private struct
+ *
+ * Return: 0 on success or error code on failure.
+ */
+static int idpf_send_get_edt_caps_msg(struct idpf_adapter *adapter)
+{
+	struct libie_ctlq_xn_send_params xn_params = {
+		.timeout_ms	= IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC,
+		.chnl_opcode	= VIRTCHNL2_OP_GET_EDT_CAPS,
+	};
+	struct virtchnl2_edt_caps caps = {};
+	u64 gran_ns, horizon_ns;
+	int err;
+
+	err = idpf_send_mb_msg_stack(adapter, &xn_params, &caps);
+	if (err)
+		return err;
+
+	if (xn_params.recv_mem.iov_len < sizeof(caps)) {
+		err = -EIO;
+		goto free_rx_buf;
+	}
+
+	memcpy(&caps, xn_params.recv_mem.iov_base, sizeof(caps));
+	horizon_ns = le64_to_cpu(caps.time_horizon_ns);
+	gran_ns = le64_to_cpu(caps.tstamp_granularity_ns);
+	if (horizon_ns > U32_MAX) {
+		dev_warn(&adapter->pdev->dev, "EDT horizon exceeds U32\n");
+		err = -EINVAL;
+		goto free_rx_buf;
+	}
+	if (!gran_ns) {
+		dev_warn(&adapter->pdev->dev, "EDT granularity undefined\n");
+		err = -EINVAL;
+		goto free_rx_buf;
+	}
+
+	adapter->edt_caps.time_horizon_ns = horizon_ns;
+	adapter->edt_caps.tstamp_granularity_pow2 = ilog2(gran_ns);
+
+free_rx_buf:
+	libie_ctlq_release_rx_buf(&xn_params.recv_mem);
+
+	return err;
+}
+
 /**
  * idpf_mmio_region_non_static - Check if region is not static
  * @mmio_info: PCI resources info
@@ -3085,6 +3135,14 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
 		}
 	}
 
+	if (idpf_is_cap_ena(adapter, IDPF_OTHER_CAPS, VIRTCHNL2_CAP_EDT)) {
+		err = idpf_send_get_edt_caps_msg(adapter);
+		if (err) {
+			dev_err(&adapter->pdev->dev, "EDT init failed, err=%d\n", err);
+			memset(&adapter->edt_caps, 0, sizeof(adapter->edt_caps));
+		}
+	}
+
 	pci_sriov_set_totalvfs(adapter->pdev, idpf_get_max_vfs(adapter));
 	num_max_vports = idpf_get_max_vports(adapter);
 	adapter->vports = kzalloc_objs(*adapter->vports, num_max_vports);
-- 
2.55.0.970.g62bdec98f9-goog

