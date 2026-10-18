Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2F9CCF2C4
	for <intel-wired-lan@archiver.kernel.org>; Sun, 18 Oct 2026 16:26:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F5E840367;
	Sun, 18 Oct 2026 16:26:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e-YAszqJev7i; Sun, 18 Oct 2026 16:26:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A40304052A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792340789;
	b=KLfoscfPcdwWBToDiYNIGh9rhLr/Nto2gcjTy6GX/0TkivMxO6MV08ev8Z7JJ7WKphfv
	 693STu0jqs/qSAz6tChP+fclgYxHJYmM7EX0d5xRoEuTE1nIuW0uTPR7lAS8GB5UDYdTV
	 sk2C9osUfG/rInpXI6gmaMydfWbCZDiSZM5c0SKn7IopLqOKMdlv7iwRkFOsw0LIEOMoK
	 OEGYkjYTKlf+Eg9nZcJrBKVReYV7P4vzTDNe7r5j0pDJrfjABRV+XLw4PMZsDCpe1y867
	 NXESYp8agq3kej8jA6oW0WC1uaoFVqr52WKMBZ7aGLO7jcBaZtEoRJ3QPB4y52McMIg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792340789;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=r4CcxdQ2oJybJSNbjjXimwSvVRvmuOa37brscnwQTP4=;
	b=WPoTru3+cy48FBYUnaSPA4vp46zOn76MUp2xArn//D0ZaK0LB9joBjkhbqZZR0WrZRmQ
	 EbnLwPO8pT96MXE2+H3MAazuFwKWrUWkk8X0d9snEgD42UsXhsJj7nIQPyFMnYmJkmHuE
	 Hxdkh6QwLOZ1iP69VlbYt4FRDGWt2IDlI6Xeta+53qLBz6Q0N1bBTd3XDd1pZMWm/LZJc
	 6YqhteGsJZGOB7EykLihkGG3kyOChP/k/fBhFivBnwOVR7itfLMaRYjsGP0A6k0cAvHae
	 xLhwUmYK05aIvnWm0JC2bGlV46Mc9uExWBZQoci+1qrnRpH3H1fYXAhWLKZzkoOvHgw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=none header.from=roeck-us.net;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eTKFN3tJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792340789;
	bh=r4CcxdQ2oJybJSNbjjXimwSvVRvmuOa37brscnwQTP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JI0F8MMPqrcygAiZR/anrz6kblOYu1qGHQY3Bl7pFe1kf9kZQ6ctwne64qAC1F2Hf
	 5IMId/72OaZTUZw829TjeI2fDJ/UC2irdVEAxGtfa5Df8l/pgzLtkt0iJKMG8Dsf50
	 2xVfV91CzCeofy/pxTQfy07xa/DvXMYRyj4Xt8n9/RiGGmuq3RQakKDswwhOD3arXh
	 su+n0m8FDH4fF1fexd7DYHAl7rhuxzUNLAzjD8tgQ1EsfpZ3IwkdPnkoSW02HUdKwc
	 yUsyuwK16jrRW6EfziffrGojCN985uBjFLcYo6fBAQWWQQOr43DPsitmEbqXY3Svji
	 ySgeG76MAonUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A40304052A;
	Sun, 18 Oct 2026 16:26:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E49E61
 for <intel-wired-lan@lists.osuosl.org>; Sun, 18 Oct 2026 16:26:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 339104052A
 for <intel-wired-lan@lists.osuosl.org>; Sun, 18 Oct 2026 16:26:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cqZUoi14B9kh for <intel-wired-lan@lists.osuosl.org>;
 Sun, 18 Oct 2026 16:26:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 20DF640367
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792340787;
 b=kAngMyqx0yLiXr5RRtpq50frDADJ9Y1a0GVb0Jxcv/RZZ/qvG6/DBheUeom6Seqe8Ifw
 kPIYIIEzvfZ9uhK+wVEyLC/mLadRcLVRscCVjC/InmmYNG6fYnREjmaEqbsJZNuBoOuGC
 v99kBiAJ6MEwGzsur/rZzZTPHfOsgasSsXv4/io6SneDQQH5sUlAvn+GQyLJVyIDorOR0
 P8BB/1wxfR0So8ApHujNibZzZZxSeqFm8JAEBgnwMWZ44Dg2Obfm5ZgnroR2obNzk0n9B
 EVWpCQTbrOy2ZTnqk2YeKvaWtZpOJu5LPVGIyXH22v7P64zF6XPdG+tlcuR/CLRjUCA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792340787;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Sender:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=r4CcxdQ2oJybJSNbjjXimwSvVRvmuOa37brscnwQTP4=;
 b=n6Sb6vTaa6j3H2KtjdMDDLdvo/nGJ5h2535sCss0Lb5oqDKBczoFlK9ZVXhzo0Nz9Kkj
 HpkGCNduXERYU7zSNz5+QjRYH9fpQvqVn2huA1CnFjbzWGSRyMxPiuwystYdXmb/lgOl6
 dtMWGPB0YWvJdfUs7ztoxhI4fqeq5qmdQXdvqJvWXEj+8d6Lm8BoruW6zzj9U2+qI7zz9
 h0IitKDLiXYbq1ERMiv0iLoRQeetnMwWCQoAXAernFNciGSz2hbqoyTJihm96l2gvtfZd
 dWxtN2Mz7KvfmS9hNkijSwXBM8XKMC4bkszfqGphLACSX3+wgbkNCainiBx6/Two8Hg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=roeck-us.net;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=eTKFN3tJ; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com;
 envelope-from=groeck7@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=eTKFN3tJ
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 20DF640367
 for <intel-wired-lan@lists.osuosl.org>; Sun, 18 Oct 2026 16:26:26 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3acd21ba21aso1074198a91.1
 for <intel-wired-lan@lists.osuosl.org>; Sun, 18 Oct 2026 09:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792340786; x=1792945586; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=r4CcxdQ2oJybJSNbjjXimwSvVRvmuOa37brscnwQTP4=;
 b=eTKFN3tJc/3thi6FFOtv/GegobPko3NvwRZwJK+8yCuEX72WG8ELzboQd7jCAkrAyH
 5yBYs2FNtSvvTe1z5ZY/PVFSiGNVSLGEhiEhIwHJzGP8S+bKOjTs1PjOTGlE5kjTHl+Z
 p5fR4WeZVQY2g07W6+aEnZBycSagoJtJPRGs5EiSTadpJIb73+D4kG9liVfSJRpxz7w9
 i3UaBYmFoSPVcg+pJ+iVQdUR1tyqyCvla3TWq/TeE1by+edivA/hq2ZR5uMZjdoFzStz
 pxiTmphb0gxEFqhkmWxRyYytIY4bIHMifrBd5cZPZZO7idl5ouP35gMu08X24DLnr4FV
 AOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792340786; x=1792945586;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r4CcxdQ2oJybJSNbjjXimwSvVRvmuOa37brscnwQTP4=;
 b=ImhkpbNpn9c9+vE9XdhlN1xrUIqWpg6IBACTb1K49FasPC9oTlnqjpZO97duOl9WNy
 Y8nb4d3ddC/vdx34onYmnFOdVxKmbEyhXyhH86HY9OPyh7/wu9kMTtbAUZA3u+KmjuDh
 mF+EvziXx+K3bvbzJimezYbmCm2CgUFuX0B5PejcqEj4/iceXkGjbNwOG6dSryLG4Fmg
 5SZLkBhidjlzlB02wwjF9hk9A34ujq/yq0HAnfAA32yknCoNbRxbY4/Kz/e3WqzcnJ/A
 4roRFhZ8jwlSsBw8/QaD8gFXnLIZ9LQvECMXkPu+p2WTlSmOVV2+QTZckmHEi/degGPl
 CBQg==
