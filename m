Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B64FCCA5FE6
	for <intel-wired-lan@archiver.kernel.org>; Sun,  4 Oct 2026 11:44:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 653B36061C;
	Sun,  4 Oct 2026 11:44:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z2gFoBQo6mUm; Sun,  4 Oct 2026 11:44:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B45E16060E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791114254;
	b=ZaL5WMQNIxVkOAXtKt1/p1um0KXszTQfTrhrCXEK2vSaxINDBFBbzEY7hk4JLSlfMuNr
	 Lf8PGN+ztttHP5DiMigs8C0j+4eb2wFjluwP77CUVxqPfLTzwctPJifKAhy6kxSXrBVfU
	 2DcVTt08v7+ocR106FWHXj08HgYMEi4FRtitGYq44cJ3WUeByVijwJ7nFweULKDqBrOjS
	 lSUND3rRrIGwmusoRLo6+Sfb1Na513RXeNI6mS5Vm2lNvWom71qQzC0RK3FQBiQG+dLOb
	 GkqZ6ycI/0+Id6JxVb1hAEsNsZEERMvfIs/BnxqDLZ0A9dtCcLH2ITTnWFgAxYJjdkA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791114254;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=VrC8MipqRMsjFleiMybcQkY+76/LuM2Mw14J4Ebzgz4=;
	b=WZyRd+hy/Dnv0vM+z8V03jhOwTJjlU+21YSKWnBCOzSyD1tbML/H5ntD9j3JUwPbwNuv
	 cTmd6sdrMQCiLWtb4poinPLKPMFZGjfbuwjrM8DGZzyS0gNKMmrL4krYCN3u0ALBpoqck
	 7tk6ftP5BpXuSnlD1/eEBbBOe9WEmCj6Oe2K8+QXXkiQusrEZNwwfyTbzkxpdHxhXMGG6
	 baj4cxpNsjQby2a+DI2zrtdEbYqbt0cQqV2sjbIN8lk8ECZK+kCKWLbar87YceIaR3pxZ
	 I+dJnM/fsDAdeTiVwjtLmmLEYHLgc6SJDfe9r/5efbt5+ZDf1astRbvtgUbq1hnEPbg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791114254;
	bh=VrC8MipqRMsjFleiMybcQkY+76/LuM2Mw14J4Ebzgz4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=h8BpsSVVSGiH18vSlFxzoBDtyyZ1C8u+FUBIVVY9OrLDl+rzle4OOlglovEp4uaD7
	 xdqvhFAaVM7vq71tiyhfdMKRCpranyyKgDB2apOK9ILSVj/WjrALdSBI8zU78Tm5GI
	 PmPoBcofLpXmUtAY9+XWZhEXX37129/OBOrZvtc+fp5/Ox0ufy3ABzT5VGe+qwj5pR
	 hbRJw2swBdU+k37r4AKuOSS6aQFrqgCZbKqCFsTl2L0Z60K0lhrUWiK33chtZWXi0n
	 4wAZZMaBPPOjVEkqzxVpLIn9qZbeFKgZMkRxrk7E7JnlmuQWBfBh1REPX0ft5rqoTz
	 S5Uz6cPWqheyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B45E16060E;
	Sun,  4 Oct 2026 11:44:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C4DF5263
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Oct 2026 11:44:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AAA6C80DBA
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Oct 2026 11:44:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MPdfHEkm7RpM for <intel-wired-lan@lists.osuosl.org>;
 Sun,  4 Oct 2026 11:44:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7AD0A80DB9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791114250;
 b=kLLlLvrq2Z3B4YFt1j2VJUHoqWyyw/UThYg1EYEPMMufma/GH+fJ4HF7zuCp73y5N1fj
 JAav62goEUldVBrQ/VzW8vu5UsuATU3z/IyxeU+KMGh/Tf8yIDLNxguPWo1nNT/8BRa5c
 a7kSh9JFJ2S87qOk7dpDgXRWaGi4wUze8uUrGbRe3qknCzh15bubpwmUVfONjweNbKVhK
 iSjmGBacOBHgB5GerL4C2cpAOl84Go8eG1OQy0CSf/yXQa8A/CV8DJXuLX29Q1wQ8GFFl
 ArtP3xhiwiabzACnMcv+NKTY1pMmsBOekLW7+eRRBa8QmaQWZLC8XmHu+y39OS/sNiw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791114250;
 h=Received-SPF:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
 MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
 X-HM-Spam-Status:DKIM-Signature;
 bh=VrC8MipqRMsjFleiMybcQkY+76/LuM2Mw14J4Ebzgz4=;
 b=AR9fUgEJ5686sK9lGRhxJdyyF9d9vyIGOScffXJiM6z4Y2YiZYGtLBCCK7snFO2g2TT7
 coO6RfBVHwHsKoGQCkbDN/G6W7Nl+kXOMXKBg92am2WB2yVumcCmiRYLKGLmrGQknZpBD
 8wINWTOWCQCF+r3+65Xo7m2YzWi+wDADbTOKtW4ORkfmp3IxVO/mENQDJLgboN8gmHIAa
 K4vWn3mA4vnWlW4/fFSeQTAuRSXXkxDcU10VTQiGWIeEAz9BYZ11AUOtEZz0do0aiPddx
 31cYwUlKicqpXADhfTX6nUeX9I3gDrPhp9Ds1fqxlByvmgKm3Vk7m6zMZiEEG/kKUrQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=seu.edu.cn; 
 dkim=pass header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256
 header.s=default header.b=ZR7w4QNf; 
 arc=none smtp.remote-ip=45.254.49.198
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.254.49.198;
 helo=mail-m49198.qiye.163.com; envelope-from=runyu.xiao@seu.edu.cn;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256
 header.s=default header.b=ZR7w4QNf
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com
 [45.254.49.198])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7AD0A80DB9
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Oct 2026 11:44:05 +0000 (UTC)
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4fec266b1;
 Sun, 4 Oct 2026 19:43:59 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
 Matthew Vick <matthew.vick@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Runyu Xiao <runyu.xiao@seu.edu.cn>,
 Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH net] net: fm10k: shut down the service timer during removal
