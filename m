Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE4BCA9ED2
	for <intel-wired-lan@archiver.kernel.org>; Mon, 12 Oct 2026 07:30:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 98F8B605EF;
	Mon, 12 Oct 2026 07:30:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pDP1kL1yHJgX; Mon, 12 Oct 2026 07:30:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C81A360619
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791790246;
	b=gLUwXXyKWiVnM6zYZN9pXoLy9r5atlVgw6c8OwuDhi7pJW4rImE1I6hTXrhK8Yv5XuBg
	 3C2JeBl3oNodzPyYeINd5HyRwTU6TxGWAaPX+eflZ95XU1zGuLfogJeOYv8UosXYPSKaa
	 68Ms+9RQ7kjKaowRK/o9znyPOdwLAa82ZDRlGjflhX1ZkjF16xNbHmK4FLUrVgb4Yp3gQ
	 ezPebmfIfI+Yk10x06DN0ZGuslYA6WaOmNglXW512P1rA87wFZCLSAe/ReUWz3PJmQKjj
	 meZFmoi0uEwz3DqO11LKsE7/0R50EFmb3BnVKW8gvz4i8xjRMONF+eKl599ObZ/Z4/w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791790246;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Th7i9MmgPqf+eKL72J4AGfFVFML6R6BAitK93cMpub0=;
	b=Xa3ITzRfMIb7wpBAiftON1YQPj1oOcHPo6cuBQzLGfVuhvQS66aCisRUmUbu60h1IsXU
	 Tgog0JeoC7oEnVFk3Cd4W+RPs/VRcCDZPWGZAfUfwHyN1ziSqJKiaIlvxNieZXZtEfPUm
	 Ps2jVi3N6bjP3AaqbwY0kNuLJUibN8ReLptdYeRMoh8di2npHaal/6tPmXQk2WT5uPkbU
	 VdGL0w6vUnB/DAcpOuEWgrXL2KtvVaLmAzQ/Lon0k8tjeWlpfC5Cgvggx6egcpBMtgoey
	 0p9Mln7CEi4A9cZ8S/cwEmhoXWgN2pyi2k9zzYc67rQyVMg4DL766z5xyHO1nytO4Hw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b="dR/dBLA6";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791790246;
	bh=Th7i9MmgPqf+eKL72J4AGfFVFML6R6BAitK93cMpub0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=85N0GeFZPWSzPT0DOcOJzgnxG9D5fVAln8X7zBleeEc2I4G2VG/wDTqhrBvfYS1N3
	 TP5Eu6c/ubul2gSLiIUe0bzdU7ky4zm6l0es+jjNicBZ8Nxoo9/1L2BP1nJeVTS/0T
	 WvhhL8mr5BVJIqMGpRVEKqvv1j1L95exwjz0lUovCRqcsmsko4mEYNy/Rfe/Vtp38B
	 NE8O3XeE5Bd1vs2t516+olA42nYgWvjk1rMYHVSOB1KKFXVJdUBf7qn4SlcMom9/S9
	 o8S5w3MG7GqLQILeO2ylgV9GOC+6SDTqiNgaq3+4lwdcuzoNHQ1aVSXIsj5tc5RNeT
	 EHPDVOuCfePeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C81A360619;
	Mon, 12 Oct 2026 07:30:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3BCC9194
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 07:30:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2154460619
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 07:30:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8kJ4XS4v184O for <intel-wired-lan@lists.osuosl.org>;
 Mon, 12 Oct 2026 07:30:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 14D7C605EF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=220.197.31.6
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791790244;
 b=gW49gbWRLb/pOs4g2QwRJspFq4A2TZmiFzBfLbo9zAi13YzqVxcZeoxKiogqiRUcXYrD
 OTsaA0LMSfjPdphgOPn3qwIiOaKxak5OGRQdvAdr3driI5MlK4xTVQsp2Hy+6EmZD3Jtk
 K6Sp5fax7df/kGiagFBMUsnWuQMtAU3HFzGRiFRgtADC0gX+83XB5G/pn6QQzKc1QhU2R
 2rWqMR4oNB/nWctOixynaT9GI0MS8qsKK+5dBZSAcBTEmgH0jj0v4MXp7b+SkzQ2i+Mzw
 fJj9pYqzHzTj9nHv0nuKAe8kqQdLeH+s2wAOPrSa5dNriTasojkrgsuwihbFX8M8yhA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791790244;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
 bh=Th7i9MmgPqf+eKL72J4AGfFVFML6R6BAitK93cMpub0=;
 b=S012QlMZ2If7Dka+8hQVU5plC4/ihkYpiFvyD7UJMEwuSGBlmvE/zQFUh2HAQlnZr+TF
 6OiiDZzcIZBsg34gC8HAOBSdJc8mIk5dB3D3VCept0k5XFvIDix1syDIXYWjY2dgITe6j
 UCwi2HB71XrVx+Tpz5nKjymc+m1sDbL7vg83x63dPts0HD65YE4o1e3ByOGGbMKkfVnvT
 eKaqub1XRKI4l7X0vDe3zjPQIn8gFlLybleXbpsQkCygAGFWi6lcNx60OVc9RxR5UGnK4
 /2u9IP4q5fIimUrL1lEHEaKyz5R1RA7Z2dZxzej3V5WkN5PZ6DruVSgkDceY1mCOkBQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=126.com;
 dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b="dR/dBLA6"; 
 arc=none smtp.remote-ip=220.197.31.6
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.6;
 helo=m16.mail.126.com; envelope-from=xiaolinkui@126.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=dR/dBLA6
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 14D7C605EF
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 07:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Th
 7i9MmgPqf+eKL72J4AGfFVFML6R6BAitK93cMpub0=; b=dR/dBLA63a+lX0QBZA
 k7bqPIkoFdkezKQP/iVEW6h67BitazIAKcEr7ZxPbpzuyfrtL/xUkQCMOfx25XAS
 kbi9HlWDoys132+CAdkNkUc0ZylfajS077L+OUwgnirccyAMMc2Oe3Rf6OeszN3K
 TLozhq/dTMcuOlissHbSNglNg=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id
 _____wD3N_p4jMxqvoGeAw--.28607S2; 
 Mon, 12 Oct 2026 15:30:02 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>,
 stable@vger.kernel.org
