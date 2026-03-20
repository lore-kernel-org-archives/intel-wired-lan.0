Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE341098783
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Mar 2026 13:21:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0180C847E7;
	Fri, 20 Mar 2026 13:21:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YVNhaKawD-Cj; Fri, 20 Mar 2026 13:20:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4013D847CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774012858;
	bh=TZoiyOPcXYFytYbcPhQQwtFYV69MPiajbtiVckKehhI=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=849IP3NvfGcIOM5rRiLoMnlBVC/MAA+bTua9RbaUcYB2ZIrco4McHhO5flK8V107r
	 l3wKuSMz4peUl2tf0NUQvSTOTv6+8O+5Z8aR76IrOg9smZqr7KkOgbk0P+XtIJeRTJ
	 UnhrHC/HIn+hrjrBnWEBJvGvDpMeoir/4vaXZhS4f/vWVja8n6uKts4gJdmsx78OAu
	 MGkO6auqF1ydNZJkPAtecMs0q5FpNVe8DgUKGbwJHvqBVME4jk0Jo3E5h0xRMkF+Fl
	 nICyqn4hv6YAQ8HwKyu/bPr0g2KDnh2okoMKzWl5AuMHm1rdK3PSxWJ8DrdKc7fiaj
	 df3ADZkj60Vnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4013D847CE;
	Fri, 20 Mar 2026 13:20:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D4D5F1B6
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 13:20:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C655B405FD
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 13:20:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PnJH-CMciG6S for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Mar 2026 13:20:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=marcin.szycik@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9C3E14014E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9C3E14014E
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9C3E14014E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 13:20:55 +0000 (UTC)
X-CSE-ConnectionGUID: Wpj1J/kMRQmOwVDDa5WADA==
X-CSE-MsgGUID: 0KgWl0i/S/OZsT7Ti+HkyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="85722707"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="85722707"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 06:20:55 -0700
X-CSE-ConnectionGUID: YB/3+kZyQZOx90BORRLQcQ==
X-CSE-MsgGUID: 02YQOKTsRDmxZwYCT/OZ+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="227409603"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.246.17.139])
 ([10.246.17.139])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 06:20:53 -0700
Message-ID: <ea943092-d0a2-4a93-b6f2-72fcad8f9914@linux.intel.com>
Date: Fri, 20 Mar 2026 14:20:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com
Cc: netdev@vger.kernel.org, Marcin Szycik <marcin.szycik@intel.com>
References: <20260320050529.422444-1-aleksandr.loktionov@intel.com>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20260320050529.422444-1-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774012855; x=1805548855;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=PQ6yOqa4PgyAZF4ktQrGNLVKtsw3530HSr+f7H4rcpw=;
 b=keRNZEkDmrtEuG26bDO+ziyWtDr0e+I7Pk0EQFwv2qmh+2th1N87t46T
 w1VXy4DeKDj++H0NFc8CqujdOJlWbFIQAeW6q/kkl7OAYfMvB2w7LLf5C
 AJGAQ7m+w4SOSz01Wy9QTTRdA6DtKds5rnFBbADvm6aHx6e35iuqoR3R2
 4v4EQ1bEebcB4KiJG5r1KNCSbLXJcYqJdq6P39B8BMzFSgF2vms4lttdC
 ElV1aCBmkPDWBBTqWjJghWB6ZxSFspeRDhcKfCOu3R18pn+luwPzYpXOw
 4oUgXvS5hGVJzeIPV/pd5LctMmu5DQg8RCKUa3j1ttUyUexpg+xu2uB5w
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=keRNZEkD
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: fix allocating
 excessive memory in ice_create_lag_recipe()
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



On 20.03.2026 06:05, Aleksandr Loktionov wrote:
> From: Marcin Szycik <marcin.szycik@intel.com>

ACK

> For some reason ice_create_lag_recipe() allocates an array of 64
> struct ice_aqc_recipe_data_elem elements, while it only needs one (1).
> Fix it, while also using kzalloc_obj().
> 
> Fixes: 1e0f9881ef79 ("ice: Flesh out implementation of support for SRIOV on bonded interface")
> Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lag.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
> index 310e8fe..70357dc 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lag.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lag.c
> @@ -2418,8 +2418,8 @@ static int ice_create_lag_recipe(struct ice_hw *hw, u16 *rid,
>  	if (err)
>  		return err;
>  
> -	new_rcp = kzalloc(ICE_RECIPE_LEN * ICE_MAX_NUM_RECIPES, GFP_KERNEL);
> +	new_rcp = kzalloc_obj(*new_rcp, GFP_KERNEL);
>  	if (!new_rcp)
>  		return -ENOMEM;
> 
>  	memcpy(new_rcp, base_recipe, ICE_RECIPE_LEN);
>  

