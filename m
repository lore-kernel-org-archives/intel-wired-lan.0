Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C97BC4450A
	for <intel-wired-lan@archiver.kernel.org>; Thu, 16 Jul 2026 13:04:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D455C6087C;
	Thu, 16 Jul 2026 13:04:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aKcimpkJtQtm; Thu, 16 Jul 2026 13:04:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 98A4560872
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784207081;
	bh=HmGA/l7R5DgUHEUedngx1KpcsIvGqxoQmK+APT2PTsY=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AHw+3gejfaLzH+nKrGNCnS0Z6KSWXTSMiZfb7Ud6Vn0EQ3qXfDQVNRjyakvP399u4
	 44cAvqfE1vfbJc9VQy0PyeZPGgpi8u1ncoBgiHwhyulSwactYNMMyE0oNudkzQeM6m
	 5LPR6IHUoYxqefOdGCs/s4D3TAgcqYeUhglB5NBvTm+i5yGChV/0wqH4D5w4NtqXl/
	 mkyf5xKkyjpj+X4J+fHE+DiXtHO4R+TackOZSSkeSzPA2S8bj2m2Zbjv/dmXTwPnxH
	 bNdXDvVlHuI9+2z8ctgQg5luVB1uj6TN29jsW7LTf252rfPH0PT/4xVrQrhS2xvx74
	 OVJm1lNqPRQ8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 98A4560872;
	Thu, 16 Jul 2026 13:04:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 51EB3426
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 13:04:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 37EEA40309
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 13:04:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2H0fD31s3See for <intel-wired-lan@lists.osuosl.org>;
 Thu, 16 Jul 2026 13:04:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4B145402EB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4B145402EB
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4B145402EB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 13:04:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 74411600AF;
 Thu, 16 Jul 2026 13:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327D51F000E9;
 Thu, 16 Jul 2026 13:04:37 +0000 (UTC)
From: Simon Horman <horms@kernel.org>
To: sergey.temerkhanov@intel.com
Cc: Simon Horman <horms@kernel.org>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
Date: Thu, 16 Jul 2026 14:03:28 +0100
Message-ID: <20260716130327.311494-2-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260710105403.1050025-2-sergey.temerkhanov@intel.com>
References: <20260710105403.1050025-2-sergey.temerkhanov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784207078;
 bh=HmGA/l7R5DgUHEUedngx1KpcsIvGqxoQmK+APT2PTsY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Zs3qrtsJlip3dMi4X/wbqw64/UK6XMf54E46LQ/sltiK1EUY8CAjVZAqFOF/+bGfI
 dKI3mFZSf/twwY6HIVGItSOzqhDlG7loc+ufbCxV162Kx+VLmW4urhqOg4cjYATBv2
 XQTQzn+hET1/WWVf9H0Ib661f7Wr3S3rVtaYCo5Pe8iXKGA1ZYcqoecIu7KZI/37X6
 4rzw6myOuwjsKJhcC5C68vxrvuIeWWLyFmNs/AX0AuNj3R23tUXrzpxX1SB3al8vNF
 z6/a02InhUcpT6jUCj0o4a6LMfDixOfcQD/8E72Cto7nFg030cg4CEllgUhNy8AhwW
 aJzw6LK3F003w==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Zs3qrtsJ
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
Full review at: https://sashiko.dev
---
--- Patch [1]: [PATCH iwl-next v1 1/2] ixgbe: Refactor device operations to check whether netdev is available ---
commit f7037ec91fe4185b79d89bd64ec8042f9f9b1904
Author: Sergey Temerkhanov <sergey.temerkhanov@intel.com>

ixgbe: Refactor device operations to check whether netdev is available

Refactor several ixgbe driver operations to check whether the
netdev they operate on is enabled. This will allow the system
to get synchronized, for example, during the PCI resets.

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
> index 011fda9c61939..e4cd4673f21c2 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
> @@ -836,6 +836,10 @@ int ixgbe_fcoe_enable(struct net_device *netdev)
>  {
>  	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
>  	struct ixgbe_fcoe *fcoe = &adapter->fcoe;
> +	bool running;
> +
> +	if (!netif_device_present(netdev))
> +		return -ENETDOWN;
>  
>  	atomic_inc(&fcoe->refcnt);
>  
> @@ -845,12 +849,14 @@ int ixgbe_fcoe_enable(struct net_device *netdev)
>  	if (adapter->flags & IXGBE_FLAG_FCOE_ENABLED)
>  		return -EINVAL;

[Severity: High]
This is a pre-existing issue, but does this leak the FCoE reference count?

If ixgbe_fcoe_enable() is called when FCoE is already enabled or the adapter
is not FCoE capable, the function returns early without decrementing the
freshly incremented fcoe->refcnt.

Later, when ixgbe_fcoe_disable() is called, atomic_dec_and_test() will not
reach zero, causing it to return -EINVAL without freeing the FCoE DDP pool or
clearing the FCoE flags.

[ ... ]
> @@ -882,6 +888,10 @@ int ixgbe_fcoe_enable(struct net_device *netdev)
>  int ixgbe_fcoe_disable(struct net_device *netdev)
>  {
>  	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
> +	bool running;
> +
> +	if (!netif_device_present(netdev))
> +		return -ENETDOWN;

[Severity: High]
Does this early return cause a memory leak of the FCoE DDP pool?

During a hardware error or device hot-unplug, ixgbe_io_error_detected() calls
netif_device_detach(), which clears the device present state. When the
driver is subsequently removed, the FCoE stack catches the unregister event
and calls ndo_fcoe_disable().

Because the device is already detached, this new early return triggers,
causing the function to skip calling ixgbe_fcoe_ddp_disable(). Will this
abandon the per-CPU DDP pool so it is never freed?

>  
>  	if (!atomic_dec_and_test(&adapter->fcoe.refcnt))
>  		return -EINVAL;
[ ... ]
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 8873a8cc4a185..12361ed58a0ff 100644
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

[Severity: Critical]
This is a pre-existing issue, but does this error path leave a freed BPF
program installed in the active Rx rings?

If DCB is enabled on the interface, ixgbe_setup_tc() returns -EINVAL.
However, before returning, it calls ixgbe_open() to restart the interface:

ixgbe_setup_tc() {
        ...
        if (running)
                return ixgbe_open(dev);
}

During this restart, the Rx rings are initialized and assigned the new BPF
program currently stored in adapter->xdp_prog.

When ixgbe_xdp_setup() sees the error, it restores old_prog and returns
-EINVAL to the network stack, which then frees the new program. The
rx_ring[i]->xdp_prog pointers still reference the freed program. Can this
lead to a use-after-free?
