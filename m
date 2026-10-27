Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA98606A32E
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Oct 2026 12:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Uuh3nTBI;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hBxTbubK
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 79D4160708;
	Tue, 27 Oct 2026 12:44:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Nu-I92vYuYP; Tue, 27 Oct 2026 12:44:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E5D2C60711
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793105043;
	b=ZCdjokr0jIl9R0xFB5CS/EWwLAW72qDYq8kafvYd4Wnlk1ofOfKeLe0FPHw2LG+QFluS
	 bo3R/Mm5AvCLYjSTwq97QRMQxW2yUigZYWxoD2HnOW+5uSaYlVX07xURReR8rkPF88bbk
	 k/GldKzHx3jQmvenZ8p3EoQD0QZG2inEhn/NlhnKQegWJMEzvHcFPUeR1s1QieGnXqwMl
	 MFUurZMyReUA/cz8Xzb+cwspQxsesCcfAclUILIqMsCqEogCQJiKlX82NBe/Jj8hxGHJQ
	 RWwJ5xIhEpHNcxLswVTtzjtJdMrL1dpYUNJH4BU6o8CJQMlgvk7tKyayM9yyAYnJpbA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793105043;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eb/61ru4rVEXautmCBJ79YrbItkTpxD25OGZkF+zK7I=;
	b=CHcrR4IVXYdzHUYz8yrR4u5TewDqY19ZEBV8K+xiMwEkLGyltys4toY4JddendUrui9p
	 L2XUAv60VmZHrFyE7LRF2kEl7K4CiyLx/BUD8f3YEUYADnwTCHYJqbc69px8kk7Lj+bWR
	 ccOxFzuom360hfuXhA7Q77V9YdHQsVji8cT3hOvYha2EQ3gUBmH2sP1Q6jkdeImcU6mpX
	 EUE9xVdHzq52NVffX5AwAupHRNVkLW2cXzbyelBhNLTCzhkS8qSqOnhsEtEX34lMod+XQ
	 onzq2rJVTg2Jm3PxTrFZ48KL8UD6t/LrYNq67jghK8jb1PmObsdg8CJX0gLh6lNQ9wA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793105042;
	bh=eb/61ru4rVEXautmCBJ79YrbItkTpxD25OGZkF+zK7I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Uuh3nTBIWyfhkEtJPMpIbRj2FRZtQKBP3AyXTmVahRq7ecmY3yiJK3+S1+zVzXnW+
	 U6dUuGNk54XxACSHy1azkc+dnqGhwEXlo0DtX2DErwBbduCtAFKbhM8agoH/Z55qLD
	 C7CCcHPNsKC3WAPmif3DVjN9oFMMgy6IUxDKRIsGhNqRNgtwYFGd/vtXmXNLFE0Wk7
	 HFNQ0SU4J88gU5LAythOfaF//6TXxFg44f3vybLRpS8Caa/JO65NvTO59knSP+SNhD
	 FyIvcrswW3iqsHvN7XNni7HuCKZk2JuVN8W7TFcgQmoEn8G03fihH0mHoRuRxSG2F0
	 4xRQGEVTWc/+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E5D2C60711;
	Tue, 27 Oct 2026 12:44:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 690DE4BC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 12:44:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5AEAB40575
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 12:44:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Iz7Ij4tTxGE5 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Oct 2026 12:44:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 835F0403A8
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793105040;
 b=WnJEb69a9InzLq9zymExSFsiV+617uqJFZBijjWFf1tagPKugo2HlhrW8pNWtVEA4YeU
 V956RUMRm277cFfs2bi7imsRaR400jXx8uGodTC8vRsFL20T0t79VFQGHQN4eCbk+4DI1
 5SttVDhR6bxf3FeV6abwQLc1+10o1xndqycTXbFiqQddRVA2hj5485BzLwueq5BoZoeRb
 qNJ2zloabsDrOtRVMRYdFaR+s9t+y8ky5Qa+4J1qL4gmJBMgKg3LZl3gO7lMZhoh+mTao
 IthqZJasQf/Kd9wlZkz93Zy5NYqgZUuV3C+gMxxKPULWO6WtJpiY0ZcKLld/vLFjong==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793105040;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:MIME-Version:
 References:In-Reply-To:From:Date:X-Gmail-Original-Message-ID:
 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
 Content-Transfer-Encoding;
 bh=eb/61ru4rVEXautmCBJ79YrbItkTpxD25OGZkF+zK7I=;
 b=dFSZpX1xfSr0tv/WZu1PsvqFTk95hmqtLkGYPvdxhv9v/2EKx2KjMUvK7J7DxXZed/TP
 fv60wsKa5I/EGtneqMP/JZz+p7yD2TMQGHcRHLXFLYlZtedbTl4qK/6zb6TZGkdGNkl6j
 9hu4hVVS/fo61yQQvi9lTCr4qu814ORLmOGid3OurUjKeh8bSP0oAtJ/xn2oo4ukCX0Kx
 0V6IIy8oTAIxoDZufqp+sv8gOTOTs2EcpjEx3vh6eV+bl1szmrQeFnLj56XUxnamGy3kM
 5B+19MNwBuMXSQpYueBwlKO2lqGO/EkmrRarIgwqyb6jOwz/txnAgyY0PtKrF/E2aHQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=hBxTbubK; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=edumazet@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=hBxTbubK
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 835F0403A8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 12:43:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5A60643319
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 12:43:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECBC1F031E1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 12:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793105039;
 bh=eb/61ru4rVEXautmCBJ79YrbItkTpxD25OGZkF+zK7I=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=hBxTbubKKniiQVC4RFgkZj4xzE4r6Mz3h3zkomOGN98Ahx6zKh1GE4zeMqJvnkbwJ
 CE/dtXVBBw+29DOGEpGFpzpqWd4FUtCIS0BKxb4g9a8pjagTIEt+j7Svo1fnPDRrve
 AS9D7QBjjLGr+JLRFnru34z55WmLqhQhcrXK8OhCywTRJpnMDkThyup2ZcHnGIRuBR
 J/mKf6AhWFdSCeOwHJkw4bdhsPfujNSzXnxx6OF/ST3RPgL/WllojFcWfMisxUZRVD
 mTqHNRguPnvX9bGRVbevSuVIql0UQ2tATPRl44pcOb5n24SL1TOvin+LIE17rUAbCg
 Uur0KEeqi/ycg==
