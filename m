Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640CDC46467
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Jan 2023 05:36:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D0B6541D84;
	Fri, 20 Jan 2023 05:36:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D0B6541D84
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1674192964;
	bh=HN8FB91B9/T3wXMlJKPQhQBrZDeZXbtxv7dzrZpviDY=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=AdLaDwe59CJCgaKzYPHtcLEM3cGfRcZadBuHy1GtMiFuYSryRfyjjwykUTEnKxD0t
	 KOtr50uon/mK1xEeuDlw34D/LSAMn+bxsDFfelZrcExLnGIqyiQFgD3yzOvjsFGuxw
	 ypYHH5rzkxfv4R5ROa21t4NVBNZ1+JJTyDHPFgedZMxQbmgXsY2FtIyUWhYM6BgFID
	 gf28AeVczDeQtjCGkCt4gZHrDssTsssXfgTKKiWWLs2oMKRx2w4w4Yz44LuNU7fe+c
	 tZFa8ZyRNGeBRs5MZrxPjAsGmz56fkKpbOBCCFRwH3h164iVPguCfu02Ql7rrzS4GV
	 YsaIz9c5e//hQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1Rza_51YMl3K; Fri, 20 Jan 2023 05:36:03 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 99B0441D7F;
	Fri, 20 Jan 2023 05:36:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 99B0441D7F
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 7341A1BF397
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Jan 2023 05:36:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 43A7F41D7D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Jan 2023 05:36:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 43A7F41D7D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1LBXG8EA--Vm for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Jan 2023 05:36:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 729DD41D6C
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 729DD41D6C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Jan 2023 05:36:00 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 592F361E1D;
 Fri, 20 Jan 2023 05:35:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61686C433D2;
 Fri, 20 Jan 2023 05:35:58 +0000 (UTC)
Date: Thu, 19 Jan 2023 21:35:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Message-ID: <20230119213557.57598e8f@kernel.org>
In-Reply-To: <2c722338-c113-14a1-040b-70326e2e2451@intel.com>
References: <20230119184045.GA482553@bhelgaas>
 <2c722338-c113-14a1-040b-70326e2e2451@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1674192958;
 bh=8fStNEoSsGqotQjU+mQkrtNKHP0mDcCwZkH9P+/tZzk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Nia8b2pq9XxzIMd3lyGpEAN0Pu2CG6R/GrdcTOZCV4rgawIEe5u3WFJu2zMwOjyZG
 8eEBY+03XA+j95KK5CCOiiWA9sXNPWwz2vFhJzWV3mNQotav9sq+K0i/IZJ/Cr6itK
 q1pRC7CcHDb23n3UfaPPtScqf9+o5Y9UBXKndLHQRiR7KKYi4BfKO6EIjltz9VBnHe
 ORM8i89pvcJDHieagLHpp1wDMAZCl8BnxhP/qDOrPJfe+bxGoUK/FpTrjLrFUv5JmJ
 qpfaAS6LoYjQeyVqWaQEbykyPEh8BPopyy8Jop/IBYEorFcFoXeAlfgN6kfHfE8lsX
 n5v0uF+zOoXUQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=Nia8b2pq
Subject: Re: [Intel-wired-lan] [PATCH 2/9] e1000e: Remove redundant
 pci_enable_pcie_error_reporting()
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
Cc: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, 19 Jan 2023 13:31:39 -0800 Tony Nguyen wrote:
> > Thanks a million for taking a look at these, Tony!
> > 
> > These driver patches are all independent and have no dependency on the
> > 1/9 PCI/AER patch.  What's your opinion on merging these?  Should they
> > go via netdev?  Should they be squashed into a single patch that does
> > all the Intel drivers at once?
> > 
> > I'm happy to squash them and/or merge them via the PCI tree, whatever
> > is easiest.  
> 
> Since there's no dependency, IMO, it'd make sense to go through 
> Intel-wired-lan/netdev. Keeping them per driver is fine.

Ah, damn, I spammed Bjorn with the same question because email was
pooped most of the day :/ Reportedly not vger, email in general but 
fool me once...

Tony, if you could take these via your tree that'd be best.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
