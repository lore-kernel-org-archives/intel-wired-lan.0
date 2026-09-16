Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D99AC88E5C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 16 Sep 2026 13:17:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D5C36402D4;
	Wed, 16 Sep 2026 13:17:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YIxNrBLFcpzJ; Wed, 16 Sep 2026 13:17:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E02C3403F0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789564643;
	b=Nd6EQtIC/otB9/a/C6KDsTKtpTPvBoPRnD+XF6px+fVDd+3vdduCsC58xXo1rRE/Sxzg
	 q+bQKCFvJEBydHMnf6Z4h2VteSK10fUD+QSGBotOp34sZmu6AT3vNzLyYmNqgGQRiwms8
	 GQ9uBUJF9bvH51RAaMwyM8DDKxCkzgoVciShQtzCQxwlzsO6TkZdZ+mcHneGUhNwZv8F8
	 4lWd/llOvkb6m+v0/fxdJm3k/7n5yNYqK6oR4/a8cNXFBxlZaGPxEWnlF0FxzKxQ73aB5
	 ZsoARs+l5EXAU3qyxPDcpfOXE0CeNmOrHVjCqFHUvz4VrNqLjQ+ErBoZUX4ab0OQORA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789564643;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Language:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=docZh/8sl7dXFnUbYvGXsVtko0JDj9j3X/6xWphAisg=;
	b=G6F7OvitaKN0TA/d7lk35bEEYHnQqW+XAGtuaVUwOT/ND15CdoxgGZ7O7o5oSaUWfhUT
	 PbwXFgNukd0ne60W9iSejgp7EklZiG3Y9/82xJzFxJXDZ/MIHJh9hw7bAahlW5WOZs+Oo
	 rZFr7DSiXF8Y/FlwxZHgTXKZd/YlcYqoJ2L8cBCcGrc7MsaAWYg2mFT3Jv9CnpnFsLHwC
	 p4/1iqTqHQt09pefgH3BjvMQK0Gh6kMAZXdAzFfaO4K9Tx5WgnlaBzWkp5n0MiXruJrpK
	 8bl1DLQc9KQSWRahVPMqFa+LnD2eLg7jMleyHDvomjDq9Polb3uKeQYDyWA76vOURHA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SdCW9oLp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789564642;
	bh=docZh/8sl7dXFnUbYvGXsVtko0JDj9j3X/6xWphAisg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wMvuobZ0mU69ZnqwjApyez6liMq6vYJRfbofif7MV2ZgkRUjTEhJqVno7oonkO/w0
	 TxoinV1UCl3JLSYPDXfjHj7UeQdI2p/vhMwHXT52BRpp1fDFgSpTJMpAvIkFturYCf
	 3Y4ckP7GmJ5o3IJBJAeU9Xef7ntLlkNxM9RDVozANxdXzJE74CP0LjKVKLR4GJrNv2
	 v4PTleZBZXs2vNpIIBAqovqaOVMNxglLjTqkztT080DDlbYfTeJ1GVXGeslbTb1IKY
	 uD9NPJYeAz8pZcW+PhFVwkBKSxCkE5R/9sfRZPwclcuQfo6YYzO0zVr4jFfBiDc1q+
	 6LHC3TYhK+rNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E02C3403F0;
	Wed, 16 Sep 2026 13:17:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 60EF0422
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 13:17:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 522E4403F0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 13:17:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id socGjISNaSPR for <intel-wired-lan@lists.osuosl.org>;
 Wed, 16 Sep 2026 13:17:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9BD21402D4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789564641;
 b=U+zxG0kDK+cASUflBvdkiFsCo+ltJOAUr7IKboHJQ/lXBss+HJFsxcdpOpwlabR70bAk
 ocFqsF6Do8h8du2/g8x91pZSiO8Vb9br2AMR5PXDOiq4CcjnyT9s1QC6sbJfDLjN8tKwo
 uYVG/A2+AwHHIfTOeGncR5RtfyQVE8BCfZ2gVsFCMMpLQRT9MrW2tOGFxEvNWza4efV3U
 Kmu4Tj87nfi9LRwdBmAsSu9YOiLd+iuKQhWGm8a/25xhbu/pi6B4johFcRJ9d+4Rx51rE
 iMKxMWUJ47w+sbUvzgfczmhaJr4ePxbV3CQX8I1LUCr0x4pbIk5cGcnH4Yxe+VFE8Dg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789564641;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
 To:Cc:References:From:In-Reply-To:X-Mimecast-Spam-Score:
 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Language:
 Content-Type:Content-Transfer-Encoding;
 bh=docZh/8sl7dXFnUbYvGXsVtko0JDj9j3X/6xWphAisg=;
 b=QaaTmA/1zf2ChEMITa6Q3b9eRvOI0Fgol1nne+mA+8c1EuZ9nVCF0j1YI484qEkowjas
 n7YjFVCUWPaAJShViLYA0VkEoOILM2YXBK67ntqWwrP8ays4otxEYdH1w0lE+s1mh9Vz3
 vG7ABARcVfc89gsOE0A+ZoG48bKlXuwgNJ+h2LJDAhuO+watbm/CsGJ0H+V02qhVfYTe5
 iwuS13JzRfcmTeFdsu9bGz/mJP0gXog0UVGgnttam0eEAFiiPlUKZtN8AxDp+1g9JQK4Y
 Etj4skt9FsXRGt2eJXhyLGh+jcACbk+XvEJLeozZud5w65sOw4yK/5oZMrVv4AuHV8A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=SdCW9oLp; 
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SdCW9oLp
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9BD21402D4
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 13:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789564638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=docZh/8sl7dXFnUbYvGXsVtko0JDj9j3X/6xWphAisg=;
 b=SdCW9oLpFQOHyzlzCsy/Z3WlGmUPyVRycn4QAs4VNzIW9xo7sFUnOzZRQ+85SwsWo3n3iC
 ukrOv0Mlb0VkH9GpeMJbqtFUNLPoGq5gXGCv1V/DInZDsbs5NDE802eZ3nOnZ0XzZBSg+T
 RPLTT6JCXikT0SovHCe0UDTteopvaMM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-QjhAPUgjOr-73hTfDmuHtQ-1; Wed, 16 Sep 2026 09:17:16 -0400
