Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C1010F9940
	for <intel-wired-lan@archiver.kernel.org>; Wed,  8 Apr 2026 14:28:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A191C82435;
	Wed,  8 Apr 2026 14:28:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jmgZQgrEP0MB; Wed,  8 Apr 2026 14:28:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 44FC182425
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775658495;
	bh=Bxiw5mVHENcrRPV7A1vvWpBcBReAl8itOfhT8mHqNRE=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pLdih2pMEgHKrMtrvxY59F8IfhC7PFKp3UvOqkxpgnStjprNSqwteEbR5dvBbO4Cu
	 ZZYM6k4Beg2HBrUh+6C4OwrcgBP3bBC3qTjUV3/QzUGp0Ip0zGYwcZ9GnOA/znn5BB
	 KbD58BYG39YzbclAhrkzJ6cFuQ4OrT5sLDzIQu7yq2SwDaPYB0jTaWOoWzrmFxPQi7
	 htczuCKOr/Rgl3Ci4+gIXriDE1TUxALQh8Ndfvc/GOv1/L4JkvyyQ87BXFGMyW1FcH
	 X53NzC4WJqVk3jwK4WLoRqMcKonQWcFRHzhFKt3lhSUpO4iufYsgq57TWAePaDgI9c
	 nBVKRFugSTqDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 44FC182425;
	Wed,  8 Apr 2026 14:28:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 34C401F6
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Apr 2026 14:28:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 17BDC402D7
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Apr 2026 14:28:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WGv8dOxizZCl for <intel-wired-lan@lists.osuosl.org>;
 Wed,  8 Apr 2026 14:28:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 58CDF402A8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 58CDF402A8
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 58CDF402A8
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Apr 2026 14:28:11 +0000 (UTC)
Received: from [192.168.2.229] (p5dc55707.dip0.t-ipconnect.de [93.197.87.7])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id B82594C2C37F04;
 Wed, 08 Apr 2026 16:27:51 +0200 (CEST)
Message-ID: <d87f554d-ef86-44c7-9585-0a3806cc5752@molgen.mpg.de>
Date: Wed, 8 Apr 2026 16:27:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Marcin Szycik <marcin.szycik@intel.com>
References: <20260408141429.2798589-1-aleksandr.loktionov@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260408141429.2798589-1-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2] ice: call
 netif_keep_dst() once when entering switchdev mode
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

Dear Aleksandr, dear Marcin,


Thank you for the patch.

Am 08.04.26 um 16:14 schrieb Aleksandr Loktionov:
> From: Marcin Szycik <marcin.szycik@intel.com>
> 
> netif_keep_dst() only needs to be called once for the uplink VSI, not
> once for each port representor.  Move it from ice_eswitch_setup_repr()
> to ice_eswitch_enable_switchdev().

It’d be great, if you could share the commands, how to verify your change.

> Fixes: defd52455aee ("ice: do Tx through PF netdev in slow-path")
> Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v1 -> v2:
>   - Verified Fixes: tag via bisect - defd52455aee introduced the redundant
>     per-repr call to netif_keep_dst(uplink_vsi->netdev) by changing the
>     target netdev to the uplink VSI inside the per-representor setup
>     function. Before that commit, each call was on a distinct repr->netdev
>     so no Fixes: predating it applies.
> 
>   drivers/net/ethernet/intel/ice/ice_eswitch.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> index 2e4f096..c30e27b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> @@ -117,8 +117,6 @@ static int ice_eswitch_setup_repr(struct ice_pf *pf, struct ice_repr *repr)
>   	if (!repr->dst)
>   		return -ENOMEM;
>   
> -	netif_keep_dst(uplink_vsi->netdev);
> -
>   	dst = repr->dst;
>   	dst->u.port_info.port_id = vsi->vsi_num;
>   	dst->u.port_info.lower_dev = uplink_vsi->netdev;
> @@ -312,6 +310,8 @@ static int ice_eswitch_enable_switchdev(struct ice_pf *pf)
>   	if (ice_eswitch_br_offloads_init(pf))
>   		goto err_br_offloads;
>   
> +	netif_keep_dst(uplink_vsi->netdev);
> +
>   	pf->eswitch.is_running = true;
>   
>   	return 0;

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
