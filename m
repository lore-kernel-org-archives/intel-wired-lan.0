Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE558F46C40
	for <intel-wired-lan@archiver.kernel.org>; Mon,  6 Apr 2026 14:06:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC85760643;
	Mon,  6 Apr 2026 14:06:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tQpZHcXfVUMi; Mon,  6 Apr 2026 14:06:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E02B36063E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775484385;
	bh=6dvUwkTyEiFOcgg/rtaSGFzUpJXNrZgNepii9xrmX4g=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lhNYKuNQVc6tqVvtIkNg8th6dgi6/LTWHqr+obDyE30QYx1MZqr/AW4L9XBHYhE+h
	 Wu8QrxhIWVqg49R7FmzonJjwmnd7eOA1yHakpK6pwO31doQFoA60uHbBnkBuMY/o6v
	 Xaq77eSmS+fxnKCeWvK1dtVQ+q5Shtw6bk6tf1A/Hzjf/voZKBfwsqTUbc37o32J18
	 NRFUkEJwfeBHfJ0QP2NPeQrU/EbMZAb1l7BlKBcFCDCqxHs2KfA3zxYqbhpGvcWcgd
	 51rbIUdjJqkUHHOgqgVz2wdWay/LKhqxu7nzVDYYZc5NvF8cqar9XpJi5h4T4228nX
	 CexnvpyPylCdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E02B36063E;
	Mon,  6 Apr 2026 14:06:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 492271EB
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Apr 2026 14:06:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 272804072F
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Apr 2026 14:06:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d1fYQuBgwpUN for <intel-wired-lan@lists.osuosl.org>;
 Mon,  6 Apr 2026 14:06:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6291F40712
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6291F40712
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6291F40712
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Apr 2026 14:06:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 916AC60123;
 Mon,  6 Apr 2026 14:06:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C230C4CEF7;
 Mon,  6 Apr 2026 14:06:20 +0000 (UTC)
Date: Mon, 6 Apr 2026 15:06:17 +0100
From: Simon Horman <horms@kernel.org>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <20260406140617.GC395680@kernel.org>
References: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
 <20260327073046.134085-11-aleksandr.loktionov@intel.com>
 <20260403131857.GB113102@horms.kernel.org>
 <IA3PR11MB8986472BF64AFBF2191A381EE55EA@IA3PR11MB8986.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA3PR11MB8986472BF64AFBF2191A381EE55EA@IA3PR11MB8986.namprd11.prod.outlook.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1775484381;
 bh=lSOhJktgpXKPmVSgZ1HfGR78lmK+3sPi09aFmGX56q0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AG7paG2FM97zut6Ait4Vs9oVl0bVsbqvUMoTJdkG9GcrMOE+LVmL1NCho4pjItkAi
 GsHNFBkYtZGbu0UfS/lLqHWNhdlUqggZWm2uICusyTcRkhLx8hR34suFlBn1YzCyVf
 Dj0zTvtLlFVOanXrdSrTzfYbOXoRwO+zHS4tEG+15ErwBpcmJDlEgHxfgqx/QLEjkH
 ULhlyOiVF6Pwvf1cbSVj5l5/74pB72e1i4BSFy0IfUp6riyqwYG8B53Ep24jQB6NDu
 Az6wHh8QM1MhWk7NrXgiOYW0IFjja5Ho7lPRkwhd+pAhRrUw2lZwQtUUW6evlruVsS
 CrItt9ADHf3iA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=AG7paG2F
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ixgbe: fix ITR value
 overflow in adaptive interrupt throttling
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

On Fri, Apr 03, 2026 at 04:12:02PM +0000, Loktionov, Aleksandr wrote:
> 
> 
> > -----Original Message-----
> > From: Simon Horman <horms@kernel.org>
> > Sent: Friday, April 3, 2026 3:19 PM
> > To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> > Cc: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> > <anthony.l.nguyen@intel.com>; netdev@vger.kernel.org
> > Subject: Re: [PATCH iwl-next] ixgbe: fix ITR value overflow in
> > adaptive interrupt throttling
> > 
> > On Fri, Mar 27, 2026 at 08:30:45AM +0100, Aleksandr Loktionov wrote:
> > > ixgbe_update_itr() packs a mode flag (IXGBE_ITR_ADAPTIVE_LATENCY,
> > bit
> > > 7) and a usecs delay (bits [6:0]) into an unsigned int, then stores
> > it
> > > in ring_container->itr which is u8.  Values above 0xFF wrap,
> > > corrupting both the delay and the mode-flag on the next readback.
> > >
> > > Separate the mode bits from the usecs sub-field; clamp only the
> > latter
> > > to [0, IXGBE_ITR_ADAPTIVE_LATENCY - 1] via min_t(unsigned int, ...)
> > so
> > > overflow cannot bleed into bit 7.  Add a WARN_ONCE() when the raw
> > > usecs value exceeds U8_MAX so out-of-range ITR computations are
> > > visible in dmesg during development and testing.
> > >
> > > Fixes: b4ded8327fea ("ixgbe: Update adaptive ITR algorithm")
> > > Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > 
> > Somehow - perhaps because there is no m/n notation present in the []
> > in the subject - Patchwork has treated each patch in this series as
> > it's own patch-set.
> > 
> > And in the case of this patch, it didn't apply - I assume because in
> > order to do so an earlier patch in the series needs to be present.
> > 
> > So CI didn't run on this patch :(
> 
> Good day, Simon
> 
> I have a bunch of simple /* independent */ patches for submission every week.
> Whis way you'd recommend to send them to ease /* and accelerate review */ ?
> 
> 1. submit one by one
> 2. submit as a batch by one git command (with the same internal main ID tag internally)
> 3. imagine a cover latter and submit as a patch-set 

Hi Aleksandr,

I would suggest 3 and lean towards small batches.
