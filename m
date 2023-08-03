Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CB1C001DB
	for <intel-wired-lan@archiver.kernel.org>; Thu,  3 Aug 2023 14:59:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1556A83BE4;
	Thu,  3 Aug 2023 14:59:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1556A83BE4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1691074751;
	bh=j1VrkGCtcAduBocHnIoIx1wg4lxBhJn1gzti7gFZ8Tc=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=szHdCRdQ7bqTkT962XFZOaZGO5kMxorsjS2AdTBto0Izs3szIDXfvwCPpbptIzfeE
	 Djb8DBkC3srrhf0aI2KlytcQ/gIJsWWr1Z1udxpPBxRDY18Q3BWN9BWlZiwXDJPhMW
	 HmDdE74Po6wZYLGaikH6NZA4S5vPOzOCncIdiyNIZX3HSDM8qh38vY5I+2O1LnUTwv
	 CBxNff7rxKbDSQpap4C4DLzeioQoi7SJJeNkPeiyr0gjj8FRX+RPienh4wn/CE9rjN
	 Umw6YTl7DlxMhcysaA94uk4ArI2GQQ3p4bWvPzbCBh7BawBXIcoVAxSehrBZeNnM3Q
	 PG9f2fq9C15/g==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4tZGHSN9oz5K; Thu,  3 Aug 2023 14:59:08 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5182B82FC9;
	Thu,  3 Aug 2023 14:59:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5182B82FC9
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 340941BF97D
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Aug 2023 14:59:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D37F6417B5
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Aug 2023 14:59:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D37F6417B5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yCN2SGB8-Wvq for <intel-wired-lan@lists.osuosl.org>;
 Thu,  3 Aug 2023 14:59:05 +0000 (UTC)
Received: from mgamail.intel.com (unknown [134.134.136.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 155414056C
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Aug 2023 14:59:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 155414056C
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="359951208"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; d="scan'208";a="359951208"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2023 07:59:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="723235922"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; d="scan'208";a="723235922"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.249.159.204])
 ([10.249.159.204])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2023 07:59:02 -0700
Message-ID: <51af092b-cd91-e134-888c-0d0220d37d1c@linux.intel.com>
Date: Thu, 3 Aug 2023 16:58:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
To: Leon Romanovsky <leon@kernel.org>
References: <20230801115235.67343-1-marcin.szycik@linux.intel.com>
 <20230803131126.GD53714@unreal>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20230803131126.GD53714@unreal>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691074745; x=1722610745;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=RC90PoHcIJ3DN0re5YrF7v8v74QXIm/r6CDhc/SzN6E=;
 b=GSXmsc3GpzF9NMnVTjUyEfd5iysAf48sQ1YktyWs97Lk8z0ydOtD8guD
 HOPGqSrWV9gp8yWHuQHVCCsUKhMTFDTB6W+m3f+6Oavf+zNWf6VjA9LIK
 NH8M40rTgz6nErOULb++C7ZE312mX14BI8B+8D2UPnjIgMOC5jsI6qDEZ
 A81HUf9kvDTPKKeAjEGckJkanG9d3SP6FUedy1NRe6bdNfJKVwfiCD2Jg
 4V9gB8M2Qfj5iP79t2MkPXy8M3MHgAbL2dO+Zwtm6qX95FTuPpT87z5md
 CQ1wpm1kgTnXqa4J6sfKpTpvyYhQWufeX6J0RvrlUYi1zLXEHrbb3uraF
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=GSXmsc3G
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: Block switchdev mode
 when ADQ is acvite and vice versa
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
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>



On 03.08.2023 15:11, Leon Romanovsky wrote:
> On Tue, Aug 01, 2023 at 01:52:35PM +0200, Marcin Szycik wrote:
>> ADQ and switchdev are not supported simultaneously. Enabling both at the
>> same time can result in nullptr dereference.
>>
>> To prevent this, check if ADQ is active when changing devlink mode to
>> switchdev mode, and check if switchdev is active when enabling ADQ.
>>
>> Fixes: fbc7b27af0f9 ("ice: enable ndo_setup_tc support for mqprio_qdisc")
>> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>> ---
>>  drivers/net/ethernet/intel/ice/ice_eswitch.c | 5 +++++
>>  drivers/net/ethernet/intel/ice/ice_main.c    | 6 ++++++
>>  2 files changed, 11 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
>> index ad0a007b7398..2ea5aaceee11 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
>> @@ -538,6 +538,11 @@ ice_eswitch_mode_set(struct devlink *devlink, u16 mode,
>>  		break;
>>  	case DEVLINK_ESWITCH_MODE_SWITCHDEV:
>>  	{
>> +		if (ice_is_adq_active(pf)) {
>> +			dev_err(ice_pf_to_dev(pf), "switchdev cannot be configured - ADQ is active. Delete ADQ configs using TC and try again\n");
> 
> It needs to be reported through netlink extack.

Will do, thanks!

> 
>> +			return -EOPNOTSUPP;
>> +		}
>> +
>>  		dev_info(ice_pf_to_dev(pf), "PF %d changed eswitch mode to switchdev",
>>  			 pf->hw.pf_id);
>>  		NL_SET_ERR_MSG_MOD(extack, "Changed eswitch mode to switchdev");
> 
> Thanks
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