Subject: [PATCH iwl-net] ice: wait for in-flight Rx polls before freeing a
 representor
Date: Mon, 12 Oct 2026 15:29:59 +0800
Message-Id: <20261012072959.254206-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3N_p4jMxqvoGeAw--.28607S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuw48Gr4Dur13Aw43JFWkWFg_yoW7ZF1xpF
 WUKFy5CrykJr40gw15Wa18uFyrCw45trWagryxKrWruwn8JFyrAF17KryY9FyrCa13uF1a
 vr15Z3yrA3s8X3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UpVb9UUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlBoP5WrMjHqmJAAA32
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

From: Linkui Xiao <xiaolinkui@kylinos.cn>

ice_eswitch_detach() unregisters the representor netdev, removes it from
the eswitch xarray and frees it:

	repr->ops.rem(repr);
	xa_erase(&pf->eswitch.reprs, repr->id);
	...
	ice_repr_destroy(repr);

The Rx path holds no reference to what it finds in that xarray. While
the uplink VSI has ICE_RX_FLAGS_MULTIDEV set, ice_process_skb_fields()
calls ice_eswitch_get_target(), which is a bare xa_load(), and then uses
the returned netdev in ice_repr_inc_rx_stats() and eth_type_trans().

unregister_netdev() does wait for RCU readers, but it runs before the
erase, so it does not cover the polls that pick the representor up after
it. Between xa_erase() and ice_repr_destroy() there is no grace period
at all: a poll that loaded the pointer just before the erase then reads
repr->stats through ice_netdev_to_repr() and the netdev itself after
free_percpu(), free_netdev() and kfree() have run.

