Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1D4C001DB
	for <intel-wired-lan@archiver.kernel.org>; Sun, 13 Aug 2023 09:03:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C0968196A;
	Sun, 13 Aug 2023 09:03:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8C0968196A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1691917403;
	bh=zofZzvd1tGeVk6fqkCMc04RneI3yWmM41ylGm9quL2U=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=iODGmmJqiwGff6K2sKU/j/NUzVfVUFGlKd606zqe/tZBxuPnxCR85V2mTlJf6BJOz
	 oRgDkJNbjDbHbIARCf3Kf719BJ8i9QYPCRWzT7/dT605FaflGHz0/+zwExvbYbnaPl
	 iSlx6K+u9SddG9k50tK1VFrxpVC9CighTXRKFTZ13yfTlhS6cPcDIhg30gzgHZC0+n
	 C3D5Hh+VBmWRfQLx//Tl+5/XOez7ucc32I2ReCFxBzzI173DeweVSiQH7bxsnLWXzB
	 wnHkpL5fHzUwzjUOTKVaSVfL8N/+d+yFP+Tsu4jHtU59Xl7TW67+WADucUSL4tUIcF
	 tssJJjODp5nWQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hHaJKrXhm2Dk; Sun, 13 Aug 2023 09:03:22 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 918138198A;
	Sun, 13 Aug 2023 09:03:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 918138198A
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id A0F601BF429
 for <intel-wired-lan@lists.osuosl.org>; Sun, 13 Aug 2023 09:03:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 75D228198A
 for <intel-wired-lan@lists.osuosl.org>; Sun, 13 Aug 2023 09:03:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 75D228198A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wyCuuk0TnYSn for <intel-wired-lan@lists.osuosl.org>;
 Sun, 13 Aug 2023 09:03:19 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 297D78196A
 for <intel-wired-lan@lists.osuosl.org>; Sun, 13 Aug 2023 09:03:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 297D78196A
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id EA7AC62253;
 Sun, 13 Aug 2023 09:03:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C92D6C433C7;
 Sun, 13 Aug 2023 09:03:16 +0000 (UTC)
Date: Sun, 13 Aug 2023 12:03:13 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Message-ID: <20230813090313.GG7707@unreal>
References: <20230810235110.440553-1-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230810235110.440553-1-jesse.brandeburg@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1691917397;
 bh=wL7aCqb94Cdrt5jofRLuQExYraS5Rk/IOXsF4HRviZI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pAGMMuT7SjxOMH85jrVhbeUR+xXUM/R/qQA6Zi57fPbtWS7C1b2FMoguz6De30SiQ
 Jg0KVE7WCGMNEby20RXO/rPV5QjJYduJNdLJI/yULQnb4LCsO7gkrX0VJ1n4AspfMJ
 zNfNWdJJZADle2YKz7moYHMBR1Kp0g+2fjKM/dGjfUkY61c80YpXEwRQFYmzOz3NgK
 9cMhEeUkjpSq1pdjflHosJIcEvc0geXP+npWIwh6b5AXmiVL95P/s7/to0ztYkexVU
 Y7bdW1x8qNq6zrnYJvc0oBN/Mw3CyVbvj8X40PN/+zJCA8Qqb6FJ69xMyaPNgwuYKz
 cItg/tcuicceA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=pAGMMuT7
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] ice: fix receive buffer
 size miscalculation
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
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Aug 10, 2023 at 04:51:10PM -0700, Jesse Brandeburg wrote:
> The driver is misconfiguring the hardware for some values of MTU such that
> it could use multiple descriptors to receive a packet when it could have
> simply used one.
> 
> Change the driver to use a round-up instead of the result of a shift, as
> the shift can truncate the lower bits of the size, and result in the
> problem noted above. It also aligns this driver with similar code in i40e.
> 
> The insidiousness of this problem is that everything works with the wrong
> size, it's just not working as well as it could, as some MTU sizes end up
> using two or more descriptors, and there is no way to tell that is
> happening without looking at ice_trace or a bus analyzer.
> 
> Fixes: efc2214b6047 ("ice: Add support for XDP")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
> v2: added fixes tag pointing to the last time this line was modified in
> v5.5 instead of pointing back to the introduction of the driver.
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
