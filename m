Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1245D606A884
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Nov 2026 11:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=YKSLH9D8;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=odhwX6PN
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D5ACC40763;
	Tue, 17 Nov 2026 11:18:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Na1P_ttxA5ix; Tue, 17 Nov 2026 11:18:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BD70A40742
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794914317;
	b=iZWqTr3hvl3mZGgHm5N6h/FVuFNGNSwRjMCSdWqjwLEO9IrdS50cVpvgpxaXrp9e9Rvd
	 VjYDbBlSF9FmjG4wSQHZg4c5WZFGjBtU8xdL6/ILgynJ0I2Qs6aOymCsDCZA92E8tngtR
	 JJV7XEgAZiAePQvYNdL0C+O+7gViDK3hYRYM3JzdabWBanWGqjJTPpCDrir3OVTg+aGIX
	 GY2MSNPd33mv/wKxxomeHumMdBiC+RVSB8sdINC58It7877oDqZfDtMOTLgo2TPp+CEun
	 l5ilfd6t39YW77Y3I2M/PgfaMyEwbZ6EeiID9U+lEWZeVqkILF7yZJDACjvwM2+naUQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794914317;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=k+kIo9jpV5KFdYWHjuEUw/DWKQDI9aOHBv+v3db2R3c=;
	b=EHLdwcy0Ehqqk0UUrrx+xLlCPk1gAOe6N/S3r0k6uvikvkkqz/mvGHAQw8gyWFo4nMNa
	 2nZ2alOlfQCr4iJ1K0dObOZOv+aU60AirG0owX8S/hdNODT+xMtKPa3za3zub8ipjjw8s
	 MAOQrjnHJuFpKs84dLQh9msjlrdW6VInir+4f2equZUjN2L578SySdD67SEVZd/QI1fUw
	 DI6VEQEc53EIkbzeWBgqm1ts7NIwKx6RP8YSrXBO63Pvf5tDqQUU1YyTli5WtAOMT0IjN
	 3s0d+i36WN2LwHw6o9cy/+Z4hOMRDliBJChJoHECFlt7Y7zh7Fjf3Pe+qfV9TZy3jfg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794914317;
	bh=k+kIo9jpV5KFdYWHjuEUw/DWKQDI9aOHBv+v3db2R3c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YKSLH9D8KuDVDEcf8TUjoHcpPoOXdcZU5y4vwIfIYVRFdu1NAfkoaA2hhUAxmHCVV
	 Y4uoaX6U6mAGEmXDGiOqaaOEAhJ3l5YvdQ6eOZpKtkEHpl6HSISkhSgBPphAiPwLoi
	 shnSSENsDj3xhja99gwupg3dzDKD/IaXyrLm32fKHRjBPYhbCz6G+dI+M3fndgweuS
	 ZVgbETXD+0Vi7BHv9AyDry1EsyHCZnyQw0QxE9nwJyAInk08jl4n4FypBVXDGo80qr
	 9igRrqPBojqKNSboga/D2YEbiN7R0AOeNc1NT70LhL9J8zFxeoGQCOEAPCLx8shrK6
	 gOyipuDicBdqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD70A40742;
	Tue, 17 Nov 2026 11:18:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 87F9E70B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 11:18:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 715B14030C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 11:18:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0gpmeqG94fhf for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Nov 2026 11:18:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3AC5940308
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=netdev-bot+sashiko@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=odhwX6PN
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3AC5940308
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 11:18:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 30AF460DB6;
 Tue, 17 Nov 2026 11:18:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329991F000C8;
 Tue, 17 Nov 2026 11:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794914312;
 bh=k+kIo9jpV5KFdYWHjuEUw/DWKQDI9aOHBv+v3db2R3c=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=odhwX6PNDqnSOGmkajWFLLggKYsk1XXV6+pRNcyjje7CTi+d5WH1/dkHak2sQPRz8
 Z1cKs/ThKki9H1NyHKgq896L5QtXa5usT6J0ZlEGol0oth06EudyYAw3h5M8qcjLc4
 16hk4ejhvuC8sHMYO+OfRsqbrDyL3/8nyfTIuGEjHq2WhSa7J9Gr/ktRxBR6f9quW6
 nBl1xbeZNr0opqe1pM5Ai8pU6CWOMZ8HiMfteoQtFLaNbSL855YdnzxLjWD+Kx/Iy8
 03l0KGv61my8wT0O+2P7Kad7DDNBbzkgcQKtoIeQsrmT6l3mKXWCdQ1LkvmD//fCkU
 33PHvxZW65N1g==
Subject: Re: [PATCH net 1/3] igb: fix RTNL assertion when resuming from
 runtime suspend
From: netdev-bot+sashiko@kernel.org
To: antonio@mandelbit.com
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 zheng.z.yan@intel.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Tue, 17 Nov 2026 11:18:31 +0000
Message-ID: <179491431170.3136.416423016654830307@kernel.org>
In-Reply-To: <20261113105835.3821433-1-antonio@mandelbit.com>
References: <20261113105835.3821433-1-antonio@mandelbit.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Commit "igb: fix RTNL assertion when resuming from runtime
  suspend" moves netif_set_real_num_queues() out of __igb_open() and…
