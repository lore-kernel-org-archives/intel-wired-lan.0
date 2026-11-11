Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD8B606A320
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Nov 2026 01:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=GNqLnLWm;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=FMIzNWEj
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 15C98407D9;
	Wed, 11 Nov 2026 01:08:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id buXO7yTZbH-E; Wed, 11 Nov 2026 01:08:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4CE4640840
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794359282;
	b=SN6255Q/BkwglHYOc3XGBRwNk+58ZpgCOiWuBXpr+T3CydZk139/lHnOb8CQFTecK67L
	 zwEmb7cUffp2I5D9bq0HVmJvgXpPwEEibU67rVV7757Eno60y1xrBXciL6Y4i+x1S+kto
	 2AVP+t1NJUqr6HFxYSayd3llb0o/3Qwm46TzmMY12IrgJS8kpxZhZ3IuqBPd8oJfLSjk9
	 JtuOTLmqnSGCKWjFSsk1zSqxPIeshSiU4lEeddVzoIdw/+jkRV6x9ANkS7NoVSsHGy1AK
	 ELPA/XGawuameFsT6d/vXfpECJ8GRzd9fmCveIS4bbxSrFvnozre4v7vBnUdLLtX7gg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794359282;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=8MFwGdApl0d4OiJqtJrDFLzpxo7TMPDirGuojCnnp6s=;
	b=qOZMoS9p+haB7XMvtUl0htj+GnNc59CZOb3o8Uv2FKr9PraJWbOfLjVU2E0IcmhGcef5
	 veV9xilI50jCLwd3/wfN86x2RMoEp/SWZL7qhS59TlbQDdJyImnyRA40lcabzI4OpUhhK
	 aWjl0WT7rAPi363M3feA3GpSsYKwywOsMNMo9A6ohVd9bY5yU807GIuFogkWr785NOJtM
	 +F5RHpzI1YDEWugeM/cnrNXh103bAmycI91a+U55/Ud7FUHiwFWzmk05fz0AbY/YZC+IZ
	 XM7PQf8IhX2eOMrERV0G5dbAZQ+4tbWDWI4h+y4BaARY9GI6yMJkOUlAPtWDHlT9XHw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794359282;
	bh=8MFwGdApl0d4OiJqtJrDFLzpxo7TMPDirGuojCnnp6s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GNqLnLWm2QGqQ548NJ+661etklA9+R5sU39iwcKqfklulVoP4soEoURaMkbWheE+W
	 xR22ndiiUJ1d7OSVYbKp5Urhbe+GVNghBteZuggNSwW3OtncmdcEIajw4PzBEQ5v6u
	 DJ5B2zyJPc0ij7s4mwi0eFEg25MlaJbW2IjABl9GK145SGqZYeA86fohZx1mzkiPyp
	 n54zaS8K5iVFeXLJqmFz1pP5xLg+FLMYL535S5GwWy4iE0fnOUDUz/zDTFwcOBoOts
	 nc6VxsKpkqJINroHg3iIIhVuNcGOZd3WyLOxuQP8d8KCiVcwA+XWGT2ju8ALR62SgN
	 n0aNfWs1vt2ZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4CE4640840;
	Wed, 11 Nov 2026 01:08:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AB6F99D1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 01:08:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 94E316088D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 01:08:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f6j0skNKNiCE for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Nov 2026 01:08:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 66F3160797
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::c32"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c32; helo=mail-oo1-xc32.google.com;
 envelope-from=tianyi@cloudflare.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=cloudflare.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=cloudflare.com header.i=@cloudflare.com
 header.a=rsa-sha256 header.s=google09082023 header.b=FMIzNWEj
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 66F3160797
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 01:07:59 +0000 (UTC)
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-70b875f6f13so2110626eaf.0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 17:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1794359278; x=1794964078;
 darn=lists.osuosl.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8MFwGdApl0d4OiJqtJrDFLzpxo7TMPDirGuojCnnp6s=;
 b=FMIzNWEjptKoqokr7dJ0kMkNePgxl8rbqL9vugki3kaADZEvg+jKPlLmxzhH4r81pK
 kkR8QQAPYqY4OLNVhaOHlm2J/qfW7xygjAJIz9kyqGC7k7XiuQ/LoLUt2SHguNfJ4ViJ
 5E2r+ugc3NnE0pcOV9VV5TyM5oQOQVCiJFcZ++ejh+dIuGczPbHbh0V/2SR/F3u3+fHF
 FCR1OTzP762ppxToDAusN7G6h/FOiRw/7GdHMuoxKIZhDKvj3PHSwzAipd4rIWL4WI2A
 wIS6fGMf76XSuZIRWjL6d2Dh8aEwuhi3pGnkUK+fSRikewa9wd99uXIdQ4HGo0PuW5mK
 VrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794359278; x=1794964078;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8MFwGdApl0d4OiJqtJrDFLzpxo7TMPDirGuojCnnp6s=;
 b=eE8R6Rc4RlhLlDEqPY2E+cBwFl2R+4k7bhqx3/xU7NmL1mQIPdd+SC6AQrk1RUr1+F
 hSSjukVIl+BWJlyX4GGuKBotUlNKvrpx7WUk58wwj518A/41UdMTrsl3NTYELKX6K2AY
 nwmzywWilwsIghFkYx3Z8ggRELaXWf30bnyLtVcJ7bKF1R1Un0H4gPSW/SgQfkNY4fUG
 G9OYXV+zjcXLBxVcaa2bFHalZLhX847QiV1oz/s9d6UYZkj9ZGl2DMGtfyNnkjEEUR9N
 ezu5eljHUXrwtqFGpwWCtwYHOZnHxGFEBlPFvh57iQqIdDFT/hswmhc2By9W2Vi1aqNd
 3fbA==
