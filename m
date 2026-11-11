Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E415606A88D
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Nov 2026 10:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=mi2UXzSc;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=B21EnIbU
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0AB458111F;
	Wed, 11 Nov 2026 10:48:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bGFJpJTcgG_J; Wed, 11 Nov 2026 10:48:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2E48181123
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794394133;
	b=ni0x/w+Nj0N5fhA7psClslzO/2cZCHw8IOXohcjzmwzCdNpd26xShzHwprqqfmZa4l2W
	 B3SaCZiGekY4yvjaczO7ICY4jqZ0xqrY/msp04kZ6WOtOqy9n59hSX76Ia8bidRvLDySY
	 6QpwFXsW5+S81WTvUcT3v1NShejuGfbY8NH77JhL7GhBBQEF4+SIWjFmsxAN+ZkEOhHMn
	 FTHbs6g2tXYzbUIhN6TAFseDWUN17ZReOHr29LQ1HOcO/4T0I5TBZe9TdaQTnxnh71f1O
	 4NinwTyYVmGRXsLmdDEKr1zF/zHZRDHmZokkKYXMXkRJeGGzv+uVvYe3FI2VuP3QZYQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794394133;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SJE8c/dZm+CWhQbZBqBGTdaX2jwL8ZWmvduRU6X8Ew0=;
	b=CmiC8SVWp7bQMgDeImhHfJfvviOJc30Jj1JCfw8g3kUgg7+b4vakQVmV0aerg1NJ0H6u
	 P4KYPlXSKa2sjyF0Y38id9rH0pgVuvBnsHruRjzptJQZas7z9Etxqy0YFSwxuOneHpoBO
	 NgKoi1yhdJao/BcVXpWRUI66oskXcUWus0FmnKnmz9MSAD9QJrxuNQaZQkQFTwBXx6pXv
	 gV40QNCVVkrDBamtdz1/zTiNGX4onih8y+0YMIbAzf/5XQqsSVATf5tm7Pj3TqYeOB7ip
	 H29+D26VEosXYLGb/U35KJzEHV56UqjTLZ+IGi2IPqstqQ4y9brWX4NGFcx9EVNyKIg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794394133;
	bh=SJE8c/dZm+CWhQbZBqBGTdaX2jwL8ZWmvduRU6X8Ew0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mi2UXzScG9ee4tA0wEYCm9HB/NIsYJAZKR2EPfF7REpdWRr5E6nIEqP/YaYLJkaKF
	 Q0CnNXhykA/XugMVzrSDEIpFlYsIjmPhnssJ62F7KVVMz2WlCU3dYiowBfbKvLGLvg
	 IdmGLYVQSpwRq3OENI1MwnOGJK2+qNc6N3v9Yd6jedbomfOLPuBMNZtcNVrmy4dVDS
	 iu18dkEncR6Kq3W2ytSBz1XtQkrSLXj7thAsWLx7OIxlwwbcb9dyZflgui+QMuilyE
	 nm4bWXYBd7+ykVEWpJmeEe5ihy1Sz3y5aLzamnCA/PafzYikcJw1zMBhzlvXGaofCr
	 E0gvPrx5431qQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E48181123;
	Wed, 11 Nov 2026 10:48:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E29E317CC
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 10:48:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BF077606E0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 10:48:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rP7sXfQoVWkS for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Nov 2026 10:48:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 850F860604
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=petr.pavlu@suse.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256
 header.s=google header.b=B21EnIbU
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 850F860604
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 10:48:50 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a2072b9832so17556465e9.1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 02:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1794394128; x=1794998928; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SJE8c/dZm+CWhQbZBqBGTdaX2jwL8ZWmvduRU6X8Ew0=;
 b=B21EnIbUm4xQ4HN1JyrTQTqzXnl7hYQxL7+wEqa2/bwhBDpa3M/NKWKIdKvohgIsCT
 8OyeJXNG5GAUtpgt0wlNMKPJ2u1SFtRTI3mwDrgAH7FSCesG7T7Ero6yVDL3WJ3FPKyj
 4Pa4w2HaPZ84lQLectcGQcvriGJsUf2TO161xM3pNom0Rh/fIC57xO2NEk8BhHH6u05P
 cQz9MhyM3L6mTWPX8MkEALRWmvKuhDpUJaIk1IPqkVXVetIDnAmrC6Ab/u0mFI8Wxd61
 sENps/vvmmd6jJ6jvE2pTS+ImBAbeoYXArRXpwOej5IS3Qq9GIt6LP3/bj73c43bzk3X
 mpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794394128; x=1794998928;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SJE8c/dZm+CWhQbZBqBGTdaX2jwL8ZWmvduRU6X8Ew0=;
 b=xG3wtxonB2cA4ONuet60iHA+GT0sE6/Dmd0T7DjhiBXCzgwnUxHJwFz4UcnbODBJTo
 10e4SdXgitgeaRKAGAuc73n7jrZZD4cUn1Kg0RAOdTDO9vXUjZqhZxr81rH7cVfYQNW0
 3Gi1iZcqOFiqfyw1qFBnamV7EdBgA+S7Es7lTeedlTwDj3I8Ugj70lVjUportH66C54p
 TJ4zvGt/JnyYqbojEXG9Z7p/U6KSlPcKo5+7EXX6s/4lHQ1g2ArP3n9wFVXIGZ5iZAHQ
 hv+x0MKL4L82H3CGwZlh5y5WzR4lTgihMgZCMYJirX4Unf56Ec986JaaItTku6fh/8LF
 1RQg==
