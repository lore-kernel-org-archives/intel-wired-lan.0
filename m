Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C653F606A890
	for <intel-wired-lan@archiver.kernel.org>; Mon, 16 Nov 2026 22:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=R7o0AdRq;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=md2D4WPO
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9D205405CB;
	Mon, 16 Nov 2026 22:27:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HRaigTxOD0Lv; Mon, 16 Nov 2026 22:27:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CFFA040705
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794868035;
	b=jgvXjJ5PteMnNrMPXx5eOgWv+/AD6VLzB4jfu9CPLYsBdldgGnjBwBMOk9tGSvQ0L30S
	 yQhd2P88e5o9kytzsBmKwA+I5U/ChVqA9NmUV6lE4TEbAXRY6VGdfcVoJf+WvTZPewCCY
	 Jp7H+7LNeevMygnAxXpkH/wMN2lCXh9sOxbsSFJcUA6AN691WygYz/ElUoObSdLjVW/35
	 +wbpWgQdHEyvd1n4tUugK3+RH4CtDRB5B2lmxFjoLsVsUXtLp2g4hy0Y0GmsjmRso5saP
	 c5tBH3M/HuZ3ZTeBrA/sypi85Zz3ncq9J5bXDw088alkmPH3Sfdp00glSuSTOFpkI4g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794868035;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yTKvK6Q2yCQePo9OFHjf3+LCM7gt5vNfOS7VI6PK0to=;
	b=ItRHDTmWXHpiBsjYFApIfbuiSbQe56acVKO0X0S1vjU0ayZ1eXKUrvJP6qnyniRlQ030
	 r3TlYunaflOamORCD/eW7upvB27dUKZM5EbYVvHvywLVxs9oVqLb0d22p43Cw1UCYfafj
	 eAiGBWq0zfmxh69GSANEPS3NjJhqMFrr2yN/dgHAAZYEvouwE/LHvOohAH7gBVTAnyxgk
	 DjpFF5XfAUsCtld4WtT3H/7jb9A0Fq1KfltW8Bbql8jbjtNvi0wCbNHWVMLEh4I45FB+G
	 29GoJm1D6k2afuxY2bv5WdDfeBTwTNRh/AODjy7xHW7E7+DIbUoTzmYL5IeYFmh3XPg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794868035;
	bh=yTKvK6Q2yCQePo9OFHjf3+LCM7gt5vNfOS7VI6PK0to=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R7o0AdRqP3POobQ1rKrtacqd722d2dnjDTt4Pzv3cYoRXxb3FxhtsAPTliqvDoXPf
	 KeSqo4VX9FEiiKsCa05l0XIHipVs6ZWEOAUqbAMF6vl0Eo5KLss1AwP0dK2rfC88c8
	 dM3wuwyQgC0nG4uUKnFIUVFTGIO8VBIB5NilnZfjqHs1JOLYnOIQzRVLfxEunx894c
	 8X/y0N9OxmQCgiiORp2xdnByBaJlB6pWVmpE41DWXHASXfD5FAN+/rLhTjIPkAg+OL
	 boA2Fmh+UYsMbxz5Vb03bajxSyCS3Ak7oStixi18KiOHpqdkNkIWVMCXkGFvpC8Qg5
	 /qwUrX8WksjCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CFFA040705;
	Mon, 16 Nov 2026 22:27:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A2B9B49B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 22:27:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9429A606A2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 22:27:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jwoll4Kjilaz for <intel-wired-lan@lists.osuosl.org>;
 Mon, 16 Nov 2026 22:27:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A699060602
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=md2D4WPO
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A699060602
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 22:27:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C66934139E;
 Mon, 16 Nov 2026 22:27:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283BA1F000C4;
 Mon, 16 Nov 2026 22:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794868032;
 bh=yTKvK6Q2yCQePo9OFHjf3+LCM7gt5vNfOS7VI6PK0to=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=md2D4WPOInNakDSqWfE1IPbeod9zOxz2pjEYXRvX5XiOz3ugZVGikYj7oFVPNv5TA
 anRLz9W1IPaeffFSXdQM5eIkNzSl7SSBVcl2XNx1GIfniOATopc5iOYnfIW2tcJICz
 aVn8KUWMqGcxXYidnfS7JXA/XupIgyyf55FAXfxOjNnYtNjcQUssyVADQa/bzbhV3W
 UicZSxsZqypH7o7MtWctPXY/bJPQqUdH6+NnMUSsGHKKnFY1lnd0GDxpKiTXt7vuKS
 VxK1w0CvT9hWXVQ6g73MyFiBbMOQ63w53AYN7IuB3i9vZCAPLRr0V5/4yR2A03YPn6
 UCdDxRThMLAvA==
