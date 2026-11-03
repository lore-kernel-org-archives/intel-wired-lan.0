Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CE6606A33F
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Nov 2026 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=wUYIiO5/;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aMIS84u7
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C24E80C84;
	Tue,  3 Nov 2026 16:23:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V32XZRyOJFyU; Tue,  3 Nov 2026 16:23:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A2C6680A87
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793723015;
	b=gQFdc3g+kG4Mm5/dKCc/qOcxfl097O6nviJpupeteRiOC/MKWSg8quDWHNcVuoEJfyrP
	 HgVCGlUIfyHplmKpjxFGP/3n+YjW1ZYb596syBHjb3W2koiMEV7PdBSwh4xSff/2x0ICC
	 wMiTi6B0SZo4uyYL+OSJX9JfleO/MeW0FYX9znq8Gd7Z6Aw38ThuYh0jImdfBfNq+wi54
	 dNBPcNlRK2XoQ2aa4jUs7Hha6WMUNgc+9IuFV4Fceb/PLoh7GiBaaxR2G/k2TptBaZATS
	 VWRV6RIJBbMqltpOUSccj789DbU9KYQmZP7Oq6StP8puJ7W+iKItGWlc6FCva3+ydMw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793723015;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 Date:In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:
	 From:To:Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9VsMG0ZVwtVW7+osviETCc9BDdPpuMXt1m2c2HzrSlg=;
	b=eo76xp06tp5S5nxzJvHw7wXnBeJEFlmBUNThxmYquNbqFsNOoZJ7yR5hSZkqYCRd8IHd
	 FVlk9uZIS5M9D7xrKJ9oSJCuixEgpaNbCg4PbhaPqaps/DniYtwco4iK1b/7UD+reUGiw
	 M8OW1np8Rm74bx2RYbOTDWvfYFicH0UgyC0d+0QAC3tZGW9Djfl6I4ha01kazivDFxPhp
	 vjyoFy3PHbaASvxs6YC+JpP3nyfTBA/R5p84Zobhzo/rFszIOi+Jx+Yr+V2PDZ/2F0FkP
	 hg7n4ayJcpnKe6aPh2/jhL9bQKLRJIxFo0tegeKFLTl3A0bqCTRZJHwRLgKrAtq5G/Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793723015;
	bh=9VsMG0ZVwtVW7+osviETCc9BDdPpuMXt1m2c2HzrSlg=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wUYIiO5/lZQOq/HFRRTnZsIEY01pzT8fdfcpiJUyGdeGzXUv7ic6bbhsZ4mgU4flv
	 6mL/4+camychFQENIkmj9+hW44cyI+fjnxnpBEtLxwtLHeIsuIyamXwZHLSC8oP9O9
	 fUtMrIEfX7Dh6xSIjyF08ZrCMh6OvJGJSCtfcvWNN4x+cqfqiwKDnp8MV9PWHDJtib
	 mXl+IR6O1kU4RSUNi2aSsbcScycimFHxc/7H1xrQcLDtddxVw4M+EtWfSWCCkkrFVz
	 gJT9ajF0BL1C6u1hC+m47VLku9q32SOyyStSz4FO9yPwWmwN6OhUzInidhNeu5W1pX
	 njNQoNM6y9HxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A2C6680A87;
	Tue,  3 Nov 2026 16:23:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6FF2D4BC
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 16:23:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 56018400BE
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 16:23:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jGp4SPaKF7Ow for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Nov 2026 16:23:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6AD9040068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::646"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793723012;
 b=duZNUW/X/6LnULByyv68o7vGXziMBHVHhWZg+O1RJsk63v41IizrK1H47bdUjl+dwbht
 bTMZR1pXExbE71xwLMjOSdPpqvtUEA5qQowrEsG9iGMFGVZbJL8cZd3QQH8I6xFN7mNr3
 vtpOgEzUmy1pB7C7awhcKpD+HB10SycYwpIiGm0yV07u5YQ3UNd649OgSDdLcnETi42tn
 zh0z3Tljzz3Elht33HKw4xfreYu7ZzjYeLD+4iDQB97g30aTx7VsH53PuAOfro77dGPRw
 gv5zgjTmM6NTQuwtCjmJLxcsysDUYt4UEOeosmAKaQ6QH5dKGmLbYYXtDdNzggNG0EA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793723012;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
 bh=9VsMG0ZVwtVW7+osviETCc9BDdPpuMXt1m2c2HzrSlg=;
 b=c6IbQxe9/NNw1f5I2QLDWYRfvldtaBTeajiAlnqDwcIufdyBULQQrEZzh6IgLRZ3Q2jT
 vx7wqdjow4bNrbj0WgU1giSb+QCIKJI06x4DXSCYsUSlHKexoiSahjK8/7td6pcTCHftN
 uMKCfbTI/bd3hK1DANn/BnGoOGKYYQXBfr4+ONSyn10O81RtFBw0QTVQ6BfB23OFGXHYs
 cgKTbD7VasOGfAAfl6PjZrYVtt4M/2zsFNCe4awSZ8B7ZRdKv/BvDqgVYr5j0STb1ComT
 g9m/nM3y8r9IVcBqN5M8QGM0/OH4BTrickpypIKZG4U44ShiNjob7fPf9kQBYA7MY1A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=google.com;
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20260707 header.b=aMIS84u7; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::646"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::646; helo=mail-ej1-x646.google.com;
 envelope-from=3gqrqagykd5whnevvkckkcha.8kiejpah-sena9-h6jheopo.koqkoh.knc@flex--lrizzo.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20260707 header.b=aMIS84u7