Received: by mail-oa1-f46.google.com with SMTP id
 586e51a60fabf-43bf9548df4so3669576fac.0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 05:43:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBynV3bVJJL8glBI9tGih6JxAPBtkJTarlRrGF/oejCLqr7UuqfGB5A3NRG6Yd/g+rq0in+tFfm3laOO305/hO0=@lists.osuosl.org
X-Gm-Message-State: AFq9FYLhOWW8CVD1lQWHuzN491k9rxzXATQHAdh7axENhRoaqBmtFNTI
 W2BN1P1F/lUwZF1yXmZ2wX1mpn79aliIh4063nc0R4xP5pcSpcGc8kVG3Pf8Hme5K5WN5mNn369
 OoC9Lhu+lbcLB74j3kvORhCFsYBh3o2Y=
X-Received: by 2002:a05:6871:73a4:b0:499:c29b:93b7 with SMTP id
 586e51a60fabf-4a83f57ba5amr5113061fac.53.1793105038536; Tue, 27 Oct 2026
 05:43:58 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027121442.907414-1-magnus.karlsson@intel.com>
 <20261027121442.907414-3-magnus.karlsson@intel.com>
In-Reply-To: <20261027121442.907414-3-magnus.karlsson@intel.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 27 Oct 2026 13:43:47 +0100
X-Gmail-Original-Message-ID: <CAL4WiiqJ8K5wXutDRk_XR8KfpWMxhYF_K1eNUVqq7HuyahO87A@mail.gmail.com>
X-Gm-Features: AclHuK91OW4DpBGjqcfgsApUmrjxZO4uBmfJAeEY0HoTj3dKfQfjf-9tJNng8XM
Message-ID: <CAL4WiiqJ8K5wXutDRk_XR8KfpWMxhYF_K1eNUVqq7HuyahO87A@mail.gmail.com>
Subject: Re: [PATCH iwl-net 2/2] iavf: fix USO for 32-bit systems
To: Magnus Karlsson <magnus.karlsson@intel.com>
Cc: magnus.karlsson@gmail.com, intel-wired-lan@lists.osuosl.org, 
 anthony.l.nguyen@intel.com, netdev@vger.kernel.org, 
 maciej.fijalkowski@intel.com, przemyslaw.kitszel@intel.com, 
 andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, 
 pabeni@redhat.com
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Le mar. 27 oct. 2026 =C3=A0 13:15, Magnus Karlsson
<magnus.karlsson@intel.com> a =C3=A9crit :
>
> That USO works for 64-bit systems is just pure luck. Currently, the
> computation of the UDP segmentation header is performed using sizeof()
> a pointer instead of the sizeof() the UDP header that the pointer
> points to. Since the UDP header happens to be 8 bytes long and a
> pointer is 8 bytes long on a 64-bit system, this works on all those
> systems. But no such luck for anyone using a 32-bit system as 8 bytes
> !=3D 4 bytes. So fix this by using sizeof() the UDP header that the
> pointer points to instead.
>
> This was found by an LLM while implementing something else that used USO.
>
> Fixes: c91a4f9feb67a199c2 ("add support for UDP Segmentation Offload")

Missing prefix? This was really:

Fixes: c91a4f9feb67 ("iavf: add support for UDP Segmentation Offload")

Other than this,
Reviewed-by: Eric Dumazet <edumazet@kernel.org>

> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_txrx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/et=
hernet/intel/iavf/iavf_txrx.c
> index 8982cf75466f..2c290d7788d2 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> @@ -1807,7 +1807,7 @@ static int iavf_tso(struct iavf_tx_buffer *first, u=
8 *hdr_len,
>                 csum_replace_by_diff(&l4.udp->check,
>                                      (__force __wsum)htonl(paylen));
>                 /* compute length of UDP segmentation header */
> -               *hdr_len =3D (u8)sizeof(l4.udp) + l4_offset;
> +               *hdr_len =3D sizeof(*l4.udp) + l4_offset;
>         } else {
>                 csum_replace_by_diff(&l4.tcp->check,
>                                      (__force __wsum)htonl(paylen));
> --
> 2.38.1
>
