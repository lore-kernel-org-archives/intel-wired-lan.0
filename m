Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0704C25B10
	for <intel-wired-lan@archiver.kernel.org>; Fri, 10 May 2024 07:31:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7107C61579;
	Fri, 10 May 2024 07:31:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7nydFxdmajnc; Fri, 10 May 2024 07:31:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B80256157C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1715326313;
	bh=w9X/9RHDSiQCIKC45JHyk6P3CElR5S/wa2q4LlTUczw=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=0vKDlV6E7OIt+0UTWiPGPZ3f2uCInIj8Z6GVuRSMh819Q6FeNhcYOjXUZdLf1rKvh
	 PDGkSgUzbua3fPsTg43OL6yCZSfGeNgJkZg5dmy0cOVIYMW11KN2cgdSaxm/vq/fWh
	 geNyUOTX35nlzgme+ei75GPufklvSlr0dUMvCTtuHuBoWcikAPt6RVNIUyjkd4gLaU
	 XNM4vo9A3/kUAndKb7jfoV2qAlIat2TEEjF1BFccx1hgh87RTl/+8q6wc70dWHdW0W
	 pjss11TGdNoiUWNi7410mfAFer+NUKAEIzirmJAdiYux1GKG3BDuAORYNZvtd0cLMf
	 /Ec1wmFrlg34Q==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id B80256157C;
	Fri, 10 May 2024 07:31:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id A4FF51BF5DC
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 May 2024 07:31:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9BD484238C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 May 2024 07:31:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LQKY6XAG_Ip6 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 10 May 2024 07:31:51 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.9;
 helo=mgamail.intel.com; envelope-from=michal.swiatkowski@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6CE2E4230F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6CE2E4230F
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6CE2E4230F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 May 2024 07:31:50 +0000 (UTC)
X-CSE-ConnectionGUID: v4z7WVdQRzGhAcgsHhRqQw==
X-CSE-MsgGUID: 77FFulTzQQqxJ6jX2LnQbQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="21965488"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; d="scan'208";a="21965488"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2024 00:31:50 -0700
X-CSE-ConnectionGUID: z0ndINDHSoSj337AvYImAg==
X-CSE-MsgGUID: 4Jd23kDZRk+YaMH5xlz0HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; d="scan'208";a="29906290"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2024 00:31:47 -0700
Date: Fri, 10 May 2024 09:31:15 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Message-ID: <Zj3NQw1BxqtOS9VG@mev-dev>
References: <20240507114516.9765-1-michal.swiatkowski@linux.intel.com>
 <20240507114516.9765-9-michal.swiatkowski@linux.intel.com>
 <ZjywddcaIae0W_w3@nanopsycho.orion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjywddcaIae0W_w3@nanopsycho.orion>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715326312; x=1746862312;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=OAlirC+gOM9PRA8w/mTLy087HEypbm6XLwuNEFoWgWY=;
 b=ZROEHxUHGZWpcbKrZqyfdqEPCRuIvqCk00Js8jTxjjrrvJnDl/LYymBz
 du7zCkQmskaHYRjZwlaPis8MAIWNLV2mZLiRc62nnMZhPYsFsD2vE1qYo
 tfNT77g1Df4YgoLwYOsSCUr6I5o9QZ4UVRfAPBD7c9sn9Zmtl7XkURG5V
 XkXpAvH+iHDHDrUGK4z2Xz3pw2kNtSIzOwi+T2C0e2OYwaWXzj1ylItF5
 wGZMe+Smds1emtrfLsgEP2uKkzBWKt+KqrliF3+3IWbwdEU35ecibGJOu
 SU6JoBQqs6AWZupxikt08QVC9DH3+CmNokwp7dIMXvT6w8R516bCkpVs/
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ZROEHxUH
Subject: Re: [Intel-wired-lan] [iwl-next v1 08/14] ice: create port
 representor for SF
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
 michal.kubiak@intel.com, intel-wired-lan@lists.osuosl.org,
 pio.raczynski@gmail.com, sridhar.samudrala@intel.com, jacob.e.keller@intel.com,
 wojciech.drewek@intel.com, przemyslaw.kitszel@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, May 09, 2024 at 01:16:05PM +0200, Jiri Pirko wrote:
> Tue, May 07, 2024 at 01:45:09PM CEST, michal.swiatkowski@linux.intel.com wrote:
> >Store subfunction and VF pointer in port representor structure as an
> >union. Add port representor type to distinguish between each of them.
> >
> >Keep the same flow of port representor creation, but instead of general
> >attach function create helpers for VF and subfunction attach function.
> >
> >Type of port representor can be also known based on VSI type, but it
> >is more clean to have it directly saved in port representor structure.
> >
> >Create port representor when subfunction port is created.
> >
> >Add devlink lock for whole VF port representor creation and destruction.
> >It is done to be symmetric with what happens in case of SF port
> >representor. SF port representor is always added or removed with devlink
> >lock taken. Doing the same with VF port representor simplify logic.
> >
> >Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> >Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> >---
> > .../ethernet/intel/ice/devlink/devlink_port.c |   6 +-
> > .../ethernet/intel/ice/devlink/devlink_port.h |   1 +
> > drivers/net/ethernet/intel/ice/ice_eswitch.c  |  85 +++++++++---
> > drivers/net/ethernet/intel/ice/ice_eswitch.h  |  22 +++-
> > drivers/net/ethernet/intel/ice/ice_repr.c     | 124 +++++++++++-------
> > drivers/net/ethernet/intel/ice/ice_repr.h     |  21 ++-
> > drivers/net/ethernet/intel/ice/ice_sriov.c    |   4 +-
> > drivers/net/ethernet/intel/ice/ice_vf_lib.c   |   4 +-
> > 8 files changed, 187 insertions(+), 80 deletions(-)
> 
> This calls for a split to at least 2 patches. One patch to prepare and
> one to add the SF support?

Is 187 insertions and 80 deletions too many for one patch? Or the
problem is with number of files changed?

I don't see what here can be moved to preparation part as most changes
depends on each other. Do you want me to have one patch with unused
functions that are adding/removing SF repr and another with calling
them?

Thanks,
Michal
