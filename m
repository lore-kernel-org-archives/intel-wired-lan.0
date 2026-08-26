Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D905C5DF97
	for <intel-wired-lan@archiver.kernel.org>; Wed, 26 Aug 2026 12:23:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 37DAE4055C;
	Wed, 26 Aug 2026 12:23:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wnffaj3agSI1; Wed, 26 Aug 2026 12:23:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787747017;
	bh=3mBB7aH1lVR/G+Fuyhaip6TpSpRtuDD8azXWh1ZBcjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T4bkI4OUIGi9b1Qotjz28fGZMs8g0PPCGhQDsLEDwVaI3eSrpVtJxcWGiAaRUHEgk
	 Eo5ztNfRVW9Gdvrt0NLrf3bnsD+cYhen1NH+VNQz22MgVy0cRhmLbSf+nNPUJr3cgF
	 hXPTSIr3z2x7zQH5nWBNpdA9qebEmIShjVDZ18NuuZGpwKi/syH/SfdRaP06H6K5/J
	 IJlIyA07w45/wUEvDDb6ydUkCIIwKtQKgnmvs1Vv32DOuof/YNxO7rDLL9mpn2ouzf
	 E4buGZkDVj3XdfVaoLD2o21oq5Mvw98bzjNdkrzcFYrwaHwpKzBbzTQ+3HUELFaYWg
	 gyao4Mw6hsuDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 206B540555;
	Wed, 26 Aug 2026 12:23:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2695F3AD
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Aug 2026 12:23:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1885240555
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Aug 2026 12:23:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 10A1u_v3v4ES for <intel-wired-lan@lists.osuosl.org>;
 Wed, 26 Aug 2026 12:23:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.67.10.101;
 helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256
 header.s=20171124 header.b=Wy2OI3f9
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A2F4D40550
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Aug 2026 12:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=3mBB7aH1lVR/G+Fuyhaip6TpSpRtuDD8azXWh1ZBcjQ=; b=Wy2OI3f9X2Dp162KGlQw2njmql
 fDI/iKmIDEDY5kw+MfFu2hbk+WhGReuIufB4uFrIFgQibiFxa9BCyA18PK9b3SXhw22POGJgk2HcL
 nNquSSJg1dezu8mQg/pLw2+kq1Ez06Th8P5HGMWlXVeG3NGa2YAGmui9OykxEaDg0xk0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1wzCf7-001WB4-3T; Wed, 26 Aug 2026 14:23:25 +0200
Date: Wed, 26 Aug 2026 14:23:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Richard Patel <ripatel@wii.dev>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Steve Douthit <stephend@silicom-usa.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ixgbe: fix MDIO bus leak when rejecting SFP module
Message-ID: <87e4aa92-4687-4fbf-b632-9493932c349f@lunn.ch>
References: <20260826042945.2344686-1-ripatel@wii.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826042945.2344686-1-ripatel@wii.dev>
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

On Wed, Aug 26, 2026 at 04:29:45AM +0000, Richard Patel wrote:
> Plugging in an unsupported SFP module caused ixgbe NICs to get
> wedged permanently.
> 
> ixgbe unregisters the netdev when rejecting an SFP transceiver as
> unsupported.
> 
>   ixgbe 0000:3b:00.0: failed to initialize because an unsupported SFP+ module type was detected.
>   ixgbe 0000:3b:00.0: Reload the driver after installing a supported module.
>   ixgbe 0000:3b:00.0: removed PHC on enp59s0
> 
> This code path failed to unregister an MDIO bus owned by that
> netdev, so when unregister_netdev() tries to tear it down
> (via device_del() -> devres_release_all() -> mdiobus_free()),
> it trips over the leaked registration.

Maybe look at using devm_mdiobus_register()?

      Andrew
