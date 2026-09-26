Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C4DC9832F
	for <intel-wired-lan@archiver.kernel.org>; Sat, 26 Sep 2026 17:05:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9259681180;
	Sat, 26 Sep 2026 17:05:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NOGl1GaTTnFn; Sat, 26 Sep 2026 17:05:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E836A81166
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790442352;
	b=ptcjfBrLWDiEFtpKudw9EW5g/t/b5ltJgr5s+sHK+P1uV9DID4//rd/NV64qgTx614b0
	 iZTHQJ89jUdW8QmgVdFteU4WFkh42HFtX6rgIczryXMNc1o/l/9Z+OjOXXHOg55My2iKR
	 mkpigRrMAd6MYPMKMY+YpTfrfCCaOOnUO6QZB8PjHkqkUiLZLdBrlEvpOvVgZWHJdzkp4
	 N/M8CK6O5QexmLrnxT5aLkporbYNiT4LK1im/rnVKqYAeEdoMZlD6ykHwFVrmzpT5rxaS
	 ydz80rqq/QhxrYRvdym6vxBvoKxa4bU6wZpLPGcgEjOxmoplR+y9w0rSPD+fINB8lSQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790442352;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fFbDQ/pAVTasBkqneTF+ptvM2577UUi5vrtaUdplXRs=;
	b=K2+zo6ff8Hd1hdtjLpOoHQ+rExQmdwONBchGKlQ4VEczxYuc+MpIvHWBPFy4SUzl1wTH
	 H8Xh53T9zLqbBq8EVbGRzdg11zIc/xvAAN3fG67LoqERKa3a7yzo35xMR1cT9AzO+JHQL
	 iDMmquSGuZdiVZWiEFFCUg3crs6x8MpSAFJb/tKMhElxT3ANXTjXFmcTsZ6sP8ernIxR4
	 LQ1XmOL+Tb2ku/P78Tz6LhA0/lhKDXagtFBTRQzSMRXFVei5cOfqXJpz0DHkxoR8AdGTN
	 7319xMGwY1n5J0CqC7Ffj1Qiownd5qBTUoYGAXxFGdVIKXkYfKoXcJMM/JbPX3eIlaQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BVRdVYlD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790442352;
	bh=fFbDQ/pAVTasBkqneTF+ptvM2577UUi5vrtaUdplXRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uVvNZTczICrxznuDlwxO6pKiCH76LprnF4/aqyasCB1vC2Sj/QQuRJzNY+OIMlsPa
	 BZd9m3rggSSZfBnuW+d2Gwhus1g61SfGpkNMjzChAt9sRTmIoIGuUuZxxTHgkev/9G
	 LLJ0K435nd/fsOyYvDef5zCbsMouGoyE4uixTHo8xRKlcQxv1M9hQ9HLW/B9zfCjeO
	 lry5UL4Ta3fWvmS96QRRygfmFG5GrnRLc0VYROdMmvIOXSprELTjxGOBW5cw5jMGo3
	 PCJC9+jImHwWWN571Kxsq0vXDspBHZODf8mgf8EsWghA+tmQ8mG3ghUNrlxOYeAMOb
	 j4bFpL2xhjP6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E836A81166;
	Sat, 26 Sep 2026 17:05:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4DF85194
 for <intel-wired-lan@lists.osuosl.org>; Sat, 26 Sep 2026 17:05:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 341A6810DD
 for <intel-wired-lan@lists.osuosl.org>; Sat, 26 Sep 2026 17:05:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cV1H5rVLqFog for <intel-wired-lan@lists.osuosl.org>;
 Sat, 26 Sep 2026 17:05:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 776B581166
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790442349;
 b=Gvb5ckQtyQJmK9L53Jxg8NxgHFbYPFT5ipOPCw5gVEwnZggegV9paW3G5lF/UFZeB7b9
 4tUGsyC42y5tt+Z5ZH75+IStWmhvwr8gluWR4yDrgInAvx7BtxA5rc4skdi3t/aZOPHHl
 iKwS9uQTeSPJEW5OY8iNNfz6qyiA7UmHC3scT0FjqmrBtfNlAlL/qljeIct3tB7hP5nU9
 RfMSmaPtic2yLraLSidOiiGQo7VqOqYX5R4Tdh8FGM069vMtNIap30e2c1qkWqVv+nB+m
 4HvLKi4XDBqPSyikMn9CedxHqmvKCUIhUrqlU431ApY5AqTh/cbgyRfhH/BI3Dtdv/w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790442349;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=fFbDQ/pAVTasBkqneTF+ptvM2577UUi5vrtaUdplXRs=;
 b=OODx1cs/ovWU/iedcSprTSvlPXaQaBvwdNXUQXbhzHP4PZdzp8PRKdp8x9035ihfnSoh
 MMNFBLSkG1kxLG1+O5gUp5SF4tF3o/39s1YVWvh7TlSoEeZRA8uqaFzt4EWVb/blHtwmY
 I4AyHtYEyzHpOlJL49yu1aOFQMH4b2R7q8Gas7pqMhhElpDuUad5VlQMWBL2izdS0UD4V
 mWfKTH1Rl2CZGr/10c5Hdugmt4WIub/nb72MBvTdkeNTVmn/71fwunshVs61taxDu+MaP
 K5JUARokxeM97iYaYTgZtjYLm/vi8KT/OixxxaLDYsheyFc9mUGs0bd3rQpxhEVprRA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=BVRdVYlD; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=BVRdVYlD
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 776B581166
 for <intel-wired-lan@lists.osuosl.org>; Sat, 26 Sep 2026 17:05:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AB2054353C;
 Sat, 26 Sep 2026 17:05:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F284C1F000FF;
 Sat, 26 Sep 2026 17:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790442348;
 bh=fFbDQ/pAVTasBkqneTF+ptvM2577UUi5vrtaUdplXRs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=BVRdVYlD4uBJU6KfOfgmSvlMq1D+hUmGeTK5GH/5K/NInQ1zYwx/Gj2/ogL6AZgxX
 elFpUrfNvJHJVajxCm1UyhergmnUS5ge/KbMFRTxLHHpSOmq9DO630Yq/X19xn61kq
 qhnZ47QTiuGZ3L5f1Kv0svOsVLthetP3x4IdeadIv/Ozl4ZZzzO5N2nN1YAiGFbRAV
 wj9HPGGeDbhV3ZD2c4YjRQwNwiSBUNNBlQzMbDOqw13QRBkdkNUIDEcDXNNbi342jG
 EbX4RO+zjWlRpdiQT7SfQhvESadlCaog+ZcnU5hLIN7Qg/DXjP7lY25OZta3kgXnyU
 gvU+/So1Q4gKA==
