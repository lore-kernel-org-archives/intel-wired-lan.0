Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8C6606A31A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 21 Oct 2026 19:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=oBMcr/8q;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Hsng/zYE
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8912340900;
	Wed, 21 Oct 2026 19:11:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 43kd6tU_m3Ig; Wed, 21 Oct 2026 19:11:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9FC8940AAA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792609885;
	b=htXBhBXGfXLtXDbdt98VfUqEqpd+cn5F/lv2tJKemkI0SU/CBuK/TNUB7VOpadTjeuyL
	 8GArqK3MYRf7CGaccnMQ8LPw5Mzn1D7sq9peItP+VHN4y31/KWX+/QsvvYyYFjJ3CG+r1
	 edrhB/sYFS2js1DRm26RDOQQ31D4/dB6T8lLqmsgueV8cHqzg30LYNSrBM7thjtIpMMpJ
	 LGkZNyNqmL+Qszi2w0m7+rY733Upr93ZlcSY9ahkOx3T56QRjWPy8iHu07S/37CM/sFkw
	 wWmUEehuPHcOrJn/HqU3ePRXHWJRj5bOk3ZUHYl10mjeuFj9xKh94foEZPO7/MF5ImA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792609885;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+JKXqhdtW6oX94eZMED7N51uhKdO+qZKQDvb/WZHHvU=;
	b=npKOxSnUcsEz6i49ttYu3Whz1fQMXhBfCJr3C6g7p/m4t2WuVNWC/W2kqOlZl1pgNsqy
	 xHhBy+hluQOJSaOwc0ZKT34Yeay27++C1WOT3GURfU+/pSq4IFwIvyv7ROTPbNCSmC+d5
	 SeXn1vUdf47UiGkO8Os29Q/6hQzDFipjhsdn+DPGU/4OmSDRiBEcF/3wlugxtGcNCXfZx
	 BqpL7sMrA37ZzEUFGIqsEPJEFjJa3aCo/l5FcD0aFf9E/2TasjuTSXmeh2xZtzkq79CjW
	 kG3+4S+dYq5pnFy0bKwSnw+ndffS4BwvRPcLKgIvb3cFRRtOM71xNlI3FeKzwbqDG5g==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792609885;
	bh=+JKXqhdtW6oX94eZMED7N51uhKdO+qZKQDvb/WZHHvU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oBMcr/8qMRnW/wUX/yWZm/5Lfi7ecA8yEIZaLbd4Lypl3kZCtKZi3kPfe/y/F4Yqp
	 tq0mO5khrfljlZhrNCCKta8W9pLuRh7Als9Bv9QHCClUz0Lgs8Vg+yF2D09m81YC6Z
	 e0jMkrEQGtREnftMq3tJB3DaQ4XGu4vqBNQkYqDhzn+WsW55XNeuFiEdE9HolSbUYp
	 nYgtze3rnQfR1NcXlkoKV3YMegcDiAo0l+7Z5+xOiiAOKCMa3evZgfelkxioJsKS9K
	 BUHUIo8wggN6qyLfAp3NUX90C5NPjcCBzrpXOZJ7dTy7fyJ49kpxZ6ymfdrat4lt9V
	 EkiBzLRTbOE2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9FC8940AAA;
	Wed, 21 Oct 2026 19:11:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 974D93A4
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 19:11:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7D35B61ABA
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 19:11:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o1h9h5utRe8F for <intel-wired-lan@lists.osuosl.org>;
 Wed, 21 Oct 2026 19:11:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8B474617AF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792609883;
 b=HLdMhGKOMnYihQn1N5ubgB7n0KrPJ6dvqHRQu+jl54Djbsi58RqCAKDgnxAPf5EPFXu+
 lMbapuus2CR1PmO/2lsVa1eYrZp6rQo4/VoJfGw0bL8dH/humFK4t0466DDjHoh6qPAy9
 vzxd2ZOb0+qTBE+BQ1YZ2v92T1n7CgbiqYUdRW7u6jP+HVGrZgJIJnyI9gQwlBlfqKiVJ
 0ew3gF6xWNfWw1/cHCxVTp4nVwJj9lHn7IYQzTqt+PTYvvo8L3cAeoxazInyMvimHIros
 alhTMNTg+Aati4PcfohgSNNfGThzrU/Nq9+1kxmICcPi3brdLcHNzNSs2rmGD7SV5FQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792609883;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=+JKXqhdtW6oX94eZMED7N51uhKdO+qZKQDvb/WZHHvU=;
 b=G4IrYDgNaHtD8qzSNHrGmbEQtIol5XSMP1B7Zmgy8c6YQQQhS2vX5z4sOiRaQIgrM/Mv
 WaywAqBCm2NBn6DCeAdsm3oK0NaimF0CwfNqWtNX5Fh8bqKuvwPUXT99hSSy4gADw7slT
 G4JzGzneaqokY5f9T35o30/YKBy6o79oGS0yn0ovLJ0ftYPjySlKyEeHRszawpHF91bSK
 iS0Vhh+ciw38nWLxeD2IjnpIklCOKqQdYsR4Z7GMNNA9O0pjO6KnsmbgtqWN6u96DpFCi
 3CmYmCTV84K+ankH9aa5zJ7GUfueZISiE/1XxrA8z8tqSNDM0JN8/korHGX2NCrEooA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="Hsng/zYE"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::62a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com;
 envelope-from=andrebrait@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Hsng/zYE
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8B474617AF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 19:11:23 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2e98798cbddso5353445ad.0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 12:11:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792609882; cv=none;
 d=google.com; s=arc-20260327;
 b=igpgbg///8RJtxg6+GaRK0l+KyjkClIij/DPG23L5VqSlPtPc8rEvdEuCfCmrW6Hem
 Hu2JfNVQ9BfLl4i2Xa4dbKa+/Id2h6sbHtyq4JYWIwRtZAqWvpg0k60RfjdFB4lndvNN
 deiQ5RVXUycMYsZLz2GyHG7p3zTFKfyiVvMwNQY4Nwe7CKR5Wz6d4kpx/Cy34XNXVg+P
 y4LlHhO/g6ChL5yrNhFroiswuj4S3GWfH5tOz06rMCZkQ7a/172m10bHSiS4JrPwulfJ
 2Orri9osvlhHyJGjZNsdW80PMkjGJmaTDD5rfnATXvz9n0Pt7HHvMlIWTEL42TRts+2h
 J1jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+JKXqhdtW6oX94eZMED7N51uhKdO+qZKQDvb/WZHHvU=;
 fh=/1ZgaczbI2PME5EUZDsPMbR5Ipx0oUs6joucYMKReaQ=;
 b=QCcXJxuIMhR+ZxPQOlPXudtNl2Z8CcI2Fig+ohFcnOjMpX/Xw45iTolm/sGclZMVIB
 Y7dZVxumjhHF6T3PCHG0muTU/LFBqvTaVC9c+JiyFAIVp2jDMlo4ZxAejlfIld9ou/gX
 BeWfCu5sddsNgrkv7gEgYKt4RNIK/Qj0ZM0mrBl+aeCBj5FK346rk4JBbXZ42kLaHVRJ
 qcwX/4qYELbbHz3SuFuPrFR0WfbeXqn4KA8gA8iqQHhUOBGhbZIpZazAGD/d5WbgUyjE
 EhujbyZ1Ygua+4swJHFUuxuDXUtJL1SSv29fygpbIB76yK2e0wvO9JoPpKou67+pwKp1
 tkoQ==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792609882; x=1793214682; darn=lists.osuosl.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+JKXqhdtW6oX94eZMED7N51uhKdO+qZKQDvb/WZHHvU=;
 b=Hsng/zYE3+A7J93ZAg4I14Ox2dlvz5hUXQRx6mTY+nL77tqSjt+A2VEFeryZPAenYe
 KX1rQNvmwQagUE2EhF6SkTSissZvdckFZyy3zPJXZc4CpO1PxpXzUfLekom2X+UEut8T
 jkfg5q6L6ooPXB2ebXb22VBtUjMhij1Z5mPAJaeKIt0h+w/ZBSxsxQr+D/Fz0/NhUoEU
 xvHxDD8/3ARCn3NqMOV1TBZ5gewaeZG95NZ6B7sjAUId467i8M+vVj290RcO7XVpLJRe
 1KibjQ3gOreTcUFF8TAmpXTbhChRsp8qC6gfdUzyuI176vH+74yqlAjrmu7t2hCwUyIA
 kMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792609882; x=1793214682;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+JKXqhdtW6oX94eZMED7N51uhKdO+qZKQDvb/WZHHvU=;
 b=JiRvD14Mju56eTj/lqrIIxANaJWFeAykbu4a5O6Y/FFLstbL+PIf57zi5nejXB3u9n
 FilbATWlGxhPHKeBXGovQV1N34YF7v6gwvfy7IzvFT1h1EUUpy6fW0HpIjHFv5z2DXbc
 lx3JuC8ubzj9gQjxwhBicysQrqtdR2QGeMaAvtdxWAThu1xRcu0pYHfYYevcQuNxv+ND
 4ERq8bjkk2bJoqZhydGQ+ltOzWJg5VRpqlRVe+YM8cFVkbW3a1yZp4p3JRfJnXvKdxCx
 7E+Hn+6sotubp18wJ0OnFSGintViR4mHSDWlQybmHtyRLcAi9UQqCkyEzoajsv5Qj7lS
 NpXg==
