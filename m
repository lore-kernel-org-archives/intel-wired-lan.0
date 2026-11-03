Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E62606BF8D
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Nov 2026 11:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=JyNadYBe;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cL7DP2F0
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A91940598;
	Tue,  3 Nov 2026 11:16:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h8el7WXKZtEH; Tue,  3 Nov 2026 11:16:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F1B82405A7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793704591;
	b=QhAKSqZSb9Z8QpMROO2snxADrVVwvzIBAzwSGEig4ZJfUUkSa88jgTrxNLaK+ZecCESs
	 NY80MF6wAWjuuYhjXbp8Mt+5fwcg4JCulVjpVk4T0+0ImfjBzVg2EXiKoOMaEtcL+SWm1
	 faGP59UrTrIFmKmuSu7Cg5/Cu2E4gPg9/7yIdhZ+xR6bZ/vF3P8yRq/0Cujo8hcQHwMOf
	 IxUV48T1fxWN0SHx9PlufzeadzWk524iI+GxwnkT8zF7ufAGzHVxND3nTr98wNiPI8Jfk
	 QuygQeDN42Q6XdHECFVPUDHF/JuQ2pd55eTVdEer0ZHtHtBkYLFtijtQ+cD/rbnZJUg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793704591;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=C2TR7Jw91Qq5XSj/O2fms0EOmgomU15DFV/Paiflvfg=;
	b=CAvT9gbBe/LafTMb5InW+FLpVl0RpNPDuoHdtWagG0ORzZzZ/8NZtDx9nPWXDCmswd3j
	 PSpllefVt7K1Y22GDa3kJpVVv6Mtv9Vyxckg320r5QG2UXub2KMqxqRske1CNJo3pFoYt
	 wMjd5ZWgeQh+EjWgERhKWEO60PbfDtKUDUSLflTHzwvRtYHGSJpNhxawIKdtn8FhfBHDb
	 CahB0iUrd2Y5SOl5fuN8Rp1/7OmnmZXxPp/uijvbr6lt4+griyl18y4P62c/zEwOMTg0L
	 Sdsu49umq6KAxEPPaySzsMd+ZvGXPWNszU4XjHQcQn063jqMKKd0oh31aAvdalsrOFA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793704591;
	bh=C2TR7Jw91Qq5XSj/O2fms0EOmgomU15DFV/Paiflvfg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JyNadYBeUxyzg3gzTll+SuF1ehuPmezYgPCvlJrv2xyf8mr1aXlYMFJK7KjIOnF5+
	 wZktqpCpN/wl5e7cv4vB1bS39dMsli2MB5NMzMf/If1ZNiep4uPAnD1LouDOCIP3BD
	 VEvIQcHlNltx4kxb0/flITWZP1mvhqrxPUmX8wFij4cQ5Q9u3tfxgbEPRdV55IqOeF
	 dIVERGttthYpCo/eSARO/5bqD2FC+dnrCYxEMElko3wmQpvlzjmEP/DQyMNVl8fqod
	 VvSwjacJhWM4ScAQav8lJacumIVjUyoI2coAD5xz9e/lcOMZ7RK5qojhaNS/NiZzwS
	 0TkyqLO96Y1yw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F1B82405A7;
	Tue,  3 Nov 2026 11:16:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 440A411CA
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 11:16:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 29A5B80DA1
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 11:16:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4LZTHmG1BUnh for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Nov 2026 11:16:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1F9E980B80
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793704586;
 b=d5s5gJpNmo4tyiJe1eoaT6MzeL7EFzz9JD81nmzTGwQ2vghLpUZl+yNgFhCCjX1yPuO1
 J5UVXqbQ84drngFTeAiXg3yoH/aLqSr9ks8KAadQRELTFCUOuWFA25oEeykDbMcDrN1Dv
 AoTyg6Ds4B+Q12/2PtXnEEsMJLD19jBlRWxJYBO0qPl7Olth3K7NE/Ou0WLwg1H6b+hkC
 D7lmVWb5pr3wk0y6B5cFPgnsOSyv066m4HvmeUoueLIDrN4lGfXewTxS6zhBmpZP8lVul
 3nVzZ2PSJWpqMspmNWylKp39LJsOlIPLWtePPTv1ypurPbtqCzOP9rAkl9Ef+M/shpA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793704586;
 h=Received-SPF:Received:Received:DKIM-Signature:Subject:From:To:Cc:
 Date:Message-ID:In-Reply-To:References:X-sashiko-severity:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 bh=C2TR7Jw91Qq5XSj/O2fms0EOmgomU15DFV/Paiflvfg=;
 b=EqCfSrlYf89x+OafKFci/ZQuyilyYyy9RNUsHuSMFbXxOX4eFI4hU0p1eWHfVeXmX78o
 0C6aJGE1zbRXX/pssGXLtpHpXbI5qFC5ZYK6zYW72W8qtaBTbqjVP+WJRMyH23HgdTeyo
 Aks30JHRCVSKaaGx9mslCmSUGrLvkHSZKKA+1ILyGUfFEwbuWpyMTwZt5jWoL2Qe+0olV
 dKX4xrtCprV8sc5v5vvtVbqtBm+0v0tqRvt+AbSU+vwpm2uwjnMvRh68q5BQFe9L1xLW/
 r626+2Uq6aUmB640xPUCZPbpBzSGf+qaQTOU0vlKMViWCZguerwvV/+c2JIi3vDdZMw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=cL7DP2F0; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=netdev-bot+sashiko@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=cL7DP2F0
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1F9E980B80
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 11:16:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 44C02601FF;
 Tue,  3 Nov 2026 11:16:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7621F000C1;
 Tue,  3 Nov 2026 11:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793704584;
 bh=C2TR7Jw91Qq5XSj/O2fms0EOmgomU15DFV/Paiflvfg=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=cL7DP2F0E3uOhkz0spmctbkp/n4c79EyHpNVyepkRcIjHfOG90056AfVm7vMwuK16
 mO55tB54q26IXxF966GdC50RQRJZeTKHDTUFPI9rHGveY88W4SG4o9cppm/ZuL0Ppc
 VAdO21lA2tI9L3b48rFbmVjtfjKKQGAcVUFlQyww8Fv92xBQGvU3Sfe8ASaunX3wXC
 qZ43a6znNSG5E+DhCMDywD87PsuG2Mi+elfN4G/E2I980WH0PlHJcufpXQ3fz4NlyE
 YtCdKiaFHrMr7AziO+44J1Pn6SleZweDSFJFJcgchi6WEDtScpltXMqzHFD7pKm0N2
 jc753bRmrf3qA==