Date: Sat, 26 Sep 2026 18:05:43 +0100
From: Simon Horman <horms@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, przemyslaw.kitszel@intel.com,
 anthony.l.nguyen@intel.com, arkadiusz.kubalewski@intel.com,
 davem@davemloft.net, edumazet@google.com,
 Maciek Machnikowski <maciej.machnikowski@intel.com>,
 Marc Neustadter <marc.neustadter@intel.com>,
 Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
 Milena Olech <milena.olech@intel.com>
Subject: Re: [PATCH iwl-net 1/2] ice: ptp: serialize E825 PHY timer start
 with PTP lock and incval
Message-ID: <20260926170543.GA13925@horms.kernel.org>
References: <20260925222824.270640-1-grzegorz.nitka@intel.com>
 <20260925222824.270640-2-grzegorz.nitka@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925222824.270640-2-grzegorz.nitka@intel.com>
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

On Sat, Sep 26, 2026 at 12:28:23AM +0200, Grzegorz Nitka wrote:
> From: Maciek Machnikowski <maciej.machnikowski@intel.com>
> 
> ice_start_phy_timer_eth56g() programmed the PHY increment value and
> performed the PHY-to-PHC phase synchronization in two separate PTP
> semaphore critical sections, and touched the shared source command
> register (GLTSYN_CMD via ice_ptp_src_cmd()) and read the source incval
> before acquiring the semaphore at all.
> 
> Because GLTSYN_CMD is a single global register latched for the source
> timer and all PHY ports by GLTSYN_CMD_SYNC, a concurrent adjtime (small
> offset, <= S32_MAX) or adjfine could clobber the source command between
> the incval-init and the phase-sync steps. In the worst case the source
> timer command written by ice_ptp_adj_clock() (ICE_PTP_ADJ_TIME) was
> overwritten by the unlocked ICE_PTP_NOP from ice_start_phy_timer_eth56g(),
> so the adjustment was applied to the PHY ports but not to the PHC. This
> left the E825 PHY clock permanently offset from the PHC, showing up as an
> intermittent clock drift.
> 
> Hold the PTP semaphore across the entire start sequence: acquire it
> before the first shared-register access (ice_ptp_src_cmd()), keep it held
> through the incval read, PHY incval init, and the phase synchronization,
> then release it once. Since the hardware semaphore is not recursive, split
> the phase-sync helper into ice_sync_phy_timer_eth56g_unlocked(), which
> assumes the caller already holds the lock, and call it directly from
> ice_start_phy_timer_eth56g(). The locking wrapper is removed as it no
> longer has any callers.
> 
> Fixes: 781ff8f2d575 ("ice: ptp: serialize E825 PHY timer start with PTP lock")
> Signed-off-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
> Co-developed-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Suggested-by: Marc Neustadter <marc.neustadter@intel.com>
> Reviewed-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Milena Olech <milena.olech@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 48 +++++++++------------
>  1 file changed, 21 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index 20bd1813650f..d3e4aeb7e496 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> @@ -2045,7 +2045,7 @@ static int ice_read_phy_and_phc_time_eth56g(struct ice_hw *hw, u8 port,
>  }
>  
>  /**
> - * ice_sync_phy_timer_eth56g - Synchronize the PHY timer with PHC timer
> + * ice_sync_phy_timer_eth56g_unlocked - Synchronize the PHY timer with PHC timer

nit: I'm not entirely sure renaming the function is warranted.
     But it's your call.

>   * @hw: pointer to the HW struct
>   * @port: the PHY port to synchronize
>   *

...
