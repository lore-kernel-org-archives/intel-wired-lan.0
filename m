Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7715DC61DD3
	for <intel-wired-lan@archiver.kernel.org>; Thu,  3 Sep 2026 15:56:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 340AF60B73;
	Thu,  3 Sep 2026 15:56:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id leEGhG2026bn; Thu,  3 Sep 2026 15:56:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6F79960B6D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788451011;
	b=RlbgH2zDY8dpuFyoe7phXZaJMDZZZkv6jq++OCBEDDCC6HnyqDAXe/+72bigcXoLBjdG
	 P5ETx0KQBKWr3BAhQcCxH+EVkn4MzB7CjAPK5zSmBwoobPD1Ye2ac5dYm3cGSFEWlb8L8
	 Niyem4LSLo21bi4K6EfrhI8D2Xdtd8XXvm+p3mRWKSaKxnW2keWHEjo9U3rEYYaHHSUeb
	 g4v0GKpEnhaJu2ekp+FncImUAVqSv8hH3c1vElWbA2YwUKxIArqKmZ8pwPGikqsLTSEkr
	 Z5JoS3/LcR+FAUY4vuB/cmsirxxZft7BAA7OZhCCSnFRmOg3AD4oBLyiNg7zyGtzOyA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788451011;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BU0pHPVrhHdYT1WkFVjJDxv8ZrMHIUMFXolTYoauB9k=;
	b=pV3HQdiX4slypSBxWNb4KeLKZNFzPIGvTc+itpjfAHun3/8iGpqkOs8GqMrtuP0M7d4L
	 /8DG+dpSJ/OUBr5VWnXxVOMLJ/hjZFsvljklZJJUBdfHoyrQ04hJsLsAItxx+g8wTo0xx
	 Cjo8rdCHjIsUvCHjFowMj7hEIcL2zx3pNRSguSnxPx40GdPuKcBsagxCTRPHsgS6b+tT+
	 hq6T2kKkIDZ5gNslWTpIhpIIAcxN/+nKdwPYNoVmNQsU5U+5h5OameW10bgJ5ko9j8B8o
	 Rh73F0OMk1ImW/S2PljXphA8kUxZC/UbpX4xp3Ak6oFeQt2Oj6pbY6Hry3hp67LHzDA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="sl/Rbaxr";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788451011;
	bh=BU0pHPVrhHdYT1WkFVjJDxv8ZrMHIUMFXolTYoauB9k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C4vqAtrBUykj8JLc+Vt1JMPCvjLcCfF076pqynfqrS21973AP/u4B2xGJ2jQLvptw
	 hjbT82S0z+fUi1M8o76AU9C8k+uDER27USfZYVfaUi1/q7VuiSZa6Z8e8/q97YRT/o
	 yHnE8IFBZAaMAe+YHIy1FYyFgXRsoH6T6H5QaVKJ3Fz5nLCC8t3JsRUny7x8Tfbj+m
	 /lepYTuJ+voBPl/ExgQX/ZJ/5Lf1PM0H6pKvGr7S5mcEJ4gBoo6tBFe2DU04QBXYGv
	 U2f9SSDNBL5UGGI1WVMZyDa85JlvlHEpD0XNuBn/HteH3ZY1fZG3N0MVg/gHF0tPG1
	 VHZLiQssNfPLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F79960B6D;
	Thu,  3 Sep 2026 15:56:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3DD022FD
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 15:56:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2F36E60B6E
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 15:56:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SadPE-V-UhBu for <intel-wired-lan@lists.osuosl.org>;
 Thu,  3 Sep 2026 15:56:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4598160B6D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1132"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788451009;
 b=Rl24zNjcyPunZoVFGEXi93ipjjkJOlILYPX6nRFJIHxI4orz7Q3vfASmWTYeYxJ9kgd6
 4Hv8lLmFfkfiQMF4G0KvDlRdzhkx9V2azVJOkGUoC5PoVr8ND6Dwquz1L8R4iA6b7c1Y8
 5bD8zq/29DQPARqplQWhhF1tdlYrke+7Y41ixwVtlck0d1Hm2kqYhnqVOZSRrCs3APWRr
 9Otx1XnKRlepalcdYHdvgJ4o1D6VbrK4DMkalSu+GPnHkUZZCFwzHG99EeoJVTNtOizk9
 irLoIPV2LNLP9af4bGicCSeCSzYnYmSiehlOlGtbz4LSTUn9ANB9gryVKvlItT37XMg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788451009;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=BU0pHPVrhHdYT1WkFVjJDxv8ZrMHIUMFXolTYoauB9k=;
 b=Tdfyh0JMktYjm3YAgAORu/wJxDz4KjNO3B5x1tf1h28uBqtGnZbfQMXPMG0UX4SOt3qU
 eo9px3ik72B4L+xZn4RybEFSEMzbDHfPoT9TLuNKAQRZqnqQ0k0j+1GHXpvWrrDV0kPb7
 W4lMRri7xqaqTVYggeHShE70i1JV3vD3NgVIhTb8w+bSPszARrHX3GDAjNNae9il4+cHI
 sSY/E/6HG811zmVCPIY1lZwwuThDdh+1UWT02X8jLC91PIrFRe8Jo6gts5lPMvBdcY2hZ
 ttkY2hL/kGhjCEREkQx+Uq9VpMVMVeDVUZu0ficdXOc1TZrRIcPs1O9qe35aSFTkjdA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="sl/Rbaxr"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1132"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1132; helo=mail-yw1-x1132.google.com;
 envelope-from=tactii@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=sl/Rbaxr
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4598160B6D
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 15:56:48 +0000 (UTC)
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-85a50f6a7f7so239867b3.2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 03 Sep 2026 08:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788451007; x=1789055807; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BU0pHPVrhHdYT1WkFVjJDxv8ZrMHIUMFXolTYoauB9k=;
 b=sl/RbaxrMQ7Dygqz6dzDHgWL6wgAMunVozg64iSFRvdHER/cVIynBtyKc/306sfVZa
 pVWt64APaclYndGp8JVgdKSKjM6sFARlUGC5BTiLwbEduteg4vHHsQeUoezcZSCqkd39
 SA9mqfHlzILgUw8E8NLHxYnbdyDuuNIDqBVGfuzaFFWyKbfH4zAM81BztfivrVBNGGwa
 ZeXlTS5ZtIFS/2332U3EyxkGEznV09kd97tYSdDK3vKf/Oa/hnJalf6VvNyulB0BynCD
 HuUc4QDn2AUyXQG2R+TQ6Cs/FSxLDUbPoMtg5fX5EN6eaOGqKquNoF2GEe4V0bBmZ5WH
 pkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788451007; x=1789055807;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BU0pHPVrhHdYT1WkFVjJDxv8ZrMHIUMFXolTYoauB9k=;
 b=n+iyFG5zjQSSpfOqzKutp8ehreJNzuu21v3P+6idINmA7WWnOm+OjiXcYAFhP/89XM
 upq3OOwesQGxO/CpkmAv1ORoFRMMC9VapmtdrvkEuN6Fml3pI7srxXEmShlU3tdMmsn3
 GTgI4REHlWRiYbIg5dyHVyxSqcA9zmcKdGdA+ihkNrTsXiPi+pTmywIGYLFhyoet6i5R
 ih5OYIpOHVPqOTv53GyprZdmikYjfrtn2JSE56KUoBP1F7n/FE7wBZZ7n6T9MTyZE1wC
 4Z+apf6FswrcfEwfK54MJ1PbMqrzINQcu90YJyCQXVGsQXjje828cM1+nCLZQ191NNr5
 aeDQ==
