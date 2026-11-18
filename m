Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9702606A32A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 00:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=ZEthINQb;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H8Z8uMXb
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 86E1280CFA;
	Wed, 18 Nov 2026 00:19:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uVAIqsswJP1c; Wed, 18 Nov 2026 00:19:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C843E80D1E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794961141;
	b=jI6g+SHVvaogVvoMTRbdUsZEkzoSkyYHBh5YrhfZUCYPpoNbVRn8diCcihCcKD31cR54
	 dmbnGt5t6Qqa8uOo/c95pjhzBPyMnjZy7KDOzw5M5EikVeyvuyznRr1UlWaQ8GjdWbbhs
	 gU5NBNbS5m7feLBYE4tzwjb1GRFaqfsORRWgQS8b/FQLEiexLxgp8k1TskzFHoUk544fB
	 p8mWVBWkR/1ZdYSxNRE8aA6/bb8nsKFGiyg2+jAbcLLiRbpboMNTOVqdCm5S0/CFzYdbb
	 U+7b4s8l2y6BpbzV+a+Y4mIOF/Mmx0BBynSIPKVHDwMJGaG/QbvRUbdB92bGAoYPo+Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794961141;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=CiaEOlN3DliPTegWH/OxBrR4pZjxHdFZsot9BUcRetk=;
	b=O9KTLzN70S/yNeuzayc186D8qw9hwJ+G154Ad1L4k1S8GtvthsBLPolQ2dB4tfKdeSo1
	 AWJO/l9gBMmZ2Lep4crRbLgFKuxXd2yNkQKpGgjPCnFftLqsCIZ1uRmYSVGZ8+75Q/7j7
	 uzQeFRqdw4XAz5MLHo4/gFgQtB8Csh1k8U1cv43smDH9NFw/yNqnMO1ox1gqczQUzymjh
	 ByjWBbJ5EoFhKfy258ZO3sxxJ5yFNffVfYwhs8Zd1e7ox0nMZu9MWv/WyG1C7yVEWKFM1
	 myoNIC67Wh5EFKHDlhy9DxVMsW6vswqIS3sOREtqRNgmfn4mJfEQVHz9nWcSBXxlacA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794961141;
	bh=CiaEOlN3DliPTegWH/OxBrR4pZjxHdFZsot9BUcRetk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZEthINQbtNnwifenbsWQPQMPftMGznI6tU9xbl0Q3YMAzaZn4SIWs9js3qkm0WIpo
	 xNkd/4WgCQe0A2KtAV/WaygpQtoJCu2UWRMuwE0fWgLw8uE7fpJHT8DoPhhMK7hLQ3
	 aOJJ28FEoUfE5Jz80a+vqQ1iSfmpqmJKHRNxZI8WxovoGUWeEVp9AQ6wQZZF0Ykinz
	 91rkctSUIVX9nsYCre7HDt5KIHw6j+SAxuPnTH1GjDGT9wUefzkxocqjLSQxUpRZ9p
	 v7Lg32FC61H8m4nQrNdmBzl6t7GaLB64S/K5+beoeMLMv6CVoeMq7GRNcXOkRI/nfC
	 sZKiRAChW26DQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C843E80D1E;
	Wed, 18 Nov 2026 00:19:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AF4FFA0E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 00:19:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 94DF040079
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 00:19:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TbymdVUqHbHk for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 00:19:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D05EB4005F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=H8Z8uMXb
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D05EB4005F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 00:18:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 987BA40406;
 Wed, 18 Nov 2026 00:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117E81F000C4;
 Wed, 18 Nov 2026 00:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794961138;
 bh=CiaEOlN3DliPTegWH/OxBrR4pZjxHdFZsot9BUcRetk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=H8Z8uMXbbN46/Dz3D2RrmXrHgVu5ybahMNNXc49qnRx6z5esm+e9cQXQNXAkFRcrN
 XjmuwGX7gj9Rh1y79PoI4NaK0mLI3lCX73yjdRDoB+D1y1WklzIy2e8f9mS3q4u+l/
 dLFiO9fYL3E7KTmVPPiOfWsjTNhS0YMv7GMyaIDCQ+pKEm8Lgacu/lrndDp8B7MNLx
 YwMbpf7AFMyuj1PqggDvwly759kt51eULOFCZw2i7JDZG6WT+TRtdZa0B7IB2fTULb
 hB4c/bZDmJWQPPjQJHU2uC878bQxQs4xyl6w8kaik3Dq8UI1RItPx7q2mDRwt/utdd
 +sV71LPdCs9XQ==
