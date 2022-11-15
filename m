Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2EC6C433FE
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Nov 2022 12:47:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 74C834010C;
	Tue, 15 Nov 2022 12:47:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 74C834010C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1668516464;
	bh=KqJWxf6F6gzCYyr/qqJwP18yFRcIxUwax7z2WoobSI0=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=2TMzRAGRXSr/YGiI8A71XW/vVVgzlX4fV2mmV366iyD8XGFEK7HdAjoU0KOY8iX2Y
	 U4/9bMAyinsqWm9XSW1jM1kKrIhZxIUF2HF/4Qq9deeaNNB8P+hzU0FpA85kHS23pY
	 WJu56uGCMYA75H8vzER27FoOHSTu2Hb203m/f/Ae6zaa5oPLgY+MD2+kTJthok+UzU
	 CTX0xnun7emn8bHLNCi2m9eghinupLIdLy/orZb7k10IkSveLMq+XPJhGj43uVKCjp
	 G0i0Ipg1XhFGVEo5NIjSK4Ce8yrJMr+AMQLXd6/n3OvBYGHiZNaYayy1QPicRLatfj
	 z0EHRBUI/dbsg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vc34sLCW6z46; Tue, 15 Nov 2022 12:47:43 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6D2AA4038B;
	Tue, 15 Nov 2022 12:47:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6D2AA4038B
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 285851BF348
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Nov 2022 12:47:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F00EB6066D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Nov 2022 12:47:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F00EB6066D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pX7J7YlLa0Qc for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Nov 2022 12:47:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4511A605A0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4511A605A0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Nov 2022 12:47:41 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="295608170"
X-IronPort-AV: E=Sophos;i="5.96,165,1665471600"; d="scan'208";a="295608170"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2022 04:47:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="707723978"
X-IronPort-AV: E=Sophos;i="5.96,165,1665471600"; d="scan'208";a="707723978"
Received: from unknown (HELO localhost.localdomain) ([10.237.112.144])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2022 04:47:38 -0800
Date: Tue, 15 Nov 2022 13:47:35 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: "Saleem, Shiraz" <shiraz.saleem@intel.com>
Message-ID: <Y3OKZx8eAj3KwHB9@localhost.localdomain>
References: <20221114082048.9704-1-michal.swiatkowski@linux.intel.com>
 <MWHPR11MB002973559040490B1377165BE9059@MWHPR11MB0029.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MWHPR11MB002973559040490B1377165BE9059@MWHPR11MB0029.namprd11.prod.outlook.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1668516461; x=1700052461;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=dN8tgK9VdZSHBBwihF3mxVF86MUSbhbkxmTmwLu5qoE=;
 b=fk452euYLa/AW6Y7Ne30SnFyp3TpqhxhUO/B1guBV7Sihjfgwr8MGCs9
 Ma7DqmiNeZtY1OZAdM2FKOiUw6Mp9IUJ1pt0vTZkHJkSLYMzJFrJGmzdR
 fosVfe+2ZQ6cK8DCpGVv60Vsbz4SC8PF5aFASU/gn/B+O+yZz830wBcww
 eXnr7CzVO3MuukBFw9xJw55BS/1tlCLnwHRETnLahNWeePUceiOGVXinZ
 mBw9k7Cw/3kKvuVYuVQmqCMVhZBh1Wg3iLyFFDHKy/3xgm1spSoRUZ0av
 o6R9UE+FeS9u7Ag7HfOpRQpcGEmwssIUoVv6uidosl4NVbAZgVabmwvFH
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=fk452euY
Subject: Re: [Intel-wired-lan] [net-next] irdma: change name of interrupts
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
Cc: "Ismail, Mustafa" <mustafa.ismail@intel.com>, "Bednarz,
 Christopher N" <christopher.n.bednarz@intel.com>, "Barrera,
 Ivan D" <ivan.d.barrera@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, Nov 14, 2022 at 04:19:20PM +0000, Saleem, Shiraz wrote:
> > Subject: [net-next] irdma: change name of interrupts
> > 
> 
> This cant go through net-next. It needs to go through the rdma tree. I will co-ordinate w. Tony on it.
> 
> Use "RDMA/irdma: change name of interrupts" for the subject.
>

I will remember, is "rdma" the name of tree?

> > Add more information in interrupt names.
> > 
> > Before this patch it was:
> > irdma
> > CEQ
> > CEQ
> > ...
> > 
> > Now:
> > irdma-ice-AEQ
> > irdma-ice-CEQ-0
> > irdma-ice-CEQ-1
> 
> This is better for sure. But we need to add the device name. Not sure if adding "ice" is adding any value.
> 
> Ideally, for the RDMA drivers, this should be ib_device name. But there is a limitation in RDMA subsystem that doesn't
> set the name till after the ib device is registered which happens later in the drv.probe() flow.
> 
> So I think our best option is to use the PCI device name.
> 

Sure, will change it, thanks.

> > ...
> > 
> > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > Suggested-by: Piotr Raczynski <piotr.raczynski@intel.com>
> > ---
> >  drivers/infiniband/hw/irdma/defs.h |  2 ++
> >  drivers/infiniband/hw/irdma/hw.c   | 14 +++++++++++---
> >  drivers/infiniband/hw/irdma/main.h |  1 +
> >  3 files changed, 14 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/infiniband/hw/irdma/defs.h b/drivers/infiniband/hw/irdma/defs.h
> > index c1906cab5c8a..09e4aba31b64 100644
> > --- a/drivers/infiniband/hw/irdma/defs.h
> > +++ b/drivers/infiniband/hw/irdma/defs.h
> > @@ -20,6 +20,8 @@
> >  #define IRDMA_IRD_HW_SIZE_128	3
> >  #define IRDMA_IRD_HW_SIZE_256	4
> > 
> > +#define IRDMA_INT_NAME_STR_LEN (32)
> 
> INT to IRQ which is more used in this driver to reflect interrupt. Drop the (). And move to this main.h where the irdma_msix_vector struct is defined.
>

Done

> > +
> >  enum irdma_protocol_used {
> >  	IRDMA_ANY_PROTOCOL = 0,
> >  	IRDMA_IWARP_PROTOCOL_ONLY = 1,
> > diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
> > index ab246447520b..46665624e515 100644
> > --- a/drivers/infiniband/hw/irdma/hw.c
> > +++ b/drivers/infiniband/hw/irdma/hw.c
> > @@ -1087,14 +1087,20 @@ static int irdma_cfg_ceq_vector(struct irdma_pci_f *rf,
> > struct irdma_ceq *iwceq,
> >  	int status;
> > 
> >  	if (rf->msix_shared && !ceq_id) {
> > +		snprintf(msix_vec->name, sizeof(msix_vec->name) - 1,
> > +			 "irdma-%s-AEQCEQ-%d",
> > +			 dev_driver_string(&rf->pcidev->dev), ceq_id);
> 
> As per previous comment, I think dev_name((&rf->pcidev->dev) is better. Given this should we make the msix_vec.name be a 64b variable?
>

Yeah, it looks better, thanks. I changed name to 64b.

> Shiraz
> 
> 
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
