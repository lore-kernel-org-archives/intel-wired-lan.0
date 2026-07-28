Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486CEC53219
	for <intel-wired-lan@archiver.kernel.org>; Tue, 28 Jul 2026 10:55:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E776840975;
	Tue, 28 Jul 2026 10:55:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ceArmBXRvNYB; Tue, 28 Jul 2026 10:55:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 555DF4096E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785236117;
	bh=PguSWyVqZRDGQy3BSxwBZ2iGGLwEFfLhZm0jfSJpPNY=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k+z0lAUgtO5RAvhE97/hvzidd8ie7cbzi8LOUnRtMfexQR0eYciQ/EBbLCEBV0gwC
	 RP6eT1ZNaSylWKLcbud6JqOdGijflhIMYCKneVkhglRinHZs/lXrbplgCVHsXH+ZUd
	 KgDBGkhD+m3BWudkcff+BTbOnUTv2miXBRvMaNCSBylnHAPCOjTpqh6tcp44gbLgYp
	 hCngrEhNDkJDtqUS9LZsvR/6VQLgeZG8U0SFtz1eeiCX0KSD9FkIqq66Ayp3HHsWvp
	 DzcO9qmVY7700RNjyHrcm81HChRLRakEkGK6ZK3ZiR3+An1sBjFVpnUj1vlgpThfKv
	 9/Noa4hEICDAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 555DF4096E;
	Tue, 28 Jul 2026 10:55:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9266E350
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Jul 2026 10:55:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 83EEF402C5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Jul 2026 10:55:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 66TADBzCm5GJ for <intel-wired-lan@lists.osuosl.org>;
 Tue, 28 Jul 2026 10:55:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org CED09400D3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CED09400D3
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CED09400D3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Jul 2026 10:55:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0E54D40C36;
 Tue, 28 Jul 2026 10:55:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC00E1F000E9;
 Tue, 28 Jul 2026 10:55:13 +0000 (UTC)
Date: Tue, 28 Jul 2026 11:55:11 +0100
From: Simon Horman <horms@kernel.org>
To: Lukasz Czapnik <lukasz.czapnik@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Jakub Kaminski <jakub.kaminski@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Tomasz Lichwala <tomasz.lichwala@intel.com>
Message-ID: <20260728105511.GT418547@horms.kernel.org>
References: <20260722122448.2286008-1-lukasz.czapnik@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722122448.2286008-1-lukasz.czapnik@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785236114;
 bh=PguSWyVqZRDGQy3BSxwBZ2iGGLwEFfLhZm0jfSJpPNY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=WC8YgbD86orGre8TwX3YKNWk7Oo7h7uPAOWj3jJD+xj/pDGvJKZzLWcvrUYrgVc4u
 KNkFCVNudka0R/uu05a4/K+H+9vkWHUEVUBR81KnV0w6hl7Dy5x+djIvD1QN6j+PIv
 l0idKSc/4L5frEzzYdtyVbjX2W4I7E8JFS+Jh5AM5uXUL8F/gHI8Kji8M5kGc5wxTT
 lxpr83Qia7wtr1eIT0kYfo8Cn90XrvzqBm2GbeYhChpsRLatosHmnlZdvVk3/9eOqy
 XMy3ycdvxWngk6lcwYCiMAJD9Q84rUGoyMoRPMZFHR+2AcLILgMU7Sp6eqkZvc1mqr
 xBx7IruCWbi/Q==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=WC8YgbD8
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: Fix "Unknown bps" during
 link events
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

On Wed, Jul 22, 2026 at 02:24:48PM +0200, Lukasz Czapnik wrote:

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c

...

> @@ -1193,8 +1194,10 @@ ice_link_event(struct ice_pf *pf, struct ice_port_info *pi, bool link_up,
>  	/* Check if the link state is up after updating link info, and treat
>  	 * this event as an UP event since the link is actually UP now.
>  	 */
> -	if (phy_info->link_info.link_info & ICE_AQ_LINK_UP)
> +	if (phy_info->link_info.link_info & ICE_AQ_LINK_UP) {
>  		link_up = true;
> +		link_speed = phy_info->link_info.link_speed;
> +	}
>  
>  	vsi = ice_get_main_vsi(pf);
>  	if (!vsi || !vsi->port_info)

I have a minor concern that the change above effects the following,
which is a little further down in the same function.

	/* if the old link up/down and speed is the same as the new */
	if (link_up == old_link && link_speed == old_link_speed)
		return 0;

Maybe it's obvious why that isn't the case.
But if so, perhaps could be mentioned in the patch description anyway?

> @@ -1224,7 +1227,7 @@ ice_link_event(struct ice_pf *pf, struct ice_port_info *pi, bool link_up,
>  			ice_set_dflt_mib(pf);
>  	}
>  	ice_vsi_link_event(vsi, link_up);
> -	ice_print_link_msg(vsi, link_up);
> +	ice_print_link_msg(vsi, link_up, link_speed);
>  
>  	ice_vc_notify_link_state(pf);
>  

...
