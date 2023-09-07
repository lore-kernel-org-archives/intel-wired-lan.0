Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A0A5EC873A
	for <intel-wired-lan@archiver.kernel.org>; Thu,  7 Sep 2023 15:46:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3884D83F2F;
	Thu,  7 Sep 2023 15:46:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3884D83F2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1694101617;
	bh=L7XzWlN2mh40/r/dSGaCotcxsNBehh092x3ZWyAwduE=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=ZYl+Fg/v4u8EO27V7C246Szyqqs2nJpik3m5/GK+EM9F9rstZwX86BLcxc5PNcc90
	 IDskOf/sDETDqRjQjKjo7M0mUc1s7Ky6BZVyOMqDbFgF9g/Ira13w8I7JohLq10oh5
	 x0XZFawb5q8CuyM0h/emAXuYZcMgZAvstInc4r0//Sl0+BzU1YZl/IWc2NUALSuXst
	 4/GPeaL5MokpBmzJ5KbN9c8ZPnCA+gr0WfIZW8r8gGnY9PfNef5ys8FNm/0TAHdYxF
	 WHn1xoL0vTYBlug1t1w1uKWSBJVNS6Xu8jEsswK2jrcYRgHDbCVdsW1ghidntddF//
	 yQXv7Kor+oeWA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e9pmtgggvCo3; Thu,  7 Sep 2023 15:46:56 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 358F183EE1;
	Thu,  7 Sep 2023 15:46:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 358F183EE1
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id AE7FF1BF2CC
 for <intel-wired-lan@lists.osuosl.org>; Thu,  7 Sep 2023 15:45:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 92CED418BC
 for <intel-wired-lan@lists.osuosl.org>; Thu,  7 Sep 2023 15:45:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 92CED418BC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GKsoTVXvE-dv for <intel-wired-lan@lists.osuosl.org>;
 Thu,  7 Sep 2023 15:45:07 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 78C0D418B3
 for <intel-wired-lan@lists.osuosl.org>; Thu,  7 Sep 2023 15:45:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 78C0D418B3
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-EPwSvFjgNLWT4x29tG7TyQ-1; Thu, 07 Sep 2023 11:45:01 -0400
X-MC-Unique: EPwSvFjgNLWT4x29tG7TyQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B8B090B242;
 Thu,  7 Sep 2023 15:45:00 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.226.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4548C493112;
 Thu,  7 Sep 2023 15:44:58 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Date: Thu,  7 Sep 2023 17:44:57 +0200
Message-ID: <20230907154457.3861711-1-ivecera@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1694101506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7+VK+VR2m38+xEZzYiAj3ASuAJ4XHaCJV5htNfCsfmI=;
 b=NAb4F6RrXZgGsr1FibJ2f9i7Gqx2OXxB1VHgMfuRtZYtiejI+kCyNpihlF1aoW12FkiuhY
 LhIq6TK1aSwpF4CPF6ZdSrdkTAJC7o38hB1pY5PR8j4J0nwbi+4SZMiSaoY00jBiYWXa/z
 NGhYNBcnbZOKEh9qlxJTcx4Ux0Xqyxs=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NAb4F6Rr
Subject: [Intel-wired-lan] [PATCH net] i40e: Fix VF VLAN offloading when
 port VLAN is configured
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: Catherine Sullivan <catherine.sullivan@intel.com>,
 "moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 open list <linux-kernel@vger.kernel.org>, Greg Rose <gregory.v.rose@intel.com>,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Jeff Kirsher <jeffrey.t.kirsher@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

If port VLAN is configured on a VF then any other VLANs on top of this VF
are broken.

During i40e_ndo_set_vf_port_vlan() call the i40e driver reset the VF and
iavf driver asks PF (using VIRTCHNL_OP_GET_VF_RESOURCES) for VF capabilities
but this reset occurs too early, prior setting of vf->info.pvid field
and because this field can be zero during i40e_vc_get_vf_resources_msg()
then VIRTCHNL_VF_OFFLOAD_VLAN capability is reported to iavf driver.

This is wrong because iavf driver should not report VLAN offloading
capability when port VLAN is configured as i40e does not support QinQ
offloading.

Fix the issue by moving VF reset after setting of vf->port_vlan_id
field.

Without this patch:
$ echo 1 > /sys/class/net/enp2s0f0/device/sriov_numvfs
$ ip link set enp2s0f0 vf 0 vlan 3
$ ip link set enp2s0f0v0 up
$ ip link add link enp2s0f0v0 name vlan4 type vlan id 4
$ ip link set vlan4 up
...
$ ethtool -k enp2s0f0v0 | grep vlan-offload
rx-vlan-offload: on
tx-vlan-offload: on
$ dmesg -l err | grep iavf
[1292500.742914] iavf 0000:02:02.0: Failed to add VLAN filter, error IAVF_ERR_INVALID_QP_ID

With this patch:
$ echo 1 > /sys/class/net/enp2s0f0/device/sriov_numvfs
$ ip link set enp2s0f0 vf 0 vlan 3
$ ip link set enp2s0f0v0 up
$ ip link add link enp2s0f0v0 name vlan4 type vlan id 4
$ ip link set vlan4 up
...
$ ethtool -k enp2s0f0v0 | grep vlan-offload
rx-vlan-offload: off [requested on]
tx-vlan-offload: off [requested on]
$ dmesg -l err | grep iavf

Fixes: f9b4b6278d51ff ("i40e: Reset the VF upon conflicting VLAN configuration")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 8ea1a238dcefe1..d3d6415553ed67 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -4475,9 +4475,7 @@ int i40e_ndo_set_vf_port_vlan(struct net_device *netdev, int vf_id,
 		goto error_pvid;
 
 	i40e_vlan_stripping_enable(vsi);
-	i40e_vc_reset_vf(vf, true);
-	/* During reset the VF got a new VSI, so refresh a pointer. */
-	vsi = pf->vsi[vf->lan_vsi_idx];
+
 	/* Locked once because multiple functions below iterate list */
 	spin_lock_bh(&vsi->mac_filter_hash_lock);
 
@@ -4563,6 +4561,10 @@ int i40e_ndo_set_vf_port_vlan(struct net_device *netdev, int vf_id,
 	 */
 	vf->port_vlan_id = le16_to_cpu(vsi->info.pvid);
 
+	i40e_vc_reset_vf(vf, true);
+	/* During reset the VF got a new VSI, so refresh a pointer. */
+	vsi = pf->vsi[vf->lan_vsi_idx];
+
 	ret = i40e_config_vf_promiscuous_mode(vf, vsi->id, allmulti, alluni);
 	if (ret) {
 		dev_err(&pf->pdev->dev, "Unable to config vf promiscuous mode\n");
-- 
2.41.0

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
