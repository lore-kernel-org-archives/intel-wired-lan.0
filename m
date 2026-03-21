Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0681094462
	for <intel-wired-lan@archiver.kernel.org>; Sat, 21 Mar 2026 09:14:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 89BAD612F4;
	Sat, 21 Mar 2026 09:14:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U60S1yPc438U; Sat, 21 Mar 2026 09:14:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9F624612E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774084486;
	bh=snL4k6e6rTbBwtpEuFh/S9d23iDr14/DqmUlgH25KSQ=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=6uV4WyPl5XXW0VqXmXJt6qVNRWj+V06ZXfjF58/FXffqYEGAP7Tv62lxSHcfAybuW
	 aC/T5BD7NJmw/VqtOumnGdhgc4VVaOlkETuuVA27bXK8T0I2H2jmmq1JuOZvjP+UUf
	 bGwkoGd03uCpPTEFUpdq83C57wTiCgege48VzPqSlcI/L6jc8qG0+vis2VLZMiit+Q
	 S4p5kZi1wIks1OKI+nxz1fLbo/UmPFjL45fsirjbyP9f00zOrL1dp+AVi5V/4WNtS3
	 K9sCezlwTBJpQfLpwQYNzB/5m5G1+Vts13lIX9zz4s5V4CAc0LyJKtWTYizvYDqFJP
	 D2lJN4TSHoekA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F624612E9;
	Sat, 21 Mar 2026 09:14:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B4B625C
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Mar 2026 09:14:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 711E9405DB
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Mar 2026 09:14:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hLnQdeV3iedz for <intel-wired-lan@lists.osuosl.org>;
 Sat, 21 Mar 2026 09:14:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org CE90C4023D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CE90C4023D
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CE90C4023D
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Mar 2026 09:14:44 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 06F38416A3;
 Sat, 21 Mar 2026 09:14:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9C8C19421;
 Sat, 21 Mar 2026 09:14:42 +0000 (UTC)
Date: Sat, 21 Mar 2026 09:14:40 +0000
From: Simon Horman <horms@kernel.org>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "Wieczerzycka, Katarzyna" <katarzyna.wieczerzycka@intel.com>
Message-ID: <20260321091440.GR74886@horms.kernel.org>
References: <20260320050518.422303-1-aleksandr.loktionov@intel.com>
 <20260320180410.GA151863@horms.kernel.org>
 <IA3PR11MB8986779AEBF981B6AF66F3D8E54CA@IA3PR11MB8986.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA3PR11MB8986779AEBF981B6AF66F3D8E54CA@IA3PR11MB8986.namprd11.prod.outlook.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1774084483;
 bh=UqZ8VzmgWhDv/uupfpMd/3DUo+HUmBI1g+qwzL27+nU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JoE6RpPAmMfSwff//GVuT4xxO4zDe+we7wWo0alVhkWaUW76yYIIvsjXu+JGKIjhv
 hTKuRZVoAPKKby9WuZ1TD2k3BDmFUksn03bzNSsdAyGSA4gWRmwyN14zfDB+dR+HkB
 HJr4sUHj2LBj5U8t6IB2Nz3H6JfRzjj8hFLxw5WW9xi/+0nrJDbVTUeBJxxjM58jes
 EZeDbWMayf/Iw7NW83lWqCYvIKKgXEv+RHffQ0GrVhYWLKpbXfGCda1Fm/XEzrQFhX
 WcIhIGevNDIp2t9R9mBFecyIoHLkk+iESn1BBTlMypHLcPMq8DGnmrw7eJ764w/pH/
 RntjBm9rJqnqw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=JoE6RpPA
Subject: Re: [Intel-wired-lan] [PATCH] ice: add missing reset of the mac
 header
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

On Fri, Mar 20, 2026 at 07:53:28PM +0000, Loktionov, Aleksandr wrote:
> 
> 
> > -----Original Message-----
> > From: Simon Horman <horms@kernel.org>
> > Sent: Friday, March 20, 2026 7:05 PM
> > To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> > Cc: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> > <anthony.l.nguyen@intel.com>; netdev@vger.kernel.org; Wieczerzycka,
> > Katarzyna <katarzyna.wieczerzycka@intel.com>
> > Subject: Re: [PATCH] ice: add missing reset of the mac header
> > 
> > On Fri, Mar 20, 2026 at 06:05:18AM +0100, Aleksandr Loktionov wrote:
> > > From: Katarzyna Wieczerzycka <katarzyna.wieczerzycka@intel.com>
> > >
> > > By default skb->mac_header is not set, so reset prevents access to
> > an
> > > invalid pointer.
> > >
> > > Call skb_reset_mac_header() before accessing the mac header from
> > skb.
> > >
> > > Signed-off-by: Katarzyna Wieczerzycka
> > > <katarzyna.wieczerzycka@intel.com>
> > > Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > 
> > Hi Katarzyna and Aleksandr,
> > 
> > I am curious:
> > 
> > Is this a bug? If so then it should probably have a fixes tag and a
> > bit more of a description around how this can happen.
> > 
> > If it is not a bug, then is this defensive? And if so, is it really
> > necessary?
> > 
> > ...
> 
> 
> Good day, Simon
> 
> I'm upstreaming Katarzyna's fix.
> 
> From my point of view, it's not just defensive code, but real bug even on latest kernel because the gap is partially closed by packet_parse_headers(), but not completely.
> Sorry the patch header is malformed, I definitely need to add 
> Fixes: f9f83202b726 ("ice: Allow all LLDP packets from PF to Tx")

Hi Aleksandr,

I can see you have been busy.

I agree adding a Fixes tag makes sense.  If you could also expand the patch
description that would be well appreciated (at least by me).

> But not sure whether to send to net, because on modern kernels I have no real call traces only theoretical conclusion.

That is a line call in my opinion.

If you include a Fixes tag, which seems sensible, then the chances are the
patch will end up being backported to stable. And if the patch is in
net-next it might not have hit Linus's tree before that happens. Which
doesn't seem ideal. So I think it would be more sensible to target the
patch at net to avoid that problem. But that's just my feeling.

Either way, please consider adding a note regarding this.
So it will be more obvious.
