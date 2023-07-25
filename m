Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A7B4C04A6A
	for <intel-wired-lan@archiver.kernel.org>; Tue, 25 Jul 2023 11:04:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D583C416B5;
	Tue, 25 Jul 2023 11:04:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D583C416B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1690283085;
	bh=rlcLRd5j2mzE22z9GCo2FKr56VbE93qB26laYBdaFJU=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=GWJn85NpPs9FjIPQ9gcLr/sSIbLM8D4XnAD+rBgto+R65ClEfOkO9Jyy6E2ayw5Rd
	 /B4lYQ1FeKfLUZmmTTmXA7nmV6Z11XvLl6Ve6rcQ0RasnTL7avHpos1q6zjqkqQms1
	 meMBdcFLBfLTwfahEr9c8mOYsPywRXJGUNBBapB/qM6CqdIevIuBpQK8EQlPt75Hx6
	 sS4d8jRlJYY219JbQOY+49HUaKqSnC7gs+FZ5ejDO5Q0xYM12DO1NBPC0noCwVa/JC
	 fR9AYKDvryXWFmeu3lS24AFClaZ9y9/XHLaqtH8RbCcVxeLweFOCyRC7isxK0d2g06
	 3DzG5RZD2/KYA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TJ5q36b6_ihZ; Tue, 25 Jul 2023 11:04:44 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id AAF35416D5;
	Tue, 25 Jul 2023 11:04:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AAF35416D5
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id BFA551BF29F
 for <intel-wired-lan@osuosl.org>; Tue, 25 Jul 2023 11:04:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A31FA416B5
 for <intel-wired-lan@osuosl.org>; Tue, 25 Jul 2023 11:04:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A31FA416B5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KcLhxSWXwyf4 for <intel-wired-lan@osuosl.org>;
 Tue, 25 Jul 2023 11:04:42 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8F131416D5
 for <intel-wired-lan@osuosl.org>; Tue, 25 Jul 2023 11:04:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8F131416D5
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="365149832"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; d="scan'208";a="365149832"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2023 04:04:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="1056760007"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; d="scan'208";a="1056760007"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.13.12.25])
 ([10.13.12.25])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2023 04:04:39 -0700
Message-ID: <690803c6-d76a-624f-3d97-ae883789f205@linux.intel.com>
Date: Tue, 25 Jul 2023 14:04:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
 intel-wired-lan@osuosl.org
References: <20230711003453.9856-1-muhammad.husaini.zulkifli@intel.com>
 <20230711003453.9856-2-muhammad.husaini.zulkifli@intel.com>
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20230711003453.9856-2-muhammad.husaini.zulkifli@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690283082; x=1721819082;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=UG9LR8Rcn0zyrMIVP63SvlyAFzt8smQDF3JQausqeUQ=;
 b=KlPVUJYbJhcWx1bfDQ34Yrv68C8p4KV1AUmU6lStnFbeEm1/muoEF3bU
 R9gvqkQXyazeGSbcmOVtymWxtUS8AlGMy7GHfcdR4hXCbdGRmpD9A1kRn
 MtF4DpKO9fxwZaF+lLp7jTJ+c3iNMdfDYziBbTVzD9gLABm0q/mRr+NXB
 LHADghmxDbfSgNpM/yedXKYtU7GGoOf5S0mpTfLx/wEZFE9llVvp9CgT6
 Ki0JBPD2gXnsWTGT2FJKbHh3JjlDrfur+cupVJgp6r8zEysIlXjhKR8DE
 WryKrqlALfVkzRRyqxZets7oH9tzIsMBwupMuCOFzuUUoYAqAkFVufIZa
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=KlPVUJYb
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2 1/2] igc: Expose tx-usecs
 coalesce setting to user
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
Cc: anthony.l.nguyen@intel.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 7/11/2023 03:34, Muhammad Husaini Zulkifli wrote:
> When users attempt to obtain the coalesce setting using the
> ethtool command, current code always returns 0 for tx-usecs.
> This is because I225/6 always uses a queue pair setting, hence
> tx_coalesce_usecs does not return a value during the
> igc_ethtool_get_coalesce() callback process. The pair queue
> condition checking in igc_ethtool_get_coalesce() is removed by
> this patch so that the user gets information of the value of tx-usecs.
> 
> Even if i225/6 is using queue pair setting, there is no harm in
> notifying the user of the tx-usecs. The implementation of the current
> code may have previously been a copy of the legacy code i210.
> 
> How to test:
> User can get the coalesce value using ethtool command.
> 
> Example command:
> Get: ethtool -c <interface>
> 
> Previous output:
> 
> rx-usecs: 3
> rx-frames: n/a
> rx-usecs-irq: n/a
> rx-frames-irq: n/a
> 
> tx-usecs: 0
> tx-frames: n/a
> tx-usecs-irq: n/a
> tx-frames-irq: n/a
> 
> New output:
> 
> rx-usecs: 3
> rx-frames: n/a
> rx-usecs-irq: n/a
> rx-frames-irq: n/a
> 
> tx-usecs: 3
> tx-frames: n/a
> tx-usecs-irq: n/a
> tx-frames-irq: n/a
> 
> Fixes: 8c5ad0dae93c ("igc: Add ethtool support")
> Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_ethtool.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)

Tested-by: Naama Meir <naamax.meir@linux.intel.com>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
