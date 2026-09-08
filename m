Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D83C79F9E
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 15:19:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 52D2140540;
	Tue,  8 Sep 2026 15:19:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4cdcnEnEEU3h; Tue,  8 Sep 2026 15:19:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2162D4056B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788880765;
	b=gDbZRuLFSy67xeHzk5TwWa3JYfCUH8KYcGa4ZouNFQFIKHDDOZbchmcLtZoz30agaDF5
	 Mm7klx/ZyJp6FbPHasKc8Cza6shNicMY+3RZBLPcLGhu6/x67+z8duy5iQdncLJYsLC5w
	 6wPGNrQL1J/QP8QBVb7bZFXBnxnGHMknFX5m1sbM+CJl0zcIfh0Uo068ExsWY7yU8DilT
	 zWLTNQhzqCdxEzvCo/UDRUIdoPHOBK1CeTPzrRSsiavczEI7UY9O3tRV9uAPjvxwfKx/9
	 IutjVZDhJ7G3QJdgkr5Se9SsoBfxi1PBG6KS20H8ph4eVl/KpMaNWeQy8DHniENT/eA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788880765;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QhdCOmP4zDl1C4qG/vDZ2J5jFE+DMqbe+H/tbxij/K4=;
	b=SgcuJHBcZZQBEljFAUdk3pgT96xXi54mOnpAPNJ4NtMrbLTxGI/+eIBgFz/8z/j7JEPS
	 Zh2ifmVAtBn5Vlb0Zo3anHIRp1QXMj0IFSI/StNZzeda/zviNbTZLF0x5ZL8ZeA/hJmA/
	 4Nb5cIeUWKhx8FdLXGc7bCwOQVhbewkytzP6FRXEpOpKPYX4aTCUAB0Jxp0+g64JL3vqF
	 2gxQ+QUvDvRhIOxzxqNswtZaVXhQyXAdl6OW0MpmJBUyH4evhfykzW3SQwsTgzxZKZOd/
	 n0SWDumwOeK/JagXateYoxgBUz3hDeNqlX/1iSKNpcCVUoBC6mtHqicJ51roZx1Cx5w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CWXP6gvD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788880765;
	bh=QhdCOmP4zDl1C4qG/vDZ2J5jFE+DMqbe+H/tbxij/K4=;
	h=From:Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nR4xlrEnybOycbdflCQWK9JVxYwkPZTdPbD/tJjELogQWHo+YNdVTqap4Tl8+NNPr
	 ks9gle2EyUmojStyRw/XBFqFwXLKTxF9cAU38aROy3Uics1/jUy1nztU5HAodjDi5D
	 Z2bMAVIdvsSpGQ2s6cgGBf63lXADqgE99tq67ZaHaKoEwGfTEZHke8LHd+//vCtLgl
	 u8SFfX7rCoqTdt6NufZ3skqE1mE7GPJ8IZk+2ieZM9gF9rINb7dHcM8aL2kcr/MMdt
	 wCWdJFGL2xQjeq5zqaPK3/9uqQSHjpHeodDFZo/9WcV+TZ5ZyvrrADjTF8PhIBmYRv
	 Ulzd2smij3P6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2162D4056B;
	Tue,  8 Sep 2026 15:19:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4BE46990
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 15:19:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2901B4056B
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 15:19:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 15ZYuqc7iqGa for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Sep 2026 15:19:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5EE9440540
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b134"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788880762;
 b=EnfNOgVevuLldP8XGIjLhLLKQ8IJO/XtAfYVeXdVmLGPCiZW8oqRBBR8B2qplXXcd26T
 OdAid8Z5bIKUYcB+MKNWcl3WbHUvG02vszRNTSQWWKRWDJx2dI0tGWwSVo1uHU6n5Xau4
 SBCcVZRUJNtfHjpmi5wh75ygnmWqYB4bGCF4GljJRt4WqHTKIIIG2jJ1dAvAn7N/EO3HW
 p7s9EsosQ9pZhsHv2nfa9JCiStNlaCcxwLBrwKHTAQjFjOhsGOlfAoevUT/1CIq3G24Vx
 2Jf8AmJBmRtBTLlYIjAih7R0uhgm19wrNeRUCOqIi6NdfY54okiweBbf6QrxDKExz3w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788880762;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=QhdCOmP4zDl1C4qG/vDZ2J5jFE+DMqbe+H/tbxij/K4=;
 b=qXroiiBx5buxry4eGKySp4j8Xpw6HnGrECpVwiNh+qENsdiDVUjP2ldLW/yjQJcVjO2g
 eUD9RXWuHjqQ71IjzotILlDMkQPLXbTO/bNt8B93rvKDmk0RljBFcRemgKg+Be1e1NOkb
 vM1ybJmXPuGYMZURPG2mcG++Z+qed6+I0Ns/Ux7fag2F4yKLye/qBBfiG93br96N7sE6I
 bFFeqF/gfySK1o1zo+4jhDa/MU6kgAPbgXJVFt5Hf+UID4/6DoLcDELmWoAdngbp7dMZV
 EHbLw5pF6jzgzlvwloTt4bO2Xo2LNjpc9bdWF5fiA9ysjpbN4J8WqDc1ZVoxievPpnA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=CWXP6gvD; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b134"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b134; helo=mail-yx1-xb134.google.com;
 envelope-from=yury.norov@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=CWXP6gvD
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com
 [IPv6:2607:f8b0:4864:20::b134])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5EE9440540
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 15:19:22 +0000 (UTC)
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-66bd7857841so4710188d50.3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 08 Sep 2026 08:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788880761; x=1789485561; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:date:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QhdCOmP4zDl1C4qG/vDZ2J5jFE+DMqbe+H/tbxij/K4=;
 b=CWXP6gvDuZGOG8SiFkxgWop+kfO4EDqHdZgAmquD6xV8Vdn0+yZIUF88//SpP3LKqK
 ursPtHRjG07tEAMxSMAe5nxfPcg8FUbgRtV6BveIl/cPABrT/B4A90Eqm+CIKcpDxZ1x
 /5PfTM4uCnqLVO4wR9zqvq1bOSM6v0ohMTWHKvlabVa2DrzJJ8YByREkK3ljmfaMO1wJ
 UglkUmyQR4Ak9ZiXcaSSsG+FdN/k6IfF/l7s+Zphr7Ex4N9KUOBK2ePf1SPWrj23LfRk
 royLVIFobQu0vw4FNa7pi80ELFt2HO+W2DW15AtfVCZ7iBolhC4DWsnDMS981o9EMgjG
 EEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788880761; x=1789485561;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QhdCOmP4zDl1C4qG/vDZ2J5jFE+DMqbe+H/tbxij/K4=;
 b=kCoKJmvHUQfwpJxpneebpyfqRKPiLZQ82Mvg7aiqkfMPgfAb2bcgpwpvJBwezRJ+SG
 Bmxy1f2YhoqJicHZP7vJwz//UUYo8XCRoKAPV2IaDMDul0KMuMTapfKdmT8OVpNkwNA+
 T7aI6mDKu+anBy1WthB5WLtiBas+5rZi33bebuJav3D0kB+YwN1QZaqQB9HYR6QXWk47
 J0PayR537DCtGUhy5zoOPs9vF8IDWW2MduJY7Pa0XJLo62I+6Pr3X7O93o+D4zGDWEt+
 bBer6perrC9uszgaUL6aUODP3gh3MmQuyBmNTqQcsT+AMglLGr9SzdjemfwGEpJDGWVT
 DKIw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwbSgJHnU3/LqNDOemRa/cnJ2S1iA67ITe5f39rlJnzgAW2TsmuTVoVv0MOA0csaL746W9AEfvO7pCultPcSps=@lists.osuosl.org
