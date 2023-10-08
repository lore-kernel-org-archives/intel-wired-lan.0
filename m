Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A311E95A82
	for <intel-wired-lan@archiver.kernel.org>; Sun,  8 Oct 2023 14:09:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 897BD403FF;
	Sun,  8 Oct 2023 14:09:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 897BD403FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1696774185;
	bh=ye8ZliInoKlrWW6vF+cfWw2kW2kjcr9YUUUM7LObbRk=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Xbn7Z9ntZeFWiS5mPA+l1L+pfwQjRJFvN1RPTjTU/LUyRovvVUaXUoXwUvSpM8xj2
	 aGAsJeLnAyrR0nBMHw6GTveV2QNt6eSBjSD2KcTopxH7lZigGe27yoAK4af4VuPTvn
	 KRAd86SpbgpPQb4htbAt8SToYSWl5FPdrWLBBSqbz2niC0Zbj3uhdKozUDQhhE4UTl
	 UhD32/Jza1cGaTR0xTq4H8QGoX+Q38kSrLUb/5hvVAJIqhY+ceZDtCVx9dyeIUJe1+
	 oMa0U3PhG7aiBvQrF9nCW9xiI79DsE53OCZz91vGy7jEDZ+cbMyEuziwP57GxbsJuf
	 07LUGG5pTvEOw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GOtpyWeDLsox; Sun,  8 Oct 2023 14:09:44 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 87B8640593;
	Sun,  8 Oct 2023 14:09:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 87B8640593
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id BB6EA1BF2EF
 for <intel-wired-lan@lists.osuosl.org>; Sun,  8 Oct 2023 14:09:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 924EB405A2
 for <intel-wired-lan@lists.osuosl.org>; Sun,  8 Oct 2023 14:09:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 924EB405A2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jEma8q7YIcZs for <intel-wired-lan@lists.osuosl.org>;
 Sun,  8 Oct 2023 14:09:42 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2EFE440542
 for <intel-wired-lan@lists.osuosl.org>; Sun,  8 Oct 2023 14:09:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2EFE440542
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 14FD4CE0A11;
 Sun,  8 Oct 2023 14:09:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A87C433C8;
 Sun,  8 Oct 2023 14:09:36 +0000 (UTC)
Date: Sun, 8 Oct 2023 16:09:34 +0200
From: Simon Horman <horms@kernel.org>
To: Dave Ertman <david.m.ertman@intel.com>
Message-ID: <20231008140934.GI831234@kernel.org>
References: <20231006210211.1443696-1-david.m.ertman@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231006210211.1443696-1-david.m.ertman@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1696774177;
 bh=8N7Vu6fE1UJTylpIcqubQbtnPqSDc9vbK19cmandGTQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=h8v9ntIo4lhKIghBZSRBhlYjXsHkQY3sWR2jPYFyw9FdI99M4fFj093QZe5y+QYJl
 znMoQDTEZlkmhHZLKC5pCyL+oprcaqZetk+sDbg+0bv4yelyRe6NpgGf+G8FLBUWl6
 00gzF9iYydvCzVdiF44VN4otPc+eKoTZu2pzezz+kYx4miTAUROAiobh/71rUjsRbY
 LhD36ezyhf7H0APKZNWkK4ir0Ca7Q/E4wPbTqS4iRGkyGl8ZIl4jnfO6Kr0shTYYV0
 R8DKmiG170ypeGTN75QVZOito3Ojhj4nawIIVw4ZeCiwFMczeS2lUUa2mZQ25wo7Yi
 olsgoxsMr9BGA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=h8v9ntIo
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: Fix SRIOV LAG disable
 on non-compliant aggreagate
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
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, Oct 06, 2023 at 02:02:11PM -0700, Dave Ertman wrote:
> If an attribute of an aggregate interface disqualifies it from supporting
> SRIOV, the driver will unwind the SRIOV support.  Currently the driver is
> clearing the feature bit for all interfaces in the aggregate, but this is
> not allowing the other interfaces to unwind successfully on driver unload.
> 
> Only clear the feature bit for the interface that is currently unwinding.
> 
> Fixes: bf65da2eb279 ("ice: enforce interface eligibility and add messaging for SRIOV LAG")
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lag.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
> index 2c96d1883e19..c9071228b1ea 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lag.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lag.c
> @@ -1513,17 +1513,12 @@ static void ice_lag_chk_disabled_bond(struct ice_lag *lag, void *ptr)
>   */
>  static void ice_lag_disable_sriov_bond(struct ice_lag *lag)
>  {
> -	struct ice_lag_netdev_list *entry;
>  	struct ice_netdev_priv *np;
> -	struct net_device *netdev;
>  	struct ice_pf *pf;
>  
> -	list_for_each_entry(entry, lag->netdev_head, node) {
> -		netdev = entry->netdev;
> -		np = netdev_priv(netdev);
> -		pf = np->vsi->back;
> -
> -		ice_clear_feature_support(pf, ICE_F_SRIOV_LAG);
> +	np = netdev_priv(lag->netdev);
> +	pf = np->vsi->back;
> +	ice_clear_feature_support(pf, ICE_F_SRIOV_LAG);
>  	}
>  }

Hi Dave,

unfortunately applying this patch results in a build failure.

-- 
pw-bot: changes-requested


_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
