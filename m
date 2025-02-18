Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4678BC021AA
	for <intel-wired-lan@archiver.kernel.org>; Tue, 18 Feb 2025 18:25:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F25BA60F7B;
	Tue, 18 Feb 2025 18:25:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9PGZsle-NNXK; Tue, 18 Feb 2025 18:25:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5FCBB60EDC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1739903158;
	bh=VP3evxSX9H2Hc5FcdKeZ+7cIWBepzDt6epX5BB+BP54=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rIh+UiNY5lcdMQyOX2O5bsHRI0y6O9vABGqWyjhFd9BdDD1Bn+cBKqYgS8jLXEJDF
	 TlfEQYqVVEsOGGMRtvePKz8ngJXrXPwzaDcWnSE7P3I29Yov1RisfyRBIcPS473UGc
	 xNzoQ7n4egDau012hv9GiRYAt5mGittib6RzKyohQ3eTXKokSjPRgd/tWJVsnRrcu8
	 iFUOmoUoF1+xsaqCxBVaGQnupdLelKXbxSQQEnJFgrOL4CvxLAjZCkeRGNC01D+emV
	 vgJ0sDs6V3YTYhLJd/miXwoRyLp9JmBnDEr8+RNdnZPMtoe9xagHurNleLkGITArtQ
	 Bl8nDgOc90lyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5FCBB60EDC;
	Tue, 18 Feb 2025 18:25:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DB608C8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Feb 2025 18:25:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BFC1B400FC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Feb 2025 18:25:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X6SIuvxgQuue for <intel-wired-lan@lists.osuosl.org>;
 Tue, 18 Feb 2025 18:25:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7907640275
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7907640275
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7907640275
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Feb 2025 18:25:53 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5af2b0.dynamic.kabel-deutschland.de
 [95.90.242.176])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1FAD761E6479A;
 Tue, 18 Feb 2025 19:25:36 +0100 (CET)
Message-ID: <aa596679-a229-4335-806b-45539d8ec1d2@molgen.mpg.de>
Date: Tue, 18 Feb 2025 19:25:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, andrew@lunn.ch, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20250218161741.4147-1-piotr.kwapulinski@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250218161741.4147-1-piotr.kwapulinski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ixgbe: fix media type
 detection for E610 device
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

Dear Piotr,


Thank you for your patch.

Am 18.02.25 um 17:17 schrieb Piotr Kwapulinski:
> The commit 23c0e5a16bcc ("ixgbe: Add link management support for E610
> device") introduced incorrect media type detection for E610 device. It
> reproduces when advertised speed is modified after driver reload.

It’d be great if you gave a concrete example.

> Clear the previous outdated PHY type.

Only the high byte?

> Fixes: 23c0e5a16bcc ("ixgbe: Add link management support for E610 device")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> index 683c668..0dfefd2 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> @@ -1453,9 +1453,11 @@ enum ixgbe_media_type ixgbe_get_media_type_e610(struct ixgbe_hw *hw)
>   			hw->link.link_info.phy_type_low = 0;
>   		} else {
>   			highest_bit = fls64(le64_to_cpu(pcaps.phy_type_low));
> -			if (highest_bit)
> +			if (highest_bit) {
>   				hw->link.link_info.phy_type_low =
>   					BIT_ULL(highest_bit - 1);
> +				hw->link.link_info.phy_type_high = 0;
> +			}
>   		}
>   	}


Kind regards,

Paul
