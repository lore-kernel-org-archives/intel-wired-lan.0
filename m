Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A491C531F5
	for <intel-wired-lan@archiver.kernel.org>; Thu, 23 Jul 2026 14:05:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0E74A409D4;
	Thu, 23 Jul 2026 14:05:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VjrDpm6rOQko; Thu, 23 Jul 2026 14:05:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4A159409B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784815551;
	bh=I880Ca0KXpdJ71lyMD7Z6ZxjAEzuDwA1b+elqzVFveY=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UkkqCRtQKVN/LF621ZtDrwvYIQE8/06TOSKkhpHlKrlZ+DOvWvwD29qkfeQmrlstO
	 oKGge4q8pswQfznRDQHc0SreX+jn7YBWwX07DQpYhQCchxpj0SRVFjVr1MvzKTeWqz
	 2p0viqarpHMjN+gLUk4u2S9spHOJaIzkN+36gKbH9v18YH3aqRsk07RTvDwJ8somLb
	 WdLMakKg1hQa9x6jznKiU72j0K1Wu/23tE172j0bDEzGR8Z5j5ihwWmHIXaezIDVc9
	 jb+7ZFGLjlrllr4opkyDTcOweu2ry5KenSFmc/k9HlO1gplEmN8wgdhLCD9K90aJ6g
	 8IYwfEll/IinA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A159409B4;
	Thu, 23 Jul 2026 14:05:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4225A786
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 14:05:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2802640939
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 14:05:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BfEVoPOioXjf for <intel-wired-lan@lists.osuosl.org>;
 Thu, 23 Jul 2026 14:05:49 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=mheib@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1533A40956
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1533A40956
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1533A40956
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 14:05:48 +0000 (UTC)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-IMVbQX0AN-miEdyoGBvrlw-1; Thu, 23 Jul 2026 10:05:45 -0400
X-MC-Unique: IMVbQX0AN-miEdyoGBvrlw-1
X-Mimecast-MFC-AGG-ID: IMVbQX0AN-miEdyoGBvrlw_1784815544
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-493a7fa8481so3409265e9.1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 07:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784815544; x=1785420344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=I880Ca0KXpdJ71lyMD7Z6ZxjAEzuDwA1b+elqzVFveY=;
 b=DuGiiwENJ0vVs6jxmiLSXnE8bQHlVlhPLbuhhSu2wL5HM/En19v81qfEPTGCnGCoes
 zgTrwtjt0g1/9waONj4GzTQhCbGFsJPwuCuiXGr/o9wHweF97LVCFstctyuJhSq3UAxR
 mHAHGl8dpi4ryXrI6JUw43KQ2GJLHZnS8d2lfUmxbPRgLJ8ngyNQFZKAnJLR4Sg48wsr
 AM6pm2DDW+OxlRW8TYafu/wz6O5m1Q3toLsBszXlFhcV6BSSR5SgW6dfl2/WRLshZcta
 tSSw1FiHe2a7i09ZijrH7gJVX/jFTGHkj4liHN8mi1RqE5EG8Nxevq9IZb5UtGEPwbj4
 DvTA==
X-Gm-Message-State: AOJu0Yx2h/WNbXLHpA+g2JnIBm8RQvkTF4Tt+cTbS2K97F7QODshZRL/
 QCAblv4Pn86+fOX0caVM1wPp86SD2WZXk+7lmPK+ZlrfBZtXW2nuI2TpDMGznGcHuJUBh8ER3B9
 fk7T69irlg3D+u8ZmtjgK5/3/kDEOWNsrDCmnpVw1mVG//85HVSytL/Zrir0rrdmOpD2Lna1RIp
 V6czBQvjFgANEpq1dTEpVWv8jumAD6j7EO0s8T2ThAIY3TF388wVoW0g==
X-Gm-Gg: AR+sD10HRkE9CDuLHqtURKE5fb7XdBUdsmN7vLgtmbZ122NITHTjUlWEGUmdPcZFO3p
 GUquMxUfjl38Xx2/g4cIq2xACNryHDt3woxWvcthTGUz8OkN/+gs4De32T5nwjPapym9UdbTUPH
 Q9r2b5EDo83FdsSfynjvgehFfr3y7b8Cy2U4OeIrhHgN/srSg1or76b7hWOU7d8GgWfcs7VFDxz
 1P+61EAMgPJsyVPyo4NpXeYDq2+FW99FjeWbElpJOG1dBjn5cLbGqxnvBgGNXq58Fwr+dIVMhN9
 c+JuqbmJ0J3wbLPmuE14sEE61Lf2Mff4D5XgQFRHt8cJrObQoga2CAS62z/G9kI3QiJt8tYvGKp
 NUNW/i/6LHeti1A==
X-Received: by 2002:a05:600c:1c1c:b0:493:ecf5:89fd with SMTP id
 5b1f17b1804b1-495745ac487mr31797125e9.17.1784815543799; 
 Thu, 23 Jul 2026 07:05:43 -0700 (PDT)
X-Received: by 2002:a05:600c:1c1c:b0:493:ecf5:89fd with SMTP id
 5b1f17b1804b1-495745ac487mr31796565e9.17.1784815543225; 
 Thu, 23 Jul 2026 07:05:43 -0700 (PDT)
