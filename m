Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95309606A32A
	for <intel-wired-lan@archiver.kernel.org>; Mon, 16 Nov 2026 23:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=lC19JTBb;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=e9BV/tRZ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 67A2A80D58;
	Mon, 16 Nov 2026 23:55:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HuWbJ0vswPA5; Mon, 16 Nov 2026 23:55:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CB6CA80D8F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794873357;
	b=MIEEcc2GxYk6JOFPePEC5snu6890pJ/cfEgi7ULwH2wJBiQVZt0h+ENKjuU1IMaLGeg5
	 QrfuZ5PFZMf8icgYoIXR3H2d06b+9lQhBTznNLPQX8bZmovv8NJkfkQk8q0fGZtPa1sD/
	 AFis8Hh3rRm+NkJtsqMeuVADWPhhgiSOMZrB7qHZeA1TO3Cm3inhimypoIN318Zfx++/M
	 e3GptfYfdCf6thr2OlQGZlcyNnEMr1X2Zkb8mYELrcUzFiz2snegEHojiedYyapgXC40P
	 C+HqsBPOSDTh2pZjaMgTLXXMeCtmiNHV74lur36XP84DJWHkP0S0YWBo9slHO6xx4eQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794873357;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=pBcsIqN5fGPsZcVWkz3kK83U3k9KWzXvm7Zsz1tEHJk=;
	b=QWtv/na5DF2GO12VBM3NP8rnQwv5wYVzt95H3rWZ2N9fDyWZFFaMMMNwUnXJyWcnAlDJ
	 rgr0J9nnMc7GloLdpWNnWjClwVb/nds8zN8RuLnyDIeqBOzJ6EdNbBpCyBTKNFo9OsiLF
	 wyRa6TUSV0ta8JQ89JqgyAEM/stAdR3Iv0t2m2D88UhAzt2KEQ3xWP2vZl4/ruS9E67xK
	 MEvFo54r0c73p/GrGznbSb8zRurhDJ3DcZi8pXRuOC1lileIMXbqTFc/F2jbfIZg+R4eT
	 F5F87BafQuVRbyBDeDZDdOPwyUh36PjKv03Pk58zMQlnooLcOqxYBOaZoShM2npw9SA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794873357;
	bh=pBcsIqN5fGPsZcVWkz3kK83U3k9KWzXvm7Zsz1tEHJk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lC19JTBbG1ghywdSlhMzSA3wFH1LS3MxaN6baLrdTtKouX8ogMpVDpVeS/WITYoES
	 eX0ORcN2zd9O+P+HgjYGUnPMl5yGWNJbtWltfJXn1JagYoTPvX/rGOH0t95n9Vyw2s
	 Q90Y1BMddnOQnCP7ewNvdnhDbXS66H2XDytDovYQtUuFq5uxVpyzAJRUHpdaFFIFB1
	 OMq2OExLVaBv9uG7x8++/suo1LQ9UHwey4rjcS2hZLQkwz3zSP/46BgTkHd04TheAI
	 FK++agNRuk6lLqLHHwjNAJg0Fib+GIbiE82bV2Hfh54oTDhL3p7vh18DQiJfGOP2HM
	 AYIE32f2dpsnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB6CA80D8F;
	Mon, 16 Nov 2026 23:55:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1BC201A6
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 23:55:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0D1C260774
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 23:55:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EJWKYnS9DZQT for <intel-wired-lan@lists.osuosl.org>;
 Mon, 16 Nov 2026 23:55:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F3946605F3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2001:4860:4864:20::31"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::31; helo=mail-oa1-x31.google.com;
 envelope-from=tianyi@cloudflare.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=cloudflare.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=cloudflare.com header.i=@cloudflare.com
 header.a=rsa-sha256 header.s=google09082023 header.b=e9BV/tRZ
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F3946605F3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 23:55:54 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-43bf9548df4so5386406fac.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 15:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1794873354; x=1795478154;
 darn=lists.osuosl.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pBcsIqN5fGPsZcVWkz3kK83U3k9KWzXvm7Zsz1tEHJk=;
 b=e9BV/tRZr29++1OrelGmjcBUE1vfyLDf95rCARG0LK/x6T+WALAAtXX166jJ6f4vp4
 U1hqecAflhbubgBYve/IfmPEKH39pVAl/AuIuVgRj8prd8dfpbiY2coVdgAvKEbD7Hmh
 bq4sV3K+NujixfC2sWUVkGwU4I/qcGexvR2/N47k++VwykCBLhv08vqCXA96eV6R8wzS
 ZKjH5l14dyHKL8oPqZ6bpg1xgzl1FLyH/7hUJudnD48+LJfChrtw/45B7klfovPbflhf
 uhOUi3LIfzM5A9i2kM2p65+eDc5svQfLKrmQtodd+G/Te80/zp6uRrcz4X+GxCWBA0HD
 dmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794873354; x=1795478154;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pBcsIqN5fGPsZcVWkz3kK83U3k9KWzXvm7Zsz1tEHJk=;
 b=v55mYffkmN+iG3ZTgSNWHTgEI3KEj3mq4uE/E4Rxh85VBLvahOVFvrs0Ej6mqgiigc
 58tPZ1t/gLVJcfCyj1FBlWqVvcf0jxo5rkDWc5UFUVZjc2hCzp5F4ctzaJyhRQ/QB2+c
 My2LTYydPRB1S+2jeX3zJ7bUYt3qzJRSeDCB9jz7F+QyfA7zUQAzL6uCqxHQ83fN0Ilm
 C3SdofaGGiw4teFPpqjxvVZFoJ6FFXQJW/8sHxCZseGaz94eK1VfxkHU4frY4JUbuEZ3
 VF8FwPGI3F8iHNA0lpyLt3YH2UW9wGhGcd94wtSEqGt+u/4NasIOsamCrkg8lirUU/pP
 xmLQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHgHGDJH9l9YMDbH9+dKfmtnY0gucQjst/yi6Y5vYeZS1eN33EOuPNPUjolYiqc6ZZqMZHBVY3KtUJorObyiB8=@lists.osuosl.org
