Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5863CD4F24
	for <intel-wired-lan@archiver.kernel.org>; Wed, 13 May 2026 12:13:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 69DBB60F10;
	Wed, 13 May 2026 12:13:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id neiDrIV24dAG; Wed, 13 May 2026 12:13:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0622161199
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778674420;
	bh=lEe1wKr7RfEuTs0qlezkOo7LcO9jy29KhnvuGONzzRE=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pDe/4FtNNU3zxDldDjUfWCNSOMXC6v+DALOW022bMkcLXCNyUhH7O9IuI4lHkWZ7k
	 vPLbmQJhVvpE/C58E/7nOlMEin3MsIc22D3j9R4mR83bZNrQX2pYG6rMvNxob9Nc3v
	 mnP32MmqDRVu463ppFMgWO/mpGJwFipNoM2tz3V1qCsqwO6UazSlMzX0mbQGFfe/ph
	 91NJXUg8q5ufetMkhkTOlkOCPoCyuM+PUIl1cUMiiWdRDdWcVm621G9jkmKJWd4Tv9
	 b1ZKRH2YFuwIQquzoaRJKM+TlIMRc0phIoGP4n1ArHl6aKZ5L6i5pduTuFkpVVy0pC
	 hPBI80wsW7vTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0622161199;
	Wed, 13 May 2026 12:13:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C00015F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 13 May 2026 12:13:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7D52240A40
 for <intel-wired-lan@lists.osuosl.org>; Wed, 13 May 2026 12:13:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id twk-D1R5G9QM for <intel-wired-lan@lists.osuosl.org>;
 Wed, 13 May 2026 12:13:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B707940A3B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B707940A3B
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B707940A3B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 13 May 2026 12:13:37 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 60DC260120;
 Wed, 13 May 2026 12:13:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22810C2BCB7;
 Wed, 13 May 2026 12:13:34 +0000 (UTC)
Date: Wed, 13 May 2026 13:13:32 +0100
From: Simon Horman <horms@kernel.org>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <20260513121332.GA136966@horms.kernel.org>
References: <20260508031226.3601800-1-aleksandr.loktionov@intel.com>
 <20260508031226.3601800-7-aleksandr.loktionov@intel.com>
 <20260511154043.GC27589@horms.kernel.org>
 <IA3PR11MB8986A411A8E4C16AA67F2709E5392@IA3PR11MB8986.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA3PR11MB8986A411A8E4C16AA67F2709E5392@IA3PR11MB8986.namprd11.prod.outlook.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1778674416;
 bh=CpGkwp82wpNTsFSWengLwbabkK/i3jYuaJc8/HRvkyg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=V1YNvFRIFV8CHf+W1DKVzkwyKVs44h9UBuC9M/Xnqs7EZbpb6VkW+ccQvPBgDLs8D
 puBPozY0kBl6dmg3L5S0sVInJiimgSjHynHFzxsq/9vf97GC5Db/7qdOCHuAzqLgHH
 atYkSSGmurJu2TOgQB+EbHPtVSCVZJTdTbiYMPCNE8M3TPDkBj7QBruMdMOr3tC23t
 mi5zisMR26mhLsBg3P2VmpI0PRt5Eb+DUNo/7VOwaGm5fFuuSuGATqIpdZtzVo0HBl
 8dMMurnFJLGwG79dXdAflWk1AWZMKP9V17d9BC92mVMiulyN8/i4NxTL4n0/QimtcL
 luK67sm+27bcA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=V1YNvFRI
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 6/8] ixgbe: extract
 ixgbe_restart_auto_neg() to avoid code duplication
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

On Tue, May 12, 2026 at 01:42:39PM +0000, Loktionov, Aleksandr wrote:
> 
> 
> > -----Original Message-----
> > From: Simon Horman <horms@kernel.org>
> > Sent: Monday, May 11, 2026 5:41 PM
> > To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> > Cc: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> > <anthony.l.nguyen@intel.com>; netdev@vger.kernel.org
> > Subject: Re: [PATCH iwl-next 6/8] ixgbe: extract
> > ixgbe_restart_auto_neg() to avoid code duplication
> > 
> > On Fri, May 08, 2026 at 05:12:24AM +0200, Aleksandr Loktionov wrote:
> > > From: Jakub Chylkowski <jakubx.chylkowski@intel.com>
> > >
> > > Both ixgbe_setup_phy_link_generic() and ixgbe_setup_phy_link_tnx()
> > end
> > > with the same three-line sequence that reads MDIO_CTRL1, sets the
> > > MDIO_AN_CTRL1_RESTART bit, and writes MDIO_CTRL1 back.
> > >
> > > Factor it out into a static helper ixgbe_restart_auto_neg() and call
> > > it from both sites.
> > >
> > > While at it, also check the return value of phy.ops.read_reg() in
> > the
> > > helper and skip the write on failure.  The original inlined code
> > > ignored the read result and would OR MDIO_AN_CTRL1_RESTART into a
> > > stale autoneg_reg value (left over from the prior MDIO_AN_ADVERTISE
> > > write) and unconditionally write it back to MDIO_CTRL1 if the read
> > > failed.  This is a small behavioral change: on read_reg() failure
> > the
> > > restart write is now skipped instead of being issued with a
> > > potentially garbage value.
> > >
> > > Signed-off-by: Jakub Chylkowski <jakubx.chylkowski@intel.com>
> > > Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > 
> > FWIIW, the AI-generated review of this patch available on sashiko.dev
> > flags that similar problems wrt write on failre exist earlier on in
> > ixgbe_setup_phy_link_generic(). It may be good to address this area
> > more holistically as a follow-up. (I am not suggesting increasing the
> > scope of this patch/patch-set.)
> > 
> > ...
> 
> Thanks for the review!
> 
> On the min() nit - the operation here is "clamp the new (smaller) itr
> at a floor of prev - IXGBE_ITR_ADAPTIVE_MIN_INC", which max_t()
> expresses directly. Rewriting with min() would need to flip the
> reference point, e.g.
> 
> itr = ring_container->itr - min_t(unsigned int,
> ring_container->itr - itr,
> IXGBE_ITR_ADAPTIVE_MIN_INC);
> 
> which adds a subtraction and reads less naturally than the floor form.
> I'd prefer to keep max_t() here unless you feel strongly - your
> Reviewed-by stands either way, and I've added it for v5. Thanks again.

Thanks, I don't feel strongly about max_t().
