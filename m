Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9BBC624D6
	for <intel-wired-lan@archiver.kernel.org>; Sat,  5 Sep 2026 16:47:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6EDE760604;
	Sat,  5 Sep 2026 16:47:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IhNl1XqiPtS0; Sat,  5 Sep 2026 16:47:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BD5CD605FA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788626826;
	b=CNUQY1pnS9g/vSgRMPcfvlObOlVXmnVCpm8wRSTyA+W3ZnG9pvCzCLugtG3O6xdNzwj0
	 mFQ7HVptWjCVSzWAarZ4FNM+zGH1/6/NQmo6tOaEkZDJR7T/n2NoeZ8wiwQodAhonisto
	 CmVavCmD/UMzCkp+R34E7qICpCYu1GD5d7EIx84LoylrzoXe2vfTbAT6S1Ao5fPYbZwPA
	 9O9F6260Iko9OvXEORiveIbXQMNcEByw9tnSth9efDLHIyDTnAU20tS6n9z/Cyn4xxUrs
	 Dsb+fvXj6+xHj0ttw6+QXt8TQy4yOYkmMfRnBSYVjSleOn+x69T4hFI8bPF9J4zgJ3Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788626826;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9Tjn9kv1hxb46aSkL0y6J6BeizBOSInInYI9R08z21U=;
	b=ANJdcz3tvIrNkGrCG2r8Prf4B+8HLX0raAscLWuAYhd8kQ+pMRe5lnkgU66TS+H6kRui
	 XHPFV1vENqK7sXkMIpQxlsH7d0Rt8kUaUA3HBZ/gwAuq3ThP+XqVQ8/qMljvLm7rwVMQK
	 CVzeec2vKSwc/pwQp3HG+1C8g2fiKe4w24rJI2iI4bqDtlHxFbeGCcmXwnK9xhIUbOaJN
	 D+DsJnOpsQYazQQ5rQ2PDu3H2h4fFXiRGwwi87ZoMoo0WOo5oqqqGKf27GzmuVSH5uXOR
	 USljKJU1RpmdiOPambsVndD/VtNkJ8kTqcMtrk67qZhiaiRKVcugzhnq1VHAD1gZS4w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788626826;
	bh=9Tjn9kv1hxb46aSkL0y6J6BeizBOSInInYI9R08z21U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VvuC4yjPDX0hon0vemBXj8ezYuq4M37prt4ncDKZ5nM9uB9sM0OLNQFAgHGvh5wrL
	 uCWOkOVHAOitAOCo0QOs464zYwWh0vapeqkJeT3kn1uF6tz2VqgK2jsBQqYmMCAwF8
	 8dO2yN+TIUSugD5kLytoR6Deel9SYf7LRsGw3UtjV595AC5ZaVpo0TVpPMca6+r2ym
	 xL/k9pBSyY5qg1rQtsbhPbvKv6YDYYqlhczwc1ZfeP2fqud6rO+hJcTXVQYJUxe7VA
	 xY2orlnWgLO4A3E0tnvZ2YBR314ecqR8PjbcWsgbIq9jmqMn+sfKK73VjQFY/CoKJz
	 U9LPaOZGZfFgg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD5CD605FA;
	Sat,  5 Sep 2026 16:47:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 25E44B88
 for <intel-wired-lan@lists.osuosl.org>; Sat,  5 Sep 2026 16:47:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0C61D40AEF
 for <intel-wired-lan@lists.osuosl.org>; Sat,  5 Sep 2026 16:47:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oD5RyxqhyAIK for <intel-wired-lan@lists.osuosl.org>;
 Sat,  5 Sep 2026 16:47:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1677A40AE9
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788626824;
 b=qE7YkFxM6rOD1qpbhhjYyl9f4LD10H0DgKbh4XlPs7zJnjhtnyMMAiDLLEKHc+zaPjgQ
 UjsJJ8ElK9nzOTGMLZ1RT+ITjVHt+VWDuz8cMCjFu7CcUHKdTTjhzQZa9feGUgU0sAbnz
 FNu4kyHaAxl1AsjYG4qRXSSxy/fZzLwp6RarFfeWVY4MGvkGKGAKaKCYis9rgkHOKppKL
 WdZ/UtzIBpgcSicazK3Z/HI1EBCCeA90Oy2XwmPJxJoJk3DgEN/KyPNu+0z8L/55SSbiG
 RQYkpNXiYynNeOlNm5TsU45V4hX9u7TGEcf4oCPjXB+xHkzm/rbV2ATspUpcGpypkng==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788626824;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=9Tjn9kv1hxb46aSkL0y6J6BeizBOSInInYI9R08z21U=;
 b=iWZQ9Qk04wCYXOLVh+EwRxoBQnvdR24MOQ8KzJdNGV3dRXTdd0i7FSvWi8JRAIfS/gNO
 SGZTLCX3yNcb1A3/eNVADmi+WzsBxvNAA5M2XbjahqdTKDMrzC1ES8TZmTNyqBHoO4MyY
 7tnMU+rlMEFJ+AD5fo9kNW8pTuaID8Z2tZlhGW5YFJSNy2XRjxva1okI42be6FoE060qp
 /A2eKOfoFPyMoPeL2Qh3kunHjN5t+t1vAJfd7FL+4He7bZDQ2dKYz85XIKGnOWXbCTqbs
 SnIixFE+ti2HMx8rJBT5P/ljGGkYnmJtaEL912J0g2nITsX6U72xvps4IufCJbKRC+Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=EqWNb3ED; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=EqWNb3ED
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1677A40AE9
 for <intel-wired-lan@lists.osuosl.org>; Sat,  5 Sep 2026 16:47:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0D6D4601DB;
 Sat,  5 Sep 2026 16:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D49D1F00A3A;
 Sat,  5 Sep 2026 16:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788626821;
 bh=9Tjn9kv1hxb46aSkL0y6J6BeizBOSInInYI9R08z21U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=EqWNb3EDnTcI/6DXDaeNxh+n9tWBIOmuE79v9CqJiW7vZmVLJS0Csma4b1BSDMe8k
 Xu1ytVRnn7IaAZfzUj8de2kGCMDaU7ldImjVvXmpkMeSWT2epjINvzT2cZanX4wsbc
 5MLbok9cMNj3WL1IKu3bmlpWgM3KHxgD3a3voYC7qRj0ErjaBvIhTgwcDhGlvdcf4R
 G4kr169I4qnchlarD22vurO7zrhYMhlnV3/MxRXCgtcX/vCNNHULV4TM81nSinfiFA
 FLGLlbcylN0HfXnUps+8y/unif3IzWQkfiGJ1XSQ5FE4mTgpqPK0ivupjersDavtrG
 BYXaYUU0gfUvQ==
