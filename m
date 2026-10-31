Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179F5606A329
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 22:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=OT5mxxVn;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hdZokYLc
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EAA0740506;
	Mon,  2 Nov 2026 22:32:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cceHE17VvC5n; Mon,  2 Nov 2026 22:32:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 29B744051F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793658773;
	b=VByGVbQDZtCwMDsj14lMANP8SgURCdkOqHlozytJMqqq+lZLBYx5jKOS+a1W0EBgb7PL
	 wk6vzLfW8k639/EFARgHryc1zG4c9FpTcoOEKlgn3dHJCr18Oki0RjjzEn/PvSKXCs0p2
	 9Itb3F7p8tq6tL9+QXF2qII8Es+NdJic3oeYfv3Hxi4mH62uqNo7DkVhYpVUFdzuNBYV6
	 4lARd/7GC8AJCeQcfx3R1f76iQjWcERohBNulOJ8UtuX18N5mxwRA70LPOchi88upT7pS
	 SSgcvy4L22KPosvsMVIfjtJc1XI7ExmLH34aLYNEJl2TF/4uJdL0FLdmoQlcvgSpypQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793658773;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=29lzrQDKQhJkd273yOHGbx0kds4ErzcM/57QFd0LIGI=;
	b=Hl616rkvwP/6r8vbt/pR32U6RIlo2KStiyZXFbXY30Xs31vCKVoJhbaUucy+eiZXVPEW
	 6LG/xjxqgE3P88OdzIoQsE7IH+cHW5y1OSgVfzhcDDeSJVuwX6Xq3hjdDYIWSrEjh2IRW
	 w2qU9qiouCp5X0HUmVrGqSeg/mpGMkrOjOBF9dJRK5aU2EdYicNFbLdmS9KXDGq09wX2o
	 +0RBRAvNbXItfTaKMDMegWLYXT+G+OdBVa1l7A3m420pz4KTfsLDZ3/4BHGOOEmkkBBsR
	 9A+p5JtyL8pA0u5kkHFBZHxnhU565OR1iwusqOl5zNAobQ2Q4Lt/vDOzlILo7XwZK2w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793658773;
	bh=29lzrQDKQhJkd273yOHGbx0kds4ErzcM/57QFd0LIGI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OT5mxxVn9FrKwBxS5hyb1LEwZViODjcjgZKMaHlqP45l46BTLNTUOdcAQKC9yk856
	 KpnvY3YHtfyaDg5BYClbh3dd5n0su3wXkPQdtieSZohM4wUDgkkaI+PKjg+Eytc/Kx
	 RkFB+SHGfE3/4G2KdA1edwAnomVlYHYid8chh8y4tFtArFqelXh69VL0qWeaPKjB0n
	 SC+ISc5ZtV/flGZ7ZANKJnBTd8TRaSkikEVXQgPA5DO1Blrw/8flC8heCDiSXouXAm
	 FlmkJ3In7WRjHj44wIAxufoa78VH5Z0Kv6pAdTIOV7vycO5WVQhm1K6gGsYek48grX
	 Y8G8N1DVw39Fg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 29B744051F;
	Mon,  2 Nov 2026 22:32:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E2A0D32A
 for <intel-wired-lan@lists.osuosl.org>; Sat, 31 Oct 2026 02:26:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D406E8110E
 for <intel-wired-lan@lists.osuosl.org>; Sat, 31 Oct 2026 02:26:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JLxB4ACGyDt8 for <intel-wired-lan@lists.osuosl.org>;
 Sat, 31 Oct 2026 02:26:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 500BA81100
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793413618;
 b=IKoTSsCPNBx2+dQtkQcdZlkf7heQeClhHsHUvPN5Znx+D6h5QpC+OZF6szA+qJqGTbS9
 X8hslDOllFMQXfu+PrlBVFjSE9RYLVS5whzDhUUEhLaayyhxgXHSa5vYXSWq+vx3vtvd0
 x+8xIZ6X0MgROILHrNCph4rCwMrXqOrVeiZ53lVbJTFbgpVa1IyvnTO6nnqM1DAayHepS
 tkSqK3kRSWvbn+PybA5/SKiqa7CNt6Jxo1gvL6/j1kq08UapUqWsfEtQZgjtpJaELSwLi
 mphraXxkGzA3ctSaX4gMvQ519OKvhOkH5Q/AITD70sVvGCw2cUqItRFg9lHisyAt2oA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793413618;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=29lzrQDKQhJkd273yOHGbx0kds4ErzcM/57QFd0LIGI=;
 b=lf9IzR9/jdTXR7xFEmjydMU5EbSIRVHMw+gFQjtpPJ2RLvRYp/PIiXKy0kkkblIR7qaA
 rkYpSgDhNhi2CGyBS1lUtiWLiaTVX+r2lTsQC+sOdYpu8HHcoUODTJEmPWxVOBPf7DJdZ
 Cu5DhUohOdsiUGz9Th4BJpN0wolu+g9PrCkJXm432rhnPK0zrIfTO4/1jVJcytrD7oexf
 lSwC07/q0pI8uMdz/qAkpqoDLX8DgCFtsqNPLdwuYtqPCTAX+PU/Q0eZXgbTVuGy95YAu
 uz1P2JMeGWJ1oR5kPj62OoqLUNQVJJfkOmAsK6gvm16a7olGJYnVGX/OYK/fPdjAYzA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=hdZokYLc; 
 arc=none smtp.remote-ip=192.198.163.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=yifan2.li@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=hdZokYLc
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 500BA81100
 for <intel-wired-lan@lists.osuosl.org>; Sat, 31 Oct 2026 02:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793413618; x=1824949618;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=BycSqTNFSvvJvts+gcHeLU/qGm1sRGULL4Af3Kj5hw0=;
 b=hdZokYLcLiATrhXWZhr/AZ7bVLgizAmKvfYBYW3e8PSvgVftypXUJSUS
 87ggaOR7e9FMfTa/abC2vvAmc6+O4wGvL7SnJc2nf/8Sjq1dENFtEbthG
 cgySK5x2JENDue3mqnaN0hD+PQU+r4qfYgVtKsFncls2957girZVA72tO
 rwkWhUQeUnhktTOg8ZtdVs/jxcKKpmersQeEqPrpNRo1ER0nsxD5wBM6C
 McniByWLM4p77NcIdl4AoLLaKidaBj/2keBRY3A8/AGAQuQcC8ImKhD7Q
 7zC2KmEiJ/STn8gVXHXxBKC7nRoVs7l2j9zG+tU4IBW6OYQZTDy7k2vDg Q==;
