Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA715606A326
	for <intel-wired-lan@archiver.kernel.org>; Wed,  4 Nov 2026 01:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=MNkNH21v;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=l++6mnWA
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B28CE80D49;
	Wed,  4 Nov 2026 01:36:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ihknLA4uqF-J; Wed,  4 Nov 2026 01:36:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0BAE480C6C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793756179;
	b=I8uAzVplhHpM/JgxFG3sJR4XLdchhgTBLtb3wNxQM6uR+VPkZOOJbJKufsZRPckheSaF
	 ONRjzfLU+N1fh4Yv10HoDns23zUd7rzcE9EOqs1g3yegM1Ct2c1FdnstAn+nqdu2PAXMU
	 pLcFL069qxbxQSNml1bIVBFxgelPAbhXccVEfZPfxNc9j8Xgsm3GkoA4tCeZWNfX+d4iE
	 JfnNQZztt4C9aRC9pMCSuNdWTNwbYOE8b7WT7EVM4y42/Fh0CjSPV0zEd3zisIU7A+KaS
	 gAUSe3E9FYWT4fGWzu+QEB0NJCR5ImfNrSrNDTy28VyYem36WwjtEsd79B3NKwjovug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793756179;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 Date:Mime-Version:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GAC24OLY0Y1nAdH6NCIJXJvDYqD0c/SMa5E8X0eawBg=;
	b=Z+QVCr0JAqust+agpjOqjXhRRtdI5sOmxHJYqBC5x9uNuIX8r3n3NeOMGcVZmMvHXDIa
	 7yLl0Y2n74PKz5551RC6/voS27my4PqALYn/qKIDnSvh9hc1mnnaG2t7sF9FSWqjII+i3
	 lyZbM3+hMvGWZVmSIFP4YRvRHWRaLE29wbn3cDrQvWsRLz1Bxu/tiasvfFUDuONMue93j
	 Cz4Hnvh8Wot2qpo3R5p85RUU5DQJHTIVQ9ZZjzO/Y70L9EktL7yCB+KEcsTJEKhBI6jnO
	 PEOfpplE37UMcQOH4tufviUBNuQoKzcNT0Lw7fxB1ACebXga1n5ohIqNUv35kY5baYw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=l++6mnWA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793756179;
	bh=GAC24OLY0Y1nAdH6NCIJXJvDYqD0c/SMa5E8X0eawBg=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MNkNH21vYvUmBicgS69UIxmv2nrr3Hz6AMgDhImYk4mjHSiMm9qfjdnZkcD+3mxnu
	 VpB6PwcJRT7rRdvKDy28tRzggkV6FzSx/iREiXDUkYsgirMuUuA2m2Xp4kxWyPz9NK
	 426XVOOP0XG+kC3x4aHWn+u/BYc8zHlTinP6U/7BV+GtgwPjxivvBi3DK0XwdjyVrK
	 9BngZ0zJhXqP9Ocv0ST7JjtB94Yn1ns1vjmhvvMX3Wc55YzolCzADEJO8SIgDfSAcA
	 pwznBsPPrZL0WvYw/ANBsU3CZaAjn09/Im1UrEhy9UvFAJKoAyGnZGXoaFXB1BZoei
	 g4sc0OnyoM5mQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0BAE480C6C;
	Wed,  4 Nov 2026 01:36:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AB7D8784
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 01:36:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9101B80CB9
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 01:36:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4hObm91PUAHo for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Nov 2026 01:36:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C9AC580C3F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::847"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793756177;
 b=baREtlqj5JbCDMfjWnZsgzBULFyZzZD1xjEBT1Rz7QxSgm15E1pK17z6dBEE8a5aEGDr
 CDWb8cSjRBNFoFTxOjVj0myag5vp7Td9i4YwBFTd5tWBMpGZ7OlYh/Nj+LVI0YCv8alsZ
 Qd2aShb1XPiUD/rUjFWll+DEV/RwgJNTr3Ep9DTxuU5+TJNDyiNsaoel9e5wEUI6u7p3y
 dhrkYrRSlHuLjNzRkc/UQ+Web3uUMq+ATuTSZjV4DN1WGZ9PHjgSoJXIjwm61BSBrZOU4
 9Rdag+2KiVQs0icvCaR+LLfAkgiDoO2DuWn0f8j6WMbraeBzoV437SZBWgoGE+xrXLQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793756177;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
 Subject:From:To:Cc:Content-Type;
 bh=GAC24OLY0Y1nAdH6NCIJXJvDYqD0c/SMa5E8X0eawBg=;
 b=GRTIMrkKzQrhp1rCMTM5X4Mi5o4+N9kOmqiEfQnCTl4X2c/MkQLPjEvFJB697kLLo9aZ
 /sAIRflPNQOYy7onEai3LhIIDf6RDXFOSIvz6o6xHfinfZwaFUbZGaZLFIof5BCQ2fChE
 VM8U0zyZdm98yj1q/DQaBcF+cvXKu7nUtExWxJHRkkWl875798EOJRnEoxPSWSpFKncah
 1LDKZjpGeZeT8CvSeE4QQCk+98vafRpgz+R8IjA8gheRwVEK9V+ogeP6pfnP6SCKBHAO9
 m6DXqo54Wds1vgQn+jrAplOeqUSm+D+DsGH4nyYV/ur9jw4IudWTnfMO0hf7LGktsvA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=google.com;
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20260707 header.b=l++6mnWA; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::847"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::847; helo=mail-qt1-x847.google.com;
 envelope-from=3dyzqagskac4xkwkxqevkdsqyyqvo.myw@flex--namangulati.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20260707 header.b=l++6mnWA
