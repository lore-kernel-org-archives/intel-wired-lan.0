Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7AF8C47422
	for <intel-wired-lan@archiver.kernel.org>; Fri, 26 Jan 2024 12:20:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 646BB836C5;
	Fri, 26 Jan 2024 12:20:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 646BB836C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1706271628;
	bh=muqaJK5yxdWPtsteEh8rv8RW4eolqlMeFQuBFD9p780=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=WcrS6fZYnhQ2Y4tF1RX4gbPWglHYDAoHUkWWJJNa4afnLQ/eeyVz1YF5/kZ0NhBDe
	 8Kti5MzB/P+bnwfXjgzOwoopHFguQpVG+8NgMnfu7fie0jbt17rBihOts2OPI4tJxM
	 pOxzcbJNyM2hV77rMlHCfYsM6V8+pn++FfeBlEyBWGrbFLCPhHrab8Pl9e4GGE4plS
	 eiAPyXDdpUW4biWp1ZTSzc7xn8t6/fGcbJkiN3OhctEpiud9BqgsIUlx+8ArOzJtrw
	 gw3afUH6KxgwEWjmzRmYZnP8dIgt9gN8SgdBG42NEyN/4mL7HYOm1Gct9U8OT02vrZ
	 Wu3HoPUNfoPOA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qs7SPEJv4U_Q; Fri, 26 Jan 2024 12:20:27 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B61A836F6;
	Fri, 26 Jan 2024 12:20:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9B61A836F6
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 830531BF363
 for <intel-wired-lan@lists.osuosl.org>; Fri, 26 Jan 2024 12:20:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5AB2060BF1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 26 Jan 2024 12:20:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5AB2060BF1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cvamc0F5hwI7 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 26 Jan 2024 12:20:24 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B52D860BB1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 26 Jan 2024 12:20:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B52D860BB1
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9E80061E5FE05;
 Fri, 26 Jan 2024 13:20:08 +0100 (CET)
Message-ID: <ef60b488-35d1-46f3-8ecd-f373b22bdf37@molgen.mpg.de>
Date: Fri, 26 Jan 2024 13:20:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Sasha Neftin <sasha.neftin@intel.com>
References: <20240124055700.818996-1-sasha.neftin@intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240124055700.818996-1-sasha.neftin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1 1/1] igc: Remove temporary
 workaround
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
Cc: intel-wired-lan@lists.osuosl.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Dear Sasha,


Thank you for your patch. As always some nits.

Am 24.01.24 um 06:57 schrieb Sasha Neftin:
> PHY_CONTROL register works as defined in the IEEE 802.3 specification.

Remove the dot/period as the parenthesis follow?

> (IEEE 802.3-2008 22.2.4.1). Tide up the temporary workaround.

I’d be more specific in the commit message summary/title. Maybe (now idea):

igc: Enable PHY_CONTROL

How did you test this?

> Fixes: 5586838fe9ce ("igc: Add code for PHY support")
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_phy.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_phy.c b/drivers/net/ethernet/intel/igc/igc_phy.c
> index 7cd8716d2ffa..861f37076861 100644
> --- a/drivers/net/ethernet/intel/igc/igc_phy.c
> +++ b/drivers/net/ethernet/intel/igc/igc_phy.c
> @@ -130,11 +130,7 @@ void igc_power_down_phy_copper(struct igc_hw *hw)
>   	/* The PHY will retain its settings across a power down/up cycle */
>   	hw->phy.ops.read_reg(hw, PHY_CONTROL, &mii_reg);
>   	mii_reg |= MII_CR_POWER_DOWN;
> -
> -	/* Temporary workaround - should be removed when PHY will implement
> -	 * IEEE registers as properly
> -	 */
> -	/* hw->phy.ops.write_reg(hw, PHY_CONTROL, mii_reg);*/
> +	hw->phy.ops.write_reg(hw, PHY_CONTROL, mii_reg);
>   	usleep_range(1000, 2000);
>   }

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
