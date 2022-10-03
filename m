Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5649DC433F5
	for <intel-wired-lan@archiver.kernel.org>; Mon,  3 Oct 2022 08:23:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C525B4002A;
	Mon,  3 Oct 2022 08:23:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C525B4002A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1664785418;
	bh=NC34XtOx8KH+tQ4kGGrBDS/S6651EKOvbAx5F/4D/4s=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ofCSVQlrTVQ6GC5n8/ieoB5uJUx6mpcp4dQBI4pVesBBw9WMfjrQSelxNf1mwxq2w
	 H4ZRdMCTxBUPHgmQNGtpbEn1PZIeweWZvgnXSQdGlTnH0I1iIMMr6TXVwBiocHEtqQ
	 +Hx+q0nS5ZgLfOGhNqiS9ZYDhHF4mVL6ugV9V/pFYZSQeoG8QK6jR8B47ABIeHecyT
	 imNANdmxy5OsC6CZ2EkRqBGvTHHLqMOdyyVIIdwfuhm68LHkVCTN8aX6txwkkoJ5qQ
	 vL/ZtKVijdHFvBVT1aQK3lN+96PdwtRvPKOQgr4mzt9TFH9u6pjASfhHDLM/jcNHvu
	 QWGwxEqgGsJNA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IW0UUK6DO6YQ; Mon,  3 Oct 2022 08:23:37 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9537F40047;
	Mon,  3 Oct 2022 08:23:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9537F40047
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id E3CA11BF271
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Oct 2022 08:23:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BDA644044D
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Oct 2022 08:23:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BDA644044D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4MNdT-1CD7UU for <intel-wired-lan@lists.osuosl.org>;
 Mon,  3 Oct 2022 08:23:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 92E5E4040D
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 92E5E4040D
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Oct 2022 08:23:33 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="285713566"
X-IronPort-AV: E=Sophos;i="5.93,364,1654585200"; d="scan'208";a="285713566"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2022 01:23:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="691970773"
X-IronPort-AV: E=Sophos;i="5.93,364,1654585200"; d="scan'208";a="691970773"
Received: from s240.igk.intel.com (HELO s048.nql.local) ([10.102.18.202])
 by fmsmga004.fm.intel.com with ESMTP; 03 Oct 2022 01:23:31 -0700
From: Jan Sokolowski <jan.sokolowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Mon,  3 Oct 2022 10:26:15 +0200
Message-Id: <20221003082615.1870-1-jan.sokolowski@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1664785414; x=1696321414;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Jo+gNSas+ZqTdzzR78oPLB8cnrzwFpiqwBZUblVooIo=;
 b=UzUYxgZRozaa0nPcCjOKGYzNm5cBI1LkmaVFi2m9yC5+MuVU5FBEad3g
 oSsFt4PV4X1/yUh3Mc4HhHHH7+ZeNLoWuegspFMYO9Gmo6Lmh3zMiLCKG
 5RqXukcgN4PoXCUrno3CzhX1RhlSZJxaHEDG9OuY6hXgppDSwCL3BgKHN
 v7HEK3tN7uMir9YCU0mvBp68ynY6WhVTSL1miaT0EyNNJV93lVwaCU1nq
 Zdhxn/H1odqggvosMtjOoijhBpqs46/9+tu4QlI9c2RtiQ6ESlvN/2lsA
 n0s/qlv7Y2mtkbAa6e7TBmzGkWBFj3GgB/yjNKMdLG1dnHnOhdCfJEwJz
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=UzUYxgZR
Subject: [Intel-wired-lan] [PATCH net-next v1] ixgbevf: Add error messages
 on vlan error
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

From: "Sokolowski, Jan" <jan.sokolowski@intel.com>

ixgbevf did not provide an error in dmesg if VLAN
addition failed.

Add more descriptive failure messages in the kernel log.

Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
---
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c   | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 2f12fbe229c1..f1e5809f4d22 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -2044,12 +2044,16 @@ static int ixgbevf_vlan_rx_add_vid(struct net_device *netdev,
 
 	spin_unlock_bh(&adapter->mbx_lock);
 
-	/* translate error return types so error makes sense */
-	if (err == IXGBE_ERR_MBX)
-		return -EIO;
+	if (err) {
+		netdev_err(netdev, "VF could not set VLAN %d\n", vid);
+
+		/* translate error return types so error makes sense */
+		if (err == IXGBE_ERR_MBX)
+			return -EIO;
 
-	if (err == IXGBE_ERR_INVALID_ARGUMENT)
-		return -EACCES;
+		if (err == IXGBE_ERR_INVALID_ARGUMENT)
+			return -EACCES;
+	}
 
 	set_bit(vid, adapter->active_vlans);
 
@@ -2070,6 +2074,9 @@ static int ixgbevf_vlan_rx_kill_vid(struct net_device *netdev,
 
 	spin_unlock_bh(&adapter->mbx_lock);
 
+	if (err)
+		netdev_err(netdev, "Could not remove VLAN %d\n", vid);
+
 	clear_bit(vid, adapter->active_vlans);
 
 	return err;
-- 
2.31.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
