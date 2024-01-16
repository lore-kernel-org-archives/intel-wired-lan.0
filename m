Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26776C47DAF
	for <intel-wired-lan@archiver.kernel.org>; Tue, 16 Jan 2024 19:57:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B3B7440382;
	Tue, 16 Jan 2024 19:57:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B3B7440382
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1705435067;
	bh=R7cD969KfBkZA787xolt119GWX/h4vfCpgkl23sheEA=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Qse0Lk1LKw+uR98CHGCq3ydoy9sXH4MeCKB62OXejRHlBAvaOSLyaXIKb4AABHreZ
	 UhRhbX6uVG5W39Ddi6VPhJ+38SyhKGPoJe/xqi9rT3juwGehRr5NsqKU3WpuVcp8UL
	 1wy/llb1yLBPGaD6U4E7j/HYJMmNk0sxyYQTNEM6eznYdnGRbVHsjQSkUSLyBFENEv
	 4y6FFYqo2uLix3JyZ1iZOwOWo8k8+gyCK9L+e4GsLv8DEcmQiXuLj9TRW+va63KoVx
	 JYAoCP7pp7u+H5cDbB41Fg06Ct/BQcXnfIpKqB28ezGv4zP82pzT1545SrddXJixcq
	 k++amZ1sqai8A==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3c94_2iTEKLJ; Tue, 16 Jan 2024 19:57:45 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3FD3C40640;
	Tue, 16 Jan 2024 19:57:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3FD3C40640
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 77BD51BF846
 for <intel-wired-lan@lists.osuosl.org>; Tue, 16 Jan 2024 19:57:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4A60D831EF
 for <intel-wired-lan@lists.osuosl.org>; Tue, 16 Jan 2024 19:57:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4A60D831EF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lEQ-FHO4qfhs for <intel-wired-lan@lists.osuosl.org>;
 Tue, 16 Jan 2024 19:57:43 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 88B8B83155
 for <intel-wired-lan@lists.osuosl.org>; Tue, 16 Jan 2024 19:57:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 88B8B83155
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C704C60B51;
 Tue, 16 Jan 2024 19:57:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7AACC433F1;
 Tue, 16 Jan 2024 19:57:40 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Tue, 16 Jan 2024 14:54:05 -0500
Message-ID: <20240116195511.255854-66-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195511.255854-1-sashal@kernel.org>
References: <20240116195511.255854-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1705435062;
 bh=puRV9+d/Db0XBkDKUHK/iRtAtFxjI+BZTX6e20CdEhI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dudsoOwH5E+JCmjiT1mnj7sBPUkx6d3VpEw7A9YM07ibzWicfUTWWdmB17iRwLVLg
 ssVu3W2nQWUqEbUQc5p+hw8mzgX3xwKZawHhWOt3RIWi5CkN/WKGxtX9GT9Jmdt4HA
 RYIhv5y0nqZwKx/xwlCQdXkJ25IsLCwdLusWXn7/phlsfrLgswMpJWa+AFBzZSwRU8
 gxXv4mL8nU3MBKBDd7X7BXU6DpNH7o6CHE25IAG6rXGUfJKdprHyQBaUSUQ6huRhTk
 gk0YhjR+8AW2AxyU8+6R097kjo/M4K8P+2UqUwNTm10fY/1qtlgpX/OYBnE/qFpjP9
 nGFHC3vs0bxDg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=dudsoOwH
Subject: [Intel-wired-lan] [PATCH AUTOSEL 6.1 66/68] i40e: Fix VF disable
 behavior to block all traffic
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
Cc: Sasha Levin <sashal@kernel.org>, Jan Sokolowski <jan.sokolowski@intel.com>,
 Wojciech Drewek <wojciech.drewek@intel.com>, davem@davemloft.net,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, jesse.brandeburg@intel.com,
 Andrii Staikov <andrii.staikov@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, edumazet@google.com,
 netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 intel-wired-lan@lists.osuosl.org, kuba@kernel.org, pabeni@redhat.com,
 Rafal Romanowski <rafal.romanowski@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Andrii Staikov <andrii.staikov@intel.com>

