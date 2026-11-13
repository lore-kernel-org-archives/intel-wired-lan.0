Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DAA606BDD7
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Nov 2026 08:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=MynaCYix;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=Z4pVlkPr
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E78B640DA7;
	Fri, 13 Nov 2026 08:29:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hoHP4ACCouo0; Fri, 13 Nov 2026 08:29:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6F58240D96
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794558580;
	b=NJ1mGjwwvyvXomq+TWFN4Lcm5fBvlYsppXFH7X+jUOeVx8DILjLGoXTH/nBg1kydsWbE
	 VGUEhvAY9uvam+jlRs5ogm735lxOKAV50c+37bgE/r03nNbGKQ+LFulNRCTJNE9jqD6vL
	 JkmlFiwPFqMPpKPlR4HapU0a1TQHlXkvvct4TZaRcW5ILsQOmm1LGyT8tVOoblkAKu9it
	 Pb6sFmDLPOdrWfNigbhzCRBqF3+wTp5UyTi490rFA00ehiiqkyvH2wjvuS4x/lywrXS8b
	 4GlYN/j3Dw1dpIPhV2xa8tIfoOmIE022yh87UzVsPVFdzs8GaeQC2rFV8CwvG3JMVEQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794558580;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1mYFa7xxgjAJeyPToTySUaczpeeUgBwhkLFQ6YEU7hQ=;
	b=a0zpKmIlZ+hmxidYhMCDAS6X2MOzSlLGpmXd689s1jGqCLO1pWdGqaFVAXh+SlRghoIY
	 1GxqWt8S474u9LA/RmYZ7yXKMXawj8LEmhYJM7KG9tfyFnIuplkrycFMkeh1DWW1Z70Hz
	 N7DF7eZ03tRzTYFHBNdMntZddZABe1xbBW49o8uBxauU4ZiYB0CJPSO+wGr51vr9jXKMK
	 GiwtQfwu9n0srKT//2oVGpklNq3Ht89PWyztl/5QEDyylo6KVOnazEtklCcU4xgxT3uzS
	 xdZQds6yAaLr+WLI4jwRALssb6+u46eyb15trAeiCCXNDv3Iddmvga28CUcwH7wEgrQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=1g4.org;
	dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=Z4pVlkPr;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794558580;
	bh=1mYFa7xxgjAJeyPToTySUaczpeeUgBwhkLFQ6YEU7hQ=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MynaCYix0iMuoEkYwG5q2dnjJWqPMPgQ+OgFswenkUOI7Hz9KmAkOOY5khl8ZE0mr
	 NhI7QoJMVDV8dA23cWGoc3db2Ioc3SqYggc9g1jpVVIZ55RhvCpgtGzWOqsgclwRTV
	 eFoZj7eiBEwpU74cCy3EQ2zaed7/gRtLseGRxl4LF4AHXnSeZXfYysF+ScXIsfipIy
	 3mqSgDI+9wAmHqWGJR2xD0bwo04pxy8eOM3E4weyGrc577SWDqqUzvFaCy+Jq5meKN
	 Lmu4wXmXmC4tI/ZiMeI2g8TQa2LVR9kmBGPwKXWellKyO4YnSV3VCAd97Yfu+nHm4N
	 uPiAlmzDySheA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F58240D96;
	Fri, 13 Nov 2026 08:29:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C31228C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 08:29:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3208840D96
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 08:29:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s4Zna71ldCWu for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Nov 2026 08:29:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 07AD940D8F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=109.224.244.119
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.119;
 helo=mail-244119.protonmail.ch; envelope-from=p@1g4.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail header.b=Z4pVlkPr
Received: from mail-244119.protonmail.ch (mail-244119.protonmail.ch
 [109.224.244.119])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 07AD940D8F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 08:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
 s=protonmail; t=1794558573; x=1794817773;
 bh=1mYFa7xxgjAJeyPToTySUaczpeeUgBwhkLFQ6YEU7hQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=Z4pVlkPru5cQylQgYvXMOr49LFb2OHKQRpwgqEsPQ8IYOcp5mY86PTpezXkfEXJIM
 TSWPAC6obDhtBNj8zBxGTMp4LunDoLDgHI8CkgfsnlwI90lWB9o6nf88ZWXy5JTsyJ
 oyg4WoL4zZxN7i4Q4dYHhxADPMk3sh+uRVhA6rIsjYPzgl+bzhDT/FttGFSsPYvf5B
 UZxLMtao3ZKqzEClyme06nK7cG5P1Vh00IoMUU72thYfI/lkBUMkmXeqLlIgi6RL8Y
 GlCImxsZ7xBP1myXhpZBT84h2pzXJ9nbLH4rhzSnwNydeyT9lMMQhmNIm9Y6BzKyC6
 E8DKtqW7gMFxg==
Date: Fri, 13 Nov 2026 08:29:24 +0000
To: Ding Meng <meng.ding@siemens.com>,
 "gerhard@engleder-embedded.com" <gerhard@engleder-embedded.com>
From: Paul Moses <p@1g4.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, florian.bezdeka@siemens.com,
 jan.kiszka@siemens.com, wq.wang@siemens.com,
 Jason Xing <kerneljasonxing@gmail.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] net: mark skb NAPI IDs independently of busy polling
Message-ID: <Fhn2gT70aJ-2_eak73NBZYuXuKtVb64PoD8VQ9jwm-S-K0RhZilAg9iwSBJ0RlaiSrRvM1vPw1aHvGPjcktu9GmdBuvFk9244-q2IVOrFu0=@1g4.org>
In-Reply-To: <4pqljild2fp6eotiicvwbwu2wfw66fzd4qamwt6utirdjxlaok@iiu2f3k7azrp>
References: <20261105071706.7043-1-meng.ding@siemens.com>
 <20261110134539.12d860ef@kernel.org>
 <4pqljild2fp6eotiicvwbwu2wfw66fzd4qamwt6utirdjxlaok@iiu2f3k7azrp>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 8667dd8222532892df754a88db7395758801c657
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


>=20
> Then, drivers that use deferred timestamp conversion (e.g. igc, engleder)=
 must
> specify a busy poll dependency if they want to obtain the original net
> device upon consuming the skb. However, this dependency is far from
> obvious, and annotating it for future features of this kind will be very
> hard to discover.

The "deferred timestamp conversion" was incomplete is what I'm saying.

This started with 97dc7cd92ac6, 0abb62b68252 and 069b142f5819 were built up=
on
it, so maybe Gerhard should decide the path forward?
