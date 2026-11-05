Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A28606A334
	for <intel-wired-lan@archiver.kernel.org>; Thu,  5 Nov 2026 17:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=OWQF7CMq;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FKX8a5cs
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B306540807;
	Thu,  5 Nov 2026 17:09:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pjjmHYwp3XkS; Thu,  5 Nov 2026 17:09:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E653340825
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793898550;
	b=HDf5A2NxIFyLF7IkIBcqpqTxWBwzn4rrSHXXJWCgx4yvQCoIlr0T+QZyuGevlQuuZg/G
	 X76fFOKeBeSakTMU3ur+ZZ8omYzOKebxABA/hpv+aVAvyTA9/rbPEJXN88sbRHNpRoEx5
	 tVe9saqJ15R68ioRBs8FK08jUHnM8EzDKEGvlWtGYJEpcbqQwvBQI8mbLSBk0kwQExmnm
	 1quLfOrjB2dIVyJqNS0U4Xk/n8thlUSv7ljAn35cJxQzBTdR9RCmEwJKcZKkp6RJehADo
	 NPY9ZZndrFc/k5yGesDPwAUbIqcJ65IMizUkPAlzO2EjVcKKon/YBwLCz4wnsUWQVEg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793898550;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=kQXVzs+UYaWDn+IaqCcCLtAQKsKwcmCsC/NWALdi5xA=;
	b=dDEQ1O5XEV+ZzNC8w2s53CWSzafT9Y7mfpNnyG5c34uNP1OG01fsvikCV2O0VqCrJ2FM
	 FlroXeDu+C5H1IGlEplaOS6FMklYrsmpQwI/rugRUCtj1QG/E8688YSHofRXMd6mqcFcM
	 WTzq3UsAP8u3xbm2mjBq0UkZvuzCU3W9eAOUmwHHfw6/UE6lViW3TaCI1BcK3iolCu8TI
	 NpB/uxUh5KdQSg5+/nUJkaftZsQViAwQm9+aqK0NVbi/8AtYWQOEJDAECDe99Hct2Xjrv
	 NpJBq0vJv7GVIscTQ5toa1lyRLCwjbUsRnhgks+FZoQAHH6yRE0yOH953a3K/w6LO7g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793898549;
	bh=kQXVzs+UYaWDn+IaqCcCLtAQKsKwcmCsC/NWALdi5xA=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=OWQF7CMqzSJwRo/7BXX1yX3SzgS97bcjYJ2gSI2plL27/v/rZqpu+ijLt+AQJKz+j
	 q0453aTlIDPcHA2uEl03DR+FNaQy95R/h4fKUP+X5CIN7fSq5bHukhixXimCQlnA21
	 0eQPk95ecJpwefklm8+j37hWfui13U8UW4bgT5BNqvI5/ZgdO5Av2/XodVtJdLj1rk
	 Zi2tXOoMszT2/wr8dqRXJIeE28HfzWzzcowgKi05AzBs43TpEKjfLeLDRbN/O3RLhA
	 ONDJ/QEgfVBV01cQRftYiWvGpEn5K5YCZiJMXo8n43ftv0lOVJn7w/YTSj3FhwjZI6
	 82Q6j5wlfBShg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E653340825;
	Thu,  5 Nov 2026 17:09:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 96A3134D
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 13:21:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8857381144
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 13:21:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PtEEzId42l34 for <intel-wired-lan@lists.osuosl.org>;
 Thu,  5 Nov 2026 13:21:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 950E781135
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+dominik.dvorak.econ.muni.cz@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=FKX8a5cs
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 950E781135
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 13:21:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7A79A438CB;
 Thu,  5 Nov 2026 13:21:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id C6AC21F00A02;
 Thu,  5 Nov 2026 13:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793884911;
 bh=kQXVzs+UYaWDn+IaqCcCLtAQKsKwcmCsC/NWALdi5xA=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=FKX8a5cspFps6w+HwM2Ioc2w3NeOE4zkIq/KAAahb46BWyWEe/oaUfmbEEvWgDZnh
 6Zi7cdSX0DyKayQlnPRvPotLcgcBqTYP6nvPtBbp15T8hcHvuqFEAgIlkldDkhIDF0
 DYM0gdjNgTW1BTwFsMtO72taSPFjaBJRRIeaX3swjyNibcLWW7hTgMlOmj7541gl4U
 GtivFbCKfdA6lEiq/uWAdV3HJTF1gcmPm//2/bETo3ZzOQtxT9i6VH6lTISlJ6lBFn
 6RTNqAakZtCFzbP3228gVlGCSflBbablWN/ofqepxA9DEG8Ktqr1CcmuluvvwOvk9V
 yg50G5y6f0n3w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 41A6747271;
 Thu,  5 Nov 2026 13:21:50 +0000 (UTC)
From: =?utf-8?q?Dominik_Dvo=C5=99=C3=A1k_via_B4_Relay?=
 <devnull+Dominik.Dvorak.econ.muni.cz@kernel.org>
Date: Thu, 05 Nov 2026 14:21:15 +0100
Subject: [PATCH iwl-net] ice: fix Rx byte accounting for dropped XDP frames
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261105-ice-xdp-rx-bytes-v1-1-63da7b5e3d76@econ.muni.cz>
X-B4-Tracking: v=1; b=H4sIAMqC7GoC/x2MQQ5AMBQFryJ/7Sdtg4WriEXVw0+kpBUq4u4ai
 1nMYuahiCCI1BYPBZwSZfNZdFmQW6yfwTJmJ6NMo7WqWRw4jTuHxMN9IHJlnc0oGGcoZ3vAJOl
 fdiTXyh4H9e/7AYxXQEFrAAAA
