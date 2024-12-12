Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083DCE77180
	for <intel-wired-lan@archiver.kernel.org>; Thu, 12 Dec 2024 16:30:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 92DCB841A3;
	Thu, 12 Dec 2024 16:30:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JActT5JGKG_g; Thu, 12 Dec 2024 16:30:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A6F2481EA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1734021055;
	bh=4PIz3w4ERXCHmEDk07qqENKb4rZ1vCHeiMlTZBzm9NY=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TRVAygRL+YHFTyLWnYj41bTdId/K72PZUfGsxOqs0lqMx8g3/TCaWV32ogcyyG83N
	 lbiXVeY0YzNe4MCwm1dslrUAbfHqxJcNwb5S0kNX8/YLms6fbkhTCYT5vMAVnVJi6W
	 MfJBvUEO6skT94Qc5tUA0w/8dwHPSy2vnHvWLQdOCtBuY3h1afHJ5GCucbb8kvM09a
	 kHJEaPZv7vbTpOazbVj3Ob8TY6V3ftlvQ36alDFBWcrN3tsQb9rbIZhI7inCJ3ajqA
	 RMZE+Rqnx46ECNarWnsBzVjEiO5UAFW5IopK0bborMrCL7KRZ7A1Jh9DH4+aFV73zI
	 EF3YqV/JjRqfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A6F2481EA1;
	Thu, 12 Dec 2024 16:30:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A28631147
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Dec 2024 16:30:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 82E15409BA
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Dec 2024 16:30:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bFRmKtKF3QH6 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 12 Dec 2024 16:30:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=147.75.193.91;
 helo=nyc.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2EE254094A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2EE254094A
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2EE254094A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Dec 2024 16:30:53 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id ADDC9A42918;
 Thu, 12 Dec 2024 16:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8B7C4CECE;
 Thu, 12 Dec 2024 16:30:50 +0000 (UTC)
Date: Thu, 12 Dec 2024 16:30:47 +0000
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Ahmed Zaki <ahmed.zaki@intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>
Message-ID: <20241212163047.GA73795@kernel.org>
References: <20241211132745.112536-2-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211132745.112536-2-przemyslaw.kitszel@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1734021051;
 bh=Bgd7dC+8VkZkhmHsUWGvAPgGMT1s5CIo9KCWBJ3WLgg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LjutuD17SdC3oU1eNsby40al2J7o8SErj+ov30fqtQQK085BsF1HSVdJEouvFEq9c
 mEf84+jqHBLX26q+mzSywIgC/n0L0CYkcwobTOarz2jYIu94DBq6WrXEya4E6SwIys
 y9yGXOiJIK3YDTIs21EymA8wC+qJRV1tVEpTDe8qeYcOn2IR3WBY/SM/zJhdquZO/Y
 cOMmk70J33AyhsfQSnrBUvmwsQOkzsbgtpdeUCH85DXLLQTvrqkPLt4aVWqZSAWjDs
 mS4DCi0Pi8exOKtbRTgd4Obh+QIDo2XM5+kgOQIcwcTU+N/zPXFyQtWf0t2jIPpg6k
 C/hHoZCSgBLAg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=LjutuD17
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: fix
 ice_parser_rt::bst_key array size
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

On Wed, Dec 11, 2024 at 02:26:36PM +0100, Przemek Kitszel wrote:
> Fix &ice_parser_rt::bst_key size. It was wrongly set to 10 instead of 20
> in the initial impl commit (see Fixes tag). All usage code assumed it was
> of size 20. That was also the initial size present up to v2 of the intro
> series [2], but halved by v3 [3] refactor described as "Replace magic
> hardcoded values with macros." The introducing series was so big that
> some ugliness was unnoticed, same for bugs :/
> 
> ICE_BST_KEY_TCAM_SIZE and ICE_BST_TCAM_KEY_SIZE were differing by one.
> There was tmp variable @j in the scope of edited function, but was not
> used in all places. This ugliness is now gone.
> I'm moving ice_parser_rt::pg_prio a few positions up, to fill up one of
> the holes in order to compensate for the added 10 bytes to the ::bst_key,
> resulting in the same size of the whole as prior to the fix, and miminal
> changes in the offsets of the fields.
> 
> This fix obsoletes Ahmed's attempt at [1].
> 
> [1] https://lore.kernel.org/intel-wired-lan/20240823230847.172295-1-ahmed.zaki@intel.com
> [2] https://lore.kernel.org/intel-wired-lan/20230605054641.2865142-13-junfeng.guo@intel.com
> [3] https://lore.kernel.org/intel-wired-lan/20230817093442.2576997-13-junfeng.guo@intel.com
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/intel-wired-lan/b1fb6ff9-b69e-4026-9988-3c783d86c2e0@stanley.mountain
> Fixes: 9a4c07aaa0f5 ("ice: add parser execution main loop")
> CC: Ahmed Zaki <ahmed.zaki@intel.com>
> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Hi Przemek,

I agree that these changes are good.  But I wonder if it would be best to
only treat the update size of bst_key as a fix.

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_parser_rt.c b/drivers/net/ethernet/intel/ice/ice_parser_rt.c
> index dedf5e854e4b..d9c38ce27e4f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_parser_rt.c
> +++ b/drivers/net/ethernet/intel/ice/ice_parser_rt.c
> @@ -125,22 +125,20 @@ static void ice_bst_key_init(struct ice_parser_rt *rt,
>  	else
>  		key[idd] = imem->b_kb.prio;
>  
> -	idd = ICE_BST_KEY_TCAM_SIZE - 1;
> +	idd = ICE_BST_TCAM_KEY_SIZE - 2;
>  	for (i = idd; i >= 0; i--) {
>  		int j;
>  
>  		j = ho + idd - i;
>  		if (j < ICE_PARSER_MAX_PKT_LEN)
> -			key[i] = rt->pkt_buf[ho + idd - i];
> +			key[i] = rt->pkt_buf[j];
>  		else
>  			key[i] = 0;
>  	}
>  
> -	ice_debug(rt->psr->hw, ICE_DBG_PARSER, "Generated Boost TCAM Key:\n");
> -	ice_debug(rt->psr->hw, ICE_DBG_PARSER, "%02X %02X %02X %02X %02X %02X %02X %02X %02X %02X\n",
> -		  key[0], key[1], key[2], key[3], key[4],
> -		  key[5], key[6], key[7], key[8], key[9]);
> -	ice_debug(rt->psr->hw, ICE_DBG_PARSER, "\n");
> +	ice_debug_array_w_prefix(rt->psr->hw, ICE_DBG_PARSER,
> +				 KBUILD_MODNAME "Generated Boost TCAM Key",

Should there be a delimeter between KBUILD_MODNAME and "Generated ..." ?
e.g.:

				 KBUILD_MODNAME ": Generated Boost TCAM Key",

> +				 key, ICE_BST_TCAM_KEY_SIZE);
>  }
>  
>  static u16 ice_bit_rev_u16(u16 v, int len)
> 
> base-commit: 51a00be6a0994da2ba6b4ace3b7a0d9373b4b25e
> -- 
> 2.46.0
> 
> 
