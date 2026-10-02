Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8502CCA5FDD
	for <intel-wired-lan@archiver.kernel.org>; Fri,  2 Oct 2026 13:08:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36E9B81233;
	Fri,  2 Oct 2026 13:08:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bWAtoSXsWMbA; Fri,  2 Oct 2026 13:08:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8AD9A81222
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790946525;
	b=FCwUU3eD21JW1DkAB9BeQ0nhu9XS7m05Cc9KUqFa/HVW/iPwmMjXOVzkPQK4yyKfY3ol
	 rp81Pms9SqWZ9gQbnSWYQgX76Kj6gcJM6FrYXHA7EPxI6LzuIMPM2Ir8usXrfwxVF4+U+
	 /z+CCHSJVhiR+3AaKItOqFLNSLx6cfIihizcf5FCLCtNUhFhB+uZyPpJRPMEoWih/Z3g6
	 Wc56OoqOXnkepforyk9tIVcqiIfxJb+N/l8vdHLpeA4vQ/LCVQK1rSq7nH9UC7UsE6pxe
	 KrqhCZReifM+G9nHCseSxKXxJexQl+zHRjYFNGeYkWFMIpUztHVm0LmlAgtZgcuRaYw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790946525;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YulG5bJgMGBjiytjh2Hc9hcOj+okxOhkE66bat0zKVI=;
	b=iSUvMPcMcagBA8sQyq69alxDHrVEv49cI3GvuwaaCmVJIgR0MWhrI58r3UBx0UtnzOBC
	 MDRHixbfSBzBAxTFYzxzCMDG4qUs6LZhyEn41MrJmvRzmg1wnst6ypaeaSXvoV4HZ8bX/
	 Lc767hcR3JEyeNBAyxRZ3YfjlhmnlhT2uUCpHx3GBKTXGGuVzBo8eZjGqi2gt5enRQzGC
	 FFlH0SXp14GlqfYSmfQH5COvK/vOGtBKCCNAiYK3yPdrWUat64QLv47AyYgf+x2YPBH0K
	 zPJJv324pRMh+eQIgU5FTOmqM1T9ZA78YN23griQ+omuV/EStaRlCa4YU5i7Zs86Ntw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790946525;
	bh=YulG5bJgMGBjiytjh2Hc9hcOj+okxOhkE66bat0zKVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rVgsxOFK3YLZo8BmEQHbZQT4dC9GEEsI8Ir5nlIa8SMbHQxCHZPkgR7Cvqkg0sUKd
	 LvOiPT9azm2hzMTQD68VB2Idj223BRwrlGQAqgdKPIRJeTlSXeyLSAerZeueix8HAt
	 nrlBMzAdHUtuLuedVFmJGGU4SMyJDrAO8cQyP4OWhB6tGbiQP9o17CrbNqAu0A2Vuj
	 NFMpIsyU/rCC9uXv14HhJIEmUwNlShnxDg2+lvPr+hg3QIyAiAjfmRjRUII7mPaahH
	 bBmCZTWmkiQNekuRPa29ou7ez7yToxJSMkGJoBjOJgMNgVgmknIoFBq63RseupRHo3
	 JjvUhapSeDrkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8AD9A81222;
	Fri,  2 Oct 2026 13:08:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D53F282
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:08:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 73B7C400BB
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:08:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6z0tCfDMF8Bp for <intel-wired-lan@lists.osuosl.org>;
 Fri,  2 Oct 2026 13:08:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 8BE624004A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790946523;
 b=cvfV/xroBM/SvEOMk/Q7tW+FfFRXvRgdLNYZk5CtXd2j053+fZyVWJn2jp+OeBO11RYv
 +FPuoDzMR3hWCUq5QiZ7+InDCXbe8inuUW6Qg/jgq6I7H0+KOLHkXu3P+K25XB9btMMtq
 IJu5oYsXPR55B+z7Xyz48jB7AfF0bHsVtn4ZS0AOgoImwcXGucwKk55hM4GB0BzMAoDBz
 vK3lsNQpmEnGayQIZxRqGditcJ8Ez7Ma4A75iAA5aaImB+I0nc8fvz9h5tuhdn5FW3YKJ
 FrKqAIjNU5jBTXVGBE0vY8MWMdOGhQOqrGNFMPosYZfAbk4OzVPELqKeEc1yDNL9GvQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790946523;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Transfer-Encoding:content-type;
 bh=YulG5bJgMGBjiytjh2Hc9hcOj+okxOhkE66bat0zKVI=;
 b=paFdgxjKRMXduzmAoQuySf3OtypqNCpy5BA4A0vyIcZk7MnfY1jPUVegqS+pW9DPDNsu
 Bfam9HqHu+PoPwEVS3cN6tOCS/O/I5v/kVnBfu7jVNVIudXZ+5iFaRpVRTan91OOxaxgx
 iCouv+nc12fgRbXgpQTtw+hbZkp0JumP2Am7oWbsX7JtmJlXbgTG36Ot9Gftqxz02UhbT
 +h05qbPt8hWFR8BShYY59vjA8C9A/eOeZIp2+QaONOxYIk/xYJUYIEGvTTl1IlGOZGDQE
 /trUh+DSVJ10nvFVEPM56hqxKkp2fP1HiETNdN3u376BhDt7DQAGx+Tmx0oiUD6AHwA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=TNDrJqgY; 
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TNDrJqgY
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8BE624004A
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790946520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YulG5bJgMGBjiytjh2Hc9hcOj+okxOhkE66bat0zKVI=;
 b=TNDrJqgYDfL0GdcZV7pByDnMvCQGItgb6XqzsdXfUtFqTMtk7bmIh3W4SeVAtnOmfHKw2G
 kO3S5jU/N5zL0H3FzyIKJbgwgHyu6ONwdLIXcu8DWXZ7gBIDVp0BiQp4lDN7Tbo9JoBIx3
 frqZtG23ITXxcq1nebpGKnuZKF0yBzo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-HZ9L1NsWNp6DG-FSepvN4g-1; Fri,
 02 Oct 2026 09:08:35 -0400
