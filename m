Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65716E77188
	for <intel-wired-lan@archiver.kernel.org>; Tue, 14 Jan 2025 16:18:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 19F5960F81;
	Tue, 14 Jan 2025 16:18:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VezRisorTx89; Tue, 14 Jan 2025 16:18:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BCC9460EDA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1736871516;
	bh=viLJXrRON3LuId3kJGF63clQ3P8ymoENgh5ioS2JxAM=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HsaS/WRWkOTrIiSljsbjyVc17O8V5/4Cs5CpOmmYYxWTet/hPEBHSCyB7hkR7N8BL
	 u1o3yRvYzS5EgjwRsmQ876TAn/QfajJOjFR5WOf53wRD+JUkQUtgeU3qSi9U8TulnM
	 QghDKvW3Uovv5qVoeUPx2tG2rIlhdp2u4ldeNQLCcxYVx/CV7AZWm1KNMsp7p9+1w9
	 z3yyKjcOu/KkkjbtuS+gUzpAn+YI/Od38mVV/s0zdic9pr5b0xzCV0TYwWOvOcvm2a
	 2wgC7pLXXSHl5kSCrUytHFqbGVd0XpkUcr1prIZAmCNRsubxwRmqN6WqMyeOLxJK1s
	 y3AXPTUUqPZEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BCC9460EDA;
	Tue, 14 Jan 2025 16:18:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0F8DA94B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Jan 2025 08:32:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E4419410AE
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Jan 2025 08:32:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T2gTOFcRllrR for <intel-wired-lan@lists.osuosl.org>;
 Tue, 14 Jan 2025 08:32:32 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=daniel@sedlak.dev; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2AC0740E1F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2AC0740E1F
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2AC0740E1F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Jan 2025 08:32:30 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d3d0205bd5so7926461a12.3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Jan 2025 00:32:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736843548; x=1737448348;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=viLJXrRON3LuId3kJGF63clQ3P8ymoENgh5ioS2JxAM=;
 b=G1vCNF2Kgpf6Syp8yCL9TfArg2o73pMtTCylkJl6V6hb1VVizyN00rR1ihz81hupVx
 /jglKwQdGhXdQP1lQk98zB/wSdHmRw6y9wr6+jNFMoY5O7NBkBkY4p65Kcbe+OZInA3e
 pfC6dsjo86NJVYJRmX7uxXb8LsarT+fxQm6MUV/cXBzsm2tPSjQ2H69TM8NTuL32A+ap
 e5zmHeEvPajxflezvoVgM8v3oShRxvae11LlislmKIScm5of0uWeKXRo7WgnK1yolIPa
 34kU/pUrzWb6IKg90paLJ99wF9nDzX/eJs9RFiRRbYvS1jRjpML664+SxKFgJTWLWOJe
 QpQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWk25K92GY3lEkPgxrzXBnlkLUgTjjZhLpmxnWFtEDe63PYJVy4L7STy/LWl7k0oERPiaMcOPwSP2QwkcIWeRI=@lists.osuosl.org
X-Gm-Message-State: AOJu0YxDeOZt0e1j6MDFRnfSOayeh8z/u1/ZVdok0avAKfKQhEuDT74K
 x6bH8PvspTqi/o/cdG3NkAxouo0Ck2cIwwgtGTtubQg/ZCPbyI2w20OprVCM/Mw=
X-Gm-Gg: ASbGncvDs94VZ65x4McN0ShfNmT5nKdmLSf3kkGwJTM3Mv6TLy6sAUeZKjYTvuNVwOO
 21xXXXfV/TLMIgMflORG9x7QRXTdtLYx0KJgHG3GPzVsaevHgLNHCmBFTfoiSsW9So+2JXp+jaL
 pKVJgW/ncUaE1dimVG+z1aAq7G/KRr2Z4iiZOczn8hyOmGoilDN8rppcL4eo8BeixH14wDKwPrJ
 0EJvdlTLHzpiB+dwX4EWdfqJ8q2ssewPemk/u48vsIR3bMMcAsWIR+AY4sU5wvy+Kc=
X-Google-Smtp-Source: AGHT+IEoAu/bHC6PMPvHq2cBmT5tImWGnk5L4zFRS9n/NANKyF0/dMSpnJNaS5yxIlE07gPl4SJLNQ==
X-Received: by 2002:a17:907:1b03:b0:aa6:86d1:c3fe with SMTP id
 a640c23a62f3a-ab2ab6705b8mr2506074766b.4.1736843547977; 
 Tue, 14 Jan 2025 00:32:27 -0800 (PST)
