Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BC8CC6B2C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 14 Oct 2026 20:22:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BFA55406FB;
	Wed, 14 Oct 2026 20:22:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L39Fbh_Tsfqc; Wed, 14 Oct 2026 20:22:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 32B994076B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792009359;
	b=lwIFOk3PgsWl13HwLVskhMUz7WShsLi8wX9N0QLS0KEhcp8yOlgy4VmWZMXMbD1tlvW3
	 WCeDqrRe498mFzlODX09UpbxBNeCaRL+Ak22XwZylmUrVPeA1kA9kJeIf3oXx9yHXVsuG
	 y7itzekF81saXcAdv0gz+UDzOn62nmwg55Qc3gCIf4nagEFwgxl5C/p1TS1+rT/QhXuBD
	 Lg13cZ/qTBo38KVQbc21gOfscnNqMw2a/PWZOYhmlCDsMWBHzzKo8LWnXr0b3qXhkJfXN
	 va543p+x4+vjuypjdGTyesfBK8rh2xs+5sGQFxCtUfP3o8agRFMUzM/2x1CgMfRwg9A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792009359;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+lgOL2ulPahwJN6jZRnnLS6q11epqQte8G2+w9DfD1w=;
	b=R9QP+IvoX8JCNiR29aVr+wFqvlHKbP6ajh4pX0ewXNcaD5UlHPSP95kOCFftabAvWYtc
	 ecUV/vQBLKdwnP3g4Iq3/irBF2NW5JdFwiR7CWXP8bYAmxwV/srdodbIdMIdKC+QalO1s
	 B9qL306k3D+Fkmv5i87YlHlh1amS6frdAUb+hqd73hoAoglj9dNbFxHxnrOcyuq7VEzdU
	 AMUnymyc1Nw+4vPoeh1rlIdm9d9x4y/tYEGz9piO7p4feQGRo9Xu+AJXe04dTesL6Qo+Z
	 vK70miqD8X7MqylZuuRnYdncfF1ZJbaZ0VW3znSHii26lhbWaZlsAMNYbw4BuriG4WA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=hyROOirC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792009359;
	bh=+lgOL2ulPahwJN6jZRnnLS6q11epqQte8G2+w9DfD1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0CepAdD+iT5Xk76z4nQoTHI0UpQ7eWedLRJ0hPtKfwJGqQokUNoQSo8KdZS22HVHo
	 kItFdaBfNZ8ft25tmSzrIb01jkp7XL9nZCqOedQzkB0ORMyT6wTQmquvtnnCN3g0zD
	 ivhue8InpO5KYTx0smG+gGk5ZPF9nxscgLEtYaqw5eq+Z/MmVEDVlZ2B4/VrH9fUuZ
	 6weFhbyajiAMoI7Gumy0Uc4oC45buqPmZCjEXYCfZaTobdEbvlcBt5EC4WxBHtepb8
	 ClGICAk+c0fpn/dz54bAX7wqEn+yDuU7UI5tqL9N8d2G/Uu6HHxUcM+ZFGBBx82DYC
	 7nqRlM2aaZhXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 32B994076B;
	Wed, 14 Oct 2026 20:22:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2721A769
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 20:22:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0D0B34076B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 20:22:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TQ98V6klJ8eo for <intel-wired-lan@lists.osuosl.org>;
 Wed, 14 Oct 2026 20:22:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 33F81406FB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792009356;
 b=SyobH+qGR1C11MboDhp4QssDdnZ7xP8qGuq08++zdDILIOyWZ/JBcuTeXCJNOIY2embw
 gcNKuyTSJw4Xe7Zn3KfCCJer/T+z7Bx8jlMxlDA6z82NX9MOIyViGaOiGMWUZZoIotJ6f
 FRtkfq+2RSanZ9hGpnxUqqbreigdVveErzzfP7NNNpCOXANXGSpQ1MNNPGXTU8kaf+59t
 fteTZbBc49q42uOUVE0LHqeBEemkIGFct4jc2uwb+JIMAZHmgFLuK5cLQi6X+fj3fOIzp
 Ur3ZF4OgjAhomGfWAx1PjYtk3sDxXECcxEcPDwzWy937d5Lxiqgc7RVXCJslOeSygpw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792009356;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To;
 bh=+lgOL2ulPahwJN6jZRnnLS6q11epqQte8G2+w9DfD1w=;
 b=Z7EiswUSrB4ztWy2n62WyOvCyDuhrUxE9KpV8Nqmu0gDZb3iOtB49PhK7fYKVAMpbDP7
 21fUIIuIXaUJ6OAkPsKLb6vuYyIzo06SPByz0t9PHC4WdcegYff4sb3YXrgigNcPzNdSK
 Y5gxZMwLbszGgvgYFNYv0AGumoVkUN0fxp5V5ilLzA8sRxOW65bW8q6YOD+btQTlI2FM9
 hzyw/rOYo+q5NX4zYKn0ibBu+c8ODDjPmKQ89SuNoxGS9u3ndn/iAr523WAaSELFkUTbm
 7NBevPUPlO/NKsIIhNWVWtlnUNmicrvfpK58yaTJ4OGW2my4sOhvrhiSFZT9x4oFfHA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=lunn.ch;
 dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256
 header.s=20171124 header.b=hyROOirC; 
 arc=none smtp.remote-ip=156.67.10.101
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.67.10.101;
 helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256
 header.s=20171124 header.b=hyROOirC
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 33F81406FB
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 20:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=+lgOL2ulPahwJN6jZRnnLS6q11epqQte8G2+w9DfD1w=; b=hyROOirCFWWpVPs3cviThT1aL5
 YVlYU9IZMqemL6WZfbqsGvT3O9fxuIEsOzEmreyuoeg9XF2/naMFNlNvf/24ed/5g72vuS6817zeF
 zCSPv7lT8H2iHkI93KxtRBqoHdgEOYJX02FAmT4t3mZLwRChsF22X7bc+lgIApb93eg8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1xH5US-00AoHx-E2; Wed, 14 Oct 2026 22:22:20 +0200
