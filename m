Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32FBC27C6E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 14 Jun 2024 12:43:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 699FD40325;
	Fri, 14 Jun 2024 12:43:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QBW1XMHyIBjt; Fri, 14 Jun 2024 12:43:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4F9CE403DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1718369024;
	bh=rLH6X80kRgj8PpuNaI+Y65N6lqAbLLzxcen7XpYwgYY=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Ua7lZTxGcuYgcbKNTJR0kGtlPN3asGFmJMqvhLGAkILKR0sKZ/v7aPq5ernRbT1Oq
	 0rGzQTH8G5O+/sL+ucQWJtOwIDa90CK3EQCVQdTC+uDB4EdNGVdvpt9iKM007PfweM
	 YLrRuvhxZqvOMUU7vqEKq1+Ku4j76/sjofScIzNvnNiV0ReeYzqzr/qCTQTouRq1Th
	 cpc/IrpilSSsQwyY4ITQYd8uBt86AGgpRmq5GOGDpYeHeSsyJq+0uYOL5SpXDRdXX4
	 HuBWOVY2EfM/I3kPn4PmiMufrp96Z8HgVFj7Rj/aGssA8TVG7tj/ZlDZSwm/SG85Ji
	 3+th7SJ0NArOw==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4F9CE403DB;
	Fri, 14 Jun 2024 12:43:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id A997D1BF33C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Jun 2024 12:43:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9536240511
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Jun 2024 12:43:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V0QRni8g35ms for <intel-wired-lan@lists.osuosl.org>;
 Fri, 14 Jun 2024 12:43:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 451A1403DB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 451A1403DB
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 451A1403DB
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Jun 2024 12:43:41 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id DA981CE1F3B;
 Fri, 14 Jun 2024 12:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C4FC2BD10;
 Fri, 14 Jun 2024 12:43:33 +0000 (UTC)
Date: Fri, 14 Jun 2024 13:43:31 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Message-ID: <20240614124331.GL8447@kernel.org>
References: <20240610074434.1962735-1-michal.swiatkowski@linux.intel.com>
 <20240610074434.1962735-4-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610074434.1962735-4-michal.swiatkowski@linux.intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1718369016;
 bh=uDzve8H3dCkfmELZWZLzl/N50oTljXg6cmrTDCRiAg4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=r8uwoXucf1fwVkVi307nyKhhdTzCq4AHD5QRmjBGM3iLnf9eFT0mxyP7ZuK9i+/jO
 S1HGT3eRqly1Xt5Ce30MYr49SiqoVLMRyLphbrxpN9dLwQRuzUnM9mbU+vr8xLU7P/
 j6dfw/oZzIBk96b3E0f/s8xci/fbDlZrheQYMqqTTfZpcOjYqTn8a/aQlYLDw+JpKU
 14BdAW8XL3EzB+xh84p5NnStwqIhTfMH5O7HiVKIQoQcvwfbb/WWSxI25UZhmhq8Ma
 7VKOp5gmIDGzLHv2S62Ozqv9UF6tzFjki4bIJxm8nwEpnUJjweI7fRRhX6gyZmaJBh
 ugRLPSJ35DtSQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=r8uwoXuc
Subject: Re: [Intel-wired-lan] [iwl-next v3 3/4] ice: move VSI configuration
 outside repr setup
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: shayd@nvidia.com, maciej.fijalkowski@intel.com,
 mateusz.polchlopek@intel.com, netdev@vger.kernel.org, jiri@nvidia.com,
 kuba@kernel.org, michal.kubiak@intel.com, intel-wired-lan@lists.osuosl.org,
 pio.raczynski@gmail.com, sridhar.samudrala@intel.com, jacob.e.keller@intel.com,
 wojciech.drewek@intel.com, przemyslaw.kitszel@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, Jun 10, 2024 at 09:44:33AM +0200, Michal Swiatkowski wrote:
> It is needed because subfunction port representor shouldn't configure
> the source VSI during representor creation.
> 
> Move the code to separate function and call it only in case the VF port
> representor is being created.
> 
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Hi Michal,

The nit below notwithstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/ethernet/intel/ice/ice_eswitch.c | 55 ++++++++++++++------
>  drivers/net/ethernet/intel/ice/ice_eswitch.h | 10 ++++
>  drivers/net/ethernet/intel/ice/ice_repr.c    |  7 +++
>  3 files changed, 57 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> index 7b57a6561a5a..3f73f46111fc 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> @@ -117,17 +117,10 @@ static int ice_eswitch_setup_repr(struct ice_pf *pf, struct ice_repr *repr)
>  	struct ice_vsi *vsi = repr->src_vsi;
>  	struct metadata_dst *dst;
>  
> -	ice_remove_vsi_fltr(&pf->hw, vsi->idx);
>  	repr->dst = metadata_dst_alloc(0, METADATA_HW_PORT_MUX,
>  				       GFP_KERNEL);
>  	if (!repr->dst)
> -		goto err_add_mac_fltr;
> -
> -	if (ice_vsi_update_security(vsi, ice_vsi_ctx_clear_antispoof))
> -		goto err_dst_free;
> -
> -	if (ice_vsi_add_vlan_zero(vsi))
> -		goto err_update_security;
> +		return -ENOMEM;
>  
>  	netif_keep_dst(uplink_vsi->netdev);
>  
> @@ -136,16 +129,48 @@ static int ice_eswitch_setup_repr(struct ice_pf *pf, struct ice_repr *repr)
>  	dst->u.port_info.lower_dev = uplink_vsi->netdev;
>  
>  	return 0;
> +}
>  
> -err_update_security:
> +/**
> + * ice_eswitch_cfg_vsi - configure VSI to work in slow-path
> + * @vsi: VSI structure of representee
> + * @mac: representee MAC
> + *
> + * Return: 0 on success, non-zero on error.
> + */
> +int ice_eswitch_cfg_vsi(struct ice_vsi *vsi, const u8 *mac)
> +{
> +	int err;
> +
> +	ice_remove_vsi_fltr(&vsi->back->hw, vsi->idx);
> +
> +	err = ice_vsi_update_security(vsi, ice_vsi_ctx_clear_antispoof);
> +	if (err)
> +		goto err_update_security;
> +
> +	err = ice_vsi_add_vlan_zero(vsi);
> +	if (err)
> +		goto err_vlan_zero;
> +
> +	return 0;
> +
> +err_vlan_zero:
>  	ice_vsi_update_security(vsi, ice_vsi_ctx_set_antispoof);

nit: Please consider continuing the practice, that is used for the labels
     removed by this patch, of naming labels after what they do rather
     than what jumps to them.

> -err_dst_free:
> -	metadata_dst_free(repr->dst);
> -	repr->dst = NULL;
> -err_add_mac_fltr:
> -	ice_fltr_add_mac_and_broadcast(vsi, repr->parent_mac, ICE_FWD_TO_VSI);
> +err_update_security:
> +	ice_fltr_add_mac_and_broadcast(vsi, mac, ICE_FWD_TO_VSI);
>  
> -	return -ENODEV;
> +	return err;
> +}
> +

...