X-Forwarded-Encrypted: i=1;
 AKwUvByn2cozHpTwbbe/smpenmg80BMdEYhLBIVDfVk/SVyKogxhJ2z3eiy/sVfI0CgcFiWEKUD+hMuZOIoR7zikiTI=@lists.osuosl.org
X-Gm-Message-State: AFq9FYKDkTyVDk7J5olQfAFPm4xlr7V3ZoWtLTyAwXZ9OsGWpjTEZzAU
 Nuu3Az9UQdBobM64e4sUaL1nWTePvXFrZxiqCQkUfUYQqJuuuHfzzWZl
X-Gm-Gg: AYBFou38SbLt8eoDymGZ9VMQ41s75loVkj7sY1aWQwx/rd8Qy8NCEAWf2oxZFMK24l+
 RjgCRCjLK/c9WAWV2hy5BX9JH/C+p9/ptFaS/U4Ae1HFW2P5E0DV3HgrcIHDDHoP60owRrT9xRI
 3Q9OZrFG5NIT43yt+m9frk0Zu3nPPFn2VYzPRhTrM3ix2tZh/m/NdAg70D0azK1i4vyRKyBdEV7
 70Y4H2FPMlXgy4fypYFdDk/LmacQ0fmzodkVQhWF73bdtQZ1+cjyoJZBJF8UYPnj09aTL9yAGeQ
 qYNZHPFNx3sMD6D8tiTjYPhPKqio7GBwVFO90/dVt8dtHu7kCJcWg+L1R/PSXbWSmO2DIT3n+lR
 IBLtjRod6UOpIcn+F4jFIUb31e+pcnm4syjaxW6ZpOSN/GFj8p7UQeHR1tYyp2309BUfFcj7hNn
 aIePSETsYNYijd/Y59Xgj9QvYFIRuBFLdoCTVpxRRUQ2z0YaFJsc78sTyx8DwM7iZvV2ienOXk1
 /trFnpqAduc
X-Received: by 2002:a17:90a:da87:b0:3ab:36c4:b502 with SMTP id
 98e67ed59e1d1-3acef19656fmr4952624a91.30.1792340785847; 
 Sun, 18 Oct 2026 09:26:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc43a1981sm12210945a91.2.2026.10.18.09.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 09:26:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 18 Oct 2026 09:26:22 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Ian Abbott <abbotti@mev.co.uk>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rudolf Marek <r.marek@assembler.cz>, Andi Shyti <andi.shyti@kernel.org>,
 Chris Snook <chris.snook@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Andreas Noever <andreas.noever@gmail.com>,
 Mika Westerberg <westeri@kernel.org>,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Duncan Sands <duncan.sands@free.fr>,
 Chas Williams <3chas3@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-watchdog@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] hwmon: Replace __MODULE_STRING() with __stringify()
Message-ID: <49d1de69-ffce-490f-bbee-80513cfd0cba@roeck-us.net>
References: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
 <20261002-module-string-v2-1-fc7438acaf4d@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002-module-string-v2-1-fc7438acaf4d@suse.com>
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

On Fri, Oct 02, 2026 at 10:31:01AM +0200, Petr Pavlu wrote:
> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
> MODULE_PARM support for older modules" [1] in 2002-12. That change also
> moved it to the graveyard section at the end of linux/module.h
> 
> Replace the remaining uses of __MODULE_STRING() with __stringify() in
> preparation for its removal.
> 
> Link: https://git.kernel.org/tglx/history/c/136839a1b4 [1]
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Applied.

Thanks,
Guenter
