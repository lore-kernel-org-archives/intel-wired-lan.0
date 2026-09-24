Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDED6C98314
	for <intel-wired-lan@archiver.kernel.org>; Thu, 24 Sep 2026 12:41:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A0A528107E;
	Thu, 24 Sep 2026 12:41:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X31VEyG-6fmp; Thu, 24 Sep 2026 12:41:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C0CD581DE8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790253670;
	b=fgv5ncfVSXek7U276kRxPA5aba94jsbtFrIGAtBn8V6KmLhn60WFxApAyUIdP+YQY0O3
	 HcebtkdOjPxRKVFEvFJiepIT/NzyATK9jzQYcA8YXKGt0b19Lk2/xy34l1BGi8vuPr5Fe
	 jtJ2YDn9kGF1tpFx6YDEBc2/JaattpwXXOsXCa+VPfRzgYvgkNWuB59opz5aRHZlN7Ith
	 bFWXVC1bkIO/h+Id4yvuXL6qiOyeamKdDVB+F0ei6/QYyY0J39V7eeDjoZiFCr2LSbueu
	 jEZ6MXoqC2sfIuuyGcUOUHzFXWbFTztIaxvp8HuxM4VwipWmdKxcnWs0KgVvr6ncfUQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790253670;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=m+K9xI1+b45+Hx50rEe06X/tskVciHAk+ndafWRnnYs=;
	b=ncKnEXyBEdRwW/5jMUAKAd7gWJmbdBIveOn4iuNfpqyTdZBcfVVUnK6o4zfU89s6VoYb
	 boRl6SwDvlOb//8qkYhHjsHph32421JBF73LymSNJkofWQVCcBOifRsJukX6EYWyfIoie
	 YWmE5ZbpsAoWqNMCvuJfN35QNi3I5RoSm1qIiHWk1bR9KfIiMy7kllz9v3MBIjylxySPf
	 Zm7L2BjTnqlbykY+QJoAlo82KpMeb/T82YxT/HnPgpoUU91/n+041bPgxpOYN5Q9Kqyhr
	 l0er5SOOutqpoiF1+c+bXWcmZwQbkFEo8bCj8sgoLhI1u6PD2DvK4sPGJKZiMVAsBKQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790253670;
	bh=m+K9xI1+b45+Hx50rEe06X/tskVciHAk+ndafWRnnYs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hbJoAtyI+V66YjYUMjHN7OcODMCNHV486VCz9v+7lh9bvaQMdkt4J0eSEWPb57P+3
	 Gy1dPukdoFCW5UQ8giQPs/cZlL1+UbdYgSyOVmrq7KQxCgmFEsFkL/f9qj1wUAGvpV
	 Zf+SJMZUzO631eSUMFXD9Srie7q9UzRS2FCTk4lPqMAhbYzVC/0IX76yx5Hcy3FxCa
	 0JiA+NF6Niuj72O960zx/rTKxHPWz7QkoowCVo8Geuyeyf7dy1lNFZjhKHndJjoAVK
	 KvOSUM+P1fZ8ZkzLkgPEtsg4A/+ICzvcklk9K2P2P59jkWqScAfbnM+qx3YZA2qukg
	 HIba/4ihKwf2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C0CD581DE8;
	Thu, 24 Sep 2026 12:41:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BA7B835A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 12:41:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ABF2A607E4
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 12:41:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0gQnLvKbs3H5 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 24 Sep 2026 12:41:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 66B5360626
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790253668;
 b=nb4oSlNuccuX0m4muZbtoYAr1JZNv4F0JxfrEL9fHtnHXPboz+u617DUjlnto96qJfG+
 JbK6paHwkeGlTiAgQ5QeVF8jXRnb6fpb7mZR/Yr4i18nOl7kOfJkGZ/7MhBD7qgaCOyjc
 e3E1Ez0Ft84GakMwJ4oQANTYfIEMKs2nTfqlVZ5kJkBBUtw6Yng4mCZnArJfa4PTCYsQy
 dbgwqEeNKMeot5nd5kxlLJbFTjE0/M3vV9zob/eGQOOMpECaa7irvsWYnT62xlzr1i1kz
 /f6mTQH0olYtcxx2BKz3z43WW8uiAulPB7RPvvaZXrieXKYbdxnEOS3F/Hcboj1bzMw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790253668;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=m+K9xI1+b45+Hx50rEe06X/tskVciHAk+ndafWRnnYs=;
 b=a3zOdL68lMP2Sk1X0zartVJgO+WQQDum/n5EF/ouj/uXEyJi5yosQeukzjQJGUvH1vqr
 F0RRJ7RY6K8Hk5PENEKKODhqh6swov7VoCMHvZ7Xsbfiftmbl0ZF2qTamFiJXjhZXOICR
 e0wZIOuBx+dFSTHFF36g4us1s/ttgoNKOjI/dYMxAC/XeGUc3sg3gsjhiMBkuuDWLdoEJ
 HPpi/nZ10JO5A4vjTqwi8GxKndMJwR6Swcxv9QqaB+cbfymbng2tZL3yFA6BmzzfHb2GB
 GltSMefx3QvIScOm0xcMRvtRN3pBat1SCviTksZHeaRtRFNLEOmEFr8fkNS/yM/2+Kw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=suse.com; 
 dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256
 header.s=google header.b=UAujFYuF; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=petr.pavlu@suse.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256
 header.s=google header.b=UAujFYuF
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 66B5360626
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 12:41:07 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cd38e0f79so11461915e9.3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 05:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1790253666; x=1790858466; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=m+K9xI1+b45+Hx50rEe06X/tskVciHAk+ndafWRnnYs=;
 b=UAujFYuFttJmR4M8+M2Xfg3Ff/9Bg9sjfmlUXAdUh6YowUtN+Vk9l0T2WA6qiQ22fm
 Af0m6S4Z90HlPKtLOhV0XV9F9XKFKDI6va6HRU8eOzW7t3lfvXL4BSHvJh/nREfmJPtl
 MwpRQvTHS8TxtDqXf8Lt0UnmzR71B3sNtOZm86XwsKPO2OqHPqAvtRut9mvrw8hH3DOg
 izlZqcEzhE3/02yDnW2tIqtdqZ/9Hyc34n2s+XOmg0J1ujVZoGLp5KNGJhpIimH0CzCS
 4IcfDLSKyvnPGmdF/PQ24pcanFaoVzMn7THlzneQ8hPd2Xux4qDnZe95yjZzDJVIsRj9
 NQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790253666; x=1790858466;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m+K9xI1+b45+Hx50rEe06X/tskVciHAk+ndafWRnnYs=;
 b=r+wIBQyoPGjbEKhDAdFvXWTI7T392tM03jfJo+3cy12T8LKnNx1z30S/pJd5kHd5Mh
 v8nUjraaMNxwJdIQX4Se/iy4bTGXIW8pS4zYUZdrjYBj+k97OVhc8v0w46GsAFRemKku
 8iUcMb20iPWqI8TgCLOD/HxKxvRGpRG4BGwr/eS/6ohJfKc2LOqbm+72H2Hj2nbkuN8b
 sCXJzWB5GKrtdl6SjnP07sInc9Li+xzJwbrAUvg3R4sKLLiXbDIeR3hVyDszlbiUqFNv
 vsiU8kZU4OFAdkyMRrgilQiSyetpubW7fDLp72fVdVknbE68Hafjd06JZgwgZXFwRHtK
 eMeQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzpSwM0yMyzHS/zl4aI6Q/bq3gx4WJUmv7UpBEguBVApvyFsYjTInbFXSlbhRdmCuKwPINkcARJZIWBdDhVK9A=@lists.osuosl.org
