Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DE9606A32C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Nov 2026 09:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=RbfGmGq4;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=cOYBKJqb
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9615D80CD8;
	Wed, 25 Nov 2026 09:00:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QehnKCL_ny46; Wed, 25 Nov 2026 09:00:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CD74480D81
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795597210;
	b=M3NEamfi8bs0WizayeIqVO9AJ7uJXoXvAkIW1C8x7u2Sr0cdL77XRguakI7kDN9VNC4i
	 gM1HUPDPJhKU0kjWUx8JHzUgl/jfR07uj01d0CEub/sxZlrYCGbs+zumNe+FdgtnLyXFp
	 xa/UXDHN5Hgmz4O4DohtyoPxRu7/a2vcY6m8x/+PMJ9obPqw9s6M+Dt6J3PEQiIL+X1+q
	 RAgBaeMGchPZaWUtyRhMcqIWlbE1lzR9iyADHj8n2ZOvruxhaptKIziZ1qxo5mLnQTEt9
	 72y753NKBf2VPFBcAvOu6bqj3+dFdGmG/Au6vD+gAlf7uDCEu/lAPnTZGDylCPYxTeg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795597210;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wCuJhhLEoHgkC07eMz8DzYO5TWgSi6mxnzjUookJyTY=;
	b=a3VihXYZxXMjeazRRpjohvgSFi9pRXQIBGaj9TA46MFSddIwYawKwc01fKBjE04iHeW4
	 cVxI+6QbN4YQEmmdCKn6VnisINjXDkXkAVG6Bqr/Smy4wEWp0bXEtfx7F24oWJlDHuTJL
	 hmzHFtROFA3IZdiAi0MVQnrrvqDoSQUld16f65NjcXNvIB0Qzd+kKM9JQGwXgnwRQUTw3
	 Rz4Aw0XhtimFcdD5StVOcAe8bIojlGfYnjPTWnYYdO0LK/R3vH1HPKPX++M0gb8M8Z3V+
	 vkjqB65dbq8IhMI4POczf8SzpYRwyIJroVHcQxDiauBcpdXglW9VgQug1KHY00EICIw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795597210;
	bh=wCuJhhLEoHgkC07eMz8DzYO5TWgSi6mxnzjUookJyTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RbfGmGq4DNuUnAAYGg7FntP8jVHpuwpcdVZWOii2bWiT25p4wTZSaUciJTcmxlMNW
	 ILcgJ1gkhocHBy5AavVmT84Mk88Q6bCW147tVrRmYa6yrJ6fOI0LZ4LzycWhYnzyto
	 Yrj+6HsIdZfgf35VlGcaX9AElFUKr6ZrHug4qDcDjhmRV7X4mQJhB3nMI6oVsH3ykq
	 kGbg5vcjpUu46nbzC9SJxOF4eiEMhoTLSPMrp7wUu3BuvaKomgXtfrMj+LXNBLUQHl
	 ThigOrp/j1YxiHkxafuS+jHUSmtDF+b4OknvS5ETdjHPcBnr9pQBM6fdJHi/xRHc15
	 LseJ4ZGUkTNsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD74480D81;
	Wed, 25 Nov 2026 09:00:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B7C12F5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 09:00:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F229140122
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 09:00:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pfTYVHHL5qvU for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Nov 2026 09:00:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BCB9240064
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::629"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=tianyi@cloudflare.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=cloudflare.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=cloudflare.com header.i=@cloudflare.com
 header.a=rsa-sha256 header.s=google09082023 header.b=cOYBKJqb
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BCB9240064
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 09:00:07 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c50a4a2132cso804516866b.3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 01:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1795597205; x=1796202005;
 darn=lists.osuosl.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wCuJhhLEoHgkC07eMz8DzYO5TWgSi6mxnzjUookJyTY=;
 b=cOYBKJqbWjjHpJgR5JIyVf1t1mWui68SXPeUdz5x65aOUHFkg4SrM9P+C12S+gUnGt
 19UBEeZOvQ1Ic7OAmYxjszUfUz5vo6wXDG9Qxi/RzNhrwvKM2+38CzRglxpXfxsEqiKc
 uO+sYfNpq1dMHJqpPAF4R7ZYuHfEs8i4qlisXfLz2Y/6u72kkEfB6fPmPCOj7Gl0P/ZJ
 y7mSGv31Qsmk2rreKUPcR2hapCCRoZ8FjKMtnaw7Xv2oJZA06EmB4hntYp9pe8ytp1ei
 3knZmyH8sfvP6CDmghzh7eiO5O5GMwaFn6zjMMri8moLVGSRWIaN+PPakPffIZmcKTXb
 NX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795597205; x=1796202005;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wCuJhhLEoHgkC07eMz8DzYO5TWgSi6mxnzjUookJyTY=;
 b=uNrN/cGxdS0K6aOQ/hXd+vYoEBjSXz/bveYF1neCkUCzJ4DHOvOS7+D2y+/2GiAKdy
 R6fJ5xc/RImINA8lYglVuEt7RnSmY1RPoTf0wEx0ZXbExPxx3dvKWyWcGrlHmQaknWQv
 CxEj8T8IXL/T9Gv4r9MNHGGLixVfVX6Qi+ejI4CQaWdF6NbxlwuiCvI2XWDGUROvfYyj
 ZU5gcbM2BU1DSNWog/c7gFTpen75uyoPBsMLDu8UIptDMipIq+GjMsMAKcPHH98f1JV0
 ughk2EYVsTBb+Hb9e4Zrfjod3WU3OrLA1AnKDoLMYZ0qtPh5MbpaLULjCVjNlNJDhpAk
 SFgA==
