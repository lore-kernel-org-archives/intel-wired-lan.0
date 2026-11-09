Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36EC606A330
	for <intel-wired-lan@archiver.kernel.org>; Mon,  9 Nov 2026 15:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=XcffJlOT;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=V/Ix1knZ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8729080FF7;
	Mon,  9 Nov 2026 15:51:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KPwKfSylom83; Mon,  9 Nov 2026 15:51:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BF4D780FFF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794239516;
	b=gGDZgeSPAldpLcAKJvefeEqum90tyl/sC1L0YFtRRSMZADQi2cwAfvwU+kYjP3S1Kj6f
	 /X9Lo3jUO9G1lbvZLGtNDUDeSaYXeT6PbfjBem8LQ6bG/QwJHjuWbJnuq8WpvhjAW9j/V
	 w35V6mA/H+F8aYkryLgy6/Ts89OhfM2Tc+XQtDJFijYnzyk2/FqEKRlLU4seiXMFknxXh
	 prmnHz9dEEQJWLWCPo2tOwO9sP28dk8CNKGbOU26oqEK96B/+0t0lzL5U34Jy4s4KWCbk
	 bXVC3RPk0ALgDKVbFL3VI4cLzUp7yR5i1YxIR9B17DpnEga8V5AmREP2lbH+y13uYZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794239516;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Cc:References:Content-Language:To:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GqcUVOE8YZm1FPDzDze4+rCKgn8rK0xiBVztztTok30=;
	b=QyMx8xkGr1R7djdpc4vQ/jVEFU0OAmF5xv8fUId7EaosxOKsdfPz/OIQFbGXy/A/GRt2
	 x8luvdamt9hT4TGVxu1jLN6Arr8jFuafGQ3yW3+UE2fEkc8Kyd508Zw/kblO6GKP3Twk3
	 sAnlo5eaRLJzxFIFPd85hu919Xgug3yAfPGBpuK9vq0azVrwGVU15xNZDH6pHjiGzCDRp
	 tepQSaJ8HG8tVT840nlZ4DoaM97kOyZC2bdnu/qhrSp1PF7wBevInSdsQOySsK3/nLpFx
	 UsPrk9O3KJGlrCe1CVgfwGmEzYnz2OrPH70W95gHkoUUTl6XjqRwYIKKCfluuhcbKCQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794239516;
	bh=GqcUVOE8YZm1FPDzDze4+rCKgn8rK0xiBVztztTok30=;
	h=Date:Subject:Cc:References:To:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XcffJlOTXQfOI7Ppr/Rn2S2gCxpUAPz2NS2XaqJauZCMKMrnouy2Wkydg6pDr++oD
	 YP3qRbvbCvR98DnAbX20zki7szQUpiQI/9czev6YnnqCSZa4ye02jzc5Go8v+Tdt+4
	 KqC79llWBZL6QBvz2BMr8A3GrLG0RM7XGapc//dS5TQDNDyZvvxrIsXk2GgDKKEzL8
	 1izUGdPwpS+3CZAQ5Us3hJpPLvSs8sxB+LMTRqyHtVd9YOLmIV03wI3+8tjls+oPEg
	 2sWyJNd2mwtEfZBi67IoVjhQKb8NvwFECUlV0OYiWmsF/ZT1lVQksPHr1GXrF810MT
	 f62gYAyv4JJeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF4D780FFF;
	Mon,  9 Nov 2026 15:51:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A1B4251
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 15:51:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 500694010C
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 15:51:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g96gASmovvBp for <intel-wired-lan@lists.osuosl.org>;
 Mon,  9 Nov 2026 15:51:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D471C40087
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=petr.pavlu@suse.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256
 header.s=google header.b=V/Ix1knZ
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D471C40087
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 15:51:53 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-491f34b4e0fso462311f8f.2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 09 Nov 2026 07:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1794239511; x=1794844311; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:to
 :content-language:references:cc:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GqcUVOE8YZm1FPDzDze4+rCKgn8rK0xiBVztztTok30=;
 b=V/Ix1knZm9gA8HVcyvN8Jkp7o/r0y0u/YkwqtXsZuukKLAtgatc/PiQZPlPwaLvaYo
 5WtrPmky04QKKbPxS6ai0xZAQIZb6B3kQDIysUS/t5x+5XonSSzjav8C5kGMC+q4U5U3
 CXJSm4DgtL1vvhIDoEstdi41N3NYdxuLFNbJYFasRrb5xXyaR1/KvE5IGpxfsDpM49j2
 UXxs7nPIHvO519HaG0AThFHbLXJSCL7yUYx4E+L2xHYNfcsh93+iOA00bIScpZODK0pk
 VEQu4cCOZBP/UDUvH9OlB3jVVQmEA2zCYNqIE7HXqedU+eDhWiCKmv5BkKzCPOQE8QHn
 Pgkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794239511; x=1794844311;
 h=content-transfer-encoding:content-type:in-reply-to:from:to
 :content-language:references:cc:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GqcUVOE8YZm1FPDzDze4+rCKgn8rK0xiBVztztTok30=;
 b=OPlG0DoF/aQgpcazdw95UKZzKaS29ywekV7+0RGQ922Tq3Q/KItn7m1KC1b2/W/VPW
 9d9aqP9cxSwsVo/DkMWozJhq0KJ3/YOXhniX2Jd232W6EUYuQeNuz04reAKXBpvNMwvE
 v2Mlw4PBqhke1MexXN3/87UhfdWZjXTFjQURr6ImioNMc5VfV1WZgI9qPtPeM8v55Qd2
 9+AvCFSQi0OFbQNeXqoMdNG+2A/T8m+Rnjv2JGhQ9rN0AYc/RJuAC5pBOxYPXvwy5Lxn
 +MxceZ5RsSZVwwLtDA0AkaiDSTxYd/j/hDnVa1QAf59AN2T/qVC/EGabZhDu7ZJoCpp5
 UKSQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFLXxyPkD9zhEjZGqcN207aPvS3/o272Yct6IO0F1Gw8K/652IMfLuK0L653dtK2IvHjO2Tu+JXR+FOAPr+wx0=@lists.osuosl.org
