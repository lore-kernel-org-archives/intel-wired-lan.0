Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CAD4C3DA59
	for <intel-wired-lan@archiver.kernel.org>; Mon, 22 Jul 2024 15:03:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B35A81139;
	Mon, 22 Jul 2024 15:03:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fTpBY8_W7etT; Mon, 22 Jul 2024 15:03:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 93B3281132
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1721660632;
	bh=4PUODeLTfnXj8mUT0/CaPXNAGIw7ywNXNkXhlo7FDgg=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=wyTtDX2MUTvuFey4xKiG2ZjnkcMocHggxwPR/mZ1UhCfAi6J2tIbLI+JqwJMBo+hR
	 njl7QMnWp3FbIvHFc/S6VAsotpqSXRsg++vedEACdhzhlthuh0vB+x3Nf0fK9NOlNs
	 QM+E0lpAJjFr9Ql/qNME+iLnM+PBgcwCkioWoDqvG2YBPOHCdM62eotOd8hDORpRSK
	 j0hVK/7rrsfPTXCoJQatUJP4aVFjxIbeB9o7QI2x3TG+t8/qwzo2/QB0LLTrKXevV4
	 NHzhBV18/G5QsX5VbymP1+UXpyNkxVw4CMXt4QpRg+U/fzSr9xEAIIUBh70UYmJ0mi
	 lJOB/ieq50KQg==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 93B3281132;
	Mon, 22 Jul 2024 15:03:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 61ECD1BF8A8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 22 Jul 2024 15:03:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4E6BB40448
 for <intel-wired-lan@lists.osuosl.org>; Mon, 22 Jul 2024 15:03:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SRDhp_DPGh5s for <intel-wired-lan@lists.osuosl.org>;
 Mon, 22 Jul 2024 15:03:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217;
 helo=dfw.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 55B1F40109
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 55B1F40109
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 55B1F40109
 for <intel-wired-lan@lists.osuosl.org>; Mon, 22 Jul 2024 15:03:50 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 815C260ACC;
 Mon, 22 Jul 2024 15:03:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C00C4AF0D;
 Mon, 22 Jul 2024 15:03:47 +0000 (UTC)
Date: Mon, 22 Jul 2024 16:03:45 +0100
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Message-ID: <20240722150345.GJ715661@kernel.org>
References: <20240710204015.124233-1-ahmed.zaki@intel.com>
 <20240710204015.124233-12-ahmed.zaki@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710204015.124233-12-ahmed.zaki@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1721660629;
 bh=aKtTRE0gYv4JNiizTWmrDHB3lYg1AYIXuFIN/d6fECQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NBYhwxf+OXuj7lAa5wXanBgAwzi6v3zM36wr+8IkiEsMghAMlGDs1ZsJPsi4wWTdD
 9NAAdA8uJyvydGvfuhUGbftMxBhb93bc2KTdgDj+iJJaDZDqebtSzzASFrw4LwieyS
 5YavRO9TCE1lg6rzfzA4QUE7Xs2mqbck5x8zGPwTiBYNGarB3EpGZQCUqTyDFBod4v
 EvzkM9G9z+AtXK0WXO47TROrK7pDADMDDkTN6kUv5Z0NkWbyih9yEIyO/cGRfxCB9P
 2kNHWc+AwOjWnTes9znZAqtlWx40T3zBvsOx4xr7PzHOBHp6h1pPiMMSbLTYWTyVj/
 qi8DisEhnCk/Q==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=NBYhwxf+
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3 11/13] ice: enable FDIR
 filters from raw binary patterns for VFs
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
 Marcin Szycik <marcin.szycik@linux.intel.com>,
 intel-wired-lan@lists.osuosl.org, Junfeng Guo <junfeng.guo@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, Jul 10, 2024 at 02:40:13PM -0600, Ahmed Zaki wrote:
> From: Junfeng Guo <junfeng.guo@intel.com>
> 
> Enable VFs to create FDIR filters from raw binary patterns.
> The corresponding processes for raw flow are added in the
> Parse / Create / Destroy stages.
> 
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> Co-developed-by: Ahmed Zaki <ahmed.zaki@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c

...

> +/**
> + * ice_vc_fdir_is_raw_flow

nit: The short description is missing from the line above

> + * @proto: virtchnl protocol headers
> + *
> + * Check if the FDIR rule is raw flow (protocol agnostic flow) or not.
> + * Note that common FDIR rule must have non-zero proto->count.
> + * Thus, we choose the tunnel_level and count of proto as the indicators.
> + * If both tunnel_level and count of proto are zeros, this FDIR rule will
> + * be regarded as raw flow.
> + *
> + * Returns: true if headers describe raw flow, false otherwise.
> + */
> +static bool
> +ice_vc_fdir_is_raw_flow(struct virtchnl_proto_hdrs *proto)
> +{
> +	return (proto->tunnel_level == 0 && proto->count == 0);
> +}
> +
> +/**
> + * ice_vc_fdir_parse_raw

Likewise here.

> + * @vf: pointer to the VF info
> + * @proto: virtchnl protocol headers
> + * @conf: FDIR configuration for each filter
> + *
> + * Parse the virtual channel filter's raw flow and store it in @conf
> + *
> + * Return: 0 on success or negative errno on failure.
> + */

...