[ Upstream commit 31deb12e85c35ddd2c037f0107d05d8674cab2c0 ]

Currently, if a VF is disabled using the
'ip link set dev $ETHX vf $VF_NUM state disable' command, the VF is still
able to receive traffic.

Fix the behavior of the 'ip link set dev $ETHX vf $VF_NUM state disable'
to completely shutdown the VF's queues making it entirely disabled and
not able to receive or send any traffic.

Modify the behavior of the 'ip link set $ETHX vf $VF_NUM state enable'
command to make a VF do reinitialization bringing the queues back up.

Co-developed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Jan Sokolowski <jan.sokolowski@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Andrii Staikov <andrii.staikov@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 32 +++++++++++++++++++
 .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |  1 +
 2 files changed, 33 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index cb925baf72ce..21d6deb23f54 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2577,6 +2577,14 @@ static int i40e_vc_enable_queues_msg(struct i40e_vf *vf, u8 *msg)
 	int aq_ret = 0;
 	int i;
 
+	if (vf->is_disabled_from_host) {
+		aq_ret = -EPERM;
+		dev_info(&pf->pdev->dev,
+			 "Admin has disabled VF %d, will not enable queues\n",
+			 vf->vf_id);
+		goto error_param;
+	}
+
 	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states)) {
 		aq_ret = I40E_ERR_PARAM;
 		goto error_param;
@@ -4630,9 +4638,12 @@ int i40e_ndo_set_vf_link_state(struct net_device *netdev, int vf_id, int link)
 	struct i40e_link_status *ls = &pf->hw.phy.link_info;
 	struct virtchnl_pf_event pfe;
 	struct i40e_hw *hw = &pf->hw;
+	struct i40e_vsi *vsi;
+	unsigned long q_map;
 	struct i40e_vf *vf;
 	int abs_vf_id;
 	int ret = 0;
+	int tmp;
 
 	if (test_and_set_bit(__I40E_VIRTCHNL_OP_PENDING, pf->state)) {
 		dev_warn(&pf->pdev->dev, "Unable to configure VFs, other operation is pending.\n");
@@ -4655,17 +4666,38 @@ int i40e_ndo_set_vf_link_state(struct net_device *netdev, int vf_id, int link)
 	switch (link) {
 	case IFLA_VF_LINK_STATE_AUTO:
 		vf->link_forced = false;
+		vf->is_disabled_from_host = false;
+		/* reset needed to reinit VF resources */
+		i40e_vc_reset_vf(vf, true);
 		i40e_set_vf_link_state(vf, &pfe, ls);
 		break;
 	case IFLA_VF_LINK_STATE_ENABLE:
 		vf->link_forced = true;
 		vf->link_up = true;
+		vf->is_disabled_from_host = false;
+		/* reset needed to reinit VF resources */
+		i40e_vc_reset_vf(vf, true);
 		i40e_set_vf_link_state(vf, &pfe, ls);
 		break;
 	case IFLA_VF_LINK_STATE_DISABLE:
 		vf->link_forced = true;
 		vf->link_up = false;
 		i40e_set_vf_link_state(vf, &pfe, ls);
+
+		vsi = pf->vsi[vf->lan_vsi_idx];
+		q_map = BIT(vsi->num_queue_pairs) - 1;
+
+		vf->is_disabled_from_host = true;
+
+		/* Try to stop both Tx&Rx rings even if one of the calls fails
+		 * to ensure we stop the rings even in case of errors.
+		 * If any of them returns with an error then the first
+		 * error that occurred will be returned.
+		 */
+		tmp = i40e_ctrl_vf_tx_rings(vsi, q_map, false);
+		ret = i40e_ctrl_vf_rx_rings(vsi, q_map, false);
+
+		ret = tmp ? tmp : ret;
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index 358bbdb58795..010e5730465e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -98,6 +98,7 @@ struct i40e_vf {
 	bool link_forced;
 	bool link_up;		/* only valid if VF link is forced */
 	bool spoofchk;
+	bool is_disabled_from_host; /* PF ctrl of VF enable/disable */
 	u16 num_vlan;
 
 	/* ADq related variables */
-- 
2.43.0