X-Gm-Message-State: APuU4Z9OLPC/Xfhn11ypOUSG2s0k59lD3zk4OAslz4woTqdvxpr4z5Sr
 ceizWLcD8LPXFQ2mEsq09qMBbR5yqnafhKwA90Lhvv0xDL0AIyUzfxOo+nQ68xJMRjk=
X-Gm-Gg: AYBFou3NwstrX71oq4ScSBy9dDdPJAGWeCHTGNW5DdnM0VB5DY8QclpCVhS7rSqidk4
 KPRtkHMbodeHkIGsGaUD2V8jqTT8T7UUv5JbdYjS2MsmTZNewIPZEM+J25IFvxSzFASsOLNaxzB
 1IEzwrC0f141PvP6QU+2QSHwSaAB9eZQBBArbu9eMQ3HEALSJAzkNZzQtPSNbOzSRT0kNGRNzHx
 RgHUyFstN5DSm2cT3lwLMM8ITyVZDOuciHcve3MwSOw7t3NUt5/g5lEFCYxEPCEhnC2TdcAiefz
 O3fGvHY0PZWIAIrbus97mj0WegM81pya59zXWSAyV294uFpiRtsJZbzgsZis5QzSACKwJdUy77O
 KdNGexEII/Hid8bF7eHLdspqTun6TnesEZPctY3wIw8DcplM+xtyxEsarQup8SWvZqqDxiCswA9
 osh1jgzFYdhvs7e+hAPJ+0vOUHW7YYyGdtw/Tw4KOkJtnptNRcjLwZ4pXC9HSItH5R9NAI+/vX2
 bvVqB1X1d5hlAt8QBHITbJGTOg0UYQa1hjR8KwqT37PdAC7kOgCUf0BdwH3OrbtJiMIWbUsbTGV
 g6KNhHs7PSxMxbWoSBDpDkOI78Q0Q6EGbpiRLW0IpSEHRtB6b8aYYryRgFpqKq4P
X-Received: by 2002:a05:6000:25f5:b0:492:e1a6:90eb with SMTP id
 ffacd0b85a97d-49582e8e516mr8245452f8f.10.1794239511204; 
 Mon, 09 Nov 2026 07:51:51 -0800 (PST)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53?
 ([2001:af0:8000:1409:193:86:92:181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49597186eb9sm10435718f8f.35.2026.11.09.07.51.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 07:51:50 -0800 (PST)
Message-ID: <a190f981-d668-4208-8148-f4e50adb31a6@suse.com>
Date: Mon, 9 Nov 2026 16:51:48 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Remove obsolete __MODULE_STRING()
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
Content-Language: en-US
To: Petr Pavlu <petr.pavlu@suse.com>
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <2e88806e-57dd-47e0-a9ef-a8507d22aa3e@suse.com>
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
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/14/26 11:36 AM, Petr Pavlu wrote:
> On 10/2/26 10:31 AM, Petr Pavlu wrote:
>> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
>> MODULE_PARM support for older modules" [1] in 2002-12. That change also
>> moved it to the graveyard section at the end of linux/module.h
>>
>> Replace the remaining uses of __MODULE_STRING() with __stringify() and
>> remove the macro.
>>
>> Apologies for the wide distribution. Acked-bys are appreciated.
>>
>> [1] https://git.kernel.org/tglx/history/c/136839a1b4
> 
> I've queued the second patch ("drivers: Replace __MODULE_STRING() with
> __stringify()") on modules-next for v7.4-rc1. Thanks for the Acked-byes
> and reviews.
> 
> The first patch ("hwmon: Replace __MODULE_STRING() with __stringify()")
> should go through the hwmon tree. Once these changes are in mainline,
> I plan to pick up the final patch ("module: Remove obsolete
> __MODULE_STRING()").

v7.4-rc1 no longer contains any __MODULE_STRING() calls, so I've queued
the final removal in patch 3 on modules-next for 7.5-rc1.

-- Petr
