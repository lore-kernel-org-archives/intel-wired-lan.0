Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD018C369A8
	for <intel-wired-lan@archiver.kernel.org>; Fri, 11 Apr 2025 12:37:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 91117405D7;
	Fri, 11 Apr 2025 12:37:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DysU9MOujFnD; Fri, 11 Apr 2025 12:37:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B276B4173C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1744375022;
	bh=v/+tujnu+dJQP3b8U7/HRuZXN4dSfwqr0LyLAupbyZ8=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XJxMewA5zejhhqCYd2dIhvR9WB8Sq3A5roaMk1uJjPH6wrTcMquO+j4ZDBkrMdqVw
	 hmhfhzRogdegFPuTwXENoFBu0Ipf8xlIGRp8MKtCFEqj/TtTKzyK3qXEvevNGb/SBF
	 bGErXlsDcGXCqR39CFPEO2jfk4ZURMphjQXAYywwd8tuOECAWMkowkqbMrhCJgkurS
	 wh4N24W7oLH9ymQW2r4RjeDpPkx6NbJ+kT2CeUIiiY5MDmncCmzynyl7V6EkFBi9f6
	 J5Qg54IXar+lVv/3J+3hCWBkz2ynvDPWWt38MEfDM5WN1tOWAPhsXas1RxEj/ChX7K
	 pA6EWdeuM34PQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B276B4173C;
	Fri, 11 Apr 2025 12:37:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CC079108
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Apr 2025 12:37:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BBD694004A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Apr 2025 12:37:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H-fnHtwllR3q for <intel-wired-lan@lists.osuosl.org>;
 Fri, 11 Apr 2025 12:37:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2C7CF40597
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2C7CF40597
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2C7CF40597
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Apr 2025 12:37:00 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 848F8436A3;
 Fri, 11 Apr 2025 12:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B48C4CEE8;
 Fri, 11 Apr 2025 12:36:57 +0000 (UTC)
Date: Fri, 11 Apr 2025 13:36:55 +0100
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 Michal Kubiak <michal.kubiak@intel.com>,
 Milena Olech <milena.olech@intel.com>
Message-ID: <20250411123655.GC395307@horms.kernel.org>
References: <20250409122830.1977644-12-karol.kolacinski@intel.com>
 <20250409122830.1977644-14-karol.kolacinski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409122830.1977644-14-karol.kolacinski@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1744375019;
 bh=KnsVY9sZXhd6B4Lr+cWrYHT+qQpOxeZV9n2BSY5yzQE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iycIUIfYtY9JOui2TvKnm6XF4OcI453O76KcvoWb2Thw2frzIIcjny4BhaYrz6mEK
 pOjJrJiMcLawF/jbWBiZyge2n0mKsp0sqfNbzGUXJBJvEyBK8WJkQx3sDsJh5L9M3q
 Va187xejr4Xnexl3e3chSx9dfoR/WEa/IAKXqFRxqF8in6+tJjv9uisiOwX2frS7cQ
 5ZVpc10qZ/gPRsVtm9Jjx878OKmQFReYfe/ZidBHuOADFtVG52wR0GwqHkPSO9c/nn
 2n3Kc1UkaHP74dEMETl5+TgqO3FnI+6KXTYHU84OY7DtaT7WcforsJ8LQXLcbQ7sL/
 UXevDsg78v4uQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=iycIUIfY
Subject: Re: [Intel-wired-lan] [PATCH v2 iwl-next 02/10] ice: rename TSPLL
 and CGU functions and definitions
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

On Wed, Apr 09, 2025 at 02:24:59PM +0200, Karol Kolacinski wrote:
> Rename TSPLL and CGU functions, definitions etc. to match the file name
> and have consistent naming scheme.
> 
> Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
> Reviewed-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.h b/drivers/net/ethernet/intel/ice/ice_tspll.h
> index 181ca24a2739..0e28e97e09be 100644
> --- a/drivers/net/ethernet/intel/ice/ice_tspll.h
> +++ b/drivers/net/ethernet/intel/ice/ice_tspll.h
> @@ -2,16 +2,16 @@
>  #define _ICE_TSPLL_H_
>  
>  /**
> - * struct ice_cgu_pll_params_e82x - E82X CGU parameters
> + * struct ice_tspll_params_e82x

nit: tooling expects a short description here.

Flagged by ./scripts/kernel-doc -none

>   * @refclk_pre_div: Reference clock pre-divisor
>   * @feedback_div: Feedback divisor
>   * @frac_n_div: Fractional divisor
>   * @post_pll_div: Post PLL divisor
>   *
>   * Clock Generation Unit parameters used to program the PLL based on the
> - * selected TIME_REF frequency.
> + * selected TIME_REF/TCXO frequency.
>   */
> -struct ice_cgu_pll_params_e82x {
> +struct ice_tspll_params_e82x {
>  	u32 refclk_pre_div;
>  	u32 feedback_div;
>  	u32 frac_n_div;
> @@ -19,25 +19,25 @@ struct ice_cgu_pll_params_e82x {
>  };
>  
>  /**
> - * struct ice_cgu_pll_params_e825c - E825C CGU parameters
> - * @tspll_ck_refclkfreq: tspll_ck_refclkfreq selection
> - * @tspll_ndivratio: ndiv ratio that goes directly to the pll
> - * @tspll_fbdiv_intgr: TS PLL integer feedback divide
> - * @tspll_fbdiv_frac:  TS PLL fractional feedback divide
> - * @ref1588_ck_div: clock divider for tspll ref
> + * struct ice_tspll_params_e825c

Ditto.

> + * @ck_refclkfreq: ck_refclkfreq selection
> + * @ndivratio: ndiv ratio that goes directly to the PLL
> + * @fbdiv_intgr: TSPLL integer feedback divisor
> + * @fbdiv_frac: TSPLL fractional feedback divisor
> + * @ref1588_ck_div: clock divisor for tspll ref
>   *
>   * Clock Generation Unit parameters used to program the PLL based on the
>   * selected TIME_REF/TCXO frequency.
>   */
> -struct ice_cgu_pll_params_e825c {
> -	u32 tspll_ck_refclkfreq;
> -	u32 tspll_ndivratio;
> -	u32 tspll_fbdiv_intgr;
> -	u32 tspll_fbdiv_frac;
> +struct ice_tspll_params_e825c {
> +	u32 ck_refclkfreq;
> +	u32 ndivratio;
> +	u32 fbdiv_intgr;
> +	u32 fbdiv_frac;
>  	u32 ref1588_ck_div;
>  };

...
