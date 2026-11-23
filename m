Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D12606A31E
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=6JdDmQ77;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CJELoYmX
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E60C7605CF;
	Mon, 23 Nov 2026 14:27:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rWe2umhHwjC4; Mon, 23 Nov 2026 14:27:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DA1EC605FF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795444040;
	b=qL1ujHGJq8b0u1FALGGv2VYFOHBVoHDVIjicU0VhGxYhfvbHAlskzhX9QVeLReVTBuIk
	 G4gTA5H4TjsBA3EnoyL1UGrpMNms0HUjCf/qj1uwUQ5XuMLfuuGkWCQeuctXIt41BEzfF
	 apaEBRDkPtgXKPcyNoc6wn978W/OpacBIuo47PMMJeyIT73h3Z0IkDee1hhBz9zEEHTC9
	 W3x2gJuPspgBXUAgvzatIeC0qN40tOzrW8EQKM2m41HVol3ztKxkUBb6JJlSkbGau1JbU
	 V09336i2aBViEZcEPScCcLm8b2AbKAu4FWpBEXo0S+FvK3oIptkP/lDY0QT/rqu1lhA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795444040;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=KHB/XI4cKY1r8Bk1cluPtbj8UheyxZWHTnaL5PnDwJ0=;
	b=hNn8yVKqQM3kY2/y07UgAvo5F2ojX9bcB6fEIgVL4aidzwvUYreHwVvNEAL/UpiXUGXr
	 3QOciDBP1Iz4LQcRUFP6oKr+Mb/jVsmp5WT5a/tgE3NvrXA/XGtOmAISOAB3+3nbSYdF/
	 fXA/YkViPmYvq2xJA0n4O6Y0QZejX82W1NPEijgiZRPVF/ig40h/XO9hmbEyNJRZrZt6T
	 hCL6LxEegFoTbiaYGMCddFJ/mEyY+EkwKa41vnTPW2Nzwpc+avOsJYv7spY2VrvOsJXUj
	 mJt2UR4edZcfTUY6oiD1nnvBzIovJranloLsR0h0QUrBBJwoh+i7s02cEc5ShYPT5pA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795444040;
	bh=KHB/XI4cKY1r8Bk1cluPtbj8UheyxZWHTnaL5PnDwJ0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=6JdDmQ77Kj3BEtkg24g2iMF5Qr8aL7uUS66qea/cuaVuLty8jJiJsb99i3SCjw8Xs
	 LxZ6q/rGP0k9kcgDNOwzA4RX+oBM9jOb+Shrt47VGawmgECVYt4eCxwCEeeVtJiGOb
	 HFWHTL7bfdh9wpaMAVwnNJ/i6J4QwdZ0toTpflRpuQcJvpehqgWMPif8DsyC2oDQkf
	 p/8TZuMTcGm6yqNz0YiqSiVTVgimAhz6sE25LcR5tnNm6sd7dftbVoIBgsCpPCWFCI
	 0nloGZm7v8EV7jxpGufEJwheoA+LpbxcAg/v+zhbQV3XkFOEcp4ahO38lgwoiBJb74
	 lJTbnRSjUCVtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA1EC605FF;
	Mon, 23 Nov 2026 14:27:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 417E9260
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 14:27:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3336840682
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 14:27:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eApqCTlKDnmU for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 14:27:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E9A7C405BF
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=netdev-bot+sashiko@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=CJELoYmX
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E9A7C405BF
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 14:27:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 96AFA61E02;
 Mon, 23 Nov 2026 14:27:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29D91F000C6;
 Mon, 23 Nov 2026 14:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795444035;
 bh=KHB/XI4cKY1r8Bk1cluPtbj8UheyxZWHTnaL5PnDwJ0=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=CJELoYmX/EDhq0BWS8Gj5oaSsjEeUFBwlcdk4dUw3JvbNG0GjW48yGzHkXMi7QdH5
 kIj2Q4irawJdO/wOls7zTG2BOXO3I6ZDxrvERilOJ/g0tofdr42tQIXt4DF9tviNf5
 BUywKElXkp22vw3BhFrWLFVZ/+WeROQ0tpt0iR/fGvJsWcAWQDTtmt4qp6MEwf6sCX
 uzfFJj4A+cp5DUjpcTDC7Sa+oCvnu3yVIxlb925PJR6VwwFC2MlQoHaP9rpTfkGb0R
 VT2pfoWu08nRUPcMo3TG+RzCAXmB7X5PAsOYdV/h4jOzvA22rtrDt2d3HQEEi+XsvB
 D2t7yKP7R9bBg==
Subject: Re: [PATCH net v3 1/4] igb: don't disable rings that don't exist when
 disabling an XSK pool
