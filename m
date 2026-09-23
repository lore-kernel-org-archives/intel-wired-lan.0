Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11497C98309
	for <intel-wired-lan@archiver.kernel.org>; Wed, 23 Sep 2026 09:46:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA54760632;
	Wed, 23 Sep 2026 09:46:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ChExSCuXBZMu; Wed, 23 Sep 2026 09:46:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org F1DC760690
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790156780;
	b=QjRzAgqN7DaDFFr96Zueq/eUQMaign0A2Qg12c8Q7axKWbvAZ/4Kz182/h3h+ypSa9rm
	 wlT5lwnu+2AhvIIzJYMihdX8nIq96c5jsr6tsg0pwJJ8nAyekGdOSDhj78/xbkhHSVo/p
	 03gaudUjNkpqLgWrWqbU8ctvLtRop3Snfgykn2G3zoaNCrs1f28nI/zyp5hgWmYa1CyFy
	 eQOarMrX4TMh7MDGnWU59GF3FWh9YYGaLVFjv7VoHnzliKtxV+WIMjbqLnfGa+dArdCQj
	 qieZJjdoDhA8Vp8n1cr9rN8wy8VIDMjYfZybJSufuCwpxfbg06sYFGXlgxC+erlO6FQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790156780;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=T6Qi8YPK1RXqDrx7q/dk8raUpjNTcrjbKdaAJ9D+O7U=;
	b=E4gPNiEzPiNcchIiqRnFNVq8xxocFnXaeLWQArRljrHOTLrvW0+55PokjKugB3Ba+SHv
	 dGOzf1dmJxOMq079ZUqt+WlVirZ+9mAAiGbRO+xWdNjabjgfYtUmhB4TCqZHMRZWQX4wX
	 JC6SatYK4oW2GlA+ovlwG5tRQQISPBCDye1Kz1LjlCeZW1Ul2T9FtXejhm1nATvXCQ0dG
	 hImRiP53HWVdVSzlYZdWeUWLFcw7mGjwe5KdXxYLmflKZwdC5QZHrEa9WTeYl3DFRASEi
	 QewPHTIqAzzQ5IkSOmH0zGkp+LEJ48Y5S9WrlW0Zut0hxm8DXfL8fAwoyYS42ms58wA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790156780;
	bh=T6Qi8YPK1RXqDrx7q/dk8raUpjNTcrjbKdaAJ9D+O7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mL9cVmNXVYyX0BWQ4WKzzF53bOI+Fun5mebeOc6gdzWDMY7UptY11O23dJa+HdjnW
	 19aCdfWx7XyGQJFZ9tI5JJMZEGo+dji3RZqc6bYFTMUVqRw5Pi0q6AHYCJBAa263gj
	 4UZSgr0K9ymz8ezGyig2vbUWhMWY301cfwezVfdqR6xIjV03gPDI9pjqQdWZwkO3UT
	 YOnzxgLA4EwlfE7EnIC2flTqA0A17AQrV0wLO+FGlgm6QQb8iBH6rLGFk9QiaehCz1
	 NGxuIxxim6WxuESC9ZSNLJx814A/KgxSV5vu1T+RXMh7TgqLT8Io5FlTRAG5yga7Db
	 Lt0Itnr9rWa6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F1DC760690;
	Wed, 23 Sep 2026 09:46:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AD747355
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Sep 2026 09:46:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9398C405F8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Sep 2026 09:46:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ci1PdR_OJ1DD for <intel-wired-lan@lists.osuosl.org>;
 Wed, 23 Sep 2026 09:46:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3116940526
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790156776;
 b=QXTIjK773UnH79BVUPDW3OK11DDPoYP204Zy9mo8d7n+UyeFgdAsioby+oLsQp46Tj9O
 /XFSHkxAgkc9bNWlNZEG7c0EaHeSs6YH/oi/Da+xsBjS24aCLSZfgoQy58dNEmgCniiKw
 Z48a9f0YoVJ9itIevlMjV+LVv4fItG7o4TaOlX6+POV/frTIADNZvwPlArGLyCGESCY8e
 2pAPux5PlFpgja71LzxJGlX+5kpkT5aun5U/qiiNxsHXPbs2ywuy4MupO4rkaI5Z3h5gc
 bnI0jukpGSETLYyQKK/cgcArQ973QT9nlOY78LnloFRrEB37ewlSyFELBRiBGfqd1Lw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790156776;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=T6Qi8YPK1RXqDrx7q/dk8raUpjNTcrjbKdaAJ9D+O7U=;
 b=r4rulA4RMMt5s4QW6Q9Guz6jdeDoBQF7WIMgskYeZI+crjQgG9g1c9LqiWYdRfIVNWdc
 YlaJpH/hRnAzu73+kdormCJTuTAPhCHPlMbPiK+bQyhY9okt82ioUNZaFXU6QUbdM+CQV
 zc1Jl0noWJXqE/vuuS82dH64XDXj3ay+7lZkxUhp9KAjdZ1W8v9BTmwi8FAsJHbWpsgPa
 hbeeiunqwK3Nwk+s50JDKOqwfJkkZVje9ZiG7xiOiivSq1EjqcgV6z07aVQZ/QaLNy9JJ
 XKk2CHF8oXqn+ykJjwL0fDo/tj/e10QQlsGre+sOMrlkGYFfeG37132LyXVhoUwfnLg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linuxfoundation.org; 
 dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org
 header.a=rsa-sha256 header.s=korg header.b="M/D1iPoF"; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org
 header.a=rsa-sha256 header.s=korg header.b=M/D1iPoF
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3116940526
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Sep 2026 09:46:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2430A600AA;
 Wed, 23 Sep 2026 09:46:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D0A1F000FF;
 Wed, 23 Sep 2026 09:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1790156773;
 bh=T6Qi8YPK1RXqDrx7q/dk8raUpjNTcrjbKdaAJ9D+O7U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=M/D1iPoFzrqn2W6mcgJ1LRF5Focn/2Y/OUIg5hYwYiMMSR8CT5ZIZD6NWIRtkXhk3
 oujVm9FkeETC48xHPmtDrloCMSOmZ/vL27gXOV2pX36pL3yyN4jfhW6fI28IWXFgQc
 0QzjkhcjfBTTo3h+lTK1ooSJmJ+pUx4b6t4Eufug=
Date: Wed, 23 Sep 2026 11:39:59 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Andreas Noever <andreas.noever@gmail.com>,
 Mika Westerberg <westeri@kernel.org>,
 Yehezkel Bernat <YehezkelShB@gmail.com>, Jiri Slaby <jirislaby@kernel.org>,
 Duncan Sands <duncan.sands@free.fr>, Chas Williams <3chas3@gmail.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, linux-watchdog@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
 linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rtc@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-atm-general@lists.sourceforge.net,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] drivers: Replace __MODULE_STRING() with __stringify()
Message-ID: <2026092352-demote-rewire-6df6@gregkh>
References: <20260922-module-string-v1-0-c18766690185@suse.com>
 <20260922-module-string-v1-2-c18766690185@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922-module-string-v1-2-c18766690185@suse.com>
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

On Tue, Sep 22, 2026 at 03:32:22PM +0200, Petr Pavlu wrote:
> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
> MODULE_PARM support for older modules" [1] in 2002-12. That change also
> moved it to the graveyard section at the end of linux/module.h
> 
> Replace the remaining uses of __MODULE_STRING() with __stringify() in
> preparation for its removal.
> 
> Link: https://git.kernel.org/tglx/history/c/136839a1b4 [1]
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
