Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9E3106ACC9
	for <intel-wired-lan@archiver.kernel.org>; Thu, 12 Mar 2026 16:33:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2163F84CBF;
	Thu, 12 Mar 2026 16:33:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JFKo7IxYuP1W; Thu, 12 Mar 2026 16:33:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C3A2784C6C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773333202;
	bh=cjYLG2i+oigQBYil8THpuyYq/pagidp+s6PnU6tPXGg=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UoLWKU5jHyfiFy7/9FTwwK5obwmw2WP/eL9LMztOiy7GSGyWAq9wGcsKp7P0fRV9D
	 G2GDvCMcTkQNwLDHS/ApssJFJ80ain9ab0LBO/Guh1aElZnU/uV2wvY0+8wRBtpjdq
	 ICPWaQtiap4teZdU8qhVkWvX7ogkf8YGQ599t0W4jJSgx3rytI81RPJBFz7tVANdRX
	 5ap6c3ufLxjVXXmNdOdxa+x4BKz6r85/XolIyf/lFLGKVlfWpJnFLP74AbBX1brz1i
	 SwxosO3czlL0VTLJlUXHxw9cOyjoWq5u1tj+hPCwrYhijjDnIvFQQPJCNuXrv+cKmQ
	 aej8dJ9x63sjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C3A2784C6C;
	Thu, 12 Mar 2026 16:33:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 40E8D282
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Mar 2026 16:33:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 326AD40605
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Mar 2026 16:33:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lZD4gi3WWUA6 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 12 Mar 2026 16:33:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=aleksander.lobakin@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 39AE9403AD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 39AE9403AD
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 39AE9403AD
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Mar 2026 16:33:17 +0000 (UTC)
X-CSE-ConnectionGUID: xHoTfJ+ySZyXh04R90ARkA==
X-CSE-MsgGUID: fNgdLlQMQQSMbJNk4nIfHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74349217"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; d="scan'208";a="74349217"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2026 09:33:17 -0700
X-CSE-ConnectionGUID: 1YY5csTKRy6iBC2DxRBP3A==
X-CSE-MsgGUID: p7syge5aQIOf1CHH3f8X6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; d="scan'208";a="246213940"
Received: from newjersey.igk.intel.com ([10.102.20.203])
 by fmviesa001.fm.intel.com with ESMTP; 12 Mar 2026 09:33:14 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Steve Rutherford <srutherford@google.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Decotigny <decot@google.com>,
 Anjali Singhai <anjali.singhai@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Brian Vazquez <brianvv@google.com>, Li Li <boolli@google.com>,
 emil.s.tantilov@intel.com
Date: Thu, 12 Mar 2026 17:30:24 +0100
Message-ID: <20260312163025.3765321-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CABayD+dJOxYxZYBpUP06sbgEf4rzMTiVfdmqbR4wnY9C677RFg@mail.gmail.com>
References: <20260227203457.558196-1-srutherford@google.com>
 <20260227203457.558196-2-srutherford@google.com>
 <6a7fbafa-cdcd-4bfa-ac00-204e68602f61@intel.com>
 <CABayD+eF30_OHRrGYiG-7qKbJjvs5=7U8H7SH9Hj=ou6aZJBbw@mail.gmail.com>
 <8b43d234-867a-481f-90e6-e155132100a5@intel.com>
 <CABayD+crjO3S2cC3=9HqSH+kngE1=yKp_MnKZmAdW-YwJH1idA@mail.gmail.com>
 <7c8ed118-d3c3-4bdc-913a-14f5537c44d3@intel.com>
 <CABayD+dJOxYxZYBpUP06sbgEf4rzMTiVfdmqbR4wnY9C677RFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773333199; x=1804869199;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GPNtDaDinweeeNRE+lD7M+Kk13rvwH5XMW6tRwPLK+4=;
 b=bxyMoh/hRNQFVRuIOXmdQvTfp6Jn3frXJCb4Gy0FX0hutvb5ZT3AKNgp
 /Q4efyCa2MRD010tmMdJF9nKk/j2L2LbSOHuzXNQEgLzrFSWredr7ocPl
 Y6/oJfEMn+McpiyUiw/tRb4XIpGugQC3TLlWHqi59iwclqW6hewfuyNOC
 QVjBOWZpNlCyCi/+txNVmBrTw75Sejn+T2yBAlPE0p4A3dfFTIql31GIM
 rOZC0mGhsubfx+uQ3iJK9WfbUoLC946LLpf+A6kcpW0qnbl+oHaCUuVot
 w4nHk1/iXwl4Wb6kWuHQ/V3ErdviO8f7N8WnlS/mNaAJdRQql6duMv3N3
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=bxyMoh/h
Subject: Re: [Intel-wired-lan] [RFC PATCHv2 1/1] idpf: Fix header clobber in
 IDPF with SWIOTLB enabled
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

