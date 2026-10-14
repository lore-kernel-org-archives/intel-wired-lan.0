Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6366BCC6B2A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 14 Oct 2026 22:22:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 10199608E7;
	Wed, 14 Oct 2026 22:22:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hciB1sv-OLcs; Wed, 14 Oct 2026 22:22:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 64FA6608DF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792016563;
	b=cTAX+EB85zRB2nCsrF2ewDYwK6ha/wysShpFQSqx3yfygvaEDmUHwj6L4Y+a7sy+SYqo
	 4OHWBsu/w/g1dNtX+/nZyqdmRMLtpBvPJMWNusNY/W8pweni3Ls8i3JsAjILpHCiiV31s
	 0IT2anHlgMmnRI4mlC3vxpV0Whph9DkFuEVMwwL+jdra4qYaHODRZ0nSzuJj/uNhajSJC
	 bkflCSGXjP3l12dzhyJ1YjRvDq75ZoiSR1x30Gi54qt3kKJaq0+VLx0lymrhFxx6/BjZH
	 4Q5B1OgVi4cjg8eVvrkRzS9UBB4ZSsasHGS+VYuea975FJcYLI/QARJbaTeOH58b+uQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792016563;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:References:Content-Language:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ns0B30INk3EFm5BYUh6uqqqCm1RVFpX8f2ZsoTr9sgU=;
	b=e9FQeJheGDmthIyMVq2pLkAYRTN5U8NxeUWzkJyYp8c8WTKWNdpIFfEF1Hqwzku43uHd
	 afNAPYanB+73BZTqocaqlkWyFY3U0JedNBB9HVWe0s67fqqkY03dP262j+Vqf31P/Lm6d
	 m26mDRCUl2s8MPEjGtD+4gu+Nny4eGz+0Yf8gy4VHcdonB5/id/Wo2I3U6G7fI5yFfS6A
	 hZIE62xt6YmSnGNdY3PjSjCT2j71km84LBTSPa2r2HJDm1zve54m7Bi01XYGYDtzrj/Ye
	 OB8nx5ztErS4LE/+krCOWKfdtLBAaYRB7f2DXSExqZcv82o8UDNPuvrofsu+r8qjd8Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792016563;
	bh=ns0B30INk3EFm5BYUh6uqqqCm1RVFpX8f2ZsoTr9sgU=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mX/9ZRkn63Vg5sFjqIm3Dn8/1kORxBqW0vUhTVP15u5g4jVtBBYfeYCLM+jVAyfSa
	 HOqTZiaXjiCEUVlty5X2zFVO6HnS/hnVFpOZOb12zCvMDCHdhpHOW/uU6S5vd7Iul8
	 YdrHHHmD5D2FG+/ycQNdrBjdAOl68jcrlfobkKstREuVMxc4IlgLF5GyOx2SGt9ARt
	 RwGTNdZEIwjGZJedwsZwuCHxMvXGiN5ayUkoO5fZAUSaJDFEkAv9AjY1qJCqt1HzVe
	 krBUdd2xFLTVweadYg64kheXEVrxI6j+xy+QK+F5FURQ7og5T11uPTMKupGDnKhxZk
	 IbKEzc97j8dIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 64FA6608DF;
	Wed, 14 Oct 2026 22:22:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8FD1C4DD
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 16:05:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 75DD7401A3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 16:05:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ivYpESaY5iF3 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 14 Oct 2026 16:05:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A87994008C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791993933;
 b=KAgFuqzpwAkovmXPmARkjSjpgjwQX9S3ofaAtB7r2+clUfUHjpxVyLOSj72TvaJM0oqV
 8/gGZIdt5OELQQ79zwfOpU/ye4DFcfS/el2eQfD1JAz73ScQkHOj+3CmsXbRd2NLJ1Vie
 3xxZXHWkuUxDaw6XYwZgWx9+2Smwe0jcb07ZBX5hB/8nZrCJaVK/bTJw3uVM+1FNfMASC
 Yj9amtnyPyp8zDFGTYLgAifVzMptZ69NV/2cO5B79i10kKIODqOSHMZd3Xs71Zkd1jbBj
 bFQL40V/4ZW76oLO3ZiwHREm98+MO2X/SJKKdD6s5YPE4BooFYCVaKUefy3ToUW1xhQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791993933;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:References:Content-Language:Cc:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=ns0B30INk3EFm5BYUh6uqqqCm1RVFpX8f2ZsoTr9sgU=;
 b=JqAVkTeoS17bmZqi6dd1rEmryI8Ti9Mrxwip8HA9BawhWN5HKV0zZ+0WgY+9UGIO2sLZ
 AqiQXTmyJZqm5sLTXBnj4fuPKITQpOiBc7ucheWntoYfJjQqFj2Jf7fsf/7s2ndVqbtxe
 wpHHbD+jYDf6EES7icAt+mVWVAlYRHPSdfBX5tbtw4+0JwV3y3+uOJWdqtXYM4LQ4/Ocy
 gt2p4le7DHlcsslHYWemFvaFMZQrJNFRusYNG1xWZR+JRj5xscrVg+05CPO66VuXMgGvI
 s1kHCfEiQKtnZm0OqMpn6Nrail/HbbPrWFxjIg/TKbAhZLHTSFS0gJr4McjeJyHjvlw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=gsLX8+BN; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com;
 envelope-from=alok.a.tiwarilinux@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=gsLX8+BN
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A87994008C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 16:05:31 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3a4b3ac8fb7so2034954a91.0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 09:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791993930; x=1792598730; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:cc
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ns0B30INk3EFm5BYUh6uqqqCm1RVFpX8f2ZsoTr9sgU=;
 b=gsLX8+BNKNAz+ENeItwP1fD3cUmzAOPcn3AmCv4VJkB1pv0PJZky+DtUOnq2LuD2d/
 WD1f4LVPncN6HK/GUpY4ASyRpSNWDYkkuyMMlPjeSN4xkiofTc9PKsYOD+JAZefAMK+u
 35WRa5stD56Nip9r/eyTNR1ZYGEuS6bUxNaAK/I7XEvH46IohAUUElSIYNg1ENyJZ99A
 APDzFyUuu8Ft0dbJjUABKPJaDxK2YEMrSWzKGfjnUdxfo6KBgOnm5fCrZArtYgLiVLRy
 rImsIrasNU5p8ltTy25qXgbQYI1ceMiPnssdqOjT7867sJjnGNS94oqWtPhBdAfa7Ph9
 5BqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791993930; x=1792598730;
 h=content-transfer-encoding:content-type:in-reply-to:from:cc
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ns0B30INk3EFm5BYUh6uqqqCm1RVFpX8f2ZsoTr9sgU=;
 b=Wte0zg1CHLI1yzT3kupgDQ2egfppMImaA1cT8gzDxfE7GCPMqHwZ5cqWY7twFWXXH7
 mD+KLjf4wEwSvPjcnN+gEHM3Y+Vbqppf31tpM3vPkvHpmspa5pharev12BN8UkZk6TxX
 pwepb6Z9hpwmB/+hmodsyQhZtlzQAza7uYhZJ64bFRd3YJuAU38qNq83NOJMlK86w5yX
 /hB+vv8hUnnGgstmTrSyMn/UNKxoUpcZqJRXzrbm53+c8eFcIpPn9qPTqR+yh6y+y++Z
 iftuHlnZnbjLTI4uNt++g9qn0ue6IZYACdA+N17fn+l+UQVoJifUg2+Q6aHIz32FovV9
 sHHw==
