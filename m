Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB78C7EE2F
	for <intel-wired-lan@archiver.kernel.org>; Tue, 23 May 2023 08:19:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 108C141606;
	Tue, 23 May 2023 08:19:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 108C141606
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1684829942;
	bh=thoQtyatmo15ktriCT5EuVSjBsD4VPQn2UpqJu8GVSg=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=dtHP4cQq68I6H8ie0hMzVejbqovyspVSHEmIgvmlhBKGAn8cgNjKm0GAhxMRHrINK
	 q6MKhywj66jRQVvSvdFPAjB2aV2VclPcq5Vy9x7WkaAe2XbxWQxStroNgQQLaDObWS
	 qnSSlvo1B23F8bouoaxTKW0IGyql4dcY7HFuoGm4qck3gTqRwx4/BdNKV4MIidD+Np
	 Z8K146SkHuPN4aNT6jXoDt4plg0rmoTMjBje8eUvRVxkr2GGuRNFJHrYhoHzVvSkrQ
	 g04GiKqy0cyvwt57fPRjlsSaIVQP+g1r1BWMBJ/XEPZRbHL+XLi0QHF0aa+IxvmLa0
	 I3Ox5CZbjUsyA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OXlWAYwAXr_Q; Tue, 23 May 2023 08:19:01 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id D46B241695;
	Tue, 23 May 2023 08:19:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D46B241695
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id A92C61BF2FC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 May 2023 08:18:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7F6F641695
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 May 2023 08:18:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7F6F641695
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hWDc7G5AsuIh for <intel-wired-lan@lists.osuosl.org>;
 Tue, 23 May 2023 08:18:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 83EF541606
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 83EF541606
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 May 2023 08:18:57 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="350681427"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; d="scan'208";a="350681427"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2023 01:18:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="768916537"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; d="scan'208";a="768916537"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.13.12.21])
 ([10.13.12.21])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2023 01:18:52 -0700
Message-ID: <124903a0-56a8-097b-3919-7a67ab6bff8d@linux.intel.com>
Date: Tue, 23 May 2023 11:18:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 intel-wired-lan@lists.osuosl.org
References: <20230511230731.105152-1-vinicius.gomes@intel.com>
 <20230511230731.105152-3-vinicius.gomes@intel.com>
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20230511230731.105152-3-vinicius.gomes@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684829937; x=1716365937;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Oal5+6d596lTjgv6Lvmx2kACSzEyQFoR6MnGB5bhVm0=;
 b=JNBWINCbohuzjbobbVH6x+sX2vnRl+NSX77J64NNUKHOdxkDQ6PiOLzF
 huHGjGU0/FWIhlLtgefeLFSDl3vM3gAH3wtsUM/rO/OTHMhRYesqmdNNL
 gkD+lFEWsxundXF0ofpdo1vA2jUGD9+/YL6UeCeUbCJ9BfAIq3VHJMlSJ
 7ED1LYLywGYRXZv+HAfIVIF9D6zD04WZTN3tOAJd22fSygGPmNNyBGSx1
 bFLnA+i1RCklZf4zBIGS9bQVqL435tv7H1XwyFONUH1IYrv4NvmFTQAKW
 8P17sxPWjnfGJkSZOb5LRYnykB8tapj+es+AMO2EYptLH/wuFC4Usl2u6
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=JNBWINCb
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2 2/4] igc: Check if hardware
 TX timestamping is enabled earlier
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
Cc: vladimir.oltean@nxp.com, kurt@linutronix.de, anthony.l.nguyen@intel.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 5/12/2023 02:07, Vinicius Costa Gomes wrote:
> Before requesting a packet transmission to be hardware timestamped,
> check if the user has TX timestamping enabled. Fixes an issue that if
> a packet was internally forwarded to the NIC, and it had the
> SKBTX_HW_TSTAMP flag set, the driver would mark that timestamp as
> skipped.
> 
> In reality, that timestamp was "not for us", as TX timestamp could
> never be enabled in the NIC.
> 
> Checking if the TX timestamping is enabled earlier has a secondary
> effect that when TX timestamping is disabled, there's no need to check
> for timestamp timeouts.
> 
> We should only take care to free any pending timestamp when TX
> timestamping is disabled, as that skb would never be released
> otherwise.
> 
> Fixes: 2c344ae24501 ("igc: Add support for TX timestamping")
> Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c |  5 +++--
>   drivers/net/ethernet/intel/igc/igc_ptp.c  | 23 ++++++++++++++++++++---
>   2 files changed, 23 insertions(+), 5 deletions(-)

Tested-by: Naama Meir <naamax.meir@linux.intel.com>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
