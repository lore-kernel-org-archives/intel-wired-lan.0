Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD7F606A32E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Nov 2026 16:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=CsfsQ2mU;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KyCZQU2S
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5B2C340A01;
	Fri, 27 Nov 2026 16:56:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nNVz21G4-HpF; Fri, 27 Nov 2026 16:56:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BE67A40A08
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795798594;
	b=mkGe+yAJCscST3EbqWxcNHQbSMuihkg23A3HIe48LTWA6q4tJ/QYeT/XZu+NzXlmIi5n
	 hw6InPnn2YbIyQ5JXucY2dWizPXAgx0R7TcRCgutXqtf0xwzqwwlTgXA9on4NbjODySrq
	 eoSPorBiQ4ya0AFPdditGVR1J7/26he3wIE0OjztiYSOZnROj4q/N8NSz3aHMDedBZXY5
	 CjAUHdY+92LFDkxHxvFq7Koj2V/6kGbsUaB6WPvOpYChPj5WnUQWavMKrOMosqpLZ25je
	 6YejVT1V4zDEHwLxRLTpDeoLCXkqY6K6nyzuClIWVSC6FRqdFipB3qBAcpPlp8wrQxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795798594;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=V9s5cE0YFouh5jmUZ3qtfKF7Wf5pwrkzWs9hUWaorfQ=;
	b=Xd9iWMy3EYS+Ogsxd7tYQFKYX/YMsatAXi0BWe72cZyGTbBdw5z3MtrXpEAEW2BCwYGn
	 pim07JZaPcrB5P9qcz9yc+sjXuHL0Z1YA0JTHM5bsVfgZ7rHZx0DV9X+IONl/nMsozK7e
	 EqL+aLSLrDOAsBt1EDyLUBWOLX42G0SlzDu8/Mu9ZwjvbRi+QKz5umqTztgSzQO1ZGDtd
	 gFoLCDSupmHqY0ctACxYQIwhSASbStSsnFYaR0Z1rs60iKhSAa4PGZoSF/RzmjPaYq710
	 j3Ef0GxMpj7Dm5p296ZgkSnAILq/jufOVK4ov22fDs768WqLfbvIDiF9v0Le6DrQiSw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795798594;
	bh=V9s5cE0YFouh5jmUZ3qtfKF7Wf5pwrkzWs9hUWaorfQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CsfsQ2mU9lzVL4fZFHDnPimy4OKf9JKYTbDSbZM4t+hgY9oE2oboqRg1F4+ECRvrJ
	 Zk86ZB2mkps2Oy0Iqu+DK1Qt3I+xA+GykmxHOmd6pJmx54lgedGc7gBOXfu3c+80p0
	 GSRWmumgJ/nrUFXWsMP6n6/+MgfbkD/g2iwNo6KoCps2qxakcEIQlZQFODErhVM2Tp
	 M1t/GZkgTZuozfRjRTujkVgRsQfyXzWPdboDylYe8mthk9DLKCLPPsMjkA5HRiJcLi
	 VWb6N1Ybwyb5Pmqrgkd+QG+pkUx+t9WnGAscUcz8+4WFVa1LpySNmRKwVrt5aqobMB
	 BrXgqndHbT1NA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BE67A40A08;
	Fri, 27 Nov 2026 16:56:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 62F2F3D9
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 16:56:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5489140623
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 16:56:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wmrQQPekIOAF for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Nov 2026 16:56:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AF09C405CE
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=bjorn@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=KyCZQU2S
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AF09C405CE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 16:56:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 89535456CC
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 16:56:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD4B1F00919
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 16:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795798590;
 bh=V9s5cE0YFouh5jmUZ3qtfKF7Wf5pwrkzWs9hUWaorfQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=KyCZQU2SVeDwJTlBmDrV5q5aW3kTlp2vieFQXURgdUmjfX2LsU4A7jOcjE7MpPLNI
 P0JbeLJVbWFjFVEWzLgC9oddAsWqKuwDr1sVwH8Alv/+A5XSvCNy7wvuiLsMJdoFXh
 6SmYFUZfvuwiUWy6+q5yDwIAajDuLkAYTDJpaCCQl+jpfzKq1tYFBQJ8DU0+6kDyuf
 n5GvkH/ndwuENOW8JA7nQWg/G1ADpFIOdkePrL6fWSqWGh3E9GCmUQBVACHGEfoAr9
 PLVfOLkz92eBxVsrXmo5R+YqcpxQ1CrsddDX5ELDIPpWnXv2aF8nM1ut7iFFIszPsK
 VyCNDx30WRh/g==
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-949664ee41cso839019885a.3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 08:56:30 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErGygsRpXS1VKCRXGAAhn3iDAHCoxgM076kRfjvzD9v2V8KIvdn3P2hGAH37T5w4AxShS6ujA82qeTyHW5jT8Jo=@lists.osuosl.org
X-Gm-Message-State: APuU4Z+pjtllPz/si7QjnLIab0kssxIH4w3dq9EVYm9TJnQQT+9jIRou
 FxXQ4sOpzb73lVOWowbAH5eMK6WANTTZha7bisU8SfK9rGQ33fPUKP1grr6Bsg4JeCuwmYRTSDN
 IyZy2lAo4BfjSYZNtT0OAIwYjHZdtVFM=
