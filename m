Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A4DC43458
	for <intel-wired-lan@archiver.kernel.org>; Fri,  3 Jul 2026 16:36:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1E419809EB;
	Fri,  3 Jul 2026 16:36:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 96_AJl52W793; Fri,  3 Jul 2026 16:36:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B1F27809AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1783096601;
	bh=f3Pb5eWWaHTeyM0ij7fa3+fHMciuC9XlLtHIPmY2FL8=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CyQw7owiASbYoKdY2YvYuDn+QX4o1fIjbMM2i4gHhptiDs3IJOkGOGy+aUx9p2p+w
	 yYkhBNalz1FH6w5JxNrawYPrjo+hoD55dOIY1WedG0/jhOwxLdEVw7opH4BK1i2Am/
	 mg40wf8LDjpFZ8ObijzDS61NaMsHyjLQFlMHG+SDLR0Ip1hfE0+escyeaHGSEfy7wO
	 JXsy+ZkPAOA56ENN4Aq7VHgeeDm+RK66EB/AMrln/45UtkTviWhmi3TEiw7hhX1QY2
	 CYNLaBGZ9LWQfaZmjFgU4a/X1vL/dhioDYPJDg4QNNBpjzit64v16sEF1+JJPnoG/9
	 xgkMUyMDG6SPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B1F27809AD;
	Fri,  3 Jul 2026 16:36:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E03A316
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Jul 2026 16:36:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E2F4360836
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Jul 2026 16:36:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qLT1Js_nMZPT for <intel-wired-lan@lists.osuosl.org>;
 Fri,  3 Jul 2026 16:36:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=marcin.szycik@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E0B84606DA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E0B84606DA
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E0B84606DA
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Jul 2026 16:36:38 +0000 (UTC)
X-CSE-ConnectionGUID: GFC8eaKAS2G77/Fqpuzfbg==
X-CSE-MsgGUID: 1uMK4vtqR2G24ueoNHMnYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11836"; a="82837560"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="82837560"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 09:36:38 -0700
X-CSE-ConnectionGUID: kTgdviOcSVG9Z0ZrkPudPg==
X-CSE-MsgGUID: +/9m0MYCTgq+9jyOZTWnQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="253283438"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.245.114.103])
 ([10.245.114.103])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 09:36:34 -0700
Message-ID: <a0017c22-8885-4e2b-92d2-b5d876da725c@linux.intel.com>
Date: Fri, 3 Jul 2026 18:36:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>, Alice Michael
 <alice.michael@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
 Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Simon Horman <horms@kernel.org>,
 intel-wired-lan@lists.osuosl.org, Jacob Keller <jacob.e.keller@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
References: <20260701133601.2118382-1-poros@redhat.com>
 <20260701133601.2118382-3-poros@redhat.com>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20260701133601.2118382-3-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783096599; x=1814632599;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=29xT4vkcKmHxrTf6qx3zrNdyKkjGrMapqEpiRhALOy0=;
 b=mcn6H4pSD43JCg4Uu0MY7xnSMDN9UuDyuPTrO1GNsl4nDAfReuIQ8ghY
 gWK4DClv/CEX27uzvC9vBtQYUGq1OmfmRQRlTxYtopqOXD3fnSLYX3DpK
 mFozm7j1gTcHPy+7DmFEDzLjsnJP23d1vznN8N1ungtDB/xRFBzJPMG4p
 81RTXYb63ZKAt/NtJRgayqAKMWwc+sCGNndO88hftNyN57VLbf687a9k/
 putLh02+92KWk8izEkwuQzn8IWbcuezsRzcQ42HrYqzEPPWjSrIEmGUep
 t+8mszmz7O3wgusftKj5iDDAmAaAAnD7hHpI2n7ca+wwlKg1tSXXwxymJ
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=mcn6H4pS
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v3 2/2] ice: preserve uplink
 DFLT Rx rule on switchdev release
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



On 01.07.2026 15:36, Petr Oros wrote:
> When the uplink PF is promiscuous, ice_vsi_sync_fltr() installs an
> ICE_SW_LKUP_DFLT catch-all Rx rule on the uplink VSI. Entering switchdev
> re-affirms it through the idempotent ice_set_dflt_vsi(), but
> ice_eswitch_release_env() removed both the Rx and Tx DFLT rules
> unconditionally on teardown. That clobbered a promisc-owned Rx rule: it
> disappeared while IFF_PROMISC was still set and the sync path was not
> retriggered, leaving the uplink without the catch-all the netdev
> requested.
> 
> Skip the Rx DFLT removal when the uplink is promiscuous, both in
> ice_eswitch_release_env() and the err_def_tx unwind of
> ice_eswitch_setup_env(); the Tx leg, owned by switchdev, is still removed.
> Test the live netdev->flags, the same value ena_rx_filtering() ->
> ice_cfg_vlan_pruning() above already keys on, so the preserved rule and
> the pruning state stay consistent, including for a promisc change made
> while switchdev ran (which never reached the gated filter sync).
> 
> Fixes: 5c07be96d8b3 ("ice: Avoid setting default Rx VSI twice in switchdev setup")
> Signed-off-by: Petr Oros <poros@redhat.com>

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>

> ---
> v3:
> - Corrected the Fixes tag from 1a1c40df2e80 ("ice: set and release
>   switchdev environment") to 5c07be96d8b3 ("ice: Avoid setting default
>   Rx VSI twice in switchdev setup"), the commit that made
>   ice_eswitch_setup_env() use the idempotent ice_set_dflt_vsi(); before
>   it a pre-existing promisc DFLT rule made setup fail with -EEXIST so the
>   release path was never reached. No code change.
> 
> v2: https://lore.kernel.org/all/20260622113428.2565255-3-poros@redhat.com/
> v1: https://lore.kernel.org/all/deef5756e534ef06c12d910c5305d3fd205d30a0.1781786935.git.poros@redhat.com/
> ---
>  drivers/net/ethernet/intel/ice/ice_eswitch.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> index c30e27bbfe6e25..07e2016fb9481f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> @@ -66,8 +66,10 @@ static int ice_eswitch_setup_env(struct ice_pf *pf)
>  	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
>  			 ICE_FLTR_TX);
>  err_def_tx:
> -	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
> -			 ICE_FLTR_RX);
> +	/* keep the Rx DFLT rule if the uplink is promiscuous (see release_env) */
> +	if (!(uplink_vsi->netdev->flags & IFF_PROMISC))
> +		ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx,
> +				 false, ICE_FLTR_RX);
>  err_def_rx:
>  	ice_vsi_del_vlan_zero(uplink_vsi);
>  err_vlan_zero:
> @@ -276,8 +278,16 @@ static void ice_eswitch_release_env(struct ice_pf *pf)
>  	vlan_ops->ena_rx_filtering(uplink_vsi);
>  	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
>  			 ICE_FLTR_TX);
> -	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
> -			 ICE_FLTR_RX);
> +
> +	/* Keep the Rx DFLT rule if the uplink is promiscuous; it must outlive
> +	 * the session. Test the live netdev->flags, the same value
> +	 * ena_rx_filtering() -> ice_cfg_vlan_pruning() above keys its decision
> +	 * on, so the preserved DFLT rule and the pruning state stay consistent.
> +	 */
> +	if (!(uplink_vsi->netdev->flags & IFF_PROMISC))
> +		ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx,
> +				 false, ICE_FLTR_RX);
> +
>  	ice_fltr_add_mac_and_broadcast(uplink_vsi,
>  				       uplink_vsi->port_info->mac.perm_addr,
>  				       ICE_FWD_TO_VSI);