From: netdev-bot+sashiko@kernel.org
To: antonio@mandelbit.com
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 janislacis06@gmail.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
 john.fastabend@gmail.com, sdf@fomichev.me, sriram.yagnaraman@ericsson.com,
 kurt@linutronix.de, maciej.fijalkowski@intel.com, hkallweit1@gmail.com,
 joe@dama.to, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Date: Mon, 23 Nov 2026 14:27:13 +0000
Message-ID: <179544403344.3135.6737096159492443262@kernel.org>
In-Reply-To: <20261119140412.163202-2-antonio@mandelbit.com>
References: <20261119140412.163202-2-antonio@mandelbit.com>
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

Critical: 0 · High: 2 (2) · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix only covers the RX side.
- [High] The new guard `qid < adapter->num_rx_queues` in
  igb_xsk_pool_disable() is not serialized against the code that writes…
- [Low] Commit message accuracy (discarded by baseline).

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but `if_running`
  in igb_xsk_pool_disable() (and in igb_xsk_pool_enable()) uses…
- [High] This problem wasn't introduced by this patch, but the error
  paths of igb_xsk_pool_disable() (igb_xsk.c:162-165) and…

--

igb: don't disable rings that don't exist when disabling an XSK pool

The patch adds a qid < adapter->num_rx_queues bound to the if_running
condition in igb_xsk_pool_disable(). With it, the function stops
disabling and re-enabling rings the device doesn't have. The goal is to
stop a NULL ring from reaching igb_txrx_ring_disable() when the stack
knows about more queues than the device has.

Link: https://lore.kernel.org/netdev/20261116153041.3002666-2-antonio@mandelbit.com/

> xsk_get_pool_from_qid() checks the queue id against the stack's real
> queue counts, which can be higher than the number of rings the device
> has, e.g. after igb falls back from MSI-X to MSI on resume.

[Severity: Low]
This is minor. At this commit, a successful resume goes through
__igb_open(netdev, true), which re-syncs the real queue counts:

    err = netif_set_real_num_tx_queues(adapter->netdev,
                                       adapter->num_tx_queues);

The MSI-X to MSI example only leaves stale counts after the later patch
"igb: fix RTNL assertion when resuming from runtime suspend". That patch
makes __igb_resume() call __igb_open(netdev, true, !rpm), which skips the
re-sync on runtime resume until igb_rtnl_resume_task() runs.

The guard also covers the runtime-suspended-while-up state. There,
igb_free_q_vectors() has set num_rx_queues = 0 while netif_running() is
still true.

Could the commit message and the new code comment mention that
dependency, or use the runtime-suspended case as the example?

> diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
> index ce4a7b58cad2f..8ed82bb1def9a 100644
> --- a/drivers/net/ethernet/intel/igb/igb_xsk.c
> +++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
> @@ -148,7 +148,12 @@ static int igb_xsk_pool_disable(struct igb_adapter *adapter, u16 qid)
>  		return -EINVAL;
>  
>  	rx_ring = adapter->rx_ring[qid];
> -	if_running = netif_running(adapter->netdev) && igb_xdp_is_enabled(adapter);
> +	/* The stack can know more queues than the device has, e.g. after a
> +	 * fallback to fewer queues on resume: skip the rings it doesn't have.
> +	 */
> +	if_running = netif_running(adapter->netdev) &&
> +		     igb_xdp_is_enabled(adapter) &&
> +		     qid < adapter->num_rx_queues;

[Severity: High]
Is checking only num_rx_queues enough here? igb_txrx_ring_disable() and
igb_txrx_ring_enable() also use the TX ring:

    struct igb_ring *tx_ring = adapter->tx_ring[qid];
    ...
    set_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags);

igb can run with fewer TX rings than RX rings. From
igb_set_interrupt_capability():

    adapter->num_rx_queues = adapter->rss_queues;
    if (adapter->vfs_allocated_count)
        adapter->num_tx_queues = 1;
    else
        adapter->num_tx_queues = adapter->rss_queues;

igb_get_max_rss_queues() allows 2 RSS queues on an 82576 with VFs.

Here is a possible sequence:

1. With SR-IOV off (e.g. 4 queues), bind a zero-copy AF_XDP socket to
   qid 1. igb_xsk_pool_enable() accepts it.

2. Write to sriov_numvfs:
   igb_pci_sriov_configure()->igb_enable_sriov()->igb_sriov_reinit().
   igb_clear_interrupt_scheme() sets tx_ring[1] to NULL, and
   igb_init_interrupt_scheme() allocates rx_ring[0..1] but only
   tx_ring[0]. The pool registered at qid 1 stays in place.

3. Close the socket:
   xp_release_deferred()->xp_disable_drv_zc()->ndo_bpf()->
   igb_xsk_pool_disable(adapter, 1).
   xsk_get_pool_from_qid() returns the pool because
   1 < real_num_rx_queues. The new guard passes because
   1 < num_rx_queues. igb_txrx_ring_disable() then calls set_bit() on
   NULL->flags with rtnl held.

