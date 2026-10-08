Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19AACCA6014
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 18:17:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C0598408ED;
	Thu,  8 Oct 2026 18:17:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h272XajfuFtU; Thu,  8 Oct 2026 18:17:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E56E1408E1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791483422;
	b=D1hE8etgh2lxld9VLjkpXtttlC5hnPATqyFU6AEPyadBcG9xxHsUVfCwXOQ1GgmOAMIZ
	 A0ZHYXSzEE6xJYXUGjToy8AQ32wqiHOZEiKKJIi02BhllzuWelaid7eZreAcg0Bfd0VEL
	 eMbo63zqi/KndIzimssOfQHiiDJdYk4Ay8wR1bgNw+RwnuNpNAkS1a3qGwUN1wkKw1FVQ
	 F1a+fd77z/LzCbYSatIcr31XEptIztT+06m+ybYCjZFYO0i1mfhJcezlOMEkOxTYWa+TA
	 NkFqV/hcG6d/A8MQSBZEPcBRhq994VvBhmCEKezveHAGea91OVwDey1g8C8qZmGhj1g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791483422;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=Tb6aJ+vupNKr/sFx3R6aEtET96erhvok1PfFx51DYxU=;
	b=ZoYfRrLWZKHtpqe6oQjGu8fcYRt1sTLamVsm3JM5S0CVopJPj8E8THXn9tEjZSGJ0tXF
	 Nn6D2rX2eRSrxHKUFRu9Dc91Xr7Dr19OR6leVMlRFg2jsZONLKF3WFMl47VRHFQwXk8Tz
	 /UEwI9xKFqAzQAUu3ExexPQMhRI5n2P+lKgIWgZwzraaunZRAjFM0pYKvUe9j66DTV9Pc
	 2eKQ8a+zjRJ3HGb0G7oQJLkTVZSCWzr0cbwhF4Yr7lsflGAinGhApMF6dwtMpohIG9VUE
	 dRYSt7yiNyiMgfqg/T3kvcyRgicKHbSlW6kYP3MWOjh/HL1aHwjbTx/JiA6f7EfVnNw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791483421;
	bh=Tb6aJ+vupNKr/sFx3R6aEtET96erhvok1PfFx51DYxU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Z6v8gE3OFkga2w5AmVGhne1On3zhf1GxptP0lq4OBklCkMJaJO+1Wn2MV8AZLfg/R
	 CZTNBAxJE9fBteDnytPSs7AevGiH5lskXuolB/uHnHPxW0HzT0MVatepVef5ce/Zf0
	 Vd9eLIaWiB5QAkmKku/zopRsAag8aKFCrOC7WwnPwXpGGMp1vdVLTSZT930ZtqOzo/
	 TitBKYSHGgmAh49HbRGD5M4k2U5DFjia3p0mTFkAjt6TKLz9i0VyVX+h2QZbTZRtfE
	 CTLesaYMJPQAg++qNGT19SIMWWQUyiENJa5Fwt8j5kJrYR0/rQ49iWPTye96pYL0Bn
	 DRz4fxF92y/kw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E56E1408E1;
	Thu,  8 Oct 2026 18:17:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B73BD338
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 18:16:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A9C1A403B2
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 18:16:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 16Yz-6ZeCmgu for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 18:16:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A494D401A0
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791483418;
 b=FTKrmWbnpdwmqy6yNTaCpde3wS6em8Z7P/GrkMaQAjKRcY0lRjhaP8hzVB4i6Q2XBI+s
 7gsmaL9UKHiTkcx96ZX2L1cThjETwe9rHZFfBC+cujo97qTy82hiSygXpwVX8SyeiBEEp
 OwB0jQ6BZNpyZ8LBplZiXYKGZx8kB8R10bujcmIB1SazrcoYTzqTZ/SZftiT26DnrGH20
 u1V/5iseRfVNQfTc90mBAw65XYkUh1APDxMNQSiq8XNh+nOCKcurDh+hGHoOagmVue1Xs
 yls5hyzYNV/RtU2g/BvIsmyGI06KOCQ3acgKeDfz48JkZgGZpBtj7S8d1ySJRbGsx2Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791483418;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=Tb6aJ+vupNKr/sFx3R6aEtET96erhvok1PfFx51DYxU=;
 b=sXnsJiEF5cNS/6RmaD9K6THjlywg8+GJ8DxA0+9NjX5QplAh9q7OkNfN9gLgO+kKtuuQ
 L/K8TDQtHt5IYXcf85prQbc5vjicBxGejB+zrMWSCFITJEGgpoxW7lTa3qoL8aIob5x4V
 QLLxk9tDwowgnQr/xmifrf9xPqk0S3MYoR+YyHC0cCvoZO1xuc1Si+T5LvhxxoPKsxObV
 hi5t9Q7T/jVu6ta8NXwGLRopdNRyxN2ft3mSctPKd14cmPSOgYDE9iha6XzIR70sMHf1Y
 v6zitRGigHIvMqtBvzri9THCHDcMAzX2LS71UCcKpFK2U6uDFpmu62ATKHIywoy2gnA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=mPVbWuYm; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=mPVbWuYm
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A494D401A0
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 18:16:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A8CE0602C4;
 Thu,  8 Oct 2026 18:16:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248511F00893;
 Thu,  8 Oct 2026 18:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791483416;
 bh=Tb6aJ+vupNKr/sFx3R6aEtET96erhvok1PfFx51DYxU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mPVbWuYmJRL2K+slUBiKduTOv5I5iVNLmIjVBNJXo4U0emYCguEfYhwhkicxTDva5
 YaDUxk3XJ4lS8SYt/hRlABkL9bywYj7br4tB9jr6UU9SjQ2kXiWuWmu3gCHO/ZJbjx
 XLrfD6bVmRPxgxvKs2It4LtNi0TohspIT/+gNJYLtegWa0JEy3933LjXZqVi5b7Tnr
 00RuCLn0n143KOyuROpAzr0upG4WryW1M4QFRCW03s67cCkP59hKTxzPn+5w4STG0C
 RvsgLf2PPTEDecVI+G0fzMmk/WMYYlQSlZ9AD4nvmAE6eW5hZqCtQY5vRa/cjLNM/f
 vaGaQ4O6iEHPQ==
