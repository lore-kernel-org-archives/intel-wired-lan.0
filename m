Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E14CA6001
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 15:11:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D83560814;
	Tue,  6 Oct 2026 15:11:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eHgsqrjaEkBZ; Tue,  6 Oct 2026 15:11:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 75B06607CC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791299517;
	b=UfTwWI3X71s5Ne+9xu/gh9xN25tEqxvJxZ83yfj0DqiQ8TLMWtmRQwwsffKCrpowODYs
	 CuXgSiwEiTfCX0dgEToB6Myee1Cj536K1b5o5yJfegiZ1gGAzeN5J21oCLUzic61j2I/s
	 sh8OzCLtBPZ6N39X1ypzRF3KbtkIpAOrX2a5HDy+nEFEHdVwcUmWIS8VvqoJe92etdqQ8
	 ZUvt192ykwSeKp5WSJFmBtMosFHeLswqbnyYUtp2kP4ouievwhc6OI/NpoklPL/x4bhmp
	 /Lp4dZo4IbbbgljyAR98K1g3mBjLTpH9b+TBb4fyzCPMHx063stXkyIh6PUwczKX3sQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791299517;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ULW9vKRbgYcfVx3QsuSyDwqIJAfEuuNW/5xpKdjfHdw=;
	b=lOlVmuQpsOI7sh4Jjheckx1RpbzWXvgtIEbjeaz/6cfhEUcvv77AsWZnfB75U18lxZol
	 71MDDIL0DTvnGimWLH/jEcjZ4kUlKRwTfyv3oiwJw7x4vbeX0ZFrBY94VFLQnKzC92SrQ
	 aAUb5yZ648/Mc7rzgQJ4GzeP0KEWtV8L3zn8fHIo1g02cqCEjUNbs2j4nPxPzVck/AMKy
	 iUMauLjHWSy0/UWr5KRXxQAk0fWT+vl2sg58yV3zDouBHWMZ5nlhRNymH3PZ1Bo06N+DN
	 vie0IGp40/AW5NjYjZo979hBCWBBntJiGL34TO5X012blwfGWVVsbR1m/uGSO46GxSA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bOYqORGa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791299517;
	bh=ULW9vKRbgYcfVx3QsuSyDwqIJAfEuuNW/5xpKdjfHdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LYNYzipohtueK455srM21d5qb3/m69KEKmdFQo/ptrBD6P1Ke409SYucFjSjz9bj3
	 kxHPJfD86EbqroPzhFj8dHQBUhVh9cY6C/9JqkpUbAYDwWb5dPHm0mJcoVGzYpcfLM
	 RdRBMeI8nc15FVPs0secpW8f2kRV0/fPH7YcsAoWsYfk9pDJqer+YmjEkwPiUacLwk
	 8LkptSm2na6RbRZv5qzsiQVPh1GjlWzQEXtK2nMMUb56AKZQIpTsdN8q9IKPy4RlSL
	 5EoTJkXhsjCS4FuePglgANqM/lQofES6mfnnpOZFEJSoZ3sp2fwTM6jYuX2Mjx3kCX
	 B5UvQ1ECRSUqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 75B06607CC;
	Tue,  6 Oct 2026 15:11:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A8D275
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 15:11:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1F659607E5
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 15:11:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g9bgTvqyhyax for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 15:11:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5995C607CB
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791299473;
 b=jML6VUlUczDvEkD7s+Ws/IM/umJivh/D8RgcqCt5B4OCkeq5CLwnTxeqg8bbK9Q7ZNye
 RuH9BpKby+kkjPpRdMKA5v2g6bwY+FLIMUXmPtLsUmG4fC4JDO+NHFbb64Ep977yc1pmX
 Yjph7D5H7CADiYe5Xk/ITxmZEl61unsHUBo6wOI4eZM5nxP6q6eTVvHI+GT1IUE4t4s9B
 XQWB4644Ra3iQMEsLyRogBZGCVEhVvReuKtGyxYW/efJsRIK493OlbPIlPJECi63eEyj7
 owsFuiDL2LoO8ityo9nx1ugP3VbHKEA12M04g+1vspAUgGnZDs94erHG3qgPVbHD1gw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791299473;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=ULW9vKRbgYcfVx3QsuSyDwqIJAfEuuNW/5xpKdjfHdw=;
 b=FzVUIuGR97VoQ4pW7jUq2eslpZ+G74Zu5C388mcZQQtBJVQQhpxonepY0VeTVpVxDTCq
 BRKbZ6RuPbJVsYxncHwzRSoU+25Gj9bmUDxtio5hZ2Gzv4RWJM+SNqyuUrONbch/Mn/QC
 f9JGrp0pzBh0/Etxw1p57nY/rS8MULTs/9DPwa3TsOGbtc/vL9YzkSEnxURkWoJN+f5Vq
 e9wTjPNsw+Nvb/xcP7erc7BBk7pRPkEoGvzYpRCOqZX94aFx8NL+ISCbqWd1gi+2AMjnh
 sxmUj2mhevf8bsVCKo7lseunltqBPSYpOCDYRFwiySDgoCbBayks5kUFHV7d2VxMp6A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bOYqORGa; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bOYqORGa
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5995C607CB
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 15:11:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3934B601E4;
 Tue,  6 Oct 2026 15:11:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744091F0089B;
 Tue,  6 Oct 2026 15:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791299470;
 bh=ULW9vKRbgYcfVx3QsuSyDwqIJAfEuuNW/5xpKdjfHdw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=bOYqORGarKp/msV2EqO5hS1Bnco4I56Lbe3Q/vwXx1ffcC+ieYWsauhLHUpgkRHe0
 96BARLbefkSD6HWfHgbPPixICfAqjNGm2xlEX2WL9BQ8WADL1mGqXp7e1i4TWYXndT
 gP6uAatAQzid669U4dvZhbtjPXCoSSQxcoAhsUOtGz6TceidaYO70PO9MWPvbHKXdL
 tJGoL7vp4lO2xdKHEkaExELqWVz+ZZYSBrZSNMrCR7Ld1gcvogXRyUcYqXAmxUMzYc
 hCFTK2R0TudqUZm1xBLTyn9+jdu8udhZ52am7jZnMRTcQHGbPSf8htl76/qRnHPGm9
 ORfpYrl/BvCvA==
