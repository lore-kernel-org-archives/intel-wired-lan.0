Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25310D29C4F
	for <intel-wired-lan@archiver.kernel.org>; Mon, 19 Jan 2026 18:00:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A48F380A08;
	Mon, 19 Jan 2026 18:00:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9TdrHyB2ypQX; Mon, 19 Jan 2026 18:00:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D1CA7809B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1768845601;
	bh=LHo5efg8CgLD6lt9DbenrpXRwBIRAyaPdhr0/HDvpMI=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=xSNz6L+YHyb7QVYkzhGXiF28Wv9yMfWDhiUho9IMw5JAfU27HBO26rklrdFJtI6cF
	 85eqwUBF+IGjUz8LK1h0bcpeW/BivLz7AaSKL7tqexIn/3Ujx+W5hO49/7yhycpzP2
	 29GbHv2WMGhRZCnJVh3C3mqJ9t/m9SH3qAbeNEqZsnDi23Uazxk2pnxuKk0F8i2K1q
	 AMRCXeudPmluZsgRPnupbsA1vSOK9K8NZUcg3aC2kVCF4EAYqUZyon7Y0UHalRb8ro
	 fCntCTyb8vt4iLj5wZlUOz5N14qA1K892uwxqy6OKmN/o/gLjac8lru6c44YaGiihl
	 yZi5mhu8SMpng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D1CA7809B6;
	Mon, 19 Jan 2026 18:00:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 202E22A8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Jan 2026 18:00:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 066854044D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Jan 2026 18:00:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WHj_wh4UeqAv for <intel-wired-lan@lists.osuosl.org>;
 Mon, 19 Jan 2026 17:59:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::82b; helo=mail-qt1-x82b.google.com;
 envelope-from=edumazet@google.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2183640427
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2183640427
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2183640427
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Jan 2026 17:59:58 +0000 (UTC)
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-5014e8a42aeso49093351cf.2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Jan 2026 09:59:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768845598; cv=none;
 d=google.com; s=arc-20240605;
 b=A/IK5HTHlFiEIRr3k7tW+86WTeNxpDCjUOT9VvRaOoDPvbgWJj8feLpKCI47bdPaLG
 wDWml10B60Cmhn6ZSw4YTzN8ReuXTMuRd0uJCQpVfWC8YpKS3EBBR4f4MS3yvzKS/gAJ
 nZEGwHZeGxqwjdwpioFeo+GUDIJi6QB0qRAGoLOlD9rJr13Pw0xtTGEYc+ymPemYGhod
 w6iGAJJUIVkTj+B684SP9dixukhT+zOT5EVD063h5eftlCfsG2/lrT1WWyjccj3VlkKZ
 8cMe/ttshOEjxwug6TvqaZqI1l9BfxELjJYfdfsq+Y/8zOYjVkWmgc2gHPFVuMohogXI
 3jnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LHo5efg8CgLD6lt9DbenrpXRwBIRAyaPdhr0/HDvpMI=;
 fh=pwW6zkl72E8njvBSpv5OZj5e8TU5idVyy64faqBsWGI=;
 b=QglCSY4vrDZ0u1sBkM/wsfXcYOPnKlwBnJKZ2rIyo1EJbUlKMtD5zUevWy1Wk1sgxe
 llauV1RVhajuCOZo2J1NcDiC9LvQ1ID9MI2VHm/rS3Gvl2E2kbmw+vq9m2UhJm0zgmhz
 /3oGANj8/dWfykT6j82T5iJs7bz1S+oSAV3Atj6QhFOdPZa5fNE5dS9HhB7FdqPdczT2
 1usp+nhTe2jqG3jZBdhG04xDqdSsyNEyeP5GPf4/fOizxB9FWKJbt6VICezOEXg/rstm
 TssFTyluRmaIoFSUylsCRcAy8tIj/BAQKRq+HXZdIrUaYkF1JcbnvDZEnwbXF76ci5E/
 JBLQ==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768845598; x=1769450398;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LHo5efg8CgLD6lt9DbenrpXRwBIRAyaPdhr0/HDvpMI=;
 b=C1TxwZJ7yjedhQTOhQYNDK++i4xMLU3XSlaoWzls82efBw79VRRcmUWfU9WJHX8U95
 qCkYtfoOc238UgS8QirpkVKfJAWx+y8ifDVnEgh3GvroKEZerwgpZGtunSAM4BEMCCwZ
 ZSDw81Fk29SbkGzX86n3EARZgaHevE7m9fkkU0TIlApioUQAfjCJ+3Qf+bS+MeD2/1Yn
 vzV+jXesQxUE+h8hjHCQE28y3x/5GS2PE7cfxN9UJQAyIk6cdezM26bUQpdurIcIEkph
 +hZrgyWofW8RLlrQwSvHYUYxiujpfBfjJDvL3K0Q1UJuMyVkntIsIPYYQ1BjPSQsS2Vz
 435Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5A1hy7pRoHckGkFRcOhGqiOqLFOdXAkGi2/uflF1HuZQW1D9fNOzQ2iohrk3qbxbGCFRDtvE/DX4poyQBqVo=@lists.osuosl.org
