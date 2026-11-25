Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6FB606A332
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Nov 2026 01:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=9Cd5ezH7;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kUOKGAh8
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 72423806A1;
	Wed, 25 Nov 2026 01:38:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uGz930Q5uWpk; Wed, 25 Nov 2026 01:38:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 57A2A806E7
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795570694;
	b=OF2bRLmOSHj61lVSFMNHRJOSDxSFM/05SfUZHUNVNc7qupQcGW92zS+uNQ9nP5O9rlmU
	 QPGHsfDRQpeBaZzYyZFMr3thuF8Mbqu+YYpLzX3b29bwNtqJFr6hAnbSjEtCyy8Cng0QO
	 Mmw6YCM9FlYw8YgIat7/hJ7fDikTgWDJO6LN2wo2Z0N3xK4F+hWXCh2dbcp3oaxhY76IB
	 wfmoJHYPnAl+WoDmKEt0XTywAIRucCWDfrKuHtcVczMP3mNINaE3KunP5kNCEnxev56Ws
	 cgjKvzuWzRJL+jPZnohKqSWV3LgVdaWfF1pC4OA69Kt879Oc4zH5Wz+K4wLH65Aub6w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795570694;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/i4jNdS1y5p3R3vSDLsBxb1ySs5NP+dCuDhMtJTNlqs=;
	b=mzrWCORcY/wZMma1RQSjLOtmP5BmY5urjOT8G5hp7hqd6jO6W/AewW/+C+pi5dSewA16
	 Q1p44trRjP9GRt4RG04GdhdorlVDpqquTqHVWskXUbcpd0q5Ohc2V3RKPnOmFxKW+2vNP
	 qW3df0QP9ang2FOY8wOSVc/9mlY8z15ZpnA/rYhJJqAB3u1rWNFzdTEb9F5g9SH4qaHyp
	 Dd/hWg7wWchPbUy+8zONVRgAS95j3RnPB44KXPBPn1pCwInjsDQq+xSk60+KaCqZOgXWK
	 bypHcfa/dd01reuyFP4M6lVMvHyB0u3quIv9Ap6/QnpJ3pWRNluRnnurPgIGMsJx8+A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795570694;
	bh=/i4jNdS1y5p3R3vSDLsBxb1ySs5NP+dCuDhMtJTNlqs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=9Cd5ezH7MuUturm+2bRbfflEno0gCEFEZiqiFO76SbzdzVr6MSgJI8mtNpm4KvwdL
	 7YA07NgoK87NcZmzZ8JK1kduXjTAsGmBMTyX3pD369HeWwXl11HgUHH1buo3FiwhOJ
	 aNar8/CA+UxV+qrI1rMdTnZOv7B6F4AsSvinpQ52Zn21bgk3Sl7ylOS0WRSEFE9d+P
	 3gEk13+v+TOmHFUgsw5CXp0seXEOHqPEzrdRpiIi6RPYeZdhBcUjl+4uMbT7i8eI5j
	 aiJYW0SJZZee/fUOnonxoBlg/IUmDCu2TSUXs/6EwQA9ltmXFFq1W55qTO/tlCxX/q
	 fbHZTjLQVa0bg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 57A2A806E7;
	Wed, 25 Nov 2026 01:38:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6EACF325
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 01:38:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6BFDC400AF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 01:38:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kBxtECObiqEn for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Nov 2026 01:38:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 314DF40079
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=netdev-bot+sashiko@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=kUOKGAh8
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 314DF40079
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 01:38:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 06025602C5;
 Wed, 25 Nov 2026 01:38:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C621F000C6;
 Wed, 25 Nov 2026 01:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795570689;
 bh=/i4jNdS1y5p3R3vSDLsBxb1ySs5NP+dCuDhMtJTNlqs=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=kUOKGAh8l/KAFUNWyQrKSsmQsU5/wiBnVMWq7tCCQrQ1RNWNl3dsHK4WquJ/Rzg78
 iahk5s+iSvj1Q00iJtc9XsjwSv3gCyL0KR+70Dg7RrVuch4PiPR1mtIF1wdFhy8oy6
 8DzeiJXdQ8rJQRPnDb+VZla9K5yrA01RtP3o7ps1lIQUN1k1miZaw7khbV5eL06yHY
 sTeGkj7r2grUauDXeHHv3b+iQaGv9O6vSwZeAbK55pHIEtbNplousCGwVuBoQPnE21
 qEHVOQt33tc/2FzgOpYMMAucQ5YlINnfzvEy41YpXN3SjwmxlHzmqLK2gcvHzdop/4
 bAdX4j5k9jwlg==
Subject: Re: [PATCH net] ice: do not report CHECKSUM_COMPLETE when an XDP
 program is attached
From: netdev-bot+sashiko@kernel.org
To: tianyi@cloudflare.com
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, paul.greenwalt@intel.com, alice.michael@intel.com,
 eric.joyner@intel.com, jbrandeb@kernel.org, lorenzo@kernel.org,
 bpf@vger.kernel.org, kernel-team@cloudflare.com, tianyi.gao@linux.dev
