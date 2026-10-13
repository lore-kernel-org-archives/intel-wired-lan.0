Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED8FCA9ED2
	for <intel-wired-lan@archiver.kernel.org>; Tue, 13 Oct 2026 12:12:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BA646809F6;
	Tue, 13 Oct 2026 12:12:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id miDH1z2glEvT; Tue, 13 Oct 2026 12:12:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1FE72809EB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791893565;
	b=LUznJUtcAE3v/LajfFtO9swhfKem56nU9kkp20NaxV1XzGH/z8vblAGlLWC0417FFLmG
	 NEKW0628lqQGG/9jHyBRXd87vkuzuJPBV0k5msSdE5qtJ24FfkbAvwMZlzHsVqxo2r1ES
	 zsepg/AlG0azEweAqLF18b2qHpuZyj9Y2NxxhJ7InjkXrDa3N1R4DrkWNRjOtEMmBMpZC
	 hVl96VU1dFzZZ8Z6cORR5Q3nHzxNIav3ZXqdrIkdPBANi7yTLB50DNRMOjjKdthJtTrT3
	 dBjhHb1b72sDEZkGkvqMaXO0uiZg3UlePe3dusT3uzGRkamH2WiuXARzm33d6J9BaKw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791893565;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ETrKISw+8AK0KtLxNpxC+VOrt9aLiNM1tKj5N66RmxM=;
	b=BCPr656IAVAC2Jxpa4Xc+a7t1FBuV/hvVVhxRBYBp7wQzGogGrwSGGNkGY9ANFMV+vWl
	 FKEWhCAKIeYynggIQiIlPT7WqRkMPLpfzb5L3GMf+djUU7FhirUphGhoPUj6JBFLxewPI
	 Nv/cfu7owMxacPQTw49/5Jg1cLDiIOB5UnGgNeWf2vAPUuc7Q8+CDmqw+eJRQbuMmm2zK
	 GCVa9sZOjJuOBcSy9Kc5m+a9vYfwz2sKDkI6LNxHTAAG8rQWsVbsN1+IWWmX4OdeEboCS
	 AEVeXuMZ2hTRknq4sADawlyqChICr02HpwhKGYBpVrhJ8ZlH1fP6FLobgkdHy+5LRyA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791893565;
	bh=ETrKISw+8AK0KtLxNpxC+VOrt9aLiNM1tKj5N66RmxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PB58itHtdMe2CpZrBlGqO8vKBOme5Z2I9ogXSft968Ts1TqwyFs95G6eOfDXyyVeS
	 UDP4uydjhT2af00R5PKUrii2fNGTMBQt4+K97eMSGSrKuJ53cR8ELIbDB9F3GajjHA
	 +VbyRrMyNH7cruU/g1hImjWCZn1y44vv2q0ePrheqDFwF+XR/N+VWJOmj7/Nj5gj/l
	 rX8RU3RAJf/9yZ5yfP292CKjFzBoKcB9w3tIdBBHg94w/Sk2iLABEE5nr93H2Etk0m
	 aNQ6AaljR2vwt2ZWNVM+wxkTsBUi41sJDE62es53Pxcuyk14hTnkyc8aJa5jZ1Gfbq
	 Zio57X/u8Vy7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1FE72809EB;
	Tue, 13 Oct 2026 12:12:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 46A032E0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 12:12:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 27DB1403FF
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 12:12:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 407oTJ7VzKV3 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 13 Oct 2026 12:12:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6D896403F6
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791893562;
 b=hEYzuBBBXqhG5FV8vtPVvne2wqhiTU+WbwlBZ02gD9M/VeceO6cjQd9O+h2kkHafF/c8
 34A/8Q86qRILFnI0QfOm5wc2INi+SMLGVWyR3OT7zO5kFMbHLUC2JESfCRc/3rxR/zvqA
 /+vSg0QX04x1pC23XPnYTWarIEOwxSVOLIGy4OJD1JdJuTiz1+igQCaSKW/UP8QW07knY
 61UJjwXgFN5WjEjnooJUNyIC0wFJ7jeOUlvkrFkHznWJw6GBEVYn6T1Cf/nZiKGa2P1fU
 Bt5g3jpi8Q2IHUhgXIt45omL/p9gqWGHIkBUP/RowZSi1PTHD122xmK2jhPK74Q1sBQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791893562;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=ETrKISw+8AK0KtLxNpxC+VOrt9aLiNM1tKj5N66RmxM=;
 b=kl/IOrdL5KoMcmy1l9BgAHg0gLm78sHzwttFrjdDBPmugEQ5tchXdpTOE8JCXjFSCGrF
 X49QtMiMlKhWPdWc8U4fWDh+R83h5O0+19pOdeeP4qf4LEGNn2V3urPyRxY6ISJBCJ8a7
 uX1lyraImf9jzy7QiA3E1mgpFZfWx9eui6mozu76cE5fAicIkqwZ5vWb12Fc10HLsBx2w
 8HEJMC7peK0BkdvzJZwWgFysKFU5miN86bK7aXPFjNrF+yfaKYUxO+qGwVbNgtNZLGi/5
 gKPDQy2pftE1WytA/X9dIGNSaeEG/u0/qqIG2MKTOrdH1/Q55uFJMvnDc4n+pQ22RqQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=dRwqNPgm; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com;
 envelope-from=luckilystar08@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=dRwqNPgm
