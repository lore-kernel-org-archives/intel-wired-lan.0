Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC645C3DA7D
	for <intel-wired-lan@archiver.kernel.org>; Sun,  1 Jan 2023 11:35:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6FCA0409DD;
	Sun,  1 Jan 2023 11:35:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6FCA0409DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1672572918;
	bh=Vr50yottYgFcw5vBwIgYJm1o8lhNDb0t4Y1I0x/2O/4=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=gdsq9LgWiZq1mUICE55i5DPMw9xJE99akXwHyyqFv4Qg6rmIKQ0ag0vjS3U9szJob
	 fFwKK94zqO+K2Xawj53dYEhVm5/nRHk2FDktMQw2lcRFOHKsLBANwjG1Z+izW89Akk
	 3/NlVLGBac6TNPGIvr2MJurWLoR6D8qlfXjBKQqY4SMdJik0kKLzlESIGJnHU/ouEt
	 YCaBqmsv01d0wUOPKbOkL2ghfGOrtkpnUVLForSG/EDju3DRSfQ1ORTj4BLsp6ajQM
	 HHY+ojIyzQ55ZdfY523F/oOmPyuhI9P0HlUqJiy1muw57/vxZ1llRREo6GP6xwxwXQ
	 GTFmn7QmZQiQg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4CeljlQwUPia; Sun,  1 Jan 2023 11:35:17 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42D2B409A3;
	Sun,  1 Jan 2023 11:35:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 42D2B409A3
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 98C041BF29C
 for <intel-wired-lan@osuosl.org>; Sun,  1 Jan 2023 11:35:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7261260E56
 for <intel-wired-lan@osuosl.org>; Sun,  1 Jan 2023 11:35:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7261260E56
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5cfHjxOycvax for <intel-wired-lan@osuosl.org>;
 Sun,  1 Jan 2023 11:35:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D0AD060E53
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D0AD060E53
 for <intel-wired-lan@osuosl.org>; Sun,  1 Jan 2023 11:35:14 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10577"; a="383679260"
X-IronPort-AV: E=Sophos;i="5.96,292,1665471600"; d="scan'208";a="383679260"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jan 2023 03:35:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10577"; a="722737587"
X-IronPort-AV: E=Sophos;i="5.96,292,1665471600"; d="scan'208";a="722737587"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.13.11.251])
 ([10.13.11.251])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jan 2023 03:35:12 -0800
Message-ID: <63dcefca-4d30-f770-61f0-890ce1ad08f2@linux.intel.com>
Date: Sun, 1 Jan 2023 13:35:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
 intel-wired-lan@osuosl.org, vinicius.gomes@intel.com
References: <20221214162909.22856-1-muhammad.husaini.zulkifli@intel.com>
 <20221214162909.22856-4-muhammad.husaini.zulkifli@intel.com>
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20221214162909.22856-4-muhammad.husaini.zulkifli@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1672572914; x=1704108914;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=rxUDMTCJLyhDcPSviOCA3IMSJtuunpqzfeE0E2bwOzA=;
 b=bafTVmrrra+sFSUMcK2sWudBrEcRHxv/FB4rFivb42Jlt36YVOVk3GFC
 3/vbsh6N7ypiwkj5TpSTxFMYmYHGSs/790DmEaa2PQFDZCI48OT2Z/Ydc
 ZdsDn4Zibrw+8v45J47EJCeueF+uzu6kQsjcju8PK7tfajEhgNT8hjCkI
 f0mkbNwVtHweUbWVf/JeUIwuMwE+nFDPhAeve9FAGZNIwILr4uOuBVwbQ
 8RDNxWjRV/mSkjCXI/hjN7PswK4gVzjaphf3PcTAtsezG9fulLAXnlYtU
 pClBNGv39MHvEb3SH9laKUV/ubcQuGS8DQyPt85OKIVMYPSgxDosMyUTa
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=bafTVmrr
Subject: Re: [Intel-wired-lan] [PATCH net-next v2 3/3] igc: Remove reset
 adapter task for i226 during disable tsn config
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
Cc: anthony.l.nguyen@intel.com, tee.min.tan@linux.intel.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 12/14/2022 18:29, Muhammad Husaini Zulkifli wrote:
> I225 have limitation when programming the BaseTime register which required
> a power cycle of the controller. This limitation already lifted in I226.
> This patch removes the restriction so that when user configure/remove any
> TSN mode, it would not go into power cycle reset adapter.
> 
> How to test:
> 
> Schedule any gate control list configuration or delete it.
> 
> Example:
> 
> 1)
> 
> BASE_TIME=$(date +%s%N)
> tc qdisc replace dev $interface_name parent root handle 100 taprio \
>      num_tc 4 \
>      map 3 1 0 2 3 3 3 3 3 3 3 3 3 3 3 3 \
>      queues 1@0 1@1 1@2 1@3 \
>      base-time $BASE_TIME \
>      sched-entry S 0F 1000000 \
>      flags 0x2
> 
> 2) tc qdisc del dev $intername_name root
> 
> Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c |  6 +++---
>   drivers/net/ethernet/intel/igc/igc_tsn.c  | 11 +++--------
>   drivers/net/ethernet/intel/igc/igc_tsn.h  |  2 +-
>   3 files changed, 7 insertions(+), 12 deletions(-)
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