Date: Tue, 6 Oct 2026 16:11:07 +0100
From: Simon Horman <horms@kernel.org>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] idpf: Fix vport IRQ name leak on request failure
Message-ID: <20261006151107.GJ83879@horms.kernel.org>
References: <20260923234819.702327-1-oss.patchbox@gmail.com>
 <20260928091551.GK13925@horms.kernel.org>
 <CAGG=RgBNpQLy3s7Zqf1=TpN_grUOha8Cu_UVmjou=qPe0RBqiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGG=RgBNpQLy3s7Zqf1=TpN_grUOha8Cu_UVmjou=qPe0RBqiw@mail.gmail.com>
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

On Wed, Sep 30, 2026 at 12:06:48PM -0400, Yuho Choi wrote:
> I appreciate your time to review this.
> 
> On Mon, 28 Sept 2026 at 05:15, Simon Horman <horms@kernel.org> wrote:
> >
> > > Fixes: bf9bf7042a38 ("idpf: avoid bloating &idpf_q_vector with big %NR_CPUS")
> >
> > I don't believe that commit introduced this problem.
> 
> Thanks for catching this. I'll fix this tag.
> 
> > name is allocated by kasprintf() which is a wrapper around kvasprintf_const().
> > And kvasprintf_const() documents that it's return value should be freed
> > using kfree_const(). I don't think it will make any run-time difference
> > here, but perhaps it would be best to follow that convention.
> 
> kasprintf() uses kvasprintf(), not kvasprintf_const(), so the name is
> always kmalloc'ed and kfree() matches the kfree(free_irq()) used on the
> normal path. Please correct me if I'm wrong.

Yes, of course you are right.
No idea how I managed to muddle that one up.
Sorry for the noise.

> 
> > Also, for completeness, shouldn't there be error handling for the case
> > where the allocation of name fails?
> >
> 
> Agreed, I'll add it in v2
