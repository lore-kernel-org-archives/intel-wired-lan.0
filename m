Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5106606A32A
	for <intel-wired-lan@archiver.kernel.org>; Mon,  9 Nov 2026 18:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=7kfmGs1b;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IP9SxyfD
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A1B024075F;
	Mon,  9 Nov 2026 18:08:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bxm1g28_JW73; Mon,  9 Nov 2026 18:08:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DB9314077F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794247693;
	b=TmF0Yp5vWhqB708TbhLpjgPvalvoIogI9ygNiUUKILZimg/w2kmGqWiEDpSHTJAjxH/e
	 2f5t/mttg/TGYmeQFZHvjroVfjocnKGOcUH8sHZGwuKS2bnWekpm+knW0W/ilOgtDbN9T
	 eylbbWBTWsFCEHs4FaiMXFoXIiEX59NOnNZGOw2TtiaxVA9Hce9uOWTv8gro1zd1h1+zs
	 4KVYM81uOAuG4o76RKp919+hkpd0vBP71eVACqMmLsi4tFmBCDhNRxyRkIJBND0ksXkiN
	 2naPJELceFadUeJCUs+88TIGqS4fholSTr5xIMOyev6Q60zIK5hGvhS3qoBnCakm4BQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794247693;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:In-Reply-To:Organization:
	 References:Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=s7U/x5CE+niXpSBFgBUHJahPZfA7nFuXi/iUGvk2YDg=;
	b=ZBL+Ek8F61lWhvsAUCmxrz8vFWS3neIF3gNktQl+uGIIZ+cZaB15E1XsT1fnximhW89c
	 qESevmsXicyB8hBUCZscTvIQgpSkhzV1yCDU5967RXQgj9gnezZDjj4sTs1/ns9PKfMuh
	 YXncOsLxuUcNABLO3US1pXKjL2yKhfzRWCXp2fpMUQJLF4jWBFLJ0nmhWUdR+4Ek6VUci
	 3LZaLCuu0v5ny1Zo1lndaTkQIq+0BTk5ZG6FLLyBZ0OYOM51dIBJkG3ihlbEYkmNn46mH
	 sRwu+leZ4rf4dM4w+h0gvdz3XImhf5oUvKpj7Z5y0cz+WTu9GytvlhH92VpPMNm9mUw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IP9SxyfD;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794247692;
	bh=s7U/x5CE+niXpSBFgBUHJahPZfA7nFuXi/iUGvk2YDg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=7kfmGs1bx/sOwykOkfg7I9cO17oPUDbO/q85hiE4pa7d6sm+ku6R1bIOYMaKIUgj5
	 n7TwxvfOMcxfCcBxeBK1251Q0xBRBYyXqhkfYiJnDZUuf0YuXrx5z/T5T+64IrMlXL
	 YwWzfW3kErIbk223WGy6I3Y6ntHA66brnLO3rdB0/i8J3t0wVbcdP514JCTq9LrYGG
	 sjGRE7G+sTzC/v6bItkTrSlXrhK0udMSBX25Dw/ykXtgSA31PS3DuGnzNF87ne8OOm
	 dlcVz1I6YdpGPiaAL9gDhHdo0hDOtveInbUFz+AGNFMTUOOSVomRxBSOKSe9VjIGju
	 qsw+Li3cpOCnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB9314077F;
	Mon,  9 Nov 2026 18:08:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EBD223AD
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 18:08:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DD3A24077F
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 18:08:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZTUV2KwqBHhG for <intel-wired-lan@lists.osuosl.org>;
 Mon,  9 Nov 2026 18:08:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7FC064075F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=jani.nikula@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=IP9SxyfD
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7FC064075F
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 18:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794247691; x=1825783691;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=wfrbeowEpzlsOOtS5Xzt/Z99rOONWv91scfsMt1LT1o=;
 b=IP9SxyfDSB6EGFGs7A0bVCps7q2rwZcFhAiDYps8uP26aAu5UsHuIxSf
 tlmYluqa8O0Vkzw3iTrVKhijz+FC+kmiN5XaQ71GLb+8eONi8JfI0J27i
 gAac0Ey+5zHnjNqUoGr9URlzdDJ+F39/qK50JinS21ss/u/G8rc4vPQ7x
 mqFEASpQPYKebvqnlIxIvZKEEeurzQ5f47Zp+zwzxQZxNVFZvEO6oQe8W
 qyB2XD0JMOX45lgejPKqDw7YfMTajxl51pPK45w+PADjiswcG2ePqK5eB
 51DxM3/Q69Vre2Thnw8Y200cdNemMOs78amfHRZkMWzOSK6HYmZMgrBl8 w==;
