Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD2E606A31C
	for <intel-wired-lan@archiver.kernel.org>; Mon, 19 Oct 2026 21:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=qOjOknM8;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fGsjOV07
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8FDB36076B;
	Mon, 19 Oct 2026 21:06:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ny4IaWBLmylJ; Mon, 19 Oct 2026 21:06:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CF6106075B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792443981;
	b=CGc0AwSOAaQBx5TfK+32Ai33KhUVn11QV/8kX/qh2NefAG7njtRTnikR6T1y5WoxEeJ4
	 fldhoUa/54Rh6hMJDXVy/q+PHctq/yWQ7JaZhiFIwdBWIb/vkRPj4unWCfKnhQQL6eeEB
	 A4egBSo4y1Ng1aFcKy1xYQJJJ6XPpx4wTvwfxSeDBbiHajAupoNIDJPycHhfTrqeYmLag
	 eX9VnDm8Ps0/rCa9JF3mWZIqAhQCJwC+JbZaFV/7/V2d5CwHJywNt5pePYIc83q1LzGpf
	 +0DJucYbRY6ymfBTW/ZexptvaQHHhhMjPgf8Hw72+EEDfuaRQIpA7s62C5nWU3iZf0w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792443981;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 Date:In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:
	 From:To:Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XfnY0DQvDrTEPobKWSGpJJKZhuCHUJe4OK2P9eZsJs4=;
	b=ixOLgoehDPZla1VYTPbv8DdkHr3K3B4HAUghdCGSiabGx50ulmuSCLQkxKE1iqpvOOpx
	 jVAQTMwj51vvGTcvd6DSZLFfhfwzjtsH4q21tK+kdlsmveMgAVSyh5TZN3o8JarABy8EE
	 2JBsGMtb4I3zPuMxPepdFpp7Fa1TwKvPKTS3saCeUd3dbaBMu7e/NCTUGjM1JXk65aqWp
	 WULyicB3/WQjUkmL5TUm6rnOVi2++vCNL0NeMfD5lx/s2sO7HiWrl6RAEnm16BqKGkxn8
	 P5GOE8HeMrOfAq0YI0PfIOr7eSz9nO+KUj9uYI5hn0ah+vQuHUeHmcztwUvCNyVggzQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792443981;
	bh=XfnY0DQvDrTEPobKWSGpJJKZhuCHUJe4OK2P9eZsJs4=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qOjOknM8DCrhoda6G/ygPvovBAeWsgL2dx8/ztn/8+ZZspsRB4pQLerRyWcqb0+Y+
	 tKv3R2wFV0s8vVvErQqXhwJAQiI7a+vEZ4DHLtrxkaaR3NIz+YlEbSW00pU30ekvEA
	 RyRH3cMn0YnxBeCobQLO8lr8V7T8MJ+HQKoGJqsZFQUnpdpYYSi7Bm6L+8O8acx8Fg
	 Hq5HPfTCjzwHCeVdkBJtmbWL+1yvgZiI5sMwPD2RyJlWwMjnPebXNWk70Hf3hyjmEo
	 Gz7XG3n+5pUcEKrN2klgwG6xvZ3pUX6Io13cdPESweQnTyoVLwOSp3NHsbQ4vmemQR
	 9xEANn4UX7HLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CF6106075B;
	Mon, 19 Oct 2026 21:06:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E413523F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 21:06:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E125240713
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 21:06:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L2Gxe-_NYp-u for <intel-wired-lan@lists.osuosl.org>;
 Mon, 19 Oct 2026 21:06:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CA09640712
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::648"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792443979;
 b=JODtPa1KRF9CAQEiZbUKts8k8JXREcpeRhLlji1+z5uAg9aKWqcRzT0OEGG4MvpXGQ/l
 2ca0vow9cXPgesM1BxYlk9WF4sk5TqOfp4z07AnzaItrPuz3bMtegpzyijzssRdOSVzIB
 gurfVoqGIYZLP7rWvpAhLrMFaMteOwjG1KZm93gwT+6ItaEe1ubOxkTkEfZZ5mHkpmDY1
 uN9Nd9nVuaAzCKzyoSgeNC+XI6Wyf9vo43tk+eCaynubJAVd8Q1eciAQi3KcAUP9uPI3D
 gjU+jlBqejhS+61+8flqG5Muvw4ubK01dT3TJQLDhWoQZnq5VamGD3O8uqpcFVyPMhA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792443979;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
 bh=XfnY0DQvDrTEPobKWSGpJJKZhuCHUJe4OK2P9eZsJs4=;
 b=NHgKrNq7qjeMNJ8bzZ65n1JMvcY04FY7zAmjaNsYovMWUyoDgtsNRrtkh6s1NyiNP8Ks
 VSYNWniGNnkw8B/JCq6wFh1JPIgzPM9TyHw6iUaX6oMAoYu8B5czhUw+XA4F+i2LVq6zW
 TL6Pl5MgIMvfVwpGEspLw+dfQrwUOUzMqyuJner0JK/5pO2kDBKPoxFvVuAetF57/2geU
 FyDTKZfvccAgKKfzclxqq7rVuL2OMxdeMZJd29rPaOkMTMkkwVdOt7UMm5pPCajmj++ra
 a1feS1Z5FDETvpPVOYiIWeFAx3ocZ3S24v+TN+WmVvDgFvnKgsg6t35D4my9w2dIhZw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=google.com;
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=fGsjOV07; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::648"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::648; helo=mail-ej1-x648.google.com;
 envelope-from=3sibwagykdw0y4vcc1t11tyr.p1zv06ry-9v4rq-yn0yv565.15715y.14t@flex--lrizzo.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20251104 header.b=fGsjOV07
