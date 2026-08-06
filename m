Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C86C5AC67
	for <intel-wired-lan@archiver.kernel.org>; Thu,  6 Aug 2026 23:29:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B66F4408FE;
	Thu,  6 Aug 2026 23:29:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I-5tbzYWKYWB; Thu,  6 Aug 2026 23:29:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5938F408F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786058967;
	bh=ZifFpVx4BW7pemc+Qe2nKHeySWm1EELGJZ9eoiY9qdA=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c5OUKf3aRCqCctqzFtcomJImZBafGm5HsOcY2Yba7rlp3fm2ZrflvKq6hmOcz2XVP
	 zLouGQrCfFo4rH8arFEWzASkXXf6KZFi2pQsmuvlyYlpMgavj/aTNJLGG8oiLDKbrp
	 idGJG34qAMtNmwK+6aiUL8szlNWekF7d2jYBua2WlXZ/yJmXybi8hyt+KqFqpDFyV3
	 8avnv4UqivkY9Ik17XzjKN+4quPjH5P0bFVLPR5/IAsTdRzepDpVQ1yQCyXZP68hQN
	 GzqO3Jf3PbMID5Vez3t04AwpT+5aNhLAIAF64FDomyOnFZsN7ZNWPmx/+JbbKoVDHZ
	 /87DPy29YbS9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5938F408F4;
	Thu,  6 Aug 2026 23:29:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 59B79198
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 23:29:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 403F5402F6
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 23:29:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1nw3ROM8ToBm for <intel-wired-lan@lists.osuosl.org>;
 Thu,  6 Aug 2026 23:29:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b129; helo=mail-yx1-xb129.google.com;
 envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7761C40240
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7761C40240
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com
 [IPv6:2607:f8b0:4864:20::b129])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7761C40240
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 23:29:25 +0000 (UTC)
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-664b05d408bso2739756d50.1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 06 Aug 2026 16:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786058964; x=1786663764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZifFpVx4BW7pemc+Qe2nKHeySWm1EELGJZ9eoiY9qdA=;
 b=p4bdOtM7jj9GYCVvMkgN39gJQEvwqhFxpq8FD15N3Fiu9nIOu5bXDH+xegTIeXvvpg
 Ak1er1t18HFJcu4LMC2ThwhCbRmmOKA0sE6c+npjoue0j33drjLsDicLawpydxrvM7Zs
 AULIt3jABf/IJF3iZQthn/5/6io9KKpLj8tErL13vlD6ffgbWMzNiRwX1/AJvi1MYpbI
 boHaQ23zKYWidJNsrEJcxiPm+GuY6of83eXxo9I3Lx7pHXD8e5eVWZoBtyndGzBPEqnP
 VZ3IXnynAEIP2w7hRXK3k8a/LdVKMrXFGNnliZFSLA+PMFFOcD0TcGoRr8Vw1lTPXNro
 4e5w==
X-Gm-Message-State: AOJu0Yyvx0cHmaQaqUdkGWU4Y42AMEY/cSy8K/XteozV/rDXMlyejCes
 UuwfdwTX9F5OdiekYsZfpkZvSh5xlW3X4K2f8UuF07IBIKH2bcmPy9RlS2JogA==
X-Gm-Gg: AR+sD10yF6CyOFqU+W5LIzeOwmDpF8Y+IdzzY90/ouklS2ylfbv6E67/Nh2H+YmI7Z8
 adujb9SKvFcZWwpa1e0JCcCmsUE/bvyFqBnOAFIh9Tw6n+kxHXGy1Nu1Dyo3R/FZB/5zWQ/8yKx
 CyIiQg4BreUiZjEAvISlTGK2xCsrFxrw4PbJOGstRFwj8S9jILZKuIM0gcIasicA/NFU0J9cHFn
 90AYPtr05nTeQSrBj1mVS8Df2h0O+CdosLycM4AnpdojabRV0v7N7rv4KKuWYjeYPcfp+h59wRh
 yIsu5kwcDRupkaafAQ75OqzqQFHhrY6lMoolqP17pjU6JeyxRopv6m0YQ4po55uSdh0sci8mHas
 ffja31M2e2mSdd2hE6Nv+f65v4ZPgW2L84XPfNcO7OUnWCEBnoo2+WJRZnWxVuSUt5u0FXtem3a
 Kx5lMjPZVuMac/WzxUdVz14UJ9lXTkladlFH44orDmNmakGJTiY2kBICGWmkvIzEl4YamR6P5rY
 Puyx7jzapG2OE4JAZ/StUT8Pf8vmXW19LbTrmnF/O2p66Sz9ADuzYKszdQ=
X-Received: by 2002:a05:690e:45:b0:667:b645:5303 with SMTP id
 956f58d0204a3-6699aba143dmr8358514d50.33.1786058964059; 
 Thu, 06 Aug 2026 16:29:24 -0700 (PDT)
