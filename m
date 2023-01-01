Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B16C4708E
	for <intel-wired-lan@archiver.kernel.org>; Sun,  1 Jan 2023 11:16:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 460114089F;
	Sun,  1 Jan 2023 11:16:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 460114089F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1672571792;
	bh=CVY7Yu4MFecYTotttLr1Erz4xUhWVhIM0mzCTaxIVb8=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=rxiv4x5ybuGLXhoo4ja6vyZcExCLcDVTVB85dgtJvFPhrARObPMkgUHKBPTXrMuMi
	 fWzZjjRHgwXYDAPygHpqSngNH+trvF5EYEQ4E98tD17iz+g0vzxhteyyMQcEp16zov
	 i4XpzIYpF8pk9s/ni0vyuon4/pyOUquKPY+tIDXj3d4nLk/m5zuxXSC1np6dmQUo+m
	 M8nIuY1xGmE8cSJ2KSK6/Rpafs7AYA9FJ5iu5O76z+ChUiu2cN4w728KcSAlTCn0/l
	 RlXhturEMVMIu+/oR0pdVnyUvZ1J+HFg5emTTqH5wMODeEMoyvktKCQLog/qlEYGji
	 cbliNg3c0U16w==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WBjkbLI0EXHk; Sun,  1 Jan 2023 11:16:31 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 311D940874;
	Sun,  1 Jan 2023 11:16:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 311D940874
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id AD1321BF392
 for <intel-wired-lan@osuosl.org>; Sun,  1 Jan 2023 11:16:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 876A060E24
 for <intel-wired-lan@osuosl.org>; Sun,  1 Jan 2023 11:16:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 876A060E24
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EfkNggDif2wY for <intel-wired-lan@osuosl.org>;
 Sun,  1 Jan 2023 11:16:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E9E8E60E15
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E9E8E60E15
 for <intel-wired-lan@osuosl.org>; Sun,  1 Jan 2023 11:16:28 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10577"; a="407640743"
X-IronPort-AV: E=Sophos;i="5.96,291,1665471600"; d="scan'208";a="407640743"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jan 2023 03:16:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10577"; a="654260466"
X-IronPort-AV: E=Sophos;i="5.96,291,1665471600"; d="scan'208";a="654260466"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.13.11.251])
 ([10.13.11.251])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jan 2023 03:16:25 -0800
Message-ID: <71b8226c-06c6-efac-50f6-6b4f43a61bc9@linux.intel.com>
Date: Sun, 1 Jan 2023 13:16:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
 intel-wired-lan@osuosl.org, vinicius.gomes@intel.com
References: <20221216150357.12721-1-muhammad.husaini.zulkifli@intel.com>
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20221216150357.12721-1-muhammad.husaini.zulkifli@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1672571788; x=1704107788;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=V/Drwe46nNm8ImYDn+F+kyPBWTptKXLn2Dws9TEbR+8=;
 b=NF8SzHuhL8Jibqtufgk+Zlp1cinHF3ti4RvLQtSAXxgNA4qkjgtkkfZn
 LDAjdpYR/gk86xvSpPEnIhHuLmy/ccR83SPbTNJEXyB5mxGuA1hb/aw9N
 X/acPPJjcHCgL7O23/5OmFs3Nc02hYVsQAEAfPS/oVSkUVMeSt/nHmCRw
 WGHnqcCkRn91u4nh9ZO7NOFeiE1lBQghwZzjN9L0CwCgnoFiYgeYnZPRu
 XK999Fyg5au6i7ImFPq/lePGxXYl6aJqrd23tad/VcBNCJNkuKK2xpC1X
 a7IEL7pACaIR3GZqoBbA0Juw7m01+g/zGoKBP1QxzoLo+QYSPbRuyftvj
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=NF8SzHuh
Subject: Re: [Intel-wired-lan] [PATCH net-next v2] igc: offload queue max
 SDU from tc-taprio
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
Cc: kuba@kernel.org, netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 tee.min.tan@linux.intel.com, davem@davemloft.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 12/16/2022 17:03, Muhammad Husaini Zulkifli wrote:
> From: Tan Tee Min <tee.min.tan@linux.intel.com>
> 
> Add support for configuring the max SDU for each Tx queue.
> If not specified, keep the default.
> 
> All link speeds have been tested with this implementation.
> No performance issue observed.
> 
> How to test:
> 
> 1) Configure the tc with max-sdu
> 
> tc qdisc replace dev $IFACE parent root handle 100 taprio \
>      num_tc 4 \
>      map 0 1 2 3 3 3 3 3 3 3 3 3 3 3 3 3 \
>      queues 1@0 1@1 1@2 1@3 \
>      base-time $BASE \
>      sched-entry S 0xF 1000000 \
>      max-sdu 1500 1498 0 0 0 0 0 0 0 0 0 0 0 0 0 0 \
>      flags 0x2 \
>      txtime-delay 0
> 
> 2) Use network statistic to watch the tx queue packet to see if
> packet able to go out or drop.
> 
> Signed-off-by: Tan Tee Min <tee.min.tan@linux.intel.com>
> Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> 
> ---
> V1 -> V2: Rework based on Vinicius's comment.
> ---
> ---
>   drivers/net/ethernet/intel/igc/igc.h      |  1 +
>   drivers/net/ethernet/intel/igc/igc_main.c | 44 +++++++++++++++++++++++
>   2 files changed, 45 insertions(+)
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