Subject: Re: [PATCH net v4 1/2] igb: do not let XDP frames span more than one
 Rx buffer
From: netdev-bot+sashiko@kernel.org
To: tkusters@aweta.nl
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 sven.auhagen@voleatech.de, richardcochran@gmail.com, kurt@linutronix.de,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 maciej.fijalkowski@intel.com, p@1g4.org, stable@vger.kernel.org,
 piotr.kwapulinski@intel.com, aleksandr.loktionov@intel.com,
 alexander.nowlin@intel.com
Date: Tue, 03 Nov 2026 11:16:21 +0000
Message-ID: <179370458190.488856.17697539789438631896@kernel.org>
In-Reply-To: <20261102-igb-rx-ts-fix-v4-1-8785124c5d23@aweta.nl>
References: <20261102-igb-rx-ts-fix-v4-1-8785124c5d23@aweta.nl>
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
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 4 (1) · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch breaks XDP at the default MTU of 1500 on 4K-page
  systems, and can leave a program that cannot be removed.
- [High] The fix misses AF_XDP zero-copy rings.
- [High] Turning on the legacy-rx private flag while XDP is attached
  brings back multi-buffer XDP frames.
- [High] With rx-all enabled, RCTL.SBP defeats the new hardware length
  limit.
- [Medium] During XDP detach, the hardware limit can be dropped while the
  rings still run the old program.
- [Medium] Lowering the MTU gets around the new timestamp-aware check in
  igb_change_mtu(), which validates the new max_frame against the ring…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but a malicious VF
  can set arbitrary VMOLR bits for its own pool.

--

igb: do not let XDP frames span more than one Rx buffer

While XDP is attached, this patch caps the maximum receive length at
max_frame_size. The cap goes in RLPML when no VFs are allocated, and in
the PF pool's VMOLR otherwise, so the MAC drops frames that would span
several descriptors. It also adds IGB_TS_HDR_LEN to the one-buffer
checks in igb_xdp_setup() and igb_change_mtu().

