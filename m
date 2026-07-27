Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C05C531D0
	for <intel-wired-lan@archiver.kernel.org>; Mon, 27 Jul 2026 09:46:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 70FBF4046D;
	Mon, 27 Jul 2026 09:46:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PPSqONzeyLWD; Mon, 27 Jul 2026 09:46:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A18EA40630
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785145571;
	bh=KfuVeh2YNqH1b7KirUNNJ0ubuePgr/u80Cse7JhvyPw=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YnEVXmbFoOQAT5GojON/hzoHMQZPD8Vdugl1RwlT+cM9oMk5/zIP9Fv06B1pJZsbl
	 Zc5JuFkH8xbaxosfIQ9Lvnh9hPbh0oTMkPcVKiJ/9OwJ8eROCOb9bCAgGDG/RSips7
	 aGleZ6LhFfwILOhZD/mBQd3I6GSvhrxVw1HK7B4D6ZfoKweyxL6qmNQrwaAjdrkNBT
	 MjcUyXqBZHwLqqOG/tsA71rF1eeno5Ms6Vu0DR2U9S6z+kxhiCm/5Y7T4LXni+UFFf
	 1w8eIZ3QSApzgp53tZNkfaFyu53v3fABhagXBF4ckXvKsSsMqFd++OFV+3KVnOtS3r
	 N0piTEQdSzZ9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A18EA40630;
	Mon, 27 Jul 2026 09:46:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 083CC350
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 09:46:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E255780D5C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 09:46:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IlksJObbf8wP for <intel-wired-lan@lists.osuosl.org>;
 Mon, 27 Jul 2026 09:46:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=marcin.szycik@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A044980D3D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A044980D3D
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A044980D3D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 09:46:07 +0000 (UTC)
X-CSE-ConnectionGUID: VMcA+nvBT1GYMCLMEfnpIQ==
X-CSE-MsgGUID: 3tpAAAo4Rxu9P2UacO3vyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="103250902"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; d="scan'208";a="103250902"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2026 02:46:07 -0700
X-CSE-ConnectionGUID: JamNl8+GSV6UQNknkzi9vQ==
X-CSE-MsgGUID: v9NvPtl0RK+K72O1j2Vd4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; d="scan'208";a="263148737"
Received: from mszycik-desk.igk.intel.com (HELO [10.217.160.239])
 ([10.217.160.239])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2026 02:46:05 -0700
Message-ID: <cb66f729-2869-4116-bac0-15bb6557a7dd@linux.intel.com>
Date: Mon, 27 Jul 2026 11:45:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sang-Heon Jeon <ekffu200098@gmail.com>, kuba@kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260725150852.859188-1-ekffu200098@gmail.com>
 <20260725150852.859188-5-ekffu200098@gmail.com>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20260725150852.859188-5-ekffu200098@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785145568; x=1816681568;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=CAANQ8JwqOdCbVfDdGusJsGbBaNEb10o4VqN1uAhUbM=;
 b=UXMkKWODu/k4OYXVusorklBYo0loRDiPwKs5Xsw/TYU0H7jVfZ7SDcys
 HHPqhIC1s1MV9IA1Tg+xcmT0VeEsP6Ta7W2Js3tsr+sHT5w47bI95a7ZE
 djCB13gcfeHxr8GQS+Em1RWEXUYVsLNAzIgZojmVnYgXy7gsp6uRYjHgT
 V8fZxuXaM3ULjaexHcweQbsy38fjNlxDkfETRNX/Y0lUE8Xc/UG/Yn8+c
 svJgROhC/bp/He61do3jHIHEAvE/Sr0MpF1rIu2ZmN+jn/Vh1zqfm2cvl
 alowb1I4GTc/DHiUZYEkIiGy31GAIH8A5dae5gfMSFQ1GTnFWXR+mJkc5
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=UXMkKWOD
Subject: Re: [Intel-wired-lan] [PATCH net-next v2 4/4] net: intel: remove
 conditional return with no effect
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



On 25/07/2026 17:08, Sang-Heon Jeon wrote:
> Both branches of the check return the same value, so the check has
> no effect. Remove it and return the value directly.
> 
> This is the result of running the Coccinelle script from
> scripts/coccinelle/misc/cond_return_no_effect.cocci.
> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>

Nice cleanup.

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>

> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 8 +-------
>  drivers/net/ethernet/intel/igb/e1000_i210.c | 6 +-----
>  drivers/net/ethernet/intel/igc/igc_phy.c    | 6 +-----
>  3 files changed, 3 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index a04683004a56..0cd0e5597c90 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -4864,16 +4864,10 @@ static void i40e_control_rx_q(struct i40e_pf *pf, int pf_q, bool enable)
>   **/
>  int i40e_control_wait_rx_q(struct i40e_pf *pf, int pf_q, bool enable)
>  {
> -	int ret = 0;
> -
>  	i40e_control_rx_q(pf, pf_q, enable);
>  
>  	/* wait for the change to finish */
> -	ret = i40e_pf_rxq_wait(pf, pf_q, enable);
> -	if (ret)
> -		return ret;
> -
> -	return ret;
> +	return i40e_pf_rxq_wait(pf, pf_q, enable);
>  }
>  
>  /**
> diff --git a/drivers/net/ethernet/intel/igb/e1000_i210.c b/drivers/net/ethernet/intel/igb/e1000_i210.c
> index 9db29b231d6a..784f9a7bcbed 100644
> --- a/drivers/net/ethernet/intel/igb/e1000_i210.c
> +++ b/drivers/net/ethernet/intel/igb/e1000_i210.c
> @@ -756,11 +756,7 @@ static s32 __igb_access_xmdio_reg(struct e1000_hw *hw, u16 address,
>  		return ret_val;
>  
>  	/* Recalibrate the device back to 0 */
> -	ret_val = hw->phy.ops.write_reg(hw, E1000_MMDAC, 0);
> -	if (ret_val)
> -		return ret_val;
> -
> -	return ret_val;
> +	return hw->phy.ops.write_reg(hw, E1000_MMDAC, 0);
>  }
>  
>  /**
> diff --git a/drivers/net/ethernet/intel/igc/igc_phy.c b/drivers/net/ethernet/intel/igc/igc_phy.c
> index 4cf737fb3b21..b758a7e0f013 100644
> --- a/drivers/net/ethernet/intel/igc/igc_phy.c
> +++ b/drivers/net/ethernet/intel/igc/igc_phy.c
> @@ -675,11 +675,7 @@ static s32 __igc_access_xmdio_reg(struct igc_hw *hw, u16 address,
>  		return ret_val;
>  
>  	/* Recalibrate the device back to 0 */
> -	ret_val = hw->phy.ops.write_reg(hw, IGC_MMDAC, 0);
> -	if (ret_val)
> -		return ret_val;
> -
> -	return ret_val;
> +	return hw->phy.ops.write_reg(hw, IGC_MMDAC, 0);
>  }
>  
>  /**

