Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA29606A334
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Nov 2026 09:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=olI32TsK;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AVPs0/VE
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EDB1F40665;
	Tue, 24 Nov 2026 09:56:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IlKTBTt3xYyC; Tue, 24 Nov 2026 09:56:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1DFF44066F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795514197;
	b=Yf7w/vzzHK4/hh8M2b3GqLpbtEYjh/QazxHY33fIhlOhFyQKL+wz7SznmvC5srWMNpxa
	 dAH6Q371kFV8hR+3k0gIIE5+v9U3qX89wPWT3GnZlJXydXKZ1DdjrvF5ybD4EW5RZO6s8
	 R+su4Op1cUcCjXcEoz6gOVXfOaPnf//wk2S5tJQPGt+KIm+7NDtMKPLUoHTrUvnUXnZzb
	 6mr6UFB6jFHRxT3FsKy/df4sQOIIqu9vJqIx/gVxVbV5YnyYWCE5S5I1UXU9Z/igSilFg
	 htGqtze9K1RrSRGpDFm984xvZdH4AsJQ+5wGhSKqVFQ2fUeZkwaBCMNW+IYA2kPNAWg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795514197;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=GQRDSWIdvCU7K0iAmCaWO5zOK+B4rmsI18uUwQpN5Bg=;
	b=G68RddGWpRkdhmYkIRAiyXOGmIgD1bKqAnPdbqC1VZcr5OVXVXRpy+j0rhTQJht+A7kI
	 VA6j73uoTazLDdWH96nEZ/JJksLfE7PFQV+y3142yXAAYd4VT88cw9twlwtRk0CU5EP5Z
	 JY6LMwo0C35RISq6kk11J75XozdWQUSLH2EKCqK+p1ggHz0dr/5XMeHLepc98LA4dGkOX
	 6xz//2WciqCfMUfN34jveEkanP02J+OIpjR0rkPEO5erJxfcbVhleAgzayfyb89r1QAvr
	 Kf9YFbMX9192qI5E9EUq1KTQx6zAHfcNKkQzmVH5c82GKNwn931bVS/ruttcjcsQ1Tg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795514197;
	bh=GQRDSWIdvCU7K0iAmCaWO5zOK+B4rmsI18uUwQpN5Bg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=olI32TsKxc4nWN7Zr+2luRRwFLhNSVGB6nW99FFnxjqWLuRjdVSgiHU8vTxIcCqyj
	 G5GFRsfz+J/4aPxbnrorRU9AoWhoQusflM2c+ftaFUWam7G/17SNWXG3xIr0I2HdI8
	 qPKn0zTN5LyLOQNs1pU7U9j7cwFu9ERzGAXJ47/yD6q82HeaLKcbAmQmBvjqBUmqq7
	 e2KMN+Cc2pJaHx60+93vgYegAkeHAooNeVDxx0tASQnYfCdtTmQVpsQ/4YEPx5Qpv4
	 A3opMS6JIJcMIu4ZFKAmZXjs4mT5jAMtWUjRSLbLdSkEfK69qXgcVVG7RNGytVxeXB
	 YqJvhgaIGEeqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1DFF44066F;
	Tue, 24 Nov 2026 09:56:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id F22EA1C9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 09:56:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D7ADF80F52
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 09:56:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WetY6nejoKlF for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Nov 2026 09:56:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EE50A80F4F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=AVPs0/VE
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EE50A80F4F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 09:56:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CDF3E419F0;
 Tue, 24 Nov 2026 09:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562E21F000EC;
 Tue, 24 Nov 2026 09:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795514192;
 bh=GQRDSWIdvCU7K0iAmCaWO5zOK+B4rmsI18uUwQpN5Bg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AVPs0/VEeI8sxVb0+M5n8qLkPqpraY7rzw2qsG3npj7PLVNKYNB3Z0xUurBWYc1MK
 m3LGkic7Fuck9/posmorOYATL+RYuJCdUemux6wN3YD65D15CqLr2iO4Ii6WHCEuKl
 oz4ZXl+GwaHkvG2M1y1U1DUOZapCLq0S3sI7tCamJ2klfg/W2pd91tGrbo+Mo+OJEC
 FFynnZ/4Fkcx4dYfzFP8E0fkWGqYcZ+XSNlNSQ4mI5O0pwiOCZmHvKd0N1As/aYVmf
 bGB4kZDb+wOWNz4MvWPtJ7dLZ7iyT3+dYn4cTvpe0Xh92Gf3CHcSt7nrgDvWZGY/J3
 qKuANg4hjeKqQ==