Link: https://lore.kernel.org/all/20261028083344.3047350-3-p@1g4.org/

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index ce91dda00ec0e..5bf489cd7b066 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -2894,11 +2894,13 @@ static int igb_xdp_setup(struct net_device *dev, struct netdev_bpf *bpf)
>  	bool running = netif_running(dev);
>  	bool need_reset;
>  
> -	/* verify igb ring attributes are sufficient for XDP */
> +	/* verify igb ring attributes are sufficient for XDP, leaving room
> +	 * for the inline Rx timestamp header
> +	 */
>  	for (i = 0; i < adapter->num_rx_queues; i++) {
>  		struct igb_ring *ring = adapter->rx_ring[i];
>  
> -		if (frame_size > igb_rx_bufsz(ring)) {
> +		if (frame_size + IGB_TS_HDR_LEN > igb_rx_bufsz(ring)) {

[Severity: High]
Does this refuse XDP at the default MTU of 1500 on 4K page systems?

At MTU 1500, max_frame_size is 1500 + IGB_ETH_PKT_HDR_PAD = 1526. That
is <= IGB_MAX_FRAME_BUILD_SKB, so igb_set_rx_buffer_len() sets up
build_skb rings without large buffers. igb_rx_bufsz() then returns
IGB_MAX_FRAME_BUILD_SKB (1536 - NET_IP_ALIGN):

igb_rx_bufsz() {
	...
	if (ring_uses_build_skb(ring))
		return IGB_MAX_FRAME_BUILD_SKB;
	...
}

The new check is 1526 + 16 = 1542 > 1536. So attaching XDP to an
interface that has been opened now fails with -EINVAL, where it passed
before. This seems to affect every MTU from about 1495 to 1510.
igb_change_mtu() also refuses those MTUs while XDP is attached.

The check also runs before the xchg() when bpf->prog is NULL. Can a
program get stuck attached? There are two ways to get there:

  - attach while the interface has never been opened (the ring flags
    are clear, so the 2048 check passes), then bring it up

  - attach at MTU 3000 on 3072 rings, then set MTU 1500.
    igb_change_mtu() checks against the old 3072 rings, and igb_up()
    then switches them to 1536 build_skb rings

After that, "ip link set xdp off" fails. On unregister,
dev_xdp_uninstall() hits:

	WARN_ON(dev_xdp_install(dev, mode, bpf_op, NULL, 0, NULL));

and the reference held in adapter->xdp_prog is never dropped.

The extra 16 bytes do seem to be needed for the skb layout:
igb_skb_pad() gives all the slack to headroom, which leaves exactly
1536 bytes before skb_shared_info.

Could igb_set_rx_buffer_len() instead pick a layout with room for the
timestamp, rather than refusing the default configuration and blocking
removal? For example, it could use 3K buffers when XDP is attached and
max_frame_size + IGB_TS_HDR_LEN > IGB_MAX_FRAME_BUILD_SKB.

The commit message only mentions a 16-byte reduction on 3 KiB buffers,
and none of the tests described ran at MTU 1500.

>  			NL_SET_ERR_MSG_MOD(bpf->extack,
>  					   "The RX buffer size is too small for the frame size");
>  			netdev_warn(dev, "XDP RX buffer size %d is too small for the frame size %d\n",

[ ... ]

> @@ -5386,6 +5389,12 @@ static void igb_set_rx_mode(struct net_device *netdev)
>  			rlpml = IGB_MAX_FRAME_BUILD_SKB;
>  	}
>  #endif
> +	/* XDP does not support frames that span more than one Rx buffer.
> +	 * With VFs the global limit stays large and the PF pool is limited
> +	 * through VMOLR below.
> +	 */
> +	if (!adapter->vfs_allocated_count && igb_xdp_is_enabled(adapter))
> +		rlpml = min_t(u32, rlpml, adapter->max_frame_size);

[Severity: High]
Are AF_XDP zero-copy rings covered by this limit?

For a ring with an XSK pool, igb_setup_srrctl() programs the pool frame
size rounded down to whole KiB:

	srrctl |= buf_size >> E1000_SRRCTL_BSIZEPKT_SHIFT;

With 2048-byte UMEM chunks, the frame size is
2048 - XDP_PACKET_HEADROOM = 1792, which gives a 1 KiB hardware buffer.
xp_assign_dev() accepts that pool at MTU 1500, and
igb_xsk_pool_enable() does no size check.

The limit here is max_frame_size (1526), so frames from 1025 to 1526
bytes still span two descriptors. igb_rx_bufsz() has no xsk_pool case,
so the checks in igb_xdp_setup() and igb_change_mtu() don't see that
buffer size either.

igb_clean_rx_irq_zc() never checks E1000_RXD_STAT_EOP. It runs
igb_run_xdp_zc() on each descriptor as if it were a full frame. On
XDP_PASS it builds an skb from the continuation buffer with
igb_construct_skb_zc(), or it redirects that buffer to the socket.

Doesn't that leave the bogus-frame problem from the commit title in
place for zero-copy?

[Severity: High]
What happens if the legacy-rx private flag is turned on while XDP is
attached?

igb_set_priv_flags() sets IGB_FLAG_RX_LEGACY and calls
igb_reinit_locked() without checking XDP or the MTU.
igb_set_rx_buffer_len() then returns early, which leaves 2048-byte
buffers:

	if (adapter->flags & IGB_FLAG_RX_LEGACY)
		return;

RLPML here, or the PF VMOLR, is still min(..., max_frame_size). For
example, attach XDP at MTU 3000 on 3072 rings (3026 + 16 <= 3072
passes), then run:

  ethtool --set-priv-flags ethX legacy-rx on

RLPML is now 3026 while the buffers are 2048, so a 3026-byte frame
takes two descriptors. In igb_clean_rx_irq(), if the first buffer gets
a non-PASS verdict, the second buffer is handled as a new frame.

The same happens if legacy-rx is turned on while the interface is down,
after it ran with 3K buffers. igb_xdp_setup() checks against the stale
large-buffer flag and passes, and igb_open() then builds 2048-byte
legacy rings.

Should the limit follow the buffer size the rings actually use? Or
should legacy-rx be refused while XDP is attached?

[Severity: High]
Does rx-all get around this limit?

When NETIF_F_RXALL is set, igb_setup_rctl() sets E1000_RCTL_SBP:

	rctl |= (E1000_RCTL_SBP | /* Receive bad packets */

With SBP set, the MAC stores frames longer than RLPML instead of
dropping them. Commit bb5ed01cd242 ("igb: set max size RX buffer when
store bad packet is enabled") already notes this, and
igb_set_rx_buffer_len() forces 3K buffers for that reason. Nothing
stops RXALL and XDP from being enabled together.

Frames larger than 3072 bytes then span several descriptors. In
igb_clean_rx_irq(), igb_run_xdp() runs on the first buffer before
igb_is_non_eop() and igb_cleanup_headers() are reached. On a non-PASS
verdict, the continuation buffer is handled as a new frame.

Would it make sense to refuse XDP while RXALL is on, to clear SBP while
XDP is attached, or to drop buffers until EOP after a non-PASS verdict?

>  	wr32(E1000_RLPML, rlpml);
>  
>  	/* In order to support SR-IOV and eventually VMDq it is necessary to set
> @@ -5402,15 +5411,18 @@ static void igb_set_rx_mode(struct net_device *netdev)
>  	vmolr |= rd32(E1000_VMOLR(vfn)) &
>  		 ~(E1000_VMOLR_ROPE | E1000_VMOLR_MPME | E1000_VMOLR_ROMPE);
>  
> -	/* enable Rx jumbo frames, restrict as needed to support build_skb */
> -	vmolr &= ~E1000_VMOLR_RLPML_MASK;
> +	/* enable Rx jumbo frames, restrict as needed to support build_skb
> +	 * and XDP
> +	 */
> +	pool_rlpml = MAX_JUMBO_FRAME_SIZE;
>  #if (PAGE_SIZE < 8192)
>  	if (adapter->max_frame_size <= IGB_MAX_FRAME_BUILD_SKB)
> -		vmolr |= IGB_MAX_FRAME_BUILD_SKB;
> -	else
> +		pool_rlpml = IGB_MAX_FRAME_BUILD_SKB;
>  #endif
> -		vmolr |= MAX_JUMBO_FRAME_SIZE;
> -	vmolr |= E1000_VMOLR_LPE;
> +	if (igb_xdp_is_enabled(adapter))
> +		pool_rlpml = min_t(u32, pool_rlpml, adapter->max_frame_size);

[Severity: Medium]
Can the limit be lifted during XDP detach while the rings are still
running the old program?

This check and the RLPML one above read adapter->xdp_prog. The Rx path
runs rx_ring->xdp_prog, which is only refreshed on open. igb_xdp_setup()
publishes NULL before igb_close() stops Rx:

	old_prog = xchg(&adapter->xdp_prog, prog);
	...
	if (need_reset && running) {
		igb_close(dev);

igb_set_rx_mode() can also be called without RTNL. One path is the VF
mailbox:

igb_msix_other()
  igb_msg_task()
    igb_rcv_msg_from_vf()
      igb_set_vf_multicasts() or igb_vf_reset_event()
        igb_set_rx_mode()

Another is __dev_set_rx_mode(), from callers such as MLD that hold
mc_lock rather than RTNL.

Suppose one of these runs between the xchg() and the point where
igb_down() clears E1000_RCTL_EN. RLPML (no VFs) or the PF VMOLR (with
VFs) is then written as MAX_JUMBO_FRAME_SIZE while the old program is
still running, and oversized frames arriving in that window would be
split the same way. The window is small and only opens during a detach.

> +	vmolr &= ~E1000_VMOLR_RLPML_MASK;
> +	vmolr |= pool_rlpml | E1000_VMOLR_LPE;

[Severity: High]
This isn't a bug introduced by this patch, but it involves the same
VMOLR RLPML field. Can a VF set arbitrary VMOLR bits for its own pool
through igb_set_vf_rlpml()?

igb_rcv_msg_from_vf() passes the mailbox word, which the VF controls,
straight through:

	case E1000_VF_SET_LPE:
		retval = igb_set_vf_rlpml(adapter, msgbuf[1], vf);

igb_set_vf_rlpml() takes it as int size, clamps it with a signed
compare, and ORs it in without masking:

	if (size > MAX_JUMBO_FRAME_SIZE)
		size = MAX_JUMBO_FRAME_SIZE;

	vmolr = rd32(E1000_VMOLR(vfn));
	vmolr &= ~E1000_VMOLR_RLPML_MASK;
	vmolr |= size | E1000_VMOLR_LPE;

A value with bit 31 set, such as 0x81000000, is negative and passes the
clamp. Its upper bits then land in VMOLR: AUPE, ROMPE, ROPE, BAM, MPME
and STRVLAN.

Take a VF with a port VLAN assigned by the PF, where igb_set_vmolr()
clears AUPE to enforce tagged-only receive. That VF could set AUPE
again and receive untagged traffic from outside its VLAN. It could also
set ROPE, even though igb_set_vf_promisc() only offers multicast
promiscuous mode to VFs.

Should size be checked as unsigned, or masked with
E1000_VMOLR_RLPML_MASK, before it is ORed in?

>  
>  	wr32(E1000_VMOLR(vfn), vmolr);
>  
> @@ -6713,7 +6725,7 @@ static int igb_change_mtu(struct net_device *netdev, int new_mtu)
>  		for (i = 0; i < adapter->num_rx_queues; i++) {
>  			struct igb_ring *ring = adapter->rx_ring[i];
>  
> -			if (max_frame > igb_rx_bufsz(ring)) {
> +			if (max_frame + IGB_TS_HDR_LEN > igb_rx_bufsz(ring)) {

[Severity: Medium]
Is this check run against the ring layout from before the MTU change?

Suppose XDP is attached at MTU 3000 (3072 rings) and the MTU is then
set to 1500. The check passes (1542 <= 3072). Then
igb_up()->igb_configure()->igb_set_rx_buffer_len() picks 1536 build_skb
rings, because that selection doesn't account for IGB_TS_HDR_LEN.

On those rings, igb_skb_pad() gives all the slack to headroom, which
leaves exactly IGB_MAX_FRAME_BUILD_SKB bytes before skb_shared_info.
With inline Rx timestamps on, take a frame accepted by the new RLPML of
1526 (1522 bytes stored after CRC stripping). With the 16-byte
timestamp that is 1538 bytes.

igb_build_skb() then does:

	skb_reserve(skb, xdp->data - xdp->data_hard_start);
	__skb_put(skb, xdp->data_end - xdp->data);

Can skb->tail end up about 2 bytes past skb->end here, overlapping
skb_shared_info?

The same overlap, up to 12 bytes at RLPML 1536, appears to exist
without XDP on build_skb rings with timestamping. So the layout problem
itself predates this patch. Still, this path lets frame plus timestamp
exceed the buffer, which the new check is meant to prevent.

>  				netdev_warn(adapter->netdev,
>  					    "Requested MTU size is not supported with XDP. Max frame size is %d\n",
>  					    max_frame);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102-igb-rx-ts-fix-v4-0-8785124c5d23%40aweta.nl
