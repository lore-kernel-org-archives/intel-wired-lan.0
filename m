Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 665EFFED3CE
	for <intel-wired-lan@archiver.kernel.org>; Fri, 24 Apr 2026 14:00:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 115CC80C68;
	Fri, 24 Apr 2026 14:00:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C8U48l3w7xqT; Fri, 24 Apr 2026 14:00:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 42A1880BFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777039208;
	bh=/pOafHCgUief4FUDwHPdX1l9bczmYGq6ntuMlrpurhk=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hqnBwXUcoaVcznWUERiWpFy8p1UlxSkan2IbeSjVWgtD+JJM/AAax9pR/Yy3t03jK
	 aPbeKgEzrpY+/k6/dn8mehXWveRatwx76iCufOHea+KLHsvWUwIUZW9/KWUNVVRuas
	 vhUAxjglz0Z5JyTRhywYsEC/M7F31mTJse6kIvM9A9C0XI8Wzb6NMuvDV5AC1xBIpd
	 gWHnJC1zmuJ27I1HzjL2ysFvBt4aBo69mDHCqZnukT3D1yU1ooIw1KothZ8aKPFYnq
	 JMHyK32qj9awxfbbqtfWbDYIzVb0aJALNHGiNQ72Nr0XbJUgr+c4s8UdXJxMslD+PO
	 9IIQ7L2BckfCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 42A1880BFB;
	Fri, 24 Apr 2026 14:00:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DDCAB24D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Apr 2026 14:00:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CF78A6153A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Apr 2026 14:00:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wqXXepUcTlYQ for <intel-wired-lan@lists.osuosl.org>;
 Fri, 24 Apr 2026 14:00:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1D97061293
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1D97061293
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1D97061293
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Apr 2026 14:00:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C6706600AE;
 Fri, 24 Apr 2026 14:00:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FE5C19425;
 Fri, 24 Apr 2026 14:00:01 +0000 (UTC)
Date: Fri, 24 Apr 2026 14:59:58 +0100
From: Simon Horman <horms@kernel.org>
To: KhaiWenTan <khai.wen.tan@linux.intel.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, faizal.abdul.rahim@intel.com,
 hong.aun.looi@intel.com, khai.wen.tan@intel.com,
 Faizal Rahim <faizal.abdul.rahim@linux.intel.com>, Looi
Message-ID: <20260424135958.GL900403@horms.kernel.org>
References: <20260422155701.7420-1-khai.wen.tan@linux.intel.com>
 <20260422155701.7420-4-khai.wen.tan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422155701.7420-4-khai.wen.tan@linux.intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1777039204;
 bh=RjPXRwAeTtKHltjAE51ItOPdDhf9jKLVKaPyYVF/kmU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Nsfc9I4AdaKxHCRy2KFb+Y9+EwjnpX/Y3Yee7SewGiwoqUS87ru385v9QS+AC9Tlu
 Ev3ri/Dr7iQBhFV+L87rM+SimKLIGXXiM6UYXxJXYsmB/Vp/QaHyqvL4mZkRFAkFxQ
 9rCN98ZbQK56Q+a87wdUSZ1mrSU1olCyLjOmPqGFQt+KtgeG0fLKk/zyMepzkf/02g
 QZnfzl65gmd34GvAzunuH8Yuc/JYGIcQSKSaAfFPrFgkUImH1kZjq0LkSeyj9r6J4P
 P1CnBYb9FuNWtgSbosp6yrG30e0rB5gR6m5tPWIVQdMiLJ9kvAERwJuo140yk0GKsK
 DMleeFOSEzqGw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=Nsfc9I4A
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3 3/3] igc: add support for
 forcing link speed without autonegotiation
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

On Wed, Apr 22, 2026 at 11:57:01PM +0800, KhaiWenTan wrote:
> From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> 
> Allow users to force 10/100 Mb/s link speed and duplex via ethtool
> when autonegotiation is disabled. Previously, the driver rejected
> these requests with "Force mode currently not supported.".
> 
> Forcing at 1000 Mb/s and 2500 Mb/s is not supported.
> 
> Reviewed-by: Looi, Hong Aun <hong.aun.looi@intel.com>
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> Signed-off-by: KhaiWenTan <khai.wen.tan@linux.intel.com>