X-Gm-Message-State: AFuF++k9Hz14RYQpKxPJP80s5CW/0OVgHZf0gYWBZNaXH1oPsmhg3xu6
 5yeDGm0Ep/xV44bGN2bZbpsRaT9CL3Wk77g8gHS8aKOBgzGFVT+BkrH4
X-Gm-Gg: AYBFou3Vfaazozz4je1Uh1AjwEduohBDl7PgP3cOVRXn++U2RLBtOpZr6scCE2Wg+B8
 tPDHHgk1gbWFQXTfUDSQotoqzLMRuI3P2uj2FkQ/mGdG4XgVD1nvlWSWeQFTjseh81VlPaelR6z
 YeUJ9oqOeSuKT9+aUER9A8FkcbDF4bvYjvYVm7/qStFuZD6Bg4NjWA0QPaWL2+sCVUvLt+uewNS
 E+UWIKsQFKBZ+ws6PZNWnuqJrW+bKWVDcW8n3dqyRh8q+qzaVZOvr+4hd3vIXkNAGnhvyxRoY56
 zp+ikbFUoYFgIdZf8/gxCzghNlP0Nk2q+W/aZxT23ZusxT7Wmj7+clypy5K0FOKhr3AfgPWjNAm
 qEh9Itcvp+trABBxDwxEXvt6TfAN4vR3jLcOqLw1d8CFrURa5ntW2kLWYS4wvbKjeZyfa95RrmG
 exkTamsvHBbAkQCJrCiwHmY6aFN1QDBGQ23D2wD2K1FLeD9vmgE3mTLLsjdtp8pLcwyqSj0rVZV
 XA=
