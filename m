Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9721C3DA6E
	for <intel-wired-lan@archiver.kernel.org>; Sat, 23 Dec 2023 18:22:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3EBE64011A;
	Sat, 23 Dec 2023 18:22:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3EBE64011A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1703355743;
	bh=QzMdA+M38f4WvonmMQsG9eh+LRwBiHP34ymmV9K1TLw=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=xxWr7E62jFageUAm2aINVOipYxwJrElnG1BUIs9kz2hCijONXIh2Pc9UA0bRMnZfh
	 xuwh+7csJoXl0RAK25KhfNot5KSAwWvbhGdjfIDYPt9Os8K+PxjNWeJXaTtQ+7JJ7g
	 G9ehe4Ly/moloRW4WAPXl5HTxgTwC9cYoiJ3e/rF9f2KACYZ3V232WxPLKLY1zpY5J
	 M9T3KY0vOI7SOO8kkiIgSWtancfBb/bIbd6+Vq36+biF1cyQ0/H4C7TKOAIxhXHfUh
	 wEZH2CKxjrQfGZ5vBSSDoNG2kligpYiKLEG3aUN5YZmPrtOlSEti3NgUrgv8nca35G
	 DEA9YKhWtc9Rg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NS5B1d9I1yCN; Sat, 23 Dec 2023 18:22:22 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id F3EC84011C;
	Sat, 23 Dec 2023 18:22:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F3EC84011C
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id A62A61BF34C
 for <intel-wired-lan@lists.osuosl.org>; Sat, 23 Dec 2023 18:22:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 89ABA41747
 for <intel-wired-lan@lists.osuosl.org>; Sat, 23 Dec 2023 18:22:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 89ABA41747
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zPxxM-vpkbgl for <intel-wired-lan@lists.osuosl.org>;
 Sat, 23 Dec 2023 18:22:19 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DB6A64160D
 for <intel-wired-lan@lists.osuosl.org>; Sat, 23 Dec 2023 18:22:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DB6A64160D
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 958DE60B05;
 Sat, 23 Dec 2023 18:22:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B849AC433C8;
 Sat, 23 Dec 2023 18:22:15 +0000 (UTC)
Date: Sat, 23 Dec 2023 18:22:13 +0000
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Message-ID: <20231223182213.GK201037@kernel.org>
References: <20231221100326.1030761-1-karol.kolacinski@intel.com>
 <20231221100326.1030761-3-karol.kolacinski@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231221100326.1030761-3-karol.kolacinski@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1703355737;
 bh=7YgZjgPdz3vwKmJhQ2IYJpvkLXR6GFQjhfBpY5pwTQE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DS4lintziKXlrbH/1Z5KCbLcHJ14mdE7uWCg662+xMU30MgHMuS7obF/vD2C1a6yC
 9/EctNgrYBk391CR3FsWE7bHRdKpsEaAisWGYHqtoqUAchCi1fFwqHWAVTL6YQ/d0n
 tAa+qbzn7zAjmnaAZVnBd1b9qNn2s6M1D7hnjKTLjVks5rSyYYUrSdFz7pUcGWnNGX
 U9cckBeLEGTlKBi8kQzBRmEsTs3Iu/Co1I+E1nzVU+y17NeVFKAqHzkcDcOn/9wj7X
 lVJMnvdSH9l0r8Q/zA0dBqN2VlSNmmru/Hz+Cs3P6SL5rjRt00bhWjd0t+QJybf0/i
 2T1VKwWfT+WPQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=DS4lintz
Subject: Re: [Intel-wired-lan] [PATCH v4 iwl-next 2/6] ice: pass reset type
 to PTP reset functions
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
Cc: Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org,
 jesse.brandeburg@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Dec 21, 2023 at 11:03:22AM +0100, Karol Kolacinski wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The ice_ptp_prepare_for_reset() and ice_ptp_reset() functions currently
> check the pf->flags ICE_FLAG_PFR_REQ bit to determine if the current
> reset is a PF reset or not.
> 
> This is problematic, because it is possible that a PF reset and a higher
> level reset (CORE reset, GLOBAL reset, EMP reset) are requested
> simultaneously. In that case, the driver performs the highest level
> reset requested. However, the ICE_FLAG_PFR_REQ flag will still be set.
> 
> The main driver reset functions take an enum ice_reset_req indicating
> which reset is actually being performed. Pass this data into the PTP
> functions and rely on this instead of relying on the driver flags.
> 
> This ensures that the PTP code performs the proper level of reset that
> the driver is actually undergoing.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
> index 2457380142e1..bbac053bd099 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.h
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
> @@ -314,8 +314,8 @@ enum ice_tx_tstamp_work ice_ptp_process_ts(struct ice_pf *pf);
>  
>  u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
>  			const struct ice_pkt_ctx *pkt_ctx);
> -void ice_ptp_reset(struct ice_pf *pf);

Hi Karol and Jacob,

I think that the declaration of ice_ptp_reset() is
needed for the case where CONFIG_PTP_1588_CLOCK=y
until patch 5/6 of this series.

> -void ice_ptp_prepare_for_reset(struct ice_pf *pf);
> +void ice_ptp_prepare_for_reset(struct ice_pf *pf,
> +			       enum ice_reset_req reset_type);
>  void ice_ptp_init(struct ice_pf *pf);
>  void ice_ptp_release(struct ice_pf *pf);
>  void ice_ptp_link_change(struct ice_pf *pf, u8 port, bool linkup);

...
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
