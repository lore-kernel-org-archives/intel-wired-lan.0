Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E57BFF8860
	for <intel-wired-lan@archiver.kernel.org>; Mon, 27 Apr 2026 16:43:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1AAAE80FB4;
	Mon, 27 Apr 2026 16:43:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ocrDLdWIMKLj; Mon, 27 Apr 2026 16:43:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4540C811FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777308194;
	bh=6NMzplX/z6JFceZNAIer9+Ya48FQkIVFvYJYuBHTqNY=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=we+Gf5KVN6/matb6lWxd9oSAv2gYuphxS2S6mEv7GhpjiiLC/i01E7EHErrvwCwMw
	 bJ9m16a8pZ1XZiP0Prm1zLYHYrTSJatzHSMEg9dvtkvUZj51d5Zfj7eJ+BAF6b1mTz
	 pbwzzbH191jdrR4KtAljda/p6bfjCfARk3eExNdyUiPuJiiz4U5pdeinTS8clOF+CM
	 4BE/0hvW2RAZkSJ7tIWexfb9pWaE73Cx6sdPVynNRz3JMkNKy/uZ03IdrVXzAmCx7D
	 S7FLReDjGiaUaA8bzQmGxscfLmgcpetoi+wcSXlpropQRFlUkTkGV7jAtlru6suAxU
	 0GeVDbPT1MfbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4540C811FE;
	Mon, 27 Apr 2026 16:43:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 85230231
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Apr 2026 16:43:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6B4734008A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Apr 2026 16:43:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s95_w8ISL7U3 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 27 Apr 2026 16:43:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9636240086
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9636240086
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9636240086
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Apr 2026 16:43:11 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id EFCF542B1E;
 Mon, 27 Apr 2026 16:43:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A9CC19425;
 Mon, 27 Apr 2026 16:43:08 +0000 (UTC)
From: Simon Horman <horms@kernel.org>
To: jtornosm@redhat.com
Cc: 'Simon Horman' <horms@kernel.org>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, przemyslaw.kitszel@intel.com,
 aleksandr.loktionov@intel.com, jacob.e.keller@intel.com,
 jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Date: Mon, 27 Apr 2026 17:25:48 +0100
Message-ID: <20260427162548.1221245-2-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423130405.139568-3-jtornosm@redhat.com>
References: <20260423130405.139568-3-jtornosm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1777308190;
 bh=sop+jYumr5WtvqsHY9B185SKGiwtvPmTo1JFw0Tpae8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uVfMjh1cSBeqXGQ1jpCQ9zi8y+sTNtFMx7uFJIqELSbHlu3wvQxMojZMmnqDmqbfI
 tFjd2V+4VIB0HgXqW1NBUPrSi6+cDpagxMVB+g47/MnI2pxC0xiASjCYRIbeTKkNJe
 MKCj29fZj+er3mkIukGaLhf9e4b776AdAPqs/T6DDrbkq66nQX4GZBi1XYd4G5S60z
 OLZXEVb4aXabZiunIscGt6OQBGWvSuQNwlaIJbRrhUD6keCnQ+OmH/W8rpdHDMMCT9
 NihTpn9E5yhPUptzF+iUMSD7arywiQ+u7rg+2jcqUHfvEIPsJz3yQyrqOeE1R3ICVz
 dbFc7rxsS052Q==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=uVfMjh1c
Subject: Re: [Intel-wired-lan] [PATCH net v4 2/4] i40e: skip unnecessary VF
 reset when setting trust
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
i40e: skip unnecessary VF reset when setting trust

This commit attempts to reduce the bonding setup delay by skipping the
synchronous VF reset when changing the trust setting, manually handling
the capability flag and promiscuous mode instead.

> When we do reset (ADQ case), we reset first to clear VF_STATE_ACTIVE
> (which blocks new cloud filter additions), then delete existing cloud
> filters safely. This avoids the race condition where VF could add filters
> during deletion.

Is this description accurate?

i40e_vc_reset_vf() is synchronous and restores I40E_VF_STATE_ACTIVE before
returning. When i40e_del_all_cloud_filters() traverses
vf->cloud_filter_list locklessly afterwards, the VF is already active again.

