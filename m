Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F73CA6011
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 18:17:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C7A22408FB;
	Thu,  8 Oct 2026 18:17:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NFllx-vNGSEZ; Thu,  8 Oct 2026 18:17:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 00973408ED
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791483427;
	b=g+4cN9OtjgVEIV1ggtTCVo08jhrhR/8VINDwjBzHSxvDLVZ/iflghVW1RTAA0+iY4/Kd
	 Vw+H8X8vr4jSN2akBaN5pFaR12JRh0QwKK4UIExw9oHpGWN+3hYq495IV7DBMAafoFnSU
	 /bnd8+3KRabX+epkKZ8zxe2l1oYyVq9MoGlE4vOg38v+LR504Gl0CSz1x4x7CDtk/hv2L
	 xllLBbTqyblSkNOwGEEYxHE6u4ydldxpSUYl3CgeqhXyAWYucYwRf7fc1rtzhN/prkeNy
	 CtwyFeMWviFXpV19T5E76djSyQCnN8FWwYgQ649VLgXcDvr80MSgRdH/yugGF7IxUAw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791483427;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=CHwS+u36SNW7geX74e8e6wix0qei4qt+RPnUFFfW2PY=;
	b=CtKpDWJruLqJ71HJzsKxZDBrFKe3gJkpPhT/EMT6mqBv+wccv9NLBhSWOSffhtO+GBPG
	 UQimkoosto521iGlhJnEtQe8lIGKYPgagX9WkxuCrqHG5Z+oQ7yOfnMh9NDoM3KjWXbXw
	 BH3BXoERlQTxrPUdQysLAGkTlxM3gxIAt6p4siROTYlv8obAQ883iSPyLi1s7MtdUGstL
	 UliKpk3/WdDZKs8/pdIEar/3QlNGr7tilazCF+OfllOuMKGd0ifh41QjZPNZc+LgKi+HF
	 G44SlR023JZp9BzO3vTLzxkIvBL7S0+z7JTYPLBH9ncBgb19DxHUA+IMIMpDJKWTRLw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ukvs7Slp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791483427;
	bh=CHwS+u36SNW7geX74e8e6wix0qei4qt+RPnUFFfW2PY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=C2QKOGl4Bnmx/11758mZg+E8hOXReXS11u+5kmKUDPXOmvA/vdbNWQ9F5vhUAyJkF
	 CUlUn2BxpuAHAQxO2BayaazdahyNGN6E2lZvNJ7Yatv4ZRX0UHHibCTmP7i0Ki2MYw
	 /FJLZlscK88siLvvk/YTZ6zrnCAXBLUYUbGYQ5caBwg9VZjsvx1Zg39KaFebRu3RAR
	 nMwsOrRhABzGl37yZAtPL6pTa0HeapCXaBAS6JQkDGjNUpSm3xRMqn9E+L3jmAkq41
	 lZKDpqyL0Q9uwteZObixgQZSiQTXJCK5MynQhIjWgRVjCvI+tJodkJ0e5GwS4h55Lo
	 3cXqQNg3DgMYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 00973408ED;
	Thu,  8 Oct 2026 18:17:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4DED92E0
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 18:17:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2F6D5408F7
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 18:17:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KolQDpqDZj9H for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 18:17:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 637E5408F3
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791483422;
 b=TkxCveFjWAmR+f6zt46ypZ1aj4UuavFJTP9Cq18nJ71tmCcK6VUhdRPnV1PlVt7HxFPk
 +UXcivbHkmWbT3NK2FheIbRIkNVlPMU4Y3iF4ttGBojEtRRU+nSnoEpHP+40tDEnNBwO1
 F9DPQuw71PtHT7KO3ycI7qaogPcDDIHklv4HMAz+3pQqqqUVLRRwf0yejttdNxOWuhamR
 rU++/Fa6XxqDmcotyul9wM2HXu21luhyzHebLjpZx/QdRqdKUN0ebqYb7+aGpczaUhGNy
 rLZIkV2qAyScuE9CBnIXykkKpH0JYGJ8SGHM8QddpZUnkl47yIJYthAA+dymWAp5nPA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791483422;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=CHwS+u36SNW7geX74e8e6wix0qei4qt+RPnUFFfW2PY=;
 b=SYTBQaOFepljKM/n/mnxULj7lY2LC71Z96jJu/Tk9cvf5VW2UzRJ/B7TTJKQTFkSh64W
 UcxNmwK5skT+FMF8zkDJLm4c9B9oKT4x4p6oZuIhljas7xq/lMfx+V0Wm9sIpotnsR0u3
 mhfkmJHTLaZC47eCC3oB1Xfq3Ro+FygFpruHH2x9kZH9OLC0AUMxNvqJNtc2aq5+PWne9
 ATQSRBotu7Wm+OaxEZT1xoVVHr/mz86jcR6BPOXjUucAxzaC+dbNgWUx+hhU0ElPn68rR
 x96DhkgnjZZGOD335lgEwDBZ/O5h9QVtF9ZBya3UtQv0+zbVxpEBu46PxRO8CL7Aisw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Ukvs7Slp; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Ukvs7Slp
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 637E5408F3
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 18:17:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 96CBD43EEC;
 Thu,  8 Oct 2026 18:17:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE991F000FF;
 Thu,  8 Oct 2026 18:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791483421;
 bh=CHwS+u36SNW7geX74e8e6wix0qei4qt+RPnUFFfW2PY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ukvs7Slpruk5T3whfx6wyBuVRNsutjfcxktg56Ixcp9XFECad9pL2C0O11tiLZjea
 t9LsiUnes/JQa+M+ozqsiuPR9k00tEoVdhJMSqaAMFJJX+ZZmZeeUJEQ5mLV5Zdh6o
 BGDoP2kiiYey0WgylIkWKlW5yGn1otEiAd02M7tZmS47rMeyycvqMf6MhUbenGDSGP
 aaMvKc8kkQJLkkNjatvLKu8IMLm9ZtiaQnODqzwBQhfuXaF53qLzTkf8JXlTuUfBfZ
 +39vMhRyPB1qqVgeHZOJgodIFoH02qJeqlgKUM8GJZ4eg1aMRXhvR/7AUIxMFkEDje
 p03ku7iTH1g4Q==