X-Forwarded-Encrypted: i=1;
 AL+hErH9wmMotx/LdiRgQ+kbkTuyVXkP0CCVfTR7gYq20nB4DXewE7Me8M/9N9YrDMfi8A00k2rFsiBD19rJ7WfEDnw=@lists.osuosl.org
X-Gm-Message-State: APuU4Z+E2HS5/eM4yvuPaGfCAhICifx+pqlPiWF90+oZaxT6AlSCd40P
 VlIt4OkI+3+jlrEdKmFYACKvv95VpHt/xero6c+T9iEvciIJk/OvAE6Lj8ZfPokHMUI=
X-Gm-Gg: AYBFou0yrU/s9szE5TYwCJiKnvU4fezBoZAQ4m5Hk5fiKug6H4olKf0mipdXqWnHmwO
 gPdStUZGaeg0VC/O8NL1iFaqFYNX3qDlVrbwHZBsTebRPY9rzJF4pC47Qi7bXHPigSNu8IVQAlK
 mj9yXco1ivRTXQpyCL7HrNKGmWGOikAzPMxCJpYATREB8L0UFboAhbqoU1xgU857tq9j8/vjmbB
 Z0cMI60hXVlDn3foY7rfDrgB24RkT0OLlBY1L+4hL9DhxEdq8nEuKmqCItthza8hSk8C25z4hr8
 oPOEd/BFEmtcfY46XI/SeNh+oR++FyxkYMa9wc/l0uZk1BvZwU9OMmHD1s8ZWVVADetMgn/jFe+
 6+hBpGh4HgyX3I9FeAe0Qne7vRogYxOPIoIsjL4aQq8n2r+HzFxO6URHNil3DUfrAcuRAZ3Hrls
 w6YRBz8O5WF8mFvhNdZmUPRys6yj5W0R5ILsT9JxCOLfDushfY/BUGgak3hZnlupAxCwvKIkAQM
 7xENMLaoJifbonFWsO8SiEWJtx18MehouY89ztgJqECOKU1AMcqhzFewDYAl4guJnGyiIf/vPl0
 sTG+RUpSyQr8Ztw7qSUkwPpxEe8F0Fy789dGu8OJEiWkhHWpm5HlS0IWPXo8UNGzoQ==
X-Received: by 2002:a05:600c:1f93:b0:4a0:20b4:ba93 with SMTP id
 5b1f17b1804b1-4ba0938124fmr41926975e9.16.1794394127955; 
 Wed, 11 Nov 2026 02:48:47 -0800 (PST)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53?
 ([2001:af0:8000:1409:193:86:92:181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba0951fe22sm54693255e9.3.2026.11.11.02.48.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 02:48:47 -0800 (PST)
Message-ID: <2e392c2b-3fde-42fd-82e0-8130d2de48d2@suse.com>
Date: Wed, 11 Nov 2026 11:48:45 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Remove obsolete __MODULE_STRING()
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Ian Abbott <abbotti@mev.co.uk>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
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
 Aaron Tomlin <atomlin@atomlin.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-watchdog@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
 <2e88806e-57dd-47e0-a9ef-a8507d22aa3e@suse.com>
 <a190f981-d668-4208-8148-f4e50adb31a6@suse.com>
 <6c00fc009f4e61e87895eb2dd3d77c5dfb28183d@intel.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <6c00fc009f4e61e87895eb2dd3d77c5dfb28183d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/9/26 7:07 PM, Jani Nikula wrote:
> On Mon, 09 Nov 2026, Petr Pavlu <petr.pavlu@suse.com> wrote:
>> On 10/14/26 11:36 AM, Petr Pavlu wrote:
>>> On 10/2/26 10:31 AM, Petr Pavlu wrote:
>>>> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
>>>> MODULE_PARM support for older modules" [1] in 2002-12. That change also
>>>> moved it to the graveyard section at the end of linux/module.h
>>>>
>>>> Replace the remaining uses of __MODULE_STRING() with __stringify() and
>>>> remove the macro.
>>>>
>>>> Apologies for the wide distribution. Acked-bys are appreciated.
>>>>
>>>> [1] https://git.kernel.org/tglx/history/c/136839a1b4
>>>
>>> I've queued the second patch ("drivers: Replace __MODULE_STRING() with
>>> __stringify()") on modules-next for v7.4-rc1. Thanks for the Acked-byes
>>> and reviews.
>>>
>>> The first patch ("hwmon: Replace __MODULE_STRING() with __stringify()")
>>> should go through the hwmon tree. Once these changes are in mainline,
>>> I plan to pick up the final patch ("module: Remove obsolete
>>> __MODULE_STRING()").
>>
>> v7.4-rc1 no longer contains any __MODULE_STRING() calls, so I've queued
>> the final removal in patch 3 on modules-next for 7.5-rc1.
> 
> Perhaps send it for v7.4-rc3 to prevent *new* __MODULE_STRING() users
> from cropping up between now and v7.5-rc1?
If I need to send an earlier pull request for the module loader, I'll
include this patch as well.

-- Petr
