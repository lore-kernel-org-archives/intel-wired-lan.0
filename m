Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2ADC433FE
	for <intel-wired-lan@archiver.kernel.org>; Sun, 13 Nov 2022 07:37:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2ACD181464;
	Sun, 13 Nov 2022 07:37:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2ACD181464
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1668325028;
	bh=FJxiTgLB5GlWJfr5ZpUidkIdkzv93FyVvzrhQLti9Hc=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DuorHhYOAYr2KCri2RPPr+qpIKElh4dCJyJy/SaXATulABc2yJf1UVxKj/1nYKHoJ
	 pB618mHyHakO1Jnx6elugRlcOoYQOWhhKTXG2mIDRyzn8G3uq4WGkaJh1kZFhwZIdY
	 DE5fc2dbeYHytdU0uBm5vO4T0ipVfpV4sxhYcSjmipmAvfg62GYOCZTGcU5Zep4mEu
	 tKAfCJZa9Wgk71NAoKQ9oPBwJ+6ub5JuCt+dkc4x7eM5DCWNVzv/Ih8Gi0vGSl8vEK
	 SxWMgVSfn5hrAB+/qvLoS5ylu/nuKLyOTKO3hV75LzEE2V5OcRPupEHhnHopJj92r8
	 04tAFGwZI1hWA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vPVIbNV4LIZN; Sun, 13 Nov 2022 07:37:07 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3059B81991;
	Sun, 13 Nov 2022 07:37:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3059B81991
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 30AD11BF4E5
 for <intel-wired-lan@osuosl.org>; Sun, 13 Nov 2022 07:37:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0AE8540562
 for <intel-wired-lan@osuosl.org>; Sun, 13 Nov 2022 07:37:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0AE8540562
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cx_ue51ZrxT7 for <intel-wired-lan@osuosl.org>;
 Sun, 13 Nov 2022 07:37:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6349D400CF
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6349D400CF
 for <intel-wired-lan@osuosl.org>; Sun, 13 Nov 2022 07:37:01 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="295151369"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; d="scan'208";a="295151369"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2022 23:37:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="743737534"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; d="scan'208";a="743737534"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.13.12.13])
 ([10.13.12.13])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2022 23:36:59 -0800
Message-ID: <2a0db6b0-1fce-55a6-cf02-a2cb97c60774@linux.intel.com>
Date: Sun, 13 Nov 2022 09:36:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
 intel-wired-lan@osuosl.org
References: <20221104120037.26717-1-muhammad.husaini.zulkifli@intel.com>
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20221104120037.26717-1-muhammad.husaini.zulkifli@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1668325021; x=1699861021;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=5NO4DvU0zc+EWDX5wsR9mzIAYd9Osp/luRquqh2Uh44=;
 b=WyqCSEBnpOCI7zPQafkHgkR1ZUGq46No8ascPjJbVgi7jWaMTFTotHCj
 DsyeIatA5WIXUyBCbhsU0gKovO2Cpftoug9c92L5y5e4rwEmh4a7DUuFH
 D65RLTRUCPjKuCDhSvfCEjJ88b4sv5H6akGfz3NdjVB3e8daMdE4GYmBG
 LkcZTGtbnZxatapmu+Kmt08eUpOtCxRvs8Tly82JBEpZkenSBb/hwnfEk
 gC+EmDdckSGpX5TXZ0BpfnSwwB9hR4GdKMAZjMxNcvFeCpAPwIeYFSTwT
 PAZjKp+xao78FqPSZ5O0UtneSjiwVLZ+KOSyivSe288cxwwNEPT5jnbcw
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=WyqCSEBn
Subject: Re: [Intel-wired-lan] [PATCH v1] igc: Add checking for basetime
 less than zero
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 11/4/2022 14:00, Muhammad Husaini Zulkifli wrote:
> Using the tc qdisc command, the user can set basetime to any value.
> Checking should be done on the driver's side to prevent registering
> basetime values that are less than zero.
> 
> Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 3 +++
>   1 file changed, 3 insertions(+)
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