Message-ID: <sashiko-outbox-164450@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 3/9] net: niu: check for failure when pulling
 in the RX header
To: "Josef Bacik" <josef@toxicpanda.com>
Cc: linux-rdma@vger.kernel.org, intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261007-b4-pskb-pull-tail-drivers-v1-3-9512b0fb977b@toxicpanda.com>
References: <20261007-b4-pskb-pull-tail-drivers-v1-0-9512b0fb977b@toxicpanda.com>
 <20261007-b4-pskb-pull-tail-drivers-v1-3-9512b0fb977b@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 18:17:00 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: intel-wired-lan-bounces@osuosl.org

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] net: torn read on 64-bit statistic rp->rx_dropped without u64_st=
ats_sync
--

commit c489740632704e1a68308e50d5ffe53ae3415f3f
Author: Josef Bacik <josef@toxicpanda.com>

net: niu: check for failure when pulling in the RX header

This patch updates niu_process_rx_pkt() to use pskb_may_pull() to ensure
there is enough room in the SKB head for the hardware RX and Ethernet
headers. If the pull fails, the packet is now dropped instead of relying
on the buffer's initial state.

> diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/ni=
u.c
> index c74a97fe54641..d1c0e868004d1 100644
> --- a/drivers/net/ethernet/sun/niu.c
> +++ b/drivers/net/ethernet/sun/niu.c
> @@ -3488,7 +3488,11 @@ static int niu_process_rx_pkt(struct napi_struct *=
napi, struct niu *np,
> =20
>  	len +=3D sizeof(*rh);
>  	len =3D min_t(int, len, sizeof(*rh) + VLAN_ETH_HLEN);
> -	__pskb_pull_tail(skb, len);
> +	if (unlikely(!pskb_may_pull(skb, len))) {
> +		rp->rx_dropped++;

[Severity: Medium]
Could this 64-bit counter update cause a torn read on 32-bit architectures?

Looking at struct rx_ring_info, rx_dropped is declared as a u64. Without
wrapping the increment in u64_stats_update_begin() and=20
u64_stats_update_end(), a concurrent reader might fetch half of an old value
and half of a new value during ndo_get_stats64.

> +		kfree_skb(skb);
> +		return num_rcr;
> +	}
> =20
>  	rh =3D (struct rx_pkt_hdr1 *) skb->data;
>  	if (np->dev->features & NETIF_F_RXHASH)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007-b4-pskb-pu=
ll-tail-drivers-v1-0-9512b0fb977b@toxicpanda.com?part=3D3
