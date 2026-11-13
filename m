Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD26606E1E6
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Nov 2026 17:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Wam++SV2;
	dkim=pass (1024-bit key, unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=I1JA5P5q
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 19E338156A;
	Fri, 13 Nov 2026 17:00:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FW2cN3jCHw9P; Fri, 13 Nov 2026 17:00:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F3DB381360
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794589248;
	b=JgZGkSv4pwAQ+moJPUzL1Bg/YSYgynwNEUymoWkRA3GqXweWDVsP+VjG2OWVj501LpHn
	 z5+NcAtPRzdCQIqjhaznBQVna/Y6q0BblPqT0FRTM2PFWf9bZE0DOVBmlLb/b7Ise9Iz4
	 bxFVEr4Lslmg1crGUuQ3zEEinrFoX5UzLQFm6w/WKIbtOpxn5bb1C/6iIM55CELVod06O
	 opyi/Ej/Ph6rJKl6+2sHb823fU7Nkl1N1wgJkNcp/cJAkJURNRlxeCd8jQu3EAqwp5i1W
	 52nTRHQ8B7HeJirifEBP8BG67NM1lxKctyVYW9R/a6LhrdA0wzMpULk6Jvwv9L4X52w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794589248;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:DKIM-Signature:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ev+Xl72+1OCLuwasUtviXG9+6wDTgYoAYsCBeKV+34I=;
	b=GJWaDyn7zykr0jmPdHbd2KMfjX4uHvIe12S4Xuw26FiNh3jMUVCUSbZMzPRgIInnebTK
	 EuTaa0qAk/nFv7SMsYVGg2gtbEPZgrv16pC4/m23O+UDI19jpSzmc/eDkYFAMQFNCCTmQ
	 MKN0FQKsl4ntd0xK6o/8kSir7t1Z0K4ys1QygkIumFNdiTyXizXFSNOujD/3VnY4hqrLG
	 dsTlcpkK70FDjyONiXO9VPDpKhYCnZpWF46wt4gsdKDIdCrP5F07ORU5OZJyUhascka5n
	 tTFUvonlARaAxnva2j7198XVqP/S9hN+zsUNVW1xvKgHfMGb1XdSHntpj6+JDSEgvbA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794589248;
	bh=ev+Xl72+1OCLuwasUtviXG9+6wDTgYoAYsCBeKV+34I=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Wam++SV2kGo1wE66YDmQ+C87CPbND0NFEW4Z1hSQ4Tbji3U8K36+tv4Vt65Sc3MQ0
	 1/3cQvXLqa2HeXFe4f0yRTxcIxCW01dUHrzptoZxI/Q9rebNe8Zph1xxKJgCCgXjkt
	 yis/FATd+kd/DLLiDYlWZhmhMePlvPEETRgC3XRtZoxjV/f6mqf6RFY1f9coLt8gkB
	 Lwr9JAHzjTZqonQaeUeAqkV9w/m4mE88TtgyIEgIcl6l9EBrt5/REMwkzrbtdzVzY9
	 5PKjwbFPbQmxDC4YyvG65I03y01VJionAIHjtT/e4eAFbJyhX21uM+9CFID6K/2Hi7
	 kv2jxeq/rku+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F3DB381360;
	Fri, 13 Nov 2026 17:00:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D50362FE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 14:22:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BACE760B0C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 14:22:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7ca10iyv6ILi for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Nov 2026 14:22:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 86BB5607F7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=101.71.155.101
X-Greylist: delayed 308 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 13 Nov 2026 14:22:22 UTC
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=mail.sdu.edu.cn
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn
 header.a=rsa-sha256 header.s=default header.b=I1JA5P5q
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=101.71.155.101;
 helo=mail-m155101.qiye.163.com; envelope-from=liguangshuo@mail.sdu.edu.cn;
 receiver=<UNKNOWN> 
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com
 [101.71.155.101])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 86BB5607F7
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 14:22:21 +0000 (UTC)
Received: from lgs.. (unknown [101.76.249.61])
 by smtp.qiye.163.com (Hmail) with ESMTP id 549b5a83e;
 Fri, 13 Nov 2026 22:17:05 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH net] iavf: Fix potential QoS capabilities leak on removal
Date: Fri, 13 Nov 2026 22:17:04 +0800
Message-ID: <20261113-4e14e563a1-net-iavf@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1d544e98d03a1kunm647ab2784891f
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTUJNVh8ZSksaTU5MTx8YH1YeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
 NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
 b=I1JA5P5qmnbqbrfRDiLxoEbIBviJDrid741fAgSv/KcQjU0cXX2wAPCKE55hKZRbuw6P37kLYmHuzBHL3h1WXSuJBOUSkCKDPNcmsjiuUYYt9nTmAcuQHNSYPYpTKYgCH+LVKblxSB2OrZ/SxaltCxYRfCZe3dMXLsWuSmd2vzM=;
 c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1; 
 bh=ev+Xl72+1OCLuwasUtviXG9+6wDTgYoAYsCBeKV+34I=;
 h=date:mime-version:subject:message-id:from;
X-Mailman-Approved-At: Fri, 13 Nov 2026 17:00:43 +0000
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Probe allocates qos_caps separately from the netdev. Remove frees the
netdev without releasing this allocation.

Free the capabilities after the workqueue is drained and before freeing
the netdev.

This issue was found by our static analysis tool under development.

Fixes: 4c1a457cb8b0 ("iavf: add support to exchange qos capabilities")
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 2f8a80a11336..a2e7bc4cba88 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -5680,6 +5680,7 @@ static void iavf_remove(struct pci_dev *pdev)
 
 	pci_set_drvdata(pdev, NULL);
 
+	kfree(adapter->qos_caps);
 	free_netdev(netdev);
 
 	pci_disable_device(pdev);

base-commit: 2e54b3e187300893688c2c7517894f5d96732e05