X-MC-Unique: QjhAPUgjOr-73hTfDmuHtQ-1
X-Mimecast-MFC-AGG-ID: QjhAPUgjOr-73hTfDmuHtQ_1789564636
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49e735659b7so25531195e9.3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 06:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564636; x=1790169436;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=docZh/8sl7dXFnUbYvGXsVtko0JDj9j3X/6xWphAisg=;
 b=jhIpnnhvYRZESZeq894bjy2vJOf7SntOerAVQOUdWah5BDNNB3ujtdhKzf4qR95Wat
 AObMORS5b4nT/9rSTpHyE6/ymibfT3mXPIM7p8OQg8zlD4qTPaCRRHTpVUj6BrVuRCAg
 AsCijBgDrK3XYulGjAQFeVqgeY/oI0UAaWfPJeU2MWNaUds6D9N35dQlyTxO3Jmj0T0P
 RU3NUNAZ81MNW40I2+F8mkYDOF/GvReXI1fPzYcJPcwVBSfV1Hmp5D/7gPdakEqdy2m1
 G1btYXdzWhqb+eoIQYZN7wfBQ+4iG70xKZsrDzW564WUWrwzTsAFwNOzFPKHzv4PPrDP
 WkVg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzOLzn+8isyAHkeyvcqzUCVmccJ83ZGKr+QVBOwIWRq0atu4dih3MkGJq5rvOoKyGEbhHzwAZX5HBFWlWehwfM=@lists.osuosl.org
