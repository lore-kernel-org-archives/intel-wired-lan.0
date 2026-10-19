Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CDF606A325
	for <intel-wired-lan@archiver.kernel.org>; Mon, 19 Oct 2026 21:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=wrvIHopq;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=sIvxtaZ5
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 84DC26076B;
	Mon, 19 Oct 2026 21:06:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9AhpH0JgRGoK; Mon, 19 Oct 2026 21:06:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D985D6075D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792443976;
	b=T66TUkaZcj1uI7KFd+357prQXuQToKSyodpi4mquFZNH54ubhsBN0No3URXjjDgiDFb8
	 dSrFjHvXsmQecUEiA1tqLZbD87vP6uo6ZRj8D6SLtIcpEksJVmsQdV0+lSaCEq9tOULl6
	 BcocNxsBMPFz6dbVHOA5G7WXxFMVyzx6Ku91RSUVoSAMYDRKr5ctoHaupSXtdR91psNRl
	 fuaHMgeRtg65D6/nZzGa3vTEQ3u5mvsZfNbUwROjOSCqkBTQzjGtpfyBxapvun0pNMFgV
	 Bn9saw3RAijRQa6hWSxBK2nMf5+zxclFeKKHpjWhE/czFQ0w+jT4eCtXOY7GYppk+AQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792443976;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 Date:In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:
	 From:To:Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WqVC5CFEQLN+eiA8h21jf2v2wQ711iAVIxvEEPes1m4=;
	b=cKLCfddpRcwdEowwve23g2Yg+w0590QVolJu7EP2Al+tWz68pDyCYdInZYw6kmqSZRz4
	 BZijoGIlw4WA5zHn6vZrMIuxdeKNg83nurWDBgdGB2rUFIkEmzr+J5FEeYCuJKNNaOxBf
	 EA772WuW3kDRA9enD7bqdghM2H5zmXhtQHO7UaK/GhrSoYPXVRsDX8f3ymNu/YrcAafUy
	 kilRadnl+K32HdmrjpQuiwMrVR6bHttT07JcGlfRzDnLIC+wghGPh4BiLzEh8tf6YLxMi
	 QkP6G3UDUW7w262JFTFVGqSdVhQt9Zk6aGG3LKc+JV2neaH/opQQa4G0Tm/4rCmM3Xg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792443976;
	bh=WqVC5CFEQLN+eiA8h21jf2v2wQ711iAVIxvEEPes1m4=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wrvIHopqLtrTTPho315Xz1xJyMMPLTWq1CTlzriO3oPdkCtxYxCaJCvHjKZ2E9ZGx
	 ky5EID0xMNFl2+yxXc9FMU5bKYk7Ontbthu35m4KANb46nRoQXLeT2ifvA0dn5nFNn
	 0jVQKlpbz9TODXp3mRj2erN4+NU9skoasM9IgdwD88Tl68IMS2NBpyrK2d5SGStNzM
	 1dJVNoqj+RsyJ0Dx0M2piurzF5x5b9U5op3QkfeIyAugtq6PaSJsAKOU/e0BDvvWWS
	 V5cDPosY9BD+qjhjkvj9X4Nd+JOkWygtUvFAIqu57N/zC/xjwqwXiQiIv9jQ76vy2o
	 4EFAhjYKrqxKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D985D6075D;
	Mon, 19 Oct 2026 21:06:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 75A0C23A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 21:06:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 670574009D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 21:06:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dT6CQjwF9JEh for <intel-wired-lan@lists.osuosl.org>;
 Mon, 19 Oct 2026 21:06:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 774D04008C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::645"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792443974;
 b=SAA8Y7c5iP/WWCShS2awR2/vUkCAVMurZpnOYWADpqr7abDgrIh6BTi5eLu0oSqkUrlX
 +duN1vBojQvttd2TQVUxqefPaHqzJqeL0cWbxHVuwH9d3FArOw+Ea5hynTZuGeeT2LTdg
 tmWQ62lsYRKaWfU6/bwQyntYAGa56mq9K4b5314j9+wVzlDxWyLmGEcvNU6zdgz53WLuj
 TykLt0VlQoncwYM149RT9XryWH9qdvf6cfQwySNrYxoYvM4maeLyTvxN6APg9JCGbT/EL
 1sKs6qQvOgYDtWrV4km/18a3ZGoj88K2uP/SrF11z/6u5BUndQwHzVrMcjC95XJzPrA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792443974;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
 bh=WqVC5CFEQLN+eiA8h21jf2v2wQ711iAVIxvEEPes1m4=;
 b=Jh01DgmAv9KgD6zOrMBHjUeNMoAFeOCmnoSxu1AhwJJABNJbJI+mTOLsHc4Bpv2dnSJC
 pbZI0rPLoomuKIvBicL7O0lxjC0uDHXU8dqeKyADm6q7SVu24d55cvFETmsqEekPDJu1i
 /kIR8f0z+i+abi1srAsfGTpAV9xJqE79Nf2aUuDdkoyWpL/68dejKh5c53+VERCBMh9ib
 YrAhRWCC0TIsphvksf257d9JpdMUlLaBACA3mVeQ4/WcOGxk3gs9ASeNi2YGE2tX/Oinm
 2/4Ewu7dRTWj3+ZsfI4KQG6+GJLRuFtc10eQlYUCeaNoqjPeDp9HjkdC2UigHMyLS1w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=google.com;
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=sIvxtaZ5; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::645"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::645; helo=mail-ej1-x645.google.com;
 envelope-from=3q4bwagykdwgtzq77wowwotm.kwuqv1mt-4qzml-tivtq010.w02w0t.wzo@flex--lrizzo.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20251104 header.b=sIvxtaZ5