X-Gm-Message-State: APuU4Z8VLM/KP7bOuhhSuzi2x3w+NiQSE7IS5jYukCiC5cdt/J80dcoi
 ryIlXZZp23Im24V4OnmYcdTcEMabtwVqhOSzItwQGKpLkvBehmhwGMqltLJOF9gSTO0A1hq705R
 ohWIc5MqkDxn5Q1jtroPqf4FMxpB1E7AYvHjXAPCJ8A==
X-Gm-Gg: AYBFou01/XfwUyaqHSOsIGsbBR9bM7haDC2AX1F66yArordLbwbqCODwWP+8khuW/gc
 mFSsUxwNpiF6R7tgLe3j9SmcDrW3bRUQWs606L2ATXf+wn3Y360pUaavJjrolFNL1MsbL9ehDSc
 3bZcIdo1oxXkXVjCLGeaW8mBAVQtyaLWlIKXIK04X8Fv8jrhqVkCzyGvuhZeYtbnkze1mdndoNz
 sj6XBR+b6tvi6Bqbtb7WPZup1k27xGDPu6m2K/oXRPq7peNek76QjKy6TR3Zc6lr+qMzkaTBX0l
 0wy9M9IYnsAiDCGFZpB+PVfrBgE5cmZI7qvb/xMjkA4ffvhLREVwMvAF8aLWGXFqixDF+SaX8sZ
 SbcrSWI+EemMsIajkWL7hGte6YtGj5i+gEmVLVmHkiVH9WebUWyMYZHBS/703LGq1J2yPEHqwgw
 YgO2OkK1agUw==
X-Received: by 2002:a05:6871:b2a:b0:494:b8f4:9a22 with SMTP id
 586e51a60fabf-4afdf70bba7mr10365207fac.28.1794873353687; Mon, 16 Nov 2026
 15:55:53 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1794281983.git.tianyi@cloudflare.com>
 <avOvI8xrHI0dwyHj@devvm16445.scu0.facebook.com>
 <CAG4wq-egD55NZDw+OKVKTKN2tQJ9oKEC504wFv=xoMXyJ-0z4g@mail.gmail.com>
 <20261115113902.4834dda6@kernel.org>
 <CAG4wq-dhd5a5zxQcSShaKifYd2z+pMpHaCYtZJRX1QCxEH4dfg@mail.gmail.com>
 <20261116142710.347e8571@kernel.org>
In-Reply-To: <20261116142710.347e8571@kernel.org>
From: Tianyi Gao <tianyi@cloudflare.com>
Date: Mon, 16 Nov 2026 23:55:42 +0000
X-Gm-Features: Aa3M54oRvcr-c3A5HCcCKnOxqAqDaGkfnfsAP0Ey0SL0I7zgF2gu0s6ZsVqnle8
Message-ID: <CAG4wq-cDYa2GkpWSYeOLwEPv45BtucZk+r=N2b1Srd=gUUO4MQ@mail.gmail.com>
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
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 16 Nov 2026 14:27:10 -0800 Jakub Kicinski wrote:
> The question is _why_ you use it. Let's leave the cpumap case aside,
> you provided no legitimate reason why having an XDP prog in that case
> is a problem. With veth - you are right that attaching XDP causes
> problems for pure skb traffic. For veth cases, however, there's no
> strong reason to delay the skb allocation. Hence my question.
> Why not let the driver allocate the skb if we know that the
> redirect target will need to allocate one, anyway.

Sorry for not being clear enough.

On the setup we want to build: an XDP program on the NIC does the
decap for all traffic. The services run in namespaces, so the packets
must be delivered into them. Some services attach their own XDP
program to the veth, and some do not. The host does not control the
service's program.

For a veth with a program, the skb path has the problems you mention,
so the host uses XDP_REDIRECT. For a veth without a program, we want
to use XDP_REDIRECT too, so that the host delivers to every namespace
in the same way.

In a minimal benchmark, pktgen sends UDP, and perf stat counts the
cycles on the RX CPU. bpf_redirect_peer() from tc costs 3% more
cycles per packet than XDP_REDIRECT with the checksum status kept
(mlx5, one extra __netif_receive_skb_core()). So one XDP_REDIRECT path
for all namespaces is both simpler and cheaper.

> Since your patches are not a natural / clean extension of the existing
> infrastructure - we should step back and make sure the use case is
> practically justified.

Maybe I am missing something here. XDP_REDIRECT into a veth works
without an XDP program on the veth. To me, it is natural that the RX
metadata also reaches the skb on that path, without attaching an extra
XDP program.

Thank you for taking the time to look into this. I would really
appreciate it if you could point out which part does not look natural
to you.

Thanks,
Tianyi
