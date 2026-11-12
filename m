Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51674606A31C
	for <intel-wired-lan@archiver.kernel.org>; Thu, 12 Nov 2026 14:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=ChwIX20H;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=KmiSiCTa
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2A70680A9F;
	Thu, 12 Nov 2026 14:55:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hO3iox8ZdzOm; Thu, 12 Nov 2026 14:55:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 61C9480AD5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794495332;
	b=Rvl7/IYo4G1CyACknxdkp7TNj2660RH50K2DhcnPnox3hlnmd7R/pjI0U7bE1UcdDZlb
	 XRJe/m2VFIjuVGxrKvqs6NXZeUjNLTMJZ8iAWoGktagndms06hHW1MxUfO+EStxoAUhgI
	 zK+acb9hqRGNsjF0f9ETr50ASAZwiA0k7lMjf/bshsaT5Am1AmUzg7gyz9IDgZ7pjcg9/
	 2dhCbBVHjET3WG3Iy4g73EGH1GxU5DeeE/DMkSop0JoyCJ2YLlbFoO5IiYNFhILyaQQIC
	 CFtIOWRYMLCuSkAUvy6p+hEuyoOBhkjbclwrvkU5VUTr7Ce30QcO05quoU6pr0CO2IQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794495332;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=vwPTmyMvNhiyDg4UslxzJuuKVfCT6YaQluFzq5V0j6g=;
	b=YTVvZO10T8BnoDk0Cfvk/JanXXyBJ2b/neHkWh9wFvRH7DPQoSWfipqyOaqJyjyN+ZcV
	 /NqS+ieuWKT3m5Dw+Dk2wXrRxtRW15aKQQwhudbEee+RMt9bmrZPNrfC4uZtsk9UbZG3Z
	 W1TnEkN9cLbZDI741g6XpgnCgAnuf8IFn4pcBwuO4y4kFMGeZ6X5Zx6VWI8KD+IFWN88m
	 RaqXWmHPosyn0kmZEYYxNr/aKVSzewBnIYifrkRoP4q9/XJMc7yUN2K8E4aUwTmLIecAK
	 x3nFiCDtwZCqgp9E472ExjFocoVB46r8JyiFi2IrGJ8DVWNbRoxwZycwmlREhQDrm7Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794495332;
	bh=vwPTmyMvNhiyDg4UslxzJuuKVfCT6YaQluFzq5V0j6g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ChwIX20HsbkLB6UVGZH+/0K3r5VLE9myrD0HtL46V0oaHYTMFqVSS5LXoBSqF3WVA
	 tBxSm48jBkNJglo6cov/ZtHtd+dl0IE0JP/gxydxFLc09tVPegoZh5GTLVcz+32BaH
	 iI/tOJ9yiITBhClqcqzq/+RzvDl0ox14kaLX2ok/QovWounGUTjNMpgsEn/8IgD3eP
	 SclqWc1mc6Kjp2HCWcMmL+f/8g7U0ME4S0m7x/j5T7Mpf6FP/H6BvTFRQfz0S+jwJ4
	 hJQKy5PtAdiumZNnGAf1JALP5BNEUk3Du8vgOloMrtTCw1ljC4/ZQckWKK6+ttdJvN
	 3pfSWNykfojQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 61C9480AD5;
	Thu, 12 Nov 2026 14:55:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9837EE09
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 14:55:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 894B260751
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 14:55:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JBS7EOSHQ2pR for <intel-wired-lan@lists.osuosl.org>;
 Thu, 12 Nov 2026 14:55:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1BE3A606B3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::c31"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c31; helo=mail-oo1-xc31.google.com;
 envelope-from=tianyi@cloudflare.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=cloudflare.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=cloudflare.com header.i=@cloudflare.com
 header.a=rsa-sha256 header.s=google09082023 header.b=KmiSiCTa
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1BE3A606B3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 14:55:28 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-6df7f544919so2379920eaf.1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 06:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1794495327; x=1795100127;
 darn=lists.osuosl.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vwPTmyMvNhiyDg4UslxzJuuKVfCT6YaQluFzq5V0j6g=;
 b=KmiSiCTauaXMt5MbjIBfaJb+FbCfcMrOioxLCU51D0TdVYgI03qHGEHH//qYbM/E/t
 ZC2PQGTh0WKYMy6IQ8IAE8squ5qSJCWULkSLpZfvnQ19idRqi8ATh5/Sm1PhJoY3J90+
 +JICI4GLb0TvZOzAO1I9FvjbtH/qB0rzN34w96aic4Z4vFQXjLNFDB8LY8q11Y9whZul
 Few68bimdT8i0dYqmNkyuU9YuXnSvvzG8QqeHpwjwLi8JNeT0dNDoVHTqBYO69FaVJIt
 0E4FRyAUMeS6fbl+eAP9td0/x/f4c+siNcu9NRsb6HaMPkmS+4tngsaF6MZsgGc0dS0p
 DOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794495327; x=1795100127;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vwPTmyMvNhiyDg4UslxzJuuKVfCT6YaQluFzq5V0j6g=;
 b=vvEWOyj4IasC/XLSiVH1hE7zS7HATfD9DyqgGj3iJwYeoWjCRL/20eVA4dq+H00+LP
 5MDwGLWFF2JyS0vPaWpGhjJSB68z4wfigwMLV7934wVZvgq7yZcgYJlCITip673ulFgR
 eRfYHF9TlvrOUUsRGWTGpguCr9LTeShprEffgY6jLMPNJEU0128NS+RKC9CfPGchZehc
 3+Tr0G1nsBcLETBbVbB/UF/q+Lv85/8tMkuLWzGDk2fGtcts+KMVTe08EZIAIh4IFPeP
 nrv5qH7udoM4mqwk6sq+g+b8Chf+YV7jkuBeTmuBU6m32MPbp17yyFS8GHuMjRW9ZaEx
 ErJw==