X-MC-Unique: HZ9L1NsWNp6DG-FSepvN4g-1
X-Mimecast-MFC-AGG-ID: HZ9L1NsWNp6DG-FSepvN4g_1790946511
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B3151955D9F; Fri,  2 Oct 2026 13:08:31 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.39])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 33670754; Fri,  2 Oct 2026 13:08:25 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Henry Tieman <henry.w.tieman@intel.com>,
 Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Jesse Brandeburg <jbrandeb@kernel.org>,
 Preethi Banala <preethi.banala@intel.com>,
 Kiran Patil <kiran.patil@intel.com>, Dan Nowlin <dan.nowlin@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: [PATCH iwl-net 04/10] ice: restore the default XPS map after a netdev
 TC change
Date: Fri,  2 Oct 2026 15:07:46 +0200
Message-ID: <20261002130752.2597259-5-poros@redhat.com>
In-Reply-To: <20261002130752.2597259-1-poros@redhat.com>
References: <20261002130752.2597259-1-poros@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: cLe02Ftfd36mr0jhdu9-Ee3pO0N6MHntmzCRj4exA6M_1790946511
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

ice_cfg_xps_tx_ring() programs the default XPS map only once per ring,
guarded by ICE_TX_XPS_INIT_DONE. netdev_reset_tc() and
netdev_set_num_tc() drop all XPS maps of the device, but the bit is never
cleared, so the default map is not programmed again.

Since commit 122045ca7704 ("ice: config netdev tc before setting queues
number") ice_vsi_open() calls ice_vsi_cfg_netdev_tc() after the Tx
queues have been configured, so the map is wiped right after it was
written on every open and stays empty:

  # cat /sys/class/net/enp4s0f0np0/queues/tx-*/xps_cpus
  0000
  0000
  ...

A DCB reconfiguration ends the same way through ice_vsi_cfg_tc().

Clear ICE_TX_XPS_INIT_DONE in ice_vsi_cfg_netdev_tc(), which resets the
netdev TC state, and configure the netdev TCs in ice_vsi_open() before
the Tx queues so the default map is applied after the reset, not before
it.

i40e fixed the same stale bit in commit 82e0572b2302 ("i40e: Fix not
setting default xps_cpus after reset").

Fixes: 122045ca7704 ("ice: config netdev tc before setting queues number")
Assisted-by: LLM
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c  | 6 ++++++
 drivers/net/ethernet/intel/ice/ice_main.c | 6 +++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 5e183314e0d792..416e2d6a6f1709 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3218,6 +3218,12 @@ void ice_vsi_cfg_netdev_tc(struct ice_vsi *vsi, u8 ena_tc)
 	if (vsi->type == ICE_VSI_CHNL)
 		return;
 
+	if (vsi->tx_rings)
+		ice_for_each_txq(vsi, i)
+			if (vsi->tx_rings[i])
+				clear_bit(ICE_TX_XPS_INIT_DONE,
+					  vsi->tx_rings[i]->xps_state);
+
 	if (!ena_tc) {
 		netdev_reset_tc(netdev);
 		return;
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index e62a8f544345a3..8a21f87eb6ca21 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -7559,6 +7559,9 @@ int ice_vsi_open(struct ice_vsi *vsi)
 	if (err)
 		goto err_setup_rx;
 
+	if (bitmap_empty(pf->txtime_txqs, pf->max_pf_txqs))
+		ice_vsi_cfg_netdev_tc(vsi, vsi->tc_cfg.ena_tc);
+
 	err = ice_vsi_cfg_lan(vsi);
 	if (err)
 		goto err_stop_tx;
@@ -7569,9 +7572,6 @@ int ice_vsi_open(struct ice_vsi *vsi)
 	if (err)
 		goto err_stop_tx;
 
-	if (bitmap_empty(pf->txtime_txqs, pf->max_pf_txqs))
-		ice_vsi_cfg_netdev_tc(vsi, vsi->tc_cfg.ena_tc);
-
 	if (vsi->type == ICE_VSI_PF || vsi->type == ICE_VSI_SF) {
 		/* Notify the stack of the actual queue counts. */
 		err = netif_set_real_num_tx_queues(vsi->netdev, vsi->num_txq);
-- 
2.55.0