X-Gm-Message-State: AFuF++kQilEU54FjBripltp8nls8a8ilsVVnXOVgXmqBIcY7bHkgI9wV
 SRDN7SgiSZU+8gH0p1KYKuL1jIXENYn9RT6g4ld/az4r5bbwKOFtL0hb8pwQthmnrWy9sfx9jcI
 PZmJ3rnqv+wFFf4B5wuYFZOMvdwPwOQA0q7OKZAFmhAfvhyR3E19o4IZHughmGrmWJ8rpd38=
X-Gm-Gg: AYBFou2HcOkBZ/FPjPZLDxsPUmPooU0I9S7zhxVeyUVUbG80aH11624Ka10bK1bv26O
 4JXpPR3TPEzBBdItwyxeb4c5x/+4AHlkEYZV6qq33PPxXPZ3Ree4wbuYzHeobiX9FsbGhmIvPki
 qT11YqKNOGVRsythR6ByUI3TkLsBU/3mwylt94k/A1wEl18b5y9D7+PBqjqN9azUbibpTssmSsg
 4X0ijFRAsZ8Qb3LDwC0UVM7znvfkcNz7WtB/OZCHuryrLimjU5kC/N2c57+R+4FP3T/pdJoNo4O
 Re0JNIaCiShRvSHvBO00BDOj5Sas8eXMLdIGbYeR9ELCYqcvcQmJY+45SdoFBxsUhif8UhRz8w=
 =
X-Received: by 2002:a05:600c:1986:b0:49e:70b2:66ab with SMTP id
 5b1f17b1804b1-49eac40f67emr32595455e9.0.1789564635537; 
 Wed, 16 Sep 2026 06:17:15 -0700 (PDT)
X-Received: by 2002:a05:600c:1986:b0:49e:70b2:66ab with SMTP id
 5b1f17b1804b1-49eac40f67emr32595095e9.0.1789564635086; 
 Wed, 16 Sep 2026 06:17:15 -0700 (PDT)
Received: from [192.168.2.83] ([46.175.183.46])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf413dcsm7232759f8f.31.2026.09.16.06.17.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 06:17:13 -0700 (PDT)
Message-ID: <c93e917a-6c66-44f1-a3c1-5c5f5b3930da@redhat.com>
Date: Wed, 16 Sep 2026 15:17:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 2/2] ice: don't offload drop filters that bypass
 higher priority filters
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 priyalee.kushwaha@intel.com, kiran.patil@intel.com,
 wojciech.drewek@intel.com, michal.swiatkowski@linux.intel.com,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
References: <20260910154824.3603687-3-poros@redhat.com>
 <20260912083645.145790-1-horms@kernel.org>
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20260912083645.145790-1-horms@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3Onbm-VKO6FfGNdYHw4X5namZHTvODsoxF_8bmugijc_1789564636
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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