Date: Wed, 25 Nov 2026 01:38:08 +0000
Message-ID: <179557068810.3135.17964087549504688357@kernel.org>
In-Reply-To: <20261121012402.84848-1-tianyi@cloudflare.com>
References: <20261121012402.84848-1-tianyi@cloudflare.com>
X-sashiko-severity: Medium
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
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] On E830 with an XDP program attached, ice_rx_csum()
  (drivers/net/ethernet/intel/ice/ice_txrx_lib.c) now skips ice_rx_gcs()…
- [Low] ice_rx_csum() decides whether to use GCS/CHECKSUM_COMPLETE by
  reading ring->xdp_prog again with `!READ_ONCE(ring->xdp_prog)`…

--

ice: do not report CHECKSUM_COMPLETE when an XDP program is attached

This patch stops ice_rx_csum() from using the E830 generic checksum (GCS)
to report CHECKSUM_COMPLETE when the rx ring has an XDP program attached,
because an XDP_PASS program may have modified the frame. Such packets now
take the L3L4P/XSUM_* descriptor status path, as on E810.

Link: https://lore.kernel.org/all/20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org/ [1]
Link: https://lore.kernel.org/all/cover.1794281983.git.tianyi@cloudflare.com/ [2]

> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> index e695a664e53d1..ad22d855436eb 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> @@ -123,6 +123,7 @@ ice_rx_csum(struct ice_rx_ring *ring, struct sk_buff *skb,
>  	rx_status1 = le16_to_cpu(rx_desc->wb.status_error1);
>  
>  	if ((ring->flags & ICE_RX_FLAGS_RING_GCS) &&
> +	    !READ_ONCE(ring->xdp_prog) &&

[Severity: Medium]
With an XDP program attached, E830 packets now go to the L3L4P/XSUM_*
status path further down in ice_rx_csum(). Can that path mark a modified
packet CHECKSUM_UNNECESSARY based on how the hardware parsed the original
frame?

ice_rx_csum() runs after XDP has already run:

ice_clean_rx_irq()
    ice_run_xdp()             /* returns XDP_PASS */
    ice_process_skb_fields()
        ice_rx_csum()

The same thing happens in ice_clean_rx_irq_zc() via ice_run_xdp_zc().

Take the load balancer case from the commit message. The program strips
a UDP encapsulation with bpf_xdp_adjust_head() and returns XDP_PASS.

If the outer UDP port is not a configured VXLAN/GENEVE port, the parser
does not treat the frame as a tunnel. The L4 status bits then describe
only the outer UDP checksum. A zero outer UDP checksum over IPv4 ends up
here:

	if (decoded.tunnel_type >= LIBETH_RX_PT_TUNNEL_IP_GRENAT)
		skb->csum_level = 1;

	skb->ip_summed = CHECKSUM_UNNECESSARY;

After decapsulation, the outermost L4 header is the inner TCP/UDP header.
The stack skips that checksum, and nothing has verified it. If the parser
did recognise the tunnel, csum_level = 1 is applied to a packet that is
no longer tunnelled.

Before this patch, the stale CHECKSUM_COMPLETE value made the stack
recompute the checksum in software. Good packets passed with a
netdev_rx_csum_fault() warning, and corrupted ones were dropped.

The commit message says:

    E830 also sets the L3L4P and checksum error bits, so the packet gets
    CHECKSUM_UNNECESSARY or CHECKSUM_NONE, as on E810.

E810 already behaves this way, and so does mlx5, where
MLX5E_RQ_STATE_NO_CSUM_COMPLETE leads to csum_unnecessary. On E830,
though, corrupted packets on these rings used to be caught in software.

Would CHECKSUM_NONE be a safer fallback here until the pending XDP
checksum hint series land? If not, could the commit message describe
this trade-off?

[Severity: Low]
Should this use the per-poll snapshot instead of reading ring->xdp_prog
a second time? The program that actually ran comes from:

ice_clean_rx_irq():
	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
	...
	xdp_verdict = ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring, rx_desc);

ice_clean_rx_irq_zc() takes the same kind of snapshot for
ice_run_xdp_zc(). Neither function passes the snapshot to
ice_process_skb_fields().

The commit message already mentions the window this opens.
ice_prepare_for_reset() sets ICE_VSI_REBUILD_PENDING before calling
ice_pf_dis_all_vsi(). ice_dis_vsi() then has to take rtnl_lock before
ice_vsi_close() can stop NAPI. An XDP detach that holds rtnl during that
window gets here:

ice_xdp_setup_prog():
	if (ice_is_xdp_ena_vsi(vsi) == !!prog ||
	    test_bit(ICE_VSI_REBUILD_PENDING, vsi->state)) {
		ice_vsi_assign_bpf_prog(vsi, prog);
		return 0;
	}

ice_vsi_assign_bpf_prog() writes NULL to rx_ring->xdp_prog while NAPI
is still running. Suppose a poll runs the old program on a packet and
gets XDP_PASS. ice_rx_csum() then reads NULL here and reports the stale
GCS value as CHECKSUM_COMPLETE.

Both callers of ice_process_skb_fields() already know whether a program
ran. Would passing that down close this window and also save a
per-packet load?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261121012402.84848-1-tianyi%40cloudflare.com
