Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE26CC6B1A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 14 Oct 2026 09:36:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8329860837;
	Wed, 14 Oct 2026 09:36:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YZ-Q6xBfyIgB; Wed, 14 Oct 2026 09:36:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1CB36607ED
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791970585;
	b=Pp0pcGp7eFE9sxkMGvssBAN3FP4HX9SWbIuc5bkZpPQWeiSHD0VJ9sha3sNX1v8f/6MB
	 KDhNLDL2nLPvMfQ2vem+BK31HEYx/S1MTa1gvsffLr69hcoxjgEtFozGw9BCh6UA/Ooqa
	 zoZn/VRcu48vleVGTYgbGfv2vwjKEUcPPQW29uiQ+7fi1MFlPhhn2cXo88X0Y1xe3Y0Pg
	 kGxeAGBZUDs/2XSdmUMOClWpeD/87VFvPBM2X2DRSRG/3gVZqyVJgx1s1JbWlGWDekym0
	 Vs0C8d79M8L6uIPlOb3ctWNNILoOb8Kj+tw44uHMMdYMqX3B/jcelrYldQtwaOTRQXw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791970585;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9nFXolfpittgi2Lah9fQ/bqQ/j+/1tOBiVSyiO7ElMg=;
	b=H819Od8AoGmUauGAVYZwrxVYRmLiq5gj8YAosJBiyZbn2N4b8U76C+1yJfO7dYWZZ1TJ
	 uIqovXKIG+rqnA3JQJjreOW2sF+CjW2e/5OW4/DjFU0Yky5L80tU3XumnWXSOlPEOq0lb
	 PBXYa3s2JWrSVN8cYqkcZ/TWVNMMZjAmjH06OaqZJ9TRBVfjqlCpzpJDE4RcKgO5Gc9+r
	 vuKjqhA9uYZYf/hbJs2aH/lgKXvHvmmYDo2U/sKocfhCZOzVSS9b5wjMpN5HaAMPyqHKT
	 Z6vDp3lNihKLHGHbG+Wf0ZphTlH34J84dPqoxJ3vRFPmMMWgh69txUWHmXG1H/acbkA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791970585;
	bh=9nFXolfpittgi2Lah9fQ/bqQ/j+/1tOBiVSyiO7ElMg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=msDzln5FJ0tK9aLoIVm5aKjh7+pwD0/CfanCXj1YC/0r4DUJ+0aiGdAhpu1G8WIEv
	 5Fxje5CaC4PaW9iGAHw9ulQeZarC3+GoUGfBeD5dUVc47Jv9gRp+bhIXaHdIibtGHt
	 iPgKxk5NiQgzmd092ohwEdbPyOmaLtrbPecjoVH9upPy/nSW8DdOs5wKLGnSELWEQ1
	 LEVogKwSgH9ECRPyDYDQ+g8z23T7Gyl7zABqR3ICR0WmQJLWP0zuVlg/GYL6oXkD+i
	 OOcXha3tNcqkNhqAa8oIua9IxAiIep1sL7S5QsuBypihMrrcLKlmtOnTtPjzcEMk9/
	 +/cYbehl20ZFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1CB36607ED;
	Wed, 14 Oct 2026 09:36:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9D6232AC
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 09:36:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9AF1740080
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 09:36:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rEuXjiJOSjqX for <intel-wired-lan@lists.osuosl.org>;
 Wed, 14 Oct 2026 09:36:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 71C2340079
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791970582;
 b=SMtREFJq/fSBbSbqRQOtI/wtXIzZR65rZfvR4Igsj6vdlpgA5xi6vLoazHIdcRESMwbX
 gETYBQp6BotWjyVox4ssxHhn3E2iPGsY/3FgVeVDLeacYB1IGyVk+tAT3xJwsNcuvB8yI
 RlGfmeD2PC8s0dG+rmOOEkd5fbEBLs6qADDiloev1IpGEu+GFG0rhX+GAHnBIamH+i0aI
 /rn8JywD1UAPUxKzK3Df9UEtoZNdkrdy6Vu13sBGTlLdmQb2cERvvYJbG1gqduvpY5Vbq
 vBcuVVQWiVkss697ENQCZVre46azc80pqTSA8FxjfE0qeMThyVdAUzhky6k3GuHtC6Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791970582;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=9nFXolfpittgi2Lah9fQ/bqQ/j+/1tOBiVSyiO7ElMg=;
 b=pV7sqWJ90A1J2xVOBOWgHWITBq/MPYQB0sO7f8Iaf/trMW+l+wsH37/r/Fcw8RYrr8Up
 AeMoVlUmCJ+knOOu+4Q4n4IhyhsZPF49WN/YIR1yIuEfhAHfNWf+wcHEumjQAcnkNUvVp
 NppCn7UxW0Difr3g4lmUe9MPhRk0ecMmTidtb4SNBLh6pE5WmuARw9n8Xnztm+WtX9ala
 L0xkGmJWUDW8VC5SeJ1a37M8mjEyJ/q+cHLJm+UEX0GUqELESQGKboCh3/Q/wd7mhgE0v
 3sthUPKPQHuMt5JXqNlme7ackAF9skEpgtmAxgT32cGiT3iNP9Yr3f50yMtkuy6XZHQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=suse.com;
 dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256
 header.s=google header.b=IfkE5mLY; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com;
 envelope-from=petr.pavlu@suse.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256
 header.s=google header.b=IfkE5mLY
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 71C2340079
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 09:36:21 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48b0d19cf7eso3880499f8f.1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 02:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1791970580; x=1792575380; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9nFXolfpittgi2Lah9fQ/bqQ/j+/1tOBiVSyiO7ElMg=;
 b=IfkE5mLYUtTaI+dSi11AC2kSJfX7c92rqg7/tnikKUX+X/jolaXmyQSQlpWNh/y1PR
 jEqwVVCBq2OZ0ui9e4kIWV/uwQvpj6kpi8oPJHcktWrleaO+o0gILN9JkOFFBgR97tN6
 aKxh7OV3WZoM3crR6G0bHS26R8rUtBk2/0yM7wUfbDCiKrHoEzZyiWe6Stj3rO+sQBlF
 TMZ0A7RHy/RADtT8Dj85//SfDhe8cV1IB2EoG3yIB/Iyt9SwnVNSxrfh9DKTINU33HzM
 EFKpy9OK2YaNQUcwRowuYK6iP1s9cr2BZo0muq8pKLGGZXQ+Ma95RFrNuUN7S0Me11NQ
 KYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791970580; x=1792575380;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9nFXolfpittgi2Lah9fQ/bqQ/j+/1tOBiVSyiO7ElMg=;
 b=SEdg2VAtXfdpUEz3BsLkf9PSJLV54g+x9/NdM9h8wbwn4lrDFghXsKWE2b6UUp3PJf
 utd2MVIouFCdD0EEBRb78qCoYDvYn+w8SoI7iduS4gcO7JGJM5juaaD37WtOrzRuR1Tg
 j0pChtJIf0TUQIVUcdIc+TSQVeQbjRSJKwyLS3ZLpwccPqg1QjRMFzpstFtHQDIbT94O
 6AgCcvKHDUx60XZzU7J4oKfoSLT/7hCtfsmhuqGP9EGk6/k2VRMJ5M4WMPaO3QQemZSd
 w/CrOXk88j5btu7RyeJlPUIruD7eQVME+EsZjNvyhTEKrTp6qZ1dN2KsINOdP+FuQu4v
 x0Ig==