Received: from [10.0.5.196] (remote.cdn77.com. [95.168.203.222])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c95b299dsm597600166b.160.2025.01.14.00.32.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 00:32:27 -0800 (PST)
Message-ID: <adf7c053-ffde-4df8-bc24-99740906410d@sedlak.dev>
Date: Tue, 14 Jan 2025 09:32:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org
References: <ca5056ef-0a1a-477c-ac99-d266dea2ff5b@sedlak.dev>
 <20250113131508.79c8511a@kernel.org>
Content-Language: en-US
From: Daniel Sedlak <daniel@sedlak.dev>
In-Reply-To: <20250113131508.79c8511a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 14 Jan 2025 16:18:35 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sedlak-dev.20230601.gappssmtp.com; s=20230601; t=1736843548; x=1737448348;
 darn=lists.osuosl.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=viLJXrRON3LuId3kJGF63clQ3P8ymoENgh5ioS2JxAM=;
 b=jeOlSx/DCoRuotOy/8jHXNLFg/2S5Wy3zIm0DQVsyX15W9jbNOkAS/eKLW7kXfLdx6
 dLBtwcnb/kNjuQLdWb8xgEkkmO3Y+Q4g7ycI9S0MLdX/3llc5g2b+CgiGn9tZF5j7gFJ
 cEYoOd2ufRJ27DOW1jVOMls21AAVWJKd72DSjhrzGI3kCqRqheDzPol28aZcPfWbFfRU
 V5q4EfyoMCLHmNdvOznza/ZDERFmKqyA9KDceBSLVQZH84OtP/j7gMnFp2kX+wgNXIKd
 vO3cHXR+YXyiY+iyPEPZNtDGFJgCXqsA5/wGdeA3CVuKvNiOx8gpAODx9ImthecADcDy
 FOCw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=sedlak.dev
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=sedlak-dev.20230601.gappssmtp.com
 header.i=@sedlak-dev.20230601.gappssmtp.com header.a=rsa-sha256
 header.s=20230601 header.b=jeOlSx/D
Subject: Re: [Intel-wired-lan] [Question] Generic way to retrieve IRQ number
 of Tx/Rx queue
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>



On 1/13/25 10:15 PM, Jakub Kicinski wrote:
> On Fri, 10 Jan 2025 10:07:18 +0100 Daniel Sedlak wrote:
>> Hello,
>> I am writing an affinity scheduler in the userspace for network cards's
>> Tx/Rx queues. Is there a generic way to retrieve all IRQ numbers for
>> those queues for each interface?
>>
>> My goal is to get all Tx/Rx queues for a given interface, get the IRQ
>> number of the individual queues, and set an affinity hint for each
>> queue. I have tried to loop over /proc/interrupts to retrieve all queues
>> for an interface in a hope that the last column would contain the
>> interface name however this does not work since the naming is not
>> unified across drivers. My second attempt was to retrieve all registered
>> interrupts by network interface from
>> /sys/class/net/{interface_name}/device/msi_irqs/, but this attempt was
>> also without luck because some drivers request more IRQs than the number
>> of queues (for example i40e driver).
> 
> We do have an API for that
> https://docs.kernel.org/next/networking/netlink_spec/netdev.html#napi
> but unfortunately the driver needs to support it, and i40e currently
> doesn't:

Thank you for the link, I somehow missed that part of netlink…

> $ git grep --files-with-matches  netif_napi_set_irq
> drivers/net/ethernet/amazon/ena/ena_netdev.c
> drivers/net/ethernet/broadcom/bnxt/bnxt.c
> drivers/net/ethernet/broadcom/tg3.c
> drivers/net/ethernet/google/gve/gve_utils.c
> drivers/net/ethernet/intel/e1000/e1000_main.c
> drivers/net/ethernet/intel/e1000e/netdev.c
> drivers/net/ethernet/intel/ice/ice_lib.c
> drivers/net/ethernet/intel/igc/igc_main.c
> drivers/net/ethernet/mellanox/mlx4/en_cq.c
> drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> 
> Should be easy to add. Let me CC the Intel list in case they already
> have a relevant change queued for i40e..

Thank you for directions, will check Intel's mailing list and poke 
around with implementing that.

Daniel