Received: from mail-ej1-x645.google.com (mail-ej1-x645.google.com
 [IPv6:2a00:1450:4864:20::645])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 774D04008C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 21:06:13 +0000 (UTC)
Received: by mail-ej1-x645.google.com with SMTP id
 a640c23a62f3a-c37b2763f1bso247545266b.1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 14:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792443972; x=1793048772; darn=lists.osuosl.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WqVC5CFEQLN+eiA8h21jf2v2wQ711iAVIxvEEPes1m4=;
 b=sIvxtaZ5Tl/lHXmD4IqXkQsEYnbqAjVA7YukMGscvv0d7gCWDf+fp+XnlIgtpbtOou
 +Tg+jnnb/b4DgKItrINwKCwLyVqcTOXqSNHmY9WdK4JVjhXuYcLINOiU5cVt0DP5ks0q
 hXEsLNaBoCjLvg5WIBMQxGeYAhpT6e6Ri0RYX8VUU0+YjvjFJTTVdK8qbQ5cXBzRuXGb
 nnIY2Jlt70dEm9pdS5Zc2MekCTOoGHtfH8o14zKBOOX76T+NA88Mfcn8myfre/j/nrdl
 mIcNzpPT4oxcBNzxySVRsN7THbuoILZs2GN3idl6zOGUKcRJBDYuv89XAFiHMlMknE8l
 FVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792443972; x=1793048772;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WqVC5CFEQLN+eiA8h21jf2v2wQ711iAVIxvEEPes1m4=;
 b=0JLAxXnxP15eOOAS9Hna2azD9GzHdfnXH9KvaZlsH1mU0sWY08cwviXOKy+pRWtNv0
 Xen9ngJhso9aY2c8Q2s94C2R47ezpSS6DYCsSJVXBw6NkK+CXhTzF2FDLrgDM3WPwD1J
 mIDbbuDz78Wsy6XHR5drv5HkBN/oyskUGARKb5x0u6gNEGhAqFdAFfaxlGzDHSo0Umhv
 abfQBgtvaYhsOBdmizSd6ipAH8CSrhEl5frCJI0eUJBqJwX2t5LldltCBJPdrVYpEYs/
 OD6g3O6WgkFIVhdwFulzYuIxt+BBMG6uJJyaUSSn51ahtFfuyXq+jG1uf7e0sGNRdNjM
 0wkQ==