Message-ID: <sashiko-outbox-230897@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-net 4/5] igc: let dev_watchdog reset the adapter
 after a Tx hang
To: "Steffen Dirkwinkel" <lists@steffen.cc>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261123-e1000e-tx-hang-v1-4-ecb4309942f1@beckhoff.com>
References: <20261123-e1000e-tx-hang-v1-0-ecb4309942f1@beckhoff.com>
 <20261123-e1000e-tx-hang-v1-4-ecb4309942f1@beckhoff.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 09:56:31 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] igc: permanent Tx queue deadlock in igc_clean_tx_irq() [1]
--

commit c5dcfb32c435e778dcb0ad6b827b371a99667e5b
Author: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

igc: let dev_watchdog reset the adapter after a Tx hang

This commit checks whether a Tx subqueue is already stopped before
stopping it upon detecting a Tx unit hang in igc_clean_tx_irq(), so
repeated hang reports do not keep resetting trans_start and preventing
dev_watchdog() from resetting the adapter.

> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethe=
rnet/intel/igc/igc_main.c
> index 1fb5f3cbe93c5..a2d383f79a29d 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -3281,8 +3281,15 @@ static bool igc_clean_tx_irq(struct igc_q_vector *=
q_vector, int napi_budget)
>  				   tx_buffer->next_to_watch,
>  				   jiffies,
>  				   tx_buffer->next_to_watch->wb.status);
> -			netif_stop_subqueue(tx_ring->netdev,
> -					    tx_ring->queue_index);
> +			/* The hang is reported again on every watchdog run,
> +			 * but stop the queue only once: stopping it again
> +			 * would also restart the Tx timeout, so dev_watchdog()
> +			 * would never reset the adapter.
> +			 */
> +			if (!__netif_subqueue_stopped(tx_ring->netdev,
> +						      tx_ring->queue_index))
> +				netif_stop_subqueue(tx_ring->netdev,
> +						    tx_ring->queue_index);
> =20
>  			/* we are about to reset, no point in enabling stuff */
>  			return true;

[Severity: High]
This problem wasn't introduced by this patch, but can a stopped Tx
subqueue remain permanently stalled in igc_clean_tx_irq() [1] when
CONFIG_MAX_SKB_FRAGS is large (such as 45 for BIG TCP) and the ring is
sized to IGC_MIN_TXD (64)?

A couple of lines below this hunk, igc_clean_tx_irq() only wakes a stopped
subqueue when igc_desc_unused(tx_ring) reaches TX_WAKE_THRESHOLD:

drivers/net/ethernet/intel/igc/igc_main.c:igc_clean_tx_irq() {
	...
#define TX_WAKE_THRESHOLD (DESC_NEEDED * 2)
	if (unlikely(total_packets &&
		     netif_carrier_ok(tx_ring->netdev) &&
		     igc_desc_unused(tx_ring) >=3D TX_WAKE_THRESHOLD)) {
	...
}

Because DESC_NEEDED is (MAX_SKB_FRAGS + 4), CONFIG_MAX_SKB_FRAGS=3D45 makes
TX_WAKE_THRESHOLD 98, while igc_desc_unused() on a 64-descriptor ring is at
most 63.  Once igc_maybe_stop_tx() stops the queue, the wake condition can
never be satisfied and the queue stays stopped until a Tx watchdog timeout.

[1] https://sashiko.dev/#/bug/linux-8616c413-3d5c-4d57-9eda-b2849ebf6eb4

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-e1000e-tx-=
hang-v1-0-ecb4309942f1@beckhoff.com?part=3D4
