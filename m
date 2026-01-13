Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE1A5D30CC1
	for <intel-wired-lan@archiver.kernel.org>; Tue, 13 Jan 2026 20:23:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5684380DB2;
	Tue, 13 Jan 2026 20:23:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BnGjAS__m_zQ; Tue, 13 Jan 2026 20:23:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B949780DD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1768335780;
	bh=SEW+k25GxtoGpssMWcEBFy4Kv0XQW2KgqZU+s4uI3s0=;
	h=To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=pBBcLbhwzLKHisOoFqTbe6OB+gfBUGixDMQ8xM3kBadVVE7VrpiHypuPm77A20Lsp
	 iziMgSNS7Fm861jtd4H44lHB7XirsRmSt1sfZ+cbICnxdpBdPQ6vQ9k2AdqKAsvwAW
	 lHzpKwnom3gTkniZaYK9CpBM9r4ykaktY2F+HEdo0zaRfe9e6ja7UuTu3rka+Fa7im
	 FSM2ctZk6IevydCAV3D0OhBCc0StuzXq6rqa4Eh5UlNvBFVmEnBYufGjOSRdth1+pV
	 4f0XvOpvUu1LRbF9V7yxF4Yn7bhLQrBP0gwvI9LV69jtY6PCzy67yoMSQX+wAG3RtR
	 3ADokHKXCdc4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B949780DD0;
	Tue, 13 Jan 2026 20:23:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 146EE231
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Jan 2026 20:23:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 059DD402E8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Jan 2026 20:23:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DY2ubMYtf71B for <intel-wired-lan@lists.osuosl.org>;
 Tue, 13 Jan 2026 20:22:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=jakub@cloudflare.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1979C4022B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1979C4022B
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1979C4022B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Jan 2026 20:22:58 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-64b5ed53d0aso11804389a12.3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Jan 2026 12:22:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768335777; x=1768940577;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SEW+k25GxtoGpssMWcEBFy4Kv0XQW2KgqZU+s4uI3s0=;
 b=vNP6krhPQu3j8m4gbik5KRO8myZEfRXkoUV0zu53k17PScAwXl3RtZkWYiVJwk88Yd
 37oeTjeFLUx7CT/ufgp8CSNduuiq335qJ4UbZj+AMpv63BjhAK7fzwVWWcc/ZBjU5uV3
 AXQf5U1cHX2B6tYonRAC2VxywMg8x5+LdNjKpu3Dj6WcaaD5Mi+sybOY5/fP3IK14bRw
 FcX8/BmEE24+geMnAvEaK8ILdOY+pCVv06mLkRJ8uofEoyBCPy+hEo5+ikeUZb0iS4CY
 T/vVo1HYbp8u2JnXFyaHZOmEzp3GHo0lBy95YGwk3ToX7tDTsN1yWdntNPsuFhMBZ/47
 uwKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAwaVoFDx3QS5tqi3sbiVLywA4U6HZePIGXZvf/KTTtwu5wmjM0xctz0djIBWaCwiDfR7f6nykjK8FgtsA6WQ=@lists.osuosl.org
X-Gm-Message-State: AOJu0YzpcYkhNp0dRyd9Z3aFx34bxkxz/ZfPVpVqFbCgX1TlqISRU2sP
 V1oq2hV84ks9y6V1hSR9wOnc+IaY5H6h0Xgm4adzF5QK+Re7ms2cUJ0V/JTpu0eA/aA=
X-Gm-Gg: AY/fxX7ZbGMS+tQFAKc3lFmmdRU7PT3Lk/5ww2l5MhNtQrX1dNeATpDX+jebQiu+VeZ
 Ys3+sVBAXdfNdrk82oFSroZGVYQEqlYxYZuk/pTgKB5ds+rlJSlcWbtdjfgPrzegEHHqIk23pSG
 Qt2oTwrVrVo1AOZ1KsRVbMK64YYlJA/z3Slyjt/rjfSFSqRqxj++qFK8sm80Q9o/SDdfxMl1NrI
 ocAF3cuAX1+cuFQ85+nxoVdDbICJ8KDpRoaAZ65IfWNHzWrFac1wJo8E7A3J6LuraVyO928N8zP
 ufJKryUhgxHQ+AH2WplZvFvWcQNmzQeSULoIdkFS4wqglxEsErNBernIK79Gm6vbRuIGDvA0wpg
 CqIjS6qyLshz0IY2Se06hN2Wmo8i8GwwQpD19yyBXMA7GH4KNeI80CJ+MBusFaSYFwAF5luxnyO
 9IVBw=
X-Received: by 2002:a05:6402:144b:b0:64b:7885:c971 with SMTP id
 4fb4d7f45d1cf-653ec44348emr170193a12.20.1768335776737; 
 Tue, 13 Jan 2026 12:22:56 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2969::420:33])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507bf661fesm22541348a12.25.2026.01.13.12.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 12:22:56 -0800 (PST)
