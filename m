Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 929BBCA601E
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 20:26:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D1D1811B2;
	Fri,  9 Oct 2026 20:26:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6YOpO6lSQJpV; Fri,  9 Oct 2026 20:26:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 493E881216
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791577597;
	b=Oe7oYImAXK7fZUREoIWbvqIUDufp/ScnUs+ZNwQuCKa/eHNw3XEgUkKUsq+9KZB/3Fp4
	 VLG5mrhaeqZ8U7MSjtJhmYy6aesWaXdxtFhHIZzoQiUJEXwxtCRl+iz/ss2oXFEFQxfec
	 RZxRc9DQGxQUsttDGB+jYSmnqKUgqttdLjn/AFHIz3g5iz/ZNS7AGDW7XS4afqNF1Ywef
	 ODblxAhzxoc0jHjR5R2byOExWwPmpuloOJgFR6yJHhM7lHeDE5SE/VIWsCjlBAomZzamY
	 37eOnpcmp9Pj484ELTPuFKERj5TCurYjutpC9n895RK19U38lY2Ki9aRCENoFBMJw4w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791577597;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=Tzh44mjbXVAoK+lHrdvRY72AwDkXk6fYGSXxptBhEhg=;
	b=TSdHHoaeRk34OaGnimToXc2M7t0Lb9eK9h93RymbqZS/pkn2YpHpYcsToKQtOYjL/q9C
	 rQoej02URJN9Bx/vYeWrOFysiVGCGZppYvYRKM5teSJXzLo4dRmn/G/Ya4PDQu/GsRdS/
	 7ge6NaksYfM3ic6cuN1kIX1WCy3nLDtP6FuEqN3pkt77UCB4W6OnAUhg7B+l6bpSJ4QL5
	 fy9lqDB2if2mTJWxuc0ggUAZ1h93QxMxFvPT28Shku+FGjFzyw9ZToEYml8nwlYQkzXzb
	 gFemYq1Pb0EG6VjzIjHoebgiXqL6A60oKJ29keExR2l1lp/MFjAjl72Dr8gkdAK9+6Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791577597;
	bh=Tzh44mjbXVAoK+lHrdvRY72AwDkXk6fYGSXxptBhEhg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=KNDp5sb9KkeotklhXuD8T+UlZNyPHgexrpHNiZqvAbaXK1CJdWIMQXUUe8B8PSQh5
	 9806JyK/2HpvAuyNmMjjjG/p9x/vManWGL8rWiAyoRZ8cT0omzDyU4TpgDR+Ww4TB7
	 snxp/Ger6FO+9ZayKp6QadGlyUFCl5HgHNquDqAvRbUWVrfBz1XYThBRtasB0nIwI6
	 JAg9bGEN3t1jXPKRjpHdHV0MNnnImlS+qTvvs7a7+dz5zEGQ51CS1ZNT2zGZpJfWik
	 hqMHQT4mTO1Tn5vHrcwvNTFDcYbSZle286pOTeO17CGuIV0Yn0RS+xLivaPOQ6odoe
	 8beCq/wOM/e0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 493E881216;
	Fri,  9 Oct 2026 20:26:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A87FD1DE
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 20:26:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 99F77408A2
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 20:26:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cYHTirrVYTAH for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 20:26:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B23C64087F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791577594;
 b=nH0+sIfD/oWs2k/OkHDDpPDJAKoWLFFluQe8ORdikAyjr6jW36amkv5S53IIqYStfX7T
 Og5a+d6BOuHG4XzJvnvENWEfZEHDtEoJm1povp6f26FnG0V+q3DKRi1/5qMce9XbScUQC
 0YNRhHQ4oEJ3Mn2dRPAJAc2fDowk/bQkiFxSkvUJzul2hlhYkXUkvy/yirJ5jTIrgRqRU
 9iTd294mvMJGa03JGV4J1Bd5jcs69TLWSbRuiROdmKNSmG5U+KQUi7BR7tLVXfQCx5TMX
 lRBHCp4z4LEUz+Vck0TRl1t92GGo0rfyLAzH1PaQVy0stcBkp7fbMaXnXoA4Q6/QULw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791577594;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=Tzh44mjbXVAoK+lHrdvRY72AwDkXk6fYGSXxptBhEhg=;
 b=Kk/zohCXB2UQlz266uUcROqeUOzZFC691gS1QBkk6pWdMOMwiTI+uLSq5603fg0U0tTV
 N54B2cAEITpZh/4thOVaaY6PRYjra8Wa4aKH9SiBr0oTi4rEiO5/R9v3h8B19GJW8nfSF
 5F2gdQ8KK3P9DZgKYrygeacro0k3CC5PpYyuJGtJHaRdy4T4vQAn13h4Qsql5ON0I8Mm6
 e1gJixe0AoDxrOtC690keqUo9Fdg9yWefRwJtF4Nqh+JZBftIw4q825SgkBLCc8+WLYyL
 j8RwCnYj4y9Z6rhf8r7OPMh47480qUNz9KYia4qU2akkW4Ou9iPG2iioEfrcAlQP3tg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="T7/PcRuw"; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=T7/PcRuw
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B23C64087F
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 20:26:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A4F8B4084C;
 Fri,  9 Oct 2026 20:26:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4594A1F000FF;
 Fri,  9 Oct 2026 20:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791577593;
 bh=Tzh44mjbXVAoK+lHrdvRY72AwDkXk6fYGSXxptBhEhg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=T7/PcRuwC5X0g/beFf6T+TmT4SOT9r1YSJBgoAVa4GZ5Wr/WMEzBtPGP8Tcx3PaAO
 7A13VhF7hVY2el6RgxTReKrT2s7Bckm4TI86cifBVWQbMBo8pMjjSoVxkVQZimACnX
 InGuG5TYGIzfyCzZAinIM7/0nbcTFRq0+XxSCPtecbC/CcI4aBa6ucIY+E+H2VbKqh
 p3ZXS5e19Nq9ZsFOCNYrw5YxYI/4e1z+KKuVDJjKngjGTPJKvJVxoHUDCY70dkV/ZZ
 O3z5K5mgIBGtPSr7YK75QzuFFz2Hy0Dn1P1XbE7Ei2NQH5UlESv9hksiKNqqTHiRSr
 oPQcdx+4viOvQ==
