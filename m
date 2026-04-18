Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2F7F99C88
	for <intel-wired-lan@archiver.kernel.org>; Sat, 18 Apr 2026 16:52:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 23B4240F76;
	Sat, 18 Apr 2026 16:52:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xn_RHZpyooB0; Sat, 18 Apr 2026 16:52:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A06E440F70
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776531128;
	bh=lJT6eUZ8/0wb0gv+fWpBt8xji6v9X7XIoCnYmfmk5Gg=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NnXNTFeYayGHe3M/udpHM0hNH3a+NCTBrcS1RBs5cIskgsAVgQdzPGjnYTHVeKr1Y
	 3MN+gzQ8Utn26mLrLRajB4nz3G0QIEpBLJ+KY4TjFeJpAvotlwpfS5bEZyygg4Oj+E
	 GEbzufvN3DMOYA/pKmS1qS2ghRB7kP7FeaQyK51hAz+cX1JgGOjFdq9Av8xywb3JjW
	 GjmKaaw5TN7CHYmT7kfQeDLMHa9U6kOoqIgZxoeajiyoiwEar6u6cbOikgh0t1UA6X
	 C7Av5ehRLp4v53DOrc3X3hhCiJawVXaxhaoDTmqsP2fDdTAjfuyvH7RFzxoqdc/ZfC
	 eZ5Ns7hrfxtUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A06E440F70;
	Sat, 18 Apr 2026 16:52:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 77E2A259
 for <intel-wired-lan@lists.osuosl.org>; Sat, 18 Apr 2026 16:52:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5DD5440F70
 for <intel-wired-lan@lists.osuosl.org>; Sat, 18 Apr 2026 16:52:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MEiJEYzwKfkm for <intel-wired-lan@lists.osuosl.org>;
 Sat, 18 Apr 2026 16:52:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 60A0D40F6C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 60A0D40F6C
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 60A0D40F6C
 for <intel-wired-lan@lists.osuosl.org>; Sat, 18 Apr 2026 16:52:06 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 8AE7360138;
 Sat, 18 Apr 2026 16:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB15C19424;
 Sat, 18 Apr 2026 16:52:00 +0000 (UTC)
From: Simon Horman <horms@kernel.org>
To: khai.wen.tan@linux.intel.com
Cc: 'Simon Horman' <horms@kernel.org>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, faizal.abdul.rahim@intel.com,
 hong.aun.looi@intel.com, khai.wen.tan@intel.com,
 faizal.abdul.rahim@linux.intel.com
Date: Sat, 18 Apr 2026 17:48:38 +0100
Message-ID: <20260418164837.380985-2-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416015520.6090-4-khai.wen.tan@linux.intel.com>
References: <20260416015520.6090-4-khai.wen.tan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1776531124;
 bh=XMTZj1YxPkY22L6vssswSQjk4oTxVG3RPZgGbSOfif8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rKzdxscKKp1giWSsuSCO3jKQUC4b8sL/u/GsH00AIPnDBiOFJoqb+6gaZ64Cr6ODv
 K4N1QExtkRpDDRwGOlvYHPsn+kQOOUeOFYwtQza7gw7DCyUCcQQltn08GGsU8FNvX9
 XFH4j7PYOg+Mg4sCJDgKFHcgbadra4WCrK94J4fAkuf8JCj0ow8UCP1ehX1OCtAgT/
 dSf1NBAr93ssqP8u0Z7P8dOZ1mFG3FAivCr/GSgm2zRV8CJE4MpIsnM1ATPPng9N68
 xtinbU1VIwcPW6/o2Jqq708tUrlauGyQ7aipfDdgZ4LnQrCcJG7lco/Bhk63vOq04c
 TZ5P6Z7j6yNsg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=rKzdxscK
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 3/3] igc: add support for
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

This commit adds support to allow users to force 10/100 Mb/s link speed
and duplex via ethtool when autonegotiation is disabled.

> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> index cfcbf2fdad6ea..5bd37d1be1688 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c

[ ... ]

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
> +	if (duplex == DUPLEX_HALF)
> +		adapter->hw.fc.requested_mode = igc_fc_none;
> +}

If userspace issues an ethtool command without specifying duplex, the duplex
value can be DUPLEX_UNKNOWN. In this case, forced_speed_duplex correctly
defaults to half-duplex since duplex == DUPLEX_FULL evaluates to false. 

However, since DUPLEX_UNKNOWN is not equal to DUPLEX_HALF, the check above
fails, and the requested flow control mode remains unchanged. Could this leave
flow control enabled on a forced half-duplex link, violating IEEE 802.3?
Should this check be based on the resolved mac->forced_speed_duplex state
instead?

[ ... ]

> @@ -2071,14 +2120,20 @@ igc_ethtool_set_link_ksettings(struct net_device *netdev,
>  		}
>  	}
>  
> +	if (cmd->base.autoneg == AUTONEG_DISABLE &&
> +	    cmd->base.speed != SPEED_10 && cmd->base.speed != SPEED_100) {
> +		netdev_info(dev, "Unsupported speed for forced link\n");
> +		return -EINVAL;
> +	}
> +
>  	while (test_and_set_bit(__IGC_RESETTING, &adapter->state))
>  		usleep_range(1000, 2000);

This isn't a bug introduced by this patch, but does this ad-hoc
synchronization using bit flags circumvent proper locking guarantees? The
networking subsystem guidelines forbid using bit flags as ad-hoc locks. 

Using a bit flag in a polling loop bypasses lockdep analysis, fairness, and
strict memory ordering. Could this be replaced with a real synchronization
mechanism like a mutex?