X-CSE-ConnectionGUID: HcQdSMXBQommKXcpX81ggQ==
X-CSE-MsgGUID: q8UX1HSwQsCowcWNNOp54Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2894254"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2894254"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 10:08:09 -0800
X-CSE-ConnectionGUID: REOqqbgbSlKUYG/hgL23ew==
X-CSE-MsgGUID: M/rq1zH2TtK3zErWiBcqiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8094048"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.244.93])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 10:07:59 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Petr Pavlu <petr.pavlu@suse.com>, Petr Pavlu <petr.pavlu@suse.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, Ian Abbott <abbotti@mev.co.uk>, H Hartley Sweeten
 <hsweeten@visionengravers.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rudolf Marek <r.marek@assembler.cz>, Andi
 Shyti <andi.shyti@kernel.org>, Chris Snook <chris.snook@gmail.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Marek =?utf-8?Q?Beh=C3=BA?=
 =?utf-8?Q?n?=
 <kabel@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Andreas Noever <andreas.noever@gmail.com>, Mika Westerberg
 <westeri@kernel.org>, Yehezkel Bernat <YehezkelShB@gmail.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Duncan Sands <duncan.sands@free.fr>, Chas Williams
 <3chas3@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez
 <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Aaron
 Tomlin <atomlin@atomlin.com>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, linux-watchdog@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
 linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rtc@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-atm-general@lists.sourceforge.net, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Remove obsolete __MODULE_STRING()
In-Reply-To: <a190f981-d668-4208-8148-f4e50adb31a6@suse.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
 <2e88806e-57dd-47e0-a9ef-a8507d22aa3e@suse.com>
 <a190f981-d668-4208-8148-f4e50adb31a6@suse.com>
Date: Mon, 09 Nov 2026 20:07:56 +0200
Message-ID: <6c00fc009f4e61e87895eb2dd3d77c5dfb28183d@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 09 Nov 2026, Petr Pavlu <petr.pavlu@suse.com> wrote:
> On 10/14/26 11:36 AM, Petr Pavlu wrote:
>> On 10/2/26 10:31 AM, Petr Pavlu wrote:
>>> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
>>> MODULE_PARM support for older modules" [1] in 2002-12. That change also
>>> moved it to the graveyard section at the end of linux/module.h
>>>
>>> Replace the remaining uses of __MODULE_STRING() with __stringify() and
>>> remove the macro.
>>>
>>> Apologies for the wide distribution. Acked-bys are appreciated.
>>>
>>> [1] https://git.kernel.org/tglx/history/c/136839a1b4
>> 
>> I've queued the second patch ("drivers: Replace __MODULE_STRING() with
>> __stringify()") on modules-next for v7.4-rc1. Thanks for the Acked-byes
>> and reviews.
>> 
>> The first patch ("hwmon: Replace __MODULE_STRING() with __stringify()")
>> should go through the hwmon tree. Once these changes are in mainline,
>> I plan to pick up the final patch ("module: Remove obsolete
>> __MODULE_STRING()").
>
> v7.4-rc1 no longer contains any __MODULE_STRING() calls, so I've queued
> the final removal in patch 3 on modules-next for 7.5-rc1.

Perhaps send it for v7.4-rc3 to prevent *new* __MODULE_STRING() users
from cropping up between now and v7.5-rc1?

BR,
Jani.


-- 
Jani Nikula, Intel