Received: from willemb.c.googlers.com.com
 (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66acacdbdf2sm209273d50.4.2026.08.06.16.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 16:29:21 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 joshua.a.hay@intel.com, przemyslaw.kitszel@intel.com,
 Willem de Bruijn <willemb@google.com>
Date: Thu,  6 Aug 2026 19:25:59 -0400
Message-ID: <20260806232913.4020403-3-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
In-Reply-To: <20260806232913.4020403-1-willemdebruijn.kernel@gmail.com>
References: <20260806232913.4020403-1-willemdebruijn.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786058964; x=1786663764; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZifFpVx4BW7pemc+Qe2nKHeySWm1EELGJZ9eoiY9qdA=;
 b=XQSPiBh1YRbhpfALIwcsP2w6KA1bOKWMYf+bVhD83BzgXjqRkc6OWKKW43Z58/MfF4
 Gnppmrg9MMiQTTPX1HsYqLCRpjS1a9XXwok15FjVYfiJzaZGefJtTL2oxVql1DmYO+r/
 BVppuptHolDJ1AcKncJcStGr09PWu5vNkSNlg/kjANW3tQxXOOpXv84tFyad2tjsoESs
 q1hbNLGnvUkpT/2XhckVOq4he5XPQw4dW4gWejHzxs9JxSQ2HuWUh667xnW4ZudRKDUQ
 nQl3WRJhy9eyZOGTHB06eQOje7P0lm6LacSzEWCJ1jYtyO5q/pWVRqCTRPxq4KIw8Nzm
 w/ZQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=XQSPiBh1
Subject: [Intel-wired-lan] [PATCH net-next v4 2/6] net_sched: sch_fq: clear
 past skb->tstamp if offloading pacing
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

When hardware offload is enabled, FQ will forward packets to the
netdevice for pacing. The device has to test that skb->tstamp is
in the future.

Avoid this cost for packets whose txtime has already passed, by
clearing skb->tstamp.

Also disable timer drift logic when offload is enabled, because
time_next_packet can exceed now causing a negative value.

Signed-off-by: Willem de Bruijn <willemb@google.com>

---

Changes
  v3 -> v4
    - also reset tstamp_type
    - minor: initialize time_next_packet for more obvious correctness

Sashiko, ignore pre-existing issues. In particular, effects on
non-EDT packets and when queue or sk rate limit is set.

Sashiko, pacing offload is an optimization. Ignore that some packets
may not get offloaded, e.g., when txtime is a few usec in the future.

Claude suggests to only call __skb_clear_delivery_time in one location
in fq_dequeue. Unfortunately the separate fastpath location is needed
as that avoids computing now in fq_dequeue for these fastpath packets.
---
 include/linux/skbuff.h | 17 ++++++++++++-----
 net/sched/sch_fq.c     | 19 +++++++++++++++----
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 22eda1d54a0e..b3445ad5a35c 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4490,20 +4490,27 @@ static inline void skb_set_delivery_type_by_clockid(struct sk_buff *skb,
 
 DECLARE_STATIC_KEY_FALSE(netstamp_needed_key);
 
-/* It is used in the ingress path to clear the delivery_time.
- * If needed, set the skb->tstamp to the (rcv) timestamp.
- */
-static __always_inline void skb_clear_delivery_time(struct sk_buff *skb)
+static __always_inline void __skb_clear_delivery_time(struct sk_buff *skb,
+						      bool want_tstamp)
 {
 	if (skb->tstamp_type) {
 		skb->tstamp_type = SKB_CLOCK_REALTIME;
-		if (static_branch_unlikely(&netstamp_needed_key))
+		if (want_tstamp &&
+		    static_branch_unlikely(&netstamp_needed_key))
 			skb->tstamp = ktime_get_real();
 		else
 			skb->tstamp = 0;
 	}
 }
 
+/* It is used in the ingress path to clear the delivery_time.
+ * If needed, set the skb->tstamp to the (rcv) timestamp.
+ */
+static __always_inline void skb_clear_delivery_time(struct sk_buff *skb)
+{
+	__skb_clear_delivery_time(skb, true);
+}
+
 static inline void skb_clear_tstamp(struct sk_buff *skb)
 {
 	if (skb->tstamp_type)
diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 7cae082a9847..8d7458c38409 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -399,6 +399,11 @@ static struct fq_flow *fq_classify(struct Qdisc *sch, struct sk_buff *skb,
 		    READ_ONCE(sk->sk_pacing_status) != SK_PACING_FQ)
 			smp_store_release(&sk->sk_pacing_status,
 					  SK_PACING_FQ);
+
+		if (q->offload_horizon &&
+		    fq_skb_cb(skb)->time_to_send <= now)
+			__skb_clear_delivery_time(skb, false);
+
 		return &q->internal;
 	}
 
@@ -707,6 +712,7 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 	struct fq_sched_data *q = qdisc_priv(sch);
 	struct fq_perband_flows *pband;
 	struct fq_flow_head *head;
+	u64 time_next_packet = 0;
 	struct sk_buff *skb;
 	struct fq_flow *f;
 	unsigned long rate;
@@ -721,7 +727,7 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 	if (skb) {
 		q->internal.qlen--;
 		fq_dequeue_skb(sch, &q->internal, skb);
-		goto out;
+		return skb;
 	}
 
 	now = ktime_get_ns();
@@ -758,8 +764,8 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 
 	skb = fq_peek(f);
 	if (skb) {
-		u64 time_next_packet = max_t(u64, fq_skb_cb(skb)->time_to_send,
-					     f->time_next_packet);
+		time_next_packet = max_t(u64, fq_skb_cb(skb)->time_to_send,
+					 f->time_next_packet);
 
 		if (now + q->offload_horizon < time_next_packet) {
 			head->first = f->next;
@@ -828,11 +834,16 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 		 * f->time_next_packet was set when prior packet was sent,
 		 * and current time (@now) can be too late by tens of us.
 		 */
-		if (f->time_next_packet)
+		if (f->time_next_packet && f->time_next_packet < now)
 			len -= min(len/2, now - f->time_next_packet);
 		f->time_next_packet = now + len;
 	}
+
 out:
+	if (q->offload_horizon &&
+	    time_next_packet && time_next_packet <= now)
+		__skb_clear_delivery_time(skb, false);
+
 	return skb;
 }
 
-- 
2.55.0.679.g6767b8d81c-goog

