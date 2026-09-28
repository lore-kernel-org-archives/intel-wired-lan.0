Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F02ECA5FA1
	for <intel-wired-lan@archiver.kernel.org>; Mon, 28 Sep 2026 16:33:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B6C2160607;
	Mon, 28 Sep 2026 16:33:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k3X2T5XrqVmo; Mon, 28 Sep 2026 16:33:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org F30A060615
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790613231;
	b=VYx+N4WE8+DUCVgYhEivOaIOgGhVYuG/+lHQFKD70JWvj83RzMzVnJgPKjDK7fOL/JKO
	 donAtw8o08W2KgDMzXPg6SVwVezIqp2V5ea3YXzsot+aa3VhKHT/8Z8Y13WZKAFN+AQZJ
	 Y9XlB9lFewU67iw/b13xfpxiQTwQ8ufYjWagEn+SPRml2IdqIhz8wYas9Y9nV91nelrAn
	 eaHJsxnfq4qG3l3Kj2ZPVTBjCPGyaGCe5lMd3XpnU6RJmgH+dzFRu5+poGZTHnJvlLNkK
	 h9LHwQ0/91sT/9/R11Qkvpt3OPOsPwC7w5iZ9EV+NSIzCHZZlxn94yKT3sI9THfDTaA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790613231;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:X-Auth-ID:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Classification-ID:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IzFkrAdvi9zqd6RKCBztrtsL6Wwvwdj2Dg+17/rgaYo=;
	b=fWaNZJtFusOo7M2yYUJiLX69EzUWnY68KETKRRR5ZwwnU1rJZBicRR4zFk7O/EWHUBny
	 da+3k8tY3Yp71un7xLNCzVGH0Y9ZuzQ3lNXfnuoIT5SWu+wpTtXD289wKartFiMi0KprS
	 hqmE/rrOijAESq7IrBZTKQ0PlcjiGg9JUPQS0+xsdpiBfqSGg+npSRNs7gpd3eNYBdyKa
	 rnBhVW1MuT56uHFCDuYu7046DJwkZ89DAZ8hp95v91zsmgbHUEe1mA3ulrbr+1YDUrh2P
	 luTvOx2t/hzwuPi0ZtnCWd3+SGEKkc+4Oc1zHDyD9XZod57w5M9EJnKuJIm9iWl/IMA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790613231;
	bh=IzFkrAdvi9zqd6RKCBztrtsL6Wwvwdj2Dg+17/rgaYo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JcUwR1PulPDtjgT8HzNV+TOdLX7Y75eLtqXOCdMXJ9qViRB/a1k7vB8nvfscCN54h
	 FfDwX5gHyITCINo24uU4E8EjRlW1LhZFCGhgYAZUcqCoyHQn0ML4Vdyu/MllY8SSf7
	 +MHCm3KA+4Nt4EwAORd00GmynZ8guqvwU/R+tII5BbXdkj9p3Ya6VDLpz68oOzyRjr
	 BjpL+IlwTbMMMSiICKLIaj6TjfXTngntu/AzkCqDj5K9xaafjuQgMZ3m/aBae2Oy2K
	 1LTr9pf4NM+k4qRjSibgYzjvehq0rsHfZdWSSlcUw9UEXUaY0YjSmwz+nBlUyIEe6Y
	 bmPe5uxXNTVHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F30A060615;
	Mon, 28 Sep 2026 16:33:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B1E843D8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 16:26:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9AA674064F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 16:26:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iTtr7PKREu3A for <intel-wired-lan@lists.osuosl.org>;
 Mon, 28 Sep 2026 16:26:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A702540649
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=173.203.187.69
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790612805;
 b=l/RFDUnNI2glV8nQN0qVh0gsR8pzKqmBKb7GJzEWriDvqNw5oma9/Lh5z/EFLKtUKIPX
 dJ2T23IcC24KAuqfrrvoWbiJXI5To4uKD1jRZPoY7M69cx1WRztf6NiCo2kM9G/GNweRQ
 kKXUyZj0cSnzMQ4JJ/vVea/PLIEtptuOkIcpWRleS7WgUg0wL32k8EpPFLygX7nGyFlDo
 YALZiZHnxRRTrzGltQM+xpxEuBlYxMw8u/TYRhVpM8MiqONIuVOX9WoVOrH/vGxJ7K0be
 q4mFaOb91TrbG+D1TUG66EN1lRtEwRg4kenGNX22niO/XxMsPPe7U2fCByk+WbV64tQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790612805;
 h=X-Greylist:Received-SPF:DKIM-Signature:DKIM-Signature:X-Auth-ID:
 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
 References:Content-Language:From:Organization:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Classification-ID;
 bh=IzFkrAdvi9zqd6RKCBztrtsL6Wwvwdj2Dg+17/rgaYo=;
 b=XXNlBIfSn0SzSJjludDA61Mn6SYorUhjp0sz6EJoyhDtljdfDwsEN0trhtNCbu72CM4S
 fGbPfkxEIiYVsBlF+S0+VE11KB+huOrQMml839XRRF1v/2zQWL5o+pJwNYaffEtXR5MPI
 gGR7jSQ5NU+pzXmqeqRTIJkeStf448NlWt2Aaoo4rIKrYBVN8HjMEz8tBWwjUvEOfR0sm
 ZLjB0sI233oZU/++YOnBi1vHu+tv4Zs1wb9BjfB2/cDjeaX7Do+bGXDIduhWCYay1mCJf
 +5RTcm315RRJJZKP09UeuWdJICAnLOvLmvXL6lP69L2MM5FLNjvrKAt3Tu+ryYK8kHw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=mev.co.uk; 
 dkim=pass header.d=g001.emailsrvr.com header.i=@g001.emailsrvr.com
 header.a=rsa-sha256 header.s=feedback header.b=knMpqU6M; 
 dkim=pass header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256
 header.s=20221208-6x11dpa4 header.b="dAAx1Q/7"; 
 arc=none smtp.remote-ip=173.203.187.69