Date: Sun,  4 Oct 2026 19:43:52 +0800
Message-Id: <20261004114352.1232745-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa106ba5e1703a1kunm59abddd933b26d
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaHh1MVh0aQ0hNGRgYSUhMTlYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
 xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=ZR7w4QNfR/layPI4kuciqtPreg6ByWjPLtStUW8+dDHRfx26MpBDihhNSxVkuLRISKVnj/1G+13WlUI7Bz6SpXV/eGFlmT+n/FcKUcB+Zst9EPwsq1gmEbKFPXuqC94WP5dJLlHwaEqMWNpqLGSWfmjbHztLpG8bu9RlqJkvOC4=;
 c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1; 
 bh=VrC8MipqRMsjFleiMybcQkY+76/LuM2Mw14J4Ebzgz4=;
 h=date:mime-version:subject:message-id:from;
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

The fm10k service timer rearms itself from its callback. During PCI
removal, timer_delete_sync() waits for a running callback but does not
prevent a callback or another service path from rearming the timer. This
can leave the timer referencing the fm10k_intfc after free_netdev().

Use timer_shutdown_sync() to permanently prevent rearming before teardown
continues.

The issue was identified by code inspection. No runtime reproduction or
trace demonstrating the failure is available.

The patch was not tested on real hardware. No hardware- or
firmware-specific runtime result is available. Validation used source
review and available build or emulation checks.

Fixes: 54b3c9cfad6b ("fm10k: start service timer on probe")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index f5b4d0627..836664cfd 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -2245,7 +2245,7 @@ static void fm10k_remove(struct pci_dev *pdev)
 	struct fm10k_intfc *interface = pci_get_drvdata(pdev);
 	struct net_device *netdev = interface->netdev;
 
-	timer_delete_sync(&interface->service_timer);
+	timer_shutdown_sync(&interface->service_timer);
 
 	fm10k_stop_service_event(interface);
 	fm10k_stop_macvlan_task(interface);
-- 
2.34.1