X-Gm-Message-State: AFq9FYIYXMie737sfq8gMIzV1J0jla4NiPKxOQ9fANuT80mohBOlu8nq
 41kkAAvl7lxQtaKP2TOG5IA/4SYXQ1BY9vEFTTwg0rFE+8/2u/PL1utp
X-Gm-Gg: AYBFou0iLrTgwEHvyR5CbxCsLH6BGgNw9rNhKVO8FTGXOc2amqAfHUoPihQPjjOGTex
 zlTiyUWcVkqdnh0zMwjIXZKNVZIZvWX2yVR8WViOSk4raPJiXzue2r5npVwTdxs2RZeS/D69dgo
 ieWlEfVcdAw+BEFRarP8AivMfZIUzoP0PaSCraD05e8SmoCp9u/JwPA4Tf4wE4nT8OnRmAESXkW
 rcXP13t8d6cx+TGaFt7RSsugXQlNDaxhlbwchMuAyC2s/QCtw2YVjAL/3xJpSmIee7JlpU4SLPj
 klw93uNpCxU6OVC7krL17hdqY304vxRTvtJe7dGSJ9p4p/etKp+UYEjYrqXHCNq2Gmb2fOeU2wI
 nMX3GK7VWU2koEltTUIZzkQpnh2pWgCcfXxbtsQX0T4/zvWGWgYc8KucXtJe0UhL5vXDYNjt3yG
 ozqJ49uQieMM6ij+iZ352WILqOps9Fz6onsX0F5TntNLlw6wWyb8kmAY07/Q3iAn0dEkwAJGAOP
 T6PfVgOQkYnr6YoAs/m8FPah0IMcsH2Ds4p2rBQ8RpTY66sPbmBOOWB
