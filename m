Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF784CD3436
	for <intel-wired-lan@archiver.kernel.org>; Fri,  8 May 2026 13:31:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 76109613A2;
	Fri,  8 May 2026 13:31:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id exX1BNVN-FCC; Fri,  8 May 2026 13:31:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B25FB615DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778247104;
	bh=y8ibHP3Nov5Ykqxq9GpDd5L2rGCuKhmKCrkowaXfG5A=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZkZGAkbrfJJioEwbb4ooRz8enWG7hhQnwCdyk02LLJAoQ7Z6MqV6TELwyBT9OBnl8
	 FUOGj6OHq1PD5sdqLNn8abofAgJMik+Z7NK6+XoyWhIEQXkAl/tyuNbPYXIZ37hm8V
	 NPmRth8q1fEjSWVigyhxMV8NX6nV9+EVH6ukTBv1+AEeJJSeK8BYzagjyIe1C5NoAx
	 M3zXCO1JJ/XMyOQrNIL0T0HI8WR86hcbcztdmjcs/vdTqNbI6blU9RfqHsAYHeXy3j
	 uCDOGo8rz0Y2CRhBhW0A9UXs7phZa/rZlwR5UbsyeN9z0d6CJAF57YfXKk+XxKwnC8
	 L5+XqU9yE1HSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B25FB615DA;
	Fri,  8 May 2026 13:31:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5CAD0272
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 May 2026 13:31:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 42E7A41774
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 May 2026 13:31:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xwDDK07bRODU for <intel-wired-lan@lists.osuosl.org>;
 Fri,  8 May 2026 13:31:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6A7BA4176E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6A7BA4176E
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6A7BA4176E
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 May 2026 13:31:42 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 3626B6024D;
 Fri,  8 May 2026 13:31:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E98C2BCB0;
 Fri,  8 May 2026 13:31:37 +0000 (UTC)
From: Simon Horman <horms@kernel.org>
To: aleksander.lobakin@intel.com
Cc: 'Simon Horman' <horms@kernel.org>, intel-wired-lan@lists.osuosl.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kohei@enjuk.jp,
 jacob.e.keller@intel.com, aleksandr.loktionov@intel.com,
 nxne.cnse.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri,  8 May 2026 14:28:29 +0100
Message-ID: <20260508132827.1183079-3-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505152923.1040589-4-aleksander.lobakin@intel.com>
References: <20260505152923.1040589-4-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1778247100;
 bh=JxypbuWnNL/2mPFJRS9B0fB7VeJz/jcNnlNcUQF/xfE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=R2ja3fyrqJNqOj50SGTmCp06oLbtZHfnCUor/bUag/UUq45Nu0NzhDTaVd5mhMZAd
 S5DDU/B2LsLmDIYVf50FR16Tf/DCB2tO/DQq5ik51526R1Ba69lCXmneZpQPMvYlhw
 8Na9yXfKXyq/50mkMUzz8Q5ze+FbAoaYzxLRMx7borZck3uYCbX97Oo1MUUToJO7pM
 XgZgKPVITOvNCeQpw7vyv/BJcROF2VUUIQNJ16azFV8I2hB/lowbfRmUbcsr75RLje
 7LMq/hmWBtCW1NHT2w0grZq7D6+iTxM6FPTLvoKDh8VHmoM0ufiyvnEjovhvudHqX2
 ZXC8ElFqa4WEw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=R2ja3fyr
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v5 3/5] ice: migrate to
 netdev ops lock
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
    ice: migrate to netdev ops lock

This commit migrates queue management operations to use netdev locking.
It updates several NAPI and VSI configuration functions to use their
_locked variants to avoid deadlocks, taking the lock manually where needed.

> diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
> index 16aa255351523..7d89c0acc5d8d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
[ ... ]
> @@ -1107,7 +1106,7 @@ ice_dcb_process_lldp_set_mib_change(struct ice_pf *pf,
>  
>  	rtnl_lock();
>  	/* disable VSIs affected by DCB changes */
> -	ice_dcb_ena_dis_vsi(pf, false, true);
> +	ice_dcb_ena_dis_vsi(pf, false);
>  
>  	ret = ice_query_port_ets(pi, &buf, sizeof(buf), NULL);
>  	if (ret) {
> @@ -1119,7 +1118,7 @@ ice_dcb_process_lldp_set_mib_change(struct ice_pf *pf,
>  	ice_pf_dcb_recfg(pf, false);
>  
>  	/* enable previously downed VSIs */
> -	ice_dcb_ena_dis_vsi(pf, true, true);
> +	ice_dcb_ena_dis_vsi(pf, true);
>  unlock_rtnl:
>  	rtnl_unlock();
>  out:

This wasn't introduced by this patch, but does this error path leave VSIs
permanently disabled?

If ice_query_port_ets() fails, the code jumps to unlock_rtnl, bypassing the
call to ice_dcb_ena_dis_vsi(pf, true). This seems to leave the affected VSIs
(including the main PF interface) in a disabled state (ICE_VSI_DOWN) with
ICE_VSI_NEEDS_RESTART set, which could result in a denial of service.

> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> index 2e4f0969035f7..af0cc77fbf718 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> @@ -23,10 +23,16 @@ static int ice_eswitch_setup_env(struct ice_pf *pf)
>  	struct net_device *netdev = uplink_vsi->netdev;
>  	bool if_running = netif_running(netdev);
>  	struct ice_vsi_vlan_ops *vlan_ops;
> +	int ret;
> +
> +	if (if_running && !test_and_set_bit(ICE_VSI_DOWN, uplink_vsi->state)) {
> +		netdev_lock(netdev);
> +		ret = ice_down(uplink_vsi);
> +		netdev_unlock(netdev);
>  
> -	if (if_running && !test_and_set_bit(ICE_VSI_DOWN, uplink_vsi->state))
> -		if (ice_down(uplink_vsi))
> +		if (ret)
>  			return -ENODEV;
> +	}

Simon says: It seems that the topic of locks in this patch has come up
            again ¯\_(ツ)_/¯

Does manipulating the state bit outside of netdev_lock create a race
condition with interface teardown?

If the interface is concurrently brought down, ndo_stop (which holds
netdev_lock) would call ice_vsi_close(). Because ICE_VSI_DOWN is already
set by the test_and_set_bit() call above, ice_vsi_close() would skip calling
ice_down() and immediately proceed to free the Tx/Rx rings.

This would leave the hardware queues active and performing DMA operations into
freed memory, potentially causing a use-after-free.
