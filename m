Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1E5C6FD19
	for <intel-wired-lan@archiver.kernel.org>; Fri, 10 Mar 2023 10:19:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4EFD982191;
	Fri, 10 Mar 2023 10:19:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4EFD982191
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1678443580;
	bh=icHNbq+sqL7UrLKbrOYnpRPPHWyMTxJyefaKYcBPWms=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=AQOEw2i+9ffVaJus9S5x3FpSatMPOXnPn+rS+9YvaQ7P63QisIjh9r03vME0B5KMq
	 qcP7SU9z8RMWRvBifWog0bglnItAbWGrjJ6D7FcGZxbcw5d2EDN2VJHZttlwEP89OJ
	 /qoVGruJxno4WEb6TwonQDmobljBMvVjs6O/kKaDqIJRj0rKvU6EYK5NuMCyNDSsTy
	 DCDhxjZQL6cmvhGRQdV0RUzgOsQYEWDVPBi8dxICDSXvvMvh9kLcgdx01+ZyM3iPfb
	 9Jytw8s/FSUsC9hga6CGEtTNs31O13jClqUS3g8kkpUSc96VCq6wySp3YJ8NZ2UcP9
	 m8UHVLfUkneGw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jKo2r1mbxiQr; Fri, 10 Mar 2023 10:19:39 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E03E82274;
	Fri, 10 Mar 2023 10:19:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4E03E82274
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 451FD1BF29A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Mar 2023 10:19:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1A0C482274
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Mar 2023 10:19:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1A0C482274
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QJkYOtK9Csk9 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 10 Mar 2023 10:19:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3A1F882191
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3A1F882191
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Mar 2023 10:19:37 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="422966031"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; d="scan'208";a="422966031"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2023 02:19:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="671039277"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; d="scan'208";a="671039277"
Received: from unknown (HELO localhost.localdomain) ([10.237.112.144])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2023 02:19:35 -0800
Date: Fri, 10 Mar 2023 11:19:31 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Lingyu Liu <lingyu.liu@intel.com>
Message-ID: <ZAsEM+P7D/AfreLY@localhost.localdomain>
References: <20230309024934.151120-1-lingyu.liu@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230309024934.151120-1-lingyu.liu@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1678443577; x=1709979577;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=RKqPbftawELuqONk8iHhk9kruE9/ipBhpMoz44JWwPQ=;
 b=IzVI+h63qMDkBghAl9EdMGwbJtPpg0n0t1cJpPvM+4ccTGGx9Vx8abIp
 tWXnonlCt3WxR+nbXlFBDYq0012ZAZdeOqNQInsrSK7MP9BLJPqmpeE53
 HzY4XeHWLlRIYf58PIm2VXfnmVQQhSB+uAd4HC9vKSV85AUpEuAm1vflM
 zu45mdTVKNTxHD8APdBK1V7rhn0YSTFbzZ6/jzasR1517VottHwRczkzn
 pt2WUnW5ChPy1Ao7iit2rS2TL2oI4KHSnt8jHQNzi71lB4p4f6hmscb5V
 pPSG3xgFHA3sQ4X2U0yO596xYwQ3b7Ir0qkbTNLaTXxIKTzEkIUTieu0t
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=IzVI+h63
Subject: Re: [Intel-wired-lan] [PATCH net v2] ice: add FDIR counter reset in
 FDIR init stage
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
Cc: intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Mar 09, 2023 at 02:49:34AM +0000, Lingyu Liu wrote:
> From: Junfeng Guo <junfeng.guo@intel.com>
> 
> This patch added the missing FDIR counters reset process when
> FDIR inits. Without this patch, when VF initializes or resets,
> all the FDIR counters will not be cleaned, which may cause
> unexpected behaviors for future FDIR rule create (e.g., rule
> conflict).
> 
> Fixes: 1f7ea1cd6a37 ("ice: Enable FDIR Configure for AVF")
> Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> Signed-off-by: Lingyu Liu <lingyu.liu@intel.com>
> ---
> v2: change commit message to apply more to a kernel use
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
> index e6ef6b303222..60c9da4aac1d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
> @@ -541,6 +541,20 @@ static void ice_vc_fdir_rem_prof_all(struct ice_vf *vf)
>  	}
>  }
>  
> +/**
> + * ice_vc_fdir_reset_cnt_all - reset all FDIR counters for this VF FDIR
> + * @fdir: pointer to the VF FDIR structure
> + */
> +static void ice_vc_fdir_reset_cnt_all(struct ice_vf_fdir *fdir)
> +{
> +	enum ice_fltr_ptype flow = ICE_FLTR_PTYPE_NONF_NONE;
> +
> +	for (; flow < ICE_FLTR_PTYPE_MAX; flow++) {
> +		fdir->fdir_fltr_cnt[flow][0] = 0;
> +		fdir->fdir_fltr_cnt[flow][1] = 0;
> +	}
> +}
> +
>  /**
>   * ice_vc_fdir_write_flow_prof
>   * @vf: pointer to the VF structure
> @@ -1924,6 +1938,7 @@ void ice_vf_fdir_init(struct ice_vf *vf)
>  	spin_lock_init(&fdir->ctx_lock);
>  	fdir->ctx_irq.flags = 0;
>  	fdir->ctx_done.flags = 0;
> +	ice_vc_fdir_reset_cnt_all(fdir);
I am fine with this change, however, maybe the better place for
resetting counters will be when the flows are removed? Or maybe
the flow are removed only by hw?

>  }
>  
>  /**
> -- 
> 2.25.1
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan@osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
