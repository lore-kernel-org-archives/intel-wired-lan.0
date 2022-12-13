Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88B8C4332F
	for <intel-wired-lan@archiver.kernel.org>; Tue, 13 Dec 2022 06:37:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3F6354053E;
	Tue, 13 Dec 2022 06:37:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3F6354053E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1670913465;
	bh=QuIKqcc72GmEVmp/1aNtU6jUu5LCsC7709FViKbFRdU=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=9ePLnSBiohbtEc/zalSRzd24TrcDoEh7SMQrPrz2PudY7sHhRCohB3J/zmjtOIB7T
	 hcX/EFGz4x3T8YiZqf8i/rVAH9J6ruEMZ+y1ki6TKABy17CADe4i+lRMI+z1CIIc5Q
	 byO82p83cgcHdTGCWDrv3UTNUByQ+MOYV+2rv58UCTZ9RPuFv2A6qxGVe+jyhE06Cx
	 5vXIp2/rvK0bmj42VWxNEqfXyHuySRHTmcyfGf0k9wNTmAwesf9E4gaDmYUKQO/3Oy
	 GrYJdnIKEaMn8UfhHYdlMivnCnRvmAoBPoZ/gbgWIYm9wmxsc+VUDnOpmC6zcX2oxf
	 VqbyUAD/XnkTg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fxkBwZZrjAn8; Tue, 13 Dec 2022 06:37:44 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2D6474058F;
	Tue, 13 Dec 2022 06:37:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2D6474058F
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id CAF191BF2E5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Dec 2022 06:37:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A4EF381D47
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Dec 2022 06:37:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A4EF381D47
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RRbwheCfTIWX for <intel-wired-lan@lists.osuosl.org>;
 Tue, 13 Dec 2022 06:37:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 074AF81D4D
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 074AF81D4D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Dec 2022 06:37:41 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="404313613"
X-IronPort-AV: E=Sophos;i="5.96,240,1665471600"; d="scan'208";a="404313613"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2022 22:37:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="648455189"
X-IronPort-AV: E=Sophos;i="5.96,240,1665471600"; d="scan'208";a="648455189"
Received: from unknown (HELO localhost.localdomain) ([10.237.112.144])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2022 22:37:33 -0800
Date: Tue, 13 Dec 2022 07:37:26 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Message-ID: <Y5gdpoif/1zBUKDB@localhost.localdomain>
References: <20221212111645.1198680-1-michal.swiatkowski@linux.intel.com>
 <20221212101505.403a4084@kernel.org>
 <f0078f0a-acbc-a9bd-effd-6d04507e71e2@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f0078f0a-acbc-a9bd-effd-6d04507e71e2@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1670913462; x=1702449462;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=OqFkktenWvRJT3uBFfhmwjcobPWl6vfKLitPa/v/UoU=;
 b=SHzGpIo0FREOxZOyc0jzuSEyiLNOkxO9Z/OOpwlk2jbbTpFsd8NKpcJ9
 qbGV6HR4mQkTu5kAlr6J8ArtA++cUrwDCxzMtjNjSZRUpq14XGSyJB4Ch
 8er+JldggH18AJBXV5b+lAwyG/zCTKAssAMRLhWj3SaSwkvtYoTSoritb
 +eQh3c30djTfrfX0xOXGqPzWlcxjQExqaes0qkk7ZAE1R4mMV20ZEB/6H
 jMyGjwj2oiCZXhpbqsM5QZiFXBplhU7rwOlOMxS0lKrAdBYP7i+liA9xH
 YDlShau6O1rdz3GIZYThrDdYR5/DexlEjDHyi/Z/U8QnY9QRV1K1CUGC9
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=SHzGpIo0
Subject: Re: [Intel-wired-lan] [PATCH net-next v1 00/10] implement devlink
 reload in ice
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
Cc: mustafa.ismail@intel.com, leon@kernel.org, benjamin.mikailenko@intel.com,
 jesse.brandeburg@intel.com, leszek.kaliszczuk@intel.com,
 netdev@vger.kernel.org, przemyslaw.kitszel@intel.com,
 Jakub Kicinski <kuba@kernel.org>, intel-wired-lan@lists.osuosl.org,
 shiraz.saleem@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, Dec 12, 2022 at 10:46:09AM -0800, Jacob Keller wrote:
> 
> 
> On 12/12/2022 10:15 AM, Jakub Kicinski wrote:
> > On Mon, 12 Dec 2022 12:16:35 +0100 Michal Swiatkowski wrote:
> > > This is a part of changes done in patchset [0]. Resource management is
> > > kind of controversial part, so I split it into two patchsets.
> > > 
> > > It is the first one, covering refactor and implement reload API call.
> > > The refactor will unblock some of the patches needed by SIOV or
> > > subfunction.
> > > 
> > > Most of this patchset is about implementing driver reload mechanism.
> > > Part of code from probe and rebuild is used to not duplicate code.
> > > To allow this reuse probe and rebuild path are split into smaller
> > > functions.
> > > 
> > > Patch "ice: split ice_vsi_setup into smaller functions" changes
> > > boolean variable in function call to integer and adds define
> > > for it. Instead of having the function called with true/false now it
> > > can be called with readable defines ICE_VSI_FLAG_INIT or
> > > ICE_VSI_FLAG_NO_INIT. It was suggested by Jacob Keller and probably this
> > > mechanism will be implemented across ice driver in follow up patchset.
> > 
> > Does not apply, unfortunately, which makes it easier for me to answer
> > to the question "should I try to squeeze this into 6.2"..
> > Hopefully we can get some reviews, but the changes seem uncontroversial.
> 
> Yea it seems a bit late to make it into 6.2, as much as that would be nice.
> 
> We can always hold and test it on iwl until net-next re-opens.
> 

It was targeted to Tony dev-queue to allow some tests as Jake said.
Sorry, probably I should point it out in cover letter.

Most of the changes are refactor of probe / remove path, so it will be
good to have some tests from iwl. I (or Tony as pull request) will send
it when the net-next re-opens. Thanks

> Thanks,
> Jake
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
