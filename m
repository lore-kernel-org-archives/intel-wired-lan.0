Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07AFDC5B56A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 12 Aug 2026 06:12:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A746240822;
	Wed, 12 Aug 2026 06:12:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kXuFSlZNh2HJ; Wed, 12 Aug 2026 06:12:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D75C64070A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786515134;
	bh=3LGNbtNWXIQhDg6Nu2fYS7BCJroKykQsTVyjfAy9ELY=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wvl51CD+MT+bedYxl4qdenOpajyegJv0sxpBPZdTfwpgQVf4owyXahQp5QDQKa/Cx
	 BzELwEsNA0DrcLlvtpjE5cwn4xPmYU9r0LYm3phxBcS8EIDecFgAUtNIeJUw/6hHob
	 yZtpeSQkgugURBQJ9hHcWHAk18md0YZD+XrMkTJXAZJ//Lg4fSPAe4Y+CyIUp+SkaH
	 2hxzJA7nB9nPG33qIQdxXTQzpRi/sJ03DaYG+8p9xXxTG/tXE5oxTp1dpROL4uPmmj
	 lmbYKJfmWWuIIZaQqSFnewYBDr5zAHxTCtEVDs+0G7I0ANv0tGwZgLUoT84gi6T855
	 aVnoLtmjN8KjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D75C64070A;
	Wed, 12 Aug 2026 06:12:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EC043259
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 06:12:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D1A4E80FFD
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 06:12:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lscq1lEkT31d for <intel-wired-lan@lists.osuosl.org>;
 Wed, 12 Aug 2026 06:12:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0851D81170
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0851D81170
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0851D81170
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 06:12:11 +0000 (UTC)
Received: from [192.168.0.150] (ip5f5af690.dynamic.kabel-deutschland.de
 [95.90.246.144])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 389814C2C90B43;
 Wed, 12 Aug 2026 08:11:53 +0200 (CEST)
Message-ID: <4173a6dd-8c82-4b2f-8532-84db150e3965@molgen.mpg.de>
Date: Wed, 12 Aug 2026 08:11:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Maciek Machnikowski <maciej.machnikowski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 jacob.e.keller@intel.com
References: <20260811231058.220370-1-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260811231058.220370-1-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: Recalibrate PHY after
 settime64 on E825-C
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

Dear Tony, dear Maciek,


Thank you for your patch.

Am 12.08.26 um 01:10 schrieb Tony Nguyen:
> From: Maciek Machnikowski <maciej.machnikowski@intel.com>
> 
> The PHY on E825-C requires recalibration after large jumps of the
> system time. Add missing PHY recalibration also on E825-C.

Why does it need it? Does the datasheet say so? Hardware errata?

How can the issue be reproduced?

> Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
> Signed-off-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_ptp.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 84b99cfc5675..bf625b9f4991 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -1956,8 +1956,9 @@ ice_ptp_settime64(struct ptp_clock_info *info, const struct timespec64 *ts)
>   	/* Reenable periodic outputs */
>   	ice_ptp_enable_all_perout(pf);
>   
> -	/* Recalibrate and re-enable timestamp blocks for E822/E823 */
> -	if (hw->mac_type == ICE_MAC_GENERIC)
> +	/* Recalibrate and re-enable timestamp blocks for E822/E823/E825-C */
> +	if (hw->mac_type == ICE_MAC_GENERIC ||
> +	    hw->mac_type == ICE_MAC_GENERIC_3K_E825)
>   		ice_ptp_restart_all_phy(pf);
>   exit:
>   	if (err) {

The diff looks fine:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