Received: from mail-qt1-x847.google.com (mail-qt1-x847.google.com
 [IPv6:2607:f8b0:4864:20::847])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C9AC580C3F
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 01:36:15 +0000 (UTC)
Received: by mail-qt1-x847.google.com with SMTP id
 d75a77b69052e-5338c59f90dso24703401cf.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 03 Nov 2026 17:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793756174; x=1794360974; darn=lists.osuosl.org;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GAC24OLY0Y1nAdH6NCIJXJvDYqD0c/SMa5E8X0eawBg=;
 b=l++6mnWAWVwOtq3wziLIG77F0DdqKSnWgAXS1S9KxS8aYZoY5NwBrXPoITuB0vir7Q
 AUXNWi9CT9qLM9MulAE9Rq1kLR+LbMCgRGx8QxwguBTV4R/eytJ6G+3riyPFzsu9Vri8
 GwSMk2nds9f2I4Pc6G7S5uBgKWPuVw41r43ikijzP/vW5Ek4dRpDkaYpV5KyRK+ltlUV
 ivggM0pbXLI/Xf4pH4yQOBaJFj+MvKrAdFejAvzbHwUmd1syOweyjSKF2/jsNle3paFl
 s+rF1TLzwko8jvdb6miMWAxMCR7lQXk+OyIGXZXQHtB4G92qcxSwUs/7GxeltPR4aDzM
 yiQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793756174; x=1794360974;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GAC24OLY0Y1nAdH6NCIJXJvDYqD0c/SMa5E8X0eawBg=;
 b=jFyEQlSejzhX8eXuWg4ALya6e/9RrJ5Ctd4eJMlzxNJRuEtKwr8UGHWXwsm1IyY2vT
 VVD/xYRAA0KGXV24jZoOazvU51zMcv1ZXpmpIvlBNXn8+WSr4h+mlnBolBsCVc36cJAB
 S8woysWPsiBtBZshzgSumnV0k8mK4K0d3in6zA6DCGoxMYVkCpNeQY2kmE+Oaqgk34T3
 8eBNHOlSiYYMPNQPDT6T9VC9DQhhcIevwYdOE24bsAit+dqwJ+rj+qG7vgWiMuQcXE1e
 UyaQ+iekNCGIPv3uw6ejImwF05CYvAQQAaVeiwPTe7w+xk6DNqVzbeLjuIDGSIk0Ctqh
 Q0UA==
X-Gm-Message-State: APuU4Z8F+NK/35Mp+AvkYOlUCsIqTk1tQb7wQpBO5LZ0uewMURBo+INo
 ICd3vdFDN+GtdessvmtmewE96qmiwCtjPUbjBVZAva73NTMlCCnZ6XJ2mDdNxnNxzuO2ml7Qn0z
 Ldw51XYewavwSQTUVHOOi/Nv+ITLstcPVIsak/2veH/+Wg1VtoFf/A/zhoMpj8q4BisfRsh6KNY
 c4MRYjxHMxkKwiRzbc3AU2NyYi5pBKWn/XTCWDDVbNO/lAcpmqgEWQWJJ4CyB5SFgrEWDHxaEGp
 tmD
X-Received: from qtnm25.prod.google.com ([2002:ac8:4459:0:b0:535:6bd2:134f])
 (user=namangulati job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5d8f:0:b0:535:22c2:f161 with SMTP id
 d75a77b69052e-542b742cdcbmr224703161cf.21.1793756173996; 
 Tue, 03 Nov 2026 17:36:13 -0800 (PST)
Date: Wed,  4 Nov 2026 01:36:06 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
Message-ID: <20261104013606.1527767-1-namangulati@google.com>
Subject: [PATCH iwl-net] idpf: fix Rx payload buffer leak when header buffer
 allocation fails
From: Naman Gulati <namangulati@google.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Naman Gulati <namangulati@google.com>
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

With header split, idpf_rx_update_bufq_desc() allocates the payload
buffer for a buffer ID first and its header buffer second. If the header
buffer allocation fails, it returns -ENOMEM and leaves the new payload
buffer in bufq->buf[buf_id]. idpf_rx_clean_refillq() then stops without
consuming the refill queue entry, and the next NAPI poll retries the
same buffer ID, again starting with the payload buffer.
libeth_rx_alloc() overwrites bufq->buf[buf_id], and the earlier payload
buffer is never returned to its page_pool.

Each such failure leaks one payload buffer. The pool's inflight count
never drops to zero, so when the queues are re-created or the device
goes away, the pool never finishes shutting down and
page_pool_release_retry() keeps warning about a stalled pool shutdown.

This happens when the header buffer pool runs dry while the payload pool
still has pages, for example under memory pressure: a header page holds
several header buffers and only goes back to its pool once the skbs
using all of them have been freed.

Release the payload buffer when the header buffer cannot be allocated,
as ice_alloc_rx_bufs() already does, so that the retry starts from an
empty slot. idpf_rx_page_rel() also clears the slot, so the buffer queue
teardown cannot release the buffer a second time.

Fixes: 90912f9f4f2d ("idpf: convert header split mode to libeth + napi_build_skb()")
Signed-off-by: Naman Gulati <namangulati@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 885df6294ad94..7383d8241ead5 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3745,8 +3745,10 @@ static int idpf_rx_update_bufq_desc(struct idpf_buf_queue *bufq, u32 buf_id,
 	fq.truesize = bufq->hdr_truesize;
 
 	addr = libeth_rx_alloc(&fq, buf_id);
-	if (addr == DMA_MAPPING_ERROR)
+	if (addr == DMA_MAPPING_ERROR) {
+		idpf_rx_page_rel(&bufq->buf[buf_id]);
 		return -ENOMEM;
+	}
 
 	buf_desc->hdr_addr = cpu_to_le64(addr);
 
-- 
2.56.0.398.g882cbad275-goog