X-Gm-Message-State: AFq9FYIwRqbrMPtmuUON0QgCRz6at3nScC63ZIT4sqSISvmS5om03zan
 Z+ttQo0XqR8n5vGp7WpjhZCpgu5lbn7XDm5ycEXEqhKL+r+qP2e6K1INwzcnmlBqow2qAL2s1T6
 ajiVMPiKZefk4IRh3sFtCQ/GjyESdc20ioCNWrAaAE4tMUl0qqxKvCpAhv+anLU0MYn8czEkS6l
 UVl7SDyO16l3rtFlTHL7qBcErR433hAZBC4OvZlDbx12Fkt3zxjQ==
X-Received: from ejbm7.prod.google.com ([2002:a17:906:2587:b0:c3b:6442:c974])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:9617:b0:c29:d31f:7d73
 with SMTP id a640c23a62f3a-c419d83b528mr591194766b.9.1792443971745; Mon, 19
 Oct 2026 14:06:11 -0700 (PDT)
Date: Mon, 19 Oct 2026 21:06:03 +0000
In-Reply-To: <20261019210604.2433620-1-lrizzo@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261019210604.2433620-1-lrizzo@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261019210604.2433620-2-lrizzo@google.com>
Subject: [PATCH iwl-next v2 1/2] libeth: add libeth_rx_alloc_gfp() to specify
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

Add libeth_rx_alloc_gfp(), which takes a gfp_t parameter and passes
gfp | __GFP_NOWARN to page_pool_alloc_netmem(), and make
libeth_rx_alloc() its GFP_ATOMIC wrapper.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 include/net/libeth/rx.h | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/net/libeth/rx.h b/include/net/libeth/rx.h
index 0e736846c5e8a..14a528ea8a075 100644
--- a/include/net/libeth/rx.h
+++ b/include/net/libeth/rx.h
@@ -96,20 +96,23 @@ int libeth_rx_fq_create(struct libeth_fq *fq, void *napi_dev);
 void libeth_rx_fq_destroy(struct libeth_fq *fq);
 
 /**
- * libeth_rx_alloc - allocate a new Rx buffer
+ * libeth_rx_alloc_gfp - allocate a new Rx buffer
  * @fq: fill queue to allocate for
  * @i: index of the buffer within the queue
+ * @gfp: allocation flags: GFP_KERNEL where the caller may sleep (e.g. the
+ *	 initial fill of the ring), GFP_ATOMIC from NAPI
  *
  * Return: DMA address to be passed to HW for Rx on successful allocation,
  * ```DMA_MAPPING_ERROR``` otherwise.
  */
-static inline dma_addr_t libeth_rx_alloc(const struct libeth_fq_fp *fq, u32 i)
+static inline dma_addr_t libeth_rx_alloc_gfp(const struct libeth_fq_fp *fq,
+					     u32 i, gfp_t gfp)
 {
 	struct libeth_fqe *buf = &fq->fqes[i];
 
 	buf->truesize = fq->truesize;
-	buf->netmem = page_pool_dev_alloc_netmem(fq->pp, &buf->offset,
-						 &buf->truesize);
+	buf->netmem = page_pool_alloc_netmem(fq->pp, &buf->offset,
+					     &buf->truesize, gfp | __GFP_NOWARN);
 	if (unlikely(!buf->netmem))
 		return DMA_MAPPING_ERROR;
 
@@ -117,6 +120,18 @@ static inline dma_addr_t libeth_rx_alloc(const struct libeth_fq_fp *fq, u32 i)
 	       fq->pp->p.offset;
 }
 
+/**
+ * libeth_rx_alloc - allocate a new Rx buffer from NAPI context
+ * @fq: fill queue to allocate for
+ * @i: index of the buffer within the queue
+ *
+ * Return: as libeth_rx_alloc_gfp().
+ */
+static inline dma_addr_t libeth_rx_alloc(const struct libeth_fq_fp *fq, u32 i)
+{
+	return libeth_rx_alloc_gfp(fq, i, GFP_ATOMIC);
+}
+
 void libeth_rx_recycle_slow(netmem_ref netmem);
 
 /**
-- 
2.56.0.212.g129ede20d9-goog

