Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93322C982FA
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Sep 2026 17:19:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 34AAD407E5;
	Tue, 22 Sep 2026 17:19:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 19m3Z9DdCmEM; Tue, 22 Sep 2026 17:19:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8AAA5407D6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790097597;
	b=MHQOxkjkcHYlhrmPluiBpoC2iVQhGdyFVoQ4c3csPyqtFT84JL10fua38sbNb+GljHpF
	 OLwRPxjYjQoZYYWgn8eBStosp6wkCYWcQZL/SG28r2wGI/lnUXuPPjIuDzESDtL+S6qan
	 k6WyVKeDEH7nYdCrXuz32Z0s0HOe4TnjDuesPf8D907hrJvxmE7QsA+z0lSNz9R2hUmqM
	 UIWefFJ04+EW2Ov8LoXUSKgXCsJ2bcILbrdlVNWaYTeIv5b6dAmDl1KXheOfPnZNEQ/sV
	 j1V20ldwiSnMOciTG0VbyamuODwPZGHgRBNYaD6hB/bwOpoTT0LGzf5A7ByanjnG0ug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790097597;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zCRq4hnTSVTOASY3u8FUiAUCCMw+X4n90vfRzUKE6C0=;
	b=EJmn7v3S11Qkrr3jGF/IaR5GeTbBSNcCE3hT3qkWHWzooyRwzklHbSAkTJCoURGFzhzA
	 U9ChEPyq1s9drDVJ49S5P9tFc/8GfDnjgH4RGg8HJzCEaiCeY1Xb6+SyIdlYK9PbEmilM
	 hGXvYeRGzfwe1h1wQKg49JsZK6MWfAiWWUlgxURhNlN1iR/QWPTWiFca0faBtaDwCO6c8
	 WtFG3DXZII9GSCzLpSHfzijZ6SYBkyaTaHZr3Su/twDCW6x8KfdfpYvdHwzuMrHzOH6Jj
	 ItDIEqPXYtdEXi4xrC9V2kmMsG/KzljsDl1vprCAhf8fFEH8U1LUr3FWh/ZnmluGUVQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=roeck-us.net;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=W5wAsMMu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790097597;
	bh=zCRq4hnTSVTOASY3u8FUiAUCCMw+X4n90vfRzUKE6C0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=94gRvpV1FL0g2LKpB9yJmIaOhrJTzCiKZGrDl99GKNmmo54UfDyfzyzZNUTtGXVX7
	 yQ4YFx59aX0CnQKp29Qu3EP47n5Zn6W3g3CWOIe7a5jZpIqO6mtezdmwPH6/L3fe12
	 NH5PE6mjUGHRK9gnmkYzSldasPvqA8dPv6lnC2vxW/7D4BYHDKL4DQarDBeazgMLZE
	 L4hv25wIn7qrYzFsumLiNnp73HrF79x2aKTwjUNFygekcwKEfW2KsmeOhM4OEy1J7a
	 7OLyJD4NSz0TA8iiNQNBJw2rjEVOZxoRynijGeotRoVYdoImbAH8ywHlZNYxniT7c6
	 Ugtq2UUwZDppQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8AAA5407D6;
	Tue, 22 Sep 2026 17:19:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F61DD1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 17:19:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 55219407D6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 17:19:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JQOjZaER_Dku for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Sep 2026 17:19:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 45E4A407C6
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790097595;
 b=EwIZycMaTsQXdsDIzeKIW9FxyYjWaPMS871gBbTQxYb198isrzCWPPlS+iJJWjjbt/Th
 90M2Sz3nmT43QfaTCaJDTeGtHQAETHEx6SmeRv+uaN+LrQ8VGX8XP2d9fuh39sp9qs275
 k6ZLAeFp5ljaC3PzuDUfyqVHMQjikz6fuAAY7QlyDk74eCjS5A/3Wu9OYwWM97WAqUnee
 /Wfa49tjOqZ9YGbjPfNDfOXHfJGCElUany1txupaOPIWaTC7jlk1YLRxIDnIyzUc02zeg
 Yo50Wg2t/ILRcIcd0pWz8y0/hTDXXfDXIHYJxyRSG6lBVLM1kTJ6Byp8VZqUtyDgSkA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790097595;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Sender:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=zCRq4hnTSVTOASY3u8FUiAUCCMw+X4n90vfRzUKE6C0=;
 b=G9A6H02M4kP6JHbRRmMR3805YnlG9uVk8Cf1nwbuRb1XtuXjuq618VXs1SFNlPsLb+Gn
 uCKfeNw27vpNBf5NIXnBnTPDLTQgQzLAEwaml1zPXDc+XsZVKd9YYBVWD/Q/qmL5ry/RF
 IBk1z03GbA/n5lI+LQzJ8yS0C0DAry3KHcqlcbdx6RECGrrdcxMTddb+3KxFWcD09Mkev
 aN7cFBdpWCq1k2Orp8LWHz1WSmBp8HfZoJ85Gn4xHX/2RkTTNh6y7Sh0iz8LxxHkYFB1w
 rbNO/noK8Z9lIL0TlZ+gdZpSAhRnjj37MTwxxpm8SfwSAxac15rLPsuDk/4bc+++cQQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=roeck-us.net; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=W5wAsMMu; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::e;
 helo=mail-pj2-x0e.google.com; envelope-from=groeck7@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=W5wAsMMu