X-Gm-Message-State: AFuF++nHWTmMrtzAbVHdiQTobvCmPn+ZrDAPWSjP5EtduQlgUaKL7Pc+
 yfStDVsrjEa2zWKWNiaaGuba9s3u2Fwx/sGJQFNQm2tWPPGWcyu51S7xS4tsVxV4DlE=
X-Gm-Gg: AYBFou3yfM6Dj+R7VEasxFPcl+nFEJPPuMhgPzYV5Cmcx7tIoB1WT4S5M+ekZzpvfG2
 WuMZamTwPaqhNfefZRSd+z8ztVNKw6pyImCYGcy5Yu1M4ZccwW3S9hEwtQSTiOXAjTps0sWB9Kf
 oammls0DMGxBHr7J0q8pQC6zRVggPbFQDMhIgyBrVQppbnaPX3mGNBTMHyHmwpYjCM6jiov+K09
 vqzeiYXph5LPxdtO6/+JUx3DTsWICIF/qhZfYHRRFc8jY3lnktx318idM3ZlmXpfXsWfIbRn8Fp
 K+Bj7YgacBB3PKFfnaf0lhlwSkyxP97QVUIzUIJ1PyepUXzymbEjOu8D2SA2FT+BvlV4/iJSszN
 eVzbw+xve/HtfNxcDRfaPsM5Xw+kSCBqdVzLYtcBRZv47vgZxKclyAa8c7o04Wv47t7xT+vkeSj
 XZll/gL96E6rpXQUhTMntkelMEDFB1bIg849a1APWxEsnWGN7dJy/DA1xexNJLuREaVHYpTP2q4
 HRKiiL/OHRU4tVXDhcm0tobdfNYuKcB9pA=