Date: Sat, 5 Sep 2026 17:46:57 +0100
From: Simon Horman <horms@kernel.org>
To: Aaron Ma <aaron.ma@canonical.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Henry Tieman <henry.w.tieman@intel.com>,
 "moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>
Subject: Re: [PATCH 2/2] ice: clear Flow Director entries before reset cleanup
Message-ID: <20260905164657.GB40544@horms.kernel.org>
References: <20260903074706.602087-1-aaron.ma@canonical.com>
 <20260903074706.602087-2-aaron.ma@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903074706.602087-2-aaron.ma@canonical.com>
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

On Thu, Sep 03, 2026 at 03:47:06PM +0800, Aaron Ma wrote:
> Flow Director profiles retain handles to generic flow entries. Reset calls
> ice_clear_hw_tbls() to free those entries, but leaves the Flow Director
> handles unchanged until replay replaces them.
> 
> If rebuild fails before replay completes, later driver removal follows a
> stale handle and dereferences a freed flow entry in ice_flow_rem_entry().
> KASAN reports a wild access to list poison from
> ice_fdir_erase_flow_from_hw().
> 
> The failure is reported as:
> 
>   KASAN: maybe wild-memory-access in range [0xdead000000000108-...]
>   RIP: ice_flow_rem_entry+0xaf/0x170 [ice]
>   ice_fdir_erase_flow_from_hw+0x1ee/0x420 [ice]
> 
> Clear the Flow Director handles before the hardware tables free their
> entries. A successful replay installs new handles, while a failed rebuild
> leaves them invalid for later cleanup.
> 
> Fixes: 148beb612031 ("ice: Initialize Flow Director resources")
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |  1 +
>  .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 21 +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_main.c     |  2 ++
>  3 files changed, 24 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index db3c7015c56c4..4739ff882b9ec 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -1029,6 +1029,7 @@ ice_get_fdir_fltr_ids(struct ice_hw *hw, struct ethtool_rxnfc *cmd,
>  		      u32 *rule_locs);
>  void ice_fdir_rem_adq_chnl(struct ice_hw *hw, u16 vsi_idx);
>  void ice_fdir_release_flows(struct ice_hw *hw);
> +void ice_fdir_clear_flow_handles(struct ice_hw *hw);
>  void ice_fdir_replay_flows(struct ice_hw *hw);
>  void ice_fdir_replay_fltrs(struct ice_pf *pf);
>  int ice_fdir_create_dflt_rules(struct ice_pf *pf);
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
> index aceec184e89b2..faa16b5a12c0d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
> @@ -428,6 +428,27 @@ void ice_fdir_release_flows(struct ice_hw *hw)
>  		ice_fdir_erase_flow_from_hw(hw, ICE_BLK_FD, flow);
>  }
>  
> +/**
> + * ice_fdir_clear_flow_handles - clear handles freed during reset
> + * @hw: pointer to HW instance
> + */
> +void ice_fdir_clear_flow_handles(struct ice_hw *hw)
> +{
> +	int flow;
> +
> +	for (flow = 0; flow < ICE_FLTR_PTYPE_MAX; flow++) {
> +		struct ice_fd_hw_prof *prof = hw->fdir_prof[flow];
> +		int tun, i;
> +
> +		if (!prof)
> +			continue;
> +
> +		for (tun = 0; tun < ICE_FD_HW_SEG_MAX; tun++)
> +			for (i = 0; i < prof->cnt; i++)
> +				prof->entry_h[i][tun] = 0;
> +	}
> +}
> +
>  /**
>   * ice_fdir_replay_flows - replay HW Flow Director filter info
>   * @hw: pointer to HW instance
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index a97a1941cec6a..7aa1235447310 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -601,6 +601,8 @@ ice_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
>  		netif_device_detach(vsi->netdev);
>  skip:
>  
> +	if (hw->fdir_prof)
> +		ice_fdir_clear_flow_handles(hw);
>  	/* clear SW filtering DB */
>  	ice_clear_hw_tbls(hw);
>  	/* disable the VSIs and their queues that are not already DOWN */

Hi Aaron,

There is an AI-generated review of this patch available at
https://sashiko.dev/#/patchset/20260903074706.602087-1-aaron.ma%40canonical.com?part=2

Of that review, the following seems relevant.
And I'd appreciate it if you could comment on it.

  Does calling ice_fdir_clear_flow_handles() here modify prof->entry_h
  locklessly from the reset task?

  If an ethtool command to add or remove a Flow Director rule executes
  concurrently with a PF reset, ice_add_fdir_ethtool() checks the reset flag
  locklessly and then acquires hw->fdir_fltr_lock. Can this result in a data
  race if the reset worker clears the array without holding the lock while the
  ethtool thread updates it?