To: Jesper Dangaard Brouer <hawk@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,  Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Simon Horman <horms@kernel.org>,  Michael
 Chan <michael.chan@broadcom.com>,  Pavan Chebbi
 <pavan.chebbi@broadcom.com>,  Andrew Lunn <andrew+netdev@lunn.ch>,  Tony
 Nguyen <anthony.l.nguyen@intel.com>,  Przemek Kitszel
 <przemyslaw.kitszel@intel.com>,  Saeed Mahameed <saeedm@nvidia.com>,  Leon
 Romanovsky <leon@kernel.org>,  Tariq Toukan <tariqt@nvidia.com>,  Mark
 Bloch <mbloch@nvidia.com>,  Alexei Starovoitov <ast@kernel.org>,  Daniel
 Borkmann <daniel@iogearbox.net>,  John Fastabend
 <john.fastabend@gmail.com>,  Stanislav Fomichev <sdf@fomichev.me>,
 intel-wired-lan@lists.osuosl.org,  bpf@vger.kernel.org,
 kernel-team@cloudflare.com,  Jesse Brandeburg
 <jbrandeburg@cloudflare.com>,  Willem Ferguson <wferguson@cloudflare.com>,
 Arthur Fabre <arthur@arthurfabre.com>
In-Reply-To: <bd29d196-5854-4a0c-a78c-e4869a59b91f@kernel.org> (Jesper
 Dangaard Brouer's message of "Tue, 13 Jan 2026 19:52:53 +0100")
References: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
 <20260112190856.3ff91f8d@kernel.org>
 <36deb505-1c82-4339-bb44-f72f9eacb0ac@redhat.com>
 <bd29d196-5854-4a0c-a78c-e4869a59b91f@kernel.org>
Date: Tue, 13 Jan 2026 21:22:55 +0100
Message-ID: <87wm1luusg.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1768335777; x=1768940577;
 darn=lists.osuosl.org; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=SEW+k25GxtoGpssMWcEBFy4Kv0XQW2KgqZU+s4uI3s0=;
 b=AkZtrZt1ogM70ecQrSO3f5oUhPuUBr/s1J6KO1MFKpJtu0dEc5C2bsyvj4Y6AEWCqa
 LB19fu0yvGf/nWdr2K+a/Cuk87eUmzFZzu5IM3koV52RtXL95FuUOUZgDbHGi1mR+6Or
 ISjIKYKM4WXHpj7OGpRPtKyoOo2i/Z/06cZuUuWO+NeYD98tAbRHpGLWlMd13z9YxYST
 OEBt0aLu2SehEyA4H1YvTYo3+H9MJr+RhHI1XSKtJY7O+RQcBGzzDdYy9KvJkblUD51K
 kaNzZ98DI0Blp5ZryxAm8fbtSQFWptWsCaaEpeTWCsKpZ+eCzRGl+osiUO2Kyn23ggNs
 1spg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=cloudflare.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=cloudflare.com header.i=@cloudflare.com
 header.a=rsa-sha256 header.s=google09082023 header.b=AkZtrZt1
Subject: Re: [Intel-wired-lan] [PATCH net-next 00/10] Call skb_metadata_set
 when skb->data points past metadata
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
From: Jakub Sitnicki via Intel-wired-lan <intel-wired-lan@osuosl.org>
Reply-To: Jakub Sitnicki <jakub@cloudflare.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, Jan 13, 2026 at 07:52 PM +01, Jesper Dangaard Brouer wrote:
> *BUT* this patchset isn't doing that. To me it looks like a cleanup
> patchset that simply makes it consistent when skb_metadata_set() called.
> Selling it as a pre-requirement for doing copy later seems fishy.
 
Fair point on the framing. The interface cleanup is useful on its own -
I should have presented it that way rather than tying it to future work.

> Instead of blindly copying XDP data_meta area into a single SKB
> extension.  What if we make it the responsibility of the TC-ingress BPF-
> hook to understand the data_meta format and via (kfunc) helpers
> transfer/create the SKB extension that it deems relevant.
> Would this be an acceptable approach that makes it easier to propagate
> metadata deeper in netstack?

I think you and Jakub are actually proposing the same thing.
 
If we can access a buffer tied to an skb extension from BPF, this could
act as skb-local storage and solves the problem (with some operational
overhead to set up TC on ingress).
 
I'd also like to get Alexei's take on this. We had a discussion before
about not wanting to maintain two different storage areas for skb
metadata.
 
That was one of two reasons why we abandoned Arthur's patches and why I
tried to make the existing headroom-backed metadata area work.
 
But perhaps I misunderstood the earlier discussion. Alexei's point may
have been that we don't want another *headroom-backed* metadata area
accessible from XDP, because we already have that.
 
Looks like we have two options on the table:
 
Option A) Headroom-backed metadata
  - Use existing skb metadata area
  - Patch skb_push/pull call sites to preserve it
 
Option B) Extension-backed metadata
  - Store metadata in skb extension from BPF
  - TC BPF copies/extracts what it needs from headroom-metadata
 
Or is there an Option C I'm missing?

Thanks,
-jkbs
