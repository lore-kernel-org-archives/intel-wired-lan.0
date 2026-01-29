Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8183D61006
	for <intel-wired-lan@archiver.kernel.org>; Thu, 29 Jan 2026 11:25:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 95CC16087F;
	Thu, 29 Jan 2026 11:25:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E7QWnoQnrD9u; Thu, 29 Jan 2026 11:25:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D43EA6087A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769685909;
	bh=3aQOX51g59d1N9BgF3IXFQhUSf9VMf7ww2aRRmYMtEY=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E9DQ6yVHAbjREvX7UIufEfEgJhlR57bUomeLGCJ3S+mtwz9Hhtr0C+AgCCxIziCfo
	 dl/DStfb1H9iwgkLTbYVeEdiVgnZuVsXnX/H4cMXmrmqfKiotFMJiL669FvGJ750go
	 XGpd/NNmzrsrEh4pQYReqveDqSmJ1UXQWYujOmgjaTUa5NKpUF/YKJeV2AI5kOn/V8
	 ANFf1eGld/O7S9mz3NoHYHhHbyTYQ4fgFSYE2Goi27rnkpsmePtaJQASXNQS7xOjTq
	 qx0UaK+xyDTlEqXcezo6rh69ZO5JAO1LwIWRupPOkfk132l0HsMe+qRlqavzOw6wzP
	 iNkSEY+8i5/yw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D43EA6087A;
	Thu, 29 Jan 2026 11:25:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D3BE81AD
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 11:25:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C3B2A6087A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 11:25:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id APKCJkm1kW5n for <intel-wired-lan@lists.osuosl.org>;
 Thu, 29 Jan 2026 11:25:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=marcin.szycik@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D8B9660876
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D8B9660876
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D8B9660876
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 11:25:05 +0000 (UTC)
X-CSE-ConnectionGUID: oSafm6lfSj2vYmNbWPkQug==
X-CSE-MsgGUID: 2pxnXXV4Td6J5FcjfjkBqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="69937438"
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; d="scan'208";a="69937438"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jan 2026 03:25:05 -0800
X-CSE-ConnectionGUID: ahqjcYT/R1enFlUL/HWdyw==
X-CSE-MsgGUID: ivHFzpodTR2R1raoPfgBiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; d="scan'208";a="208912366"
Received: from unknown (HELO [10.217.180.154]) ([10.217.180.154])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jan 2026 03:25:03 -0800
Message-ID: <d1fcdfd8-b6c2-4bff-9138-3113084c50cb@linux.intel.com>
Date: Thu, 29 Jan 2026 12:24:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20260109085339.49839-1-marcin.szycik@linux.intel.com>
 <ddd25fe0-a6a8-4ba9-8cb1-3f91ca562928@linux.dev>
 <1e162d79-20a2-4de3-8862-aa4fbe842132@linux.intel.com>
 <979e42ca-66fb-4ca6-b68f-c10b4e441369@linux.dev>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <979e42ca-66fb-4ca6-b68f-c10b4e441369@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769685906; x=1801221906;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=hAcVxOH7BXynvR0QexOQJ5luWYMUN1rnOFrg9Uirz44=;
 b=MfMEOB07yY03QvA0AoeLD5izIcbGkDomZ6GNLSQMt1tzzUISOnBnTh4S
 Nz+rCR9CfSqOkQ6a8FSNswPWVQAl5yQoWfKl+67aiVvl4dEow00QZtO28
 jzAAVPYYIHsNVlEJy1O3m08+2WhpxTpLlHXMwByd51qRzltKWLClzQKSW
 A99p8UgYXvhyuJa1VXt4Q+5lcU9GReAcA4K9cJ2TQbDj4/NnfZcwYE4kZ
 CUt2KwyTp2+zKG3wPJmULIDu9hGe8jOEMFiwwOKZvnIixft4cfhln15QX
 O1vxbXbg/uZnJ8Z5HsRRaRYRHSBC1eONgYxqlInJ4lgpxKBYgWzXPWXre
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=MfMEOB07
Subject: Re: [Intel-wired-lan] [PATCH net] ice: fix setting RSS VSI hash for
 E830
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



On 12.01.2026 12:15, Vadim Fedorenko wrote:
> On 12/01/2026 09:36, Marcin Szycik wrote:
>>
>>
>> On 09.01.2026 17:44, Vadim Fedorenko wrote:
>>> On 09/01/2026 08:53, Marcin Szycik wrote:
>>>> ice_set_rss_hfunc() performs a VSI update, in which it sets hashing
>>>> function, leaving other VSI options unchanged. However, ::q_opt_flags is
>>>> mistakenly set to the value of another field, instead of its original
>>>> value, probably due to a typo. What happens next is hardware-dependent:
>>>>
>>>> On E810, only the first bit is meaningful (see
>>>> ICE_AQ_VSI_Q_OPT_PE_FLTR_EN) and can potentially end up in a different
>>>> state than before VSI update.
>>>>
>>>> On E830, some of the remaining bits are not reserved. Setting them
>>>> to some unrelated values can cause the firmware to reject the update
>>>> because of invalid settings, or worse - succeed.
>>>>
>>>> Reproducer:
>>>>     sudo ethtool -X $PF1 equal 8
>>>>
>>>> Output in dmesg:
>>>>     Failed to configure RSS hash for VSI 6, error -5
>>>>
>>>> Fixes: 352e9bf23813 ("ice: enable symmetric-xor RSS for Toeplitz hash function")
>>>> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>>>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>>> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>>>> ---
>>>>    drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>>>> index cf8ba5a85384..08268f1a03da 100644
>>>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>>>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>>>> @@ -8038,7 +8038,7 @@ int ice_set_rss_hfunc(struct ice_vsi *vsi, u8 hfunc)
>>>>        ctx->info.q_opt_rss |=
>>>>            FIELD_PREP(ICE_AQ_VSI_Q_OPT_RSS_HASH_M, hfunc);
>>>>        ctx->info.q_opt_tc = vsi->info.q_opt_tc;
>>>> -    ctx->info.q_opt_flags = vsi->info.q_opt_rss;
>>>> +    ctx->info.q_opt_flags = vsi->info.q_opt_flags;
>>>
>>> The very same typo pattern is in ice_vc_handle_rss_cfg() in
>>> ice/virt/rss.c
>>>
>>> I believe both places have to be fixed.
>>
>> Hmm... where exactly? ice_vc_rss_hash_update() (called from ice_vc_handle_rss_cfg()) looks correct.
> 
> Sorry, it was fixed in 3a6d87e2eaac ("ice: implement GTP RSS context
> tracking and configuration") when the logic was moved to
> ice_vc_rss_hash_update(), but this code was never backported, the
> problem exists in 6.18...

Sorry for late reply, I don't know why, but I assumed the patch you
mention would be independently picked up to stable. Now that I've
looked into it, I see it's a feature implementation that accidentally (?)
also fixed that one line in ice_vc_handle_rss_cfg(), so it won't be
backported.

Do we know if the mistake in ice_vc_handle_rss_cfg() is an actual issue?
So far I wasn't even able to enter that branch (rss_cfg->rss_algorithm is
never VIRTCHNL_RSS_ALG_R_ASYMMETRIC, in fact this is the only usage of
VIRTCHNL_RSS_ALG_R_ASYMMETRIC - dead code?). If I understand correctly,
"theoretical" fixes are not welcome in stable.

Thanks,
Marcin

> 
>>
>> Thanks for reviewing,
>> Marcin
>>
>>>
>>>>          err = ice_update_vsi(hw, vsi->idx, ctx, NULL);
>>>>        if (err) {
>>>
>>
> 

