Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 330F2C4450A
	for <intel-wired-lan@archiver.kernel.org>; Thu, 16 Jul 2026 13:03:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DBCBD408FF;
	Thu, 16 Jul 2026 13:03:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YhZTo9f3thTQ; Thu, 16 Jul 2026 13:03:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E9638405A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784206996;
	bh=O9aVvhnwq9WKul5Dkcq9CyjN9SBNgRa/ma0xPwkkGkE=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J7a6aFNMtBWqWPbh88A2Rpq21aNF9uuEXpnRqyhPgxNg+/lUuu9p8YHEAOvR8PgvU
	 MFtbHg68qWtzMbHRpLOnsBtXHf6u12HrS8iRTEa0/NZphB3BP/wtQMGMZSuVlmISnc
	 oDMeRah0SMywOVWGfGnRNhCdUVRVOdrym5lSgWqgXhTt8J2467f85ziwIdxsQ5Fnpm
	 0/01MR0pV6gXmpYXww4+2UUPJr1d5WJLCw2sKHK1ZOeCEYc1BHmJlCP0W+jE/v5Z2T
	 2meK+lHVVrDaOi0h7LPQJ/2tZ0g4+DdgQK1ghkQJdVLDW+x5iHB+ve1NByvGwPUGD1
	 axRmHojFis+vQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E9638405A3;
	Thu, 16 Jul 2026 13:03:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D346426
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 13:03:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3EC4B60872
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 13:03:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4G4sih2I4fOr for <intel-wired-lan@lists.osuosl.org>;
 Thu, 16 Jul 2026 13:03:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6DFFC60871
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6DFFC60871
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6DFFC60871
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 13:03:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B8BC4600B0;
 Thu, 16 Jul 2026 13:03:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EA11F00A3A;
 Thu, 16 Jul 2026 13:03:10 +0000 (UTC)
From: Simon Horman <horms@kernel.org>
To: sergey.temerkhanov@intel.com
Cc: Simon Horman <horms@kernel.org>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
Date: Thu, 16 Jul 2026 14:02:55 +0100
Message-ID: <20260716130254.309674-2-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260710105403.1050025-2-sergey.temerkhanov@intel.com>
References: <20260710105403.1050025-2-sergey.temerkhanov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784206991;
 bh=O9aVvhnwq9WKul5Dkcq9CyjN9SBNgRa/ma0xPwkkGkE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JdMwkirZk3C46KYBxGoYkNhody/IT9qCqvP+ckPuTxsUxopWdv6ySzDjk128eXzwT
 R93Ao5AbCA2/zT+7F7OJkOnAdaJjkkRSfzksWAFO4FV3FXsqVdiZgnIhcgCiooe+Xb
 79tzIsFheA+UWrk2b2DdcNzZ1L4NH6Hbmq1iyPSLopkkYLVU4bHtc4mkefReAEhvQL
 h21OkZaSrUOVQZh1cx3Mf/sYVg0A/EPV5zIQIopJ8ob+TOkZdeXoMebC7Kd9NzC01J
 jG33hAJVkyJj5xZiSKuobny6xg2ptBOQcRAGnl06FzFE8lNZqsHM2U3Q9k9HUrAVaA
 uxixwtiv7gC0w==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=JdMwkirZ
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 1/2] ixgbe: Refactor
 device operations to check whether netdev is available
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

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
https://netdev-ai.bots.linux.dev/sashiko/
---
ixgbe: Refactor device operations to check whether netdev is available

This commit refactors several ixgbe driver operations to check whether
the netdev they operate on is enabled by introducing an ixgbe_netif_running()
helper and adding netif_device_present() guards across the ethtool, DCB,
FCoE and XDP code paths.

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 8873a8cc4a18..12361ed58a0f 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c

[ ... ]

> @@ -10954,8 +10958,10 @@ static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
>  			synchronize_rcu();
>  		err = ixgbe_setup_tc(dev, adapter->hw_tcs);
>  
> -		if (err)
> +		if (err) {
> +			xchg(&adapter->xdp_prog, old_prog);
>  			return -EINVAL;
> +		}
>  		if (!prog)
>  			xdp_features_clear_redirect_target(dev);
>  	} else {

[Medium]
The xchg(&adapter->xdp_prog, old_prog) rollback on the ixgbe_setup_tc()
error path looks like a semantic fix rather than a refactor.

Before this patch the error path left adapter->xdp_prog pointing at prog:

    old_prog = xchg(&adapter->xdp_prog, prog);
    ...
    err = ixgbe_setup_tc(dev, adapter->hw_tcs);
    if (err)
        return -EINVAL;

while the ndo_bpf caller dev_xdp_install() drops its reference on prog
when the driver returns an error:

    if (err) {
        if (prog)
            bpf_prog_put(prog);
        return err;
    }

Can this leave adapter->xdp_prog as a dangling pointer to a freed
bpf_prog on the pre-patch code, which is what the new xchg() restores?

The commit message describes only a refactor and does not mention this
change.

Should the xdp_prog rollback be split into its own patch with a Fixes:
tag pointing at the commit that introduced the missing rollback, per
Documentation/process/submitting-patches.rst which asks for one logical
change per patch?

The new behavior also skips the subsequent if (old_prog) bpf_prog_put(old_prog)
in the failure path, which is a separate semantic worth calling out in the
commit log.
