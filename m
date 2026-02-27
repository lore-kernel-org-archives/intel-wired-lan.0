Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D4DEFD9E34
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Feb 2026 03:56:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F224940891;
	Fri, 27 Feb 2026 03:56:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v8EE_CSDJ1qp; Fri, 27 Feb 2026 03:56:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3070E408B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1772164592;
	bh=83vVmI6WajyemfBC8ylgcUzTp693lMCXzu6ONB+xpd8=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=AzN2hXLv40rLmAf1QZyiP6KnG7ZjOyamD/xyoQS5oGGUjna7q6QDwKqFen0xPSir/
	 2lfHgIImmuSgvg/tDd9LtrYAob0TaexuwtamOjAnRsOGhAJ6kpwSXcS/PPyJn7OuF6
	 vFLJ2cod9CczKyVrhobBHoGm3fNf02qIdBNBujKcZHSFJd9mzWqu4JALkSMutbaei7
	 pWRyRXWmLkkuoxE5VBQqVGiIyAMvO/7wSQyClkNFQn9zaZBztonpSQLfbejNEqfjvs
	 ZMPa/qwAV0SjRISlbwvE1kmfOzDVMBe5LiJW5ounIVuPdnW/3gJDgF0iZp+07ixBCQ
	 KfebpJheQmr9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3070E408B2;
	Fri, 27 Feb 2026 03:56:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id EE4CD204
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Feb 2026 03:56:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D438B607B8
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Feb 2026 03:56:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XgGfWBcX4dWg for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Feb 2026 03:56:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E33046075E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E33046075E
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E33046075E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Feb 2026 03:56:29 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 234A3600AD;
 Fri, 27 Feb 2026 03:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A928C116C6;
 Fri, 27 Feb 2026 03:56:26 +0000 (UTC)
From: Jakub Kicinski <kuba@kernel.org>
To: anthony.l.nguyen@intel.com
Date: Thu, 26 Feb 2026 19:56:25 -0800
Message-ID: <20260227035625.2632753-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225211546.1949260-3-anthony.l.nguyen@intel.com>
References: <20260225211546.1949260-3-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1772164587;
 bh=z5xjxIuCEpexUDITWJ0ilvcIxUSMlU5ufgnavoF6tA0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nJk1ta4ASdK91McYHdy5oBfPe9radvFqWvayT8OODWfwrt9QgxRP0NcGE8mKFP0OK
 5DpKFIIDVaYYx3CIXX7ko3X6nD11zA66J09yrufa+G1vETQuMzoC7hSeDM7hhxvgpf
 S+Jbec0bFt3uOT1XVJqEbHoV1G9L/SGEa4KV9hS62VLK+NO39ixsViQVXC+eftNLeX
 gQ/kuzGvptBEEsG8BRmva3yZaExaaC3IsvCkb9tJOtbkG+wt6hnZiQiPAOsX3m7BTH
 Qp1ngEDRNpQzgkoxV3xVXdTXtq/eWqU/SUFruliEGlnWkWsyKppBZygxfBqsB4IYdd
 SW4ztcJJpjzAA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=nJk1ta4A
Subject: Re: [Intel-wired-lan] [net, v2,
 02/12] idpf: skip deallocating bufq_sets from rx_qgrp if it is NULL
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
Cc: piotr.kwapulinski@intel.com, brett.creeley@amd.com,
 emil.s.tantilov@intel.com, sx.rinitha@intel.com, brianvv@google.com,
 edumazet@google.com, boolli@google.com, decot@google.com,
 avigailx.dahan@intel.com, joe@dama.to, przemyslaw.kitszel@intel.com,
 Samuel.salin@intel.com, jedrzej.jagielski@intel.com,
 aleksandr.loktionov@intel.com, intel-wired-lan@lists.osuosl.org,
 aaron.ma@canonical.com, david.m.ertman@intel.com, pabeni@redhat.com,
 pmenzel@molgen.mpg.de, jacob.e.keller@intel.com,
 Jakub Kicinski <kuba@kernel.org>, sreedevi.joshi@intel.com, willemb@google.com,
 netdev@vger.kernel.org, joshua.a.hay@intel.com, stable@vger.kernel.org,
 rafal.romanowski@intel.com, andrew+netdev@lunn.ch, tglx@kernel.org,
 horms@kernel.org, sridhar.samudrala@intel.com, vitaly.lifshits@intel.com,
 dima.ruinskiy@intel.com, davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
idpf: skip deallocating bufq_sets from rx_qgrp if it is NULL

This patch adds a NULL check for rx_qgrp->splitq.bufq_sets to prevent
kernel panic when idpf_rxq_group_alloc() fails during initialization and
the error path calls idpf_rxq_sw_queue_rel(). The panic was occurring
during device opening when adding to a bonding interface.

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index 761a77510467..59aafadae3d0 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -1341,6 +1341,9 @@ static void idpf_txq_group_rel(struct idpf_q_vec_rsrc *rsrc)
>   */
>  static void idpf_rxq_sw_queue_rel(struct idpf_rxq_group *rx_qgrp)
>  {
> +	if (!rx_qgrp->splitq.bufq_sets)
> +		return;
> +
>  	for (unsigned int i = 0; i < rx_qgrp->splitq.num_bufq_sets; i++) {
>  		struct idpf_bufq_set *bufq_set = &rx_qgrp->splitq.bufq_sets[i];
>
>  		for (unsigned int j = 0; j < bufq_set->num_refillqs; j++) {
>  			kfree(bufq_set->refillqs[j].ring);
>  			bufq_set->refillqs[j].ring = NULL;
                           ^^^^^^
This patch adds a NULL check for bufq_sets, but does the same issue
exist for refillqs?

Looking at idpf_rxq_group_alloc() in the same file, it first sets
bufq_set->num_refillqs to a non-zero value, then attempts to allocate
refillqs:

idpf_rxq_group_alloc() {
    ...
    bufq_set->num_refillqs = num_rxq;
    bufq_set->refillqs = kcalloc(bufq_set->num_refillqs,
                                  sizeof(struct idpf_sw_queue),
                                  GFP_KERNEL);
    if (!bufq_set->refillqs) {
        err = -ENOMEM;
        goto err_alloc;
    }
    ...
}

If this allocation fails, bufq_set->refillqs is NULL but
bufq_set->num_refillqs is non-zero. The error path calls
idpf_rxq_sw_queue_rel() which now passes the bufq_sets check but then
dereferences bufq_set->refillqs[j].ring in the inner loop.

The inner loop condition (j < bufq_set->num_refillqs) would be true,
causing the same NULL pointer dereference the patch is meant to prevent.

Would this need a similar check before the inner loop, similar to the
bufq_sets check added in this patch?
