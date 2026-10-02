Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747DBCA5FD9
	for <intel-wired-lan@archiver.kernel.org>; Fri,  2 Oct 2026 08:49:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 25D4D40AC6;
	Fri,  2 Oct 2026 08:49:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6ewKFiTqY5hd; Fri,  2 Oct 2026 08:49:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8969040BAB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790930975;
	b=FDRZ2RiUcDKzkFZpwvWX07tE/5INirSe9Qtv562UbsoNroz07bAAwF4hQ/PJRe06qIdx
	 1Xb/QPIlO/XzBRfzyPZ81DhBRyXPfI3TemRZo3P+UiJYBg1aqVQ22uHmp9Jk5tpsxVoxW
	 VE7Sm6H55uWwrQDbqtJDKctZfDYe6v5dM3RyElJBoCw75lzOESrBfIdHSVXemCXNBR3AY
	 EB6lHoqyR+fS/OBfdgi3W8YHo+yOIlglx9gqMxjnAbj1KzYNu8CHOfrW8Gwnf2vGB14v3
	 2vQir3a/wxKknMk/Ll/uzCwLC6P5yLARxvbEW/9PZsNFWJMrMSAnoYbZSeTvu2EoUsg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790930975;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=d37PxlYM+UhIBnPzJqXd7ERPGVPa10Ggni/Sy8G6jMU=;
	b=TqHfoDkXJoAw9z7qGkOrg36gNGlDnvPxTDvY+zjnJkMROcJ+Jlzo87MgRa4a/BZwN3o5
	 47kxCSLBUx9UufvysnnDXOfseoY2LezKeK6qwnVTXa0Fc48xZgWl9GQQYHm4m74o7CBea
	 DED/9pGBzq1f2SS/xyBHxCqgFfA8eBORMFp7UsGvIBkO2oyMoKILpI8EHC90wI/uc/QyC
	 jzDtEX7areDfMNNw7Sv7AAN82hPe1/iXHSatAGnbyTpe0zmr6vQ1l9j4ANKIdc8zpaIfF
	 wwm767s3KeW2CA557ubi2ngzcK4a16PWsK541NAfpqpemwNyWT17KRYwu+L99RLjL7w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790930975;
	bh=d37PxlYM+UhIBnPzJqXd7ERPGVPa10Ggni/Sy8G6jMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zX0S7GNYJcTahNjzflWl4HoZocv9c5vus81Y52c+IrgJXl6yNG8lhE2lXMgSm3GnH
	 amUu9+K6hOABVHbh1FGI+JCLary4mxyTAVC4IzyrrOlqSB9tjmJ7iSwusvvKjdFkps
	 nKBvmuWrmbe/su2oAEGWnneKYNsqRqbEbqHTe7hwoBN1/TF5nWFt3gnDgJ1EI8txlC
	 mdAPAsdIdJ2Xz7oCKgnKiVRosRD0SJB2LMKnkDtl4uGHedd0U3hia1AaMBKpniuB0I
	 RyFkzVWZydfEodOoBnnZlF4+6FZzdCzT1tl0Y3UNH126redFd3rrto5ORHGaMOV/Z4
	 T+Vsfa6ycJzDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8969040BAB;
	Fri,  2 Oct 2026 08:49:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8257722B
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 08:49:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6856E40382
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 08:49:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2614PawsRKAM for <intel-wired-lan@lists.osuosl.org>;
 Fri,  2 Oct 2026 08:49:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5E565400B3
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790930973;
 b=Iq36iNwdpZMZGckaNqK6XnDLkXkCgJDiMoj3t7arG9VgNcU0Z57pHR8MW1IE+RJIJi95
 BRBibvfFeRCK3UkyjRXT0aT7Wp1NnIRP9gyNZyf8vi0B+ltD+KiN2C6+8ZVP0PBDMUDOJ
 0ecSNGF+eRUYqmjtK4Hi1Ph1RBFu3AvqZlytpPR+92I7usy1V+UgVzSmhPfIf/QF/dUhj
 WE8IgCvn9eAMp0bFlIbjwN55CTOsg+ZHkKTrMT7hv89n6YSSPh5j261of5o1O79s5sGPT
 wO5YzLMhzJxNxFkELOuAYrwX1IUvfhRrA7ByhxxdJXozrwRH70lRoD5/ShVQty2tyrA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790930973;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=d37PxlYM+UhIBnPzJqXd7ERPGVPa10Ggni/Sy8G6jMU=;
 b=Y7+3xaauhs3w+m/GZ+f8ONx3beoXnlDl9alSCY/N44PF72oTbuF7awuQ5xoC9Kz803f/
 beRovC7Pe7CgJ39AJ8BfhRhTTUt7GDWbBxjctxXciPhm+RJpaQ9JCf09i3ZgESXo/lR1W
 kG2ImlHGvROuHKEZVOvcY02uNf9GGEXzLGeBXLqGpTA3Dm00I7WZAtRM80gtOmpUJmzSf
 C4A7ZGU6wqailT2AYPVSKAIfnxb/YOBW+reOw0wvdjJQ9R0gXpGB6gPsoX+wLRXx9VqFL
 0QmBBtKdFU6v68SHRtrH3cOf+c45yKNb7rK58giYHNQYkkXEQcaavgnIXMQQGcSX2qQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=linux.intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CfvRfDXt; 
 arc=none smtp.remote-ip=198.175.65.12
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=mika.westerberg@linux.intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CfvRfDXt
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5E565400B3
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 08:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790930972; x=1822466972;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=YN0wOfl6bDY8nqUj5Q/9V9fQKfz4SuIc2QBNbMndnaU=;
 b=CfvRfDXtuhwGvy/RpGUf9MnDMNLq1ucPlQUvyg0jUcvC+opIJfjMUzcz
 vB2BWYTWumEoEgIzreMl/vISDRQqIi3yRivrF2RCWDiLiQ+e5O/Swdy0T
 9YcQeaC69Q154HISzafm0NYsiZYlC6s35ZjE5wcsP4DgMxt6mqIOtVNfs
 QRxXqjX4xAwTHazzseSFy7/W/4bRIlLjStp2511x6f71rggotYsvx6zTR
 Qek6MekIgYYGeOVYLahaN3jqL7Qd5mGeCTilXAq+2QMqGZV6/L/8aDCJ6
 +F3y6kJ2M+rEBhGRNSvAWAhkA9l3hSeq7oedoBRjQcL15spsknfOBfxEy A==;
