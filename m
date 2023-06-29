Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54ABAEB64D9
	for <intel-wired-lan@archiver.kernel.org>; Thu, 29 Jun 2023 16:25:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CC1CE408EA;
	Thu, 29 Jun 2023 16:25:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CC1CE408EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1688055949;
	bh=kiQairK12w0FLk2P5/v+sXwSsPN0cniPu8Gs0td8PFM=;
	h=From:To:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=UKAgTzd2yl/jJzBCyVZrLmBE70poOFZyEgRniMHG6jhqyraZLZZCCoqkin4m7bEr+
	 BnwOF2WV33fUkjKBEmssVApF3yYGPrQz0pROg0EHQuXsk6dYLBo7p0+xHzGqsezXzr
	 /QrUoyakHWuzu23lZRLn5lgAHKJc73fnMCmb08Soc0yUEYKV+T+iE0KzBBVAUAgBjD
	 bp+0MayD5q23375Z7S3ULzKh8VswZiPsqBZoktcBXmQ0iwjcMJJ283itOADRDjkVeI
	 pHCLn0EVoU0NU/dyq2dvnO03jR9RrBQZPOCTyOocj8SidP7G+UhbsNa4hYTjNLiEaE
	 pEPQPr90bHBEA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6ZTQNABFT5Vy; Thu, 29 Jun 2023 16:25:49 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id C740D40960;
	Thu, 29 Jun 2023 16:25:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C740D40960
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id C2CDA1BF2A2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jun 2023 16:25:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A7C0A81F8E
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jun 2023 16:25:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A7C0A81F8E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1Q9XaO45tmoA for <intel-wired-lan@lists.osuosl.org>;
 Thu, 29 Jun 2023 16:25:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EDF8981F8D
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EDF8981F8D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jun 2023 16:25:45 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="448535716"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; d="scan'208";a="448535716"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2023 09:25:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="752704992"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; d="scan'208";a="752704992"
Received: from pdurugk-mobl1.amr.corp.intel.com (HELO vcostago-mobl3)
 ([10.209.78.99])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2023 09:25:43 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Florian Kauer <florian.kauer@linutronix.de>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Vedang Patel <vedang.patel@intel.com>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Jithu Joseph
 <jithu.joseph@intel.com>, Andre Guedes <andre.guedes@intel.com>, Simon
 Horman <simon.horman@corigine.com>
In-Reply-To: <b64dc5c7-600c-66db-d125-2d747a21c1d8@linutronix.de>
References: <20230628091148.62256-1-florian.kauer@linutronix.de>
 <87a5wjqnjk.fsf@intel.com>
 <b64dc5c7-600c-66db-d125-2d747a21c1d8@linutronix.de>
Date: Thu, 29 Jun 2023 09:25:43 -0700
Message-ID: <87edlup75k.fsf@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688055945; x=1719591945;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=GMipEncNpFuzbp3Y+IWzNKkgCXn6RBM75OjxnGRggWw=;
 b=E8bQy556/srgARCNaSz7ZsTmGIHjeK91iu375fgV8Kymnc5Y+l8PN/TI
 GOZ8YJC7iF2Du09fH8MrgYG6vJSKel/CswKmKCLhkeWnj20GK0P1Oeg77
 dTMEolXbjX9vlyvgCKJqFaIgI0u9ZcT5k7c+ICczZ5L//T5jz5fScU78E
 inRWh7rdmgzG9j4gE+6mKBKVVhvxW2KmMRTIpt02ld6+Mh6dcIqRhvNZD
 IV7kEYD1sLU0mL7tEy/+4IxaZ0Dtk5QuYfoMXVPP/AA7IxUgqZXhnnYuB
 uB/afqPjs7IdKpki64FA2+b5HQWgDes4/j2Cn5ftitIevZVVATWqP5Gep
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=E8bQy556
Subject: Re: [Intel-wired-lan] [PATCH net v2] igc: Prevent garbled TX queue
 with XDP ZEROCOPY
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
Cc: netdev@vger.kernel.org, kurt@linutronix.de,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Florian Kauer <florian.kauer@linutronix.de> writes:

> Hi Vinicius,
>
> On 28.06.23 23:34, Vinicius Costa Gomes wrote:
>> Florian Kauer <florian.kauer@linutronix.de> writes:
>> 
>>> In normal operation, each populated queue item has
>>> next_to_watch pointing to the last TX desc of the packet,
>>> while each cleaned item has it set to 0. In particular,
>>> next_to_use that points to the next (necessarily clean)
>>> item to use has next_to_watch set to 0.
>>>
>>> When the TX queue is used both by an application using
>>> AF_XDP with ZEROCOPY as well as a second non-XDP application
>>> generating high traffic, the queue pointers can get in
>>> an invalid state where next_to_use points to an item
>>> where next_to_watch is NOT set to 0.
>>>
>>> However, the implementation assumes at several places
>>> that this is never the case, so if it does hold,
>>> bad things happen. In particular, within the loop inside
>>> of igc_clean_tx_irq(), next_to_clean can overtake next_to_use.
>>> Finally, this prevents any further transmission via
>>> this queue and it never gets unblocked or signaled.
>>> Secondly, if the queue is in this garbled state,
>>> the inner loop of igc_clean_tx_ring() will never terminate,
>>> completely hogging a CPU core.
>>>
>>> The reason is that igc_xdp_xmit_zc() reads next_to_use
>>> before acquiring the lock, and writing it back
>>> (potentially unmodified) later. If it got modified
>>> before locking, the outdated next_to_use is written
>>> pointing to an item that was already used elsewhere
>>> (and thus next_to_watch got written).
>>>
>>> Fixes: 9acf59a752d4 ("igc: Enable TX via AF_XDP zero-copy")
>>> Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
>>> Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
>>> Tested-by: Kurt Kanzenbach <kurt@linutronix.de>
>>> ---
>> 
>> This patch doesn't directly apply because there's a small conflict with
>> commit 95b681485563 ("igc: Avoid transmit queue timeout for XDP"),
>> but really easy to solve.
>> 
>> Anyway, good catch:
>> 
>> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>
> I am sorry, that was bad timing. I prepared the initial patch on Friday and overlooked the merge.
> Shall I send a v3 or will someone else take care of the conflict
> resolution?

I think it's easier if you send a v3.


Cheers,
-- 
Vinicius
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
