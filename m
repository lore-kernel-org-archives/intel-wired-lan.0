Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D10CA5FAA
	for <intel-wired-lan@archiver.kernel.org>; Mon, 28 Sep 2026 15:13:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2297940687;
	Mon, 28 Sep 2026 15:13:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zzhxBcb7sxVU; Mon, 28 Sep 2026 15:13:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6193E4069B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608420;
	b=RH/wG+8TPWJ+DUTh13ZjxBQ6LT39TSXmpGAEB5DYyO6dLzzlXNobWPW4czCpNcG4bS2G
	 qksXcjtKiW2rwCmk0u7bLc77zyYQAjdT1STJlj+10eZ8T516NK1b34QBt9SVz/kT4zlHT
	 fgXnOGi6ZkvhWlLTUc6Z5k6WgbAjv2C+EoY0tnpwycwmI87/fLWxEfMUeYf+x2tyF4VnZ
	 0LC76Gw8aqADxKtimUzMAr1sGJxBr0c0nyWSxVHdae9Grt8qbXoAYmKu6QMefC9fi2De8
	 6iEgDcSZKyvhWDoQT0Orm1XH7Y+CfPrDMgI113y6aUe7RjY80cOGhoTObLsf6zAjTMA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608420;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=43+YVXyrdWk5fDHV8RByct1Z4fjfr1ARLHxq905/6e8=;
	b=PtutWvyDCf7/jxepJX1o2F7jLGgMibl7hmCw2F5dlWhCFpKYUB3I+5IkKLbkyF8l2XgK
	 psGiyf89VKehE75VfUb+6Bo3XU+ci32pZO7NfRimmVvMkXPC+0NOEfhkhHdTH6Zo8iEso
	 1pq1Zh+Qt8OMqK6U5v5fNXav2RaFiNjzQ7LctRP6eHDK+BHQEfa6ZC7tO8dUl/kRpVvqx
	 qgUOhr2ZK3wY5/qDzad30kQJkr1XfLdhz+T50QNaOJ5QHqXAi/tI6/jdYpu1+HgalN32W
	 eez5CV37Gjmm98GEzIA2IMiJSf4o4ONj5JiLOUMSeA+Wrb5kgUdocUkop7Wyd82cVpw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790608420;
	bh=43+YVXyrdWk5fDHV8RByct1Z4fjfr1ARLHxq905/6e8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KZjHTQjff5rODp6Q0575uIV/+H/C/ZhilLCsBW9cdMVjrzNiU1JYXyHncYNIZe9hK
	 3wnOUK/DJT8Rn47EEng9gUhDolp/PV96SHRcaKw5QM9SjjHhop5ZU+YhbbTLOL0mRZ
	 HK1r77HB1diLBta2IZ4cdwD4bJ/q5/nKW0/PMhxMchoUpjGhSW9w1dH5M+09cfViR0
	 JyTlwGcghd+7LtT7xr13DtAIZBWHd6kgHQrAKS/417CewLXw7g2d/WcpRNJ/1Uy+Dn
	 0IMr+x1acdfJf4VI5uAzO/6mopTFIeoWSpXx/TqaLOdkrDoZB7/p6aW2g5XKwsu4Hp
	 Qz+OnqVNJ9FaQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6193E4069B;
	Mon, 28 Sep 2026 15:13:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 874743D8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 10:05:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 78A0B6067F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 10:05:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K6rAsx8VwSDa for <intel-wired-lan@lists.osuosl.org>;
 Mon, 28 Sep 2026 10:05:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 980666067E
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790589941;
 b=Kflc4JyN/TO3z6NXZ49OdxIzTUKcD3Ds+6sM69TLch3o/O4jqHQh+npkO9WAI/XAVyv0
 d9NXKtmufbwscpO2eyWt5GFDb91/UVhDDSpiYQF9M6tvsgmMhjua+QWJG2qtj53yJ6akt
 IpP9yS+zs3T5EvzI6ExF6/2aiMJxoRRBiyU+Z9AtwXiLeYJWrTJA4xL56QGCX0Gb+dOoN
 /ZYkYvPuBJBaoKEk0RR68JoZTBIKIPTVagQntk6uZoy8m9vBXAgqUW9yYlr0WJ4IeyITG
 AaUTtnKPMoEUKE880al4up9FiFMapy3RuTAO2PHO1dCs+qVhks9vkyzAuWIlFWDya0A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790589941;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=43+YVXyrdWk5fDHV8RByct1Z4fjfr1ARLHxq905/6e8=;
 b=IXMXlyBmLNu7PQ7OwvxBJYEnsiVSHioOoEjsm4MhfYNoC15sY68dnbfkWbkl710QTnNu
 GGKDsJ6tW37EwtROXNyJRxgOdIv8/SdVffA9IsE0zMtapct6g8wM6skrt7buZN8IMdlNI
 1RoclEbOeVasEcVzNW6YeEvnpbV5fdItd5QdOpKvscxmjcq8Yzg1De+XyT2nhKlkDX7cY
 wBPtmVumnNEffeRHKjBQEKc7muIho7b62012OSY1tvpjIuHGpzEzs/EwmpWkS2M+sJb+C
 jKnj2YvbGBaHDWtGcvMGhsAvTfz5LEtZ4vlCd+FGg5kx2L3py1H9gR4HU0SWjPVur+Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=GOX3tfQm; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=andi.shyti@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=GOX3tfQm
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 980666067E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 10:05:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9915F42338;
 Mon, 28 Sep 2026 10:05:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2451F000FF;
 Mon, 28 Sep 2026 10:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790589940;
 bh=43+YVXyrdWk5fDHV8RByct1Z4fjfr1ARLHxq905/6e8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=GOX3tfQmMrYnoW34ss7TvG8kuqFbajcWZxildni27Q4qyCt3q6MdT0rIg5ciHjuIo
 ao/yjWenwFUosPjQn71u4WfnmotIB5tVD7Vdb70ePA6pMmmPU9jAhx2MPsmqDhZ51o
 W40AkISe8wpNRrkok7wLzgoO1nNuxOmV9YPC9VoK3HQgMDx0fT8KeoyyOm8zeLII7h
 c1Nz/8LwgohFdaLX5VydGVDUD6OHzTWOrYeKc3Xp9QIEq/O7qPdpd+7P+8A8dTOfh1
 IUdyrAJxVwfygYSpj3S61JrV7QpenbckymrXTLihS44x9ovfeLwJwgCejCEejqVbms
 TftN0U44DYYDQ==
Date: Mon, 28 Sep 2026 12:05:38 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Ian Abbott <abbotti@mev.co.uk>, 
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rudolf Marek <r.marek@assembler.cz>, Chris Snook <chris.snook@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Andreas Noever <andreas.noever@gmail.com>, 
 Mika Westerberg <westeri@kernel.org>, Yehezkel Bernat <YehezkelShB@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, 
 Duncan Sands <duncan.sands@free.fr>, Chas Williams <3chas3@gmail.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 linux-watchdog@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-hwmon@vger.kernel.org, 
 linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, 
 linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-serial@vger.kernel.org, 
 linux-atm-general@lists.sourceforge.net, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] drivers: Replace __MODULE_STRING() with __stringify()
Message-ID: <aro70o5N7VoXbjsy@zenone.zhora.eu>
References: <20260922-module-string-v1-0-c18766690185@suse.com>
 <20260922-module-string-v1-2-c18766690185@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922-module-string-v1-2-c18766690185@suse.com>
X-Mailman-Approved-At: Mon, 28 Sep 2026 15:13:34 +0000
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

Hi Petr,

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

Acked-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