X-Forwarded-Encrypted: i=1;
 AL+hErHHmX41ZCEuqkx2LjORZw0uroM/ketb4voxOhVJbIojWQm+Wax/l1HtKsLsCvjTs5ys0EIrb8RQSp+AceNYJv4=@lists.osuosl.org
X-Gm-Message-State: APuU4Z8fPOOu/T1iGk1h85o8DdTW8c8n3du9+qHsdLP1zC0GOL/lSCJY
 SuHw7jWEfL+LxgzJQsy8YKOhGwhkLt1tl/o+XAY5B05Csx0/rMkmaLWanHmdc/BruQaCWr/bLRo
 kaGHqSRN/mUhSeuTqFfOSFJSPkzDLjhmZEMmiuGTgrw==
X-Gm-Gg: AYBFou25hm/durKxNJZKpAlNBDMgphSPmQ9iW2CzWCZFAx7pX1kSs6gw4GTjJtWwwUh
 TvtpjJRz1lKr7ZCkr6DO0IfWJU/FcoO8nJG94sOllaSwZepC5PZxLDRx0eEnmnz3GZIuTx4kWGp
 v9npqZDNxL15KGzha7P672qTUmoPzL2e8naqxRD/TnFIMjVGfoPURnl2TuD7yp5GCaQ+cBHPBCm
 jUnMpFHbYJygKo1Y2x/8H0NdwkDtlRbbDzj8GWGQJTbtFsmN9KY9EdqV7qCbc4yFcnJQUADq2ac
 BNu0L+f3LdrdPMPPm903v2wCMzDwfep/P8eizU5oevwJmwkFNUVp++doxm6u47SWshABbK7mFUb
 3DHFz2jNnZJS3hyB3vFgqZAluCmkkUXXfUHReLX0vKnrMLHD+Ghdlcx+sxrPkFQxVEqnwr5zD6a
 WFGP98Q/6s2Q==
X-Received: by 2002:a05:6820:a50f:20b0:716:bb4f:9d1c with SMTP id
 006d021491bc7-719179b52cdmr2435932eaf.70.1794495327350; Thu, 12 Nov 2026
 06:55:27 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1794281983.git.tianyi@cloudflare.com>
 <DMST78XBB2RK.2BKP3O07GEWZQ@gmail.com>
In-Reply-To: <DMST78XBB2RK.2BKP3O07GEWZQ@gmail.com>
From: Tianyi Gao <tianyi@cloudflare.com>
Date: Thu, 12 Nov 2026 14:55:16 +0000
X-Gm-Features: AclHuK_osBWVQK63DcE7gK81kaRbLSav5BXe8bL_6Bp3W1Mewum9RV7hacJBHqc
Message-ID: <CAG4wq-cXJtTzG2GO9KTL04b=prS+X67fRBJ=nriOO0G-24Rjzw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/15] xdp: add SKB core extensions to keep RX
 metadata until skb creation
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Vladimir Vdovin <deliran@verdict.gg>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Donald Hunter <donald.hunter@gmail.com>, 
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Tushar Vyavahare <tushar.vyavahare@intel.com>,
 Jason Xing <kerneljasonxing@gmail.com>, 
 Nikolay Aleksandrov <razor@blackwall.org>,
 Madalin Bucur <madalin.bucur@nxp.com>, 
 Ioana Ciornei <ioana.ciornei@nxp.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
 Justin Stitt <justinstitt@google.com>, Chris J Arges <carges@cloudflare.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
 llvm@lists.linux.dev, kernel-team@cloudflare.com
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alexei,

On Thu, 12 Nov 2026 00:34:54 +0000, Alexei Starovoitov wrote:
> I'm with Stan on this. It looks heavy.
>
> How about the following idea:

Thank you very much for the patch and the idea. I really appreciate it!

v1 uses the skb_ext-like layout mainly because of the earlier pushback
on a fixed struct [1][2]. This series adds only the three most commonly
needed types of RX metadata. A 12-byte fixed struct that takes headroom
only when any RX metadata is stored can be a reasonable middle ground.

I would like to hear from Jesper and Jakub before I move to v2.

Thanks,
Tianyi

[1] https://lore.kernel.org/all/20250805172831.213ddd8d@kernel.org/
[2] https://lore.kernel.org/all/1d5521eb-84fc-4417-a3f5-6366694d160a@kernel.org/
