Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D461C77B75
	for <intel-wired-lan@archiver.kernel.org>; Mon,  8 May 2023 04:36:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A4E4D40120;
	Mon,  8 May 2023 04:36:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A4E4D40120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1683520597;
	bh=zq0635leWdlJ6iVZQTEHZNoBGqrtk/NXzwXXwuZV2NU=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=FxaYRz6VXvbUFG84XV7LwhshE0HP3qsph08vJe+Q72YP7EwDvVbfFrGn6xksClU2p
	 gpB2f+/WqAyJdW/ym7ygeV8oricSIGMSlSf2JMTLglr2e40w5KpIVyFmtgIX6nPi3f
	 bkcyf9eTeESLVk6Fpfjf41CDhLzmIqnryKBvizj4V55w1Fdyixlj0pBakuyvDzawZX
	 ODnFds0ue7S4gCo/WIONPefNDudaWPap/Iidrynk+3i5n7Vd6dUf/KbeoDl+cigx1v
	 1GwrY9XTPIcULQfMc5jjd9kTpj02AyXEQPzwC2im1OyiiVhp4lstWClkJKucEQc1aS
	 PrJx04WJqcZOQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ta_fHClC58r0; Mon,  8 May 2023 04:36:37 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id B1DF04028D;
	Mon,  8 May 2023 04:36:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B1DF04028D
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 24E0F1BF282
 for <intel-wired-lan@lists.osuosl.org>; Mon,  8 May 2023 04:36:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0739A4028D
 for <intel-wired-lan@lists.osuosl.org>; Mon,  8 May 2023 04:36:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0739A4028D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GFNp34SrnKTG for <intel-wired-lan@lists.osuosl.org>;
 Mon,  8 May 2023 04:36:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3BF2240120
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3BF2240120
 for <intel-wired-lan@lists.osuosl.org>; Mon,  8 May 2023 04:36:33 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="377645807"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; d="scan'208";a="377645807"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2023 21:36:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="842563929"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; d="scan'208";a="842563929"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.13.1.151])
 ([10.13.1.151])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2023 21:36:11 -0700
Message-ID: <eee412d0-711f-dee9-3785-0db9847a4755@linux.intel.com>
Date: Mon, 8 May 2023 07:36:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 intel-wired-lan@lists.osuosl.org
References: <20230417221839.292728-1-vinicius.gomes@intel.com>
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20230417221839.292728-1-vinicius.gomes@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1683520594; x=1715056594;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=5sdXVhaNzPwex0LBSgoZ0O7lJqYBMuEUO/A+83a9uBQ=;
 b=MHOUaln45YbUNkX2UN6ED0pYhBBJgdBoaV+kJmD/4xz24/rVfhEW3+KV
 ikYiCKV+SGv7EjILOFJmUgurYYP208FZRpnOP7MnLClPwEGiqjGfCjeKr
 PJahYUf57cKhtxbDyveUmDVYYrECzHsiAEObhlVOhmZmRrDXWyJ+5v9zc
 NBNs2nI7vqmSQWmOlOWrtOba/3EBcIKyjD4/XUcFncmQgZ6HiiWjyPUNo
 I9Ti5BuNSO/i24Q4fmUIMpSTdb1+fJ6MdpGx/3i4NGT5x9EjMu5Y1uRMf
 fKRlosQXsRMXKJopb8XTSvlUN7UiKcvck5kECXYs/oD3EDrXPauHRvEZ1
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=MHOUaln4
Subject: Re: [Intel-wired-lan] [PATCH net-queue v1] igc: Fix possible system
 crash when loading module
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

On 4/18/2023 01:18, Vinicius Costa Gomes wrote:
> Guarantee that when probe() is run again, PTM and PCI busmaster will be
> in the same state as it was if the driver was never loaded.
> 
> Avoid an i225/i226 hardware issue that PTM requests can be made even
> though PCI bus mastering is not enabled. These unexpected PTM requests
> can crash some systems.
> 
> So, "force" disable PTM and busmastering before removing the driver,
> so they can be renabled in the right order during probe(). This is
> more like a workaround and should be applicable for i225 and i226, in
> any platform.
> 
> Fixes: 1b5d73fb8624 ("igc: Enable PCIe PTM")
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 3 +++
>   1 file changed, 3 insertions(+)

Tested-by: Naama Meir <naamax.meir@linux.intel.com>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