Received: from fedora.redhat.com ([216.128.14.205])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a4aae16sm154261685e9.0.2026.07.23.07.05.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 07:05:42 -0700 (PDT)
From: mheib@redhat.com
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, horms@kernel.org, Mohammad Heib <mheib@redhat.com>
Date: Thu, 23 Jul 2026 17:04:15 +0300
Message-ID: <20260723140510.184819-2-mheib@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723140510.184819-1-mheib@redhat.com>
References: <20260723140510.184819-1-mheib@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: l4dhqMNLWE7QHcWTm2sN6iPllMuxV9FPTlBOOHxvkkg_1784815544
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1784815547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I880Ca0KXpdJ71lyMD7Z6ZxjAEzuDwA1b+elqzVFveY=;
 b=f07JWOhFGUAMHRFHnbJnuIBq6DYNLB5nMw4R0tZ6H4qTGNrpG0ym7vzUzTtc1w0jkjd6Kl
 nw5K8mhdyCWXeaqM8H4IO8Fe+b/JfbBJ1WXG4YrHdG9tBWXw9PsmOgsgt47My3/R1zWy7w
 Kmy4WXGeT7wYtGB3Tbs4FSvgVSl10P4=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=f07JWOhF
Subject: [Intel-wired-lan] [PATCH iwl-next v4 1/3] i40e: move ATR sample
 rate from ring to PF level
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

From: Mohammad Heib <mheib@redhat.com>

The ATR sample rate is currently stored per-ring and initialized when each
TX ring is configured. Since the sample rate is a global policy that
applies uniformly across all rings, it makes more sense to store it at
the PF level.

Move atr_sample_rate from struct i40e_ring to struct i40e_pf and initialize
it once during i40e_sw_init(). Update i40e_atr() to reference the PF-level
field. Change atr_count from u8 to u32 to match the sample rate type.

Signed-off-by: Mohammad Heib <mheib@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h      | 1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c | 9 +++------
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 6 ++++--
 drivers/net/ethernet/intel/i40e/i40e_txrx.h | 3 +--
 4 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 1b6a8fbaa648..88eb40ee45f0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -487,6 +487,7 @@ struct i40e_pf {
 	u16 rss_size_max;          /* HW defined max RSS queues */
 	u16 fdir_pf_filter_count;  /* num of guaranteed filters for this PF */
 	u16 num_alloc_vsi;         /* num VSIs this driver supports */
+	u32 atr_sample_rate;
 	bool wol_en;
 
 	struct hlist_head fdir_filter_list;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 4e5307355484..22466460e40b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3457,12 +3457,7 @@ static int i40e_configure_tx_ring(struct i40e_ring *ring)
 		ring->xsk_pool = i40e_xsk_pool(ring);
 
 	/* some ATR related tx ring init */
-	if (test_bit(I40E_FLAG_FD_ATR_ENA, vsi->back->flags)) {
-		ring->atr_sample_rate = I40E_DEFAULT_ATR_SAMPLE_RATE;
-		ring->atr_count = 0;
-	} else {
-		ring->atr_sample_rate = 0;
-	}
+	ring->atr_count = 0;
 
 	/* configure XPS */
 	i40e_config_xps_tx_ring(ring);
@@ -12749,6 +12744,8 @@ static int i40e_sw_init(struct i40e_pf *pf)
 		}
 	}
 
+	pf->atr_sample_rate = I40E_DEFAULT_ATR_SAMPLE_RATE;
+
 	if ((pf->hw.func_caps.fd_filters_guaranteed > 0) ||
 	    (pf->hw.func_caps.fd_filters_best_effort > 0)) {
 		set_bit(I40E_FLAG_FD_ATR_ENA, pf->flags);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 61525ab7d21e..48d05c2e698e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2871,6 +2871,7 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	struct tcphdr *th;
 	unsigned int hlen;
 	u32 flex_ptype, dtype_cmd;
+	u32 sample_rate;
 	int l4_proto;
 	u16 i;
 
@@ -2882,7 +2883,8 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 		return;
 
 	/* if sampling is disabled do nothing */
-	if (!tx_ring->atr_sample_rate)
+	sample_rate = READ_ONCE(pf->atr_sample_rate);
+	if (!sample_rate)
 		return;
 
 	/* Currently only IPv4/IPv6 with TCP is supported */
@@ -2934,7 +2936,7 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	if (!th->fin &&
 	    !th->syn &&
 	    !th->rst &&
-	    (tx_ring->atr_count < tx_ring->atr_sample_rate))
+	    (tx_ring->atr_count < sample_rate))
 		return;
 
 	tx_ring->atr_count = 0;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index bb741ff3e5f2..be587f804e7a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -372,8 +372,7 @@ struct i40e_ring {
 	u16 next_to_clean;
 	u16 xdp_tx_active;
 
-	u8 atr_sample_rate;
-	u8 atr_count;
+	u32 atr_count;
 
 	bool ring_active;		/* is ring online or not */
 	bool arm_wb;		/* do something to arm write back */
-- 
2.53.0

