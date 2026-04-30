Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A26FF8873
	for <intel-wired-lan@archiver.kernel.org>; Thu, 30 Apr 2026 16:21:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4F4B242AF5;
	Thu, 30 Apr 2026 16:21:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lmJhZ3iFXt4m; Thu, 30 Apr 2026 16:21:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7345B42B1F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777566116;
	bh=NNxodg5+ELqYxc66CqymVWFqOnfg/kgkhpf3ALWnR5M=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DWtGcy+bKky64kaB10KHqlGrC5c5gIFE9WeUt83bK4OH5iOOQVT0hWUwW5pDKi43p
	 xXScXPTmlfPpzWNOTnhE5A4vOsxL1KJzaPbhFvCOAqABDMtLrr0BqNLM0AVxuqNTrX
	 ry0/RKyNM/SmTKP8v6I3H0aY5/205oyD/WW36o4EY9ahmSDHWKl1lG9c12KQ6O0Y6z
	 vTuuiSOGUftM5A4D6O9EDPqLvmr7eyZmDzTT+sVzZEEelAm9fHhI2sEjK93+LZ1yHn
	 Yrjk/2T2H4Ql5msCc06jMFoHxzc7B9gMwS8FUCOjNIMabFPLB+BK8ShzYvpxMRhlDq
	 90PbgYqJGZgig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7345B42B1F;
	Thu, 30 Apr 2026 16:21:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 02F0818F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Apr 2026 16:21:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E917184BF8
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Apr 2026 16:21:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w96ZfafWcnud for <intel-wired-lan@lists.osuosl.org>;
 Thu, 30 Apr 2026 16:21:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 21FA284BF3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 21FA284BF3
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 21FA284BF3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Apr 2026 16:21:53 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5E4D641678;
 Thu, 30 Apr 2026 16:21:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FEBC2BCB3;
 Thu, 30 Apr 2026 16:21:51 +0000 (UTC)
Date: Thu, 30 Apr 2026 17:21:49 +0100
From: Simon Horman <horms@kernel.org>
To: michal.swiatkowski@linux.intel.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 jramaseu@redhat.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, aleksandr.loktionov@intel.com
Message-ID: <20260430162149.GC900403@horms.kernel.org>
References: <20260428070647.777141-3-michal.swiatkowski@linux.intel.com>
 <20260430152948.1683359-2-horms@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430152948.1683359-2-horms@kernel.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1777566113;
 bh=q1y7v3R/mJEb3oVMPBZ0EISfvAz0p1kLishWt8cqbrE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eO0mTkYr3Mhqw1AVngfjY5nvmPo4IBhVQer5hsPJ+v6G7+sd/JjGDlHl/jk4t3dVN
 2pHT76YZVtfgEMR0YDt0ktbJCrzs72BsCt5+O9x19ZfdSncCQMpPv6XOTj5IYSH4oO
 sdmev+eekoP9aGFzO/PdXd3a4xziSKnTymtXKH/bqFThpxHj/j758EuZ2Xc511t/3j
 IqdEVU5XF+ItKFjpsZPMTAP8IwH2YZTdl6LmsODm+K7P+jBAKV1gb9tb5eLv5wOut3
 G3PJZNO3tZZHbBzkntysBLFxyIBTkH5eNv+vkpHxQkyEzfN7CB5SdzblUxXrASUcjn
 rdbyUwEZ0J9FA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=eO0mTkYr
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1 2/2] ice: use
 NETIF_F_HW_CSUM instead of IP/IPV6
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

On Thu, Apr 30, 2026 at 04:29:49PM +0100, Simon Horman wrote:
> From: 'Simon Horman' <horms@kernel.org>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev

Sorry, the email I am responding to was supposed to come with
some commentary - it seems my method for adding it is broken :(
So I'm adding it below (as best as I can remember what it was).

> ---
> ice: use NETIF_F_HW_CSUM instead of IP/IPV6
> 
> This commit replaces the IP and IPV6 checksum offload flags with HW_CSUM
> in the ice driver to allow hardware checksumming for IPv6 packets with
> extension headers. It also removes the mutual exclusivity check between
> TSO and GCS.
> 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> > index 5f92377d4dfc..33f252a6a22f 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > @@ -3491,9 +3491,8 @@ void ice_set_netdev_features(struct net_device *netdev)
> >  			NETIF_F_RXHASH;
> >  
> >  	csumo_features = NETIF_F_RXCSUM	  |
> > -			 NETIF_F_IP_CSUM  |
> >  			 NETIF_F_SCTP_CRC |
> > -			 NETIF_F_IPV6_CSUM;
> > +			 NETIF_F_HW_CSUM;
> 
> By advertising NETIF_F_HW_CSUM, the network stack assumes the driver can handle
> checksums for any protocol and passes non-IP packets (e.g., from AF_PACKET
> injected frames) to the driver with CHECKSUM_PARTIAL.
> 
> Since ice_tx_csum() strictly parses the L3 header and expects IPv4 or IPv6,
> returning -1 for other protocols, will this regression cause non-IP packets to
> be silently dropped instead of falling back to software checksums in the kernel?

The problem above seems to be a legitimate concern, if a corner case.
It seems to also exist in i40e.

> Additionally, skb_csum_hwoffload_help() relies on NETIF_F_IPV6_CSUM to
> safely fall back to software checksums when IPv6 extension headers are
> present.
> 
> Does using NETIF_F_HW_CSUM bypass this safeguard, potentially causing
> legacy hardware (like E810) or E830 without GCS descriptors to compute
> incorrect pseudo-headers and silently corrupt IPv6 packets with extension
> headers?

The issue above seems to be a false positive as the ice driver
doesn't rely on the behaviour described. Rather ice_tx_csum()
uses ipv6_skip_exthdr() to correctly handle extension headers.

> 
> Finally, for protocols other than TCP, UDP, or SCTP, the driver falls back to
> calling skb_checksum_help(skb) in the default case of ice_tx_csum().
> 
> However, the driver appears to ignore the return value of skb_checksum_help().
> 
> If skb_checksum_help() fails (e.g., due to -ENOMEM during pskb_expand_head()),
> could this result in the packet being transmitted with an uncomputed checksum?

The problem above seems real to me, but it also seems to be pre-existing.
So I don't think it should delay progress of this patch.

If it is a problem, it also seems to be present in i40e.
