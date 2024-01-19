Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C55C4725D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 19 Jan 2024 14:49:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 92824421C4;
	Fri, 19 Jan 2024 14:49:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 92824421C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1705675797;
	bh=/Evk07pOXfDxcBaHw9qxWdw/BUJxVtQ6PwywBrP5GsY=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=aEOd7AwHMmBooQwomUw0wjN8EB0kRW6nAxVNzlqaYCUbfD/+zN2f1v7t9KAmE5KfY
	 a9fog+YW1lowdomxgKmaSitrUPSGs1+5yux/nyOXzRYPQy44nFPq666fX43ZM7wxUU
	 YL3INUKZdntTC80Vwnzd4hoXPKYGA16PA+74BtnDgFw76IhUX6LCA43J597VCsp6y8
	 FQjuYlQT0xmYnJQfzWjTQi0KbvCwfVielpHoES+mcf4REIFEHyJObpVHWKD9Nn6qNZ
	 YgtUQkpIhiBiWUdDMPrF7obcblHiuiti3iVgXadh7H4+AZdeCL4QEw0TZYQpJI7RXR
	 JNTiNWIW/YNJw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l2HFifIue1Cf; Fri, 19 Jan 2024 14:49:57 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE951421D1;
	Fri, 19 Jan 2024 14:49:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CE951421D1
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 501481BF35A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 19 Jan 2024 14:49:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 26CFC4219D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 19 Jan 2024 14:49:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 26CFC4219D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I2o1ejsN08hm for <intel-wired-lan@lists.osuosl.org>;
 Fri, 19 Jan 2024 14:49:33 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1D0624218B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 19 Jan 2024 14:49:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1D0624218B
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 031ED619E2;
 Fri, 19 Jan 2024 14:49:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC55C433F1;
 Fri, 19 Jan 2024 14:49:29 +0000 (UTC)
Date: Fri, 19 Jan 2024 14:49:26 +0000
From: Simon Horman <horms@kernel.org>
To: Suresh Kumar <suresh2514@gmail.com>
Message-ID: <20240119144926.GA89683@kernel.org>
References: <20240119131652.8050-1-suresh2514@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119131652.8050-1-suresh2514@gmail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1705675771;
 bh=hCsjv91Yj4g0mu9TcH2Xv3lssnwsCBwDQBHzNUt9fjU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CcUDEGoOFlcLo+0ZJN8vUz0TsUYBvRn2MSjEw9MRuxGor91adf5VbKu9ojYSgtNO4
 kId5csymMPuYgpMxvigwacpP1EHfXn+XdukEQs+mkq0FIXTlFiOO1vs70PVVgY6sBP
 GGmRWFZXPvqkdoMGzh2Zq02GXHL+G8ZRV6Zyv39U9YPCxOzr+WKZJTKOcvrkds3kOm
 kwIMCj6z2iAaOIoYCCyryl9oS6K8Xbk/UCmSauqVHq1SHavRCY17ETnyjN6xVAB1nB
 HPESE3H8wd6ihIoJrc7/u+BqXZSA5mue2NeWPiEE087Z13Oa1ZwvXoRYSi8mLwnekj
 +5iwZ2vt9T5Sw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=CcUDEGoO
Subject: Re: [Intel-wired-lan] [PATCH] i40e: print correct hw max rss count
 in kernel ring buffer
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
Cc: intel-wired-lan@lists.osuosl.org, jesse.brandeburg@intel.com,
 linux-kernel@vger.kernel.org, edumazet@google.com, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, Jan 19, 2024 at 06:46:52PM +0530, Suresh Kumar wrote:
> The value printed for  "HW max RSS count" is wrong in kernel dmesg for i40e
> NICs:
> 
>   ... i40e 0000:63:00.0: User requested queue count/HW max RSS count: 48/64
> 
> whereas  ethtool reports the correct value from "vsi->num_queue_pairs"
> 
> Channel parameters for eno33:
> Pre-set maximums:
> RX:     n/a
> TX:     n/a
> Other:      1
> Combined:   96
> Current hardware settings:
> RX:     n/a
> TX:     n/a
> Other:      1
> Combined:   96  <-------
> 
> and is misleading.
> 
> This value is printed from 'pf->rss_size_max' which seems hardcoded.
> 
> Below commit also removed this 64 limit:
> 
> Commit e56afa599609d3afe8b0ce24b553ab95e9782502
> Author: Amritha Nambiar <amritha.nambiar@intel.com>
> Date:   Wed Nov 8 16:38:43 2017 -0800
> 
>     i40e: Remove limit of 64 max queues per channel

Hi Suresh,

I think it would be more normal to cite this commit something like this:

The limit of 64 was removed by
commit e56afa599609 ("i40e: Remove limit of 64 max queues per channel")

Also, it's not clear to me if this should be considered a fix or not.
If not, which I lean towards, then it should probably be targeted
at iwl-next.

	Subject: [PATCH iwl-next] ...

If it is a fix, then it should have a Fixes tag and probably
be targeted at iwl.

	Subject: [PATCH iwl] ...

...
