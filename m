Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CFB606A333
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 00:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=JpfqBdWO;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=JjV+XzzY
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 43ECF407F0;
	Wed, 18 Nov 2026 00:43:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bQf4ESPvxtPn; Wed, 18 Nov 2026 00:43:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9EFE94075F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794962590;
	b=M/J13AOV0Dyg4E9hyFX8OVpCvQoDP49MukqCYamLQqtML46Bc2BiOGGdZH5LFzlZt8fx
	 uB0/7cZzVjw4mkjx+vFprH7mxAKzGJ0orrBi8YbFFQQxRH9iOkvG04/KeP/KMg+OWeBxI
	 +qitcifkrKgPuZe/zvUtiYZcQgvMhXMSop0X7AvnKsQ8oeX5uRqxrzAbe/mT+mSRw95rS
	 FT3az8BEJN2I/8TYnCkA2BdWtUeQQT6vMiEW48hWPX7RXAhEpPE8QydIUpTGsFreTTUDl
	 4NBLUAQAAQIxrLNvLYKN/ERIdyPVmtEg+Yn8sQNfrb/Kz24qF8E7Pg/BPGZjDDD7EJA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794962590;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=puGtQjs5QpcXV8o0ei3pWVAJkBqePYnUROGDguXC5No=;
	b=MrrXLiuTUp3tHBV3QEcSbZiYAQDRWKlgvUQqkUirbfWDilV6CUvFVm8mdwpGnoE7F9ow
	 NfWgIr9sPc/viDOsfkUOeJcqYwHLFj71LJ0pbWhjJjVVITnYBCNyQPD/iQuJ6LuqDOlSt
	 Pc4CQSztkSuVh3Zw39B5L2WMZobJXSOJ8QTGInmQMf1XfLn5//PSiLf1KWsEjbsZXHMn7
	 ZXvcLWZyYcqhwxt0VzdO/1/4H0e1F9D4QZCwf7YHbAjIefcb9vesbii0qNy9y0Za/eXYd
	 78e8p2/CgwSuAMwPX1OKYeyzbCBVfy7LLAlSlD8zSeRJ8zB+KI6VFTWcvKJT6FYdudQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794962590;
	bh=puGtQjs5QpcXV8o0ei3pWVAJkBqePYnUROGDguXC5No=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JpfqBdWOO0x44sQJ8FcOqNaGr4ZQ7Zy0k0fzGMwZ8VmbSHV5kTHY2KhdfE5/kWYEE
	 BlSdxD5hGjleXci5d+o0xooyHsKbYb2tpW3oOBeVYf9AU1p/uhrTMeQyNmyls6KF5q
	 gHZcqE5sTo8rNBoD++0RPJI5tmIBdHGH5LyvlvxBUhwTWzPkElEO0tMcPARlY+Q4f4
	 clR1l09jl4qk7CY6pHw/wjlH89EQYCWCnrAJgTrTYTuFsLH/2wHwjgg0+GFsuEQ8b+
	 u78Ao7tfKspjJS97FDbla3NG1Ik/9oT0C8SQZUweSDfSdcmNwfbk60K+6/nGiqomsS
	 nRGPaImmrQPmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9EFE94075F;
	Wed, 18 Nov 2026 00:43:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 322D4105
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 00:43:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 186AD60729
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 00:43:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UYWZh7-6qr3Q for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 00:43:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F1E3F6067D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2001:4860:4864:20::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2b; helo=mail-oa1-x2b.google.com;
 envelope-from=tianyi@cloudflare.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=cloudflare.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=cloudflare.com header.i=@cloudflare.com
 header.a=rsa-sha256 header.s=google09082023 header.b=JjV+XzzY
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F1E3F6067D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 00:43:07 +0000 (UTC)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-4877837890fso213126fac.2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 16:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1794962586; x=1795567386;
 darn=lists.osuosl.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=puGtQjs5QpcXV8o0ei3pWVAJkBqePYnUROGDguXC5No=;
 b=JjV+XzzYTJB+UIjvN/2UHQfCXAmwRv8vkVP6IihuE38wr5h508ejG3ZA0GP5A4OncV
 HM6wQFAI0LZ0rBYZPZh770wckX1CJ+vV0LmYrHDEWbwKr0fF7zWBAfjxQ28gWSeQU0ug
 oHUUh6vKq9jUNpxPpQKjBH0TdM3/DEEWvwS+1xVh6Wgc9zaTKUeKjH5OMb6f9E/m8hx7
 Dy9MymsI/RQ1gJZMnR1uBH2570eCtwGkfkCOss265F4GV0vwxvOwWNxqkF6qf8foYX9R
 aoA/lnDMXJTbrykKkA6Zpv4QvM1zMt4uiF0GZJRxMofrpbUozhxFCPxS+uKvBpO1kvir
 zQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794962586; x=1795567386;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=puGtQjs5QpcXV8o0ei3pWVAJkBqePYnUROGDguXC5No=;
 b=BgyjE0p7Rt3ePsWiiSKloJxW0grjWV6dYmd7yvh8vp0zCqhF/gox+I6jLeTS8AoxaT
 HFwPF1MgoaCc4oxzWBmb5T7oiZwed6YQURyV4BKNEHQzcNrKgCoSQNhCmzsD0EgoudMZ
 jZD6fcsNXvZsjUbAz38WxjNytw4DSq0uLSa4zkl0zG1BS8ZnWZot3+4CF3eJasVaMBNS
 SLuPch6lc7EYL6USlLBM8NoxItf+eXLWxbfCryn0ooHRq5ihVQb/fLazmavhwG75l055
 dNgOrYGlBcsA+p0jY25tt9hAJJqBHWrNjWZM6rOAhlj/ypR79DKBgceXj68KYnoPAMwq
 dIWw==