X-Forwarded-Encrypted: i=1;
 AL+hErEdcMJULGsng8LVAcJ23+Peqv+qDbeBjznf1I/ylcJpjSWaPH83CtEzmxknX6DFVi1jxJDzvivoaaZMFkvBOqs=@lists.osuosl.org
X-Gm-Message-State: APuU4Z/oMRBAeeVXxR3IFxB/TyWGFVfGgigIjr44OQoucndSuKtMRg+u
 IDmeJcKssZbsBZCUiDf2p1Q4g0/ZkSMSxudMwvrf/Vdsal9crvKbZN20uQO4yzvbFbQZkZAqQrW
 TmUiYiN6jCs1QyJa8Y1lgdrTlGIt6kl/RMCUwL6uPdQ==
X-Gm-Gg: AYBFou1vphySvXW5dceuINJcib0GuEE1qU0NsgCCua6UAPPdLWFuIlLy53eviNTrLlP
 8joJZhrbVPUzItGRCLY0dLa4L7Ge6H7U4Bp56IFfPuDBqmVeyHkhIpNfNjLCFbOCcgd4ZPWrybD
 5TvqfVtEUxP58I/ZdDi2RLLzQTOLy6ejMWA+gSXenmPQXv38WZughTtP11lahjzr4ZDkXyGLRJc
 Ai06/KB8BMMyVg1BDqV4+xzW6K0YQh6ZhG7nGr4oUFanYDDZlr+6th44Hw5rQ+3gzWwPBlM30At
 /LQwHjBUdmnd6WNU4heauRDlk1PA/vIu++bocGDomm2MEsSEVFJdY6D9lMs6Hya/pg0YcOj8Gha
 tX5ZtF3kO7qPU5aKXA2MtOxPcCmo7uHJjFWXP5GOpciYdAySDUZSc8gj/+uDHXsEEHkvggxodnv
 krZ7nzgAV7yw==
X-Received: by 2002:a05:6820:16a9:b0:716:c04a:4771 with SMTP id
 006d021491bc7-71917858218mr598043eaf.24.1794359278033; Tue, 10 Nov 2026
 17:07:58 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1794281983.git.tianyi@cloudflare.com>
 <avOvI8xrHI0dwyHj@devvm16445.scu0.facebook.com>
In-Reply-To: <avOvI8xrHI0dwyHj@devvm16445.scu0.facebook.com>
From: Tianyi Gao <tianyi@cloudflare.com>
Date: Wed, 11 Nov 2026 01:07:46 +0000
X-Gm-Features: AclHuK9OIHzq1A_ViLb9jLKzo-flUIoCHThbTHbypb5m7BOmw6IeVMdp_ZFoAAw
Message-ID: <CAG4wq-egD55NZDw+OKVKTKN2tQJ9oKEC504wFv=xoMXyJ-0z4g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/15] xdp: add SKB core extensions to keep RX
 metadata until skb creation
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Vladimir Vdovin <deliran@verdict.gg>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
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
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Stanislav,

On 11/10, Stanislav Fomichev wrote:
> Awhile ago we discussed the alternative of adding setters for xdp
> metadata. Then the veth (or whoever turns xdp frame into an skb) can
> apply whatever metadata it needs (and there is some magic behind the
> scenes that takes it into account when creating an skb). That keeps
> the layout and most of the code outside of kernel. Have we considered
> that here?

Thanks for the reminder. Yes, we considered [1] and [2], and took
parts of them.

The alternative setter model in [1] requires a program on veth or
cpumap to call the setters for the RX metadata. We want to avoid that:

- On veth, an XDP program removes software GSO from the peer, limits
  its MTU, and can copy skbs from the peer.
- On cpumap, each entry would need a program only for this.

This series achieves the same with only the XDP program on the NIC,
which stores the values with kfuncs in the skb core extension area
after the xdp_frame. cpumap and veth take this area into account when
they create the skb, which is the "magic behind the scenes".

[1] https://lore.kernel.org/all/20250616145523.63bd2577@kernel.org/
[2] https://lore.kernel.org/all/aGvcb53APFXR8eJb@mini-arch/

Cheers,
Tianyi
