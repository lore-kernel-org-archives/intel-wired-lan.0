Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E04F34C60
	for <intel-wired-lan@archiver.kernel.org>; Mon, 13 Apr 2026 14:59:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 168854007D;
	Mon, 13 Apr 2026 14:59:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PMWuVSxjitAI; Mon, 13 Apr 2026 14:59:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 488E141FBE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776092394;
	bh=+iiK69jUuj22K0hx6tkOrdhZnABEaD8kzPX09CT2qeA=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1UGzMzp7Un+8v37G/FQLzKfd0kUNPVkbM9Y7lpoAvrU7OwbEEtgzOdkvq5APRi1t+
	 h4i6XVgumfdM8PE1R0aw2NdsbRdu+9KEBKejJbdA0oj4HLMUCHn+9pcdS0CzzZtHOD
	 ExStExiG4/xd0sKgObMvHGnLvnT6ZxiAeRYKYwHh+wBIIlkc2OleZ/8bB1ZKL/G3/m
	 m8lAYczUKeHIK2Rpzb8Cj9jpREOI5P41ZTf3fPEjgM5Ou+QfNW2DqQN2cnNVI8Bohk
	 zTjgCoBN8YjoSisag4+Vpef2zEUb/5WKHbg8I4zbFGm6aYSPKPyLNBuLxVYth8ISvh
	 7Awjfb4AEY8tA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 488E141FBE;
	Mon, 13 Apr 2026 14:59:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 32E17237
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Apr 2026 14:59:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 248AB41FBE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Apr 2026 14:59:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XVDTt2XlwRps for <intel-wired-lan@lists.osuosl.org>;
 Mon, 13 Apr 2026 14:59:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 391F241F90
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 391F241F90
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 391F241F90
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Apr 2026 14:59:52 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A605042E3D;
 Mon, 13 Apr 2026 14:59:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EAB6C2BCAF;
 Mon, 13 Apr 2026 14:59:48 +0000 (UTC)
From: Simon Horman <horms@kernel.org>
To: khai.wen.tan@linux.intel.com
Cc: 'Simon Horman' <horms@kernel.org>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, faizal.abdul.rahim@intel.com,
 hector.blanco.alcaine@intel.com, hong.aun.looi@intel.com,
 khai.wen.tan@intel.com, faizal.abdul.rahim@linux.intel.com
Date: Mon, 13 Apr 2026 15:52:15 +0100
Message-ID: <20260413145215.718532-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409072747.217836-1-khai.wen.tan@linux.intel.com>
References: <20260409072747.217836-1-khai.wen.tan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1776092391;
 bh=ToPQhf+AU4et7lLAuA4KTwzfff0wXqHPucAzwkwJ6sY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TtW2TBS94vcUa9a4Ed7PcWrPV/FRaksQw2+2uT/VDXjTU7nqgp+KFWLTPRee+0gc5
 yvB4DOLk5RSddrYhq5YKFaGo4kGO4evnX4vGCfhrv6oe1ANV9EgFE6AQWFbm3ltNqT
 DabilfO/qj7VbMqv+W8TUF5tErjALJQHK4YRAuOvnhA84nSKkuo/fcBVMSI1srjBz1
 aGIV2+tIoq0GbZHnAALd64Wvj5n+Vat6IsDlxWFiYEmr2INVAkwbTYvN+PtBOLP2Gu
 f3nC/Ipd3gjo2civxcJrK0lYbr/IZLJJc4ipzTpiEJnbLf2IMo6q/ppcI27eKjL6aD
 keL1vs1jXFWOw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=TtW2TBS9
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 1/1] igc: add support for
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

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
igc: add support for forcing link speed without autonegotiation

This commit allows forcing 10/100 Mb/s link speed and duplex settings via
ethtool when autonegotiation is disabled. It configures the MAC CTRL and
PHY registers to bypass autonegotiation and apply the requested settings.

> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> index 0122009bedd03..e14771532dad8 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
[ ... ]
> +static int igc_handle_autoneg_disabled(struct net_device *netdev, u32 speed,
> +				       u8 duplex)
> +{
> +	struct igc_adapter *adapter = netdev_priv(netdev);
> +	struct igc_mac_info *mac = &adapter->hw.mac;
> +	enum igc_forced_speed_duplex forced_speed_duplex;
>  
> +	switch (speed) {
> +	case SPEED_10:
> +		forced_speed_duplex = (duplex == DUPLEX_FULL) ? IGC_FORCED_10F : IGC_FORCED_10H;
> +		break;
> +	case SPEED_100:
> +		forced_speed_duplex = (duplex == DUPLEX_FULL) ? IGC_FORCED_100F : IGC_FORCED_100H;
> +		break;

Does forcing a half-duplex configuration here also require setting flow
control to none (e.g., hw->fc.requested_mode = igc_fc_none)?

> diff --git a/drivers/net/ethernet/intel/igc/igc_mac.c b/drivers/net/ethernet/intel/igc/igc_mac.c
> index 7ac6637f8db73..16b0f2db06896 100644
> --- a/drivers/net/ethernet/intel/igc/igc_mac.c
> +++ b/drivers/net/ethernet/intel/igc/igc_mac.c
> @@ -452,7 +452,7 @@ s32 igc_config_fc_after_link_up(struct igc_hw *hw)
>  	 * so we had to force link.  In this case, we need to force the
>  	 * configuration of the MAC to match the "fc" parameter.
>  	 */
> -	if (mac->autoneg_failed)
> +	if (mac->autoneg_failed || !mac->autoneg_enabled)
>  		ret_val = igc_force_mac_fc(hw);

If mac->autoneg_enabled is false, igc_force_mac_fc() will configure the MAC
using the existing hw->fc.current_mode. If current_mode defaults to full flow
control, this will enable PAUSE frames.

Since autonegotiation is disabled, the MII status check further down in this
same function will fail and return early:

drivers/net/ethernet/intel/igc/igc_mac.c:igc_config_fc_after_link_up() {
    ...
    if (!(mii_status_reg & MII_SR_AUTONEG_COMPLETE)) {
        hw_dbg("Copper PHY and Auto Neg has not completed.\n");
        goto out;
    }
    ...
}

This early return skips the half-duplex safety check at the end of
igc_config_fc_after_link_up() which would normally clear the flow control
settings:

drivers/net/ethernet/intel/igc/igc_mac.c:igc_config_fc_after_link_up() {
    ...
    if (duplex == HALF_DUPLEX)
        hw->fc.current_mode = igc_fc_none;

    ret_val = igc_force_mac_fc(hw);
    ...
}

Does this leave the MAC incorrectly configured to send and receive PAUSE
frames on a half-duplex link, violating the IEEE 802.3 specification?
