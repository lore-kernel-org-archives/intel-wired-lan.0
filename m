Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD47FC3ABB6
	for <intel-wired-lan@archiver.kernel.org>; Mon,  5 May 2025 22:36:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9715D60A7A;
	Mon,  5 May 2025 22:36:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LT7OTfrqMUM7; Mon,  5 May 2025 22:36:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 939D3606B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1746484604;
	bh=2IVsHwGpgB02hKL7P5uExhDc9q3xwihrD7eP4xyx/Ks=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xqfHKyDxaGmUfD68adkKpY6j09RDl7wh13pIMqMUW2GlcJlx6tVwTzf9cGzvC2RqK
	 qwza90YwtUIM/E25c7IUs4rm6m2kwz5K0foHpRjVCC0bWtiDj73Cn2AN/Gx6ctnDoE
	 S26W79Hg95mp27Qwoawx+xTxQk9k9YrGhO1sPq1CJgupZ7cArLqQX4ypBAjq3xcWNs
	 3VTjYNBUvbE+IbwR0p+hYoRNKIO762VeSMkxBhrt9xw5H0zQsY6SO1xCWaU7Q3FeyE
	 dwGywcV0OiNh5VYbvtFeZd2bqZxcvIoEk7/LCD/KzVEOFwN4N+hySI5Nyd2qSLob3x
	 MuHTuli0Bt7zw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 939D3606B6;
	Mon,  5 May 2025 22:36:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 063E712E
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 May 2025 22:36:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E9B6C80AF7
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 May 2025 22:36:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 02GwPwqV6AUb for <intel-wired-lan@lists.osuosl.org>;
 Mon,  5 May 2025 22:36:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5684980AD6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5684980AD6
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5684980AD6
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 May 2025 22:36:42 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 630BEA4CE69;
 Mon,  5 May 2025 22:31:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E60FC4CEEF;
 Mon,  5 May 2025 22:36:39 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Sasha Levin <sashal@kernel.org>,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Date: Mon,  5 May 2025 18:12:51 -0400
Message-Id: <20250505221419.2672473-555-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1746484600;
 bh=7ZwOUkW9ETmUFHyzF9HXliCgfHLsWwg6FVhZ87z5ZNw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CIOlaCK4eGtY51M0G9X+hfvZj7/xKItOwuLImTgwqEMVdS7jq5bkcC5u4rziT426Y
 0OyOnFcL9OL0vwMdJ7XYn44+QfeYMf/pKiBIqpL7gdk4xZRoLZCYrXffQqcHLjCWkK
 ACVoqXIidBjBRpsrTpXO5uWZKCksbeXhLD65q6XW5lFu+WzwTdLn2aI5cK0fc2AgYW
 NL+MLBtPyEmm1QlDIkvCBu9CyHs3Hbgh9W/g+WLPO/+iRmX7099Xlb8HV08D3rqaQM
 ZjoVKFcReRvqAQLiTUjV/Jf4zlj8VM9NDnZQHWiYloLD7OItK1dg/xVvkk1pHNdZ2I
 A8XkhE5y9K8IQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=CIOlaCK4
Subject: [Intel-wired-lan] [PATCH AUTOSEL 6.14 555/642] ice: init flow
 director before RDMA
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

[ Upstream commit d67627e7b53203ca150e54723abbed81a0716286 ]

Flow director needs only one MSI-X. Load it before RDMA to save MSI-X
for it.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index e13bd5a6cb6c4..d24d46b24e371 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5186,11 +5186,12 @@ int ice_load(struct ice_pf *pf)
 
 	ice_napi_add(vsi);
 
+	ice_init_features(pf);
+
 	err = ice_init_rdma(pf);
 	if (err)
 		goto err_init_rdma;
 
-	ice_init_features(pf);
 	ice_service_task_restart(pf);
 
 	clear_bit(ICE_DOWN, pf->state);
@@ -5198,6 +5199,7 @@ int ice_load(struct ice_pf *pf)
 	return 0;
 
 err_init_rdma:
+	ice_deinit_features(pf);
 	ice_tc_indir_block_unregister(vsi);
 err_tc_indir_block_register:
 	ice_unregister_netdev(vsi);
@@ -5221,8 +5223,8 @@ void ice_unload(struct ice_pf *pf)
 
 	devl_assert_locked(priv_to_devlink(pf));
 
-	ice_deinit_features(pf);
 	ice_deinit_rdma(pf);
+	ice_deinit_features(pf);
 	ice_tc_indir_block_unregister(vsi);
 	ice_unregister_netdev(vsi);
 	ice_devlink_destroy_pf_port(pf);
-- 
2.39.5

