Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721C2C4332F
	for <intel-wired-lan@archiver.kernel.org>; Wed, 23 Nov 2022 07:00:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EBB7D820FF;
	Wed, 23 Nov 2022 07:00:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EBB7D820FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1669186852;
	bh=VHVtxWkTUebBLYDflK6VgT0Xl7mrOEbhh4nuA3cSmpk=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=873v+55g9riOAuirj0RhWeXPuLlx/yFwLGusKeTg/CiCsSEFQp33nOg/dosyp9wDO
	 PHIRO25gnAfFf7GScph/lKh2mPBULS2Ngrd7HC1YQt5rfGtuuy46i58FGpACjT7NTa
	 VBDEdk73K/aC5AQPZ8NprChLXbgK/jaOLIXabBQklS7kYH2kdT6zpLUp1xSnGJgHhg
	 E/ZzvfmWrQBS4asTU9eU0wFzqjisYTFfKzj22Q2w2fgR8Uv6gBd5kuzIhQcllT9Xwf
	 DhCsavn0niG0nXDJyAIGC14O5bqvk7UrvcSWC2FV7HOCtOTF96zrLOwvFHa4Ja7zN6
	 QuRcyG3mRZ62Q==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XvLV3bdLAdoF; Wed, 23 Nov 2022 07:00:51 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id EDE7382105;
	Wed, 23 Nov 2022 07:00:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EDE7382105
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 1C16C1BF399
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Nov 2022 07:00:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E87CD405E9
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Nov 2022 07:00:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E87CD405E9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uJf28tstJCGj for <intel-wired-lan@lists.osuosl.org>;
 Wed, 23 Nov 2022 07:00:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2695A408B4
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2695A408B4
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Nov 2022 07:00:48 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 36386B81ED5;
 Wed, 23 Nov 2022 07:00:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53CEDC433B5;
 Wed, 23 Nov 2022 07:00:43 +0000 (UTC)
Date: Wed, 23 Nov 2022 09:00:38 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Alexander Lobakin <alexandr.lobakin@intel.com>
Message-ID: <Y33FFtXqcAiDXxLA@unreal>
References: <20221118090306.48022-1-tirthendu.sarkar@intel.com>
 <Y3ytcGM2c52lzukO@unreal>
 <20221122155759.426568-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221122155759.426568-1-alexandr.lobakin@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1669186844;
 bh=h4qg7Xue/Hu8HNz4giAOKeVz2yr0I+aE6Vrebw/pOvA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=B2ctS6KCMORIH3Ehzc4jigb2NC/+Ygtah3IngOYRRmT118D9ZERyizEHRE32Bnhl+
 cZ6jGjxFhCUNojbUN81A9FBVivVu59gl727USX1Wh3n/QiTeyA1HrH2vqYDR4fNhyP
 cK++0rbmL3uLtZYCiwpdloIlsc/x8PPbf/Hla60THHOfk3afjBBQdJ8B3RHJW5VWYh
 Im/O1xzs/6dyuKlIrqD+WZ8pGJFrFaim1zeFOoR5wWdXqkcOFrp2qksZ170D6HcBi9
 BtqPCYwp0TBCqaac2mb/1o21etPbT+iAQczjN1jPAwtGniOfF0diHjBbjKL0zrfwA/
 uoNOV6BDMjWYQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=B2ctS6KC
Subject: Re: [Intel-wired-lan] [PATCH intel-next v4] i40e: allow toggling
 loopback mode via ndo_set_features callback
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
Cc: tirtha@gmail.com, intel-wired-lan@lists.osuosl.org,
 magnus.karlsson@intel.com, Tirthendu Sarkar <tirthendu.sarkar@intel.com>,
 netdev@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, Nov 22, 2022 at 04:57:59PM +0100, Alexander Lobakin wrote:
> From: Leon Romanovsky <leon@kernel.org>
> Date: Tue, 22 Nov 2022 13:07:28 +0200
> 
> > On Fri, Nov 18, 2022 at 02:33:06PM +0530, Tirthendu Sarkar wrote:
> > > Add support for NETIF_F_LOOPBACK. This feature can be set via:
> > > $ ethtool -K eth0 loopback <on|off>
> > > 
> > > This sets the MAC Tx->Rx loopback.
> > > 
> > > This feature is used for the xsk selftests, and might have other uses
> > > too.
> 
> [...]
> 
> > > @@ -12960,6 +12983,9 @@ static int i40e_set_features(struct net_device *netdev,
> > >  	if (need_reset)
> > >  		i40e_do_reset(pf, I40E_PF_RESET_FLAG, true);
> > >  
> > > +	if ((features ^ netdev->features) & NETIF_F_LOOPBACK)
> > > +		return i40e_set_loopback(vsi, !!(features & NETIF_F_LOOPBACK));
> > 
> > Don't you need to disable loopback if NETIF_F_LOOPBACK was cleared?
> 
> 0 ^ 1 == 1 -> call i40e_set_loopback()
> !!(0) == 0 -> disable
> 

Nice, thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
