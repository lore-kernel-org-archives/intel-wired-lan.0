Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A9FC9830D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 14:52:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3871D60D91;
	Fri, 25 Sep 2026 14:52:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3wE3VrwXxz8v; Fri, 25 Sep 2026 14:52:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6751360D95
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790347966;
	b=LzuX7tbNsuYT0P/OUipxpklo07Z79vc+su34Buo0NOsNXgfhggLdwOIiJHNCTiMqGu5U
	 HUn71Dq2wYZ4HgmF6aneaXZbPj/njBoS5Y3VeMzKTTWwtRdoK+y98XgexXEvKW+5+/Kvm
	 VfURguUxu7BK77gl2hJPm0+Bmt/H5xG5WVXK8+cAhIHv/SSGXTfEg1E22lZks5uLjaLMY
	 J+Bzz5/SKO+6BsvNnvrHOTg4eNePjm8LsX0yzU9HW/U7K6QFc0vcl6HWg/J5/UvFg+4E6
	 hhqABSXx2Jx9r7FtFkIQl7JkNW80owZhP7UsXOtXVrWfzBqOmkLuDbBanGelIhDfzQA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790347966;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eqwba8uIyIBHU0D+mbWaPP6/65+16kFFe7c0vWebTx4=;
	b=AR8swWoGcaX9gfOOHZGsqb8ut1xvO8VK527q0uRPcadbGaI+GTMxzWoJbWdbuRlaaDHP
	 uQLefbaUaDYjU002Qc0EVu8AJ9IpCSwFvj5+etYneGoVII3q5QzxzIh76iw5lruGahqZJ
	 kIYA1TFGmDWu7hqTd2ztPlma2h8XCdl7BFeDrZSYjVTQ9wOrt9cs58EpC+7/4Usezftnh
	 U/ccSjOJRRfOvjiypbfwPXSiRXUCx1EvInAH6bqR8sq9AxZ7I9h/NQ52jFx032+JawYA0
	 NsOi0DQK5qvwXqRapVbkpFm1l3nCub5OKWdGf/m0TVt9JgYc2AS7V3w+WtmbC2Q/KJQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790347966;
	bh=eqwba8uIyIBHU0D+mbWaPP6/65+16kFFe7c0vWebTx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z0wsCZBAzc7TJP8rG+4jKHdbnGbEBUsuJOlV4gGDUuUuQgK/BL9IFmMHjPputdFKz
	 VceCr17UxEGZdBS9AaP9sUPcukZj6XTiz+80YD8j+4rQqc/8k3xMMjkgO0u5UpYWLZ
	 F3IJS6fJvhxtpCG7Fva1Lazb+rBZEIxBN+9HSAlO+rGsQMJHkve6nlK4nDZQCdfFIk
	 Rm+Ql0P1m5lhRSClj2L6UkOeWRgGDjQPTIWR8r0ZyKIhIVMMKcmk6NSn64CXq67n8j
	 J+E3DPwKZMw+ZYygoyqgxLP+c9JUjBepcncwgCzP2L2SeXr5x/6+tY9319UbUuV8hB
	 cX/gt4fFL76Pw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6751360D95;
	Fri, 25 Sep 2026 14:52:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 17212332
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 14:52:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0908A4016B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 14:52:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PmiawP7RW8cN for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 14:52:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org F2874400FB
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790347964;
 b=PCzO8B9sFFpUS8kHkh0hYMmxfp0M7nnwQ7aSx4zmbWG5Na0zE+AvN5YAmF8q3cFdOSxx
 eGDQv0V7VHJOE4XyIaz53qpZ3QVY1HwIg9j7zwtxyTTsDSHUn2WiM/+6IatHaAnKMaLjS
 2ZaHFl/77++zULdpsLbF6HSS5zoGYyAexhc1ktBpcXqFeg3eh14V1RGe9Azl/xLZvjl9e
 pGPptS6IMMynFDjvYqQiDLRzmvYpMRnSMuwv5Wjize0dUGVLzmUzq/Lmw3JLskQ4sexZY
 se+c/sq3CLgfV8SId6xuMULhokJPjvBUxPmhXKBgQ13MCNW+WIWdc8CEY8EPbs5nLLw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790347964;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=eqwba8uIyIBHU0D+mbWaPP6/65+16kFFe7c0vWebTx4=;
 b=FLBnWyaiSd0wWPjMYXig/XVlirpkxT0yUgzPt7Mb8zRTtUvhKYk2jhzSkktXbSC61pVv
 sSLR4AdS15/lEvytpDFE4toQYoNln1yUU763rki34DfNDBGtburxM9ECpB9twwzMwu9Aw
 L0EZIOemUpqesA9k/FKPSd2oEasDqzANv/bxPh71ObxKrdSngZnWq8sJJvEMT06GynNPr
 kp0kDQM1DFuXuxKHJ+5krGBrUQ7z+t0Jn0yeUuMHE5W+3tsm/LsVLVgRqhgjpT1Qhbws/
 WZ1CZSbdrMViEOx6et52Zy5mR9VjhI6LwebkOU+hYBHII2M09Yir2kt3cgolzIAKSbg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=WKKK8XKP; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=WKKK8XKP
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F2874400FB
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 14:52:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9DEDF60136;
 Fri, 25 Sep 2026 14:52:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE9D21F000FF;
 Fri, 25 Sep 2026 14:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790347961;
 bh=eqwba8uIyIBHU0D+mbWaPP6/65+16kFFe7c0vWebTx4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=WKKK8XKP/if2xktccrO3rxMkmW6KauTsNF/lj7apJemrvIkZh0tl++Rd6QTb/r0kB
 7aiSZdBVt4ia9O5hAGENSxqkZ6y2rmcbfkuKUCjPZzgPw2pwDyiOl+fIe5iyPYZ8H/
 Ax8/uJesAMhZVGETEX/Idvmy/JXR20JcAIQ/6lnzcMqNkB+Zj5dIMi78/ThMizoyQa
 RuS8y4xzId+2brqX6xy9hkRWnXdYwcBc8RPHksQMo6YqBf6F/wgkB6axS4oSzJmBOG
 SJ+tevz7BD4d/3Z1HyECvqS51nX6U5rChQ3MB+b0dlPtJiXM64w+BkSrns4wj5gvKM
 RgVt6SXFkZNVg==