X-Forwarded-Encrypted: i=1;
 AL+hErHmagiPGL5NxwV/E+jtPcQQp+L/egrTVnb/MBn2VjRNIXAWzlzkDrAaSebqUCdiw/tiDn11tGOztOKMpOPeYAU=@lists.osuosl.org
X-Gm-Message-State: APuU4Z+9KpKWFFSyqFNq4Jm4eF9Rf96jfZ9aD9KCOtD9wfq2O1+PrDRV
 MHDomJ+BEGmfrMfELi7fr+k+vME5mjs+qIvQjB2eEM+w6oGbURrB3lb5D9CzVz5/J7qLG7kkjBo
 HZVUg6rdqgsG2Bd4A4R8q7fkIQbRecfO4qA+IVggmzw==
X-Gm-Gg: AYBFou1q7uv/VNu4vUrt8rqIWu6pW/LTaUsw4m6duCGW3uMk99y6MZHsq0cKc+ZX/sX
 tTWCwy/S3+TiUXjfPma55x+DkSTljnLqtALVnycyjhlDoYyy8YdZ4AOAr3jVN79vsvpT8kda1nt
 yzjgZqXoEGfG+PvZbkVRIxmQlTiYcH6tEp8E9/HiisHySc6NXbXaH/ua9swmCgl55GS2EHbX+fm
 XW/roY9Q3xLjDPMfI83y5C3x2YL0nvv1uVAUvmvf1s2eCc8q1CsEhR42nuYzRbSkEsUkR38Qox7
 FiZ6ILgh2jJpxmvtJwSJKzHp/HhFaBsvdWuDEylFWcucUV0JObcNdEnH++3FPRKv316qRsF3Aky
 sIcTy7y+RCy3ywIyj+15CMOXOCHgmMDmebIVeoOa/fzbiO7kKlO2pw/7g/1KyAHAl4eJeiGf9PZ
 F7RanyPpeHkA==
X-Received: by 2002:a05:6871:b11:b0:491:47e1:6280 with SMTP id
 586e51a60fabf-4b75bb74ec7mr770348fac.15.1794962586147; Tue, 17 Nov 2026
 16:43:06 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1794281983.git.tianyi@cloudflare.com>
 <avOvI8xrHI0dwyHj@devvm16445.scu0.facebook.com>
 <CAG4wq-egD55NZDw+OKVKTKN2tQJ9oKEC504wFv=xoMXyJ-0z4g@mail.gmail.com>
 <20261115113902.4834dda6@kernel.org>
 <CAG4wq-dhd5a5zxQcSShaKifYd2z+pMpHaCYtZJRX1QCxEH4dfg@mail.gmail.com>
 <20261116142710.347e8571@kernel.org>
 <CAG4wq-cDYa2GkpWSYeOLwEPv45BtucZk+r=N2b1Srd=gUUO4MQ@mail.gmail.com>
 <20261117161856.6f6c2ce9@kernel.org>
In-Reply-To: <20261117161856.6f6c2ce9@kernel.org>
From: Tianyi Gao <tianyi@cloudflare.com>
Date: Wed, 18 Nov 2026 00:42:55 +0000
X-Gm-Features: Aa3M54r-Qn1bATmm01-LGWkLr4tuoSPVNlK5FfS3xcLFtqloul4EQ0s5CX5Sq4I
Message-ID: <CAG4wq-cQVUJgizeowhr4s4Z2Q_o0_dWfAwzXthpBATBB-7edLQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/15] xdp: add SKB core extensions to keep RX
 metadata until skb creation
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
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
 llvm@lists.linux.dev, kernel-team@cloudflare.com, 
 Tianyi Gao <tianyi.gao@linux.dev>
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

Hi Jakub,

Thank you so much. I am really grateful for your comments, and for
spelling out your views on this problem. I learnt a lot.

I would like to share how I see the problem. I understand that you
want the setters to mirror the existing getters, so that the metadata
stays with the driver. But I see a fundamental mismatch between
reading and writing the RX metadata:

- To read it, we must go through the driver callbacks, because each
  driver keeps it in its own descriptor format.

- To write it, the target is always the xdp_frame or the skb, and
  both are the same for every driver.

So to me it is natural to set it all at once in one helper function.
This also makes it much easier to support a new driver than
implementing three callbacks in each one.

Overall, I feel this has turned into a deeper difference in design
direction. The same question has come up in several earlier series
too. I will discuss it with Jesper, and we will come back to this in
the near future.

Thanks,
Tianyi