Date: Mon, 16 Nov 2026 14:27:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tianyi Gao <tianyi@cloudflare.com>
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Jesper Dangaard Brouer
 <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Lorenzo Bianconi <lorenzo@kernel.org>, Vladimir
 Vdovin <deliran@verdict.gg>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Donald
 Hunter <donald.hunter@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil
 Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Magnus Karlsson
 <magnus.karlsson@intel.com>, Tushar Vyavahare <tushar.vyavahare@intel.com>,
 Jason Xing <kerneljasonxing@gmail.com>, Nikolay Aleksandrov
 <razor@blackwall.org>, Madalin Bucur <madalin.bucur@nxp.com>, Ioana Ciornei
 <ioana.ciornei@nxp.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Chris J Arges
 <carges@cloudflare.com>, Jakub Sitnicki <jakub@cloudflare.com>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, llvm@lists.linux.dev,
 kernel-team@cloudflare.com, Tianyi Gao <tianyi.gao@linux.dev>
Subject: Re: [PATCH bpf-next 00/15] xdp: add SKB core extensions to keep RX
 metadata until skb creation
Message-ID: <20261116142710.347e8571@kernel.org>
In-Reply-To: <CAG4wq-dhd5a5zxQcSShaKifYd2z+pMpHaCYtZJRX1QCxEH4dfg@mail.gmail.com>
References: <cover.1794281983.git.tianyi@cloudflare.com>
 <avOvI8xrHI0dwyHj@devvm16445.scu0.facebook.com>
 <CAG4wq-egD55NZDw+OKVKTKN2tQJ9oKEC504wFv=xoMXyJ-0z4g@mail.gmail.com>
 <20261115113902.4834dda6@kernel.org>
 <CAG4wq-dhd5a5zxQcSShaKifYd2z+pMpHaCYtZJRX1QCxEH4dfg@mail.gmail.com>
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
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 15 Nov 2026 23:36:34 +0000 Tianyi Gao wrote:
> On Sun, 15 Nov 2026 11:39:02 -0800 Jakub Kicinski wrote:
> > On Wed, 11 Nov 2026 01:07:46 +0000 Tianyi Gao wrote:  
> > > - On veth, an XDP program removes software GSO from the peer, limits
> > >   its MTU, and can copy skbs from the peer.  
> >
> > Could you remind us why you XDP_REDIRECT xdp_frames to the veth
> > if you end up allocating the skb on the veth, anyway?
> >
> > I thought that was to let veth run its own prog before skb is allocated
> > but you're saying that you want to avoid veth having a prog, so clearly
> > it's not that.  
> 
> Thank you for your comment!
> 
> XDP_REDIRECT into a veth without a program on it has been supported
> since commit 0e672f306a28 ("veth: check for NAPI instead of xdp_prog
> before xmit of XDP frame"). There is demand for it [1].
> 
> With or without a program on the veth, and on cpumap, this series
> keeps the RX metadata from the NIC until the skb is built.
> 
> [1] https://lore.kernel.org/all/20210416175929.35c3c389@carbon/

Perhaps I'm slow but I don't see how this answers my question.
I read your reply as "the config is supported and my team uses it".

The question is _why_ you use it. Let's leave the cpumap case aside,
you provided no legitimate reason why having an XDP prog in that case
is a problem. With veth - you are right that attaching XDP causes
problems for pure skb traffic. For veth cases, however, there's no
strong reason to delay the skb allocation. Hence my question.
Why not let the driver allocate the skb if we know that the
redirect target will need to allocate one, anyway.

Since your patches are not a natural / clean extension of the existing
infrastructure - we should step back and make sure the use case is
practically justified.