The commit message says this matches "as igb_xsk_pool_enable() and
igb_xsk_wakeup() already check". However, igb_xsk_wakeup() bounds qid
by the TX count:

    if (qid >= adapter->num_tx_queues)
        return -EINVAL;

igb_xsk_pool_enable() also checks real_num_tx_queues. Should this guard
require qid < adapter->num_tx_queues as well, or NULL-check both ring
pointers? No later patch in the series touches igb_xsk_pool_disable().

[Severity: High]
Is this check serialized against the resume path that writes
num_rx_queues and the ring arrays?

igb_xsk_pool_disable() holds only rtnl. __igb_resume() calls
igb_init_interrupt_scheme() without rtnl on runtime resume, and before
rtnl_lock() on system resume. Inside it, igb_set_interrupt_capability()
publishes num_rx_queues = rss_queues before igb_alloc_q_vector() fills
tx_ring[] and rx_ring[].

When the device is runtime-suspended with the interface up,
igb_free_q_vectors() has set num_rx_queues = 0 and the rings are NULL,
but netif_running() is still true. Runtime resume can start
asynchronously, for example from a PME on link-up:

CPU0 (XSK release, rtnl held)
igb_xsk_pool_disable()
    rx_ring = adapter->rx_ring[qid];      /* NULL */

CPU1 (runtime resume)
igb_init_interrupt_scheme()
    igb_set_interrupt_capability()
        adapter->num_rx_queues = adapter->rss_queues;

CPU0
    qid < adapter->num_rx_queues          /* now true */
    igb_txrx_ring_disable()
        tx_ring = adapter->tx_ring[qid];
        set_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags);

If the rings are still NULL, this oopses. If they were just allocated,
napi_disable() races with napi_enable() and ring setup on CPU1.
igb_realloc_rx_buffer_info() is also called later with the stale local
rx_ring, which is NULL.

Can the NULL ring this patch is meant to prevent still reach
igb_txrx_ring_disable() through this window? The missing serialization
in __igb_resume() predates this patch, and later patches in the series
keep it.

>  	if (if_running)
>  		igb_txrx_ring_disable(adapter, qid);

[Severity: High]
This isn't a bug introduced by this patch, but netif_running() plus a
queue count bound doesn't show that the NAPI is enabled. Can
igb_txrx_ring_disable() end up calling napi_disable() on a NAPI that
was never enabled, or is already disabled?

netif_napi_add() sets NAPI_STATE_SCHED and NAPI_STATE_NPSVC.
napi_disable_locked() then waits on them with no timeout:

    while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
        usleep_range(20, 200);

There are two ways to reach that state:

- In __igb_resume(), igb_init_interrupt_scheme() succeeds but
  __igb_open(netdev, true) fails before napi_enable(), for example in
  igb_setup_all_tx_resources(). __LINK_STATE_START and xdp_prog stay
  set.

- igb_xdp_setup() and igb_sriov_reinit() ignore an igb_open() failure
  after igb_close(), and igb_down() has already called napi_disable().

Closing an AF_XDP socket on such a qid then runs
xp_release_deferred()->igb_xsk_pool_disable()->igb_txrx_ring_disable()->
napi_disable(), which loops forever with rtnl held.
igb_xsk_pool_enable() uses the same condition.

Would checking __IGB_DOWN, as igb_xsk_wakeup() does, be a more reliable
indicator here?

[Severity: High]
This is a pre-existing issue, but what happens when
igb_realloc_rx_buffer_info() fails further down in
igb_xsk_pool_disable()?

    if (if_running) {
        err = igb_realloc_rx_buffer_info(rx_ring, false);
        if (err)
            return err;

        igb_txrx_ring_enable(adapter, qid);
    }

By this point igb_txrx_ring_disable() has set IGB_RING_FLAG_TX_DISABLED,
zeroed TXDCTL/RXDCTL and called napi_disable(). The error return skips
igb_txrx_ring_enable(), and rx_ring->xsk_pool and tx_ring->xsk_pool
still point to the pool.

xp_disable_drv_zc() only warns:

    if (err)
        WARN(1, "Failed to disable zero-copy!\n");

The core then clears and frees the pool, so the ring is left with a
dangling xsk_pool pointer.

Any later igb_down(), from igb_close(), reset_task or igb_xdp_setup(),
calls napi_disable() on the already-disabled NAPI and blocks forever
with rtnl held. Binding a new XSK socket to that qid hangs the same way
through igb_txrx_ring_disable().

igb_xsk_pool_enable() has the same imbalance after
igb_realloc_rx_buffer_info(rx_ring, true) fails:

    if (err) {
        xsk_pool_dma_unmap(pool, IGB_RX_DMA_ATTR);
        return err;
    }

>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261119140412.163202-1-antonio%40mandelbit.com
