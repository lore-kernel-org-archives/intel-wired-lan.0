Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FEEC4332F
	for <intel-wired-lan@archiver.kernel.org>; Mon, 14 Nov 2022 17:08:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5CB6A8149E;
	Mon, 14 Nov 2022 17:08:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5CB6A8149E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1668445685;
	bh=uhDtTC5ywUAPECxeH6EtNG6I2wg/PkwBcP5+a/WDNsI=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=NioWLlN1cliUFkDEsszA3OK2n+gQn5Q9/3Wq2CUCxm131GQz7U4dAr0KnckdgRKZk
	 4VuXDrxsCo+DrugVO5urigkRfz35lJIkIl2+OLY/pQGlq+lvZBhErIjNPKxT0eTcRD
	 Qs1zaIuSt4M83G2el6nr36tPtqdJnniK/Rv7A7Wdbc3aCzH4QWU5WxXPPaMF6EORoy
	 GlQjGILGwSsP8vnoz8LlOmNEU04QiQHXI+IBDxpxHuB5fYgjB8rzAPAea2C4+K6yQJ
	 0RHtaykPLdJ3n/y1FQZWJmG84K9lDMp6zS+/v9k1R+skgkfKGaqsr+qey/d5x8HDCz
	 cbt7UZVSJ82+g==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vzrrDS5G65IX; Mon, 14 Nov 2022 17:08:04 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 64CC581551;
	Mon, 14 Nov 2022 17:08:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 64CC581551
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id C34A41BF31F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Nov 2022 17:08:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9D0EE41675
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Nov 2022 17:08:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9D0EE41675
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s-Rns6CdZHUb for <intel-wired-lan@lists.osuosl.org>;
 Mon, 14 Nov 2022 17:08:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 572E641673
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 572E641673
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Nov 2022 17:08:02 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 79394B81098;
 Mon, 14 Nov 2022 17:08:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67081C43470;
 Mon, 14 Nov 2022 17:07:58 +0000 (UTC)
Date: Mon, 14 Nov 2022 19:07:54 +0200
From: Leon Romanovsky <leon@kernel.org>
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <Y3J16ueuhwYeDaww@unreal>
References: <20221114125755.13659-1-michal.swiatkowski@linux.intel.com>
 <Y3JBaQ7+p5ncsjuW@unreal>
 <49e2792d-7580-e066-8d4e-183a9c826e68@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <49e2792d-7580-e066-8d4e-183a9c826e68@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1668445679;
 bh=RS7xnGRgZAWv0GWsiQFM4Ag3CewkH/FioaOOZAymmAE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=S4FDg8nS9HByEpKnAyALlb+xxBVFpiVtjCa8AQUj92sQMWpCXRSfU/HyM234f8QGA
 Bo2pNxQzpAW1rPULOp1wfWdOYolmVTQGZe4szv8XMkrud3cF7i233IvbfyFz9AXSk0
 hnPOSlQf+BGf0J7C9aPHNwBngegN0k8YAMcnk8iZOaMJv0mcZKlXTq+z8tt8ljtXF9
 Jbyyg4r6hsoJUU47qTMhm44OR296QSkFq7LTID4Q7lw5V3VMQHeFFtSDgY0I1XVCLp
 ZX4PeVXNp6qmeYEYRTGn6LDIPcLlqJiOkKhjnUBw0nd2tkTumK9IHnfcuI+AV7R899
 qL5o0rEdzEf8Q==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=S4FDg8nS
Subject: Re: [Intel-wired-lan] [PATCH net-next 00/13] resource management
 using devlink reload
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
Cc: netdev@vger.kernel.org, jiri@nvidia.com, leszek.kaliszczuk@intel.com,
 przemyslaw.kitszel@intel.com, edumazet@google.com, mustafa.ismail@intel.com,
 intel-wired-lan@lists.osuosl.org, kuba@kernel.org, pabeni@redhat.com,
 shiraz.saleem@intel.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, Nov 14, 2022 at 09:31:11AM -0600, Samudrala, Sridhar wrote:
> On 11/14/2022 7:23 AM, Leon Romanovsky wrote:
> > On Mon, Nov 14, 2022 at 01:57:42PM +0100, Michal Swiatkowski wrote:
> > > Currently the default value for number of PF vectors is number of CPUs.
> > > Because of that there are cases when all vectors are used for PF
> > > and user can't create more VFs. It is hard to set default number of
> > > CPUs right for all different use cases. Instead allow user to choose
> > > how many vectors should be used for various features. After implementing
> > > subdevices this mechanism will be also used to set number of vectors
> > > for subfunctions.
> > > 
> > > The idea is to set vectors for eth or VFs using devlink resource API.
> > > New value of vectors will be used after devlink reinit. Example
> > > commands:
> > > $ sudo devlink resource set pci/0000:31:00.0 path msix/msix_eth size 16
> > > $ sudo devlink dev reload pci/0000:31:00.0
> > > After reload driver will work with 16 vectors used for eth instead of
> > > num_cpus.
> > By saying "vectors", are you referring to MSI-X vectors?
> > If yes, you have specific interface for that.
> > https://lore.kernel.org/linux-pci/20210314124256.70253-1-leon@kernel.org/
> 
> This patch series is exposing a resources API to split the device level MSI-X vectors
> across the different functions supported by the device (PF, RDMA, SR-IOV VFs and
> in future subfunctions). Today this is all hidden in a policy implemented within
> the PF driver.

Maybe we are talking about different VFs, but if you refer to PCI VFs,
the amount of MSI-X comes from PCI config space for that specific VF.

You shouldn't set any value through netdev as it will cause to
difference in output between lspci (which doesn't require any driver)
and your newly set number.

Also in RDMA case, it is not clear what will you achieve by this
setting too.

Thanks
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
