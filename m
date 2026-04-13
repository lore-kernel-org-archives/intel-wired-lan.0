Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2352AF531C9
	for <intel-wired-lan@archiver.kernel.org>; Mon, 13 Apr 2026 19:14:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C064960EF1;
	Mon, 13 Apr 2026 19:14:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0gS-31pKYhna; Mon, 13 Apr 2026 19:14:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EF41C60EE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776107682;
	bh=pYt1tOgdZFbK6/EN+WXYPhu9UbbK6FxljyO9OAvK7X4=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=l4V+C+/gj78vGVg5KqR03w3BP3+Otgvr+gEP11pzY9L8zt4IsmNqX3WniZFkCZUBr
	 sXs63wUf5f05dQq9qgWJ0UjqkieoMk2JHR9fz1nPGa3U2XyYazt6qIt0p0qFFAEsu6
	 l9BmLF/qVRWHdjwEbsHOmZfdeBb3OdSzEG+2yPFj6ALxL8BkmfkDJ9EiMvCCVby9m6
	 M5ave5gBa8bKHm6YJggh4CLNhUN23mlUUkIEcnF66R1Yi8paRF3ZaJ3bRoYsDqjFP3
	 OeZ2dsaVKgZ/L53TDQBqZkP6VVVrcQMGPtHjg2TcE12SD/M5GpTIN74+9C5H6d0HMt
	 TP7T76aP8UEkg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF41C60EE6;
	Mon, 13 Apr 2026 19:14:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8038A237
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Apr 2026 19:14:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6571B8333F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Apr 2026 19:14:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jnPyvX3bPsYu for <intel-wired-lan@lists.osuosl.org>;
 Mon, 13 Apr 2026 19:14:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4E9FE82EE1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4E9FE82EE1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4E9FE82EE1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Apr 2026 19:14:38 +0000 (UTC)
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-pfaZ9RXNNJmSVKi3RakdHg-1; Mon,
 13 Apr 2026 15:14:34 -0400
X-MC-Unique: pfaZ9RXNNJmSVKi3RakdHg-1
X-Mimecast-MFC-AGG-ID: pfaZ9RXNNJmSVKi3RakdHg_1776107668
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 445621800245; Mon, 13 Apr 2026 19:14:28 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.25])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4384E19560AB; Mon, 13 Apr 2026 19:14:23 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Date: Mon, 13 Apr 2026 21:14:20 +0200
Message-ID: <20260413191420.3524013-1-poros@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: q0C8J84Y_NYtoeyRYcEc4uFgsST5p62oluXZHf_ZzYo_1776107668
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1776107677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pYt1tOgdZFbK6/EN+WXYPhu9UbbK6FxljyO9OAvK7X4=;
 b=bbC/J+41x1PoeRoAgs2maQ0pz8/Xr2E4U/CLx3WLFfBFoOz8pGqdcltfiJRoGCVM5Vc1Tl
 m02vtFOtn+ujLQB4vdkDjidF/lkq047ya74TwfUWlD+Wp4xpH+cB/upYYdoV8vSnWzEyfb
 YNfRXo4JTs3DoExnltbuz74Vrs/Ving=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=bbC/J+41
Subject: [Intel-wired-lan] [PATCH iwl-net] ice: fix infinite recursion in
 ice_cfg_tx_topo via ice_init_dev_hw
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
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Paul Greenwalt <paul.greenwalt@intel.com>,
 Daniel Zahka <daniel.zahka@gmail.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Nikolay Aleksandrov <razor@blackwall.org>, Eric Dumazet <edumazet@google.com>,
 linux-kernel@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Dave Ertman <david.m.ertman@intel.com>, jacob.e.keller@intel.com,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, intel-wired-lan@lists.osuosl.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On certain E810 configurations where firmware supports Tx scheduler
topology switching (tx_sched_topo_comp_mode_en), ice_cfg_tx_topo()
may need to apply a new 5-layer or 9-layer topology from the DDP
package. If the AQ command to set the topology fails (e.g. due to
invalid DDP data or firmware limitations), the global configuration
lock must still be cleared via a CORER reset.

Commit 86aae43f21cf ("ice: don't leave device non-functional if Tx
scheduler config fails") correctly fixed this by refactoring
ice_cfg_tx_topo() to always trigger CORER after acquiring the global
lock and re-initialize hardware via ice_init_hw() afterwards.

However, commit 8a37f9e2ff40 ("ice: move ice_deinit_dev() to the end
of deinit paths") later moved ice_init_dev_hw() into ice_init_hw(),
breaking the reinit path introduced by 86aae43f21cf. This creates an
infinite recursive call chain:

  ice_init_hw()
    ice_init_dev_hw()
      ice_cfg_tx_topo()         # topology change needed
        ice_deinit_hw()
        ice_init_hw()           # reinit after CORER
          ice_init_dev_hw()     # recurse
            ice_cfg_tx_topo()
              ...               # stack overflow

Fix by moving ice_init_dev_hw() back out of ice_init_hw() and calling
it explicitly from ice_probe() and ice_devlink_reinit_up(). The third
caller, ice_cfg_tx_topo(), intentionally does not need ice_init_dev_hw()
during its reinit, it only needs the core HW reinitialization. This
breaks the recursion cleanly without adding flags or guards.

The deinit ordering changes from commit 8a37f9e2ff40 ("ice: move
ice_deinit_dev() to the end of deinit paths") which fixed slow rmmod
are preserved, only the init-side placement of ice_init_dev_hw() is
reverted.

Fixes: 8a37f9e2ff40 ("ice: move ice_deinit_dev() to the end of deinit paths")
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/devlink/devlink.c | 2 ++
 drivers/net/ethernet/intel/ice/ice_common.c      | 2 --
 drivers/net/ethernet/intel/ice/ice_main.c        | 2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index 6144cee8034d77..641d6e289d5ce6 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -1245,6 +1245,8 @@ static int ice_devlink_reinit_up(struct ice_pf *pf)
 		return err;
 	}
 
+	ice_init_dev_hw(pf);
+
 	/* load MSI-X values */
 	ice_set_min_max_msix(pf);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index ce11fea122d03e..b617a6bff89134 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1126,8 +1126,6 @@ int ice_init_hw(struct ice_hw *hw)
 	if (status)
 		goto err_unroll_fltr_mgmt_struct;
 
-	ice_init_dev_hw(hw->back);
-
 	mutex_init(&hw->tnl_lock);
 	ice_init_chk_recipe_reuse_support(hw);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index e2a5534819d194..a27be29f9bbbfc 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5314,6 +5314,8 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 		return err;
 	}
 
+	ice_init_dev_hw(pf);
+
 	adapter = ice_adapter_get(pdev);
 	if (IS_ERR(adapter)) {
 		err = PTR_ERR(adapter);
-- 
2.52.0

