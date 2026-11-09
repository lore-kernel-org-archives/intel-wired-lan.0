Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0449E606EE9E
	for <intel-wired-lan@archiver.kernel.org>; Mon,  9 Nov 2026 17:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=fTcNTecL;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RTdczEx2
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D80946082E;
	Mon,  9 Nov 2026 17:19:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZbUD3KTIDHxz; Mon,  9 Nov 2026 17:19:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 01FA86082B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794244747;
	b=kinMZUGzUXTRzNT4DhmsaPYRpkvPuqwaW3sOC2u3nwJpyY1HNSLVNENEdkBIIZWIKjn+
	 5mZHcm4rHKFdNf9YXaFsbjs0eWW6K3Duj9EXUrKlfGrUP0rqmtCwS/RSZ2hc4AhaV4OjC
	 iBG0snwB0bYqpdL25N7z+P+eBiRQt3KK6NpVPT1FTmQOijbe+EgrKO2hTNicZfGPFxgL5
	 yRLzisvVQFbeIDuvFRny55wtSSWfYSl1iyNIAI3qKdMavHUBKjoaFrU0ESGmi0pRUpTyg
	 dQfWX30V9Cf1waIetgsTGv3zdrKg3tKz1e5mUo7P9e3O6adJ/fRebCHME5HDMsUQYEQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794244747;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=ZKeqBS047+Pa27H8S0Szofh5TDu9ixoEKn6/UhBf5Lo=;
	b=PY6q8Ke57ClXmN7r+LhB3PWYwIkpXAYcICddk5BEu4D0pXfjS5RleCHgmJQGPhY8xmjm
	 Uu7SLHVKLBH0n5kOxpr7J9NUEhtCW7zEaz5woDHl/Omr5evaM9vRF8N/IyLQFAZk2JT9C
	 RZPT136ohBSaXGqomGk7f9YvsQlcoD8YWoQZft+TE73bQ8mlmuOcNUnq170+L37zie4oz
	 jWh3OjrBfVR/J1ZgPNXdSK0az4TWTHyy4wPdkLBGtSzSX3Bujvb4Jqq1flYYM9tTHKmme
	 Wo5q2MY8IAda25KuVh5lkjJBUwAO9N+lgh9ayXtaXwrGCWSvEaSPBgV2FCi/20gFgwg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794244747;
	bh=ZKeqBS047+Pa27H8S0Szofh5TDu9ixoEKn6/UhBf5Lo=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=fTcNTecLj15xPrrkr5EdA5HZb/PESxkKO12+qUFZaR88ziuQNMx2LZ1kFpMmlpRxa
	 y8Jd6p0/enCMRUJXbAAJr/GOejPS9sxWxoG2TAFGw/yrtRGW3LxUcna4pAu+or7SuV
	 Qa77C1eLFW5v5rbr7Nh3EoWRea1lTpU79NcK99q8E0mf2fUxWXK1m8VCqW4ffM4Ak3
	 4W8ENyXRrkGcmAWC2tbghWqkxyQ5M/6i/UHtDrOnqRh5+3A+8aKEOVjnxlbtg2fzqT
	 BM8Dz8VPmbP6/Fi8d6OeqGrx1k7olHFiMMQBas9OnV/k7aM3vjtnJP2fOnlcjKRtyy
	 K2mZn9CX9+/Vw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 01FA86082B;
	Mon,  9 Nov 2026 17:19:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D7EB2362
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 08:24:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BD98940251
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 08:24:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dRkMUSR9f1_U for <intel-wired-lan@lists.osuosl.org>;
 Mon,  9 Nov 2026 08:24:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9CFBE4022F
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+dominik.dvorak.econ.muni.cz@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=RTdczEx2
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9CFBE4022F
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 08:24:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 048AA435F9;
 Mon,  9 Nov 2026 08:24:20 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 4E4811F0089F;
 Mon,  9 Nov 2026 08:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794212659;
 bh=ZKeqBS047+Pa27H8S0Szofh5TDu9ixoEKn6/UhBf5Lo=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=RTdczEx28kGsWBqBjtijV/wx7tw+zw20WgWk0KI+fh0v3lxkBhSNo9QgEZmHcjdX5
 LeCchxBSDDPOv5Uy2L8+MC93HyNrIIxkemhQoIOtZqzqGOIdzu35Af4evEBRFnk0C0
 +RnFZYLh38wqjsMh7oa9zfZSpnqxjXSE5v86xSDYJxD4J3c+OxQIFSGvJB1Z64GNaN
 gueJQLix5B7w4drau+0HjX/dNIxtFJjFYmLWvzD2VgUkU5SeJbmYKIcxhKxI7QdxEE
 NPQGZGBAGDc982pNH+SaX3YC9tYtuRCsEav6NuV4b8Wh6HtQqUJ/q6R5Zd4SAXC+iR
 kEtMDB2wzoQxg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id A0F9F48353;
 Mon,  9 Nov 2026 08:24:18 +0000 (UTC)
From: =?utf-8?q?Dominik_Dvo=C5=99=C3=A1k_via_B4_Relay?=
 <devnull+Dominik.Dvorak.econ.muni.cz@kernel.org>