Date: Wed, 14 Oct 2026 22:22:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kohei Enju <kohei@enjuk.jp>
Cc: Ayush Yaduvanshi <ayush37735@gmail.com>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: intel: ice: Modernize ice_vsi_free() with
 scope-based guard(mutex)
Message-ID: <0079adea-1e94-4fa7-8956-a4b4a32805b5@lunn.ch>
References: <20261014110552.56976-1-ayush37735@gmail.com> <as-tT0nDrchWa96T@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as-tT0nDrchWa96T@x1>
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
Errors-To: intel-wired-lan-bounces@osuosl.org

On Thu, Oct 15, 2026 at 01:36:35AM +0900, Kohei Enju wrote:
> On 10/14 16:35, Ayush Yaduvanshi wrote:
> > Signed-off-by: Ayush Yaduvanshi <ayush37735@gmail.com>
> 
> The commit message is missing, and this patch seems to be a clean-up
> patch, which is discouraged in
> Documentation/process/maintainer-netdev.rst. Also, this document says:
>     Use of ``guard()`` is discouraged within any function longer than 20 lines
> 
> > ---
> >  drivers/net/ethernet/intel/ice/ice_lib.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> > index 9e08db376d3d..c695df442822 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> > @@ -457,7 +457,7 @@ void ice_vsi_free(struct ice_vsi *vsi)
> >  		return;
> >  	}
> >  
> > -	mutex_lock(&pf->sw_mutex);
> > +	guard(mutex)(&pf->sw_mutex);
> >  	/* updates the PF for this cleared VSI */
> >  
> >  	pf->vsi[vsi->idx] = NULL;
> > @@ -466,7 +466,6 @@ void ice_vsi_free(struct ice_vsi *vsi)
> >  	ice_vsi_free_stats(vsi);
> >  	ice_vsi_free_arrays(vsi);
> >  	mutex_destroy(&vsi->xdp_state_lock);
> > -	mutex_unlock(&pf->sw_mutex);
> >  	devm_kfree(dev, vsi);
> 
> This also extends the critical section, as devm_kfree() is now called
> while holding pf->sw_mutex.

This is exactly why guard() is bad and should not be used.

     Andrew
