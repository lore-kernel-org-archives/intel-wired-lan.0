Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A18AF46C40
	for <intel-wired-lan@archiver.kernel.org>; Mon,  6 Apr 2026 14:07:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E9CD80D2C;
	Mon,  6 Apr 2026 14:07:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id edqKD6JzNO4b; Mon,  6 Apr 2026 14:07:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8A74C80CF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775484429;
	bh=h7aV3wVg5KiYOEp55cdtRPZAA1IoSE5I5+rm6ZqH5wk=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XKUIgc3rHM1zfJh78eTrey20KKgXjpvXa+uMcknKQ+DAc3gAtePGq43TAnYqXl+wS
	 2kf0R2N0+ELr7keZFiVrLs++he6+O000N+75DpLhFA8Mxe/RY6jxHlkhBztQZ0jBTn
	 gSgs/Lx5e3VSCBKv/BIJf8R5sSVwT5oQsBUjG3ym7PoP6+6NzKGI2LvB+R8S2xfvmW
	 QHi5u/PwkQnibf3ptSLaxrMuB4ZAhND2ne/aT9GBsq55km0c+NXMp1b84TOwd0Bzrw
	 DShWBuAO8XthGchjR+pzWg6LyMhNuRaCZutoJ+gjPseO874b3KXA2RXcioHpl/6UwB
	 b3CaXlpGMIhHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A74C80CF8;
	Mon,  6 Apr 2026 14:07:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E53171EB
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Apr 2026 14:07:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E363A40762
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Apr 2026 14:07:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FJEUYa_Mqi6K for <intel-wired-lan@lists.osuosl.org>;
 Mon,  6 Apr 2026 14:07:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 02A014072F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 02A014072F
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 02A014072F
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Apr 2026 14:07:07 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 31B4E60123;
 Mon,  6 Apr 2026 14:07:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EE4C4CEF7;
 Mon,  6 Apr 2026 14:07:05 +0000 (UTC)
Date: Mon, 6 Apr 2026 15:07:03 +0100
From: Simon Horman <horms@kernel.org>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
Cc: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Marcin Szycik <marcin.szycik@linux.intel.com>
Message-ID: <20260406140703.GD395680@kernel.org>
References: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
 <20260327073046.134085-5-aleksandr.loktionov@intel.com>
 <20260403131035.GA113102@horms.kernel.org>
 <20260403131159.GA114708@horms.kernel.org>
 <DS0PR11MB7579E948B1DAEF3E8D28C1EBD65EA@DS0PR11MB7579.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR11MB7579E948B1DAEF3E8D28C1EBD65EA@DS0PR11MB7579.namprd11.prod.outlook.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1775484426;
 bh=MAH6RptzeDcpL5V+g/KSRmtMJlqdvpcbYjcxWTTBuNE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CMjTvXiFqY1RT8PIZv436z/iQGl8Ay6NcjanNYH15fxJmVRsksQBoblZLQvKslbhA
 rITkdThslYEyw/3zQXVQDFTbSrp/8vivYgHuar5g+NzKgvU4rSRznWmFq6KC6HbGCL
 5Lh+y/YJV/H8AV+B6MF3A+RPODuYrVd7axqEXyCHO2dOeqPdA4oDcP5uWIpYUxlKZm
 1QnFxzuC+mIhlzBiaKClEAbhgxGUq+Jl1+u4tqecdPHP0Gg1FVFR2mRZ9yJ96WPGbS
 v+DnTfwNADqx483FGIvNWDb5XNdF7xGPVy5yPU0tw25owTMX7WrBPXSSEZAdxyt0e3
 MvNrspYXMturg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=CMjTvXiF
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ixgbe: use
 ktime_get_real_ns() in ixgbe_ptp_reset()
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

On Fri, Apr 03, 2026 at 08:26:20PM +0000, Keller, Jacob E wrote:
> 
> 
> > -----Original Message-----
> > From: Simon Horman <horms@kernel.org>
> > Sent: Friday, April 3, 2026 6:12 AM
> > To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> > Cc: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> > <anthony.l.nguyen@intel.com>; netdev@vger.kernel.org; Keller, Jacob E
> > <jacob.e.keller@intel.com>; Marcin Szycik <marcin.szycik@linux.intel.com>
> > Subject: Re: [PATCH iwl-next] ixgbe: use ktime_get_real_ns() in
> > ixgbe_ptp_reset()
> > 
> > On Fri, Apr 03, 2026 at 02:10:38PM +0100, Simon Horman wrote:
> > > On Fri, Mar 27, 2026 at 08:30:39AM +0100, Aleksandr Loktionov wrote:
> > > > From: Jacob Keller <jacob.e.keller@intel.com>
> > > >
> > > > Replace ktime_to_ns(ktime_get_real()) with the direct equivalent
> > > > ktime_get_real_ns() in ixgbe_ptp_reset().  Using the combined helper
> > > > avoids the unnecessary intermediate ktime_t variable and makes the
> > > > intent clearer.
> > > >
> > > > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > > > Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > > > Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> > >
> > > Reviewed-by: Simon Horman <horms@kernel.org>
> > >
> > > FWIIW, this pattern also seems to exist in e1000e, ixgbe and igb (twice).
> > 
> > Of course, with this patch applied it's not present in ixgbe anymore :^)
> 
> Right. Given that e1000e and igb are basically on life support only, I
> would limit touching them unless we have relevant work to do in that area
> in the future.

Sure, that is fine by me.
