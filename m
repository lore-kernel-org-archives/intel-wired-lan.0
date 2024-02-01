Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DEF9C4828D
	for <intel-wired-lan@archiver.kernel.org>; Thu,  1 Feb 2024 21:15:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BE00C43AB9;
	Thu,  1 Feb 2024 21:15:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BE00C43AB9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1706822139;
	bh=bdl3JrF+qJvV/Oemkqv+yMS3h8HL6zwH4z8p32I5K98=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Z7CQKe3VX7nghLXsQ3Yw66D599ZEDeMYFSuyDgt9FET4vFCZMFP5xVMMFwnCc64Qt
	 DfUt1g8+wWdi13sDtQUnPp0C4d8mxH5UaEUm64msFloib4+ku5oXs9SxfQ3DD/Gah1
	 TMbqrxZ3xN+l6fkBSiG+MQFw9s7XifJmGiSPILNypyJJGJBMP09eWlHfp2tVT6pkzm
	 TZn2QldiqeqV6v2K/gprkYrS75/lhA/2ixjrgIppJIl04z5RjNpNlcCvVNFw4MdN27
	 yGdv6qIlyYQx4ESIbHlt/fdjqmK+VhtTIXXKbgiS+TUlB0kEZdcNoJQKYXJB61oTzN
	 YlrG2IKzjaQWA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IRKNBnszlQuA; Thu,  1 Feb 2024 21:15:38 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5B96743ABC;
	Thu,  1 Feb 2024 21:15:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5B96743ABC
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id EE3EA1BF4D6
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 Feb 2024 18:40:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D345A83F0B
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 Feb 2024 18:40:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D345A83F0B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aemk97jwLYAK for <intel-wired-lan@lists.osuosl.org>;
 Thu,  1 Feb 2024 18:40:28 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4BF6683F03
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 Feb 2024 18:40:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4BF6683F03
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 38AA1CE276E;
 Thu,  1 Feb 2024 18:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B128C433C7;
 Thu,  1 Feb 2024 18:40:23 +0000 (UTC)
Date: Thu, 1 Feb 2024 12:40:22 -0600
From: Seth Forshee <sforshee@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Message-ID: <ZbvlltcGnSsq/Pf7@do-x1extreme>
References: <20240201154219.607338-1-maciej.fijalkowski@intel.com>
 <20240201154219.607338-3-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201154219.607338-3-maciej.fijalkowski@intel.com>
X-Mailman-Approved-At: Thu, 01 Feb 2024 21:15:37 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1706812823;
 bh=EavXvVxLpjlqE3esGFobog0or2KVXWyptDAH7zpW1To=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=on/t3uNS9+aVK3miPDTwjSmCY3tD3ooPbh5RjjfmMKRQzoVew2BAHtxIWYqsah19+
 RJKanrgi1ISHEdggHxkWG0ECJIHqeAIzJsOa2Cnsu9KFfPlQPyhSNPBfjqeAfK1S2X
 YwC3HExLHO4PIr0E34Cwsgjy8yKH6XmPbvkG6cVaeS6we6tt40nGKX+jfrn4eUZ66X
 0n5+70nJ9zx5ir5H5OzP3TLFwWhXQrdYWD6xRe7jiY9kYYsB3EscZ5iRotgCLyPs8L
 cg1p+7GETtzavEKDMvmqdhGo63vM+9Iu2K+lCwkOPvhkwKRpncCsxh3/z8lEmKsZji
 6VbnRgJd2bNnw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=on/t3uNS
Subject: Re: [Intel-wired-lan] [PATCH iwl-net 2/2] i40e: take into account
 XDP Tx queues when stopping rings
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
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 intel-wired-lan@lists.osuosl.org, magnus.karlsson@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Feb 01, 2024 at 04:42:19PM +0100, Maciej Fijalkowski wrote:
> Seth reported that on his side XDP traffic can not survive a round of
> down/up against i40e interface. Dmesg output was telling us that we were
> not able to disable the very first XDP ring. That was due to the fact
> that in i40e_vsi_stop_rings() in a pre-work that is done before calling
> i40e_vsi_wait_queues_disabled(), XDP Tx queues were not taken into the
> account.
> 
> To fix this, let us distinguish between Rx and Tx queue boundaries and
> take into the account XDP queues for Tx side.
> 
> Reported-by: Seth Forshee <sforshee@kernel.org>
> Closes: https://lore.kernel.org/netdev/ZbkE7Ep1N1Ou17sA@do-x1extreme/
> Fixes: 65662a8dcdd0 ("i40e: Fix logic of disabling queues")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

This fixes the issue we're seeing. Thanks!

Tested-by: Seth Forshee <sforshee@kernel.org>

> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 2c46a5e7d222..907be56965f5 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -4926,21 +4926,22 @@ int i40e_vsi_start_rings(struct i40e_vsi *vsi)
>  void i40e_vsi_stop_rings(struct i40e_vsi *vsi)
>  {
>  	struct i40e_pf *pf = vsi->back;
> -	int pf_q, q_end;
> +	u32 pf_q, tx_q_end, rx_q_end;
>  
>  	/* When port TX is suspended, don't wait */
>  	if (test_bit(__I40E_PORT_SUSPENDED, vsi->back->state))
>  		return i40e_vsi_stop_rings_no_wait(vsi);
>  
> -	q_end = vsi->base_queue + vsi->num_queue_pairs;
> -	for (pf_q = vsi->base_queue; pf_q < q_end; pf_q++)
> -		i40e_pre_tx_queue_cfg(&pf->hw, (u32)pf_q, false);
> +	tx_q_end = vsi->alloc_queue_pairs * (i40e_enabled_xdp_vsi(vsi) ? 2 : 1);
> +	for (pf_q = vsi->base_queue; pf_q < tx_q_end; pf_q++)
> +		i40e_pre_tx_queue_cfg(&pf->hw, pf_q, false);
>  
> -	for (pf_q = vsi->base_queue; pf_q < q_end; pf_q++)
> +	rx_q_end = vsi->base_queue + vsi->num_queue_pairs;
> +	for (pf_q = vsi->base_queue; pf_q < rx_q_end; pf_q++)
>  		i40e_control_rx_q(pf, pf_q, false);
>  
>  	msleep(I40E_DISABLE_TX_GAP_MSEC);
> -	for (pf_q = vsi->base_queue; pf_q < q_end; pf_q++)
> +	for (pf_q = vsi->base_queue; pf_q < tx_q_end; pf_q++)
>  		wr32(&pf->hw, I40E_QTX_ENA(pf_q), 0);
>  
>  	i40e_vsi_wait_queues_disabled(vsi);
> -- 
> 2.34.1
> 
