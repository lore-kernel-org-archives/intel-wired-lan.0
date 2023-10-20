Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1EB0C0032E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Oct 2023 23:51:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4A36343485;
	Fri, 20 Oct 2023 23:51:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4A36343485
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1697845898;
	bh=m5vGaT2tbPgV9/lv3k+R4XTvnp5CekqyXU7HhHltoTU=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=U3mmr/jGZcP1M/lGCZJPoVq6EIcYt5ubuh/gNMh9eL1T2Lo74mjPilwab4ieaoO7s
	 yJrB1a8N0/va0iewB7a8GOk7VY0rDDDJxZW4FqRxRWeI3iVs45EI5LqeptNmije30U
	 DQT5NCGMaitoeorjlRVvnrfXeZ33+bSDFCtacxOoY7IIEUoZT1FjMqWs1gBcdHt78B
	 3ZtiLtWH4EYSQb1ul5dzuugBcfiqR8kXvtThhifrNbUxrpSUYHwk35wf16Q668E7Od
	 Pk6ftiA5IQynOoXLCrKUZLYwsM5uiSMNyVj82Y7FN2gFjdVQ9dVPgHuNW1tpsFL4CD
	 bPbqOkOYirqUQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X_zc9yw-6ppd; Fri, 20 Oct 2023 23:51:34 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id DF3024348B;
	Fri, 20 Oct 2023 23:51:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DF3024348B
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 6D2C71BF27A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Oct 2023 23:51:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4EAB284D8F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Oct 2023 23:51:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4EAB284D8F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6YP48jxeXEOS for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Oct 2023 23:51:31 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8C0C384D90
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Oct 2023 23:51:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8C0C384D90
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 666A5B833D7;
 Fri, 20 Oct 2023 23:51:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F09C433C7;
 Fri, 20 Oct 2023 23:51:27 +0000 (UTC)
Date: Fri, 20 Oct 2023 16:51:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michal Schmidt <mschmidt@redhat.com>
Message-ID: <20231020165126.03bb9eff@kernel.org>
In-Reply-To: <20231019071346.55949-1-mschmidt@redhat.com>
References: <20231019071346.55949-1-mschmidt@redhat.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1697845887;
 bh=+C8SywAtuLWun+lQt8i6BXrJYmp4V7Mb9eDL4qkunag=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=VHd3rG2mrnIorHLZ1G5bIu6pahJAxOiT2fRlK4v7pl7I/FtTqkGgYUWTp4/x43tzW
 WmSJ/qfTp1osFWFvb7aRsO7UvfcM4KdYl+zqUZNM71/5qIbcqhKVfoJ9krwH6JAsYF
 0dEFmrW+ViI6CqjjW0kWh92g8pVWgtK46LBpO9awVBEoAs5ZH13aNJxU9I3eRAozkv
 FPss69aoDuphPJPtoWMZSefhTymKzcu4aB6usigfOKpWzfMdDFT/q7qamwLCmfEYeR
 0ZiVKtU0a/rOoKvoUMJrom9aYBnVNLdd/SlSSbcO5rq9KYOglmIgXZxqeoVIrnnc94
 Yjignuqtgi/TQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=VHd3rG2m
Subject: Re: [Intel-wired-lan] [PATCH net] iavf: initialize waitqueues
 before starting watchdog_task
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
Cc: netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>,
 intel-wired-lan@lists.osuosl.org, Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, 19 Oct 2023 09:13:46 +0200 Michal Schmidt wrote:
> It is not safe to initialize the waitqueues after queueing the
> watchdog_task. It will be using them.
> 
> The chance of this causing a real problem is very small, because
> there will be some sleeping before any of the waitqueues get used.
> I got a crash only after inserting an artificial sleep in iavf_probe.
> 
> Queue the watchdog_task as the last step in iavf_probe. Add a comment to
> prevent repeating the mistake.

Applied as 7db31110438 in net, thanks!
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
