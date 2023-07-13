Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11099C001B0
	for <intel-wired-lan@archiver.kernel.org>; Thu, 13 Jul 2023 15:13:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C1B8E60A7F;
	Thu, 13 Jul 2023 15:13:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C1B8E60A7F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1689261215;
	bh=0n3NljcaXXHr3C5Wk0JYeLpBp2LELtXVA0vcnFXhTII=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=9tJDd9+mxp9wofZ2SbvKxmF0J6cIzuOKqBcoUPJaBZkHGceA3i/64wgyACcibJZvJ
	 SvQQZB0VZA5/twkKCDJqhb4yGwYtk014f4m/itOKIriJ3Gd4sI/rli0ovo7kj4rozx
	 yn+b5QCUBHefpGtWDwaS1lE2ONjaen9NbpCAuxI4V4dBuQZin0AzMi4UePHxAA9PqN
	 rCEsk6yHxQcc798r9GagN+pBEkJW7Y6Xz6CGl3xQaKb2w/bGH3kgcMnFvzfNNgBjjM
	 ct3btLeCfZq+pvlco8E69p47kG6DZ82u+GU7r+qsix7jMsScNZyU9Hq8Oe3LQMd3P1
	 s87q14jfoJleQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gMQvuttFB53D; Thu, 13 Jul 2023 15:13:35 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id AFD4F60BA4;
	Thu, 13 Jul 2023 15:13:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AFD4F60BA4
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 48B241BF841
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Jul 2023 15:13:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 20FF041761
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Jul 2023 15:13:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 20FF041761
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zYzplp3j--SF for <intel-wired-lan@lists.osuosl.org>;
 Thu, 13 Jul 2023 15:13:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 442F74174E
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 442F74174E
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Jul 2023 15:13:32 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="431383766"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; d="scan'208";a="431383766"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2023 08:13:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="725329416"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; d="scan'208";a="725329416"
Received: from unknown (HELO localhost.localdomain) ([10.237.112.144])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2023 08:13:19 -0700
Date: Thu, 13 Jul 2023 17:13:15 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Message-ID: <ZLAUi6z/UauMoIWI@localhost.localdomain>
References: <20230712222936.1048751-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230712222936.1048751-1-jacob.e.keller@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689261212; x=1720797212;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=0x2fcCUFINc1C1mkY2r3qNh4HcrZY1bdew3XjYJ1VRM=;
 b=RPHe0HrguB5/xDbeMW/XCkJVEpVAUGkoS51h44xjTQ0w61r7946noI5I
 i6NSaouRbRjjjTU+kfic/ypMF4PJGVPaxIqUrHTaWQjuzr20K3gEjNsd7
 0Kter7aNnbAC4q3sKLY1L9J/I5+NksR+LAxtH/RJO2hKmnaZQO+7emYqS
 Yg206f0TarXm35nHvI6xIbcSIKyzbXdXKnID61RBmKmhBu1BAiCi+6ws2
 D5h8uD3Tc3BNMKD1gX/EYIp1cotTh62sk95hKxNEN7mwwFhBGQvX0Ow9P
 0YHDLQmDYLPcbtuVlWN45ofKIglqGlIohZuMeoNPL47oQajWGe/BcCj5f
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=RPHe0Hrg
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] ice: replace
 ice_vf_recreate_vsi() with ice_vf_reconfig_vsi()
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
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
 przemyslaw.kitszel@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, Jul 12, 2023 at 03:29:36PM -0700, Jacob Keller wrote:
> The ice_vf_create_vsi() function and its VF ops helper introduced by commit
> a4c785e8162e ("ice: convert vf_ops .vsi_rebuild to .create_vsi") are used
> during an individual VF reset to re-create the VSI. This was done in order
> to ensure that the VSI gets properly reconfigured within the hardware.
> 
> This is somewhat heavy handed as we completely release the VSI memory and
> structure, and then create a new VSI. This can also potentially force a
> change of the VSI index as we will re-use the first open slot in the VSI
> array which may not be the same.
> 
> As part of implementing devlink reload, commit 6624e780a577 ("ice: split
> ice_vsi_setup into smaller functions") split VSI setup into smaller
> functions, introducing both ice_vsi_cfg() and ice_vsi_decfg() which can be
> used to configure or deconfigure an existing software VSI structure.
> 
> Instead of completely removing the VSI and adding a new one with the
> .create_vsi() VF operation, simply perform a reconfiguration of the VSI to
> configure its new parameters.
> 
> Call ice_vsi_decfg() to remove current VSI configuration data. Call
> ice_vsi_cfg() to reconfigure the VSI with all new configuration to match
> the modified VF configuration data.
> 
> This *does not* remove the VSI from the hardware tables, as that only
> happens if the VSI is actually fully removed via the ice_free_vsi()
> function. ice_vsi_decfg() only deconfigures but does not remove the VSI
> from the switch tables completely.
> 
> This new operation does not re-create the VSI, so rename it to
> ice_vf_reconfig_vsi().
> 
> The new approach can safely share the exact same flow for both SR-IOV VFs
> as well as the Scalable IOV VFs being worked on. This uses less code, is a
> better abstraction, and is less invasive than the previous remove and
> re-add cycle.
> 
> Co-developed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> Changes since v2:
> * Switch to ICE_VSI_FLAG_NO_INIT to avoid leaking the VSI in firwmare
> * Remove now unnecessary update of the VSI number
> 
> Thanks to Michal for pointing this out and suggesting the fix. I've added
> him as Co-developed-by for that reason.
> 
>  drivers/net/ethernet/intel/ice/ice_sriov.c  | 19 --------------
>  drivers/net/ethernet/intel/ice/ice_vf_lib.c | 28 +++++++++++++--------
>  drivers/net/ethernet/intel/ice/ice_vf_lib.h |  1 -
>  3 files changed, 18 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index 1f66914c7a20..ab96a5596d09 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -733,24 +733,6 @@ static void ice_sriov_clear_reset_trigger(struct ice_vf *vf)
>  	ice_flush(hw);
>  }

Looks good, thanks
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
