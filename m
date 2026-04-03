Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC68E85363
	for <intel-wired-lan@archiver.kernel.org>; Fri,  3 Apr 2026 12:49:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A4348064A;
	Fri,  3 Apr 2026 12:49:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hXO44-d8y0tS; Fri,  3 Apr 2026 12:49:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C776F80668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775220587;
	bh=Z9meWCjtoHSbt5Tjz7OVs65mN2AiMtVBXwfA93eR8fs=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fnLNlX9alue9A7vov49Rx9NW/gMijpItIPerk923Vh4wWiCgdqjzPeGtRBBNd48dI
	 m4J9ZudM4FmyUt7qjGD7rZh8ckP00rS1jNY1NrqeBRjtAZYrdOmtyMMKg/mqFlfLhU
	 OMt2eZcUX+r4kAiocLrWBK+jcmMVAOaDaKsE/mYeAV0yY5qeKvfThwD0vhRa4rSdoL
	 sa3R9hXj/y9hsorSDdFvzthJQIn6rmxa1EwjaUas+XnLl1U2xQadgFybhpUbtJfuix
	 6CfUj2PwnxKtvIU0vmeYnOPrOB1+oqjSUsFmaoxgj5Jv/G8K5Gn8Z6uPGcp6tS4Qao
	 m1wxiAjyEK28g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C776F80668;
	Fri,  3 Apr 2026 12:49:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B98E62CC
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 12:49:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9F1966087A
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 12:49:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6iLRvgmiImpL for <intel-wired-lan@lists.osuosl.org>;
 Fri,  3 Apr 2026 12:49:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 10073607A0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 10073607A0
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 10073607A0
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 12:49:45 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id AC86242A7E;
 Fri,  3 Apr 2026 12:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916F8C4CEF7;
 Fri,  3 Apr 2026 12:49:44 +0000 (UTC)
Date: Fri, 3 Apr 2026 13:49:42 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org
Message-ID: <20260403124942.GA103228@horms.kernel.org>
References: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1775220585;
 bh=oe1k06X8LzeLYzPSqTUn6zZwnoXsWv9v1PI95wY03zA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aOStDcoy773/nHKR3XdJisKUw/d/nD0GWcc79stsMFn2tJPJtCZRU17MdueYx1ayw
 F8bDzk9WbIS/Orv7/UcqFHwOFP9wZrKwCqAw4oIfWLy9sPF/YTODumbtdROmZzYX4o
 AtBPpX7yKh3IBwkCgbFumNBv6Z6ZVtPvRvAAsqGEla9w6Qt9CmsvLrpYrW7K/i0X5g
 XcmvSDgdRHmm4yK71zm3Gbo5WaaHJeObSwBW3abHpyS4VyMMO6EhBmPCsUNEyk96lo
 mBufMPs+HJglxHSlq1+nacLKedbPONkqztxZMgxEUW31xvqeFgUpyHGvLdB2JKM8Mz
 4Kphl5Oe/xS2w==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=aOStDcoy
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ixgbe: increase SWFW
 semaphore timeout for X550 FW updates
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, Mar 27, 2026 at 08:30:35AM +0100, Aleksandr Loktionov wrote:
> From: Soumen Karmakar <soumen.karmakar@intel.com>
> 
> According to FW documentation, the most time-consuming part of continuous
> FW activity is Shadow RAM (SR) dump which takes up to 3.2 seconds.  For
> X550 devices, the module-update FW command can take over 4.5 s.  Increase
> the max Software/Firmware (SW/FW) semaphore wait time from the default
> 200 ms to 5 s for X550 to avoid spurious semaphore timeout failures

Should 200ms be 1s (200 x 5us) ?

> during FW update operations.
> 
> Signed-off-by: Soumen Karmakar <soumen.karmakar@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
> index e67e2fe..85047ef 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
> @@ -577,6 +577,9 @@ int ixgbe_acquire_swfw_sync_X540(struct ixgbe_hw *hw, u32 mask)
>  
>  	swmask |= swi2c_mask;
>  	fwmask |= swi2c_mask << 2;
> +	if (hw->mac.type == ixgbe_mac_X550)
> +		timeout = 1000;

I think it would be nice to centralise the initialisation of timeout,
to either it's default or device-specific value, here.

And to provide a comment indicating what the values mean in terms
of maximum delay in s or ms.

> +
>  	for (i = 0; i < timeout; i++) {
>  		/* SW NVM semaphore bit is used for access to all
>  		 * SW_FW_SYNC bits (not just NVM)
> -- 
> 2.52.0
> 
