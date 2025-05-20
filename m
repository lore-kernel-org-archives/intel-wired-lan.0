Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9014C3DA6D
	for <intel-wired-lan@archiver.kernel.org>; Tue, 20 May 2025 15:06:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D3A66107A;
	Tue, 20 May 2025 15:06:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Aj2RnPRltULE; Tue, 20 May 2025 15:06:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D00A86108B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1747753589;
	bh=iuwkMN8lW+xcNsiQG7Aowg6AgoDBW5gxw1M7CZsxwXI=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lMLiDP6RmGbhI5A7Lj+pWURe4WOm28LQiPfjmRu/rFYcW9xDIKMDZwmauskq3F+CE
	 UhAplDA0Xn9bWR0N8IjJtqvNuVhIFhHQsAp2ajvyplpbFFgs9oETI+FoVxoeDV0Tva
	 waB28Hf3eKCZOj/cJpaj6fBTlrufWgO4CTPXBrNAMhEj3dzRpu5B/QwUo1fD+d8Fip
	 U+UjgpJTUDE7lG8fwPL5Jc3nGaOU0WRwwv+6nXFSlMJfqSDyPSuCOJDafyyv58cW+w
	 6k78J0DIL++UizBJy/j724wvTSeEkHksOIISOeaHbaWYrtOS3a2tkehsDevdsbNv7s
	 vYKaMmhPpl60w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D00A86108B;
	Tue, 20 May 2025 15:06:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EF515DE
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 May 2025 15:06:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E0CE580680
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 May 2025 15:06:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JqswsR0NVlkx for <intel-wired-lan@lists.osuosl.org>;
 Tue, 20 May 2025 15:06:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=147.75.193.91;
 helo=nyc.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 30FF280686
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 30FF280686
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 30FF280686
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 May 2025 15:06:25 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id D4B10A4EBDE;
 Tue, 20 May 2025 15:06:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A8AC4CEE9;
 Tue, 20 May 2025 15:06:21 +0000 (UTC)
Date: Tue, 20 May 2025 16:06:19 +0100
From: Simon Horman <horms@kernel.org>
To: Krishna Kumar <krikku@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, edumazet@google.com,
 intel-wired-lan@lists.osuosl.org, andrew+netdev@lunn.ch,
 kuba@kernel.org, pabeni@redhat.com, sridhar.samudrala@intel.com,
 ahmed.zaki@intel.com, krishna.ku@flipkart.com
Message-ID: <20250520150619.GZ365796@horms.kernel.org>
References: <20250520050205.2778391-1-krikku@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520050205.2778391-1-krikku@gmail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1747753584;
 bh=QPww7qfnARV4leuhCvCGrKI8AvKvoSsWTFouBCCaPYc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LYkKFlz05LorMAQjWfbGoFgphE5bSvssPZrHSMcxp2PLiv/LZ/55B8+bmbpDaaDgr
 eXU9T0cov/p234n5pZ2gLpMnU1xzvhmwzacKffXLQJl7O9qg0kE1m3y5h9fHNZdiEE
 N1xYctwNV3M2ikgaF/Q092IRUOZFmWiSILwmcfq954oBQwikabGUFOnzzoSNTTDTQd
 jBPrIxaXR8tXdN7Li0Y/Z/Y35V6zrLbmpkyFLdk3mINMt5KCD9KiG342IAqM6De3eH
 RrsE1S6e9oLGqKib8Hkego9d+NCW4Q0tXkIW+oPr+ePWfMN8MTQstQAZJzpkGd/cnM
 sE1ySX6kiOeqw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=LYkKFlz0
Subject: Re: [Intel-wired-lan] [PATCH] net: ice: Perform accurate aRFS flow
 match
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

On Tue, May 20, 2025 at 10:32:05AM +0530, Krishna Kumar wrote:
> This patch fixes an issue seen in a large-scale deployment under heavy
> incoming pkts where the aRFS flow wrongly matches a flow and reprograms the
> NIC with wrong settings. That mis-steering causes RX-path latency spikes
> and noisy neighbor effects when many connections collide on the same has
> (some of our production servers have 20-30K connections).

...

> 
> Signed-off-by: Krishna Kumar <krikku@gmail.com>

Hi Krishna,

As a fix if this should probably have a Fixes tag.

And it would be useful to denote the target tree in the subject.

E.g. [PATCH iwl-net] ...

> ---
>  drivers/net/ethernet/intel/ice/ice_arfs.c | 45 +++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_arfs.c b/drivers/net/ethernet/intel/ice/ice_arfs.c
> index 2bc5c7f59844..b36bd189bd64 100644
> --- a/drivers/net/ethernet/intel/ice/ice_arfs.c
> +++ b/drivers/net/ethernet/intel/ice/ice_arfs.c
> @@ -377,6 +377,47 @@ ice_arfs_is_perfect_flow_set(struct ice_hw *hw, __be16 l3_proto, u8 l4_proto)
>  	return false;
>  }
>  
> +/**
> + * ice_arfs_cmp - Check if aRFS filter matches this flow.
> + * @fltr_info: filter info of the saved ARFS entry.
> + * @fk: flow dissector keys.
> + * n_proto:  One of htons(IPv4) or htons(IPv6).
> + * ip_proto: One of IPPROTO_TCP or IPPROTO_UDP.

nit: A '@' is required to document function parameters.

 * @nproto: ...
 * @ip_proto: ...

> + *
> + * Since this function assumes limited values for n_proto and ip_proto, it
> + * is meant to be called only from ice_rx_flow_steer().

Please also document the return value using "Return: " or "Returns: ".

Flagged by ./scripts/kernel-doc -Wall -none

> + */

...