Received: from mail-ej1-x648.google.com (mail-ej1-x648.google.com
 [IPv6:2a00:1450:4864:20::648])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CA09640712
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 21:06:18 +0000 (UTC)
Received: by mail-ej1-x648.google.com with SMTP id
 a640c23a62f3a-c2942fa0995so264157166b.1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 14:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792443976; x=1793048776; darn=lists.osuosl.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XfnY0DQvDrTEPobKWSGpJJKZhuCHUJe4OK2P9eZsJs4=;
 b=fGsjOV079reo3U8EIH82cy2u4rCl2zTvo8aBliTLug1/vLLW05ROKD1SZdJSUI8z4v
 gxUvFxFDoQuh7aXVQrdH3jdP6sbxbsHnQTwK+TqtioOQcvQM3g+G8eCeVXFr5tauVRE3
 GoGEgq8XSBf85rva7i+oYIZdhj06y0GZj/GGtaWfSvKqPe9g8MWo3VnGs7fPBFxkY1Oa
 ecMr+Hq9Iwxw0/mNhc5T/nxGAcfFUZkSg5Cxvi3/t0NgC68RAUNNjqeQsufs2gyWDKjz
 jFrOrjRDNfTxWBdOFv8l5f22OyB9uoR4RsIf290UJul4ojKsYBCllzvns0fRSfYE8VoN
 dLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792443976; x=1793048776;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XfnY0DQvDrTEPobKWSGpJJKZhuCHUJe4OK2P9eZsJs4=;
 b=RCcvTJjkxseyE17a55qwPMoe4L5If3E6dYocfmT0LO2cpyYwywHYILZTw6Qy+/TGuh
 Yv8oUl7wRO7acYNfYFyj903YuN65lVW2uTLyOWkUJpR7Z+9gFC8aJfzTyjXhefx3gTfi
 iMpx8+Qv5t18Yd7+eY4D360gVbb/cTNYZjV1ARb3Jfp0a5w1TgOD4YRVftevIrBJ33OB
 V+EZ7772xwu0F4TvZ2J1ftVmYNJ6Rm05n6U1mn1OfwkKGrAf1ynnqP2aDv55uzjuple/
 MGUAm+8FAblp0kbjMP1JHmKMxIJ6/iXyCFtiP0rkV5BOQ+CX37ngnTiByUcGNIs0xXV9
 HD1A==
X-Gm-Message-State: AFq9FYKo/JRJF3NEbpcPg7pvrrg45J0oSHi+q+S0safLLu5l6ziioPfz
 5Nbqnn986UAJIM78WvI6FSkEspD3CIQiZMO1N8LV9HqZguNuIQdFdREUBScRXe/uI0SAmeQUS5O
 8SZVQueDxWvLu+xKpKU0lF79jPapMzwICjBjppaZ0rVRFQKKZ/DeYYhpftm4rshY7TgbZXK82mS
 bM/Kd81s0iUxKb1dOH2o2SLea5xkSIiHozM6tncULPQu74kmdK0A==
X-Received: from ejcfp43.prod.google.com ([2002:a17:906:9e2b:b0:c2e:5a25:5773])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:e1c5:20b0:c41:c718:f5c5
 with SMTP id a640c23a62f3a-c41c71926e4mr380398466b.13.1792443976050; Mon, 19
 Oct 2026 14:06:16 -0700 (PDT)
Date: Mon, 19 Oct 2026 21:06:04 +0000
In-Reply-To: <20261019210604.2433620-1-lrizzo@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261019210604.2433620-1-lrizzo@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261019210604.2433620-3-lrizzo@google.com>
Subject: [PATCH iwl-next v2 2/2] idpf: use GFP_KERNEL for the initial Rx ring
 fill
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When idpf fills its Rx rings at open or on queue reconfiguration, the
allocation runs in process context, right after page_pool_create() and
before the queues' NAPI is enabled. Allocating tens of thousands of
buffers across all queues with GFP_ATOMIC is needlessly restrictive
when the caller may sleep.

In splitq mode, idpf_rx_post_buf_desc() is only used for this initial
fill, so switch its header and payload allocations to
libeth_rx_alloc_gfp(..., GFP_KERNEL).