Received: from mail-ej1-x646.google.com (mail-ej1-x646.google.com
 [IPv6:2a00:1450:4864:20::646])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6AD9040068
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 16:23:32 +0000 (UTC)
Received: by mail-ej1-x646.google.com with SMTP id
 a640c23a62f3a-c25edb54d22so567936566b.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 03 Nov 2026 08:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793723010; x=1794327810; darn=lists.osuosl.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9VsMG0ZVwtVW7+osviETCc9BDdPpuMXt1m2c2HzrSlg=;
 b=aMIS84u7IkGJ8A+a4hUkYffTNTCi4ZHQsYDvDAjd5werWqAkeJQh1UOyg1O0gcZODB
 TWsqR6vsDH9drhMqGv9M2iTWu+UVFCfj80wiSVQ1tqt2Hmu8GUv22g77B6H2CARFW0Zq
 Sl34NIUZZwZXbRBj3j5oqBxmRARI/pAw/mNis1k6veJ2+GBddmx6mPEC6MPgfzblflQs
 ivCIG+1abzC7D3e7CNUe7f6w2qthc67xGC9r+7WPsMCs89mnucg3lRjqtmk2hmotFuaX
 O4iin5axfk1OUY2PLtCrOnJj7W3H4xAcqBrZJomtSHJU+9NEkFdKqwod0STSDIsL7mgS
 UFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793723010; x=1794327810;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9VsMG0ZVwtVW7+osviETCc9BDdPpuMXt1m2c2HzrSlg=;
 b=PnZJpQXGjk0CYW2/MTkVExLtRobRTv0bFma8Ane1aN/hAfuJZSNh3JPnOzkkwO8cE0
 8+4qS+zAyBSNX62Tb9BTO+bKbK1ReSBJHoMhT7t+RNYGHBDxfD8Mso8rhZTOuo6KVZfk
 rpO9p6Vb7j61n6I5m9D3CF0TdDQVjIlnKqIEFeC/sJvBY4zh1N//eVQoygGXJ4mQaK7V
 SnNZeZW9nnkr/8rm10oiuAZ0nFBVZpfzjqMp7V8Hm59qDULExnXl5n0JDDl/bbjT8x1I
 dGQV8r9FHh+Nxct+2IEo+ufBad0kp+xiSH092St7gpNuGj7qXDEMMxvsMP3XcVqgz6ED
 J+Hg==
X-Gm-Message-State: APuU4Z9kjknZFwmISPA2aNCS7puM1LwRJtNGHsDwEfygVLLz/V0PdmC+
 WWp1e1W9MVGNxMurufXB0edcgORxUINj6K5XKvMiIbT2CpMarhOeH4g+9IyKDkAQ6ml3slULdF9
 TBMjmHp/QBoWsacn3xWUEb6CvAYwvbbNBoG7bicLgiGNiC/f4x0hC5xo/xRM/Il7dXtKPCoB10Z
 AgEgQdDAEWorLVdFzpayKd6Ao/s2TJbt9BHloxiWlda0blCg1bow==