X-Received: by 2002:a05:620a:649a:b0:949:752d:31e6 with SMTP id
 af79cd13be357-949bac8557bmr4188486185a.79.1795798590170; Fri, 27 Nov 2026
 08:56:30 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261127142131.3527737-1-bjorn@kernel.org>
 <20261127142131.3527737-4-bjorn@kernel.org>
 <awmmhuuailYkTtLu@boxer>
In-Reply-To: <awmmhuuailYkTtLu@boxer>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date: Fri, 27 Nov 2026 17:56:18 +0100
X-Gmail-Original-Message-ID: <CAJ+HfNhwOrsGZoUz4wYokaGOOzEeCTAdkVUtvY5REV27gkbDww@mail.gmail.com>
X-Gm-Features: Aa3M54rS-Z7TnayrDFO8SKtWi5cnEqowLhI7xQRnBgqe0ZPhgLbFwKqxRVt_Mys
Message-ID: <CAJ+HfNhwOrsGZoUz4wYokaGOOzEeCTAdkVUtvY5REV27gkbDww@mail.gmail.com>
Subject: Re: [PATCH net 3/3] selftests/bpf: Drop the zero-copy tailroom from
 the xsk tests
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>, 
 netdev@vger.kernel.org, bpf@vger.kernel.org, Simon Horman <horms@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Tushar Vyavahare <tushar.vyavahare@intel.com>, 
 Jason Xing <kerneljasonxing@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Colin Ian King <colin.i.king@gmail.com>, 
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 27 Nov 2026 at 16:49, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Fri, Nov 27, 2026 at 03:21:29PM +0100, Bj=C3=B6rn T=C3=B6pel wrote:
> > The xsk tests take the size of the shared info off the UMEM headroom
> > of RX_DROPPED and off the growth of XDP_ADJUST_TAIL_GROW_MULTI_BUFF,
> > as zero-copy multi-buffer pools kept it at the end of each chunk.
> >
> > The previous patch moves the shared info into the buffer pool, so the
> > UMEM headroom limit and the frame size no longer leave room for it.
> > Drop it from both tests.
> >
> > Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/prog_tests/test_xsk.c | 10 ++++------
> >  tools/testing/selftests/bpf/prog_tests/test_xsk.h |  2 --
> >  tools/testing/selftests/bpf/prog_tests/xsk.c      | 13 +------------
> >  tools/testing/selftests/bpf/xskxceiver.c          | 15 +--------------
>
> This is based on old xskxceiver location, would it be better to have this
> one send to -next out of this set? I assume the move might not have been
> back-propagated yet...so seems we would have to double the effort?

Ya, good call. I'll pop this out of the series, and respin a v2 w/o this.

Please have a look at the Intel side of things if 1 and 2 is a good
fit. I'll spin a v2 when Sashiko has spoken!


Bj=C3=B6rn
