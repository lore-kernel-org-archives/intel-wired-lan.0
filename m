Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86708C54EBE
	for <intel-wired-lan@archiver.kernel.org>; Mon, 16 Jan 2023 10:56:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0BA976079B;
	Mon, 16 Jan 2023 10:56:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0BA976079B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1673866594;
	bh=izlgvJzWdyFk+JM9/+21qZMbVxJfdz5+b6HjiaBN9Uk=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=IYG+ngz6Fyy4rQZWqgGDa8IbGiqjfmorRYKokvikTL2GHrzeaIaelRJCcvxr9+5EX
	 JOJ2ybTmiZMDWvB5J5+TEyZeAhg1CnPZsqY68sU3VBTHeqOKgiqDkObe3pNvwzzJpa
	 iQJNZSuLY7ffzclGwsOnitmR+YnfgROgyw+lnvjr6DNzFMu1NpaSYYiKVfevCiscP8
	 A0MXH9N88kcmJxvdID53VMvsKtC7TqIt9KP/dok6VmT0MaQP8/m4Yy8W8m5mWon3va
	 miVgoHAwjs0laB14YaSTaT6Np+7OLWKmoMwKTDwesjhBWuK71mVCVrg7ry0VjSj6vQ
	 iUufwXEvP18ZA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6w9y_tfksi_M; Mon, 16 Jan 2023 10:56:33 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB0AE607A3;
	Mon, 16 Jan 2023 10:56:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EB0AE607A3
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 131791BF404
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Jan 2023 10:56:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E08BF81428
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Jan 2023 10:56:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E08BF81428
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RbtF7Ijo-tdE for <intel-wired-lan@lists.osuosl.org>;
 Mon, 16 Jan 2023 10:56:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EAB7A81427
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EAB7A81427
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Jan 2023 10:56:29 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="312290418"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; d="scan'208";a="312290418"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2023 02:56:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="801352001"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; d="scan'208";a="801352001"
Received: from unknown (HELO localhost.localdomain) ([10.237.112.144])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2023 02:56:27 -0800
Date: Mon, 16 Jan 2023 11:56:23 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Message-ID: <Y8UtV5QqESWncLcP@localhost.localdomain>
References: <20230113223735.2514364-1-jacob.e.keller@intel.com>
 <20230113223735.2514364-5-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230113223735.2514364-5-jacob.e.keller@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1673866589; x=1705402589;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=GUXjcJdBCF3ueu87ifRJZdWHyfIHNng/jUxs/zd+3HM=;
 b=dtMvnFeeBj7I7E952u5uU3DqQPStjNZ3kiTtzXZ3go/01j3RxMcKFZHa
 455VlGU//0LadpMz3j/J4QLAJY2aGNwWF/1EXfSfgCynqCoRg8Fdm6uMm
 4s+ej8Xu0TZrGt6ze9lm4i2+h+PNjdldF453wC92vSxqXx/e7DYc+2eFK
 kM218TeRKsl1R0KE4vBOm0c1EL0W7AW1mXtWptuAPdatUcrm9NuJZ3qBV
 r7S9KTFGtpC/sRCGDp18YZFXrEDfpQHbkWwSqqcFUIDSEDEGGVgP1UAIT
 iL0EPmsfsMVkyMzZRX6gsKPbH+vSWkm/qISvbBHo+xdSnfGl3KC5Uz116
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=dtMvnFee
Subject: Re: [Intel-wired-lan] [PATCH net-next 04/13] ice: add helper
 function for checking VSI VF requirement
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
Cc: Anthony Nguyen <anthony.l.nguyen@intel.com>,
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, Jan 13, 2023 at 02:37:26PM -0800, Jacob Keller wrote:
> A few places in ice_lib.c WARN if the VSI type is VF and the VF pointer is
> NULL. This helps protect against accidentally creating a ICE_VSI_VF without
> providing a VF pointer.
> 
> A future change is going to introduce another type of VSI which has the
> same requirement, ICE_VSI_ADI. Instead of expanding each WARN_ON check to
> include both types, introduce a helper function to do this check. The
> ice_vsi_requires_vf function returns true if the VSI *must* have a VF, and
> returns false otherwise.
> 
> Of specific note is that some VSI types may optionally have a VF but do not
> require them, such as the ICE_VSI_CTRL type. These return false.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 26 +++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index f89279ede9a1..79555e22a9be 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -34,6 +34,26 @@ const char *ice_vsi_type_str(enum ice_vsi_type vsi_type)
>  	}
>  }
>  
> +/**
> + * ice_vsi_requires_vf - Does this VSI type always require a VF?
> + * @vsi_type: the VSI type
> + *
> + * Returns true if the VSI type *must* have a VF pointer. Returns false
> + * otherwise. In particular, VSI types which may *optionally* have a VF
> + * pointer return false.
> + *
> + * Used to WARN in cases where we always expect a VF pointer to be non-NULL.
> + */
> +static int ice_vsi_requires_vf(enum ice_vsi_type vsi_type)
> +{
> +	switch (vsi_type) {
> +	case ICE_VSI_VF:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
Looks a little strange right now. Maybe send this whole patch with SIOV
series?

> +
>  /**
>   * ice_vsi_ctrl_all_rx_rings - Start or stop a VSI's Rx rings
>   * @vsi: the VSI being configured
> @@ -175,7 +195,7 @@ static void ice_vsi_set_num_qs(struct ice_vsi *vsi)
>  	struct ice_pf *pf = vsi->back;
>  	struct ice_vf *vf = vsi->vf;
>  
> -	if (WARN_ON(vsi_type == ICE_VSI_VF && !vf))
> +	if (WARN_ON(ice_vsi_requires_vf(vsi_type) && !vf))
>  		return;
>  
>  	switch (vsi_type) {
> @@ -2854,7 +2874,7 @@ int ice_vsi_cfg(struct ice_vsi *vsi, enum ice_vsi_type vsi_type,
>  	struct ice_pf *pf = vsi->back;
>  	int ret;
>  
> -	if (WARN_ON(vsi_type == ICE_VSI_VF && !vf))
> +	if (WARN_ON(ice_vsi_requires_vf(vsi_type) && !vf))
>  		return -EINVAL;
>  
>  	vsi->type = vsi_type;
> @@ -3487,7 +3507,7 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, int init_vsi)
>  		return -EINVAL;
>  
>  	pf = vsi->back;
> -	if (WARN_ON(vsi->type == ICE_VSI_VF && !vsi->vf))
> +	if (WARN_ON(ice_vsi_requires_vf(vsi->type) && !vsi->vf))
>  		return -EINVAL;
>  
>  	coalesce = kcalloc(vsi->num_q_vectors,
> -- 
> 2.38.1.420.g319605f8f00e
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan@osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