X-Gm-Message-State: AFuF++nX9WstC7ATZOhjTXbt8PRpsSz3+a+LHgPYbFCXxY7WKJeJ5EXw
 nliewBc49O7gTl5v8wcHhRe2vVpmPzCnLz95qPHgRtMWqwYa/oQjV+4u
X-Gm-Gg: AYBFou3Yoj0qjLRWV8ZFwA9vCJTeaoD6lCr0x+NjVq8yp0z9nOI2fsh7xKj9R3kP4j+
 hJeD/9gYH1zKqftKrPGg/Fi4cA7OmAd2H2xBrZ1CnBBPc7kBxpATk9Y5Bf7gnXVJUocQNSHOy80
 Q7XMvWvh0riMgLAzORGLKnz9tLoMGZT5yohwZrzOu+9aeC6vfspbgZj6A1Q8tDGIFIJG6j18DQP
 zpSGSPWCd85Pr2tKCe4IFuxDYRQmI3qasOKVzLU6RZO7eEsIR7xZJZgBrlNDDgrLIx78uuPRuua
 lve/4h05l3orA8cUliAAw6G08KgCS2ngH0tc55VBM2R96pPf/0Pbn6AtPMdPf2l2ffV+ihHsOTd
 VjcFgw95vl9tQKXu1msIKAct7/kEJIttJbjIchcGI2QmwTX3MyPvXGQRxDDOGwJKZZHbRNQWqs/
 jSTqs183I0EtOmgPxzewuDtgq8VEJCxfSg/pfYSiBnWSe0gt1D8Fdw2hZpprXrIwi+hWP888EuZ
 3RjF8afoywH9ENagw==
