Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B0E606A32F
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 23:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=gDTYJ/NO;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N2epo7TM
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C06F80E71;
	Wed, 18 Nov 2026 23:35:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5nh7d_WH9_WH; Wed, 18 Nov 2026 23:35:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8FEC2812A0
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795044939;
	b=J+tXrYskKs/FhboGDJFqMkI9jtyjBH0dBTn1eh2RuH4BRF+fXAHkF/Bl/VJy/W0FZ0QV
	 LM6mttU2jE1uTl1wcxPqIXB0PuZyfhI/BjI//1fZIVpYZDwunjYPAKeYB72YLjjpqLkNQ
	 942o/HcdYb4cNoLvn+AR/FRkLh6arnjpTIGaaOa4h4W+dWQClLfRo66d/L0VOTYqOBTDW
	 PwXqr/jcVVFCR7xvTHJ1qRC7YoQHNlviDfNV1OwJdkyfo1D6KNGLZ4PSugGk9q22RlEuQ
	 sQYEgR4BsKS7kkXcRVXpOaJVljPZBTUkXodjACc3dzMYmwSYto007GeEhpzRLzfuf9g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795044939;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2acnagTXh+xr2sJRfNZo6Zu2b+AvMnzwD/RO49jKRp0=;
	b=JlfSXubF0oxbkysufsIAbexBKfWsbF/PwbdPuJ5/oxKm2KVqksuXHs/TvHw8Mhvs7zhR
	 Bjls/0kAJ3Eq6YWOqeKbD8KGVS8MoGXu8MEQm3paa2oPiVmNlGkdCfFOK4E6cLOj/kGYw
	 czF3lBm2pfo+QFINNE8hkNQP3b5GnRVdxT3r67OhRatzDXsLxT3WcOkY9JCXQlKPzlb/G
	 NPOK8g0PkBjfd7QBWndmMalqyFefq7udx6MpFPikGrlS3qEAn5CVE6tUCQpHtEbz0hGoZ
	 DkB5MXVayfm8hwTJf6WSsNnfUuCMnYffNPHiEMIkj9thH9J2Mqyw0jE+qtQ+KVyu15Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795044939;
	bh=2acnagTXh+xr2sJRfNZo6Zu2b+AvMnzwD/RO49jKRp0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gDTYJ/NOldWDksVF0/rdppGDWc2lgLima0IVPJvTWm/keWGIJ/sfw5fbMK0Ghojui
	 VF9oDX4c/wbxjLNcuaq+KLmM4CkQTXxeqTdpkMwPBtjsl9u6w+OT73WDSUIiqE5F+Z
	 kF7fFfeTwpE89QwHVn415xJ8eiSD1FILImR0SAG+Of5AnPsHB2dPerKmPPkzK8ZR4E
	 Nh7g/hqv+6xZeOqaNPwmlgyhNwI7NkyTbKZ1UGU4r5c3kN4DgdYog/tDUKbRRAv00V
	 Rj+RkW0WyW7nfLk35emBunRg02joSoIFXhkeCjsVEd2s27seNSlQwLgCu6ddq08+C+
	 ZTgdV/cnV/IKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8FEC2812A0;
	Wed, 18 Nov 2026 23:35:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2449649B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 23:35:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0A2DC605DA
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 23:35:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yGZ4eGeEy9iB for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 23:35:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5071B60664
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=N2epo7TM
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5071B60664
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 23:35:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6D1B447A9D;
 Wed, 18 Nov 2026 23:35:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AFB01F000C5;
 Wed, 18 Nov 2026 23:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795044936;
 bh=2acnagTXh+xr2sJRfNZo6Zu2b+AvMnzwD/RO49jKRp0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=N2epo7TM+4CMqdU9Z7/p9rcgWlA/P76+DKQXTEg7yDOipZZSIsty6IC0YrBbcywCI
 DJbpuriXg4aAy2YaazApcaqWBW57PtUm8nDcS/ILgaTnRz0fdUuE5pIX6A3ciKPB6F
 X1dPEDgqViOxdfMlLJevtgoiLyIXyjHPJuvJT8l7ohfZAua1XOQjnFmDlx/UleV5rZ
 NItGqbCmmF8iKThT2i43FePFdWFkAb1d74n80X17nqpg7HjnxeuSvafTpGFJCAOHVi
 MBlrtgThq8LgaVR6sH0nM2sEmUoeytwe5U2rqWLvvdFPnVTYfWp/RsbD1Cmj1ByKKt
 QpVoN95Jy5WYQ==
Date: Wed, 18 Nov 2026 15:35:33 -0800
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
Message-ID: <20261118153533.42cb8def@kernel.org>
In-Reply-To: <CAG4wq-cQVUJgizeowhr4s4Z2Q_o0_dWfAwzXthpBATBB-7edLQ@mail.gmail.com>
References: <cover.1794281983.git.tianyi@cloudflare.com>
 <avOvI8xrHI0dwyHj@devvm16445.scu0.facebook.com>
 <CAG4wq-egD55NZDw+OKVKTKN2tQJ9oKEC504wFv=xoMXyJ-0z4g@mail.gmail.com>
 <20261115113902.4834dda6@kernel.org>
 <CAG4wq-dhd5a5zxQcSShaKifYd2z+pMpHaCYtZJRX1QCxEH4dfg@mail.gmail.com>
 <20261116142710.347e8571@kernel.org>
 <CAG4wq-cDYa2GkpWSYeOLwEPv45BtucZk+r=N2b1Srd=gUUO4MQ@mail.gmail.com>
 <20261117161856.6f6c2ce9@kernel.org>
 <CAG4wq-cQVUJgizeowhr4s4Z2Q_o0_dWfAwzXthpBATBB-7edLQ@mail.gmail.com>
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

On Wed, 18 Nov 2026 00:42:55 +0000 Tianyi Gao wrote:
> But I see a fundamental mismatch between reading and writing the RX
> metadata:
> 
> - To read it, we must go through the driver callbacks, because each
>   driver keeps it in its own descriptor format.
> 
> - To write it, the target is always the xdp_frame or the skb, and
>   both are the same for every driver.

Sorry to labor the point but the assertion that the write API has to
be operating on a completely separate copy of the information, via
a completely separate API is unproven IMO.
