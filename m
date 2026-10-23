Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC52606A31E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 23 Oct 2026 13:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=02gWdcKU;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=VJwGYLKh
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A25F1814C3;
	Fri, 23 Oct 2026 13:52:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZdpHkWwDYBXz; Fri, 23 Oct 2026 13:52:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F0942814A0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792763566;
	b=G8mxudr7Du/0nRm06gymevkzTsQCA5UTKZbIZCnWFHCeU40dJNuW2RBSTRCLx6AAz3SC
	 qRdRL4Ubdcwea0TKFX+998di0yaWeSjfLmdwHHjIorolilv0dq+tuRX6Kb8wAIYDSH7c8
	 D9Gik/UiBV5PHYxCfhLM8BNNiE20B9IMHToXqUlnme88eOdl2lfLR4aUb72rVN30MRX55
	 O6y+gRidAMP6G56gMStBmNXLcSOrsISFq9+U8I81pUKHrbwSOLZ0eNc6Z77k/exKMplgC
	 w0+KnXGH55sQzgJuXuZFWZNf0bgUjaNv42uYRYce3dhg3AqWYzycpkilU2Lz/Wdx2GQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792763566;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7xX2gKagSUBvZ+dsAi1NUa1T9ybCAiN1NSx6inwuTp4=;
	b=KZIbuiV/XQJlA2AOkLS3d9ewgI8hhTdGYtzkiuB4zPKO9j2SMGPpv6UBm/fAbrj3mnKh
	 r8ASs7M5eNDhBx19HyFArq8K9ui7Ay1L4wYqwe+NJm9J6Asm5VA9JGoWjy4OKHeUy0DbA
	 kSE2243zNvQu1Aqx+kbuTBzaftV3Iutbn4zcxIKcqAPoaxAwal4O3ou436xpJiwoWgFKS
	 0HKgV51iES2lEcEpn9/g/5l5GrpZIBzT+CDCtd9BvMc0sPNF0btHXNDwljhP5fGVVuZFz
	 GLWnNpaEhy4XR1IBD0poT7YJlxu2cPoeEWNn51AwRSI1YZ2OQSRluklzbC2I/hub8fw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792763566;
	bh=7xX2gKagSUBvZ+dsAi1NUa1T9ybCAiN1NSx6inwuTp4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=02gWdcKUt2/9aI0pSZnfQUHwd36+JxdqdXm37meoDE7MlMA+t0UeelLO/2NSZd8kl
	 qb0JBqF83UdzYK52pU6+mUaXr6I8TQg3WUPlFsMKcjukh4H1MTqjh+Qzlh8kjlS8ra
	 E23ZQtu1DYGJ8S12g4u78MhCw7iWh8sv6miZ3BaNa/Es5lB/kNOopwRAxtsZENhPhk
	 Lbe4McnPUy9R2KPvOSbJZbdEtFkbUd5Es94Ts0K53LWqtDy5gyUalqKpTrAc8JbCo4
	 EI1o6+GCzFxqF52w6XXGjKpEGkwLeoWph9aJrYkwiVk1qPraipKSptkUwTaQU+n+HC
	 M+21Zo4mF9fTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0942814A0;
	Fri, 23 Oct 2026 13:52:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 281483C1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Oct 2026 13:52:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0DBA76070F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Oct 2026 13:52:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lIBSNYnGj8Dm for <intel-wired-lan@lists.osuosl.org>;
 Fri, 23 Oct 2026 13:52:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3F7E3606BF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::122f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792763563;
 b=rdEM2ARkrVSuLIqNZReRVgxpi9o/UnMdzvBvb8yuXqFgL35KbJ63QA75S90dRW2olzqH
 CzZ2WJ541j2wwtReB8kMdce0sdLfD8kikiCTnB/KenUhtbKLV5MxdteKCm9T9TMKczIi8
 N5xOIRF/1gBLoAUx284e1HQ3gYmU9wjbqd/og6mk9Kiu607Ta79InKpTjHBMrRftVgX6O
 XJnLvniTTzL3qTCqVVYxXsna2tfFpv6aAZsYmfqYcdtHxFz40C3S65VSrjK0vpQ+MYj87
 iA99R6fVz35l9y49CbqSDhZwS7NmqWEnJGFmVuM50FpQV/epARacaAHY8+PEDC4Kd+Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792763563;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=7xX2gKagSUBvZ+dsAi1NUa1T9ybCAiN1NSx6inwuTp4=;
 b=oTq4VJAgADP4q+n7ZgMTJm18jM4jHPYJcr1pw3+OUGVDOPQSC9tB3RqyCMjsKLWOSbxq
 tyv3/Ix6nGQI8NPnIoxSYoLwyy9kk3/xGjR58OAkA2OLXPQBeuAWsk++FVTlfSfCQJeod
 dBodiCB8hL5o5RqQCNC8s8x1RyVwxEX/hYhGX+GGRXLx9kM9/R8ZdaY7nE05OTDSuIhAo
 UZLLwkolC8K+eqBi0KtMHR0UQ94ubPLxY/GqJ8K72stZXRKQKlY1tctg/cT01iTS0eqWJ
 GlP6/tD5Os9Gr+jlI3/h1YoPpC7ogGSIhrFgyJIEAYUGyJGfbzmPQGTHPgPEJGuiwFQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=google.com;
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=VJwGYLKh; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::122f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::122f; helo=mail-dl1-x122f.google.com;
 envelope-from=lrizzo@google.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=VJwGYLKh
