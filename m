Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D274FC3271E
	for <intel-wired-lan@archiver.kernel.org>; Fri,  5 Jul 2024 16:47:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 63721404A4;
	Fri,  5 Jul 2024 16:47:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wiM69G4PCqXD; Fri,  5 Jul 2024 16:47:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8BDA2410A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1720198061;
	bh=Rf0ALgJeKOdVgksYCfFbHgwBX5h2xDijuEZ8PSO0BIA=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=tgf2+nuTUbB2WIe7cWRAcBFXs5rIhzAuqA5OcEelpZ1i8OqjJ+ja+rnw/n2sbiMH4
	 wnbAjJdR8lp0cHtbxVVzil+UCt/YrRO5ZSeUfZVgO+POwLGkmwRY9FrYuRY0TjD3nw
	 ROwc1pxvHUDLykligFL1hrVsJJHvZPnbIV8ZV9mh4J0fSFbYx4rjKoq9odLYT4Q6ut
	 4P19iys35jjgxK2VhzAYuYGO7oPZuCe8MeoismhjAj2FNIXJ/1UtSrIs3AREMT3f68
	 mxTEnO6KH6JGZWOpP70N6UM9RUXPG5ANIWj2unty6SnqJRZSLaF9X6sHIG1t86PwmX
	 GbwpBviXd+fOQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8BDA2410A8;
	Fri,  5 Jul 2024 16:47:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 8BF851BF281
 for <intel-wired-lan@lists.osuosl.org>; Fri,  5 Jul 2024 16:47:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 83FE861028
 for <intel-wired-lan@lists.osuosl.org>; Fri,  5 Jul 2024 16:47:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ToRyEVN0OvFh for <intel-wired-lan@lists.osuosl.org>;
 Fri,  5 Jul 2024 16:47:40 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=faizal.abdul.rahim@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B8CE360EDF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B8CE360EDF
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B8CE360EDF
 for <intel-wired-lan@lists.osuosl.org>; Fri,  5 Jul 2024 16:47:39 +0000 (UTC)
X-CSE-ConnectionGUID: hOV1QtRqRAWrkqP8y0hnAw==
X-CSE-MsgGUID: Eiyqr2P0TE+vuSoA8rGHuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="17628102"
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; d="scan'208";a="17628102"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2024 09:47:39 -0700
X-CSE-ConnectionGUID: UkTg0KnjTTuxoPQWrXhqUA==
X-CSE-MsgGUID: fEMJnxKyRw6GT8EREbUC1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; d="scan'208";a="47570619"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.38.162])
 ([10.247.38.162])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2024 09:47:35 -0700
Message-ID: <faabc72b-b421-48c7-93cb-b2fe65655989@linux.intel.com>
Date: Sat, 6 Jul 2024 00:47:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Simon Horman <horms@kernel.org>
References: <20240702040926.3327530-1-faizal.abdul.rahim@linux.intel.com>
 <20240702040926.3327530-4-faizal.abdul.rahim@linux.intel.com>
 <20240703151008.GP598357@kernel.org>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20240703151008.GP598357@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720198060; x=1751734060;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=OsQBIcaZV6hpTwnvHv8LU4FRqNY5U0nNux6t1Y82xgs=;
 b=MuXPKUUeKh/oE3BT2xNkFJ+ufW5ElrvUYqrT5651QgiPht0U+T9dbIe/
 aYIRxpoMV5m3DPb/Nzd6k9xVwJQYWyDU6KwZN2rshEy4p2MWVX6sJVB8r
 rndssuUfoPCvkS5FEL/H1aZXcD3Es4DbYGDBlL6WLl2YbSxXNBxfC10jt
 p93Vr1wbDLLCT71jhcDr5ZTUYy5JCHCax7Q4ehO/Zl4AZ08zgCZNLeQTF
 pxvLUqxpWe85dsmVT3GzFx+gK+MMpLxxV9znMwtb+sZ02eVtLrCsmZNwu
 CSjxmw/dOeHwYC15c3k66QLUFNp4iVnE8mbjwgi326GtNgcwyL3K6HAOF
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=MuXPKUUe
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1 3/4] igc: Remove unused
 qbv_count
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 intel-wired-lan@lists.osuosl.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S . Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>



On 3/7/2024 11:10 pm, Simon Horman wrote:
> On Tue, Jul 02, 2024 at 12:09:25AM -0400, Faizal Rahim wrote:
>> Removing qbv_count which is now obsolete after these 2 patches:
>> "igc: Fix reset adapter logics when tx mode change"
>> "igc: Fix qbv_config_change_errors logics"
>>
>> The variable qbv_count serves to indicate whether Taprio is active or if
>> the tx mode is in TSN (IGC_TQAVCTRL_TRANSMIT_MODE_TSN). This is due to its
>> unconditional increment within igc_tsn_enable_offload(), which both runs
>> Taprio and sets the tx mode to TSN.
>>
>> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> 
> Hi Faizal,
> 
> This change looks good to me.
> However, it seems more appropriate as a clean-up for iwl-next
> once the previous to patches make it there via iwl-net.
> 
> That notwithstanding,
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> ...

Got it, will do that.
Thanks.
