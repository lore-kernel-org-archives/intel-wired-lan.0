Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CDAFC982FE
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Sep 2026 15:22:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 49A75406DA;
	Tue, 22 Sep 2026 15:22:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uVVnKLLScjBi; Tue, 22 Sep 2026 15:22:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6E0D840709
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790090567;
	b=N+XBGp7nvLt8sLTWgCmKqIAkBd+VgSrrATlG/2AnSvYonV4/LJsTq1Kfi7qxD92whC0x
	 BpaaTwwqpmRiw5RG5mLRF973j39fTcBmklAVfj1PEqsU0yJ+qqMKJ7/rIfJKVXGncs2Ls
	 wknyco6/Fshxif1Xg0lCmgJtoEz+YM1wv5kg3PCTT9j0lFJGiKSesCV9SlntSdSnnIZeZ
	 9Jh/g4SbJLDOiD+zYUDHND4DDzMmEGo6kYD0Rsz+02NPMzrNCrsPB7Cmn48ByLvi8okX4
	 GwaTqHJqJMxsK+Nm20aI5dZXFC0aDmlVp1xW8XKegoXMu+IbB6Jmw+cbGfgMNjphqbw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790090567;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6+7YwPssrYwwbcVyy1E2zRmvrRlDS05FVVsJW9+Xl58=;
	b=eod8DUB3ZcQqBFWSfAapPPSHSd8Dc2kBEkamL3es2vxBYwq/octGp2XGbmdzW9iL6Ftq
	 9ekRBVEx5JRPHY/xo9/dIqoNpdMMPKCpFzM7NhNhkfiSchsy9XjAfHRf08eNdMwnv2bmg
	 uwtjYA5gvMSz52UeCE7Q3sKPb94y3SHHu9zWwkjySsdeRHvoHY2CadKfxJtLnPZm76zj6
	 YIm2UO0ZjNCriHYlPgL1eWd446GPT8Ligsh5dgn5hiUn5dhKB/t3RBmwahek+dLsbUULi
	 jmVeoitH/ZUhqh22EOnuv/ZwRueyjDffBUYScHHON5GTL5WrdJwoDDCy0NI6sVBLQbw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=CguFkjds;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790090567;
	bh=6+7YwPssrYwwbcVyy1E2zRmvrRlDS05FVVsJW9+Xl58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eb8K+Zg9Zfx4a4zi7BEztMiBjEGj5e8/aJNNANmPkxvc+7QYYYqjrnjXj5qiqbry3
	 QMIqLX1sklyhyQ9qFkTV7zoToraOy8YnUxDpb0OTIt0+foODOYJlSY6m3JISz1nrns
	 t10bIm3CBRaYDxY55OR7Id34ejtcnQ1w+/6ONLefQIIaDfIb5Lw6Lr3X7dwreKIM0C
	 cDVluKZrs7yVm4fUMiefIlfn6vWUKjqgVKnwrtPqCJtQaycpCfmYlJRs+6dxpu4CGr
	 bSuulz9f334/rE1/aridm4WCFlczz58NlOE+BqkUTZibEkMAVXzv5U0PB8PuFCq7Pn
	 D1kVl0zqj2wLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6E0D840709;
	Tue, 22 Sep 2026 15:22:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DEF09352
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 14:52:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DC93840827
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 14:52:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UnB6f3pkUGXX for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Sep 2026 14:52:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 66FBE407FB
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790088733;
 b=TbS8xlH8mj8YtgmM00o6KwIPP9CNVpfQhNcGXMO0ByRz+GCLC+I+MBIUYhWIlAhXZeRR
 PNW3qoImBZvUrR5EL7I0VazfYyey67IVEk1+IjXfoEQmwxF8J/R3ae0EmNj8HxapiHgjm
 CAiWuBMLwM8ILTB5H6d5XF1Uvezc0NM1qTJTFyRsP8vYmTa2VxN95263u8t7W0Ng5/wsJ
 6q+j2HaVL0pDwYvvC0KxGe4kFdzh/d6enpBym9UzTLWmFq1gDjk765om8BXBwSZR1EvNR
 T4Xuq6Tnhuon4J4siIk0wkPClmdwDCXGEuUozGmIolidjMN6iZ1CPilA+Z2nGNilAqQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790088733;
 h=X-Greylist:Received-SPF:DKIM-Signature:Received:Received:
 X-UD-Smtp-Session:Date:From:To:Cc:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=6+7YwPssrYwwbcVyy1E2zRmvrRlDS05FVVsJW9+Xl58=;
 b=muHPXe2HaoSBYV80mCYG+mpcbP82QGSij0i/HA2N+bMBFSTtp51pUo2dniz0Ys2lB/sZ
 mgyiG0YJo1d/ADHlq7/Hi/pNy+agVG/15g0m3xpAyAt2WGqRYAO2HU5hGXbxoxBXCW+5T
 WGahXzKO5FVgOrfd/LqSmKDuu/om2aHo0hDwLU9tcGmvHb8wxc7fYcu+lZkUp+scq2m3v
 xmzcmsaBoxFDqTj/8+2iYQhknK/eLwyiYbTybQzawFJ4bIYRT8LTjdRfe29vEj1rildA4
 /Y2tXPIYCe6toShjyhpG8424IaoOc1B4b1prXmI1lNAUmrxLDKK5PW37mNn5JcDwgkQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=sang-engineering.com; 
 dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com
 header.a=rsa-sha256 header.s=k1 header.b=CguFkjds; 
 arc=none smtp.remote-ip=194.117.254.33