Received: from mail-dy1-x1335.google.com (mail-dy1-x1335.google.com
 [IPv6:2607:f8b0:4864:20::1335])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6D896403F6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 12:12:42 +0000 (UTC)
Received: by mail-dy1-x1335.google.com with SMTP id
 5a478bee46e88-33fb4680717so316183eec.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 05:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791893561; x=1792498361; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ETrKISw+8AK0KtLxNpxC+VOrt9aLiNM1tKj5N66RmxM=;
 b=dRwqNPgmMFPSRGGrwBr1l69h8fodKM3ye5A4aBwEte9/Edh/Udjql/vMkzOdrfRo+X
 DGTZrXkCQM6iF7WNxNo/guKK3JdBVf3FM2XBKb2GRpoRx+T6kdN3s8hDbGtyPj9KNlj9
 qI90rP9knG3kJN3Oz5BmuKdbIjJmzxr9ZnpG+yOR2aGKndd8zKStezDl+DFZiIHs8EYp
 2POF50B8PhisMVoMTdq9kFqnq2ttdn80EjHGGNQ9VbZ+INLflWr3jMloX21hZ7FxqM2D
 Q10QrTLR0fWfoNimCx3IqX9C+P27dWwdgyjlE4c4b4b+5l/uM9M9ouxP0CUP4NkIiYmJ
 XNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791893561; x=1792498361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ETrKISw+8AK0KtLxNpxC+VOrt9aLiNM1tKj5N66RmxM=;
 b=NuWWT8MU9bpGg3hm8K9Dq8tGZVO+A8aw6RiznmrAZXd1/av19tko5TNP8boBGqK7XR
 dyisCbckav0XAgqNNhtDBkTIp7TyVa7IuOaay2HB2/O1X4o+dkd3u4z0AygdS4htS3hj
 lZYDiVF+fSMcpostrVa+KFHvbh2ZFVG5ojNjZ4icxY/PGSoBzvhvDbAafHHepBTRQ9AX
 AVcpj+sojd/4De/4mjYPtUuMJ+R0XU2FhOrS9FIT14Tz4jzCwfxV6fiaSuKXvZOE4cJq
 X62xCdQOabQpVwG12yfMTzr46AER46FQ+qXIyAGqPWu2BqBuP05gNfYFsRELLaN7Hgly
 O5dA==
X-Gm-Message-State: AFq9FYL7hN5hufoVFbRIqKask3fMpRxBVOi0llyOM5NoRvp+eJw4NZ6o
 vOloYI57T7QdDClD2TEypOu14ZsescE0HnecoN2ZobO8X8274hLtCfy/XAal50qpsv0zdA==
X-Gm-Gg: AYBFou3CYQ7p9RdVNaglCMCw9rNbHIY4GnkzdTsVK56s79I/WqDZSuIl8+gQo1Xv79K
 IuU2EcdoZxalkxHpqanlyPwMVpyfu4ZFT9afA6xoBuJHPwLwOp3TkXoex6u3Lgy+P2+DWfGmt/Q
 lwcbF+atb+gYkV4Ob0lmVrWUa1LcU0zY5cdIv9CIfx+mfPT4JyBGJck7qKutJMMAW24tNRZ7UIe
 5caBNxQsqwN7mglZPVZlMT/tvr18CLUKTJV5J3gWgbaxnBagKRnXZxcrn0C68IZHhRjR2g533zI
 6N1YtRht5uSElu0mb3oSkR16qCitFVohgpnR45uhE7iwGbniUbvMYrqvcVj6bAsv42dLLCrqFDk
 JPLKWG8YrRTmaFnBOEFXXSwDLJUXzpdSeb6FOw8Mo+kfh5OmKrRysh91TuL1HRhFgPromjcdYOX
 ajYU3KQuIEO1jiZCpmKByNOd3+XzYdm2Ez1qUCZV8lR2R5iPYGXIdtD2Ff7xJ6dsrGMahZNO3qv
 Zja/3kinWNnX5fAsr4AaTZWNcDVZv0kgcmogjgFfcMV/BV9zIUJUYYr8pU64lWGPZN7Y2ccCOOh
 +Q==
