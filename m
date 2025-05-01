Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E458DC3ABA3
	for <intel-wired-lan@archiver.kernel.org>; Thu,  1 May 2025 15:16:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C63260BFF;
	Thu,  1 May 2025 15:16:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AhMEV4VcY9oe; Thu,  1 May 2025 15:16:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E062461017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1746112586;
	bh=3e9ohA1va28FYnRqMtb/jkq02WaNjAyLP9pR6RD01wI=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=9otLFGvWno/figspJQICYfMG3c4890MVcfZ0IiRwCPM9VNfvKE4r0wG+BW0EiIav2
	 cHuSbury69n9K7qJMc9h4I3cwO6rR1zR9FqqvTGlaC+KbG4ggoMXxy8kLNiFkqEZkQ
	 K5s2UlTkktmKtcCQwSekP7obND23Dd1aysI8cdT8WT9uNqn5ETVhqz1hPW1D6DMMSp
	 z2QwWaBCHcSpxMsKmCKyfC1inK8QPSRPztXwq/nhiNQ3kIWYBzDHlV/Ik/BLV/mGlV
	 bQjp4fNyTxSNiEb/rwWo/pvSoZAciSvEehQoFykHZzZAmyppj5Dzmm/U4Z1nRKYHN8
	 rzeEpQgfFDuig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E062461017;
	Thu,  1 May 2025 15:16:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 04DCF22D
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 May 2025 15:16:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DF6AB415D0
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 May 2025 15:16:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jrmUOM6VMt9U for <intel-wired-lan@lists.osuosl.org>;
 Thu,  1 May 2025 15:16:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3EA894126B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3EA894126B
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3EA894126B
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 May 2025 15:16:24 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B621261136;
 Thu,  1 May 2025 15:15:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA65C4CEED;
 Thu,  1 May 2025 15:16:19 +0000 (UTC)
Date: Thu, 1 May 2025 16:16:16 +0100
From: Simon Horman <horms@kernel.org>
To: Brian Vazquez <brianvv@google.com>
Cc: Brian Vazquez <brianvv.kernel@gmail.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, David Decotigny <decot@google.com>,
 Anjali Singhai <anjali.singhai@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 emil.s.tantilov@intel.com, Josh Hay <joshua.a.hay@intel.com>,
 Luigi Rizzo <lrizzo@google.com>
Message-ID: <20250501151616.GA3339421@horms.kernel.org>
References: <20250428195532.1590892-1-brianvv@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428195532.1590892-1-brianvv@google.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1746112582;
 bh=DeYBnZVHnZYEBZhQbxUl90si40aAkCAJWkQr9vzu+tQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LhV8uj6mRlmldjAzOQWpKP4k92NlF/xe+O2L/AzByiLRYby8Q0FpKTAWSctizCsa4
 H4t9XBEPXfl0LWGUG4DWoHJtYzjSVE5+05tPTDYQbZp782KnSMZ55MVucclwfbG6Z4
 h0U49b79IAwW/RcZlXaqrVQbxQYZUqaj9KCvwHeE/M7mtP6KEdp2a/QPm5bTuVRQ34
 XPFQ6B2A5PrjoFjPB/3QPKt7Qy/TwhFoWYAVW5xrAj0A/jHKNqhpl3Io5OcvR0Lrjb
 M7sHAjyHBcnHRrsKl9R5XhTwGdYU0VL3i51ode36mwAfFHChrBY1Kmz3b0Xh3SNhU8
 xXG5KHUwZwcGw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=LhV8uj6m
Subject: Re: [Intel-wired-lan] [iwl-net PATCH v2] idpf: fix a race in txq
 wakeup
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

On Mon, Apr 28, 2025 at 07:55:32PM +0000, Brian Vazquez wrote:
> Add a helper function to correctly handle the lockless
> synchronization when the sender needs to block. The paradigm is
> 
>         if (no_resources()) {
>                 stop_queue();
>                 barrier();
>                 if (!no_resources())
>                         restart_queue();
>         }
> 
> netif_subqueue_maybe_stop already handles the paradigm correctly, but
> the code split the check for resources in three parts, the first one
> (descriptors) followed the protocol, but the other two (completions and
> tx_buf) were only doing the first part and so race prone.
> 
> Luckily netif_subqueue_maybe_stop macro already allows you to use a
> function to evaluate the start/stop conditions so the fix only requires
> the right helper function to evaluate all the conditions at once.
> 
> The patch removes idpf_tx_maybe_stop_common since it's no longer needed
> and instead adjusts separately the conditions for singleq and splitq.
> 
> Note that idpf_rx_buf_hw_update doesn't need to check for resources
> since that will be covered in idpf_tx_splitq_frame.

Should the above read idpf_tx_buf_hw_update() rather than
idpf_rx_buf_hw_update()?

If so, I see that this is true when idpf_tx_buf_hw_update() is called from
idpf_tx_singleq_frame(). But is a check required in the case where
idpf_rx_buf_hw_update() is called by idpf_tx_singleq_map()?

> 
> To reproduce:
> 
> Reduce the threshold for pending completions to increase the chances of
> hitting this pause by changing your kernel:
> 
> drivers/net/ethernet/intel/idpf/idpf_txrx.h
> 
> -#define IDPF_TX_COMPLQ_OVERFLOW_THRESH(txcq)   ((txcq)->desc_count >> 1)
> +#define IDPF_TX_COMPLQ_OVERFLOW_THRESH(txcq)   ((txcq)->desc_count >> 4)
> 
> Use pktgen to force the host to push small pkts very aggressively:
> 
> ./pktgen_sample02_multiqueue.sh -i eth1 -s 100 -6 -d $IP -m $MAC \
>   -p 10000-10000 -t 16 -n 0 -v -x -c 64
> 
> Fixes: 6818c4d5b3c2 ("idpf: add splitq start_xmit")
> Signed-off-by: Josh Hay <joshua.a.hay@intel.com>
> Signed-off-by: Brian Vazquez <brianvv@google.com>
> Signed-off-by: Luigi Rizzo <lrizzo@google.com>

...