X-Received: from ejeb13.prod.google.com ([2002:a17:906:194d:b0:c4d:5f4:bb5e])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:f582:b0:c34:e9fe:82ed
 with SMTP id a640c23a62f3a-c4ca7aac4f0mr1166497966b.28.1793723009807; Tue, 03
 Nov 2026 08:23:29 -0800 (PST)
Date: Tue,  3 Nov 2026 16:23:24 +0000
In-Reply-To: <20261103162326.3615979-1-lrizzo@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261103162326.3615979-1-lrizzo@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103162326.3615979-2-lrizzo@google.com>
Subject: [PATCH iwl-next v3 1/2] libeth: add __libeth_rx_alloc() to specify
 allocation flags
From: Luigi Rizzo <lrizzo@google.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Luigi Rizzo <rizzo.unipi@gmail.com>, Brian Vazquez <brianvv@google.com>, 
 Joshua Hay <joshua.a.hay@intel.com>, Larysa Zaremba <larysa.zaremba@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, 
 linux-kernel@vger.kernel.org, Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

libeth_rx_alloc() calls page_pool_dev_alloc_netmem(), which always
allocates with GFP_ATOMIC | __GFP_NOWARN. Drivers also use it to fill
their Rx rings at open or on queue reconfiguration, which runs in
process context before the queues' NAPI is enabled. There, the caller
may sleep and GFP_ATOMIC is needlessly restrictive: it can neither
reclaim nor compact, while the initial fill can allocate tens of
thousands of buffers across all queues.

Add __libeth_rx_alloc(), which takes a gfp_t parameter and passes
gfp | __GFP_NOWARN to page_pool_alloc_netmem(), and make
libeth_rx_alloc() its GFP_ATOMIC wrapper.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 include/net/libeth/rx.h | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/net/libeth/rx.h b/include/net/libeth/rx.h
index 0e736846c5e8a..1333850f421a3 100644
--- a/include/net/libeth/rx.h
+++ b/include/net/libeth/rx.h
@@ -96,20 +96,24 @@ int libeth_rx_fq_create(struct libeth_fq *fq, void *napi_dev);
 void libeth_rx_fq_destroy(struct libeth_fq *fq);
 
 /**
- * libeth_rx_alloc - allocate a new Rx buffer
+ * __libeth_rx_alloc - allocate a new Rx buffer
  * @fq: fill queue to allocate for
  * @i: index of the buffer within the queue
+ * @gfp: allocation flags: GFP_KERNEL where the caller may sleep (e.g. the
+ *	 initial fill of the ring), GFP_ATOMIC from NAPI
  *
  * Return: DMA address to be passed to HW for Rx on successful allocation,
  * ```DMA_MAPPING_ERROR``` otherwise.
  */
-static inline dma_addr_t libeth_rx_alloc(const struct libeth_fq_fp *fq, u32 i)
+static inline dma_addr_t __libeth_rx_alloc(const struct libeth_fq_fp *fq,
+					   u32 i, gfp_t gfp)
 {
 	struct libeth_fqe *buf = &fq->fqes[i];
 
 	buf->truesize = fq->truesize;
-	buf->netmem = page_pool_dev_alloc_netmem(fq->pp, &buf->offset,
-						 &buf->truesize);
+	buf->netmem = page_pool_alloc_netmem(fq->pp, &buf->offset,
+					     &buf->truesize,
+					     gfp | __GFP_NOWARN);
 	if (unlikely(!buf->netmem))
 		return DMA_MAPPING_ERROR;
 
@@ -117,6 +121,18 @@ static inline dma_addr_t libeth_rx_alloc(const struct libeth_fq_fp *fq, u32 i)
 	       fq->pp->p.offset;
 }
 
+/**
+ * libeth_rx_alloc - allocate a new Rx buffer from NAPI context
+ * @fq: fill queue to allocate for
+ * @i: index of the buffer within the queue
+ *
+ * Return: as __libeth_rx_alloc().
+ */
+static inline dma_addr_t libeth_rx_alloc(const struct libeth_fq_fp *fq, u32 i)
+{
+	return __libeth_rx_alloc(fq, i, GFP_ATOMIC);
+}
+
 void libeth_rx_recycle_slow(netmem_ref netmem);
 
 /**
-- 
2.56.0.385.gac671c819a-goog