Received: from mail-dl1-x122f.google.com (mail-dl1-x122f.google.com
 [IPv6:2607:f8b0:4864:20::122f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3F7E3606BF
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Oct 2026 13:52:42 +0000 (UTC)
Received: by mail-dl1-x122f.google.com with SMTP id
 a92af1059eb24-194d0c31715so11275c88.0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Oct 2026 06:52:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792763562; cv=none;
 d=google.com; s=arc-20260327;
 b=nLpS3ER/oXS32z/cezlnTk4cY/frwy46QPCLKvEmZpK8BSTJ98P/jTrMXR8cl4mpHL
 M4l7xqopsHwxo8lUnAVyNj+2xAEj2El3Cu5KnkarOKO5UlKltNgVd/UExyaOUC9yYiWn
 5U9XOXPfiyM1lDOPJySrNA+mRgT6gVjzYCXqOnWwhvchN36mZcM6jaQvXR6NcKHSg1PS
 /O1nMVLYJakVCUoirckQ6Ycl3l7hqkKAJtvcDcHVC61WG+Kp9wo9DEf5xEWlpEcmA7Yf
 BPyJLqdGGgg81ggFVFJcidzLbLFVZxu2us0U+mItx6I4gsMbhWfHbJVMp9D8W+t8+3EF
 UD2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7xX2gKagSUBvZ+dsAi1NUa1T9ybCAiN1NSx6inwuTp4=;
 fh=HgBva3Qx3FhDAmsoiyeqxhN/InxxWWhzTbfG4zVbXbo=;
 b=V1THvq2QuhuTMceXPuLt61eD0JNIYrjkrLwpaXtFVnEPhS14UKvMsGL+8ORaHgjUVw
 ztaBmBqDHuZ+sdyOxiiCqf0Ef7FwVCTb4tZ2DiZmo4yY3fgQ6EsQY+THE0vXFqSPaX3g
 /73laW6d/QJsLcr+tNttczKD+d56/OCC0GNJgUahQ6ZMK5V6f7dKoU6rpohzbWHun0ZR
 8x9X8F6NCgFI0cD5N+g5a6fK5RIiKLyNdFmE3Rk2P+Kg/95Ndph9DOJeJwmDJ8Wz7+cG
 T0xclikgXCtr0Fi5ME2jQKLYR5nkzwnucIl3fW7K7Pin/dnD1XOBLpzaq2n0CsoN/jyA
 2Dqg==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792763562; x=1793368362; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7xX2gKagSUBvZ+dsAi1NUa1T9ybCAiN1NSx6inwuTp4=;
 b=VJwGYLKhPkeUmBucayBUuvF/xjO2G7Kz9b0DXnN9SBOrnEs6px+90WmHCUPz5e52m8
 /os1JuVtqmj/C9q2MF3EDLc4q8aUNGYyvHKgZ7dCKv7EG0p8KBNc4xH/NzlgHy9s1WV/
 +cjnAVbNtWv6JY1jETjZyZtsHXrxuNJBWn+hn6eGH88NJalpoaPdbYGAdIah6DK0lWy3
 PtusDh3xC0bUOH8r3Xkf+hv/ScJeRFLuomiDtY2t/jV/v+Qtlp/XPnjUU5KhKiPJn3yC
 NfhUnbYciq3NaCfgXBue7GKJYOLJWrsUKgkShQCsOhg4v2ds9BgweWsuITw8SfeUrygx
 u0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792763562; x=1793368362;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7xX2gKagSUBvZ+dsAi1NUa1T9ybCAiN1NSx6inwuTp4=;
 b=tj/TXDB1F/gq2EFG0V/7YKq4XrFqht5MtybK0MuEBMnRKcrgX0gEE0+4nzBJObFy0A
 u7tnS8/OH5koaY/qrvj38GtxiG4AtWJn0HMM/D35c5xIbzAVGYVNb+67sWM7qePvWOVT
 2LKf3rGg6daxuGowO9FX/g43rLfC192Zvd5rsxblLpzMh4E2lxpU7ZA0YXstrH2gtD2C
 bVMraCe+1UJKWiikCyUAHvcZqOilpVNz6ZLzWXZnIQWzvLUDlMRzrXEb2noH0PpbKt7f
 8r1w1LiXOiJBwK1gOgJ/P0zHPVAu5/86OIC8xuKz1G4JPwEI0oe8k7/QLzhP1Ed5tzfh
 IGzA==
X-Gm-Message-State: AFq9FYI8nEKOOBnJvcKQElNRmYTrP6aK2ZjnGcjuG3r8YkIPsMyzLAXk
 wE3xSlF30ZCcpD6URZ4p9fZ7omGNRuvG8p1S/YgVgqnd8kQehOj8yNw81b6OQtmxzhpMwnhSBBs
 wDzXJzyU0/DoR640+Psxa+lV93iE6jJ3cgpH2DGBr
X-Gm-Gg: AYBFou0+K9E94jVkG9VC8EddasmsNaQDDeO/AZyiAtlUBne5jY/UBvXKzgx0OaEJIYD
 1HhbBT+cSSavDtHkHYGMugjUM5+mJuEdAYoh+z/o9llieGVcJkQxTVo/UpUKYwsT4+4tMUCuSy1
 7F7NKx3voNxz5lxgHs2Nzo6lzu2M0Iv2CQ2rMZ+9/i83dpMokaio7KIfxuNL6Vp3/2NwVyXj1jl
 1xCm2hxlLIk7WJmUyAuGe9wbWjfCaKigew1771Gfxetx/WyGHx1p9SE6674umeEkepyvcrz8QIg
 xv8OvL3HIowZiHKuE1JDQS8HPZkK/mALI8tK9ZKDwqqGfq4UvhLYMWQvd3HUDkXBYPubhgagJqr
 3eMpusWe5mA5Smj/5rAej/OkBYDx8WHryNlMFqpTyNystTqa8gbccrOj/pzQ=
X-Received: by 2002:a05:701b:4286:20b0:139:90c3:391b with SMTP id
 a92af1059eb24-195aab5d822mr340982c88.1.1792763560566; Fri, 23 Oct 2026
 06:52:40 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019210604.2433620-1-lrizzo@google.com>
 <20261019210604.2433620-2-lrizzo@google.com>
 <90e0df20-126a-4429-83a7-77f95234cdd1@intel.com>
In-Reply-To: <90e0df20-126a-4429-83a7-77f95234cdd1@intel.com>
From: Luigi Rizzo <lrizzo@google.com>
Date: Fri, 23 Oct 2026 15:52:03 +0200
X-Gm-Features: AclHuK8IMAai5WBO8HJ4NB1eQHErdtx-3lINsiz265g3x7G0go6ka2kn-9-9jcE
Message-ID: <CAMOZA0+pLt6rsoc1RRO3-TB7SNSUVbEAnMOitDrqygciVvUu+Q@mail.gmail.com>
Subject: Re: [PATCH iwl-next v2 1/2] libeth: add libeth_rx_alloc_gfp() to
 specify allocation flags
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>, 
 Brian Vazquez <brianvv@google.com>, Joshua Hay <joshua.a.hay@intel.com>, 
 Larysa Zaremba <larysa.zaremba@intel.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 3:35=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Luigi Rizzo <lrizzo@google.com>
> Date: Mon, 19 Oct 2026 21:06:03 +0000
>
> > libeth_rx_alloc() calls page_pool_dev_alloc_netmem(), which always
> > allocates with GFP_ATOMIC | __GFP_NOWARN. Drivers also use it to fill
> > their Rx rings at open or on queue reconfiguration, which runs in
> > process context before the queues' NAPI is enabled. There, the caller
> > may sleep and GFP_ATOMIC is needlessly restrictive: it can neither
> > reclaim nor compact, while the initial fill can allocate tens of
> > thousands of buffers across all queues.
> >
> > Add libeth_rx_alloc_gfp(), which takes a gfp_t parameter and passes
> > gfp | __GFP_NOWARN to page_pool_alloc_netmem(), and make
> > libeth_rx_alloc() its GFP_ATOMIC wrapper.
>
> If you'd really like to go ahead (I'm still not really convinced, even

To be clear, GFP_ATOMIC is not a problem right now, but it becomes
a problem if we try to back the buffers with 2MB pages as in DMA_PMD,
and those 2MB pages may not be available without sleeping.

> with "O(100k)" which is not that realistic),

On a large system, which is definitely the target for a 200G NIC that uses =
idpf,
we can easily get there and above.
The system I am testing now uses 4096 slots per queue, 32 queues,
meaning 128K entries at initialization. Under load, the pool has grown
to 197K entries.

Ok for the style changes, will resend an updated version

cheers
luigi
