Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CD9606A333
	for <intel-wired-lan@archiver.kernel.org>; Wed,  4 Nov 2026 07:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=6AM+V675;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=me4p4b5G
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D7CE5405C6;
	Wed,  4 Nov 2026 07:51:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SB_7f9RlebmN; Wed,  4 Nov 2026 07:51:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 19726405D6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793778665;
	b=NxKoEJa5RhdeNKRB2uXQQobVDP36AK0pAh80/p/Q5oApyHyffGopVu2lIV53sbmjMXHl
	 XEeoj4mQ+NqkgHs+CaIHFBHxOHtIT6I7HcJAHVkV4Fn0HaoBNbZ4yz8RgQSfez+sdcei1
	 2IAxSOk9GEz1BXJlw53dnUFNUZ+Vbr0WFITWrl5omYXo7S7DlbiFBg9x1IAC6g8qLfxH7
	 XAUVRZ0ie0MCZWidxkRde6Vbo8sp3YSkS3liYpU2I5XKdPZ0mNtsKjSNiw/RYjzYRUybj
	 R0X6QRPQlSWn+r2SuYbYOUprys/40f8mBFAfkme4j72qi12h5XZDwSCnpp8LYos52Qw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793778665;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+x0caZ0pC+EFyWhDfl1gmIN09MGJqKHTRPG88Kl6DZ4=;
	b=FC9yUVONZYvchOcd40qxLpQ4tYeuW5wRr3q+46A03IkmekboY5oLLI+Y+ScF61wBvAgC
	 gkLFki0jLmMn90oYFDJ218AfCHhS6FenRLvYvfy+THHIFUuVbDlNFbnmQlajCf9EtdN7f
	 Gx+79Kj6YKfHWTUX3ERq+G7lm4nyNJVn1Cr9GWDj4o1KkEZk0nWP6ZvR86epWLHygCx8e
	 EIWmABsSDtr+eGQFiUc/o/fi/Ka7udWwsBADvagwO1IBk+X6X9/0aGt9gNUelo7pBdpF1
	 aVFKZUCarFbKTv5drjEQ66bDha766ldTfPau5Fk3Jpuec8LL+qaqeUlMP1s/aGRKfIQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793778665;
	bh=+x0caZ0pC+EFyWhDfl1gmIN09MGJqKHTRPG88Kl6DZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=6AM+V67549LHtBWoJ6qKTOntTnWiHLksbiNXJ8Sp61K10ZmegmcDVDoGUj48foeiN
	 GHMaBWKVNNK0rDNrIiFdK+ajPkVDyz6x3JRWYlnm3ZExTZeUcINOB/LcMN/y71lzgK
	 /4Ko8FXqeBdAvWd/7G338nHZafalNXCKxw+KL0Kzn+pAb2Xg8R5efIgKHdNNOdP1Vw
	 94BnNTHpLOfIp9F+hI/w9JJgdSbD/FkFtdRiiopcvjoX0c69r3OkzRlzf7g/8ZXV8a
	 cuzQuJNAYKpn5Zvm5bYPchEuz/PYc/MFAKHz6Qj2aAbNJ0IWBgV0Ab942E/6Uuh2Pq
	 qg/BRNjCu4/2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19726405D6;
	Wed,  4 Nov 2026 07:51:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CDBCB2AC
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 07:51:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C789C400CC
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 07:51:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hyLP8AC03s_9 for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Nov 2026 07:51:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E45444004D
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793778663;
 b=O2NDw7vni/rjnqzNL568kMMbyF/kIDCB95e5AXKffqeVAW4GU21VP34symYEvtXOBorK
 31L0COpIA52k4uulT4i9XLQr3DGhr81Bu/uHgKqklhS9wVQmSQCZrHHqK6OHNkBoaYCzB
 5T2r3t36ebI3X4eEx3TUnk9DJmTt5qm8l2cZ5PfejYdGOkOSdM3uhzFQKJwg8VDEenqjv
 XqJ+9otQVBO6YrtdjQcIgQh8rJo6p37UpuvqboKiYBp6j5vYgPHWZruX22p6Izw/I0nbj
 eWIV2TKUewZSK/lIV57kEJVcgow9ApwNZe4XecN6C6alyok74k1kAwzXnYIgNCbc2XQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793778663;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=+x0caZ0pC+EFyWhDfl1gmIN09MGJqKHTRPG88Kl6DZ4=;
 b=Jqm72xI+zZMdc7qIWNLdJzA/jQlbknN3kEWBBca0xpQp8B+48l5LNNCtbV8ls74+kOPn
 S8TdsuTeu57JABH6KoZ4BgYWD+CFaUUmFeOf8zA8DG+n4O2pVMautBLADfG9Bqnruq2ml
 oCOeQvAasswT+9j66T4zcGfD6yoFKwQGd7mxQzQj5w46/SVIEdQRTXI9NaxqZCGRzTYRw
 EheVzVr934ijFuFZbrszrh5Bmk7uLgdo/n4xMwv6I17SFLFzWbqF7ns0nM1DnMlN67OjG
 WjLLZSZuAs0RQ05SnBuGkbI7b59tg+h0GfvRZCR1HHhu37k/RM7/5iLAomuK8aOdzGQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=me4p4b5G; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=leon@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=me4p4b5G
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E45444004D
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 07:51:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BF29660D81;
 Wed,  4 Nov 2026 07:50:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3DBD1F00919;
 Wed,  4 Nov 2026 07:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793778659;
 bh=+x0caZ0pC+EFyWhDfl1gmIN09MGJqKHTRPG88Kl6DZ4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=me4p4b5GiB/BbaLFQXgar5GxXH6vWVN4hC6duaEOq4LD6uI5ioz0Tw31jQev5ByJK
 cMXVyvv5tnfWAcP4bp6XIy2rg4rHW2UCGpnG8pdzsFa0B2XXz7lHAI0xdEfXk9Kzc1
 kHzKcdOVeOvwbqr2S9wSTFITUn/8wJuu284URItSC6scrOgb2//2/Q4N9Yg+pHr2d8
 cte33u8ZdCddF9selZfGEHrE5Cw/IKdoGe1fFA46tpOdgUi6mHQlVvWyETygWKeRyd
 5WcbdTs5MiGCmkoZ+UjUQMAWM2FjoWTnGh4Lo7lwsQF8ezaApzh5zYX+lGLofpy+Aw
 gSqn/thmWw1lg==
