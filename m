Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034F8EEA84C
	for <intel-wired-lan@archiver.kernel.org>; Thu, 12 Feb 2026 19:31:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD6CD41164;
	Thu, 12 Feb 2026 19:31:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SofNhz-a0diP; Thu, 12 Feb 2026 19:31:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1CA0C4115E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770924668;
	bh=W9lSqXvbQ7SBvsiQ8zbGfXJLzNXZuBydZTTDeeGX5V4=;
	h=In-Reply-To:References:From:To:Cc:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=6VuIQTwGrTAZN6tlp19L9BxYh5Q48d9emdNkHpFiJNBhwE14B02aradM/0ZTBKhOj
	 ngQnUSNH8sTxOPQl6Q3M83/ZuWyW4J8/hby71EwihMZjrKlLUmZT75IJnOTQ68Xe55
	 xSYDFjjynFuWDj0gac7jY8Fxo04YRsq/9DcZway4gvW6Xvfps/1lE2bbVkg/c5heJS
	 oiZPYKuBQp1/v/PfdG/1nRlP0bwcZ67jFNZp4DSaR8FEaIxcPsKil7Qyp3gGmyuVAA
	 9C3hP2iOHyCPYgTt/sbZl4z9DfrrpgbUIAo2fUcyCFfyWBbn3AkBHNzKcqzX4LgYX5
	 iwEfTQjw6BGeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1CA0C4115E;
	Thu, 12 Feb 2026 19:31:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 045A5EC
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Feb 2026 19:31:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E8C8360762
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Feb 2026 19:31:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M0CPnPF2mHhV for <intel-wired-lan@lists.osuosl.org>;
 Thu, 12 Feb 2026 19:31:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=bot+bpf-ci@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D7E556071E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D7E556071E
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D7E556071E
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Feb 2026 19:31:03 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0A7A0433FB;
 Thu, 12 Feb 2026 19:31:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32734C4CEF7;
 Thu, 12 Feb 2026 19:31:02 +0000 (UTC)
Content-Type: multipart/mixed; boundary="===============3404291497187834089=="
MIME-Version: 1.0
Message-Id: <105606c43804c23ec856f4ec17a08286f182061e547f954359e2e0325d0d3a6f@mail.kernel.org>
In-Reply-To: <20260212183328.1883148-5-larysa.zaremba@intel.com>
References: <20260212183328.1883148-5-larysa.zaremba@intel.com>
From: bot+bpf-ci@kernel.org
To: larysa.zaremba@intel.com,bpf@vger.kernel.org
Cc: larysa.zaremba@intel.com, claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
 wei.fang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, shuah@kernel.org,
 aleksander.lobakin@intel.com, maciej.fijalkowski@intel.com,
 bastien.curutchet@bootlin.com, tushar.vyavahare@intel.com,
 kernelxing@tencent.com, rbm@suse.com, echaudro@redhat.com, lorenzo@kernel.org,
 toke@redhat.com, imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-kselftest@vger.kernel.org, aleksandr.loktionov@intel.com,
 dtatulea@nvidia.com, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin
 .lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com,
 ihor.solodrai@linux.dev
Date: Thu, 12 Feb 2026 19:31:02 +0000 (UTC)
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1770924662;
 bh=CfyMoN19AB34Wz5ReWi6alLjCIlR82xPRObwiwQjs/0=;
 h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
 b=uAwqP0ZNhEW5Vagfetvw+PvGC8DYBv2pnSNHyd1ovIS88pn9ifnTiDPBYMEgDtfBi
 156V17wRWRf5GaA0M4JDS5ELgZFPsToJluBFN1XLAGhKW8KgCeXz5gDB6+vnQ/qdzt
 ErH1JSBmG1tJomT9882swyU1xVor44SJj2wBmtUfim4nUsRCLmHH2crP79+8i/KLrJ
 RL96EddJ5mcRRkjR+VGWrMdsl2IvJvHtDwUCqRRaZyXq0yzheA5CtI69vZAFbKLgJb
 Kx+0YVrKWQsw/ZPaeChxh75VEwtzllV+os7CJyqECsn8HZNcyzJPsZEB+oOKEDJZrK
 ZKgv9CAsQkFjA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=fail reason="signature verification failed" (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=uAwqP0ZN
Subject: Re: [Intel-wired-lan] [PATCH bpf v2 3/9] ice: fix rxq info
 registering in mbuf packets
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

--===============3404291497187834089==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
> index eadb1e3d12b3..511d803cf0a4 100644
> --- a/drivers/net/ethernet/intel/ice/ice_base.c
> +++ b/drivers/net/ethernet/intel/ice/ice_base.c
> @@ -663,23 +663,12 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
>  	int err;
>
>  	if (ring->vsi->type == ICE_VSI_PF || ring->vsi->type == ICE_VSI_SF) {

[ ... ]

> @@ -702,14 +691,13 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
>  			if (err)
>  				return err;
>
> -			if (!xdp_rxq_info_is_reg(&ring->xdp_rxq)) {
> -				err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
> -							 ring->q_index,
> -							 ring->q_vector->napi.napi_id,
> -							 ring->rx_buf_len);
> -				if (err)
> -					goto err_destroy_fq;
> -			}
> +			err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
> +						 ring->q_index,
> +						 ring->q_vector->napi.napi_id,
> +						 ring->rx_buf_len);
> +			if (err)
> +				goto err_destroy_fq;

The registration condition check was removed, so __xdp_rxq_info_reg() is
now called unconditionally. This works correctly when cleanup properly
unregisters the xdp_rxq, but there appears to be a gap for ICE_VSI_SF
in non-XSK mode.

Looking at ice_clean_rx_ring() in ice_txrx.c:

    if (rx_ring->vsi->type == ICE_VSI_PF &&
        xdp_rxq_info_is_reg(&rx_ring->xdp_rxq)) {
        xdp_rxq_info_detach_mem_model(&rx_ring->xdp_rxq);
        xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
    }

This only unregisters for ICE_VSI_PF, not ICE_VSI_SF. With the old code,
the conditional registration skipped re-registration for ICE_VSI_SF. With
this change, for ICE_VSI_SF in non-XSK mode during reconfiguration:

1. ice_clean_rx_ring() - doesn't unregister (only checks ICE_VSI_PF)
2. ice_vsi_cfg_rxq() - unconditionally calls __xdp_rxq_info_reg()
3. __xdp_rxq_info_reg() sees REG_STATE_REGISTERED and triggers:

    WARN(1, "Missing unregister, handled but fix driver");

While this is handled gracefully by the XDP core (it unregisters internally
before re-registering), will this cause spurious WARN splats for subfunction
devices on every reconfiguration?

Should the ICE_VSI_PF check in ice_clean_rx_ring() be updated to also
include ICE_VSI_SF to match the registration path?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21960574055

AI-authorship-score: low
AI-authorship-explanation: The commit shows domain-specific knowledge of ice driver internals and XDP subsystem, with targeted changes that suggest human authorship by an Intel driver developer.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: The issue causes WARN splats for ICE_VSI_SF devices during reconfiguration, but is handled gracefully by XDP core without functional impact.

--===============3404291497187834089==--
