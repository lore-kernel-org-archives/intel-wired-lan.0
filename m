Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B810C43458
	for <intel-wired-lan@archiver.kernel.org>; Thu,  2 Jul 2026 14:41:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 01E104149E;
	Thu,  2 Jul 2026 14:41:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vzq-0mbTlF7G; Thu,  2 Jul 2026 14:41:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 30E2F41484
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1783003263;
	bh=BSUGjZhMVgTM11JN5H9hsBczgsCpi82B3AuTguh9in4=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=9pICHWWRUrfL2yGqmlp67Z4L0XwJDFCcUMeAIdcof7HMeAhvL3TiVDiVDvKfhL7Pi
	 HLcVM++P7W6DFLCTp/r5JbftcwXRZgzgKI6YhYl4lf8TRUYu4QAddFC4O5q3EeNh0h
	 0m0FJt7MRU6a9C5c7R94hnp0i3Hvl/UvPdkajLHseIeVC/XEUTj+hnllH1OxIX6DnM
	 uSXtxIKAlfDKbn9TEhEEZqf4CZHwScY7o27cgycG3S20l6aF+vPvvVfJqitYDQNaaS
	 QFzFja4W5VB+E9I6E4lvajXRk6MQ2GOducK/TxOkl3GJ15mfueFllaz7cYGuGj6O2J
	 TQ47bZMFpUU5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 30E2F41484;
	Thu,  2 Jul 2026 14:41:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 094AC127
 for <intel-wired-lan@lists.osuosl.org>; Thu,  2 Jul 2026 14:41:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EF5E483B71
 for <intel-wired-lan@lists.osuosl.org>; Thu,  2 Jul 2026 14:41:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D-XAP9v1nwsY for <intel-wired-lan@lists.osuosl.org>;
 Thu,  2 Jul 2026 14:41:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 156D483B6C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 156D483B6C
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 156D483B6C
 for <intel-wired-lan@lists.osuosl.org>; Thu,  2 Jul 2026 14:41:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7DB9A40E0B;
 Thu,  2 Jul 2026 14:41:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E461F000E9;
 Thu,  2 Jul 2026 14:40:55 +0000 (UTC)
Date: Thu, 2 Jul 2026 17:40:52 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Manish Chopra <manishc@marvell.com>, Paolo Abeni <pabeni@redhat.com>,
 Edward Cree <ecree.xilinx@gmail.com>,
 Sudarsana Kalluru <skalluru@marvell.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-net-drivers@amd.com, netdev@vger.kernel.org
Message-ID: <akZ4dBzkuoKPkIZT@kernel.org>
References: <20260701-b4-drivers-ethernet-v1-0-58776615db6e@kernel.org>
 <20260701-b4-drivers-ethernet-v1-2-58776615db6e@kernel.org>
 <d2c75404-a87f-4bb6-b17c-c921d08a1f15@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2c75404-a87f-4bb6-b17c-c921d08a1f15@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1783003260;
 bh=BSUGjZhMVgTM11JN5H9hsBczgsCpi82B3AuTguh9in4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=hm02p6fjnlEnaYi8LIyKuaKkJeMlyl6lZZN3yFPc3ZWSdUCjOZZqqceCK3AB+psl1
 buAexgo7/P/7HFNkm6FD2LF1NvTFeBMTdu0FLL30wGCeebccW2WMO2PXApK/WJxhAH
 2QzFL9gS1S5iPfPhYF54bXa20bV8Op25b7+83SkSO+ww95Jfs0kuYT1vJY9DKnVBPp
 yuuGVGfc3LcDWPTgFrq9mwklN5xL/QOEXTo39WHe3ZvjiNGiqbQMB5F210jEPFScrq
 IOBvbcxMt0xmfkouaIcQDwSx8edf9vMXjuib7M/rQRLDoLF9GyCEc8vXT8fbuZMTm0
 gTko2oCaowVsA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=hm02p6fj
Subject: Re: [Intel-wired-lan] [PATCH 2/4] ice: use kzalloc() to allocate
 staging buffer for reading from GNSS
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

On Thu, Jul 02, 2026 at 03:49:36PM +0200, Przemek Kitszel wrote:
> On 7/1/26 15:57, Mike Rapoport (Microsoft) wrote:
> > ice_gnss_read() uses get_zeroed_page() to  allocate a staging buffer for
> > reading GNSS module data via I2C bus.
> > 
> > This buffer can be allocated with kmalloc() as there's nothing special
> > about it to go directly to the page allocator.
> > 
> > kmalloc() provides a better API that does not require ugly casts and
> > kfree() does not need to know the size of the freed object.
> > 
> > Performance difference between kmalloc() and __get_free_pages() is not
> > measurable as both allocators take an object/page from a per-CPU list for
> > fast path allocations.
> > 
> > For the slow path the performance is anyway determined by the amount of
> > reclaim involved rather than by what allocator is used.
> > 
> > Replace use of get_zeroed_page() with kzalloc() and free_page() with
> > kfree().
> > 
> > Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >   drivers/net/ethernet/intel/ice/ice_gnss.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.c b/drivers/net/ethernet/intel/ice/ice_gnss.c
> > index 8fd954f1ebd6..7d21c3417b0b 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_gnss.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_gnss.c
> > @@ -2,6 +2,7 @@
> >   /* Copyright (C) 2021-2022, Intel Corporation. */
> >   #include "ice.h"
> > +#include <linux/slab.h>
> >   #include "ice_lib.h"
> >   /**
> > @@ -124,7 +125,7 @@ static void ice_gnss_read(struct kthread_work *work)
> >   	data_len = min_t(typeof(data_len), data_len, PAGE_SIZE);
> > -	buf = (char *)get_zeroed_page(GFP_KERNEL);
> > +	buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
> 
> nit:
> from the code it is clear that we read at most a page, and @data_len
> stores the actual amount needed
> 
> comment:
> I don't know why we limit to a page, it's outside of the scope of this
> series, but likely you have removed the limit (which will go into the
> loop - single AQ call is likely limited by a PAGE too).

Not sure I follow how the limit changed. buf remains PAGE_SIZE regardless
of allocation API.
 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Thanks!

-- 
Sincerely yours,
Mike.
