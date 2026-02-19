Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD4CE9A03B
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Feb 2026 09:43:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D234040A4D;
	Thu, 19 Feb 2026 09:43:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XQ1_a9wKyh2m; Thu, 19 Feb 2026 09:43:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5382A40ABE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771494201;
	bh=GlGRy1+W8+5ftMEds/mkdnyfl8SO8txcxBv9zEOee3A=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oibTcw6WNnlDmFO+HT7cabQjh0+z3ujds0BYKPF4RhXsmvaSeUHenkv61Jf3ZVkhb
	 lGsQCXD0aIcyKaM0SyANECX718Df9vFiy5C3nDuffPwEViaLHsMysr1EZatayiX4Yy
	 Pdb3LWW3jHB8sRvV67guqydwVkksGg09TVwsgjswLkvqQLsfxo5TLnBhb3tus8/oK8
	 rSfmq3L1cGv8cJAwaplHYUtI9uViUBZiI4dBqI7yRJrGeEqBVjaEAr6w0KUAjfNiwa
	 x1h2ES/v6PAJfRoTW+fiH57kuCyu0jwlGAJELvmL+odjDOLcKXJiD878Icmgy/Eejl
	 ZBSu8n4BE4KkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5382A40ABE;
	Thu, 19 Feb 2026 09:43:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CEA1A1CE
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Feb 2026 09:43:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BFD28404AC
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Feb 2026 09:43:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wg8Ds6mo4XJ8 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Feb 2026 09:43:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5CAB54039D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5CAB54039D
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5CAB54039D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Feb 2026 09:43:18 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 898A941694;
 Thu, 19 Feb 2026 09:43:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00EFC19421;
 Thu, 19 Feb 2026 09:43:14 +0000 (UTC)
Date: Thu, 19 Feb 2026 09:43:12 +0000
From: Simon Horman <horms@kernel.org>
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, ivecera@redhat.com,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Message-ID: <aZbbMGERNIYn68W4@horms.kernel.org>
References: <20260218211414.1411163-1-poros@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218211414.1411163-1-poros@redhat.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1771494197;
 bh=GjEiwksgH3xDHUGckHAT4l/tbka0q/6pPMY1uo6BDDw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tybd3Tfz+ei3J7wOvTXa/H2SkqRCm3giBP/c1muGe0ThngxK+p8Hk+Qig7GHmYBw9
 hIppfPzdZ7ce6h0K2rl6647re61CIqXegHaIhUlZ8vwackWFZ558Nj1UJ5grPCQQSH
 4UGJBF+oqMiAufFFxDEsj31C4BqnG1u0xXHC8g7nDsGHfeU2qQDsmJNzp5XYfLwx/c
 9wx5SKydnekRiKxfnsH4OR7jCF/DP2qsBWfO6TXSoxHeuLjmvae+ub7U1PGeNEVTfP
 DPcJKqxVak6P4J/i/0ZQG9+Qo29/vck6nV4KcCN4EVjSgCI+YKQ1YQUyXBy4VsETWg
 YRb8IbLmmcyWg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=tybd3Tfz
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: fix missing dpll
 notification for SW pins
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

On Wed, Feb 18, 2026 at 10:14:14PM +0100, Petr Oros wrote:
> ice_dpll_notify_changes() sends dpll_pin_change_ntf() only for the
> direct CGU input pin stored in d->active_input. Software-controlled
> pins (SMA/U.FL) are separate dpll_pin objects that wrap a backing CGU
> input, but they never receive a change notification. As a result,
> userspace consumers such as synce4l that monitor SMA pins via dpll
> netlink never learn when the pin state transitions (e.g. from
> SELECTABLE to CONNECTED), even though 'dpll pin show' reports the
> correct state on demand.
> 
> When the active input changes, also send dpll_pin_change_ntf() for any
> registered SMA/U.FL input pin whose backing CGU input matches the old
> or new active input.
> 
> Fixes: 2dd5d03c77e2 ("ice: redesign dpll sma/u.fl pins control")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dpll.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index c2ad39bfe177db..6f855fe4c78d62 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> @@ -2470,13 +2470,17 @@ static u64 ice_generate_clock_id(struct ice_pf *pf)
>   */
>  static void ice_dpll_notify_changes(struct ice_dpll *d)
>  {
> +	struct ice_dplls *dplls = &d->pf->dplls;
>  	bool pin_notified = false;
> +	int i;
>  
>  	if (d->prev_dpll_state != d->dpll_state) {
>  		d->prev_dpll_state = d->dpll_state;
>  		dpll_device_change_ntf(d->dpll);
>  	}
>  	if (d->prev_input != d->active_input) {
> +		struct dpll_pin *old = d->prev_input;

nit: For consistency I think you can reduce the scope of i to this block.
     Or even declare it inside for().

> +
>  		if (d->prev_input)
>  			dpll_pin_change_ntf(d->prev_input);
>  		d->prev_input = d->active_input;
> @@ -2484,6 +2488,20 @@ static void ice_dpll_notify_changes(struct ice_dpll *d)
>  			dpll_pin_change_ntf(d->active_input);
>  			pin_notified = true;
>  		}
> +		for (i = 0; i < ICE_DPLL_PIN_SW_NUM; i++) {
> +			if (dplls->sma[i].pin &&
> +			    dplls->sma[i].direction ==
> +			    DPLL_PIN_DIRECTION_INPUT &&
> +			    (dplls->sma[i].input->pin == d->active_input ||
> +			     dplls->sma[i].input->pin == old))
> +				dpll_pin_change_ntf(dplls->sma[i].pin);
> +			if (dplls->ufl[i].pin &&
> +			    dplls->ufl[i].direction ==
> +			    DPLL_PIN_DIRECTION_INPUT &&
> +			    (dplls->ufl[i].input->pin == d->active_input ||
> +			     dplls->ufl[i].input->pin == old))
> +				dpll_pin_change_ntf(dplls->ufl[i].pin);

The condition above is pretty dense. And repeated.
I wonder if a helper would improve readability here.

> +		}
>  	}
>  	if (d->prev_phase_offset != d->phase_offset) {
>  		d->prev_phase_offset = d->phase_offset;
> -- 
> 2.52.0
> 