Date: Mon, 09 Nov 2026 09:24:10 +0100
Subject: [PATCH iwl-net v2] ice: fix Rx byte accounting for dropped XDP frames
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261109-ice-xdp-rx-bytes-v2-1-7d6035e687e2@econ.muni.cz>
X-B4-Tracking: v=1; b=H4sIACmD8WoC/3WNwQ6CMBBEf4Xs2SW0CCSe/A/DobSrbKItaWstE
 v7dhruHObxM5s0GgTxTgEu1gafEgZ0tIE8V6FnZByGbwiAb2QvRdMiaMJsFfcZpjRTwrLQqaUh
 qCWW2eLpzPpQ34M8TLUUYSzFziM6vx1USR/3fmgQK7Fujhqmj1gz9lbSz9ettudZfGPd9/wH60
 G/KvAAAAA==
X-Change-ID: 20261105-ice-xdp-rx-bytes-4aca4ac0e2c2
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, stable@vger.kernel.org, 
 =?utf-8?q?Dominik_Dvo=C5=99=C3=A1k?= <Dominik.Dvorak@econ.muni.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794212658; l=4363;
 i=Dominik.Dvorak@econ.muni.cz; s=20261105; h=from:subject:message-id;
 bh=vmGpEja47/xI/Jmt7BtvYvGqCuVgtx1xmRCp+kyKWls=;
 b=IUXEjKuIWDxIAsEwrR8yZRdNiFvc5O1T2EZAU4prXwahNs++vMgJN659Lbp2URQ/UOT7PTy0n
 i9YXxyyo62UD2CK2c3U+UETs7d+DAs3B4L55DyES1l3lQ857mr7Gljt
X-Developer-Key: i=Dominik.Dvorak@econ.muni.cz; a=ed25519;
 pk=RTZ8nGbFvBgcLsYzcjFd1S3jciozWEBDwMVtwC7jkGI=
X-Endpoint-Received: by B4 Relay for Dominik.Dvorak@econ.muni.cz/20261105
 with auth_id=1418
X-Original-From: =?utf-8?q?Dominik_Dvo=C5=99=C3=A1k?=
 <Dominik.Dvorak@econ.muni.cz>
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 09 Nov 2026 17:18:54 +0000
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

Count the frame length once, before running the XDP program, and use it
for the byte counter on every path; this also drops the duplicate
skb->len accounting that the XDP_PASS path did afterwards. The frame
length as received is counted, rather than the length after a possible
bpf_xdp_adjust_head()/bpf_xdp_adjust_tail().

The problem was tracked down and this fix written with the help of
Claude Opus 5.5 (Anthropic), working from netdev and ethtool counters
collected on the affected system and from the driver source.

Tested on an E810-XXV (7.0.14 kernel, same code as current master) with
an XDP blocklist attached to an 802.3ad bond: without the fix, each
dropped packet added about 2.5 GB to rx_queue_N_bytes; with the fix, 40
dropped packets produced no such jumps.

Fixes: 93f53db9f9dc ("ice: switch to Page Pool")
Cc: stable@vger.kernel.org # 6.18.x
Link: https://lore.kernel.org/netdev/DB7PR03MB460158B90A64D025962670E0D5772@DB7PR03MB4601.eurprd03.prod.outlook.com/
Signed-off-by: Dominik Dvořák <Dominik.Dvorak@econ.muni.cz>
---
Based on the stable v7.0.14 tree, which is what the affected box runs;
the changed code is identical in current master. Tested on that box
with the fixed module built against the 7.0.14-26-pve headers.
---
Changes in v2:
- Account for Rx bytes and packets once, before ice_run_xdp(), and drop
  the separate skb->len accounting on the XDP_PASS path (Olek).
- Add Cc: stable with the minimum affected version (Olek).
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 4ca1a0602307d076153f77671e8c9a6ff4f8dd28..8e4cda9a34b673a6c5a75e5aa7492c18bb0f3f19 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1028,14 +1028,19 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 		if (ice_is_non_eop(rx_ring, rx_desc) || unlikely(!xdp->data))
 			continue;
 
+		/* Account for Rx bytes here, before ice_run_xdp() may free the
+		 * buffer and clear xdp->data; the XDP and skb paths share the
+		 * same length.
+		 */
+		total_rx_bytes += xdp_get_buff_len(&xdp->base);
+		total_rx_pkts++;
+
 		xdp_verdict = ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring, rx_desc);
 		if (xdp_verdict == ICE_XDP_PASS)
 			goto construct_skb;
 
 		if (xdp_verdict & (ICE_XDP_TX | ICE_XDP_REDIR))
 			xdp_xmit |= xdp_verdict;
-		total_rx_bytes += xdp_get_buff_len(&xdp->base);
-		total_rx_pkts++;
 
 		xdp->data = NULL;
 		continue;
@@ -1053,18 +1058,12 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 
 		vlan_tci = ice_get_vlan_tci(rx_desc);
 
-		/* probably a little skewed due to removing CRC */
-		total_rx_bytes += skb->len;
-
 		/* populate checksum, VLAN, and protocol */
 		ice_process_skb_fields(rx_ring, rx_desc, skb);
 
 		ice_trace(clean_rx_irq_indicate, rx_ring, rx_desc, skb);
 		/* send completed skb up the stack */
 		ice_receive_skb(rx_ring, skb, vlan_tci);
-
-		/* update budget accounting */
-		total_rx_pkts++;
 	}
 
 	rx_ring->next_to_clean = ntc;

---
base-commit: 458c6079fc1d41d564c37679c8ace02cd83ee817
change-id: 20261105-ice-xdp-rx-bytes-4aca4ac0e2c2

Best regards,
-- 
Dominik Dvořák <Dominik.Dvorak@econ.muni.cz>