X-Received: by 2002:a17:90b:1b0f:b0:3ac:8ee5:e00f with SMTP id
 98e67ed59e1d1-3ac8ee5e631mr632522a91.57.1791993930011; 
 Wed, 14 Oct 2026 09:05:30 -0700 (PDT)
Received: from ?IPV6:2402:e280:21d7:3cc:a675:9f7f:5fd1:8259?
 ([2402:e280:21d7:3cc:a675:9f7f:5fd1:8259])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac947d2706sm35432a91.16.2026.10.14.09.05.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 09:05:29 -0700 (PDT)
Message-ID: <e614943a-0521-4528-a635-ce0cba7fa8b5@gmail.com>
Date: Wed, 14 Oct 2026 21:35:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ice: correct PTP register access debug messages
To: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
References: <20261011113545.16718-1-alok.a.tiwari@oracle.com>
 <IA3PR11MB8986155B5F35281999A764C7E59F2@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Language: en-US
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
From: Alok Tiwari <alok.a.tiwarilinux@gmail.com>
In-Reply-To: <IA3PR11MB8986155B5F35281999A764C7E59F2@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 14 Oct 2026 22:22:41 +0000
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

On 10/12/26 14:34, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Alok Tiwari <alok.a.tiwari@oracle.com>
>> Sent: Sunday, October 11, 2026 1:36 PM
>> To: richardcochran@gmail.com; Nguyen, Anthony L
>> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
>> <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
>> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
>> pabeni@redhat.com; netdev@vger.kernel.org; intel-wired-
>> lan@lists.osuosl.org
>> Cc: alok.a.tiwarilinux@gmail.com; alok.a.tiwari@oracle.com
>> Subject: [PATCH net-next] ice: correct PTP register access debug
>> messages
>>
>> Report a write failure rather than a read failure when updating
>> PHY_VENDOR_TXLANE_THRESH.
>>
>> Fix newline placement in PHY register read and threshold write failure
>> messages. No functional changes.
>>
>> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
>> ---
>>   drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>> b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>> index 3a41c711e751..289e0b3ef6ae 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>> @@ -1529,7 +1529,7 @@ static int ice_phy_cfg_parpcs_eth56g(struct ice_hw
>> *hw, u8 port)
>>   	err = ice_write_xpcs_reg_eth56g(hw, port,
>> PHY_VENDOR_TXLANE_THRESH,
>>   					ICE_ETH56G_NOMINAL_THRESH4);
>>   	if (err) {
>> -		ice_debug(hw, ICE_DBG_PTP, "Failed to read
>> VENDOR_TXLANE_THRESH, status: %d",
>> +		ice_debug(hw, ICE_DBG_PTP, "Failed to write
>> VENDOR_TXLANE_THRESH, status: %d",
>>   			  err);
>>   		return err;
>>   	}
>> @@ -2589,14 +2589,14 @@ ice_read_64b_phy_reg_e82x(struct ice_hw *hw, u8
>> port, u16 low_addr, u64 *val)
>>
>>   	err = ice_read_phy_reg_e82x(hw, port, low_addr, &low);
>>   	if (err) {
>> -		ice_debug(hw, ICE_DBG_PTP, "Failed to read from low
>> register 0x%08x\n, err %d",
>> +		ice_debug(hw, ICE_DBG_PTP, "Failed to read from low
>> register 0x%08x, err %d\n",
>>   			  low_addr, err);
>>   		return err;
>>   	}
>>
>>   	err = ice_read_phy_reg_e82x(hw, port, high_addr, &high);
>>   	if (err) {
>> -		ice_debug(hw, ICE_DBG_PTP, "Failed to read from high
>> register 0x%08x\n, err %d",
>> +		ice_debug(hw, ICE_DBG_PTP, "Failed to read from high
>> register 0x%08x, err %d\n",
>>   			  high_addr, err);
>>   		return err;
>>   	}
>> --
>> 2.52.0
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

 > [Severity: Low]
 > In ice_phy_cfg_parpcs_eth56g(), is this missing a newline at the end 
of the
 > format string? The commit message indicates that it fixes newline 
placement
 > for the threshold write failure message, but the modified format string
 > still lacks a trailing newline when ice_write_xpcs_reg_eth56g() fails 
while
 > updating PHY_VENDOR_TXLANE_THRESH. Should a \n be appended to the string
 > here?

Hi Alok,

I know this is pre-existing, and low severity, but since this touches
that line and the commit is fixing newline placement, would you mind
adding in the missing newline?

Thanks,
Tony

 >>   		return err;
 >>   	}
 >

Could you please consider this patch in its current shape?
I am unable to submit a new version with the current ID at the moment."


Thanks,
Alok
