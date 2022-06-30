Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FFF2C43334
	for <intel-wired-lan@archiver.kernel.org>; Thu, 30 Jun 2022 07:23:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BA5B740A8A;
	Thu, 30 Jun 2022 07:23:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BA5B740A8A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1656573817;
	bh=d7Dp+kPuL4pdw4v+Gj8HYoY/lzytrqJBR730dBEOuQg=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=45ScsZmUA2c57uNhJNpzX18krrm4LxQVm9rG3Xj1hDPHZVsPxQsI49td9N+xyIGnN
	 Q+eZmVfsHE55+u+Ex2ZGZutCT8Hq5GAaKb38CqeNCVPoE/6s1Vf1FLRPpzwXKBdz9Z
	 bWeIzt6BuV38/b5YVvQ8MT9P6bLWtU7uNO85eH+l8zFyQPx9VKFLQp5Rdt0MdjN4xR
	 jboxk5h7FY0HDCrozDU4EnRv6xjYZoiFOlllNPgJmaEWPiIu7WCYDPqPygNWqZSa4z
	 IOKnyBCyZ6WrwfsyV/6uwViJuy3QxHzR6UvQ4UZIU0nGcHcTvo1NWCrGiiF/yPo77p
	 chLUBI5j1ybOA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hHrGxkTZgHAY; Thu, 30 Jun 2022 07:23:36 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9DDDE40338;
	Thu, 30 Jun 2022 07:23:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9DDDE40338
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id BBA6C1BF3BC
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jun 2022 07:23:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8F29E40354
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jun 2022 07:23:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8F29E40354
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vBjwLGvXx0rY for <intel-wired-lan@lists.osuosl.org>;
 Thu, 30 Jun 2022 07:23:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E20A04034E
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E20A04034E
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jun 2022 07:23:32 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="265305135"
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; d="scan'208";a="265305135"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2022 00:23:31 -0700
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; d="scan'208";a="658889107"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.13.12.28])
 ([10.13.12.28])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2022 00:23:28 -0700
Message-ID: <887f578a-6302-a1c5-b96e-012fef31ae60@linux.intel.com>
Date: Thu, 30 Jun 2022 10:23:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To: Lennert Buytenhek <buytenh@wantstofly.org>,
 intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>
References: <YpjeEyMxobCIRfTx@wantstofly.org>
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <YpjeEyMxobCIRfTx@wantstofly.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656573812; x=1688109812;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=MbfSuw9UA3LRc7GDrrVI9/ku4qISI1pv7/WgZ9sqQ64=;
 b=g05FKOIhbl7q8FJpcOXNRXSm4byEqHZgNSwxMuCaKmktbsq8+Oj2MuSm
 YwDl3vzsENFHAYdhnZimOSMaMuu/+1FlNXOBoqmmHNTQ8BLuH9q/CJHVy
 HtjWcIjDwhX1uvQFIJjaFkAworSd5H28Kqccj/v7d6AIWNg1LU+/wQ0Aw
 NUeLQU5nxtLWwOLWTg8DCziNWU9vq2/mUGvxK+9k02ZTZCetzrSpOTC0s
 teuiBm9XdOHFUdddcTk9xDM1wV5oB0ZqsmjkIL9EfhQzKv4+FDQWEEKdd
 rRqc04XGFwuqw/RNOTiv4Co9rjPbz0XntvmGdznSd9T+aU/bL3haMdXas
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=g05FKOIh
Subject: Re: [Intel-wired-lan] [PATCH v1] igc: Reinstate IGC_REMOVED logic
 and implement it properly
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
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jeff Kirsher <jeffrey.t.kirsher@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 6/2/2022 18:58, Lennert Buytenhek wrote:
> The initially merged version of the igc driver code (via commit
> 146740f9abc4, "igc: Add support for PF") contained the following
> IGC_REMOVED checks in the igc_rd32/wr32() MMIO accessors:
> 
> 	u32 igc_rd32(struct igc_hw *hw, u32 reg)
> 	{
> 		u8 __iomem *hw_addr = READ_ONCE(hw->hw_addr);
> 		u32 value = 0;
> 
> 		if (IGC_REMOVED(hw_addr))
> 			return ~value;
> 
> 		value = readl(&hw_addr[reg]);
> 
> 		/* reads should not return all F's */
> 		if (!(~value) && (!reg || !(~readl(hw_addr))))
> 			hw->hw_addr = NULL;
> 
> 		return value;
> 	}
> 
> And:
> 
> 	#define wr32(reg, val) \
> 	do { \
> 		u8 __iomem *hw_addr = READ_ONCE((hw)->hw_addr); \
> 		if (!IGC_REMOVED(hw_addr)) \
> 			writel((val), &hw_addr[(reg)]); \
> 	} while (0)
> 
> E.g. igb has similar checks in its MMIO accessors, and has a similar
> macro E1000_REMOVED, which is implemented as follows:
> 
> 	#define E1000_REMOVED(h) unlikely(!(h))
> 
> These checks serve to detect and take note of an 0xffffffff MMIO read
> return from the device, which can be caused by a PCIe link flap or some
> other kind of PCI bus error, and to avoid performing MMIO reads and
> writes from that point onwards.
> 
> However, the IGC_REMOVED macro was not originally implemented:
> 
> 	#ifndef IGC_REMOVED
> 	#define IGC_REMOVED(a) (0)
> 	#endif /* IGC_REMOVED */
> 
> This led to the IGC_REMOVED logic to be removed entirely in a
> subsequent commit (commit 3c215fb18e70, "igc: remove IGC_REMOVED
> function"), with the rationale that such checks matter only for
> virtualization and that igc does not support virtualization -- but a
> PCIe device can become detached even without virtualization being in
> use, and without proper checks, a PCIe bus error affecting an igc
> adapter will lead to various NULL pointer dereferences, as the first
> access after the error will set hw->hw_addr to NULL, and subsequent
> accesses will blindly dereference this now-NULL pointer.
> 
> This patch reinstates the IGC_REMOVED checks in igc_rd32/wr32(), and
> implements IGC_REMOVED the way it is done for igb, by checking for the
> unlikely() case of hw_addr being NULL.  This change prevents the oopses
> seen when a PCIe link flap occurs on an igc adapter.
> 
> Fixes: 146740f9abc4 ("igc: Add support for PF")
> Signed-off-by: Lennert Buytenhek <buytenh@arista.com>
> ---
> As initially reported on intel-wired-lan@ in February:
> 
> 	https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20220214/027787.html
> 
> We're seeing these NULL pointer dereferences hit fairly reproducibly
> when rebooting, presumably due to the particularities of reset
> sequencing on the boards we see this hit on.
> 
> A link flap can be caused by toggling the Secondary Bus Reset bit
> in the upstream PCIe bridge's Bridge Control register and can reliably
> reproduce this problem.
> 
>   drivers/net/ethernet/intel/igc/igc_main.c | 3 +++
>   drivers/net/ethernet/intel/igc/igc_regs.h | 5 ++++-
>   2 files changed, 7 insertions(+), 1 deletion(-)
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
