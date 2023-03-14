Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFACC6FD1F
	for <intel-wired-lan@archiver.kernel.org>; Tue, 14 Mar 2023 08:44:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5ABE406E0;
	Tue, 14 Mar 2023 08:44:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A5ABE406E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1678783460;
	bh=ocmCqmpg1ga1qn2JzZ3phnOM8JQk0H6fh8clnwxcS+k=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=YHs2qwwCruhtr8GxTPh8xWIt6ZWK2sy6Hl2dVriMk2O38K2O1RqcmvDIOfkwWFuuY
	 0mvmYI1aEtmE+bNo/gwvnN9GXBfS0VvwmVu1r0v6CghiJ4lFFukqiQ/j7ExkqAr3IE
	 ywmEldpDphgKeysCZAbIv7cqu/52b1vgifwsa0ouhi3zPb3HhbWc80vw0jzkC202VX
	 MyhZ53yKJTrs1v8l/3/ULAItB92S8Y1L/kEVT9LbuYt8k5ledn5JkLJ6aIu6Cb6DVG
	 S9LOmszi2u25K6dv7rZj2iVBzy64eO1/aewgB8n8Ixri6Xvs6YhajRmQdKm+DaRg+u
	 5PTlXDTH9Wz0w==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fcZ13RL_Pe66; Tue, 14 Mar 2023 08:44:19 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 826EC4183F;
	Tue, 14 Mar 2023 08:44:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 826EC4183F
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 8DD841BF2C3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Mar 2023 08:44:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 652074011F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Mar 2023 08:44:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 652074011F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NNes7A-9PwuW for <intel-wired-lan@lists.osuosl.org>;
 Tue, 14 Mar 2023 08:44:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0800540525
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0800540525
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Mar 2023 08:44:16 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="423636004"
X-IronPort-AV: E=Sophos;i="5.98,259,1673942400"; d="scan'208";a="423636004"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2023 01:44:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="1008327569"
X-IronPort-AV: E=Sophos;i="5.98,259,1673942400"; d="scan'208";a="1008327569"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.13.12.17])
 ([10.13.12.17])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2023 01:44:13 -0700
Message-ID: <7dbe162a-ce21-1a7a-742d-047c615a33cc@linux.intel.com>
Date: Tue, 14 Mar 2023 10:44:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, jesse.brandeburg@intel.com, 
 anthony.l.nguyen@intel.com
References: <20230307064531.68840-1-takahiro.akashi@linaro.org>
Content-Language: en-US
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20230307064531.68840-1-takahiro.akashi@linaro.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1678783456; x=1710319456;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=7OQgDKpAKey7+l+RgQJ9F0gVi1YoaK7DEPgd2Nno5tk=;
 b=YdBOllwfgBD2o/W54rFig3fJOBfgIQHuG9MVyfUGDYR5o8FilrjebDdH
 TLmc2KcyHHhwfiPHMit/ZRgIWjlm0RVZozBmoPhIUPDBQEL1Toto2VyMr
 wB9OWm8oZaDyx+cV5OeIL4MPgt6ReN9A70MGrYi8psttNUWjf3hKABnsH
 MuFIA3K8a78RQmzgHqYzn6J4Q3vKWM2PcthhWgLkIUI4nk4NX2eQ91Mnl
 H1ZH5+Q0E1r0xInCdIA0tppOZ1JwzVX4xo02rtiDNGFN1s5NymHSsoc/y
 u5nLF4hr3LhOKtyTKzCAnWhDqWjO02Gf9IW49RJRFmbJIGqpfhBtcYIJx
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=YdBOllwf
Subject: Re: [Intel-wired-lan] [PATCH] igc: fix the validation logic for
 taprio's gate list
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
Cc: kurt@linutronix.de, intel-wired-lan@lists.osuosl.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 3/7/2023 08:45, AKASHI Takahiro wrote:
> The check introduced in the commit a5fd39464a40 ("igc: Lift TAPRIO schedule
> restriction") can detect a false positive error in some corner case.
> For instance,
>      tc qdisc replace ... taprio num_tc 4
> 	...
> 	sched-entry S 0x01 100000	# slot#1
> 	sched-entry S 0x03 100000	# slot#2
> 	sched-entry S 0x04 100000	# slot#3
> 	sched-entry S 0x08 200000	# slot#4
> 	flags 0x02			# hardware offload
> 
> Here the queue#0 (the first queue) is on at the slot#1 and #2,
> and off at the slot#3 and #4. Under the current logic, when the slot#4
> is examined, validate_schedule() returns *false* since the enablement
> count for the queue#0 is two and it is already off at the previous slot
> (i.e. #3). But this definition is truely correct.
> 
> Let's fix the logic to enforce a strict validation for consecutively-opened
> slots.
> 
> Fixes: a5fd39464a40 ("igc: Lift TAPRIO schedule restriction")
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
