Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A88CDC32793
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Jan 2023 05:24:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3EF8E4002B;
	Wed, 18 Jan 2023 05:24:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3EF8E4002B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1674019462;
	bh=mHo5ekBuEruIKe4Sxb89OQTjcqgRJ/IlN74LDMS6uV8=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=LWW8UbLGDXittGBdrfd0XVOen7UiJqcnB5u9mFIR4zzqEujfBOh5TF+wdfMFnpmY0
	 YLDOSI58xVTYJnXsch4qwcGQbpnNnEcyHbIFvuAA5sW9H9FMGhYWAxL0An7vSY/OK7
	 jUUTQyYZS9Nexu58Ltlw6aW9pV9xWSwlC1H7zkG1WX9j3aiCavfyrR0Zx0EWAV6HX5
	 WCHiviD4cmKmqdm6Q2u/3xZxCz1918OpDCrAz1CC0N4HInd5BDZSp75V6nPPGTUtd2
	 pAvvh2R7HrP1yIwm/Ph7FPMd3/m1CjJ1jksJlwsi1gefNfHRbCffRqlQzeyM3eVVR4
	 LgG1IEd2kKoDQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gGzYJ0SGo3JA; Wed, 18 Jan 2023 05:24:21 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 241AE40117;
	Wed, 18 Jan 2023 05:24:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 241AE40117
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 265531BF42C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Jan 2023 05:24:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0266141583
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Jan 2023 05:24:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0266141583
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EVLddwGcE7ei for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Jan 2023 05:24:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D53E141579
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D53E141579
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Jan 2023 05:24:18 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="389402355"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; d="scan'208";a="389402355"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jan 2023 21:24:17 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="833426868"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; d="scan'208";a="833426868"
Received: from unknown (HELO localhost.localdomain) ([10.237.112.144])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jan 2023 21:24:16 -0800
Date: Wed, 18 Jan 2023 06:24:08 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Message-ID: <Y8eCeAkhm4NC3YiU@localhost.localdomain>
References: <20230113223735.2514364-1-jacob.e.keller@intel.com>
 <20230113223735.2514364-5-jacob.e.keller@intel.com>
 <Y8UtV5QqESWncLcP@localhost.localdomain>
 <9c960749-d369-4b25-c626-e4ed74163c64@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9c960749-d369-4b25-c626-e4ed74163c64@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1674019458; x=1705555458;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=LNsYB7QEAsgX7i+rv/mcW0R3ZCkoPsgFqU8d00J4VZI=;
 b=kTu4hHc10lShPSS4CC7QxqDMQvKHnwu9CecVevN/7/PeWvoOAyjzHpik
 loKaFLCgSbXW3U1ks9f3cLGfyFBf3FEnWHcOWb2pJdxg1llX1dpfLUEra
 zj2tSM8DTrrOFii7eOUrUi5cVMzoA/8SwNuj9JjW6O2bfj6t7SO+MYirC
 T9tWtcLWoTi0Ir7R/S36MrqDaq3nXMaVJdENJXjnUQeZjxVSK74vP6QnI
 KCtxmDoClvn7xbUQUVGufDDPoZFe+ROmpiJ4s7Hnb3vu8lgtwF6qkDZBK
 fFLWrkGjIFhQUpR1wiMAAFXFwWjty0tYFyScgsKuzGPPteQok/XytwxTT
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=kTu4hHc1
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

On Tue, Jan 17, 2023 at 11:23:00AM -0800, Jacob Keller wrote:
> 
> 
> On 1/16/2023 2:56 AM, Michal Swiatkowski wrote:
> > On Fri, Jan 13, 2023 at 02:37:26PM -0800, Jacob Keller wrote:
> >> A few places in ice_lib.c WARN if the VSI type is VF and the VF pointer is
> >> NULL. This helps protect against accidentally creating a ICE_VSI_VF without
> >> providing a VF pointer.
> >>
> >> A future change is going to introduce another type of VSI which has the
> >> same requirement, ICE_VSI_ADI. Instead of expanding each WARN_ON check to
> >> include both types, introduce a helper function to do this check. The
> >> ice_vsi_requires_vf function returns true if the VSI *must* have a VF, and
> >> returns false otherwise.
> >>
> >> Of specific note is that some VSI types may optionally have a VF but do not
> >> require them, such as the ICE_VSI_CTRL type. These return false.
> >>
> >> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> >> ---
> >>  drivers/net/ethernet/intel/ice/ice_lib.c | 26 +++++++++++++++++++++---
> >>  1 file changed, 23 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> >> index f89279ede9a1..79555e22a9be 100644
> >> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> >> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> >> @@ -34,6 +34,26 @@ const char *ice_vsi_type_str(enum ice_vsi_type vsi_type)
> >>  	}
> >>  }
> >>  
> >> +/**
> >> + * ice_vsi_requires_vf - Does this VSI type always require a VF?
> >> + * @vsi_type: the VSI type
> >> + *
> >> + * Returns true if the VSI type *must* have a VF pointer. Returns false
> >> + * otherwise. In particular, VSI types which may *optionally* have a VF
> >> + * pointer return false.
> >> + *
> >> + * Used to WARN in cases where we always expect a VF pointer to be non-NULL.
> >> + */
> >> +static int ice_vsi_requires_vf(enum ice_vsi_type vsi_type)
> >> +{
> >> +	switch (vsi_type) {
> >> +	case ICE_VSI_VF:
> >> +		return true;
> >> +	default:
> >> +		return false;
> >> +	}
> >> +}
> > Looks a little strange right now. Maybe send this whole patch with SIOV
> > series?
> > 
> 
> I can do that, but the main challenge is the number of patches. We're
> going to have to send the ice driver implementation as well as the
> inet_vdcm driver implementation in the VFIO subfolder. This could easily
> hit 15 patches, so I've been trying to find as many places where we can
> split patches to other series as possible.
> 
> It is definitely odd now, and I could refactor this part to not be a
> switch/case and make it switch/case later with the changes that
> introduce scalable? But I don't really want the changes that switch to
> using ice_vsi_requires_vf to be part of that patch...

Understand, it is fine for me, changing it to switch/case later seems
like good solution. I think You can also send it as it is right now, it
isn't big thing. I pointed it out, because I didn't know the reasone.

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