X-Gm-Message-State: AOJu0YwnIstiABqv97H2mPuZD5/0360PNKdIOG9yJlnXLAtqrbxW1SA8
 ery2uidBf18e/UJ7WKRz3T1fqyKbQjGn4IHvXjx8MMzBaTLYz0S9I3PCRdTKkztWZQbBPiZt09n
 z5Tf8nLujUWNOdRfRhgXNaAijaofD4WBw6vT2CVAL
X-Gm-Gg: AY/fxX7JWlZi87vBzAySYEKjeubeRND82DEElv668spqlRmTHKfPfOMYzCu/aZPLNMp
 9CqsrG/pSixbcKWDSq21g5tkAdhfE7yK+e7VhhY8RYlu6RQkHvqohxv6TDTtnaIPXNMZUdGvAf5
 QIicLyNpUquF4c+AjZwdZdnAgjp7l2o6u8zoLqgw31BemvN2n6DTlBBgEZDVu3bKQtIIt2fvksN
 cnPeiJqEofcItNEhxyjQ/jaEvhzHKjM5P5ZxqiLiKz6GBk8SEubxtusQ6l/+LJ1tMsRP+Vev38h
 UteJHqU=
X-Received: by 2002:a05:622a:356:b0:4ee:49b8:fb81 with SMTP id
 d75a77b69052e-502a177b60amr199991471cf.61.1768845597498; Mon, 19 Jan 2026
 09:59:57 -0800 (PST)
MIME-Version: 1.0
References: <20260119162720.1463859-1-mmyangfl@gmail.com>
In-Reply-To: <20260119162720.1463859-1-mmyangfl@gmail.com>
Date: Mon, 19 Jan 2026 18:59:45 +0100
X-Gm-Features: AZwV_Qgbc4ou8ErH-5XVKLl9nYMf59iH7JV60bo76qy64EVbM0CTi0OkQh8LZ1o
Message-ID: <CANn89iLuo+A3M0BSXKJwwsd4T+crXe8u0KiAns7=ks1TXnWaeQ@mail.gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, 
 Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
 Phani Burra <phani.r.burra@intel.com>, 
 Willem de Bruijn <willemb@google.com>, Alan Brady <alan.brady@intel.com>, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Joshua Hay <joshua.a.hay@intel.com>, 
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1768845598; x=1769450398; darn=lists.osuosl.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LHo5efg8CgLD6lt9DbenrpXRwBIRAyaPdhr0/HDvpMI=;
 b=qqCN/YE33dAQGmPe4NCTAYd7lHAu7w4GVesqwctjVAW8SkVNaASnQcfpjRqpuDNf7P
 xxqD8sZkemub0EWYeVJVeHk06GWmPI6RJAXJc8l8hFJ0FeFZIVjnoCydK1U/7qM1LQFG
 K/5bCwbJfpeS4bvBiYwCecaOvt19EA1jGUwTO/a314Mo8XmlIESnkGUKHbj40FJLuAgh
 amjUX0wbA8pZl6JT7ZZnV8pteh5by30lWi5UQOoPhiS9LxYpl2+EJFfiBhyB7A8GkmHW
 OMhu8xmvRqld5iZSVCzIZH/OH2T5sPSHghE1eOQlpO0pEdsDRAc3mPhpyfWz0TgS3z49
 b2zA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=google.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20230601 header.b=qqCN/YE3
Subject: Re: [Intel-wired-lan] [PATCH net] idpf: Fix data race in
 idpf_net_dim
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Unsubscribe: <https://lists.osuosl.org/mailman/options/intel-wired-lan>, 
 <mailto:intel-wired-lan-request@osuosl.org?subject=unsubscribe>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
From: Eric Dumazet via Intel-wired-lan <intel-wired-lan@osuosl.org>
Reply-To: Eric Dumazet <edumazet@google.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, Jan 19, 2026 at 5:28=E2=80=AFPM David Yang <mmyangfl@gmail.com> wro=
te:
>
> In idpf_net_dim(), some statistics protected by u64_stats_sync, are read
> and accumulated in ignorance of possible u64_stats_fetch_retry() events.
> The correct way to copy statistics is already illustrated by
> idpf_add_queue_stats(). Fix this by reading them into temporary variables
> first.
>
> Fixes: c2d548cad150 ("idpf: add TX splitq napi poll support")
> Fixes: 3a8845af66ed ("idpf: add RX splitq napi poll support")
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

It seems ovs_vport_get_upcall_stats() has a similar bug, are you
interested to fix it as well ?

Thanks !
