Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64F5D31A22
	for <intel-wired-lan@archiver.kernel.org>; Wed, 14 Jan 2026 08:16:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9C2CB6F7B1;
	Wed, 14 Jan 2026 08:16:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o2rHT_Y6awql; Wed, 14 Jan 2026 08:16:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D01A06F7AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1768378569;
	bh=zJaeQuTcmKPLmxHVeNMO+TMSB+Kiv6JhfAqfzK04nvc=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=QJZu/UKTM33CVXDVQLvgIGh43Aq81sFwKxm/hvKEBYan0KL5bzXMB2B0yKzacExwF
	 Ru4+eJQ3438IyMOyZ7w1CKyE+iO2OJMA9fFxdL4MWgqVSqJ6imsWQeAYnhAqY8QHbJ
	 dW7BDKbcWaRXTAdOYZgUl6Hdwd653UnbKcIJj9oOnoLGPzRyHKiH222X481GPZdcaz
	 7u75fHsFq5mSQKS/9i5GNvDJKTvzg7alqSNS8vnEIqk0NLXQc/Pzce8115HW4m3JNW
	 5j2PKGc00RznDSozg8jqukDrzIkRpb/O4TzTKZxui7K83SChXF7wEu9v65fWd7GLpv
	 1g5NE+WrAzMZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D01A06F7AA;
	Wed, 14 Jan 2026 08:16:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5954A1C3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Jan 2026 08:16:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3F7D640225
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Jan 2026 08:16:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iWsz4FkkexHA for <intel-wired-lan@lists.osuosl.org>;
 Wed, 14 Jan 2026 08:16:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=dawid.osuchowski@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5C54340190
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5C54340190
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5C54340190
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Jan 2026 08:16:03 +0000 (UTC)
X-CSE-ConnectionGUID: PLZ+/Ye4Tf+bRGORZvAOKw==
X-CSE-MsgGUID: UjB2R149T2e8aX4ljYvLsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="57228007"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="57228007"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 00:16:04 -0800
X-CSE-ConnectionGUID: HdljNTGlSnmU4yQpS8iDuw==
X-CSE-MsgGUID: aQ92HTXqTE2w3EbiZCrUwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="204506952"
Received: from soc-5cg4396xfb.clients.intel.com (HELO [172.28.180.91])
 ([172.28.180.91])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 00:16:02 -0800
Message-ID: <954dc352-2ad2-4950-9c8b-55ebafc5841c@linux.intel.com>
Date: Wed, 14 Jan 2026 09:15:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Paul Menzel <pmenzel@molgen.mpg.de>
References: <20260113193817.582-1-dawid.osuchowski@linux.intel.com>
 <20260113193817.582-2-dawid.osuchowski@linux.intel.com>
 <f0fee9dd-7236-464d-9e06-6adbeece81a8@molgen.mpg.de>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <f0fee9dd-7236-464d-9e06-6adbeece81a8@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768378565; x=1799914565;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Tk40Z3bVifct2EirVXFgyYO4QzE6BJo2N8YtpP43AC0=;
 b=bttR2EdOUPgNzMt5TzH5g7PP+gQI6GHsSmSFfjKOwVKcc+h4lUHwK3gG
 zh8I9tVwARCA5BWISG6OJwU/ybDX1VtY0r1NsL5zYJ25wrQV8l02kiq68
 rWvCTTfTaVanUUTheqLSgOWPGUQY+TFs87FMKaMqC/M28evzRGWuiJXGV
 bAy1cmpqUN2HUnrAsk4NPdBWiyX7TI36K5B1u6OA1lfNtAa6xcn/Ip022
 nU1XTYJGRw4k6q9uHGnNwkqFv7QMmWftmFMNzuGNMBaELN4/MlMhfMGaS
 rhLFcwHBdv9TMNdm6UWbj0QjO8i1+Ds0yd5ayfBQsOJTA9mSQhiTr2dst
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=bttR2EdO
Subject: Re: [Intel-wired-lan] [PATCH iwl-net 1/2] ice: reintroduce retry
 mechanism for indirect AQ
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
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org,
 Jakub Staniszewski <jakub.staniszewski@linux.intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hey Paul,

On 2026-01-13 11:31 PM, Paul Menzel wrote:
> [Cc: +Michal]
> 
> Dear Dawid, dear Jakub,
> 

...

> Am 13.01.26 um 20:38 schrieb Dawid Osuchowski:
>> Ccing Michal, given they are the author of the "reverted" commit.
> 
> At least Michal was not in the (visible) Cc: list

Interesting. I was using 'git send-email' without any suppression of Cc 
or similar options. In the direct email sent from me Michal is in Cc, 
seems the mailing list for some reason stripped him...

>>   drivers/net/ethernet/intel/ice/ice_common.c | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>

...

>>       do {
>>           status = ice_sq_send_cmd(hw, cq, desc, buf, buf_size, cd);
>>           if (!is_cmd_for_retry || !status ||
>>               hw->adminq.sq_last_status != LIBIE_AQ_RC_EBUSY)
>>               break;
>> +        if (buf_cpy)
>> +            memcpy(buf, buf_cpy, buf_size);
>>           memcpy(desc, &desc_cpy, sizeof(desc_cpy));
>> -
> 
> Unrelated change?
> 

During internal review it was pointed out that this function contains a 
lot of empty lines, this was my feeble attempt to at least partially 
reduce their count.

>>           msleep(ICE_SQ_SEND_DELAY_TIME_MS);
>>       } while (++idx < ICE_SQ_SEND_MAX_EXECUTE);
>> +    kfree(buf_cpy);
>>       return status;
>>   }
> 
> The diff looks good otherwise.
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> 
> Kind regards,
> 
> Paul

Thanks,
Dawid
