Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2096C4332F
	for <intel-wired-lan@archiver.kernel.org>; Sat,  4 Nov 2023 15:24:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 57E6240144;
	Sat,  4 Nov 2023 15:24:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 57E6240144
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1699111477;
	bh=wJhHqcIEc6rcKT0BqXHIQC+1gx2CnODXf2eew4bCzrw=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=1/6+5ST+nzhrS1Zc3j3kqzzmUs2KYb987XxcZSFbNLrY+l5OSviagq+Yc4PMgwn/h
	 S530+InjziXw6ADveA868+XKNPb5c1M3ZX4WY4NQC+xAUNv2nj4v0HV/589WH87Icr
	 bJR16YPSRVwKw+FBHhwC21uIREIQbeRX8faaP4ZE3N9kIU6j4J+7yvF+znZehvGw2x
	 JOikxiFN4n9+yNYj60ie6EvFhfnLmBiBYCCR1aXLgtoWhlvMNz+wl7Q3G4fJiidb7B
	 droJLikO57fiphVvqIvilup3R86fvAIb0yOQQ/ORJXxyuzMe8iZgXVcKjIBM6kgB73
	 //csD0bYrfomg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3gMgkpu5nfv9; Sat,  4 Nov 2023 15:24:36 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id AFF13409C8;
	Sat,  4 Nov 2023 15:24:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AFF13409C8
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 548151BF584
 for <intel-wired-lan@lists.osuosl.org>; Sat,  4 Nov 2023 15:24:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3A13060EA7
 for <intel-wired-lan@lists.osuosl.org>; Sat,  4 Nov 2023 15:24:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3A13060EA7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FI2lFta_CYU6 for <intel-wired-lan@lists.osuosl.org>;
 Sat,  4 Nov 2023 15:24:33 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7A7BC60B03
 for <intel-wired-lan@lists.osuosl.org>; Sat,  4 Nov 2023 15:24:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7A7BC60B03
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 6AA23CE0229;
 Sat,  4 Nov 2023 15:24:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E07C433C8;
 Sat,  4 Nov 2023 15:24:22 +0000 (UTC)
Date: Sat, 4 Nov 2023 11:24:15 -0400
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Message-ID: <20231104152415.GH891380@kernel.org>
References: <20231103234658.511859-1-jacob.e.keller@intel.com>
 <20231103234658.511859-3-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231103234658.511859-3-jacob.e.keller@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1699111468;
 bh=WhRpo2xxmwK6pr+DM4yXtfrXne2vymGmCiN2nZ3RV4E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UyuiPhyb1ogmVyBIYcMojgnzUw58fOF6eqDDrbR89yhuuv7TtKR4SoRTEZ5UAe+HR
 Kw3JL46hOZJLahs6RZsGf3jr/xIRhOi+CRjytFBc5pAbiyEawFmUTRWu7HwNFvmLx0
 m0CnufiE94fMcTcLHlEbFnDMaMTgDgGkLKgA7EmSkbxhOFCKuXhC0VEBsknoyI3pzO
 K2Y/Q6qhwutQ3qH0lA6CcXiv5mU7cgcGqtPqIzAfErMfgLC/hjPH0RqUs2UVmRsCnO
 +dxH54CKE/1kNKNuW0bKyOth00//RS6Yb1RVvd3beV5uOjdOemZ1WA7p7Sdx5l+Xfk
 VRZaunFLRzWvw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=UyuiPhyb
Subject: Re: [Intel-wired-lan] [PATCH iwl-net 2/3] ice: unify logic for
 programming PFINT_TSYN_MSK
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
Cc: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
 Anthony Nguyen <anthony.l.nguyen@intel.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, Nov 03, 2023 at 04:46:57PM -0700, Jacob Keller wrote:
> Commit d938a8cca88a ("ice: Auxbus devices & driver for E822 TS") modified
> how Tx timestamps are handled for E822 devices. On these devices, only the
> clock owner handles reading the Tx timestamp data from firmware. To do
> this, the PFINT_TSYN_MSK register is modified from the default value to one
> which enables reacting to a Tx timestamp on all PHY ports.
> 
> The driver currently programs PFINT_TSYN_MSK in different places depending
> on whether the port is the clock owner or not. For the clock owner, the
> PFINT_TSYN_MSK value is programmed during ice_ptp_init_owner just before
> calling ice_ptp_tx_ena_intr to program the PHY ports.
> 
> For the non-clock owner ports, the PFINT_TSYN_MSK is programmed during
> ice_ptp_init_port.
> 
> If a large enough device reset occurs, the PFINT_TSYN_MSK register will be
> reset to the default value in which only the PHY associated directly with
> the PF will cause the Tx timestamp interrupt to trigger.
> 
> The driver lacks logic to reprogram the PFINT_TSYN_MSK register after a
> device reset. For the E822 device, this results in the PF no longer
> responding to interrupts for other ports. This results in failure to
> deliver Tx timestamps to user space applications.
> 
> Rename ice_ptp_configure_tx_tstamp to ice_ptp_cfg_tx_interrupt, and unify
> the logic for programming PFINT_TSYN_MSK and PFINT_OICR_ENA into one place.
> This function will program both registers according to the combination of
> user configuration and device requirements.
> 
> This ensures that PFINT_TSYN_MSK is always restored when we configure the
> Tx timestamp interrupt.
> 
> Fixes: d938a8cca88a ("ice: Auxbus devices & driver for E822 TS")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