Date: Wed, 4 Nov 2026 09:50:55 +0200
From: Leon Romanovsky <leon@kernel.org>
To: David Hu <dhu@x6u.co>
Cc: Mustafa Ismail <mustafa.ismail@intel.com>,
 Shiraz Saleem <shiraz.saleem@intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jacob Moroni <jmoroni@google.com>,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Hu <xuehaohu@google.com>
Subject: Re: [PATCH rdma-next v4 0/6] RDMA/irdma: Add support for ioctl
Message-ID: <20261104075055.GL264423@unreal>
References: <20261030181512.2056056-1-dhu@x6u.co>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030181512.2056056-1-dhu@x6u.co>
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 06:15:06PM +0000, David Hu wrote:
> From: David Hu <xuehaohu@google.com>
> 
> Hello,
> 
> This patch series introduces support for uverbs ioctl queue creation
> (QP, CQ, and SRQ) in the irdma driver. This series makes progress towards
> modernizing irdma. This enables 1-step queue creation from pinned UMEMs
> and shared dma-buf heaps (system_cc_shared), providing RDMA support for
> Confidential Computing (CoCo) guest environments where memory encryption
> otherwise prevents standard host-VA-based queues from operating.
> 
> Historically, irdma relied on legacy write() commands for queue setup.
> This series modernizes irdma's queue creation path by adopting the ioctl
> infrastructure:
> 
> 1. Plumbs uverbs_attr_bundle into the irdma QP and SRQ creation routines.
> 2. Registers irdma's UVERBS ioctl namespace definition for QP, CQ, and SRQ.
> 3. Implements 1-step queue buffer creation for QP, CQ, and SRQ using
>    UVERBS_ATTR_CREATE_*_BUF_UMEM attributes and ib_umem_get_attr(),
>    configuring hardware Page Buffer Lists (PBLs) directly from pinned umems.
> 4. Split CQ creation setup logic by umode and kmode into separate
>    routines to be consistent with other queue creation logic.
> 5. Adds support for driver-specific shadow area UMEM attributes during CQ
>    creation with CQ resize capability.
> 6. Preserves backward compatibility with legacy 2-step write() path
>    registrations when UMEM attributes are not provided.
> 
> User space rdma-core PR: https://github.com/linux-rdma/rdma-core/pull/1766
> 
> Testing:
> Verified with rc_pingpong, srq_pingpong, and dmabuf_pingpong over irdma
> devices in Confidential VM environments.
> 
> Changes in v4:
> - Reject dma-buf queue creation in iWARP mode and enforce page-offset
>   alignment unconditionally in irdma_setup_q_pbl_from_umem() (Jacob)
> - Bound attr->cqe in irdma_create_user_cq() to prevent cq_pages overflow (Sashiko)
> - Fix to irdma_cq_free_rsrc() was sent separately (Sashiko)
> - Link to v3: https://lore.kernel.org/all/20261016202909.1289496-1-dhu@x6u.co/

I applied the series, but I have a concern: the commit messages are
not useful.

Thanks