Received: from mail-pj2-x0e.google.com (mail-pj2-x0e.google.com
 [IPv6:2607:f8b0:4864:39::e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 45E4A407C6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 17:19:54 +0000 (UTC)
Received: by mail-pj2-x0e.google.com with SMTP id
 98e67ed59e1d1-396ccb65437so100411a91.3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 10:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790097594; x=1790702394; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zCRq4hnTSVTOASY3u8FUiAUCCMw+X4n90vfRzUKE6C0=;
 b=W5wAsMMuNSD9jrbCzMvMOaiEpmrn9dMw/jwjoQVBhBtnFFHk2GhElnoclWtDrAVr5O
 KTg7YLQYRWjVSESFWKAf4v0SEFvrehG8rz0t//GGWkCH1S37OhhYGsEpisJxDFYCTYkj
 2mdpeqkznimFpBIvN5V4IUL+otWZyyFwjJ2G5zlbvZrWJ65z3an3daF/0y0rQ4zj9I3h
 l/RzLX5JUVH4dv/QGckQhsry64B+VhJUkyOgnt/KKA/2NrNQA7FChWrlPEYFbjfZOMNr
 jhK+QY7aodjzSS5BUB/Lmlyq2gduhefxaXx1wv1is4orEw6h055yTFSkctVApykDk/VE
 2dbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790097594; x=1790702394;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zCRq4hnTSVTOASY3u8FUiAUCCMw+X4n90vfRzUKE6C0=;
 b=bY+B/S32d3uUGrAxyZ7L9NqGP0ytFrCyKP/Z2uSQlpltERfhhar+TeU3yzKygtBEog
 DOrfCd7AfFx2N55QOxUMlEAUHvX39kM3UZppWPsdjgVD2P8AbsgeD/IIElyKYYKuTPMV
 RBdHXCl4FZzwUostC6WgRHEHOSrfoi33g31VCT7jPlBDwaHhy5U4vM5ydqoCQpZJycKe
 kw1uvSe8XnmV5uyMhM+QhOfW7MQKBDhKxlQQ055iz/sCLUkGj+ADAn6Ow72wriauC2p2
 O4T6H6UN/f7a4VUXOKboQ7wvFzsLxYIVd/dyZKfHLCphnQBfMYxoi2mZ2XEARyrpuoFD
 uEpQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwAIN5QYuoLvl+RyA/5ckK/SZ9alR4/c/155Yi4eONqmrbDrrd2aBBuGM2cOeiW3K/rQEq65X2gSG+Kbiv96+A=@lists.osuosl.org
X-Gm-Message-State: AFuF++nJlAKDvlt3Ue381G9gF6oZqenP9Y1tjJ76qU/Oqs102KRbE6eg
 fkijJP+fr3sN6WUwE/276pQjzfL9lyCthJu/h9BKPSYMyxRBKngUMrEz
X-Gm-Gg: AYBFou38tgJN7crDFe94j1VCt/5I3I+Mg+ePwm8+XOTcmsp7wPamwaohP8QDLnl3kZc
 PoFjZvkNVpXnpNwAJUw6fiAD7BhE9OaUHX5MDrdUfA4qg9TGwllPTs5I5xLhbC1lR44EfdsBYvh
 tsIfhPBsJkHtpVYI8mtq6LJ31XDt0zk7vBeZfUkenQTFo3swdPdet1iltF301B+M3bonTY9DW9J
 Ss1c31FmB5aVdISo6F5vRIZWuBRoavQRoc1b69S8sYlYimRwhejqdLrV9TNBxRJc6XjgsHt5r1u
 G1LdGJNjEl+jgebCzAiX0drDXbcguJ20e4idJCd9MBnzmvLPtvKt2fbb0htW6VfkLb1eApnyvox
 79gyRf9hrcpWdm5Q4aBf3IxXlmI9FYIg85ffWiqc0JxNrxLK5+0z97c9GfUo792hDdoWM3CPaWV
 jVmjNfH5OlT+hNw5YYE71FQJeCgKX/ASRZ9ryqPMmkAjzFgA2qtPkbwqOrd6Zj94P5s04fI3aDO
 iulBd3zXyEQyw==
X-Received: by 2002:a17:90b:2b4c:b0:39e:1ff0:331b with SMTP id
 98e67ed59e1d1-3a07e4f7b61mr128059a91.2.1790097593735; 
 Tue, 22 Sep 2026 10:19:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a07ddaf4f5sm336767a91.4.2026.09.22.10.19.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 10:19:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 22 Sep 2026 10:19:52 -0700
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
 Aaron Tomlin <atomlin@atomlin.com>, linux-watchdog@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
 linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rtc@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-atm-general@lists.sourceforge.net,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] watchdog: Replace __MODULE_STRING() with __stringify()
Message-ID: <940e0763-9de3-4d55-90cc-8289d5525b17@roeck-us.net>
References: <20260922-module-string-v1-0-c18766690185@suse.com>
 <20260922-module-string-v1-1-c18766690185@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922-module-string-v1-1-c18766690185@suse.com>
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

On Tue, Sep 22, 2026 at 03:32:21PM +0200, Petr Pavlu wrote:
> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
> MODULE_PARM support for older modules" [1] in 2002-12. That change also
> moved it to the graveyard section at the end of linux/module.h
> 
> Replace the remaining uses of __MODULE_STRING() with __stringify() in
> preparation for its removal.
> 
> Link: https://git.kernel.org/tglx/history/c/136839a1b4 [1]
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to watchdog-next.

Thanks,
Guenter