X-Gm-Message-State: AFq9FYKfLF+uSjSRQPdrY9PRlgdjFa7OQob6G22iZiSRAjmKaz8jB3nf
 NoC51f3PcpkfSg7VnJPImYO9Us34qC1YxbwpZHD384p5zkfov0n/UNP1aQMaeYXebCA8aZq8apO
 uKSwfV0LLRE/k8IbUBC7DItrOw0GBVn8=
X-Gm-Gg: AYBFou3+83d3YOIS4iZylD6sC+mb7hAGfmwspcuayXN9GJ2k3dkzCJssAXlyhzG2ccQ
 PNeAoTut5vydQLBbJdJ9ldflNBVC/02rGyRoT8Cea0amUUR7j6hq3+AXXjaTU+7wpDULy13HDt4
 JwXRPRdtpHGT21EiRzgOJG4tvtRUyrEoEVg/aaR0X1fhawzjDnuCrAkbiBvTZKeoXH+CdGSYtL5
 kZvUBF7TDn3NVClP4vV9zRmhP8YDZm92TGIkgwcou+CW/dUH+KS9Awt9cFKyZG2b5PV+HUSA2Fw
 x5klhNiYMbwBIQodpvlXS6pJOOSHlZZoMD3//WBzgBGfOcKs8M+eP8abSTyMedIuacpQ7ppqltf
 frsvS+TlClTmsaZhUbjU+ptPwWXWsYXDkb0+ABsIr/yuI9qCTd/3QS8CRNbSR3+P0JKL/UW+d81
 MJL1+37IGDnZtjZmQL