X-Greylist: delayed 395 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 22 Sep 2026 14:52:10 UTC
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=sang-engineering.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com
 header.a=rsa-sha256 header.s=k1 header.b=CguFkjds
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=194.117.254.33;
 helo=mail.zeus03.de; envelope-from=wsa+renesas@sang-engineering.com;
 receiver=<UNKNOWN> 
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 66FBE407FB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 14:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 sang-engineering.com; h=date:from:to:cc:subject:message-id
 :references:mime-version:content-type:in-reply-to; s=k1; bh=6+7Y
 wPssrYwwbcVyy1E2zRmvrRlDS05FVVsJW9+Xl58=; b=CguFkjdsvQ8uo+wX/xEJ
 3RiokJSXD94GoXAfVLjWKz+1uejkAw7kl4/1xIpbNhEz9+k8g68TzFsoi6LLucFN
 Ndwn5b23x97IbqfUJS6Ka3H72pLXZn/70hR4VEbM5/VqqBrypDjeacVP/f3C862U
 QWEM/koX8XX8b5wCCJBbcEyGr3j/76Lp52BWBC+xXj/jZb18FDWsHby8SdFNA5AJ
 KriCM4PWx7LxDc/OHgfaqQik8Web9Ux9ddtyjZ5Nital6JoZS/EUVbsnJuy5pRGN
 wavCkHNDjeGpkkALeScB5I6OHW7dAuPRkvR3oBxySwAhM494mYq744+2PmKIpyE+
 hw==
Received: (qmail 286476 invoked from network); 22 Sep 2026 16:45:25 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted,
 authenticated); 22 Sep 2026 16:45:25 +0200
X-UD-Smtp-Session: l3s3148p1@0aq/ahNckKNQT+F6
Date: Tue, 22 Sep 2026 16:45:25 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Ian Abbott <abbotti@mev.co.uk>,
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
 Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
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
Message-ID: <arKUgQKr99Ox6ZIW@shikoro>
References: <20260922-module-string-v1-0-c18766690185@suse.com>
 <20260922-module-string-v1-1-c18766690185@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sgLEH0/VtwN7fsyT"
Content-Disposition: inline
In-Reply-To: <20260922-module-string-v1-1-c18766690185@suse.com>
X-Mailman-Approved-At: Tue, 22 Sep 2026 15:22:46 +0000
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

--sgLEH0/VtwN7fsyT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 03:32:21PM +0200, Petr Pavlu wrote:
> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
> MODULE_PARM support for older modules" [1] in 2002-12. That change also
> moved it to the graveyard section at the end of linux/module.h
>=20
> Replace the remaining uses of __MODULE_STRING() with __stringify() in
> preparation for its removal.
>=20
> Link: https://git.kernel.org/tglx/history/c/136839a1b4 [1]
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

I didn't look at all but at some of the drivers (Renesas ones, da905x,
STMP and a few others). Those looked good. I guess you generated the
changeset anyhow:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--sgLEH0/VtwN7fsyT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqylIEACgkQFA3kzBSg
KbZBaw/9FrBesyOyyDUrnxlHP0bOF3BmqDAG1eHCb7OuWj1Wcqrh68l72s5PrP8Y
omafJO2i4E1dAJdffYG+gz4rfeaT4Kj9TJCODqKn6pB7cEFOj0Gk9Tlc1Pd3sNpo
3nNxwod06QpdI/1RpmBPR76rj+a0vaK8WM1j1zoARksJT0LK8Jrfm5d73Hoisng7
2iNk+ZkddaYmPSqgADJxlB+j3VUcWAIp4t/Q4F0c6+xJgA++OzbgOAvDLpXzi4Ae
zVzinZ552qM8vWVqf9RHbEz05NCRqlYewqsc6ZzFWcLHOcC9cE9nbgwH6qtd5qWU
LWqNdIl0WXDwSXi79NzvtqsAIXCMN814bx497Fbz4Xe4Sa3KBDkfUPv/JmmRtxcZ
BQxDPqXjxauBMrmarjBbr2fJy+6JRoJ44Fb3n3USWvZufXWhUbagITi8bfkE+ikP
6YriAOJVgsI9IQnTTUN5szRzPcFEHTM9N5qptkcwjCyWa3Z61/a2gmppmR4wwQ1l
Be/BD93oE4Y+DkKI3w3dWjyamEWcx+Hq9JYIMlemrXpGx5f2OZCIJNHFwvdyS02h
k8AE3H4VIwo7A/6UYTImr/JQAtwuUTyzcK54vyXsGAPSc1FhvXr+8zgbaR06nqgD
EfSNpsEVCbms7JBhxZphEoSYGUtYUwHE6x/Vd63n78pA5DJoRQ0=
=++bp
-----END PGP SIGNATURE-----

--sgLEH0/VtwN7fsyT--
