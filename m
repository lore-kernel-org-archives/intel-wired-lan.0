Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CD2109879F
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Mar 2026 15:49:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F387241E57;
	Fri, 20 Mar 2026 15:49:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eET6EMc8BQmI; Fri, 20 Mar 2026 15:49:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3B8CB41E54
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774021766;
	bh=1noh5STaRC1HybhuYlkIMhR1r7TUdhM17pEfO/82ZhA=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QPZ9x7cpSspl0qqgzRlpoZFo5dGCPSKGLHxCXpnY2kTT19HIfE//MdDTsI5TJm4MF
	 7AzrVa7l86VgDr0q/8G2XwwftEGHK2kz4X/ZWM5liZjTRbv2w98le6UbRciENCj/sZ
	 +FN4S65Dj1W6VrF/6x/hRH114s3DeQAFFUQQUaN34c91RtwS00cgGWQgE1IJIzupE5
	 VaSVUh+kYAK4aQI1oxNRTmbg0rN8j9krlBopCTyHh0O3IaBq4litnUCpN5HWsnUN5T
	 cCnRYZ3jHxQ5zXQ+mOYZmxcZ+nMtsKdS4ckzuNAASiRjLWHoLePFLjCTIpi8NKpYEm
	 1bMwPkWYuhSiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B8CB41E54;
	Fri, 20 Mar 2026 15:49:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B17425C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 15:49:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3089C61B66
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 15:49:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xhs57qi3lRNr for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Mar 2026 15:49:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com;
 envelope-from=stfomichev@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7726261B51
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7726261B51
Received: from mail-dy1-x132a.google.com (mail-dy1-x132a.google.com
 [IPv6:2607:f8b0:4864:20::132a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7726261B51
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 15:49:23 +0000 (UTC)
Received: by mail-dy1-x132a.google.com with SMTP id
 5a478bee46e88-2c0ea57fea7so2315600eec.0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 08:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774021762; x=1774626562;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1noh5STaRC1HybhuYlkIMhR1r7TUdhM17pEfO/82ZhA=;
 b=f9HoPfRupljUhw1SbW+KZLokDEYGEenJ2BbnQR/Gf4odZ59CYf2cBAA2+T8YsOUw9P
 TUtbVhNE9u2BlJ8shGMJEcKAUgZnCRTM9n45OUtAqBd401mnEAuSD1M/yiWtg7wQteo7
 wg+ec+Z4am4eSu5Th2fps7LFH6owOcyLWAhAzb/aqwYHN2eO2xydeCQwXdCF9yHRcxCi
 61yybckENaxrwnsat9aTn4KpY0nVKAM7SPds2BfwFQROLByRLBgUobsZB9UgwImzrMwK
 9pO1FYpAxzca3FN9OaL9rhAqsoCFHTXgmhFmKIzR6j6ASgtW0JjxvN6Ldvq9vBGk/elW
 tbOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuCDoJFB5UzWNfz6zKtjEvQqDt4wLVbXfvB3DuFz8nEarkCUfmQSFXYzincIPLzQT605ET3qKLCYt4tOqSGQ0=@lists.osuosl.org
X-Gm-Message-State: AOJu0YwLGsjPDeVgmn9u8CobXOEOo1SW3u9yZNXhaOc9dTp2ZRVlpHLX
 1h+Kw6NUyFyghs7/YMnNLd/Rht/kj+W0Ux9T9Yyil710ktRAF3MG7bM=
X-Gm-Gg: ATEYQzxtbTAsKsX0ByOI5m9aRayZiEdVwW6J36OgTZq1NbBW+XuUumt3Zo/HWsz1/M/
 4QEkldH22SPj4UUhlK248pqf3pdDSooVtCG/XqVM97QX5OEvPNEFOUv+YJ06g9u2m8kD4RjoM2l
 +AFQrZygW12sCfi/RTGQVM/p5VgOLKaK2G4zz8mOSTpNJdf1M0HgeMyXbRxszrdTnt6NR2wIITv
 CrAQLnBgKNNkpLW03XWdgH8iNXr5U13M/yKr1iqNvBtU4uRc5NCAeO7GFWcJGpsZU3ATHSVETJM
 RgyM+CiB5wT1WAsdeTz/26O6AlmvSHfe04YgcwGuzQC225xtuEdbMfcezd2+NcXu4INw84EkbvO
 rjQRXIQg0h2/KWWRsZf5F/DlOFJXkvuzSVekkFzKcSFb1YdedIbNxSaM11vYUi1yt8hQplrUfzl
 DHfAeUZOiow8rewruthKzuo4xWAFsQXmPTez4c0l6YGKxypxfoczl/ZRL7B+xTfF+0vPExz5X6Z
 iks59g+snOUNZNwB6Sr7ogEbC/g
X-Received: by 2002:a05:693c:3106:b0:2b7:b7e7:9025 with SMTP id
 5a478bee46e88-2c10980a36dmr1639723eec.31.1774021762125; 
 Fri, 20 Mar 2026 08:49:22 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b17b1b8sm3724371eec.8.2026.03.20.08.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 08:49:21 -0700 (PDT)
Date: Fri, 20 Mar 2026 08:49:20 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "horms@kernel.org" <horms@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
 "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "michael.chan@broadcom.com" <michael.chan@broadcom.com>,
 "pavan.chebbi@broadcom.com" <pavan.chebbi@broadcom.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "saeedm@nvidia.com" <saeedm@nvidia.com>,
 "tariqt@nvidia.com" <tariqt@nvidia.com>,
 "mbloch@nvidia.com" <mbloch@nvidia.com>,
 "alexanderduyck@fb.com" <alexanderduyck@fb.com>,
 "kernel-team@meta.com" <kernel-team@meta.com>,
 "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
 "sd@queasysnail.net" <sd@queasysnail.net>,
 "jianbol@nvidia.com" <jianbol@nvidia.com>,
 "dtatulea@nvidia.com" <dtatulea@nvidia.com>,
 "mohsin.bashr@gmail.com" <mohsin.bashr@gmail.com>,
 "Keller, Jacob E" <jacob.e.keller@intel.com>,
 "willemb@google.com" <willemb@google.com>,
 "skhawaja@google.com" <skhawaja@google.com>,
 "bestswngs@gmail.com" <bestswngs@gmail.com>,
 "kees@kernel.org" <kees@kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "leon@kernel.org" <leon@kernel.org>
Message-ID: <ab1sgEg9ii3se1Zq@mini-arch>
Mail-Followup-To: Stanislav Fomichev <stfomichev@gmail.com>,
 "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "horms@kernel.org" <horms@kernel.org>,
 "corbet@lwn.net" <corbet@lwn.net>,
 "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "michael.chan@broadcom.com" <michael.chan@broadcom.com>,
 "pavan.chebbi@broadcom.com" <pavan.chebbi@broadcom.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "saeedm@nvidia.com" <saeedm@nvidia.com>,
 "tariqt@nvidia.com" <tariqt@nvidia.com>,
 "mbloch@nvidia.com" <mbloch@nvidia.com>,
 "alexanderduyck@fb.com" <alexanderduyck@fb.com>,
 "kernel-team@meta.com" <kernel-team@meta.com>,
 "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
 "sd@queasysnail.net" <sd@queasysnail.net>,
 "jianbol@nvidia.com" <jianbol@nvidia.com>,
 "dtatulea@nvidia.com" <dtatulea@nvidia.com>,
 "mohsin.bashr@gmail.com" <mohsin.bashr@gmail.com>,
 "Keller, Jacob E" <jacob.e.keller@intel.com>,
 "willemb@google.com" <willemb@google.com>,
 "skhawaja@google.com" <skhawaja@google.com>,
 "bestswngs@gmail.com" <bestswngs@gmail.com>,
 "kees@kernel.org" <kees@kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "leon@kernel.org" <leon@kernel.org>
References: <20260320012501.2033548-1-sdf@fomichev.me>
 <20260320012501.2033548-4-sdf@fomichev.me>
 <IA3PR11MB89865C96824F6518F4A01B9CE54CA@IA3PR11MB8986.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <IA3PR11MB89865C96824F6518F4A01B9CE54CA@IA3PR11MB8986.namprd11.prod.outlook.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774021762; x=1774626562; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1noh5STaRC1HybhuYlkIMhR1r7TUdhM17pEfO/82ZhA=;
 b=JIEqeC61lwadqBz3YT6Rg7jzi0JQhZyWxAa3U7fg1P5J24S6WOLkmVqbHapHa+dVWi
 pfUNfahRq7T+IGmNjZnHkswtdZlFdviceVHCmnTXkR7mVQFobhkDjwma8xySpmqvUgrN
 t3xcSp0nB4chkzlwqcXqNCO63EDMloKR0J1u0zV74O1PXUot3dygR6I8NEB8B+8nulUC
 AdQWUaaEo7IV3oWUd8h8YU8E/wQ3ipweKA6UZexH7zjvk+ZNkjPkczBLeAWrb3udZEXX
 czA3LO0tLi8nukk0KiNfW1xTIUU6rvMuohrBAjLkHciB5SKVfkjuExFPYW8BECGkUUh6
 J10A==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20230601 header.b=JIEqeC61
Subject: Re: [Intel-wired-lan] [PATCH net-next v3 03/13] net: introduce
 ndo_set_rx_mode_async and dev_rx_mode_work
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
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
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 03/20, Loktionov, Aleksandr wrote:
> 
> 
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Stanislav Fomichev
> > Sent: Friday, March 20, 2026 2:25 AM
> > To: netdev@vger.kernel.org
> > Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > pabeni@redhat.com; horms@kernel.org; corbet@lwn.net;
> > skhan@linuxfoundation.org; andrew+netdev@lunn.ch;
> > michael.chan@broadcom.com; pavan.chebbi@broadcom.com; Nguyen, Anthony
> > L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> > <przemyslaw.kitszel@intel.com>; saeedm@nvidia.com; tariqt@nvidia.com;
> > mbloch@nvidia.com; alexanderduyck@fb.com; kernel-team@meta.com;
> > johannes@sipsolutions.net; sd@queasysnail.net; jianbol@nvidia.com;
> > dtatulea@nvidia.com; sdf@fomichev.me; mohsin.bashr@gmail.com; Keller,
> > Jacob E <jacob.e.keller@intel.com>; willemb@google.com;
> > skhawaja@google.com; bestswngs@gmail.com; Loktionov, Aleksandr
> > <aleksandr.loktionov@intel.com>; kees@kernel.org; linux-
> > doc@vger.kernel.org; linux-kernel@vger.kernel.org; intel-wired-
> > lan@lists.osuosl.org; linux-rdma@vger.kernel.org; linux-
> > wireless@vger.kernel.org; linux-kselftest@vger.kernel.org;
> > leon@kernel.org
> > Subject: [Intel-wired-lan] [PATCH net-next v3 03/13] net: introduce
> > ndo_set_rx_mode_async and dev_rx_mode_work
> > 
> > Add ndo_set_rx_mode_async callback that drivers can implement instead
> > of the legacy ndo_set_rx_mode. The legacy callback runs under the
> > netif_addr_lock spinlock with BHs disabled, preventing drivers from
> > sleeping. The async variant runs from a work queue with rtnl_lock and
> > netdev_lock_ops held, in fully sleepable context.
> > 
> > When __dev_set_rx_mode() sees ndo_set_rx_mode_async, it schedules
> > dev_rx_mode_work instead of calling the driver inline. The work
> > function takes two snapshots of each address list (uc/mc) under the
> > addr_lock, then drops the lock and calls the driver with the work
> > copies. After the driver returns, it reconciles the snapshots back to
> > the real lists under the lock.
> > 
> > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  Documentation/networking/netdevices.rst |  8 +++
> >  include/linux/netdevice.h               | 20 ++++++
> >  net/core/dev.c                          | 95 +++++++++++++++++++++++-
> > -
> >  3 files changed, 116 insertions(+), 7 deletions(-)
> > 
> > diff --git a/Documentation/networking/netdevices.rst
> > b/Documentation/networking/netdevices.rst
> > index 35704d115312..dc83d78d3b27 100644
> > --- a/Documentation/networking/netdevices.rst
> > +++ b/Documentation/networking/netdevices.rst
> > @@ -289,6 +289,14 @@ struct net_device synchronization rules
> >  ndo_set_rx_mode:
> >  	Synchronization: netif_addr_lock spinlock.
> >  	Context: BHs disabled
> 
> ...
> 
> > to
> > +device
> > + * and configure RX filtering.
> > + * @dev: device
> > + *
> > + * When the device doesn't support unicast filtering it is put in
> > +promiscuous
> > + * mode while unicast addresses are present.
> >   */
> >  void __dev_set_rx_mode(struct net_device *dev)  {
> >  	const struct net_device_ops *ops = dev->netdev_ops;
> > 
> >  	/* dev_open will call this function so the list will stay sane.
> > */
> > -	if (!(dev->flags&IFF_UP))
> > +	if (!netif_up_and_present(dev))
> >  		return;
> > 
> > -	if (!netif_device_present(dev))
> > +	if (ops->ndo_set_rx_mode_async) {
> > +		queue_work(rx_mode_wq, &dev->rx_mode_work);
> >  		return;
> This early return skips the legacy core fallback below.
> Before this patch, __dev_set_rx_mode() continued into the
> existing unicast-filter handling when the device did not
> advertise IFF_UNICAST_FLT.
> 
> After this patch, any driver that implements
> ndo_set_rx_mode_async but does not set IFF_UNICAST_FLT
> will never hit that fallback path.

I believe this is addressed later in "net: move promiscuity handling into
dev_rx_mode_work"? That should take care of doing __dev_set_promiscuity
for !IFF_UNICAST_FLT+ndo_set_rx_mode_async. Not sure if there is a
better way to rearrange the chunks in the patches.

        if (ops->ndo_set_rx_mode_async) {
                ...

+		promisc_inc = dev_uc_promisc_update(dev);
+
+		netif_addr_unlock_bh(dev);
+	} else {
+		netif_addr_lock_bh(dev);
+		promisc_inc = dev_uc_promisc_update(dev);
+		netif_addr_unlock_bh(dev);
+	}
+
+	if (promisc_inc)
+		__dev_set_promiscuity(dev, promisc_inc, false);
+
