Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8578FC021AA
	for <intel-wired-lan@archiver.kernel.org>; Fri, 21 Feb 2025 07:33:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D78083FE4;
	Fri, 21 Feb 2025 07:33:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vNy9q48yRFqb; Fri, 21 Feb 2025 07:33:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9A3E083F8C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1740123210;
	bh=i8a6ZTYDY2exDufOKEVCcryFrYN3caB14yIOL1YbOzU=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BHHwr1WL7WGQ5kyhHsK2Vwr7tvV5+WmFCKP9WaAHOlCxXFo98ofSP1oChlMMjliWz
	 Lq4cUXG1W17uSAW4uhfeDgqkJ1prpGR31x+yAQ8Ff38/u9lCMZNvDz+bpEzhRVaZj9
	 CVS37T4wpkLaQjHL5onSObolxVUhvoT4MsFC26iKgWBCywlvfb9fB9gmZaz7tZHqSk
	 YJbaSsLt9FjZwIb5IXtgNLidmMxbKEFc5rIG8Cti6tzYCpAnehdu9+rUY5SpsF8XOg
	 es4zvZgxu9/RFekYgRA7jAn8Hg5TH9U7FPHXVey8a8MiBhzRJWfEbhiwokHaFfAZrM
	 HdrDF+8Q3eVgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A3E083F8C;
	Fri, 21 Feb 2025 07:33:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E5060194
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Feb 2025 07:33:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C936840DDD
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Feb 2025 07:33:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NMWDnwzxRTXp for <intel-wired-lan@lists.osuosl.org>;
 Fri, 21 Feb 2025 07:33:29 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=michal.swiatkowski@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D4D10408D4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D4D10408D4
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D4D10408D4
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Feb 2025 07:33:28 +0000 (UTC)
X-CSE-ConnectionGUID: r5YxbcSkQuSNL20Wy8ITIg==
X-CSE-MsgGUID: vpvtOv9ESpKjRlak280uuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40852335"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; d="scan'208";a="40852335"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 23:33:28 -0800
X-CSE-ConnectionGUID: yGKCJylvT5KUfXSbr4aR9A==
X-CSE-MsgGUID: T13jXwgkSCeJXm2BARMUGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; d="scan'208";a="115294573"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 23:33:26 -0800
Date: Fri, 21 Feb 2025 08:29:50 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Paul Greenwalt <paul.greenwalt@intel.com>
Message-ID: <Z7grbgy/g4cJTqYb@mev-dev.igk.intel.com>
References: <20250218-jk-e830-ddp-loading-fix-v1-1-47dc8e8d4ab5@intel.com>
 <Z7WmcXf8J5j/ksNX@mev-dev.igk.intel.com>
 <55fcbc58-fccb-4db5-afa2-21b53a89fdc3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55fcbc58-fccb-4db5-afa2-21b53a89fdc3@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740123209; x=1771659209;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=5FP/eBS7lGDumhr02aFKydBB7pfzPWOJwwdAwCYLHHQ=;
 b=QBSprflouZy8QnfkVLcfupGvv5LO3gXCslB/UZ5p8nkgRWeaLBc80zg1
 iwdHtlPJPTLQWAsU737U9XIYsxb73W+yYf+C50bOAP78McrM3yFm7wzQP
 I+Q/96qhRTlUguBl+3yUcQ55uskJmoSPcOyylGF9Iu9YCXKRJyWC6vSYW
 eR/iSBIC7XxZgCvuS3SZpTDtIQxVv19/ggR2boHLXibPosd0NEu4Xba+f
 Xncha8d2/YFoX1obbSQoa/Op8hgGTHgI5WQ7J9kM7Oi0x2SDhsuNpXcYu
 h2umXyxiNtwRJ5AvuZSj2R5zlabmTt2y590GJqWbG6Gd5JPyB1ROnmckn
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=QBSprflo
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: fix Get Tx Topology AQ
 command error on E830
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

On Thu, Feb 20, 2025 at 02:45:41PM -0800, Jacob Keller wrote:
> 
> 
> On 2/19/2025 1:37 AM, Michal Swiatkowski wrote:
> > On Tue, Feb 18, 2025 at 04:46:34PM -0800, Jacob Keller wrote:
> >> From: Paul Greenwalt <paul.greenwalt@intel.com>
> >>
> >> With E830 Get Tx Topology AQ command (opcode 0x0418) returns an error when
> >> setting the AQ command read flag, and since the get command is a direct
> >> command there is no need to set the read flag.
> >>
> >> Fix this by only setting read flag on set command.
> > 
> > Why it isn't true for other hw? I mean, why not:
> > if (set)
> > 	RD_FLAG
> > else 
> > 	NOT_RD_FLAG
> > Other hw needs RD flag in case of get too?
> > 
> 
> From what I understand, we didn't anticipate this flow changing. E810
> and E822 hardware require FLAG_RD for both get and set, while E825-C and
> E830 expect FLAG_RD only for set, but not for get.
> 

Thanks for explanation. Seems resonable from driver perspective and not
so reasonable from firmware, but maybe this difference is somehow
important.

Thanks,
Michal

> >>
> > 
> > Don't you need fixes tag?
> 
> You're correct. I'll add it in v2
> 
> >> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> >> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> >> ---
> >>  drivers/net/ethernet/intel/ice/ice_ddp.c | 10 +++++-----
> >>  1 file changed, 5 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
> >> index 03988be03729b76e96188864896527060c8c4d5b..49bd49ab3ccf36c990144894e887341459377a2d 100644
> >> --- a/drivers/net/ethernet/intel/ice/ice_ddp.c
> >> +++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
> >> @@ -2345,15 +2345,15 @@ ice_get_set_tx_topo(struct ice_hw *hw, u8 *buf, u16 buf_size,
> >>  			cmd->set_flags |= ICE_AQC_TX_TOPO_FLAGS_SRC_RAM |
> >>  					  ICE_AQC_TX_TOPO_FLAGS_LOAD_NEW;
> >>  
> >> -		if (ice_is_e825c(hw))
> >> -			desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
> >> +		desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
> >>  	} else {
> >>  		ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_get_tx_topo);
> >>  		cmd->get_flags = ICE_AQC_TX_TOPO_GET_RAM;
> >> -	}
> >>  
> >> -	if (!ice_is_e825c(hw))
> >> -		desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
> >> +		if (hw->mac_type != ICE_MAC_GENERIC_3K_E825 &&
> >> +		    hw->mac_type != ICE_MAC_E830)
> >> +			desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
> >> +	}
> >>  
> >>  	status = ice_aq_send_cmd(hw, &desc, buf, buf_size, cd);
> >>  	if (status)
> >>
> > 
> > In general looks fine, only one question.
> > 
> > Thanks,
> > Michal
> 
> Thanks for the review, I'll send a v2 with this cleaned up and include a
> fixes tag.
> 
> > 
> >> ---
> >> base-commit: f5da7c45188eea71394bf445655cae2df88a7788
> >> change-id: 20250218-jk-e830-ddp-loading-fix-9efdbdfc270a
> >>
> >> Best regards,
> >> -- 
> >> Jacob Keller <jacob.e.keller@intel.com>
> 