X-Change-ID: 20261105-ice-xdp-rx-bytes-4aca4ac0e2c2
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 =?utf-8?q?Dominik_Dvo=C5=99=C3=A1k?= <Dominik.Dvorak@econ.muni.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793884909; l=3624;
 i=Dominik.Dvorak@econ.muni.cz; s=20261105; h=from:subject:message-id;
 bh=jfrNnQ7InY4Nb94BiB/3wT4b52lrC1Z8QEHRLs4bn90=;
 b=6zN3cKhm2x0ywzitDLLbqyMLnFFkq/laCYFenPD5EbBny9wxp05fhN6XuGjklEkEP2T03OLO4
 1Bggsv2bG6XBqLSi8kQtuZJMGbmNlzKK/IFJaBdjD3UDUxpH6LEUu5L
X-Developer-Key: i=Dominik.Dvorak@econ.muni.cz; a=ed25519;
 pk=RTZ8nGbFvBgcLsYzcjFd1S3jciozWEBDwMVtwC7jkGI=
X-Endpoint-Received: by B4 Relay for Dominik.Dvorak@econ.muni.cz/20261105
 with auth_id=1418
X-Original-From: =?utf-8?q?Dominik_Dvo=C5=99=C3=A1k?=
 <Dominik.Dvorak@econ.muni.cz>
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 05 Nov 2026 17:09:07 +0000
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
Reply-To: Dominik.Dvorak@econ.muni.cz
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Dominik Dvořák <Dominik.Dvorak@econ.muni.cz>

Since the Rx path was converted to page pool and libeth, ice_run_xdp()
returns the buffer itself via libeth_xdp_return_buff() on XDP_DROP,
XDP_ABORTED and on a failed XDP_TX or XDP_REDIRECT. That helper also
sets xdp->data to NULL. ice_clean_rx_irq() then calls xdp_get_buff_len()
on the same buffer to update the Rx byte counter, which evaluates
xdp->data_end - NULL and adds the low 32 bits of a kernel address to
the ring's byte counter for every such frame. For multi-buffer frames
it would also read skb_shared_info from a page that has already been
returned to the page pool.

On an E810 with an XDP blocklist attached to an 802.3ad bond, this shows
up as jumps of up to 4 GiB in the per-queue and netdev rx_bytes counters,
one per dropped packet, while the packet counters and the hardware byte
counter (rx_bytes.nic) stay correct. The bogus values are also exposed
to unprivileged users through the netdev statistics.

Take the frame length before running the XDP program and use it for the
byte counter. For XDP_TX and XDP_REDIRECT this means the length of the
frame as received is counted, rather than the length after a possible
bpf_xdp_adjust_head()/bpf_xdp_adjust_tail().

The problem was tracked down and this fix written with the help of
Claude Opus 5.5 (Anthropic), working from netdev and ethtool counters
collected on the affected system and from the driver source.

Tested on an E810-XXV (7.0.14 kernel, same code as current master) with
an XDP blocklist attached to an 802.3ad bond: without the fix, each
dropped packet added about 2.5 GB to rx_queue_N_bytes; with the fix, 40
dropped packets produced no such jumps.

Fixes: 93f53db9f9dc ("ice: switch to Page Pool")
Link: https://lore.kernel.org/netdev/DB7PR03MB460158B90A64D025962670E0D5772@DB7PR03MB4601.eurprd03.prod.outlook.com/
Signed-off-by: Dominik Dvořák <Dominik.Dvorak@econ.muni.cz>
---
Based on the stable v7.0.14 tree, which is what the affected box runs;
the changed code is identical in current master. Tested on that box
with the fixed module built against the 7.0.14-26-pve headers.
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 4ca1a0602307d076153f77671e8c9a6ff4f8dd28..f62a1bb7bbca579b43fe2f4c8e1946e65b5cea63 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -968,7 +968,7 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 		union ice_32b_rx_flex_desc *rx_desc;
 		struct libeth_fqe *rx_buf;
 		struct sk_buff *skb;
-		unsigned int size;
+		unsigned int size, len;
 		u16 stat_err_bits;
 		u16 vlan_tci;
 		bool rxe;
@@ -1028,13 +1028,16 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 		if (ice_is_non_eop(rx_ring, rx_desc) || unlikely(!xdp->data))
 			continue;
 
+		/* ice_run_xdp() may free the buffer and clear xdp->data */
+		len = xdp_get_buff_len(&xdp->base);
+
 		xdp_verdict = ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring, rx_desc);
 		if (xdp_verdict == ICE_XDP_PASS)
 			goto construct_skb;
 
 		if (xdp_verdict & (ICE_XDP_TX | ICE_XDP_REDIR))
 			xdp_xmit |= xdp_verdict;
-		total_rx_bytes += xdp_get_buff_len(&xdp->base);
+		total_rx_bytes += len;
 		total_rx_pkts++;
 
 		xdp->data = NULL;

---
base-commit: 458c6079fc1d41d564c37679c8ace02cd83ee817
change-id: 20261105-ice-xdp-rx-bytes-4aca4ac0e2c2

Best regards,
-- 
Dominik Dvořák <Dominik.Dvorak@econ.muni.cz>