X-Forwarded-Encrypted: i=1;
 AKwUvBzdmClfRIvCXPoUp1qIVNRkw5QpYimjMDScz9j937jjLf+LbNh2MpcJSZUs19JKAJo1InAhiIq/47npHlQmq5s=@lists.osuosl.org
X-Gm-Message-State: AFq9FYKLEPw2N2KEvgwUvHIhtunKYHnRCrsWrVzMxiqku/2ZeeVeKohx
 iCohY7r10yJfuX+0z5xkgl+8jsiNo+b/QsMRG9oS0SGgqTOWjBeN4JpYBBIZK9E/OgA=
X-Gm-Gg: AYBFou0tk6sja/mUcJbcEyqi8+fOJly+p60PoF4kg0hmyoe46GrAA1KrCveCiHXx8TO
 g/n1KryZ3r1lBlwAefD2Ski52K8kYKYnZ6Yh4hgK1LJi8ohx0qy2PtilDZVhPEtg4mf+q8acWi+
 wljrpTlQ613SPI7+Ev0VUsJTqHB3Y0E2CayTsxITItRvGnVvOmBTQeDDwl3KjB1QrIV1Cl8P5rL
 hFBfv35SIubEBZHDg7EZfXGR3Yya2bOaq4ZjWvjZ0+rJfNEXOeuUvNZviXVFtGF0nYSFN4IPsan
 bdTKE2acnbJKaFx0rEvH2fxJTqXAsruwFW1DoghWVEMgDVYl4qifrFzsv76Iq++BN3j3OTnGwD+
 KI0cgsYcZls1kwSJJ1BNkZpjAkNMr6OqO29XBq84mxd3prNME5TdIXb1gUX6S+vs1QaPe5IyOK4
 Y5FvdHi2BNCVTjr3f3NdyBMeg/RjlixGjaMcIQvAZAp2RrPLCMky5jk8PdxOLRGEWREHijQSu4H
 lmxCmdZSnLvCGTsorTnTQLfRdC+/kn530oZkfNt3pp78ZFuPUOeT8CQ8Mm0cCjXuhw93y7OJ4Hw
 BOaZQhWDdL8DHZJyYvxN4u6KWLqwnP8KZNcGvr26
X-Received: by 2002:a05:600c:8a09:20b0:4a1:9c98:b9b8 with SMTP id
 5b1f17b1804b1-4a19c98c153mr160846965e9.11.1791970579795; 
 Wed, 14 Oct 2026 02:36:19 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100?
 (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz.
 [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0aaaa3fsm10907378f8f.10.2026.10.14.02.36.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 02:36:19 -0700 (PDT)
Message-ID: <2e88806e-57dd-47e0-a9ef-a8507d22aa3e@suse.com>
Date: Wed, 14 Oct 2026 11:36:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Remove obsolete __MODULE_STRING()
To: Petr Pavlu <petr.pavlu@suse.com>
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
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
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

On 10/2/26 10:31 AM, Petr Pavlu wrote:
> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
> MODULE_PARM support for older modules" [1] in 2002-12. That change also
> moved it to the graveyard section at the end of linux/module.h
> 
> Replace the remaining uses of __MODULE_STRING() with __stringify() and
> remove the macro.
> 
> Apologies for the wide distribution. Acked-bys are appreciated.
> 
> [1] https://git.kernel.org/tglx/history/c/136839a1b4

I've queued the second patch ("drivers: Replace __MODULE_STRING() with
__stringify()") on modules-next for v7.4-rc1. Thanks for the Acked-byes
and reviews.

The first patch ("hwmon: Replace __MODULE_STRING() with __stringify()")
should go through the hwmon tree. Once these changes are in mainline,
I plan to pick up the final patch ("module: Remove obsolete
__MODULE_STRING()").

-- Petr
