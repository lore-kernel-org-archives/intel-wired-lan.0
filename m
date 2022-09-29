Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B945EC433F5
	for <intel-wired-lan@archiver.kernel.org>; Thu, 29 Sep 2022 15:23:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 40E8C80F2C;
	Thu, 29 Sep 2022 15:23:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 40E8C80F2C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1664465013;
	bh=bYpYg4ZD0cgWuCsOsh8p//p3Ei3klYnKmlgw0SxtxeI=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=lRO9UF1xRDxJettZIDdWdJnMiVPA1winnhtm0ndiIjwNPSuKORdGD6yw08SszbtZi
	 jwqUjeoIWH/BAe4PKK42zMMD/dGRlKP+Xj+t+JoZ+vPxXbnRnI7fwjf2aElIuDGKRh
	 /K2ZdTAC1wIqUFQKMg1b2i4g6kdTzjtH24IvRizJgJzKfs4Eag3zDr3wiLRyxvovyq
	 7bzDvwzxvxVBIpOASIdhqnz0Z+0DYgAOTD5y0EyCjUUp5VYT9AckfrrweUfrycPMfv
	 /tKUqL29ii+Mi9Td/1MRiCM7vtcfz0SsPbqCjS9Tuv607b97+5MsbSc98j7kuhK05Z
	 njdfaSIqPCCGA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lrH_HweZxsAc; Thu, 29 Sep 2022 15:23:32 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 525E680F59;
	Thu, 29 Sep 2022 15:23:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 525E680F59
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 322941BF476
 for <intel-wired-lan@osuosl.org>; Thu, 29 Sep 2022 15:23:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0C5D640B90
 for <intel-wired-lan@osuosl.org>; Thu, 29 Sep 2022 15:23:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0C5D640B90
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V_zo2SzmhaEc for <intel-wired-lan@osuosl.org>;
 Thu, 29 Sep 2022 15:23:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 61E804016F
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 61E804016F
 for <intel-wired-lan@osuosl.org>; Thu, 29 Sep 2022 15:23:30 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4B7F16124B;
 Thu, 29 Sep 2022 15:23:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B2CC433C1;
 Thu, 29 Sep 2022 15:23:28 +0000 (UTC)
Date: Thu, 29 Sep 2022 08:23:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Message-ID: <20220929082327.209d6227@kernel.org>
In-Reply-To: <6f6f4487-1c5d-de4e-0c79-452128deae0c@nvidia.com>
References: <20220927130656.32567-1-muhammad.husaini.zulkifli@intel.com>
 <20220927170919.3a1dbcc3@kernel.org>
 <SJ1PR11MB6180CAE122C465AB7CB58B1BB8579@SJ1PR11MB6180.namprd11.prod.outlook.com>
 <20220929065615.0a717655@kernel.org>
 <6f6f4487-1c5d-de4e-0c79-452128deae0c@nvidia.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1664465008;
 bh=YTe9P14YqLojcsFy0//pbq/oilNL4/PiTLUABmITT5o=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=dKHScsEP9kA+srQPwLyWwY4qEkixRmiljWfWMcVQXtqIj483h+/LKx2b+cDCMzuHk
 rEKjuAf5TFwRKzyV00WRHtcr7b+YYaLs8PIcCOQuWD7qDU/3YNzPHElyPyvxgMlS6G
 yqRYsA0Jskxz53CwLoQeag48dsOhxk+pkyLgBaTfSGTqoCxHMbSlAapnE3JcYoaEly
 kztBxS8D4ScpirEnIewOVOxxQIgYd1tWPJCWhx7SnVR+nBjxnX36FQGkrOREZcHBw1
 W7s4kHESUFgVs+cn8o6PABkSpHFLOPpkEKuQgk9FiiDa9qU8nyivSUjW/aeWO01vWo
 NyrwNKlNunesA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=dKHScsEP
Subject: Re: [Intel-wired-lan] [PATCH v1 0/4] Add support for DMA timestamp
 for non-PTP packets
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
Cc: "leon@kernel.org" <leon@kernel.org>,
 "intel-wired-lan@osuosl.org" <intel-wired-lan@osuosl.org>,
 Richard Cochran <richardcochran@gmail.com>, Saeed Mahameed <saeed@kernel.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Michael Chan <michael.chan@broadcom.com>, "Zulkifli,
 Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 Andy Gospodarek <andy@greyhouse.net>, "Ahmad Tarmizi,
 Noor Azura" <noor.azura.ahmad.tarmizi@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, 29 Sep 2022 17:46:04 +0300 Gal Pressman wrote:
> What exactly do you mean by DMA stamps?
> 
> Our NIC supports two modes of operation (both TX/RX):
> - CQE timestamp (I think that's what you call DMA timestamp), where the
> timestamp is written when the completion is being written/generated.
> - Port timestamp (MAC timestamp), where the timstamp is written when the
> packet is being sent to the wire, or received from the wire. This
> doesn't account for the time the packet spent inside the NIC pipeline.
> 
> So I believe the answer to your question is yes :).

Thanks! I think we should provide the config API for both Tx and Rx,
then.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