In singleq mode, add a gfp_t parameter to
idpf_rx_singleq_buf_hw_alloc_all() and pass GFP_KERNEL from
idpf_rx_buf_alloc_singleq() and GFP_ATOMIC from idpf_rx_singleq_clean().

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c | 7 ++++---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c         | 9 ++++++---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h         | 2 +-
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index e3ddf18dcbf51..d623e4ab8511f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -885,11 +885,12 @@ static void idpf_rx_buf_hw_update(struct idpf_rx_queue *rxq, u32 val)
  * idpf_rx_singleq_buf_hw_alloc_all - Replace used receive buffers
  * @rx_q: queue for which the hw buffers are allocated
  * @cleaned_count: number of buffers to replace
+ * @gfp: GFP_KERNEL for the initial fill, GFP_ATOMIC from NAPI
  *
  * Returns false if all allocations were successful, true if any fail
  */
 bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_rx_queue *rx_q,
-				      u16 cleaned_count)
+				      u16 cleaned_count, gfp_t gfp)
 {
 	struct virtchnl2_singleq_rx_buf_desc *desc;
 	const struct libeth_fq_fp fq = {
@@ -908,7 +909,7 @@ bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_rx_queue *rx_q,
 	do {
 		dma_addr_t addr;
 
-		addr = libeth_rx_alloc(&fq, nta);
+		addr = libeth_rx_alloc_gfp(&fq, nta, gfp);
 		if (addr == DMA_MAPPING_ERROR)
 			break;
 
@@ -1095,7 +1096,7 @@ static int idpf_rx_singleq_clean(struct idpf_rx_queue *rx_q, int budget)
 
 	page_pool_nid_changed(rx_q->pp, numa_mem_id());
 	if (cleaned_count)
-		idpf_rx_singleq_buf_hw_alloc_all(rx_q, cleaned_count);
+		idpf_rx_singleq_buf_hw_alloc_all(rx_q, cleaned_count, GFP_ATOMIC);
 
 	u64_stats_update_begin(&rx_q->stats_sync);
 	u64_stats_add(&rx_q->q_stats.packets, rs.packets);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 4311ffa30bb18..b1127ab48ef3f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -600,6 +600,9 @@ static void idpf_post_buf_refill(struct idpf_sw_queue *refillq, u16 buf_id)
  * @bufq: buffer queue to post to
  * @buf_id: buffer id to post
  *
+ * Only used for the initial fill, from process context, so it allocates
+ * with GFP_KERNEL.
+ *
  * Return: %false if buffer could not be allocated, %true otherwise.
  */
 static bool idpf_rx_post_buf_desc(struct idpf_buf_queue *bufq, u16 buf_id)
@@ -618,7 +621,7 @@ static bool idpf_rx_post_buf_desc(struct idpf_buf_queue *bufq, u16 buf_id)
 		fq.fqes = bufq->hdr_buf;
 		fq.truesize = bufq->hdr_truesize;
 
-		addr = libeth_rx_alloc(&fq, buf_id);
+		addr = libeth_rx_alloc_gfp(&fq, buf_id, GFP_KERNEL);
 		if (addr == DMA_MAPPING_ERROR)
 			return false;
 
@@ -629,7 +632,7 @@ static bool idpf_rx_post_buf_desc(struct idpf_buf_queue *bufq, u16 buf_id)
 	fq.fqes = bufq->buf;
 	fq.truesize = bufq->truesize;
 
-	addr = libeth_rx_alloc(&fq, buf_id);
+	addr = libeth_rx_alloc_gfp(&fq, buf_id, GFP_KERNEL);
 	if (addr == DMA_MAPPING_ERROR)
 		return false;
 
@@ -675,7 +678,7 @@ static bool idpf_rx_post_init_bufs(struct idpf_buf_queue *bufq,
  */
 static int idpf_rx_buf_alloc_singleq(struct idpf_rx_queue *rxq)
 {
-	if (idpf_rx_singleq_buf_hw_alloc_all(rxq, rxq->desc_count - 1))
+	if (idpf_rx_singleq_buf_hw_alloc_all(rxq, rxq->desc_count - 1, GFP_KERNEL))
 		goto err;
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 93547597efd2a..e27438c78ec79 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -1123,7 +1123,7 @@ netdev_tx_t idpf_tx_singleq_frame(struct sk_buff *skb,
 				  struct idpf_tx_queue *tx_q);
 netdev_tx_t idpf_tx_start(struct sk_buff *skb, struct net_device *netdev);
 bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_rx_queue *rxq,
-				      u16 cleaned_count);
+				      u16 cleaned_count, gfp_t gfp);
 bool idpf_rx_process_skb_fields(struct sk_buff *skb,
 				const struct libeth_xdp_buff *xdp,
 				struct libeth_rq_napi_stats *rs);
-- 
2.56.0.212.g129ede20d9-goog