On 9/12/26 10:36, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev/#/patchset/20260910154824.3603687-2-poros@redhat.com?part=2
> ---
> ice: don't offload drop filters that bypass higher priority filters
>
> This commit tracks software-only TC filters to prevent the hardware from
> incorrectly offloading lower priority drop rules that would override them.
> It tracks un-offloaded filters within a device block and rejects conflicting
> drop offloads.
>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
>> --- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> [ ... ]
>> @@ -2269,6 +2269,112 @@ ice_find_tc_flower_fltr(struct ice_pf *pf, unsigned long cookie)
> [ ... ]
>> +static void ice_tc_track_sw_fltr(struct ice_pf *pf,
>> +				 struct net_device *filter_dev,
>> +				 struct flow_cls_offload *cls_flower,
>> +				 enum ice_eswitch_fltr_direction direction)
>> +{
>> +	struct ice_tc_sw_fltr *sw_fltr;
>> +
>> +	hlist_for_each_entry(sw_fltr, &pf->tc_sw_fltr_list, node)
>> +		if (sw_fltr->cookie == cls_flower->cookie)
>> +			return;
> [Severity: High]
> Does this early return break tracking for TC shared blocks?
>
> When a shared block is bound to multiple interfaces, the driver will only
> track the cookie for the first interface because this check returns early
> when it sees the same cookie.
Correct. For a block bound to multiple devices of one PF only the first
binding's filter_dev is remembered, so the guard protects the first
binding only. The impact is a missed refusal on the other bindings,
never a false refusal, but it is easy to do better. I will rework the
tracking in v2 to keep one entry per cookie and filter_dev pair, so
every binding replay creates its own entry and the guard covers all of
them.
>
>> +
>> +	sw_fltr = kzalloc_obj(*sw_fltr);
> [ ... ]
>> +static bool
>> +ice_tc_drop_bypasses_fltr(struct ice_pf *pf, struct net_device *filter_dev,
>> +			  u32 prio, enum ice_eswitch_fltr_direction direction)
>> +{
>> +	struct ice_tc_flower_fltr *fltr;
>> +	struct ice_tc_sw_fltr *sw_fltr;
>> +
>> +	hlist_for_each_entry(sw_fltr, &pf->tc_sw_fltr_list, node)
>> +		if (sw_fltr->filter_dev == filter_dev &&
> [Severity: High]
> Because the tracking entry is bound strictly to the first interface's
> filter_dev, won't this check fail to protect other ports sharing the same
> block?
Yes, same root cause as above, fixed by the same v2 rework. The
per device comparison itself has to stay because TC priorities are not
ordered across blocks, only the tracking granularity was wrong.
>
>> +		    sw_fltr->direction == direction && sw_fltr->prio < prio &&
>> +		    !sw_fltr->is_drop)
>> +			return true;
> [ ... ]
>> @@ -2336,6 +2471,9 @@ ice_del_cls_flower(struct ice_vsi *vsi, struct flow_cls_offload *cls_flower)
>>   	struct ice_pf *pf = vsi->back;
>>   	int err;
>>   
>> +	if (ice_tc_untrack_sw_fltr(pf, cls_flower->cookie))
>> +		return 0;
>> +
> [Severity: High]
> When deleting a filter from a shared block, the first net_device will delete
> the unique tracking entry here. Won't subsequent callback invocations for the
> other ports in the shared block fall through to the hardware failure path
> and incorrectly return -EINVAL?
They will, though that is what every DESTROY for an unknown cookie
returned before this patch too, so nothing gets worse. With the v2
per binding tracking each DESTROY invocation removes its own entry and
returns 0, which fixes this for tracked filters as a side effect.
>
>>   	/* find filter */
>>   	fltr = ice_find_tc_flower_fltr(pf, cls_flower->cookie);
>>   	if (!fltr) {
> Later in ice_del_cls_flower(), the filter is removed and freed:
>
> drivers/net/ethernet/intel/ice/ice_tc_lib.c:ice_del_cls_flower() {
>      ...
> 	/* delete filter from an ordered list */
> 	hlist_del(&fltr->tc_flower_node);
>
> 	/* free the filter node */
> 	kfree(fltr);
>      ...
> }
>
> [Severity: High]
> This is a pre-existing issue, but is it safe to modify tc_flower_fltr_list
> and free the filter here?
>
> While this runs under the rtnl_lock, the background device reset task
> (ice_reset_subtask) calls ice_rem_all_chnl_fltrs(), which iterates over
> pf->tc_flower_fltr_list and frees filters using kfree() without holding
> the rtnl_lock or any driver-specific lock protecting the list.
>
> Could this concurrent access during a hardware reset result in list corruption
> or a use-after-free?
Confirmed, this race is real and pre-existing. ice_prepare_for_reset()
runs from the service task without RTNL and for a non PFR reset with
mqprio active it calls ice_remove_q_channels() with rem_fltr true,
which walks and frees tc_flower_fltr_list entries concurrently with
the RTNL serialized cls_flower paths. It predates this series and the
list reader added here runs in the same RTNL context as the existing
readers, so this series does not widen it. I will address it in a
separate fix.

I will send v2 of this series with the per binding tracking rework.

Regards,

Petr