X-Received: by 2002:a05:690c:5609:b0:81e:7d90:5673 with SMTP id
 00721157ae682-86c53678a4amr59135427b3.26.1788451007441; 
 Thu, 03 Sep 2026 08:56:47 -0700 (PDT)
Received: from ?IPV6:2600:6c5c:6b00:316::23? ([2600:6c5c:6b00:316::23])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-86c1784192bsm42962537b3.30.2026.09.03.08.56.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 08:56:46 -0700 (PDT)
Message-ID: <1fd96ec4-4247-4d6d-8936-cf4607a206c1@gmail.com>
Date: Thu, 3 Sep 2026 11:56:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 1/8] e1000e: add jumbo Rx CRC stripping
To: Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 aleksander.lobakin@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
 skhan@linuxfoundation.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260830232146.36948-2-tactii@gmail.com>
 <20260903102730.578872-1-horms@kernel.org>
Content-Language: en-US
From: Matt Vollrath <tactii@gmail.com>
In-Reply-To: <20260903102730.578872-1-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 9/3/26 06:27, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev/#/patchset/20260830232146.36948-2-tactii@gmail.com?part=1
> ---
> e1000e: add jumbo Rx CRC stripping
>      
> When the hardware is configured to not strip the FCS (CrcStripping=0),
> the jumbo Rx path would deliver frames with the FCS still attached.
> Follow the standard path's convention by stripping the FCS at EOP and
> leaving it out of the byte count.
> 
>> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
>> index 844f31ab37ad4..599600ad695cd 100644
>> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
>> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
>> @@ -1631,13 +1631,23 @@ static bool e1000_clean_jumbo_rx_irq(struct e1000_ring *rx_ring, int *work_done,
>>   			}
>>   		}
>>   
>> +		/* strip the Ethernet CRC; it may span fragments */
>> +		if (!(adapter->flags2 & FLAG2_CRC_STRIPPING) &&
>> +		    !(netdev->features & NETIF_F_RXFCS))
>> +			pskb_trim(skb, skb->len - 4);
>> +
>>   		/* Receive Checksum Offload */
>>   		e1000_rx_checksum(adapter, staterr, skb);
>>   
>>   		e1000_rx_hash(netdev, rx_desc->wb.lower.hi_dword.rss, skb);
>>   
>> -		/* probably a little skewed due to removing CRC */
>>   		total_rx_bytes += skb->len;
>> +		/* If configured to store CRC, keep the FCS bytes out of the
>> +		 * total_rx_bytes counter
>> +		 */
>> +		if (!(adapter->flags2 & FLAG2_CRC_STRIPPING) &&
>> +		    (netdev->features & NETIF_F_RXFCS))
>> +			total_rx_bytes -= 4;
> 
> [Severity: Medium]
> Could these lockless evaluations of adapter->flags2 and netdev->features get
> out of sync if userspace changes features via ethtool while a packet is being
> processed?

Yes, this could be prevented by bringing down the adapter before changing bits
in e1000_set_features().

> 
> If a concurrent change occurs between the first check and this second check,
> it appears it could lead to an inconsistent state where a packet's payload is
> incorrectly truncated by 4 bytes, or where the byte statistics are overcounted
> or undercounted by 4 bytes.
> 
>>   		total_rx_packets++;
>>   
>>   		/* eth type trans needs skb->data to point to something */