X-Received: by 2002:a05:600d:8642:20b0:49f:e8bf:c38 with SMTP id
 5b1f17b1804b1-49fe8bf0d97mr19384015e9.34.1790253665749; 
 Thu, 24 Sep 2026 05:41:05 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53?
 ([2001:af0:8000:1409:193:86:92:181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5cbd77bsm78152645e9.8.2026.09.24.05.41.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 05:41:05 -0700 (PDT)
Message-ID: <f3b91a89-2733-4159-98b4-129e3127e7e4@suse.com>
Date: Thu, 24 Sep 2026 14:41:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drivers: Replace __MODULE_STRING() with __stringify()
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Ian Abbott
 <abbotti@mev.co.uk>, H Hartley Sweeten <hsweeten@visionengravers.com>,
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
 Aaron Tomlin <atomlin@atomlin.com>, linux-watchdog@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
 linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rtc@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-atm-general@lists.sourceforge.net, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260922-module-string-v1-0-c18766690185@suse.com>
 <20260922-module-string-v1-2-c18766690185@suse.com>
 <cc03390d-8fc7-422a-bbcf-93bfbb82276f@roeck-us.net>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <cc03390d-8fc7-422a-bbcf-93bfbb82276f@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 9/22/26 7:21 PM, Guenter Roeck wrote:
> On Tue, Sep 22, 2026 at 03:32:22PM +0200, Petr Pavlu wrote:
>> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
>> MODULE_PARM support for older modules" [1] in 2002-12. That change also
>> moved it to the graveyard section at the end of linux/module.h
>>
>> Replace the remaining uses of __MODULE_STRING() with __stringify() in
>> preparation for its removal.
>>
>> Link: https://git.kernel.org/tglx/history/c/136839a1b4 [1]
>> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
>> ---
>>  drivers/comedi/comedi_fops.c                          |  5 +++--
>>  drivers/gpu/drm/drm_fb_helper.c                       |  3 ++-
>>  drivers/hwmon/fschmd.c                                |  3 ++-
>>  drivers/hwmon/nct7904.c                               |  5 +++--
>>  drivers/hwmon/sch56xx-common.c                        |  3 ++-
>>  drivers/hwmon/w83793.c                                |  5 +++--
> 
> I don't know how other subsystem maintainers want to handle it,
> but please send the hwmon patches separately; I'll want to apply
> it through the hwmon tree to avoid the potential of merge conflicts.

Sure, I'll do it in v2.

If other maintainers would also like changes affecting their drivers to
be split into separate patches, please let me know.

-- 
Thanks,
Petr