X-CSE-ConnectionGUID: ZFpWEOdQR/+bxcPh2ZKilA==
X-CSE-MsgGUID: AxFid2C6QdK6i3smX9tw3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="102219847"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="102219847"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 01:49:30 -0700
X-CSE-ConnectionGUID: EzkXN5aeRSCVrzI5i6k/hQ==
X-CSE-MsgGUID: jPdD+Ty8Tqyt/zWixcl59g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="276262414"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa009.jf.intel.com with ESMTP; 02 Oct 2026 01:49:22 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
 id F042199; Fri, 02 Oct 2026 10:49:20 +0200 (CEST)
Date: Fri, 2 Oct 2026 10:49:20 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
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
 Aaron Tomlin <atomlin@atomlin.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-watchdog@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] drivers: Replace __MODULE_STRING() with
 __stringify()
Message-ID: <20261002084920.GF176164@black.igk.intel.com>
References: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
 <20261002-module-string-v2-2-fc7438acaf4d@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261002-module-string-v2-2-fc7438acaf4d@suse.com>
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

Hi,

On Fri, Oct 02, 2026 at 10:31:02AM +0200, Petr Pavlu wrote:
>  drivers/thunderbolt/tb.c                              |  3 ++-
>  drivers/thunderbolt/tunnel.c                          |  5 +++--

For Thunderbolt,

Acked-by: Mika Westerberg <westeri@kernel.org>
