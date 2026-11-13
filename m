Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42322606A336
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Nov 2026 23:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=xiGVFkb1;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BFmsfKiM
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F1DA60DED;
	Fri, 13 Nov 2026 23:28:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZqQyIpawQD26; Fri, 13 Nov 2026 23:28:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8CA7F60DA5
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794612507;
	b=WlL62ting8Ga2jseh3GYJSwyn7M1wysgRnK8yZPEPUw/5XdwtdBOqMr437DCtdIsMU7Q
	 AWUswP6KfFEJ79enx9ofiil38tRTyrQ8ESDCdKrt8UZlVZXG56wCJ49rjwUnVeHdILRFx
	 l4zpLOx8/SEk5t8+D4fv8/D94mmxpXZQO4KbMQwR5gNdDUMfHr6e3Eea+hWzdMuwwTjEy
	 W8RR7tIoZwmGNC1oyP0Hd2xJrghA/Ckps+00fvX3M1jg4kiqCUqhpoXjnczTuYpMty261
	 Vpgqqz9t8fbiZ8u5Va/WiJWyup7AMM38HxOL5HFETgSQT64gF7kcuVXsx3rxczvc59A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794612507;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=MP44A2UXd/wSnusowTnecNPA/CsL40YpZ+6cXn2Yq5o=;
	b=lWNhKWdr2zwANKYbm/KGrZdIgV9EoZHBH2VvQMG18+ZD+lt1NxgnFaN7lPourZiIFH60
	 NqR2s3wliIQM6GaUUJ9UdqFMsn/QocOum/zdWXu60QHTAcsq56ZPV/z0jjcfZXBFslMZF
	 Ti6HOSrstdkC6SJmMjC6rAU5HR1iKPbUMXsNJTBOHDBxJkzamITJD9rE9OvsdYimAdqAI
	 wOKTtFDMKzeAnf/vsymzg+oxIVXnchHrYMER0xit8IM8Iccv/H0BNfooMnm8OspbJSrIr
	 2ks+aFTb61Elb6wpaMY/2WEStHfzdz/D4zHLYBF9UlrAgKWFt4tY3L3sFHRtFA7NyEw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BFmsfKiM;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794612507;
	bh=MP44A2UXd/wSnusowTnecNPA/CsL40YpZ+6cXn2Yq5o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xiGVFkb1L+ItijOoO3k4ZpNWEanzCC3h+Dl/303HuwLmgfxlCqxAVsiLA4qxww1R7
	 1xOa4uYH1htMkWf16EWw1Rgbz6UO+xhofaWvZgMr9xvZIuk+cwusWLMw4x/YMIy91y
	 F2iaJyiCENW24Rsa7Y8YH+NzghdzQoJQmukhaKFF13AYJxWnboLARbpKmCd5aEPctq
	 LxtYUmBoE4UZmkyAbC/3a+UFmtbeK+b073/24yRShk4PqOmb8n/rsa9fCuECCUt5qj
	 LCaM3L3o434OnkSphjs+MzbjBamAEm3MOaTm2PZ2bg3VwMViosRCWOQoVMcou4Su6u
	 LISrRmxWDbIYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8CA7F60DA5;
	Fri, 13 Nov 2026 23:28:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 98CBC2FB
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 23:28:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 767FB60DA5
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 23:28:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ONujmatZK1z8 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Nov 2026 23:28:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C265260DA3
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=BFmsfKiM
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C265260DA3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 23:28:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 032ED402D7;
 Fri, 13 Nov 2026 23:28:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BCF1F000C4;
 Fri, 13 Nov 2026 23:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794612503;
 bh=MP44A2UXd/wSnusowTnecNPA/CsL40YpZ+6cXn2Yq5o=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=BFmsfKiMNSSguxngG5T8TrvzhBZikBS8lfNfuEiBlybN5vaxLk351fbzf17HP53qs
 KNUCvlZMeITfQazmYnj5eztC02HQcH9cnSPy0tTc7P3gvsNrNyd+9EWzuoBQR6F7wP
 qOH9TJmA3PVAhoimmwyWEDtxiDgat5iyUjNjRct/FDqggt18zC6NYyBvmiGqljqtQp
 QCSyGIE4sQ50KkB1Aggc+ity1nl7SdzXHTIVUTLYeafC9xkDtFahIjvAbVbJFtXDSA
 DvwsuK9aIJE+5t5x2PZ1DQw8KG+ez35Km2Fcn8vT+g6qFT8Tis0pg3m/c6XwCy7JFk
 ILuB/iQ+Rm2/g==
Date: Fri, 13 Nov 2026 15:28:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ding Meng <meng.ding@siemens.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Tony
 Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, florian.bezdeka@siemens.com,
 jan.kiszka@siemens.com, wq.wang@siemens.com, p@1g4.org,
 gerhard@engleder-embedded.com, Jason Xing <kerneljasonxing@gmail.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri
 Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Ihor
 Solodrai <ihor.solodrai@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH] net: mark skb NAPI IDs independently of busy polling
Message-ID: <20261113152821.47e9d219@kernel.org>
In-Reply-To: <4pqljild2fp6eotiicvwbwu2wfw66fzd4qamwt6utirdjxlaok@iiu2f3k7azrp>
References: <20261105071706.7043-1-meng.ding@siemens.com>
 <20261110134539.12d860ef@kernel.org>
 <4pqljild2fp6eotiicvwbwu2wfw66fzd4qamwt6utirdjxlaok@iiu2f3k7azrp>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 12 Nov 2026 12:33:57 +0800 Ding Meng wrote:
> On Tue, Nov 10, 2026 at 01:45:39PM -0800, Jakub Kicinski wrote:
> > On Thu,  5 Nov 2026 15:16:08 +0800 Ding Meng wrote:  
> > > +  interface index will be returned only if CONFIG_SKB_MARK_NAPI_ID is
> > > +  enabled and the driver is using NAPI. This hidden configuration is
> > > +  selected automatically by busy-poll support and by drivers that need
> > > +  skb NAPI IDs to resolve deferred hardware timestamps. Drivers that
> > > +  use deferred timestamp conversion must select it so the networking
> > > +  stack can find the device and call its timestamp callback even when
> > > +  busy polling is disabled. The struct contains also two other fields,
> > > +  but they are reserved and undefined.  
> > 
> > Just take napi_id from under CONFIG_NET_RX_BUSY_POLL instead of
> > complicating everyone's lives.
> > -- 
> > pw-bot: cr  
> 
> When BUSY_POLL is n under PREEMPT_RT && NETCONSOLE, igc fails to get RX
> hardware timestamps.
> 
> Then, drivers that use deferred timestamp conversion (e.g. igc, engleder) must
> specify a busy poll dependency if they want to obtain the original net
> device upon consuming the skb. However, this dependency is far from
> obvious, and annotating it for future features of this kind will be very
> hard to discover.
> 
> Configuring the skb napi ID separately
> from busy poll seems cleaner and more reasonable.

"take from under" == make it always compiled in