X-CSE-ConnectionGUID: FJgmo2JlSSm6trWZUkozsQ==
X-CSE-MsgGUID: pTMDMLE+QCK2HFRKd/zL/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2186559"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2186559"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 19:26:56 -0700
X-CSE-ConnectionGUID: vx2Kve73R0S6Cyy0HVnGxg==
X-CSE-MsgGUID: x6pKkIznRuKREOvxK1IfTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5476450"
Received: from liyifan1-desk.bj.intel.com ([10.238.152.46])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 19:26:54 -0700
From: Li Yifan <yifan2.li@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Dima Ruinskiy <dima.ruinskiy@intel.com>, Li Lili <lili.li@intel.com>,
 Wang Jie <jie.wang@intel.com>
Subject: [PATCH iwl-net] igc: Disable PTM after the last device reset on remove
Date: Sat, 31 Oct 2026 10:19:28 +0800
Message-ID: <20261031021928.1714612-1-yifan2.li@intel.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 02 Nov 2026 22:32:42 +0000
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I225/I226 have a hardware issue: after a PTM dialog, the next device
reset through the RST bit of the Device Control register (CTRL.RST)
can make the device send a PTM Request. The device sends it even if
PTM is disabled in its PTM Control register (PCI config space), the EN
bit of its PTM_CTRL register (MMIO) is clear and Bus Master Enable is
clear, so the driver cannot stop it. Commit c080fe262f9e ("igc: Fix
possible system crash when loading module") disables PTM before bus
mastering because of a related issue (PTM Requests with bus mastering
disabled), but that does not stop the request at CTRL.RST.

The request is harmless while the upstream port has PTM enabled. Since
commit e1092d5e15e6 ("PCI/PTM: Do not enable PTM automatically for Root
and Switch Upstream Ports"), pci_disable_ptm() also disables PTM on the
upstream port when the last user goes away. igc_remove() calls
pci_disable_ptm() before unregister_netdev(). If the interface is up,
unregister_netdev() then resets the device through igc_close() ->
igc_down() -> igc_reset(). The upstream port now handles the PTM
Request as an Unsupported Request. On an Intel Nova Lake-S system with
an I226-LM, this triggers DPC on "modprobe -r igc". Recovery fails
because the driver is unbinding, and the next probe fails:

  pcieport 0000:80:1d.0: DPC: containment event, status:0x1f01: unmasked uncorrectable error detected
  pcieport 0000:80:1d.0:    [20] UnsupReq               (First)
  pcieport 0000:80:1d.0: AER:   TLP Header: 0x34000000 0x81000052 0x00000000 0x00000000

Message code 0x52 in the TLP header is a PTM Request from 81:00.0.

Reset the device while the upstream port still has PTM enabled, so
that the PTM Request gets a response. Then disable PTM and bus
mastering. With this order, a later reset sends no PTM Request (tested
on I226-LM). igc_ptp_stop() has already cleared IGC_PTP_ENABLED, so no
new PTM dialog starts after this reset. If the interface is down,
unregister_netdev() does not reset the device, so reset it explicitly.
PTM is still disabled before bus mastering, as the related fix above
requires.

Skip the reset if the device cannot respond: error recovery is in
progress or has failed (pci_channel_offline()), the device is gone
(pci_device_is_present()), or igc_rd32() has already reported "PCIe
link lost" (IGC_REMOVED()). Otherwise the reset accesses a device in
error recovery, or polls all-ones register values for about two
seconds until igc_disable_pcie_master() times out.

Call pci_disable_ptm() only if PTM is enabled. pci_enable_ptm() can
fail in probe, for example if the upstream port does not support
PTM, and probe continues without PTM. The PCI/PTM change above
also made pci_disable_ptm() use a reference count: it decrements
dev->ptm_enable_cnt without a check, and then does the same for the
upstream port. Before, it did nothing if PTM was not enabled. After
a failed pci_enable_ptm(), the count of the device becomes negative
and stays negative after the driver unbinds. pcie_ptm_enabled()
returns true for a negative count, so after the next probe
igc_is_crosststamp_supported() reports PTM support and igc_ptp_reset()
starts PTM cycles on a device that does not have PTM enabled. Commit
650f197d8ea6 ("idpf: disable PTM on probe failure and on remove")
adds the same check to idpf.

Fixes: e1092d5e15e6 ("PCI/PTM: Do not enable PTM automatically for Root and Switch Upstream Ports")
Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Co-developed-by: Li Lili <lili.li@intel.com>
Signed-off-by: Li Lili <lili.li@intel.com>
Signed-off-by: Li Yifan <yifan2.li@intel.com>
Tested-by: Wang Jie <jie.wang@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index b8ac2f4fea5a..3ee8b05f0515 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7406,9 +7406,6 @@ static void igc_remove(struct pci_dev *pdev)
 
 	igc_ptp_stop(adapter);
 
-	pci_disable_ptm(pdev);
-	pci_clear_master(pdev);
-
 	set_bit(__IGC_DOWN, &adapter->state);
 
 	timer_delete_sync(&adapter->watchdog_timer);
@@ -7427,6 +7424,22 @@ static void igc_remove(struct pci_dev *pdev)
 	igc_release_hw_control(adapter);
 	unregister_netdev(netdev);
 
+	/* After a PTM dialog, I225/I226 can send a PTM Request at the next
+	 * CTRL.RST, even with PTM and bus mastering disabled on the device.
+	 * Reset the device while PTM is still enabled on the upstream port,
+	 * so that the request gets a response. unregister_netdev() resets the
+	 * device only if the interface was up. Skip the reset if the device
+	 * cannot respond (error recovery, surprise removal or an earlier
+	 * "PCIe link lost"). Then disable PTM before bus mastering.
+	 */
+	if (!pci_channel_offline(pdev) && pci_device_is_present(pdev) &&
+	    !IGC_REMOVED(adapter->hw.hw_addr))
+		adapter->hw.mac.ops.reset_hw(&adapter->hw);
+
+	if (pcie_ptm_enabled(pdev))
+		pci_disable_ptm(pdev);
+	pci_clear_master(pdev);
+
 	igc_clear_interrupt_scheme(adapter);
 	pci_iounmap(pdev, adapter->io_addr);
 	pci_release_mem_regions(pdev);

base-commit: c550c1c9727726dcae121221c252013153fa5945
-- 
2.43.0

