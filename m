Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759C9ECAAA1
	for <intel-wired-lan@archiver.kernel.org>; Fri, 28 Oct 2022 16:08:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D6BD8410D2;
	Fri, 28 Oct 2022 16:08:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D6BD8410D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1666973338;
	bh=kjCtyhvZay/7ytw6UeieBqxNvnH6AwTcRu6h2ouWH+Q=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=2GandM0CWQEcjBBXxpuaIdwh2fKZKFgX+Q//Uxxug4mBf1T/CulIB9SsVylw86elv
	 mT0ESvNHa7qdvCZdRk6a7vLlY6oEesE25xHbLKoGVjZURbMjT0FsdjzCeOFIJjVr6c
	 sHDu/ocTAvOxCfJ7z/hv56FXyDnetPtAJ02ZSZm+FTg5gv/DostJBIQeW6yuHuF7/r
	 yXxmJ3HsCpo/QuJyjG2CKtNpzwctBKsEiwEacaW9IrT85aR1g4AVQ4OaBV2Ao7tp0n
	 3UuVNNntM7uxPmBc6S9YKcLUxkO66aoEf8n9RwirTSusvcruzvTpNyg9giuBYXv9CL
	 KgmrqH2QEaGaw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NnCxa-ZLpi5D; Fri, 28 Oct 2022 16:08:57 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 93554410D3;
	Fri, 28 Oct 2022 16:08:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 93554410D3
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 4CC411BF299
 for <intel-wired-lan@lists.osuosl.org>; Fri, 28 Oct 2022 16:08:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 313B260B97
 for <intel-wired-lan@lists.osuosl.org>; Fri, 28 Oct 2022 16:08:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 313B260B97
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oh-detuqMIKj for <intel-wired-lan@lists.osuosl.org>;
 Fri, 28 Oct 2022 16:08:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3CBA760B5A
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3CBA760B5A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 28 Oct 2022 16:08:54 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="295936459"
X-IronPort-AV: E=Sophos;i="5.95,221,1661842800"; d="scan'208";a="295936459"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2022 09:08:54 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="583967960"
X-IronPort-AV: E=Sophos;i="5.95,221,1661842800"; d="scan'208";a="583967960"
Received: from pmstillw-desk1.amr.corp.intel.com ([10.212.20.92])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2022 09:08:53 -0700
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Fri, 28 Oct 2022 09:08:15 -0700
Message-Id: <20221028160815.244-1-paul.m.stillwell.jr@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1666973335; x=1698509335;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=VP1rr2zrTQAQzXZ/pPTAw9Z72zKSaH8CVu79KCaqzIc=;
 b=my0QdHgsYwSlU6+kVrn5Jb8mEwBriSp/31tNT6x9H7nJx9zs4Fmqsb18
 v8+NCLFOnS6W7xNoprGh15JVYnzL2LcwcslG5UgqVEGXd8OiR/dTxlohC
 GKoGwnmZeX5etV3/ZbJnXuLpRX7fA+jLCUpfy+gwTze7DUXF5NleNXWI3
 hpl+socZ2CqF44vM3I89Xy32J/GNAKR9vnonIKYNLeFZ3oTNh03onVzdz
 3oKgoNfFps0cB0mNvLcHymRaifnHviqTbk5QG/rJuscuWmzahk17slxMi
 TlA08x4l5JWD5zpaWE5iveD0h2s1Vzq+IY/RKqvltyo3Eqtt0X7v/bPj9
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=my0QdHgs
Subject: [Intel-wired-lan] [PATCH net-next] ice: move devlink port
 creation/deletion
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Commit a286ba738714 ("ice: reorder PF/representor devlink
port register/unregister flows") moved the code to create
and destroy the devlink PF port. This was fine, but created
a corner case issue in the case of ice_register_netdev()
failing. In that case, the driver would end up calling
ice_devlink_destroy_pf_port() twice.

Additionally, it makes no sense to tie creation of the devlink
PF port to the creation of the netdev so separate out the
code to create/destroy the devlink PF port from the netdev
code. This makes it a cleaner interface.

Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Fixes: a286ba738714 ("ice: reorder PF/representor devlink port register/unregister flows")
---
 drivers/net/ethernet/intel/ice/ice_main.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 0f6718719453..910df8438726 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4599,10 +4599,6 @@ static int ice_register_netdev(struct ice_pf *pf)
 	if (!vsi || !vsi->netdev)
 		return -EIO;
 
-	err = ice_devlink_create_pf_port(pf);
-	if (err)
-		goto err_devlink_create;
-
 	err = register_netdev(vsi->netdev);
 	if (err)
 		goto err_register_netdev;
@@ -4615,8 +4611,6 @@ static int ice_register_netdev(struct ice_pf *pf)
 
 	return 0;
 err_register_netdev:
-	ice_devlink_destroy_pf_port(pf);
-err_devlink_create:
 	free_netdev(vsi->netdev);
 	vsi->netdev = NULL;
 	clear_bit(ICE_VSI_NETDEV_ALLOCD, vsi->state);
@@ -4909,6 +4903,10 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 	pcie_print_link_status(pf->pdev);
 
 probe_done:
+	err = ice_devlink_create_pf_port(pf);
+	if (err)
+		goto err_create_pf_port;
+
 	err = ice_register_netdev(pf);
 	if (err)
 		goto err_netdev_reg;
@@ -4946,6 +4944,8 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 err_devlink_reg_param:
 	ice_devlink_unregister_params(pf);
 err_netdev_reg:
+	ice_devlink_destroy_pf_port(pf);
+err_create_pf_port:
 err_send_version_unroll:
 	ice_vsi_release_all(pf);
 err_alloc_sw_unroll:
@@ -5071,6 +5071,7 @@ static void ice_remove(struct pci_dev *pdev)
 	ice_setup_mc_magic_wake(pf);
 	ice_vsi_release_all(pf);
 	mutex_destroy(&(&pf->hw)->fdir_fltr_lock);
+	ice_devlink_destroy_pf_port(pf);
 	ice_set_wake(pf);
 	ice_free_irq_msix_misc(pf);
 	ice_for_each_vsi(pf, i) {
-- 
2.35.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
