Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0123EC54EBE
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Jan 2023 14:48:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7BEBE400F8;
	Fri, 13 Jan 2023 14:48:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7BEBE400F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1673621336;
	bh=CDa8E4c4F04aJcAdwzvUZ921L/g19UfGZC10cqlvG5I=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Tac/riJvHCtSl/PgTh1hKOCMAE4nu+49V8XLXPp0Z4FZ49l/84s/iLP0w5jFf+WL4
	 vX0P/8sMWVyi3X+yGA5mmvoNEhP96T31E1Dynh3pADUOTQRvI1lOCx8iW4PMlw57y8
	 50WvSPmFNkwmGDdmB4LOff58lRnRdhwvixm5aOF8QTowOkg6FYb8TjgfkWFK5VtAuN
	 PXwIUItVDTz/L5TUCRryddR8vZ0vCDnAnVywyPmwCe0OwJbzXt+frBh4v5wg5HhoN/
	 o/QzkjHH3qY4yZurbZVUDkk+jt4z6pae4sGAwXozNYZBR6q4P0CCO956fI3OiIzmli
	 LNCtzFaTViz1Q==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4hv-iezEbOTt; Fri, 13 Jan 2023 14:48:55 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7858F400FD;
	Fri, 13 Jan 2023 14:48:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7858F400FD
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id A263D1BF291
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Jan 2023 14:48:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7C39060AF6
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Jan 2023 14:48:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7C39060AF6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XIim1ii4oQ6W for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Jan 2023 14:48:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3347760AA0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3347760AA0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Jan 2023 14:48:52 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="321700132"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; d="scan'208";a="321700132"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2023 06:48:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="658236652"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; d="scan'208";a="658236652"
Received: from unknown (HELO localhost.localdomain) ([10.237.112.144])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2023 06:48:49 -0800
Date: Fri, 13 Jan 2023 15:48:40 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Karen Ostrowska <karen.ostrowska@intel.com>
Message-ID: <Y8FvSJyn8pSUmxET@localhost.localdomain>
References: <20230112145434.770847-1-karen.ostrowska@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230112145434.770847-1-karen.ostrowska@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1673621332; x=1705157332;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=cW9uqxA4YH61oyODJ+N93Su/31DweGbC9z02mSYIWKE=;
 b=kY9D+ulptg+8M38IwCEvTBe0Bodvytr97lGd0mTYWp+yg5rUzolH3vEg
 Qt8/EQP7KQLmrw4AkIvmwNtXl6CGPzZvpGxRak6A++8tnulYyhcIUQfKS
 2e8u0NIdNfVu9bAIIeYNrA2CMGOix2/CwUa8HWQ0x3JWcBc2mkHr1Q5G9
 tq/X/Tmc45bjbikS24WbwC8fC5ZYUlmGVmkUpVEbe8nI98X0cCJMbDyWX
 nTyDBrwmVZvZAk4pWnKK9eZJaQ3X3go4z7qt0UMeCiqbWcCCwZAK8f9mG
 dGAXqjAnTIeKMepiafWG4ivv/s2frHPhJrjGV75oU8NrMvhWneeAkL5KC
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=kY9D+ulp
Subject: Re: [Intel-wired-lan] [PATCH net v1] ice: Fix disabling Rx VLAN
 filtering with port VLAN enabled
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
Cc: Brett Creeley <brett.creeley@intel.com>, intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Jan 12, 2023 at 03:54:34PM +0100, Karen Ostrowska wrote:
> From: Brett Creeley <brett.creeley@intel.com>
> 
> If the user turns on the vf-true-promiscuous-support flag, then Rx VLAN
> filtering will be disabled if the VF requests to enable promiscuous
> mode. When the VF is in a port VLAN, this is the incorrect behavior
> because it will allow the VF to receive traffic outside of its port VLAN
> domain. Fortunately this only resulted in the VF(s) receiving broadcast
> traffic outside of the VLAN domain because all of the VLAN promiscuous
> rules are based on the port VLAN ID. Fix this by setting the
> .disable_rx_filtering VLAN op to a no-op when a port VLAN is enabled on
> the VF.
> 
> Also, make sure to make this fix for both Single VLAN Mode and Double
> VLAN Mode enabled devices.
> 
> Fixes: c31af68a1b94 ("ice: Add outer_vlan_ops and VSI specific VLAN ops
> implementations")
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Karen Ostrowska <karen.ostrowska@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)

Looks fine, thanks
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> 
> -- 
> 2.31.1
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan@osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