X-Received: by 2002:a17:903:8cd:b0:2e9:851a:7188 with SMTP id
 d9443c01a7336-2ea43d8873bmr24797245ad.23.1792609882354; Wed, 21 Oct 2026
 12:11:22 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020230211.75665-1-andrebrait@gmail.com>
 <20261021095756.0f5770e6@pumpkin>
 <CALhGy9n9EMvV2JN8s4kpKb3Wsc3rjRVfibpNvVdAw_rHT=dYeQ@mail.gmail.com>
 <20261021140303.5533fb2d@pumpkin>
In-Reply-To: <20261021140303.5533fb2d@pumpkin>
From: =?UTF-8?B?QW5kcsOpIEJyYWl0?= <andrebrait@gmail.com>
Date: Wed, 21 Oct 2026 21:10:45 +0200
X-Gm-Features: AclHuK9y-kelxIPCKCCYwgl-lGFUlZEOjWFrkkhIKj9n4uzUrTg95ra_u3iGOOc
Message-ID: <CALhGy9kqmeLRH-p9OrdPObC7KHUW9gmD9o7h8Cmr8+nnx6aRAA@mail.gmail.com>
Subject: Re: [PATCH iwl-net v2] e1000e: work around TSO erratum that corrupts
 data and hangs Tx
To: David Laight <david.laight.linux@gmail.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
 g.goller@proxmox.com
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi David,

> You could just comment that that count++ is in case the linear part
> has the extra fragment.

> Put that in the commit message.

Will do both in v3.

> c) Adjust the DIV_ROUND_UP() for the linear part.
>    I think:
>     DIV_ROUND_UP(len + adapter->tx_fifo_limit - 372, adapter->tx_fifo_limit)
>    is right.

For TSO packets, yes, although it would need min(tx_hdr_buf_max,
tx_fifo_limit) for parts with a larger max_read_request, and without an
mss check it also changes the count for every other packet. I'd keep
that, the unconditional context count++ and pre-calculating the
post-transmit limit for a separate cleanup.

> Although I wonder if you really want to be doing all those divides?
> I'm guessing that tx_fifo_limit is usually 24k (and the actual buffer larger).
> So the result is almost always 1.

Not on the I219. PBA reads 0x0006001a there, 26 KB for Rx and only
6 KB for Tx, so tx_fifo_limit is 6048; in the ring dumps from my test
host, 127,676 data descriptors were exactly that size:
https://github.com/andrebrait/e1000e-i219-tso-hang/blob/5f247ecec758/evidence/related/tx-allocation.txt
Page fragments of up to 32 KB take several descriptors each, so the
divides do matter there.

> (Indeed, does TSO and checksum insertion work if the packets are longer
> than the real buffer?)

TSO does: in a 3-minute window on the patched driver, 39,725 of
40,223 TSO packets were larger than 6048 bytes, up to 65,226 (45
segments), and the receiver verified every byte:
https://github.com/andrebrait/e1000e-i219-tso-hang/blob/5f247ecec758/evidence/related/tso-larger-than-tx-buffer.txt
Only each descriptor has to fit, hence the cap. Plain checksum
insertion only sees frames up to the MTU; for jumbo frames
e1000e_reset() moves space from Rx to Tx to fit two full frames. I
haven't tested jumbo frames. Nothing in the patch depends on the MTU
(it only shortens the first descriptor of a TSO packet), so I don't
expect it to change their behaviour, but I can run the same tests
with jumbo frames if you'd like.

Andre
