Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1403F10706DE
	for <intel-wired-lan@archiver.kernel.org>; Sat, 14 Mar 2026 15:13:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B7C314111C;
	Sat, 14 Mar 2026 15:13:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lHMWKVZG9mWX; Sat, 14 Mar 2026 15:13:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E6C7A410B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773501211;
	bh=6CKRQJSo/5LxMth9T/SMAY5K+hO6PGZ56l/+iIWhIvA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v6L9VNkuA+ydiStV1aHZRWptB5bnzsAGoBzLFvdyqgs82FfnS2mYGwrt5JVvE5XQT
	 UIS5I6yyOcqU9mw3QhNI12zlBZoXsdG75Ma6v4jsrhcsfH5i/V+gDtdv3volqxlbm3
	 V9cuUBEuWalD6tawUmzkU6DJjsNPcRGoZdw7ST9UwgoNH6PrQVia9Fk7GjcQDS6J0O
	 cKsSmhqrGzX9FEm/J3CNU8zuMLL6wR+j59RtSWUbEjqJJ8ZJEVeToorOprQR9qF26z
	 WFvXu9/45VJ5axY+GvDjGUKQopzWMgbqRrXPDq9ben2WW+KdW9rRy1/5b4+AflcbXm
	 584qm8QZchdjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E6C7A410B5;
	Sat, 14 Mar 2026 15:13:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B9014201
 for <intel-wired-lan@lists.osuosl.org>; Sat, 14 Mar 2026 15:13:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B69AB822E6
 for <intel-wired-lan@lists.osuosl.org>; Sat, 14 Mar 2026 15:13:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yrs0xQghkolR for <intel-wired-lan@lists.osuosl.org>;
 Sat, 14 Mar 2026 15:13:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1A710822E4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1A710822E4
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1A710822E4
 for <intel-wired-lan@lists.osuosl.org>; Sat, 14 Mar 2026 15:13:29 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7CFEC417BE;
 Sat, 14 Mar 2026 15:13:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6BBC116C6;
 Sat, 14 Mar 2026 15:13:29 +0000 (UTC)
Date: Sat, 14 Mar 2026 08:13:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>
Message-ID: <20260314081328.2635a33d@kernel.org>
In-Reply-To: <IA3PR11MB8986CA12EE22E9C07BCE7E83E545A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260312093101.1589970-1-aleksandr.loktionov@intel.com>
 <20260312093101.1589970-2-aleksandr.loktionov@intel.com>
 <20260312074225.27a4a7b3@kernel.org>
 <IA3PR11MB8986CA12EE22E9C07BCE7E83E545A@IA3PR11MB8986.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1773501209;
 bh=WHizFYmIry56OpDo0uge9SNh3o7uX3ISwBlv4bw6UCI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=s0xiJomY/kqz2SMx2xzgjhda5Gn2iTrFLX7yij0NGEflBpEude46o4ab+7zRS6pb4
 8gpbS0Z+pNldMCGrn2+maz6pA5QsNEYaa+f70WDxzp+XGyoqxSj5iJ/XuMxMRVhIkp
 uW0CzxNZi9AIdgLZcYFEED6gFkatyD0ED4uYGZB8MMfsUdUYHN8WEqvHDgvdWjmjX4
 +FWG4ld1S2a7rkrHjVsqei2eEmuZFemVY64w8d0ta124pOJILK2I7nezqFENa0WBK+
 zlQ1yEcH7u33DEWAibcYxMCgAMacyC2XgKpqvv9K9ffF2bit5x9E5zt0p4K9NFveC7
 nj4shqo33sIYw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=s0xiJomY
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 1/2] ethtool: treat
 RXH_GTP_TEID as intrinsically symmetric
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

On Fri, 13 Mar 2026 11:28:29 +0000 Loktionov, Aleksandr wrote:
> > -----Original Message-----
> > From: Jakub Kicinski <kuba@kernel.org>
> > Sent: Thursday, March 12, 2026 3:42 PM
> > To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> > Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Nguyen,
> > Anthony L <anthony.l.nguyen@intel.com>
> > Subject: Re: [PATCH iwl-next v4 1/2] ethtool: treat RXH_GTP_TEID as
> > intrinsically symmetric
> > 
> > On Thu, 12 Mar 2026 10:31:00 +0100 Aleksandr Loktionov wrote:  
> > > +	/* Strip TEID before checking - it carries no src/dst asymmetry  
> > */  
> > > +	rxfh &= ~(u64)RXH_GTP_TEID;  
> > 
> > No need for the u64 cast.  
> 
> But without (u64) it will work only while it defined as implicit int
> #define 	RXH_GTP_TEID	(1 << 8)
> 
> When it will be defined as BIT(8) or unsigned int it will break.
> What you'd recommend preventing such issues in the future?

We will convert the 1 to 1ULL once we actually allocate the previous 31
bits? The type is only u64 because it may come from a UINT but the upper
bits must be zeros right now.