Hey,

From: Steve Rutherford via Intel-wired-lan <intel-wired-lan@osuosl.org>
Date: Fri, 6 Mar 2026 11:35:27 -0800

> On Fri, Mar 6, 2026 at 6:52=E2=80=AFAM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
> >
> > From: Steve Rutherford <srutherford@google.com>
> > Date: Wed, 4 Mar 2026 14:01:46 -0800
> >
> > > I believe syncing twice isn't inherently wrong - it's more that you
> > > can't synthesize the header via the workaround and then sync, since it
> > > will pull the uninitialized header buffer from the SWIOTLB. Outside of
> > > SWIOTLB, dma syncs are more or less no-ops, while (with SWIOTLB) they
> > > are copies from/to the bounce buffers.
> >
> > Ah I see.
> >
> > What if I add sync_for_device after copying the header? This should
> > synchronize the bounce buffer with the copied data I guess? A bit of
> > overhead, but this W/A triggers mostly on stuff like ARP/ICMP, "hotpath"
> > L4 protos are fortunately not affected.
> 
> That should work fine as well. I'm not certain I have strong
> preferences on the right answer here, other than "does it work and,
> ideally, is it less confusing?" The patch I posted is a bit
> unintuitive. I think what you are describing might make the workaround
> self-contained.

Could you please test this patch with SWIOTLB? If it doesn't fix
the issue, you can try changing `page_pool_get_dma_dir(hdr_pp)`
to `DMA_TO_DEVICE` and/or `DMA_BIDIRECTIONAL`.
Currently, I don't have any machines with SWIOTLB unfortunately =\
Let me know if any of these works. I'll submit it properly when we
have a solution.

(the patch applies cleanly to the latest net-next and should apply
 to a couple older kernel releases as well)

> 
> thanks,
> Steve
>  [And sorry for my gmail-driven top posting crimes D: ]

Thanks,
Olek
---
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 45ee5b80479a..42111d56d66f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3475,7 +3475,8 @@ static u32 idpf_rx_hsplit_wa(const struct libeth_fqe *hdr,
 			     struct libeth_fqe *buf, u32 data_len)
 {
 	u32 copy = data_len <= L1_CACHE_BYTES ? data_len : ETH_HLEN;
-	struct page *hdr_page, *buf_page;
+	const struct page_pool *hdr_pp;
+	dma_addr_t hdr_addr;
 	const void *src;
 	void *dst;
 
@@ -3483,16 +3484,20 @@ static u32 idpf_rx_hsplit_wa(const struct libeth_fqe *hdr,
 	    !libeth_rx_sync_for_cpu(buf, copy))
 		return 0;
 
-	hdr_page = __netmem_to_page(hdr->netmem);
-	buf_page = __netmem_to_page(buf->netmem);
-	dst = page_address(hdr_page) + hdr->offset +
-		pp_page_to_nmdesc(hdr_page)->pp->p.offset;
-	src = page_address(buf_page) + buf->offset +
-		pp_page_to_nmdesc(buf_page)->pp->p.offset;
+	hdr_pp = __netmem_get_pp(hdr->netmem);
+	dst = __netmem_address(hdr->netmem) + hdr->offset + hdr_pp->p.offset;
+	src = __netmem_address(buf->netmem) + buf->offset +
+	      __netmem_get_pp(buf->netmem)->p.offset;
 
 	memcpy(dst, src, LARGEST_ALIGN(copy));
 	buf->offset += copy;
 
+	/* Make sure SWIOTLB is synced */
+	hdr_addr = page_pool_get_dma_addr_netmem(hdr->netmem);
+	dma_sync_single_range_for_device(hdr_pp->p.dev, hdr_addr,
+					 hdr->offset + hdr_pp->p.offset,
+					 copy, page_pool_get_dma_dir(hdr_pp));
+
 	return copy;
 }
 
