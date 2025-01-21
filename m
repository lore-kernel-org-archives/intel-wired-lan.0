Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27CF2C02181
	for <intel-wired-lan@archiver.kernel.org>; Tue, 21 Jan 2025 00:59:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B3824846C7;
	Tue, 21 Jan 2025 00:59:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id han0FxyFVjpq; Tue, 21 Jan 2025 00:59:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B4241846D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1737421174;
	bh=SScBCv7di7VBCbCD7xsICWRTW0HGOEZZPkqj90mVTxM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jMuyyMbBcwn/+i03IS8X42PRxmyduVjjnFvWf+bEDBNCo8m77DE/nW2uQTkwWKq0P
	 SBnVCNq1kAqGoo7E9FDhCdZNhZzIG07L8T+qJ5z5G/zG2kUycSbRoiOU86Szti9L7o
	 Hqmmc56cu8+UjaUJPm67Naidd+/0RMtShY0qzsbXKipF/fTwYjCEqCpIaDYiN0DFRa
	 RozucGFybJJQkd7k8faBlvJ38IVIHQV8qSFynJENYRfeynu4YajGJ85ODU3lAJCzET
	 5q80fZfdV3G09QfiXhHU2lRiD8mLsJ/pfQYRdckFSZv+3eKopn3FkQIDSz3UnZDqbr
	 kdCBhi9UxGpJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B4241846D1;
	Tue, 21 Jan 2025 00:59:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B12769
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Jan 2025 00:59:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5EB26413D8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Jan 2025 00:59:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5rNq9ShvoNq6 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 21 Jan 2025 00:59:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 762954053E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 762954053E
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 762954053E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Jan 2025 00:59:31 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id E4437A40948;
 Tue, 21 Jan 2025 00:57:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08AC4C4CEDD;
 Tue, 21 Jan 2025 00:59:27 +0000 (UTC)
Date: Mon, 20 Jan 2025 16:59:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 andrew+netdev@lunn.ch, edumazet@google.com, horms@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, michael.chan@broadcom.com,
 tariqt@nvidia.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, jdamato@fastly.com, shayd@nvidia.com,
 akpm@linux-foundation.org, shayagr@amazon.com,
 kalesh-anakkur.purayil@broadcom.com, David Arinzon <darinzon@amazon.com>
Message-ID: <20250120165927.45ef723b@kernel.org>
In-Reply-To: <20250118003335.155379-2-ahmed.zaki@intel.com>
References: <20250118003335.155379-1-ahmed.zaki@intel.com>
 <20250118003335.155379-2-ahmed.zaki@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1737421168;
 bh=fHXdg3iX4bq6wqIRVxcNQ1V8bivng2odeQZXh0DSpVA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=NdB95HXAxJ/Dxh74nUQrsFABf0K//3z4v/pG1ulbPWEEihXMYacST1+ukIOVUF7UU
 SL9UMDUliXCbp2/bnZyhsh6j0wphlcHlKebtbMYuiSrwwM2IUmNRsm3Zqwy/LsjnzH
 A1nUtmDKR29FbMJQJ8kLkCCBTQQi3Kw6hIbCACoErP+RWbgdTospFOQit31enjSpfx
 BN43XSmKwT1Gl/bT1DGl7T+f0GVuyjSYsr0zWipimYlSXRRZvU4WW0CaML0rOgJ8tH
 lSODmCaaZLyQJxYiPKS3N+gyzPte7jSu1c7IFIzjZ4eJPCjtTvF/qL+H554x/b5IKz
 bEha5FZSyOztg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=NdB95HXA
Subject: Re: [Intel-wired-lan] [PATCH net-next v6 1/5] net: move ARFS rmap
 management to core
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

On Fri, 17 Jan 2025 17:33:31 -0700 Ahmed Zaki wrote:
> +#ifdef CONFIG_RFS_ACCEL
> +static void
> +netif_irq_cpu_rmap_notify(struct irq_affinity_notify *notify,
> +			  const cpumask_t *mask)
> +{
> +	struct napi_struct *napi =
> +		container_of(notify, struct napi_struct, notify);
> +	struct cpu_rmap *rmap = napi->dev->rx_cpu_rmap;
> +	int err;
> +
> +	if (napi->dev->rx_cpu_rmap_auto) {

Can this ever not be true?

> +		err = cpu_rmap_update(rmap, napi->napi_rmap_idx, mask);
> +		if (err)
> +			pr_warn("%s: RMAP update failed (%d)\n",
> +				__func__, err);

netdev_warn(napi->dev, "...) ?

> +	}
> +}
> +
> +static void netif_napi_affinity_release(struct kref *ref)
> +{
> +	struct napi_struct *napi =
> +		container_of(ref, struct napi_struct, notify.kref);
> +	struct cpu_rmap *rmap = napi->dev->rx_cpu_rmap;
> +
> +	if (!napi->dev->rx_cpu_rmap_auto)

Similar question, can it possibly be false without driver bugs?
I think you disable rmap completely if we can't add a single IRQ,
that may be too drastic. Better miss one IRQ than the whole rmap, no?

> +		return;
> +	rmap->obj[napi->napi_rmap_idx] = NULL;
> +	napi->napi_rmap_idx = -1;

Why do we modify NAPI here? Shouldn't caller be responsible for this?

> +	cpu_rmap_put(rmap);
> +}
> +
> +static int napi_irq_cpu_rmap_add(struct napi_struct *napi, int irq)
> +{
> +	struct cpu_rmap *rmap = napi->dev->rx_cpu_rmap;
> +	int rc;
> +
> +	if (!rmap)

Should never happen, I'd ignore this and let the kernel crash below.

> +		return -EINVAL;
> +
> +	napi->notify.notify = netif_irq_cpu_rmap_notify;
> +	napi->notify.release = netif_napi_affinity_release;
> +	cpu_rmap_get(rmap);
> +	rc = cpu_rmap_add(rmap, napi);
> +	if (rc < 0)
> +		goto err_add;
> +
> +	napi->napi_rmap_idx = rc;
> +	rc = irq_set_affinity_notifier(irq, &napi->notify);
> +	if (rc)
> +		goto err_set;
> +
> +	return 0;
> +
> +err_set:
> +	rmap->obj[napi->napi_rmap_idx] = NULL;
> +	napi->napi_rmap_idx = -1;
> +err_add:
> +	cpu_rmap_put(rmap);
> +	return rc;
> +}