X-Greylist: delayed 511 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 28 Sep 2026 16:26:45 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=g001.emailsrvr.com
 header.i=@g001.emailsrvr.com header.a=rsa-sha256 header.s=feedback
 header.b=knMpqU6M; dkim=pass (1024-bit key,
 unprotected) header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256
 header.s=20221208-6x11dpa4 header.b=dAAx1Q/7
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=173.203.187.69;
 helo=smtp69.iad3a.emailsrvr.com; envelope-from=abbotti@mev.co.uk;
 receiver=<UNKNOWN> 
Received: from smtp69.iad3a.emailsrvr.com (smtp69.iad3a.emailsrvr.com
 [173.203.187.69])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A702540649
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 16:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
 s=feedback; t=1790612291;
 bh=dcfqKy8RuwJf19ZxcNaKgTpq2Zkz6O8a3A4laJuSYfM=;
 h=Date:Subject:To:From:From;
 b=knMpqU6Mk0kmP+ISs7Cok7X4ebagiVtXT1NiP8qiqgH159TGzqgxajWFaZpSo70uz
 X4JvLjhst970T9CuQ/B1UK7DDj94fUZ9D0EuIcMXbSMkMJeSP20XqvG8xys/G508W2
 FOaJU8N23FUYtqhMknHHcQaVfBr5pD0xTp3BApkM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
 s=20221208-6x11dpa4; t=1790612291;
 bh=dcfqKy8RuwJf19ZxcNaKgTpq2Zkz6O8a3A4laJuSYfM=;
 h=Date:Subject:To:From:From;
 b=dAAx1Q/7P23kXEJJmdf1NGwU5hwBxkB9RRRgCV8DxfO9tKEKn3op87rBbKCtMQxor
 A7xRjYnmS2/wTvYLr7pPA1i+MhM1dZVN9lyPAynl4YEL0TQoXXoZQxmf7SdxwFhpQQ
 4DXajLwgB0+U+CoG1uD67D8LZvzt6Rhe9+Cdueqc=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp17.relay.iad3a.emailsrvr.com (Authenticated sender:
 abbotti-AT-mev.co.uk) with ESMTPSA id 02B6C23DAD; 
 Mon, 28 Sep 2026 12:18:06 -0400 (EDT)
Message-ID: <efbb4382-45eb-41a5-afe3-6c359714aa89@mev.co.uk>
Date: Mon, 28 Sep 2026 17:18:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drivers: Replace __MODULE_STRING() with __stringify()
To: Petr Pavlu <petr.pavlu@suse.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, H Hartley Sweeten <hsweeten@visionengravers.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rudolf Marek <r.marek@assembler.cz>, Andi Shyti <andi.shyti@kernel.org>,
 Chris Snook <chris.snook@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Andreas Noever <andreas.noever@gmail.com>,
 Mika Westerberg <westeri@kernel.org>, Yehezkel Bernat
 <YehezkelShB@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Duncan Sands <duncan.sands@free.fr>,
 Chas Williams <3chas3@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-watchdog@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260922-module-string-v1-0-c18766690185@suse.com>
 <20260922-module-string-v1-2-c18766690185@suse.com>
Content-Language: en-US
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20260922-module-string-v1-2-c18766690185@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 15bec65d-5b3a-44b5-8eff-f2a711d4e1ec-1-1
X-Mailman-Approved-At: Mon, 28 Sep 2026 16:33:49 +0000
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

On 2026-09-22 14:32, Petr Pavlu wrote:
> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
> MODULE_PARM support for older modules" [1] in 2002-12. That change also
> moved it to the graveyard section at the end of linux/module.h
> 
> Replace the remaining uses of __MODULE_STRING() with __stringify() in
> preparation for its removal.
> 
> Link: https://git.kernel.org/tglx/history/c/136839a1b4 [1]
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Acked-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