Date: Tue, 17 Nov 2026 16:18:56 -0800
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
Message-ID: <20261117161856.6f6c2ce9@kernel.org>
In-Reply-To: <CAG4wq-cDYa2GkpWSYeOLwEPv45BtucZk+r=N2b1Srd=gUUO4MQ@mail.gmail.com>
References: <cover.1794281983.git.tianyi@cloudflare.com>
 <avOvI8xrHI0dwyHj@devvm16445.scu0.facebook.com>
 <CAG4wq-egD55NZDw+OKVKTKN2tQJ9oKEC504wFv=xoMXyJ-0z4g@mail.gmail.com>
 <20261115113902.4834dda6@kernel.org>
 <CAG4wq-dhd5a5zxQcSShaKifYd2z+pMpHaCYtZJRX1QCxEH4dfg@mail.gmail.com>
 <20261116142710.347e8571@kernel.org>
 <CAG4wq-cDYa2GkpWSYeOLwEPv45BtucZk+r=N2b1Srd=gUUO4MQ@mail.gmail.com>
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

On Mon, 16 Nov 2026 23:55:42 +0000 Tianyi Gao wrote:
> On Mon, 16 Nov 2026 14:27:10 -0800 Jakub Kicinski wrote:
> > The question is _why_ you use it. Let's leave the cpumap case aside,
> > you provided no legitimate reason why having an XDP prog in that case
> > is a problem. With veth - you are right that attaching XDP causes
> > problems for pure skb traffic. For veth cases, however, there's no
> > strong reason to delay the skb allocation. Hence my question.
> > Why not let the driver allocate the skb if we know that the
> > redirect target will need to allocate one, anyway.  
> 
> Sorry for not being clear enough.
> 
> On the setup we want to build: an XDP program on the NIC does the
> decap for all traffic. The services run in namespaces, so the packets
> must be delivered into them. Some services attach their own XDP
> program to the veth, and some do not. The host does not control the
> service's program.

The host doesn't have to control the program, just know whether the
program will be attached, and therefore whether to use TC or XDP.

> For a veth with a program, the skb path has the problems you mention,
> so the host uses XDP_REDIRECT. For a veth without a program, we want
> to use XDP_REDIRECT too, so that the host delivers to every namespace
> in the same way.
> 
> In a minimal benchmark, pktgen sends UDP, and perf stat counts the
> cycles on the RX CPU. bpf_redirect_peer() from tc costs 3% more
> cycles per packet than XDP_REDIRECT with the checksum status kept
> (mlx5, one extra __netif_receive_skb_core()). So one XDP_REDIRECT path
> for all namespaces is both simpler and cheaper.

That's noise.

> > Since your patches are not a natural / clean extension of the existing
> > infrastructure - we should step back and make sure the use case is
> > practically justified.  
> 
> Maybe I am missing something here. XDP_REDIRECT into a veth works
> without an XDP program on the veth. To me, it is natural that the RX
> metadata also reaches the skb on that path, without attaching an extra
> XDP program.

Sure, nobody is arguing whether in an ideal world the metadata would 
be magically available everywhere.

Inventing a new way of storing metadata (either in this set or Alexei's
simpler proposal) doesn't integrate naturally with HW drivers.
And duplicates the information. Fast packet processing at HW drivers is
the primary use case for XDP, we should keep that front of mind when
designing.

You want to cross from XDP realm to skb realm, after frame left the
scope of the original driver, and with no BPF involvement.
These constraints are unreasonable, and leave only clumsy and
inflexible solution on the table.