Message-ID: <sashiko-outbox-164443@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 1/9] net: ftmac100: check for failure when
 pulling in the RX header
To: "Josef Bacik" <josef@toxicpanda.com>
Cc: linux-rdma@vger.kernel.org, intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261007-b4-pskb-pull-tail-drivers-v1-1-9512b0fb977b@toxicpanda.com>
References: <20261007-b4-pskb-pull-tail-drivers-v1-0-9512b0fb977b@toxicpanda.com>
 <20261007-b4-pskb-pull-tail-drivers-v1-1-9512b0fb977b@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 18:16:55 +0000
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
- [High] net: ftmac100: UAF and infinite NAPI loop on rx page allocation fa=
ilure
--

commit 64e4a607347eed7af02ba45920da8e098d9fbc07
Author: Josef Bacik <josef@toxicpanda.com>

net: ftmac100: check for failure when pulling in the RX header

This patch updates ftmac100_rx_packet() to check for failures when pulling
the Ethernet header or linearizing small frames. It drops the frame if
either pskb_may_pull() or __skb_linearize() fails to prevent panics in
__skb_pull().

> diff --git a/drivers/net/ethernet/faraday/ftmac100.c b/drivers/net/ethern=
et/faraday/ftmac100.c
> index 40ba001d4b3fc..a1eb04ead2d8a 100644
> --- a/drivers/net/ethernet/faraday/ftmac100.c
> +++ b/drivers/net/ethernet/faraday/ftmac100.c
> @@ -469,15 +469,21 @@ static bool ftmac100_rx_packet(struct ftmac100 *pri=
v, int *processed)
>  	if (length > 128) {
>  		skb->truesize +=3D PAGE_SIZE;
>  		/* We pull the minimum amount into linear part */
> -		__pskb_pull_tail(skb, ETH_HLEN);
> +		ret =3D pskb_may_pull(skb, ETH_HLEN);
>  	} else {
>  		/* Small frames are copied into linear part to free one page */
> -		__pskb_pull_tail(skb, length);
> +		ret =3D !__skb_linearize(skb);
>  	}
>  	ftmac100_alloc_rx_page(priv, rxdes, GFP_ATOMIC);

[Severity: High]
What happens if ftmac100_alloc_rx_page() fails due to memory pressure?

If alloc_page() fails inside ftmac100_alloc_rx_page(), the function returns
early without calling ftmac100_rxdes_set_dma_own(). Because the error
is ignored here, the descriptor is left owned by the CPU.

When the NAPI loop wraps around, wouldn't ftmac100_rx_locate_first_segment()
return this exact same descriptor, leading to a second dma_unmap_page() and
attaching the already-assigned page to a new skb?

> =20
>  	ftmac100_rx_pointer_advance(priv);
> =20
> +	if (unlikely(!ret)) {
> +		netdev->stats.rx_dropped++;
> +		kfree_skb(skb);
> +		return true;
> +	}

[Severity: High]
Could this early return cause an infinite NAPI polling loop?

If __skb_linearize() fails, this block returns true but skips the
(*processed)++ increment at the end of the function.

If ftmac100_alloc_rx_page() also failed, leaving the descriptor CPU-owned,
wouldn't the NAPI poll loop repeatedly process this same descriptor without
advancing the processed count, completely locking up the CPU?

> +
>  	skb->protocol =3D eth_type_trans(skb, netdev);
> =20
>  	netdev->stats.rx_packets++;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007-b4-pskb-pu=
ll-tail-drivers-v1-0-9512b0fb977b@toxicpanda.com?part=3D1
