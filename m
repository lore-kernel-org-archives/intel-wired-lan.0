Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6511DC4332F
	for <intel-wired-lan@archiver.kernel.org>; Sun,  4 Dec 2022 11:45:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE68C60E63;
	Sun,  4 Dec 2022 11:45:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EE68C60E63
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1670154336;
	bh=1OhRYmXdGIdhE4vSZQG7t2jycnNezv/Jvr1qSMbNd0k=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LuLpUdIcHqv4dsfDIrm/Aqc+h/9ILdHSZcKiwKJtngrkIWhLq7YWDzVjC1FMjnrwZ
	 rWtW1Aqo5IQd1c/5RAlFkgzn6nNI230QF8cfwGcHJy//0M23hflfDyrThvcVqd2fX3
	 N6qX3nDA/Pn9MknNtu+SFZgiQuJwE+KvsxEcFIWgPTx5ji9KbGUo3rrjMLcuIV+vO7
	 6zs/tVSfnlVXYA+H9xwh9E1XJ+BCOFE3yUHPXj9GKlbX7o9XGoED32+mDyPAdfqWSX
	 EKq/nfQi3Z0+Y7HYCEJE7TFaBrrQ4KlYqjHgEg1pZv1q0sFk/AaG/Y7useUthgH9y3
	 OQbH7u+t6fS/Q==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R4i5lT0_cY9y; Sun,  4 Dec 2022 11:45:35 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 11BC260F42;
	Sun,  4 Dec 2022 11:45:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 11BC260F42
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 2561C1BF3B0
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Dec 2022 11:45:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EAD79415DA
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Dec 2022 11:45:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EAD79415DA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yt4Q35GXaYHU for <intel-wired-lan@lists.osuosl.org>;
 Sun,  4 Dec 2022 11:45:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 28C1F415DD
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 28C1F415DD
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Dec 2022 11:45:32 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10550"; a="402463830"
X-IronPort-AV: E=Sophos;i="5.96,217,1665471600"; d="scan'208";a="402463830"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2022 03:45:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10550"; a="787765261"
X-IronPort-AV: E=Sophos;i="5.96,217,1665471600"; d="scan'208";a="787765261"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.13.12.13])
 ([10.13.12.13])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2022 03:45:30 -0800
Message-ID: <197a0f2e-b9ab-ea35-86e3-fe33f54d4c52@linux.intel.com>
Date: Sun, 4 Dec 2022 13:45:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To: Sasha Neftin <sasha.neftin@intel.com>, intel-wired-lan@lists.osuosl.org
References: <20221120081511.4136778-1-sasha.neftin@intel.com>
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20221120081511.4136778-1-sasha.neftin@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1670154332; x=1701690332;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=lSb4PUe7vVgNnUp7mC7nft9yXdy2iOjGLisUDLOTZA0=;
 b=ga3NI3NQH7VOnWcR7SY1ebSD7yYqLEuJQMM5aZ2z9nrEHByyO3QhltmJ
 9PtaK+HhnHVAc/J1GWp0YR1IVupw0ifqBsPEU3Xg2G9M/9ZSNy9bT35yw
 rLmgynTlYC3zOm3sMLD8e1xBkjd2XagnhR9ZUSSE477CfL3L0fcNlTKVr
 xjwPeN+lhV6pFeDeZ5JBNb5NqQC+ZP3ei7A8oc11KHuVKTMwG1VhdPeB4
 /wLogiuggiMwWUEfhoFlHZ/nRMG5yNBoELftRRgT3Z3wKEam5Za/ZjzPU
 brs6cnh/PWqXzo9J+spWRGUOMT3aodHKwFsQuVzj1QTki71wbRUsGN2R1
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ga3NI3NQ
Subject: Re: [Intel-wired-lan] [PATCH v1 1/1] igc: Clean up and optimize
 watchdog task
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

On 11/20/2022 10:15, Sasha Neftin wrote:
> i225/i226 parts used only one media type copper. The copper media type is
> not replaceable. Clean up the code accordingly, and remove the obsolete
> media replacement and reset options.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc.h      |  2 --
>   drivers/net/ethernet/intel/igc/igc_main.c | 17 -----------------
>   2 files changed, 19 deletions(-)
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