That order is not new: commit e9942bfe4931 ("ice: Fix use after free
during unload with ports in bridge") moved unregister_netdev() ahead of
the erase so that the bridge can still find the representor by id while
its notifier chain runs, which also keeps the representor reachable for
longer. The missing grace period goes back to the lookup itself, so the
Fixes: tag below points at the commit that added it.

Take the missing grace period. The xarray entry is erased first so that
no further lookup can find the representor, then synchronize_net() waits
for the polls that already did before it is released and destroyed.
repr->ops.rem() has to stay ahead of the erase, because
ice_eswitch_br_port_deinit() looks the representor up by id while
unregister_netdev() runs its notifier chain.

Make the lookup side explicit as well and hold the RCU read lock around
the whole block in ice_process_skb_fields(), so that the netdev returned
by ice_eswitch_get_target() is covered by that synchronize_net() whatever
RCU flavour the kernel is built with.

ice_eswitch_detach() runs once per representor, so this adds one grace
period per representor to the teardown path. All of its callers are in
sleepable process context, so this is safe; batching the grace periods
would mean splitting the erase from the destroy, which is not done here.

The window is reachable in switchdev mode when traffic arrives on the
uplink VSI while a VF or SF representor is being torn down, for example
by removing VFs or by switching the eswitch back to legacy mode. It was
found by code inspection of that teardown path, it was not reproduced at
runtime and no stack trace was observed.

Fixes: 44ba608db509 ("ice: do switchdev slow-path Rx using PF VSI")
Cc: stable@vger.kernel.org
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c  | 10 +++++++++-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 13 +++++++++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index b069e6c514fb..465ed7957506 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -556,6 +556,13 @@ static void ice_eswitch_detach(struct ice_pf *pf, struct ice_repr *repr)
 
 	xa_erase(&pf->eswitch.reprs, repr->id);
 
+	/* The Rx path looks the representor up by its id and dereferences the
+	 * result without holding a reference to it. Nothing can find it in the
+	 * xarray anymore, so wait for the polls that picked it up before the
+	 * erase to finish before the representor is torn down.
+	 */
+	synchronize_net();
+
 	if (xa_empty(&pf->eswitch.reprs))
 		ice_eswitch_disable_switchdev(pf);
 
@@ -614,7 +621,8 @@ void ice_eswitch_detach_sf(struct ice_pf *pf, struct ice_dynamic_port *sf)
  * @rx_desc: descriptor used to get src_vsi value
  *
  * Get src_vsi value from descriptor and load correct representor. If it isn't
- * found return rx_ring->netdev.
+ * found return rx_ring->netdev. The caller must hold the RCU read lock, the
+ * returned netdev can go away as soon as the read-side section ends.
  */
 struct net_device *ice_eswitch_get_target(struct ice_rx_ring *rx_ring,
 					  union ice_32b_rx_flex_desc *rx_desc)
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index e695a664e53d..bbbf13b29cbf 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -223,8 +223,16 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
 
 	/* modifies the skb - consumes the enet header */
 	if (unlikely(rx_ring->flags & ICE_RX_FLAGS_MULTIDEV)) {
-		struct net_device *netdev = ice_eswitch_get_target(rx_ring,
-								   rx_desc);
+		struct net_device *netdev;
+
+		/* ice_eswitch_get_target() looks the representor up in the
+		 * eswitch xarray without taking a reference to it, so hold the
+		 * RCU read lock while the netdev it returns is in use.
+		 * ice_eswitch_detach() waits for the section to end before it
+		 * frees the representor.
+		 */
+		rcu_read_lock();
+		netdev = ice_eswitch_get_target(rx_ring, rx_desc);
 
 		if (ice_is_port_repr_netdev(netdev))
 			ice_repr_inc_rx_stats(netdev, skb->len);
@@ -234,6 +242,7 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
 		 */
 		__skb_push(skb, ETH_HLEN);
 		skb->protocol = eth_type_trans(skb, netdev);
+		rcu_read_unlock();
 	}
 
 	ice_rx_csum(rx_ring, skb, rx_desc, ptype);
-- 
2.25.1

