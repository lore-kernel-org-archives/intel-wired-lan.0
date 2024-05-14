Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886E1C04FFE
	for <intel-wired-lan@archiver.kernel.org>; Tue, 14 May 2024 06:28:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2548482884;
	Tue, 14 May 2024 06:28:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MA5yFSdboxVL; Tue, 14 May 2024 06:28:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 17E2F82835
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1715668083;
	bh=/QzcngRfEHPfe6/RwNL6NJfU39zhtGP+T1+Iskrzqd4=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=NbZWy3Y2JjrpEAVIrDpBt/CSQT7d39P77aCV2qpT3U9jOi0LE4LzNVqHMYvsS8fSx
	 9eYqGFJwU4w5dddqkfa5+dVdRUoq1dcEgQwk7CwqU/bD0CdCeNDbC1uMc3YElEW012
	 6ZrpSM+pwUxjk9Y50zVcIsOkHMzEejz5YkZt6YafVbiAR77hO42UG1/NJ/D+p1Ygkl
	 GX4qvy1M2hPDsckzxZrNE+WK8m0cmzZbwUVeAidBDCaoF7pwN4e4c7LgAYY1HGnW9u
	 BnIvFjJAxv4tv0t4uNdOR0UdAd+B+4Ga+w/QMHsJ2XIwoOg+M8x0dURdueIdjiLGrT
	 YzkrLNiU5b5uQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 17E2F82835;
	Tue, 14 May 2024 06:28:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id E99171BF38D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 May 2024 06:27:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D4E9E60AC1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 May 2024 06:27:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a1UPO6mB-1bp for <intel-wired-lan@lists.osuosl.org>;
 Tue, 14 May 2024 06:27:58 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=michal.swiatkowski@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2C3A560ABE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2C3A560ABE
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2C3A560ABE
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 May 2024 06:27:57 +0000 (UTC)
X-CSE-ConnectionGUID: zOPOdW7ZRA6aCMVYssDTLw==
X-CSE-MsgGUID: 6VSV96h9Rn+TgcIxPx9c8w==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="11847427"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; d="scan'208";a="11847427"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2024 23:27:57 -0700
X-CSE-ConnectionGUID: c/U7QafnSAiVHGH/v6KDnw==
X-CSE-MsgGUID: M26YKeuXQC2oV9oJNWM6EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; d="scan'208";a="35125409"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2024 23:27:54 -0700
Date: Tue, 14 May 2024 08:27:22 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Simon Horman <horms@kernel.org>
Message-ID: <ZkMESjRIQc2fHF6M@mev-dev>
References: <20240513083735.54791-1-michal.swiatkowski@linux.intel.com>
 <20240513083735.54791-4-michal.swiatkowski@linux.intel.com>
 <20240513160551.GP2787@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513160551.GP2787@kernel.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715668078; x=1747204078;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=5m+xGYlMBwxNRJDWZERhtAnbSDV3/VyF/8EZ/X++y9w=;
 b=QDYdqOSiQEiwS0MQAkKX7juRTkG8LcGoy5+HYn0dUkNG961X05DkDVCa
 3A+/iTLvFE6cO6gny93IA4yD2tYJmiBddC9BUNpXIWu1+XhWDvYjqtqja
 H5dXSdZuErfLYhGjE5NiInqm5BEEqh6S0ncVsmJnXYiM2/Uz0bjFG3oyz
 0gXYe//RBooVoXpZ3NjSjXJlyHorgmLxYURiPQpINNoveVeruIYK2wJbB
 izgtcky46+PHB7J/U+aenVVIrseq7NTsr1V4KAUVKNC1QjRV18dvMrEFh
 qZcG8AXRVaIYFXbhauQSUzzecs8VZHBTJEew0NTdkymIlcszUGldLwP9D
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=QDYdqOSi
Subject: Re: [Intel-wired-lan] [iwl-next v2 03/15] ice: add basic devlink
 subfunctions support
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

On Mon, May 13, 2024 at 05:05:51PM +0100, Simon Horman wrote:
> On Mon, May 13, 2024 at 10:37:23AM +0200, Michal Swiatkowski wrote:
> 
> ...
> 
> > diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
> > index 9223bcdb6444..f20d7cc522a6 100644
> > --- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
> > +++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
> > @@ -4,9 +4,42 @@
> >  #ifndef _DEVLINK_PORT_H_
> >  #define _DEVLINK_PORT_H_
> >  
> > +#include "../ice.h"
> > +
> > +/**
> > + * struct ice_dynamic_port - Track dynamically added devlink port instance
> > + * @hw_addr: the HW address for this port
> > + * @active: true if the port has been activated
> > + * @devlink_port: the associated devlink port structure
> > + * @pf: pointer to the PF private structure
> > + * @vsi: the VSI associated with this port
> 
> nit: An entry for @sfnum should go here.
> 

Thanks, will add it

> > + *
> > + * An instance of a dynamically added devlink port. Each port flavour
> > + */
> > +struct ice_dynamic_port {
> > +	u8 hw_addr[ETH_ALEN];
> > +	u8 active: 1;
> > +	struct devlink_port devlink_port;
> > +	struct ice_pf *pf;
> > +	struct ice_vsi *vsi;
> > +	u32 sfnum;
> > +};
> 
> ...