Message-ID: <sashiko-outbox-166032@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-next v2 5/6] ice: remove ice_agg_node wrapper structure
To: "Jacob Keller" <jacob.e.keller@intel.com>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261009-jk-cleanup-vsi-aggregator-nodes-v2-5-313964c25c7b@intel.com>
References: <20261009-jk-cleanup-vsi-aggregator-nodes-v2-0-313964c25c7b@intel.com>
 <20261009-jk-cleanup-vsi-aggregator-nodes-v2-5-313964c25c7b@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 20:26:32 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: intel-wired-lan-bounces@osuosl.org

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] ice: VF rebuild fails to re-associate VSI with fully populated agg=
regator node
--

commit aed63df873bf36bec0897ed1209a7e411aadbd13
Author: Jacob Keller <jacob.e.keller@intel.com>

    ice: remove ice_agg_node wrapper structure

The commit removes the ice_agg_node wrapper structure and replaces it with
existing scheduler aggregator info. It introduces ice_cfg_vsi_agg() and
uses it to look up and configure VSIs during initialization and rebuilds.

> diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/eth=
ernet/intel/ice/ice_sched.c
> index b1c2901b23f12..f0b1924b0411f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sched.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sched.c
[ ... ]
> @@ -3082,6 +3082,114 @@ ice_move_vsi_to_agg(struct ice_port_info *pi, u32=
 agg_id, u16 vsi_handle,
>  	return status;
>  }
> =20
> +/**
> + * ice_find_available_agg - Find or create aggregator node
> + * @pi: port information structure
> + * @min_id: minimum aggregator node ID to use
> + * @max_id: maximum aggregator node ID to use
> + * @agg_type: The aggregator node type
> + * @tc_bitmap: TC bitmap for a newly created node
> + *
> + * Check the existing xarray of aggregator nodes. Find the first one bet=
ween
> + * min_id and max_id which has fewer than ICE_MAX_VSIS_IN_AGG_NODE (64) =
VSIs
> + * in use. If there is no aggregator node that fits this criteria, create
> + * a new one between that range.
> + *
> + * Context: Must be called while holding the scheduler lock.
> + *
> + * Return: A pointer to the aggregator info structure, or an ERR_PTR on
> + * failure.
> + */
> +static struct ice_sched_agg_info *
> +ice_find_available_agg(struct ice_port_info *pi, u32 min_id, u32 max_id,
> +		       enum ice_agg_type agg_type, unsigned long *tc_bitmap)
> +{
> +	struct ice_sched_agg_info *agg_info;
> +	struct ice_hw *hw =3D pi->hw;
> +	unsigned long agg_id;
> +	int status;
> +
> +	xa_for_each_range(&hw->agg_nodes, agg_id, agg_info, min_id, max_id) {
> +		if (agg_info->agg_type !=3D agg_type)
> +			continue;
> +
> +		if (agg_info->num_vsis < ICE_MAX_VSIS_IN_AGG_NODE)
> +			return agg_info;

[Severity: High]
Does this check inadvertently reject fully populated aggregators when the c=
aller
is explicitly requesting an existing node during a rebuild?

If ice_vf_rebuild_aggregator_node_cfg() attempts to re-associate the VF=20
with an existing perfectly full aggregator (64 VSIs), it seems this check=20
evaluates to false because the SW tree structures were preserved across the=
=20
reset and the VF is still accounted for in num_vsis.

> +	}
> +
> +	/* No aggregator node exists with space, so create a new one */
> +	agg_info =3D ice_alloc_agg_info(hw, min_id, max_id, agg_type);

Since ice_find_available_agg() returns here if no space was found, won't=20
this allocation attempt to create a new node with the exact same ID (because
min_id and max_id are both vsi->agg_id), causing xa_alloc() to fail?

> +	if (IS_ERR(agg_info))
> +		return agg_info;
[ ... ]
> diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/et=
hernet/intel/ice/ice_vf_lib.c
> index c56a35b8dd48f..a67586f7db8be 100644
> --- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> @@ -471,24 +471,20 @@ static void ice_vf_rebuild_aggregator_node_cfg(stru=
ct ice_vsi *vsi)
>  	struct device *dev;
>  	int status;
> =20
> -	if (!vsi->agg_node)
> -		return;
> -
>  	dev =3D ice_pf_to_dev(pf);
> -	if (vsi->agg_node->num_vsis =3D=3D ICE_MAX_VSIS_IN_AGG_NODE) {
> -		dev_dbg(dev,
> -			"agg_id %u already has reached max_num_vsis %u\n",
> -			vsi->agg_node->agg_id, vsi->agg_node->num_vsis);
> +
> +	if (vsi->agg_id < 0 || vsi->agg_id > U32_MAX) {
> +		dev_dbg(dev, "VSI idx %u does not have a valid aggregator node ID stor=
ed\n",
> +			vsi->idx);
>  		return;
>  	}
> =20
> -	status =3D ice_move_vsi_to_agg(pf->hw.port_info, vsi->agg_node->agg_id,
> -				     vsi->idx, vsi->tc_cfg.ena_tc);
> +	status =3D ice_cfg_vsi_agg(pf->hw.port_info, vsi->idx,
> +				 (u32)vsi->agg_id, (u32)vsi->agg_id,
> +				 (u8)vsi->tc_cfg.ena_tc, NULL);

If ice_cfg_vsi_agg() fails when the original node is fully populated, does=
=20
this break QoS and bandwidth isolation for any VF assigned to that full
aggregator? The previous logic specifically checked for and gracefully hand=
led
reaching ICE_MAX_VSIS_IN_AGG_NODE.

>  	if (status)
> -		dev_dbg(dev, "unable to move VSI idx %u into aggregator %u node",
> -			vsi->idx, vsi->agg_node->agg_id);
> -	else
> -		vsi->agg_node->num_vsis++;
> +		dev_dbg(dev, "unable to move VSI idx %u into aggregator node %lld\n",
> +			vsi->idx, vsi->agg_id);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-jk-cleanup=
-vsi-aggregator-nodes-v2-0-313964c25c7b@intel.com?part=3D5