...

> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c

...

> @@ -2000,6 +2013,41 @@ static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
>  	return 0;
>  }
>  
> +/**
> + * igc_handle_autoneg_disabled - Configure forced speed/duplex settings
> + * @adapter: private driver structure
> + * @speed: requested speed (must be SPEED_10 or SPEED_100)
> + * @duplex: requested duplex
> + *
> + * Records forced speed/duplex when autoneg is disabled.
> + * Caller must validate speed before calling this function.
> + */
> +static void igc_handle_autoneg_disabled(struct igc_adapter *adapter, u32 speed,
> +					u8 duplex)
> +{
> +	struct igc_mac_info *mac = &adapter->hw.mac;
> +
> +	switch (speed) {
> +	case SPEED_10:
> +		mac->forced_speed_duplex = (duplex == DUPLEX_FULL) ?
> +			IGC_FORCED_10F : IGC_FORCED_10H;
> +		break;
> +	case SPEED_100:
> +		mac->forced_speed_duplex = (duplex == DUPLEX_FULL) ?
> +			IGC_FORCED_100F : IGC_FORCED_100H;
> +		break;
> +	default:
> +		WARN_ONCE(1, "Unsupported speed %u\n", speed);
> +		return;
> +	}
> +
> +	mac->autoneg_enabled = false;
> +
> +	/* Half-duplex cannot support flow control per IEEE 802.3 */
> +	if (duplex != DUPLEX_FULL)
> +		adapter->hw.fc.requested_mode = igc_fc_none;
> +}
> +
>  /**
>   * igc_handle_autoneg_enabled - Configure autonegotiation advertisement
>   * @adapter: private driver structure
> @@ -2038,6 +2086,7 @@ static void igc_handle_autoneg_enabled(struct igc_adapter *adapter,
>  						  10baseT_Half))
>  		advertised |= ADVERTISE_10_HALF;
>  
> +	hw->mac.autoneg_enabled = true;
>  	hw->phy.autoneg_advertised = advertised;
>  	if (adapter->fc_autoneg)
>  		hw->fc.requested_mode = igc_fc_default;
> @@ -2071,14 +2120,20 @@ igc_ethtool_set_link_ksettings(struct net_device *netdev,
>  		}
>  	}
>  
> +	if (cmd->base.autoneg == AUTONEG_DISABLE &&
> +	    cmd->base.speed != SPEED_10 && cmd->base.speed != SPEED_100) {
> +		netdev_info(dev, "Unsupported speed for forced link\n");
> +		return -EINVAL;
> +	}

The condition above verifies speed only if autoneg is AUTONEG_DISABLE.

> +
>  	while (test_and_set_bit(__IGC_RESETTING, &adapter->state))
>  		usleep_range(1000, 2000);
>  
> -	if (cmd->base.autoneg == AUTONEG_ENABLE) {
> +	if (cmd->base.autoneg == AUTONEG_ENABLE)
>  		igc_handle_autoneg_enabled(adapter, cmd);
> -	} else {
> -		netdev_info(dev, "Force mode currently not supported\n");
> -	}
> +	else
> +		igc_handle_autoneg_disabled(adapter, cmd->base.speed,
> +					    cmd->base.duplex);

But here igc_handle_autoneg_disabled, which relies on speed having been
verified, is called if autoneg is not AUTONEG_ENABLE.

If autoneg is AUTONEG_DISABLE here, then all is good.
But if it is neither AUTONEG_DISABLE nor AUTONEG_ENABLE then we
are in trouble.

I suggest verifying autoneg is either AUTONEG_ENABLE or AUTONEG_DISABLE
earlier in this function.

The above is based on my analysis of review AI generated review from Sashiko.
I believe that addressing autoneg verification address the review by
Sashiko that is relevant to the progress of this patch.

...
