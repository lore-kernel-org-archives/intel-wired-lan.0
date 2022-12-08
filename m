Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18227C4332F
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Dec 2022 21:11:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B61D60B50;
	Thu,  8 Dec 2022 21:11:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9B61D60B50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1670533910;
	bh=Mm+Gwtar+DqbpXqo0Kaws2VZUoKmiZ9hDrYLZShlvZc=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=XNBR/oSZ1VUWekEZChvhuwOhZMHzK4vz1P752MRARjfCO0lfOoSGW1a1rvT9tHFfP
	 n21/eAL3s9FoYIRxe8UlSXrF19YyXvCD4Jo8tcb5BqSrUvCGVlUtcrjHqqeV7YUGQj
	 hKiXBplHTYBupff1MTI2MrTP5ZXqv6/AJMZI3Ak9JzE9AyxBbgTBKykfqbHmBqjoai
	 TBNSdGpp+3G8YKmV/od4yUfI5spEvLaRa9T/kPhUFYc7GRX6FMAzjrSxSLwMKadVGS
	 J4rqkotEZGdY9pgaiFcyG4EOzD0jwicYc6xeR+cc/VktUEFtKgu9s4S+f0Tc1NWvg7
	 ee0fybG0Shb0w==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HHJR-H3V4FOG; Thu,  8 Dec 2022 21:11:49 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9567060B69;
	Thu,  8 Dec 2022 21:11:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9567060B69
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 903BF1BF396
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Dec 2022 21:11:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 77B11400FE
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Dec 2022 21:11:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 77B11400FE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CSCu6t-Bv0QS for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Dec 2022 21:11:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8E738400E7
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8E738400E7
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Dec 2022 21:11:30 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="304947457"
X-IronPort-AV: E=Sophos;i="5.96,228,1665471600"; d="scan'208";a="304947457"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2022 13:11:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="649318799"
X-IronPort-AV: E=Sophos;i="5.96,228,1665471600"; d="scan'208";a="649318799"
Received: from unknown (HELO anguy11-linux.jf.intel.com) ([10.166.241.12])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2022 13:11:28 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Thu,  8 Dec 2022 13:10:28 -0800
Message-Id: <20221208211028.824-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1670533890; x=1702069890;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=cZXavfOPtFpd/zWK6kVRee8tZC35rLh3h78rMcqiyoo=;
 b=S4dOqRwyVUB2p6UwhRpcAhMtjEyaOeieMwEJXHp3T09Oissf7yn9/BgB
 qSHFAkLptk2PWw/1zXeXsxMfgYHJbh/YPatGGTIYmksvSBGDM04SMgNBX
 Dy9QFNhhAf7tGjL/5Ls9FmaeZaCYLbFfh5m52AEVdcGpUBjgR6F9xK9UY
 V0080IUv/BRkrBOOf4tOmF9zh7m979s5TcbGSfrFt7jzdsygiYKCdyx/b
 NM+qsnz+ZwmmUfVBLQnBc6UVFPnwz2TazXELTo1Os4CHv0Zofg3YP5Sm1
 FE7658ioWD01af1v8rMTGnwMdzAwt/+M6mgNUEAjs1Wno3SeZKQ7Bgy5k
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=S4dOqRwy
Subject: [Intel-wired-lan] [PATCH net] igb: Initialize mailbox message for
 VF reset
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
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

When a MAC address is not assigned to the VF, that portion of the message
sent to the VF is not set. The memory, however, is allocated from the
stack meaning that information may be leaked to the VM. Initialize the
message buffer to 0 so that no information is passed to the VM in this
case.

Fixes: 6ddbc4cf1f4d ("igb: Indicate failure on vf reset for empty mac address")
Reported-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 97290fc0fddd..3c0c35ecea10 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -7525,7 +7525,7 @@ static void igb_vf_reset_msg(struct igb_adapter *adapter, u32 vf)
 {
 	struct e1000_hw *hw = &adapter->hw;
 	unsigned char *vf_mac = adapter->vf_data[vf].vf_mac_addresses;
-	u32 reg, msgbuf[3];
+	u32 reg, msgbuf[3] = {};
 	u8 *addr = (u8 *)(&msgbuf[1]);
 
 	/* process all the same items cleared in a function level reset */
-- 
2.35.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
