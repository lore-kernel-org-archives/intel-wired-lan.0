Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EC3C46467
	for <intel-wired-lan@archiver.kernel.org>; Mon, 16 Jan 2023 10:31:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 94F6840869;
	Mon, 16 Jan 2023 10:31:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 94F6840869
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1673865112;
	bh=SH3bfs/MxYNtKBFpLzyZ30M0w6WmtMA9FWhLYcB8MtE=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=fodjCBueIYcgRHJ4m7zsGRtZtFPZupuPraFioPTocsZDnSzLWS/dgXz7pF18HBsir
	 sIZCxPj/WeBQOzTUwNBkwuVIRp6b17osxvO98DK1VFaYot1OI3Qgjf9ciKgRU2NkyW
	 1cUe/QKorGebmAnHu8t4O4yqcNNTCbctdBPCyqADgqLI8f8wVMBOtum02VkopThcsr
	 FOHzUNUAK0PznBwzVTUOt7GCKOXauRJNYKiMMu433ojp0XRk+BImWvU093PmfXAEIt
	 y7ZNqOfn7ds+FIpkR5Ty7gkjx/7kiUKnyaNEVAHAk5ELJHtG+YKFb9B8YpttnEcq/C
	 IwAKqkpB1JRXA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gZ5Dmi9pZ1P9; Mon, 16 Jan 2023 10:31:51 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5E556403D8;
	Mon, 16 Jan 2023 10:31:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5E556403D8
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 258341BF404
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Jan 2023 10:31:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0C9A9404C3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Jan 2023 10:31:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0C9A9404C3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BtoCKq5M3BVl for <intel-wired-lan@lists.osuosl.org>;
 Mon, 16 Jan 2023 10:31:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8EE72404C1
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8EE72404C1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Jan 2023 10:31:47 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="388930819"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; d="scan'208";a="388930819"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2023 02:31:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="727422478"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; d="scan'208";a="727422478"
Received: from unknown (HELO localhost.localdomain) ([10.237.112.144])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2023 02:31:44 -0800
Date: Mon, 16 Jan 2023 11:31:41 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Message-ID: <Y8UnjXr0y2VTjfb9@localhost.localdomain>
References: <20230113223735.2514364-1-jacob.e.keller@intel.com>
 <20230113223735.2514364-2-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230113223735.2514364-2-jacob.e.keller@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1673865108; x=1705401108;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=UnCX9WgolKUE1btOMlwxkazC5R9DOLGwDr8frUY6Wr0=;
 b=a7/0UTaPQsdZWvAlr8hQ/RE8SSuarHu5CSCZIN8ATvyBJwAB9BscT9RK
 iWvoFrmOMV8eIpN0rjQUExTU62KjHG5EQdm+uNoSp0wWVH04z8PpEulfM
 8LE43tcZavc8F4lvoskr877jqKML/Xui8GcVHRROMvzI8XWuEuf9ylFUj
 Xy3NBF7BIkZkw27gF1C/I405fYE4cMzkMILG4l5a6+7kZALIARtxoLvqt
 aeyz0H61FlQSMGLAxXn/HAHhRb9araEGDTEUGlbi59u3hZdaDNsKrycJa
 bx9cUE947/uiePdYesmn0WoifzVCXp5HCgB2ap0sRI3/y8tQAJQ+rsZ/E
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=a7/0UTaP
Subject: Re: [Intel-wired-lan] [PATCH net-next 01/13] ice: fix function
 comment referring to ice_vsi_alloc
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

On Fri, Jan 13, 2023 at 02:37:23PM -0800, Jacob Keller wrote:
> Since commit 1d2e32275de7 ("ice: split ice_vsi_setup into smaller
> functions") ice_vsi_alloc has not been responsible for all of the behavior
> implied by the comment for ice_vsi_setup_vector_base.
> 
> Fix the comment to refer to the new function ice_vsi_alloc_def().
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 04f31a83e327..62d27e50f40e 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -1527,7 +1527,7 @@ static int ice_get_vf_ctrl_res(struct ice_pf *pf, struct ice_vsi *vsi)
>   * ice_vsi_setup_vector_base - Set up the base vector for the given VSI
>   * @vsi: ptr to the VSI
>   *
> - * This should only be called after ice_vsi_alloc() which allocates the
> + * This should only be called after ice_vsi_alloc_def() which allocates the
>   * corresponding SW VSI structure and initializes num_queue_pairs for the
>   * newly allocated VSI.
>   *
> -- 
> 2.38.1.420.g319605f8f00e
> 

Right, thanks for fixing that
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan@osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