X-Received: by 2002:a05:7300:e9c5:10b0:359:f28:412d with SMTP id
 5a478bee46e88-3590f28533cmr13587521eec.36.1791893561153; 
 Tue, 13 Oct 2026 05:12:41 -0700 (PDT)
Received: from C9P9279WY4.bytedance.net
 (34.224.142.34.bc.googleusercontent.com. [34.142.224.34])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca7133asm52304765eec.14.2026.10.13.05.12.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Oct 2026 05:12:40 -0700 (PDT)
From: Tian Xun Ng <luckilystar08@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Emil Tantilov <emil.s.tantilov@intel.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 aleksander.lobakin@intel.com, aleksandr.loktionov@intel.com,
 decot@google.com, milena.olech@intel.com, joshua.a.hay@intel.com,
 alan.brady@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Tian Xun Ng <tianxun.ng@bytedance.com>
Subject: [PATCH iwl-net v5 1/3] idpf: ignore Tx timestamp replies once removal
 has started
Date: Tue, 13 Oct 2026 20:12:22 +0800
Message-ID: <20261013121224.84482-2-luckilystar08@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261013121224.84482-1-luckilystar08@gmail.com>
References: <20261013121224.84482-1-luckilystar08@gmail.com>
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

From: Tian Xun Ng <tianxun.ng@bytedance.com>

On remove, idpf_vc_core_deinit() keeps the virtchnl transaction manager
up until the vports have been torn down, so mbx_task keeps processing
replies while idpf_ptp_release() frees the Tx timestamp trackers. An
async VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP reply handled in that window
reaches idpf_ptp_get_tx_tstamp_async_handler(), which reads
vport->tx_tstamp_caps and takes its lock after
idpf_ptp_release_vport_tstamp() may already have freed it.

Once IDPF_REMOVE_IN_PROG is set, wait for a mailbox task that may be
running a callback before releasing anything, and make the Tx timestamp
callback return when the bit is set. Matched replies to synchronous
transactions are not affected, so the vport teardown still receives
them; mbx_task is requeued straight away for that.

The last patch of this series sets IDPF_REMOVE_IN_PROG on shutdown too,
which would otherwise expose shutdown to the same window.

Fixes: 1a49cf814fe1 ("idpf: add Tx timestamp flows")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Tian Xun Ng <tianxun.ng@bytedance.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c     | 12 +++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c |  3 ++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 1caf52706..d0db60647 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3204,8 +3204,18 @@ void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 
 	/* Avoid transaction timeouts when called during reset */
 	remove_in_prog = test_bit(IDPF_REMOVE_IN_PROG, adapter->flags);
-	if (!remove_in_prog)
+	if (!remove_in_prog) {
 		libie_ctlq_xn_shutdown(adapter->xnm);
+	} else {
+		/* The transaction manager stays up for the teardown below, so
+		 * async replies can still arrive. Wait for a mailbox task that
+		 * may be running an async callback; callbacks that run later
+		 * see IDPF_REMOVE_IN_PROG and leave the state released below
+		 * alone.
+		 */
+		cancel_delayed_work_sync(&adapter->mbx_task);
+		queue_delayed_work(adapter->mbx_wq, &adapter->mbx_task, 0);
+	}
 
 	idpf_ptp_release(adapter);
 	idpf_deinit_task(adapter);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
index 14dba40a9..1422b30d0 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
@@ -550,7 +550,8 @@ idpf_ptp_get_tx_tstamp_async_handler(void *ctx, struct kvec *mem, int status)
 	u16 num_latches;
 	u32 vport_id;
 
-	if (status)
+	/* The Tx timestamp trackers are released on remove and shutdown */
+	if (status || test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
 		return;
 
 	recv_tx_tstamp_msg = mem->iov_base;
-- 
2.50.1 (Apple Git-155)

