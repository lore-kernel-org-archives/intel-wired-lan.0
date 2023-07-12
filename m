Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D98BEB64DA
	for <intel-wired-lan@archiver.kernel.org>; Wed, 12 Jul 2023 06:30:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8DC14822A4;
	Wed, 12 Jul 2023 06:30:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8DC14822A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1689143407;
	bh=IrZcbuW5RjkbXhts6NKJ1Ec2tZ+PWyRCfJVLK5KVWZw=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=vkMqTIlOhhzOC276iVwTFvf+CuVomDd8e0+0zP+FR//xi9WOtHzjuN4izXiEvGfHZ
	 HydK3p+j+UzGyBGX/HL32xVeYK2OubZsUPEs7vRKwgiHH0mgcQ7f2PQqaC8Cjjp40W
	 e9xQWgji6Ey2MBF9bCKf1H9zfGIT+TPPzENKdoLLYMRf3zXfSNVrW9QXUcMRy7AL9P
	 cSraJDZZwq8zCI1NWG5fGXbsivuwTe7equDR1jxBCa+ahYl4kfV4gJP+WrVFPOzZhL
	 2B84J7Kg0eDePpX21ch9wk/VeePZPFOiLeJzOMsAOSTDxrKUOMzEhBCZ8nG8RfxEvn
	 +7z2QNU+jNQcQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uMu5F3drrEFv; Wed, 12 Jul 2023 06:30:06 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9207E82284;
	Wed, 12 Jul 2023 06:30:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9207E82284
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 409141BF47D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Jul 2023 06:30:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 06EBB41A43
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Jul 2023 06:30:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 06EBB41A43
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LoJ0khAsFKz0 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 12 Jul 2023 06:30:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 94D3E419D3
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 94D3E419D3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Jul 2023 06:30:03 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 633C461628;
 Wed, 12 Jul 2023 06:30:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB96AC433C7;
 Wed, 12 Jul 2023 06:30:01 +0000 (UTC)
Date: Wed, 12 Jul 2023 09:29:58 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Message-ID: <20230712062958.GX41919@unreal>
References: <20230711100450.30492-1-jedrzej.jagielski@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230711100450.30492-1-jedrzej.jagielski@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1689143402;
 bh=YmjH6pXE0duVWOXw/qLFsybrKOVBKUyWnoFq/rutZDc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=I5P+lLvql3e7EWp6T0IB6J5a5NSrGzK0IsZ8eVSIbYrv6adEMIpRUCZWtdmBtemDB
 N9GFKCav8RK6wL34bqwCwAUaxU/Qs1ruk5G46wFGRb3if/gbMHPYxaFp0msGxLM9b7
 WPCY79fHT59A37FzRo5BsvxquvP8USm6RIh4yEAj5WxZ0wwuoh4A4tdG4s7qWgKR0h
 nXj2H/k6UaX7smtmedbKQOuWzSmCUsU/KNEgjaboV2ZGu+sX1LiG1l4PjmBFrDPY9t
 V5zenRpRG6FJ/AFSZpjh+FwrH0WyRQjwkSGl3JdKDglxMC/X1BDsiUsuDcigIaSjer
 d6aq53Egpgomw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=I5P+lLvq
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v4] ice: Fix memory management
 in ice_ethtool_fdir.c
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
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 intel-wired-lan@lists.osuosl.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, Jul 11, 2023 at 12:04:50PM +0200, Jedrzej Jagielski wrote:
> Fix ethtool FDIR logic to not use memory after its release.
> In the ice_ethtool_fdir.c file there are 2 spots where code can
> refer to pointers which may be missing.
> 
> In the ice_cfg_fdir_xtrct_seq() function seg may be freed but
> even then may be still used by memcpy(&tun_seg[1], seg, sizeof(*seg)).
> 
> In the ice_add_fdir_ethtool() function struct ice_fdir_fltr *input
> may first fail to be added via ice_fdir_update_list_entry() but then
> may be deleted by ice_fdir_update_list_entry.
> 
> Terminate in both cases when the returned value of the previous
> operation is other than 0, free memory and don't use it anymore.
> 
> Reported-by: Michal Schmidt <mschmidt@redhat.com>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2208423
> Fixes: cac2a27cd9ab ("ice: Support IPv4 Flow Director filters")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> v2: extend CC list, fix freeing memory before return
> v3: correct typos in the commit msg
> v4: restore devm() approach
> ---
>  .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 30 +++++++++++--------
>  1 file changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
> index ead6d50fc0ad..b6308780362b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
> @@ -1281,16 +1281,25 @@ ice_cfg_fdir_xtrct_seq(struct ice_pf *pf, struct ethtool_rx_flow_spec *fsp,
>  				     ICE_FLOW_FLD_OFF_INVAL);
>  	}
>  
> -	/* add filter for outer headers */
>  	fltr_idx = ice_ethtool_flow_to_fltr(fsp->flow_type & ~FLOW_EXT);
> +
> +	if (perfect_filter)
> +		set_bit(fltr_idx, hw->fdir_perfect_fltr);
> +	else
> +		clear_bit(fltr_idx, hw->fdir_perfect_fltr);
> +

The code above is assign_bit(fltr_idx, hw->fdir_perfect_fltr, perfect_filter);

> +	/* add filter for outer headers */
>  	ret = ice_fdir_set_hw_fltr_rule(pf, seg, fltr_idx,
>  					ICE_FD_HW_SEG_NON_TUN);
> -	if (ret == -EEXIST)
> -		/* Rule already exists, free memory and continue */
> -		devm_kfree(dev, seg);
> -	else if (ret)
> +	if (ret == -EEXIST) {
> +		/* Rule already exists, free memory and count as success */
> +		ret = 0;
> +		goto err_exit;
> +	} else if (ret) {
>  		/* could not write filter, free memory */
> +		ret = -EOPNOTSUPP;

I see that original code returned -EOPNOTSUPP, but why?
Why do you rewrite return value? Why can't you return "ret" as is?

Thanks

>  		goto err_exit;
> +	}
>  
>  	/* make tunneled filter HW entries if possible */
>  	memcpy(&tun_seg[1], seg, sizeof(*seg));
> @@ -1305,18 +1314,13 @@ ice_cfg_fdir_xtrct_seq(struct ice_pf *pf, struct ethtool_rx_flow_spec *fsp,
>  		devm_kfree(dev, tun_seg);
>  	}
>  
> -	if (perfect_filter)
> -		set_bit(fltr_idx, hw->fdir_perfect_fltr);
> -	else
> -		clear_bit(fltr_idx, hw->fdir_perfect_fltr);
> -
>  	return ret;
>  
>  err_exit:
>  	devm_kfree(dev, tun_seg);
>  	devm_kfree(dev, seg);
>  
> -	return -EOPNOTSUPP;
> +	return ret;
>  }
>  
>  /**
> @@ -1914,7 +1918,9 @@ int ice_add_fdir_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
>  	input->comp_report = ICE_FXD_FLTR_QW0_COMP_REPORT_SW_FAIL;
>  
>  	/* input struct is added to the HW filter list */
> -	ice_fdir_update_list_entry(pf, input, fsp->location);
> +	ret = ice_fdir_update_list_entry(pf, input, fsp->location);
> +	if (ret)
> +		goto release_lock;
>  
>  	ret = ice_fdir_write_all_fltr(pf, input, true);
>  	if (ret)
> -- 
> 2.31.1
> 
> 
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
