Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EFB9C44501
	for <intel-wired-lan@archiver.kernel.org>; Wed,  8 Jul 2026 14:36:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ECD35812B6;
	Wed,  8 Jul 2026 14:36:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W3L6yViIYUYa; Wed,  8 Jul 2026 14:36:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DF13D812F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1783521402;
	bh=+sg0cd/dOtDSeooJg4oAtROLzWI4irmZPtRfZt3Xg10=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NDEIAdlPN/YqYR++CyzcIe+YPdM19kBbj9+XwIZTaRCRL2QpEfg9sUyIUAqU25sDz
	 lKh/ho2Mm/mKPfLuwWH16A/g/xO5tq2tsxppFcCfHiNyW6BXOsDP3e9i8eBSZF1dVC
	 xrokmZ9AJ2uo/HtoiY9x/g6Gh4wig8/ogRDdzFqYnbQUfw+bYKE1oJWWx6huqQ+xMB
	 gKYZ7pg3WYTGcdkyRGqOMIWPBHzNs71S2bxMEsEIk3opvYNuKwEzUPYPzx/QLuTRoo
	 6EhtNU3Y8bsvqRI31DHab2abT6pypUrnuHdMnOS/1Znwh66E5y/TfHwrrLsaz7DlJa
	 Z2yiSk3QrQ39A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF13D812F8;
	Wed,  8 Jul 2026 14:36:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 45F3E315
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Jul 2026 14:36:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2BB4E40084
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Jul 2026 14:36:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dSKOEPjYq8Ek for <intel-wired-lan@lists.osuosl.org>;
 Wed,  8 Jul 2026 14:36:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 131AE4007A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 131AE4007A
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 131AE4007A
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Jul 2026 14:36:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 975C6405A1;
 Wed,  8 Jul 2026 14:36:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E16F1F00A3A;
 Wed,  8 Jul 2026 14:36:36 +0000 (UTC)
From: Simon Horman <horms@kernel.org>
To: mheib@redhat.com
Cc: Simon Horman <horms@kernel.org>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch
Date: Wed,  8 Jul 2026 15:36:01 +0100
Message-ID: <20260708143601.1491656-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701093830.948756-1-mheib@redhat.com>
References: <20260701093830.948756-1-mheib@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1783521399;
 bh=+sg0cd/dOtDSeooJg4oAtROLzWI4irmZPtRfZt3Xg10=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=YBNNycRn/HVArimdqvQVG4cesmyWfHBX8eimHeL+dpAPEbq1wd0Etn0ggTXixdepX
 LakOxAH1a/MpcAynAKGAKGL7wofGaH5cyk/+RQ1BW7YRYZIIOCpRaE5rpzZBozdD9J
 4WYfeWT3JIY00jASrSQLGOuk7ce3jcyYi++hT3tuHpOeQgffT8mixCleLJWzqtxK4x
 iQD33PxJtLJRCBcigs/Fvd+FonAACgGKhQgSvHAswQrz7Bpa3g02MQb/jNTqkQ1Izi
 6DGRyEZqZzW87Q6t2A2XzB0ugroPFEMl/fLT7n1JddWKhSrYDLtohNbJKl19h8AXQj
 Qz0ELMY7WW3eg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=YBNNycRn
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 1/2] i40e: move ATR sample
 rate from ring to PF level
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

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
i40e: move ATR sample rate from ring to PF level

This commit moves the ATR sample rate configuration from the per-ring level
to the PF level. It initializes the sample rate globally during software init
and updates the fast path to reference the PF structure.

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index a04683004a567..4d4d4b07a0f3a 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
[ ... ]
> @@ -3454,12 +3454,7 @@ static int i40e_configure_tx_ring(struct i40e_ring *ring)
>  		ring->xsk_pool = i40e_xsk_pool(ring);
>  
>  	/* some ATR related tx ring init */
> -	if (test_bit(I40E_FLAG_FD_ATR_ENA, vsi->back->flags)) {
> -		ring->atr_sample_rate = I40E_DEFAULT_ATR_SAMPLE_RATE;
> -		ring->atr_count = 0;
> -	} else {
> -		ring->atr_sample_rate = 0;
> -	}
> +	ring->atr_count = 0;

[Severity: High]
Does removing this per-ring initialization remove the protection against
dynamic ethtool flag toggles?

Previously, if the ring was configured while Flow Director ATR was disabled,
the ring's sample rate was cached to 0 in i40e_configure_tx_ring(). This
prevented descriptor injection even if the PF flag was later toggled on
without a ring reset.

[ ... ]
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index 894f2d06d39d0..b36e0fc9b31d2 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
[ ... ]
> @@ -2879,7 +2879,7 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
>  		return;
>  
>  	/* if sampling is disabled do nothing */
> -	if (!tx_ring->atr_sample_rate)
> +	if (!pf->atr_sample_rate)
>  		return;

[Severity: High]
Can this global check lead to a hardware Malicious Driver Detection (MDD)
event if ethtool flags are modified dynamically?

If an administrator performs the following sequence:

1. Disables flow-director-atr via ethtool.
2. Disables ntuple (which resets the ring and sets tx_ctx.fd_ena = 0).
3. Re-enables flow-director-atr.

The final step does not trigger a ring reset, so fd_ena remains 0 in the
hardware queue context.

However, I40E_FLAG_FD_ATR_ENA is now true, and pf->atr_sample_rate is
globally set to a non-zero value.

Will i40e_atr() now proceed and inject FDIR descriptors into a TX queue
that is not configured for FDIR?

If so, does this cause the hardware to trigger an MDD event and hang the
TX queue?