X-Forwarded-Encrypted: i=1;
 AL+hErHbRlD3XxnaJReOHUWEJxGGrOztWzcxE1SZ0/qDh6yr4QhrkCrXIcaL1jM4FJnlORWfmYrk3R6zSq58TUTDO4w=@lists.osuosl.org
X-Gm-Message-State: APuU4Z/XoR6vG8uc8jYHypnD72xnMmjDgCHjEuzogBdaRurYXZCI05LE
 Lu3emEFi3vXouOz5xzQYaFbeleSGejuxOtOhlaO/ivKfUICfdKp8dA29uY3is+TOsNw=
X-Gm-Gg: AZFdTZfmLj+xRn4/ZNh5fkB9RcSi/9+sTfiXPp3PKcXGqcbg9yTb19J/wXQmrd6KIBU
 awbqbxQLZ0OS07FqwMdBodQfFNCNznLFhfD5mMUHGY20zz+fpfq6uAsKLMHEyn4dTGiBDbI/qWC
 NS3wvivXJMrfCzy5mJ+LaRkLDMoBtY0gqr5z6n57iJzKlC2HxdtFxbsHQoNVtSG7L4mgQPVpifp
 pEeY3+qrb4jjHNaNpLr0+kr8WsA4JVJubwwrAotl7vV/FOqhL6dy8reuzGhDWTDS5clEtWFtKw1
 ZcoaEcIVYlPnvKIRh+vbaXJqIxvMq/xe1W+gpbNN2EPXd9Qhn5JT+d1GStjgVUo7oqG5VAXOaxt
 ADquhAPDyAuMB3nBs4ciQsxa0Ln1/wHJ5fncndlF3XGvhksi+iEuH7wSqgxAatFDXBkXeXCElV6
 LbYihi2W9/W7X01ysnbKA9SIva01NUqe2NBXvVkxhhrRiDu6MoFQ+izGUeACX+qMxNF7lb1dw+B
 /IDyqs+sLQDqbBbIwFEugolP2O+UCcbBYfPQ1diQb66R8z/RCLJDOoPjXWtpe3omjymXfpqXPro
 BEEWzm97d5MgVPfehbZaMj9mGXUOTF0im0hy3p8yk+vqgSdcvEZtkBlgqFiIdEI4IIjznCS+qyv
 dPNQ=
X-Received: by 2002:a17:907:ea8e:b0:c49:a235:8e0c with SMTP id
 a640c23a62f3a-c513aadb22dmr1360811566b.22.1795597204487; 
 Wed, 25 Nov 2026 01:00:04 -0800 (PST)
Received: from L9JK9NPFH9 ([104.28.20.56]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513b01e242sm591351166b.82.2026.11.25.01.00.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Nov 2026 01:00:04 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, paul.greenwalt@intel.com, alice.michael@intel.com,
 eric.joyner@intel.com, jbrandeb@kernel.org, lorenzo@kernel.org,
 alexander.duyck@gmail.com, maciej.fijalkowski@intel.com,
 bpf@vger.kernel.org, kernel-team@cloudflare.com, tianyi.gao@linux.dev
Subject: Re: [PATCH net] ice: do not report CHECKSUM_COMPLETE when an XDP
 program is attached
Date: Wed, 25 Nov 2026 09:00:01 +0000
Message-ID: <20261125090001.60782-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <179557068810.3135.17964087549504688357@kernel.org>
References: <20261121012402.84848-1-tianyi@cloudflare.com>
 <179557068810.3135.17964087549504688357@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> [Severity: Medium]
[...]
> Would CHECKSUM_NONE be a safer fallback here until the pending XDP
> checksum hint series land? If not, could the commit message describe
> this trade-off?

Yes, the inner checksum is then not checked, as on E810, on mlx5 with
XDP, and on E830 before v6.15. CHECKSUM_NONE would make the stack check
every packet in software, also the ones XDP did not change.

The discussion in [3] concluded that CHECKSUM_UNNECESSARY only is the
safe option with XDP for now, and that the decap case is a known
problem. v2 will note this in the commit message.

> [Severity: Low]
> Should this use the per-poll snapshot instead of reading ring->xdp_prog
> a second time? The program that actually ran comes from:
[...]

v2 will drop the per-packet read and set ICE_RX_FLAGS_RING_GCS in
ice_vsi_cfg_rxq() instead, as Alexander suggested [4].

[3] https://lore.kernel.org/all/20260721183256.6f49d6e1@kernel.org/
[4] https://lore.kernel.org/all/CAKgT0UeNyyXKARjKR4nVVxNe3UB16WuXqxSz0cf4ZvCdb9A4_Q@mail.gmail.com/

Thanks,
Tianyi

pw-bot: cr