- [High] The commit message says "The queue counts only change on paths
  that re-open the device under RTNL (ethtool -L, SR-IOV…
- [Medium] Concern (baseline decision: false, resolved later in the
  series).

--

igb: fix RTNL assertion when resuming from runtime suspend

This patch moves the netif_set_real_num_{tx,rx}_queues() calls out of
__igb_open() and into igb_open(). The runtime resume path runs without
RTNL, so it no longer triggers an RTNL assertion. igb_open() now publishes
the queue counts with netif_set_real_num_queues() before it calls
__igb_open().

Closes: https://bugzilla.ipfire.org/show_bug.cgi?id=13562

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 131df3e09ba14..028cdd90522cb 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -4178,17 +4178,6 @@ static int __igb_open(struct net_device *netdev, bool resuming)
>  	if (err)
>  		goto err_req_irq;
>  
> -	/* Notify the stack of the actual queue counts. */
> -	err = netif_set_real_num_tx_queues(adapter->netdev,
> -					   adapter->num_tx_queues);
> -	if (err)
> -		goto err_set_queues;
> -
> -	err = netif_set_real_num_rx_queues(adapter->netdev,
> -					   adapter->num_rx_queues);
> -	if (err)
> -		goto err_set_queues;
> -

[Severity: High]
The commit message says:

  The queue counts only change on paths that re-open the device under
  RTNL (ethtool -L, SR-IOV reconfiguration)

Does that hold for suspend and resume? Every suspend goes through
__igb_shutdown(), which calls igb_clear_interrupt_scheme(). That frees
the rings and sets num_tx_queues and num_rx_queues to zero in
igb_free_q_vectors().

On resume, __igb_resume() rebuilds them:

__igb_resume()
    igb_init_interrupt_scheme(adapter, true)
        igb_set_interrupt_capability()
            pci_enable_msix_range() fails
            msi_only:
                adapter->num_rx_queues = 1;
                adapter->num_tx_queues = 1;
                adapter->num_q_vectors = 1;
    __igb_open(netdev, true)

Before this patch, __igb_open(netdev, true) updated
dev->real_num_{tx,rx}_queues after that. Now only igb_open() does, and the
resume path never calls igb_open(). The same is true when the MSI-X to MSI
fallback in igb_request_irq() runs inside __igb_open(netdev, true).

In that case, can the stack keep a larger real_num_tx_queues while only
tx_ring[0] exists? igb_tx_queue_mapping() folds the stale indices onto
ring 0:

	if (r_idx >= adapter->num_tx_queues)
		r_idx = r_idx % adapter->num_tx_queues;

Each stack txq has its own _xmit_lock. Couldn't several CPUs then run
igb_xmit_frame_ring() on tx_ring[0] at the same time, racing on
next_to_use, tx_buffer_info[], the tail write and the BQL state of txq 0?

__igb_maybe_stop_tx() and igb_clean_tx_irq() also only stop and wake
subqueue 0. real_num_rx_queues would likewise stay larger than the single
configured RX ring.

Runtime resume happens on every link-up after a cable unplug, and each
cycle releases and re-acquires MSI-X, so this can happen more than once.

On system resume (rpm == false), __igb_resume() already holds RTNL around
__igb_open(). Did that path need to lose the update to fix the assertion?

[Severity: Medium]
Will runtime resume still hit an RTNL assertion with this patch applied?
Later in __igb_open(), igb_set_queue_napi() is still called
unconditionally:

	for (i = 0; i < adapter->num_q_vectors; i++) {
		napi = &adapter->q_vector[i]->napi;
		napi_enable(napi);
		igb_set_queue_napi(adapter, i, napi);
	}

igb_set_queue_napi() calls netif_queue_set_napi(), and that calls
netdev_assert_locked_ops_compat_or_invisible(). For igb, that check is
ASSERT_RTNL(). __igb_resume() only takes rtnl_lock() when !rpm, so this
chain runs without RTNL:

igb_runtime_resume()
    __igb_resume(dev, true)
        __igb_open(netdev, true)
            igb_set_queue_napi()
                netif_queue_set_napi()
                    ASSERT_RTNL()

It also updates the queue napi pointers without RTNL.

The next patch in the series, "igb: link queues to NAPIs under RTNL after
runtime resume", fixes this. It calls igb_set_queue_napi() only when
!resuming, and links the NAPIs under RTNL from a new igb_queue_napi_task
work item. So the problem is gone by the end of the series. With only this
commit applied, though, the "RTNL: assertion failed" warning from the
commit message still looks reachable on runtime resume.

[ ... ]

> @@ -4241,6 +4228,17 @@ static int __igb_open(struct net_device *netdev, bool resuming)
>  
>  int igb_open(struct net_device *netdev)
>  {
> +	struct igb_adapter *adapter = netdev_priv(netdev);
> +	int err;
> +
> +	/* Notify the stack of the actual queue counts. */
> +	err = netif_set_real_num_queues(netdev, adapter->num_tx_queues,
> +					adapter->num_rx_queues);

[Severity: High]
Can the queue counts still change after this call? __igb_open() calls
igb_request_irq(). If igb_request_msix() fails, it falls back to MSI and
rebuilds the interrupt scheme:

drivers/net/ethernet/intel/igb/igb_main.c:igb_request_irq() {
    ...
		/* fall back to MSI */
		igb_free_all_tx_resources(adapter);
		igb_free_all_rx_resources(adapter);

		igb_clear_interrupt_scheme(adapter);
		err = igb_init_interrupt_scheme(adapter, false);
    ...
}

When msix is false, igb_set_interrupt_capability() takes the msi_only path.
That sets num_tx_queues, num_rx_queues and num_q_vectors to 1.

Before this patch, the netif_set_real_num_{tx,rx}_queues() calls ran after
igb_request_irq() and saw the reduced count. Now dev->real_num_tx_queues
keeps the value set here (for example 4 or 8), while only tx_ring[0]
exists.

Would igb_tx_queue_mapping() then fold txq 1..N-1 onto tx_ring[0]? Each of
those stack txqs takes a different _xmit_lock, so igb_xmit_frame_ring()
could run concurrently on the same ring. real_num_rx_queues would also
stay larger than the single configured RX ring.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113105835.3821433-1-antonio%40mandelbit.com