Date: Fri, 25 Sep 2026 15:52:36 +0100
From: Simon Horman <horms@kernel.org>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: anthony.l.nguyen@intel.com, alessio.bogani@elettra.eu,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, jianhao.xu@seu.edu.cn
Subject: Re: [PATCH net v2] igb: initialize PTP state before registering PHC
Message-ID: <20260925145236.GO13925@horms.kernel.org>
References: <cd12af33-ed01-4eca-88e3-703b59c05453@intel.com>
 <20260917150247.2562991-1-runyu.xiao@seu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917150247.2562991-1-runyu.xiao@seu.edu.cn>
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
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
Errors-To: intel-wired-lan-bounces@osuosl.org

On Thu, Sep 17, 2026 at 11:02:47PM +0800, Runyu Xiao wrote:
> igb_ptp_init() currently initializes the PTP lock, work items,
> timestamp configuration, and timecounter after ptp_clock_register().
> The PHC is published by that call, so PTP callbacks and timestamp
> interrupts can run before those objects are ready.
> 
> Initialize the complete PTP state before registering the PHC. Skip the
> setup when CONFIG_PTP_1588_CLOCK is disabled, since the PTP registration
> helper is then a no-op. If PHC registration fails, cancel the work items
> queued by igb_ptp_reset() or a timestamp interrupt before returning.
> 
> Fixes: b888c510f7b3 ("igb: Avoid starting unnecessary workqueues")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/netdev/20260830154912.2712900-1-runyu.xiao@seu.edu.cn/
> Assisted-by: LLM
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> 
> ---
> v2:
> - Restore all PTP state initialization before PHC registration.
> - Skip PTP setup when CONFIG_PTP_1588_CLOCK is disabled.
> - Cancel both PTP work items when PHC registration fails.

Reviewed-by: Simon Horman <horms@kernel.org>

For future reference: please post new patch revisions as new
email threads, rather than as a response to an earlier revision.

Link: https://docs.kernel.org/process/maintainer-netdev.html#resending-after-review

Thanks!
