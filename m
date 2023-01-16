Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD98CC54EBE
	for <intel-wired-lan@archiver.kernel.org>; Mon, 16 Jan 2023 07:41:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7D76640132;
	Mon, 16 Jan 2023 07:41:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7D76640132
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1673854911;
	bh=JZQ9oSEfVTq99gF2mwlXO+njH7BwuNtJNo62o0kbcmw=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=DCmh/YuWMOzZoxRAi6FNyJXRBHy39xw16Vc7/jz8sv41NzyuH6p9IbWndwIhtWjBM
	 nnRJ55rUKm+2yELAdyWo//tbRuC2wXpyg7cx6eB0QR6c5UU0Ei/oIiau8JaoHkLrh8
	 ypNOA3A+p1wgns8Jtnsv5wm21UVdGQ4+fY//EIKgR20Y9qhSaNF+/iZ11gRSr1nieX
	 PfAOKoLB1u1nKXNBN3++RuqIbb4w8cEXNaGNaUClYuXTDy92ukxpJcmEn0Vl8wIlaT
	 EpCjIKS/SH/EDrEgC0x0tYm8Qxvo1UC4DjR9ah0m+VFRmWPZEcaP0Ky9QgWKPgREKT
	 lCLX/t7JD9sbw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V46FffCrFSb3; Mon, 16 Jan 2023 07:41:50 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 59D0040407;
	Mon, 16 Jan 2023 07:41:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 59D0040407
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 536061BF30A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Jan 2023 07:41:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 291F7814A0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Jan 2023 07:41:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 291F7814A0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DoRyi4k3PHuU for <intel-wired-lan@lists.osuosl.org>;
 Mon, 16 Jan 2023 07:41:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F3F828149E
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F3F828149E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Jan 2023 07:41:47 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="386752372"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; d="scan'208";a="386752372"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2023 23:41:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="689393690"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; d="scan'208";a="689393690"
Received: from unknown (HELO localhost.localdomain) ([10.237.112.144])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2023 23:41:46 -0800
Date: Mon, 16 Jan 2023 08:41:37 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Message-ID: <Y8T/sfPQ7onjuQ0Z@localhost.localdomain>
References: <20230111191906.131-1-paul.m.stillwell.jr@intel.com>
 <20230111191906.131-5-paul.m.stillwell.jr@intel.com>
 <Y7/lpDzq6q+SWRxK@localhost.localdomain>
 <7188138f-3f07-97f3-33df-9c64a76e7895@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7188138f-3f07-97f3-33df-9c64a76e7895@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1673854907; x=1705390907;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=1Ug+Cc1NIeDZtijJ/w9Y44SPHhrmhPNNQ3OrCuwdrv4=;
 b=ntWjQJXPCybYlQMLNRvmkhKj9lX6TXoiT3OFvz5zFHkgIeULSLjOQMSV
 vmINPtxAxRn06R4iE+LDcovbUdTG+6mBkdfTrmfZ8qDXwzZCwz3XlckZn
 28cEu0owdCMOFchx9eJO+2Q+UmgThke3Oq9P/FLAQF0a6tTGr/YW+R3lx
 OB+mxrN7EOS9twJCqAUT1lHp6CxCtlidX4ytr3dxXFYbhTyltEQFJGBv7
 M7uHkAOoQdtIDZfsU1c8LRHxWNu+lVGwW7SRLF/YW9mJIE/PdI3pVTZCd
 pIDX8K+ohhrTSVvwlaqHnzJ067U+/BLA5vIBtzYsSuk75Ue1w11iwcUwr
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ntWjQJXP
Subject: Re: [Intel-wired-lan] [PATCH net-next v5 4/5] ice: disable FW
 logging on driver unload
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
Cc: intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, Jan 13, 2023 at 02:13:04PM -0800, Paul M Stillwell Jr wrote:
> On 1/12/2023 2:49 AM, Michal Swiatkowski wrote:
> > On Wed, Jan 11, 2023 at 11:19:05AM -0800, Paul M Stillwell Jr wrote:
> > > The FW is running in it's own context irregardless of what the driver
> > > is doing. In this case, if the driver previously registered for FW
> > > log events and then the driver unloads without informing the FW to
> > > unregister for FW log events then the FW still has a timer running to
> > > output FW logs.
> > > 
> > > The next time the driver loads and tries to register for FW log events
> > > then the FW returns an error, but still enables the continued
> > > outputting of FW logs. This causes an IO error to devlink which isn't
> > > intuitive since the logs are still being output.
> > > 
> > > Fix this by disabling FW logging when the driver is being unloaded.
> > > 
> > > Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> > > ---
> > >   drivers/net/ethernet/intel/ice/ice_main.c | 29 +++++++++++++++++++++++
> > >   1 file changed, 29 insertions(+)
> > > 
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> > > index 1b5debc3109d..593efc064f5b 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > > @@ -4500,6 +4500,33 @@ static void ice_unregister_netdev(struct ice_vsi *vsi)
> > >   	clear_bit(ICE_VSI_NETDEV_REGISTERED, vsi->state);
> > >   }
> > > +/**
> > > + * ice_pf_fwlog_deinit - clear FW logging metadata on device exit
> > > + * @pf: pointer to the PF struct
> > > + */
> > > +static void ice_pf_fwlog_deinit(struct ice_pf *pf)
> > > +{
> > > +	struct ice_hw *hw = &pf->hw;
> > > +
> > > +	/* make sure FW logging is disabled to not put the FW in a weird state
> > > +	 * for the next driver load
> > > +	 */
> > > +	if (hw->fwlog_ena) {
> > > +		int status;
> > > +
> > > +		hw->fwlog_cfg.options &= ~ICE_FWLOG_OPTION_ARQ_ENA;
> > > +		status = ice_fwlog_set(hw, &hw->fwlog_cfg);
> > > +		if (status)
> > > +			dev_warn(ice_pf_to_dev(pf), "Unable to turn off FW logging, status: %d\n",
> > > +				 status);
> > > +
> > > +		status = ice_fwlog_unregister(hw);
> > > +		if (status)
> > > +			dev_warn(ice_pf_to_dev(pf), "Unable to unregister FW logging, status: %d\n",
> > > +				 status);
> > Shouldn't hw->fwlog_cfg be free on deinit? Or if not here, where does
> > this happen?
> > 
> 
> No need to free hw->fwlog_cfg since it's not a pointer with memory
> allocated, it's a member of ice_hw. See ice_type.h, 863
> 

Sure, didn't notice that, thanks

> > > +	}
> > > +}
> > > +
> > >   /**
> > >    * ice_cfg_netdev - Allocate, configure and register a netdev
> > >    * @vsi: the VSI associated with the new netdev
> > > @@ -5237,6 +5264,8 @@ static void ice_remove(struct pci_dev *pdev)
> > >   		msleep(100);
> > >   	}
> > > +	ice_pf_fwlog_deinit(pf);
> > > +
> > >   	if (test_bit(ICE_FLAG_SRIOV_ENA, pf->flags)) {
> > >   		set_bit(ICE_VF_RESETS_DISABLED, pf->state);
> > >   		ice_free_vfs(pf);
> > > -- 
> > > 2.35.1
> > > 
> > > _______________________________________________
> > > Intel-wired-lan mailing list
> > > Intel-wired-lan@osuosl.org
> > > https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> 
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