Could a concurrent VIRTCHNL_OP_ADD_CLOUD_FILTER message from the guest be
processed asynchronously and corrupt the list?

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index a26c3d47ec1561..26b62650aac9aa 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
[ ... ]
> @@ -4943,6 +4943,30 @@ int i40e_ndo_set_vf_spoofchk(struct net_device *netdev, int vf_id, bool enable)
>  	return ret;
>  }
>  
> +/**
> + * i40e_setup_vf_trust - Enable/disable VF trust mode without reset
> + * @vf: VF to configure
> + * @setting: trust setting
> + *
> + * Manually handle capability flag and promiscuous mode when changing trust
> + * without performing a VF reset.
> + * When reset is performed, this is not necessary as the reset procedure
> + * already handles this.
> + **/
> +static void i40e_setup_vf_trust(struct i40e_vf *vf, bool setting)
> +{
> +	if (setting) {
> +		set_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
> +	} else {
> +		clear_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
> +
> +		if (test_bit(I40E_VF_STATE_UC_PROMISC, &vf->vf_states) ||
> +		    test_bit(I40E_VF_STATE_MC_PROMISC, &vf->vf_states))
> +			i40e_config_vf_promiscuous_mode(vf, vf->lan_vsi_idx,
> +							false, false);

Does this pass the internal software array index (vf->lan_vsi_idx) instead of
the firmware VSI ID (vf->lan_vsi_id)?

i40e_config_vf_promiscuous_mode() uses i40e_find_vsi_from_id() which matches
against the firmware ID. Could this cause the lookup to fail and silently
leave promiscuous mode enabled on the hardware?

Also, should this clear the I40E_VF_STATE_UC_PROMISC and
I40E_VF_STATE_MC_PROMISC flags from vf->vf_states?

If an untrusted VF performs a valid operation like adding a new VLAN, could
i40e_vc_add_vlan_msg() check the uncleared state bit and automatically issue
an AdminQ command to re-enable promiscuous mode, bypassing the revocation?

> +	}
> +}
> +
>  /**
>   * i40e_ndo_set_vf_trust
>   * @netdev: network interface device structure of the pf
> @@ -4987,19 +5011,17 @@ int i40e_ndo_set_vf_trust(struct net_device *netdev, int vf_id, bool setting)
>  	set_bit(__I40E_MACVLAN_SYNC_PENDING, pf->state);
>  	pf->vsi[vf->lan_vsi_idx]->flags |= I40E_VSI_FLAG_FILTER_CHANGED;
>  
> -	i40e_vc_reset_vf(vf, true);
> +	/* Reset only if revoking trust with ADQ (for cloud filter cleanup) */
> +	if (vf->adq_enabled && !setting) {
> +		i40e_vc_reset_vf(vf, true);
> +		i40e_del_all_cloud_filters(vf);

Could this lead to a memory leak of the cloud filters?

The synchronous reset in i40e_vc_reset_vf() destroys the VF's VSI and
allocates a new one with a new firmware SEID. When
i40e_del_all_cloud_filters() executes afterwards, it looks up the VSI using
the old SEID from the filters, which might fail and cause it to skip the
free operation entirely.

> +	} else {
> +		i40e_setup_vf_trust(vf, setting);
> +	}

By skipping the reset when revoking trust for non-ADQ VFs, do we leave excess
hardware filters intact? Trusted VFs can configure MAC and VLAN filters
beyond standard limits. Without a reset to flush them, does the untrusted
VF retain its configured spoofed MAC addresses and excessive VLANs
indefinitely?

Furthermore, when granting trust, skipping the reset prevents sending the
VIRTCHNL_EVENT_RESET_IMPENDING event to the guest. Since virtchnl VF drivers
negotiate their capabilities and resource requests during initialization,
does this mean the guest driver remains unaware of its newly granted
privileges until the interface is manually restarted?

> +
>  	dev_info(&pf->pdev->dev, "VF %u is now %strusted\n",
>  		 vf_id, setting ? "" : "un");
>