X-Received: by 2002:a05:690e:4893:10b0:66f:c6b0:e10b with SMTP id
 956f58d0204a3-670f63fcd8fmr2064936d50.68.1788880760843; 
 Tue, 08 Sep 2026 08:19:20 -0700 (PDT)
Received: from localhost (c-73-105-0-191.hsd1.fl.comcast.net. [73.105.0.191])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-670febedc44sm1035024d50.11.2026.09.08.08.19.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 08:19:19 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
Date: Tue, 8 Sep 2026 11:19:19 -0400
To: Andrew Lunn <andrew@lunn.ch>
Cc: Yury Norov <yury.norov@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Raju Rangoju <Raju.Rangoju@amd.com>,
 Prashanth Kumar K R <PrashanthKumar.K.R@amd.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jian Shen <shenjian15@huawei.com>, Jijie Shao <shaojijie@huawei.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-usb@vger.kernel.org,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 7/9] net: phy: use linkmode operation return values in
 phy_device.c
Message-ID: <aqAnd1gpXne2lqCT@yury>
References: <20260907215439.409858-1-ynorov@nvidia.com>
 <20260907215439.409858-8-ynorov@nvidia.com>
 <67ed1522-cec8-4137-85df-ffbae654e07c@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67ed1522-cec8-4137-85df-ffbae654e07c@lunn.ch>
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

On Tue, Sep 08, 2026 at 03:52:09PM +0200, Andrew Lunn wrote:
> > -	linkmode_and(sfp_support, port->supported, caps->link_modes);
> > -	if (linkmode_empty(sfp_support)) {
> > +	if (!linkmode_and(sfp_support, port->supported, caps->link_modes)) {
> >  		dev_err(&phydev->mdio.dev, "incompatible SFP module inserted, no common linkmode\n");
> 
> From a readability perspective, i like linkmode_empty(). It is more
> obvious than !linkmode_and().

OK, a function returning 2 values is not something obvious in C. What
about this?

        
	sfp_supported = linkmode_and(sfp_support, port->supported, caps->link_modes);
        if (!sfp_supported)
		dev_err(&phydev->mdio.dev, "incompatible SFP module inserted, no common linkmode\n");

> None of this code is in the hot path. So we should put readability
> above performance. 
> 
> >  	/* Some PHYs may advertise, by default, not support EEE modes. So,
> >  	 * we need to clean them. In addition remove all disabled EEE modes.
> >  	 */
> > -	linkmode_and(phydev->advertising_eee, phydev->supported_eee,
> > -		     phydev->advertising_eee);
> > -	linkmode_andnot(phydev->advertising_eee, phydev->advertising_eee,
> > -			phydev->eee_disabled_modes);
> > -
> >  	/* There is no "enabled" flag. If PHY is advertising, assume it is
> >  	 * kind of enabled.
> >  	 */
> > -	phydev->eee_cfg.eee_enabled = !linkmode_empty(phydev->advertising_eee);
> > +	phydev->eee_cfg.eee_enabled =
> > +		linkmode_and_andnot(phydev->advertising_eee,
> > +				    phydev->advertising_eee,
> > +				    phydev->supported_eee,
> > +				    phydev->eee_disabled_modes);
> 
> So, which is more readable, the original or this?

The new version is more readable to me. What about this:
        
        eee_advertised = linkmode_and_andnot(phydev->advertising_eee,
	                                     phydev->advertising_eee,
                                             phydev->supported_eee,
		                             phydev->eee_disabled_modes);

  	/* There is no "enabled" flag. If PHY is advertising, assume it is
  	 * kind of enabled.
  	 */
	phydev->eee_cfg.eee_enabled = eee_advertised;

Thanks,
Yury
