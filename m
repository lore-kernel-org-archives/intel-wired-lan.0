Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8AC3C83F1A
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Jul 2025 20:05:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 76ADA40F1D;
	Tue, 22 Jul 2025 20:05:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V4cFcBxfRPRf; Tue, 22 Jul 2025 20:05:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C5E514107C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1753214735;
	bh=6sERjD6jRxVPFU4WDB/cZWcKsKQv9Te3TVp93YbIgTs=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZIC88exPktbboikMBAKeAy4hWsq4I4Qj5YTlDSnLbqqoeujRB4eIXK5N6P8XbUsK4
	 EDf3fPeVQeYQdyIlteWcfUxlg91Mr6ZAA/0XAV7DaoYPd++pJgkGbnMX3mwSSzzQdC
	 5EtfiqemWPRbyJDcobR31nozhUPFBni4wIyPlM5toDmeCHzznw3vEJ6/YzGstYQasq
	 zBexBizjGT0oTayX7UhjBHznIuoLt2kiU7o+xSiESZFjhCmOnUUNjgVfBhaVRUXf6D
	 /8LDuylkKjDTEkAO31s0vh8zjpsf2sKWWmK7CXFiHLePD8QL910+EJhAFvx/kME9qY
	 d9qH0PaEhAxmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C5E514107C;
	Tue, 22 Jul 2025 20:05:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B57D7E0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Jul 2025 20:05:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B2CFF41007
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Jul 2025 20:05:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LOQoJqa68DAR for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Jul 2025 20:05:33 +0000 (UTC)
X-Greylist: delayed 860 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 22 Jul 2025 20:05:32 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B3DEE40F1D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B3DEE40F1D
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.177.150.13;
 helo=mail.valdk.tel; envelope-from=iam@valdikss.org.ru; receiver=<UNKNOWN> 
Received: from mail.valdk.tel (mail.valdk.tel [185.177.150.13])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B3DEE40F1D
 for <intel-wired-lan@osuosl.org>; Tue, 22 Jul 2025 20:05:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7FF8E1B54DF9; Tue, 22 Jul 2025 23:05:28 +0300 (MSK)
From: ValdikSS <iam@valdikss.org.ru>
To: intel-wired-lan@osuosl.org
Cc: vitaly.lifshits@intel.com,
	ValdikSS <iam@valdikss.org.ru>
Date: Tue, 22 Jul 2025 23:04:48 +0300
Message-ID: <20250722200448.14963-1-iam@valdikss.org.ru>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=valdikss.org.ru; 
 s=msrv; t=1753214729; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=6sERjD6jRxVPFU4WDB/cZWcKsKQv9Te3TVp93YbIgTs=;
 b=vf5ISdOyaLzlwDq74/0FOqPH/hf4XOO/b5LUxstGmx0V4qsa8QDudVwgthr0cVRi8WXJ+3
 vJX40sEfZJWiij7gnwjZVA+OZ5HNrggUnmuZ6OKkpFjzMv8wHeVEyK3733iaqQ74NC4QMW
 X4ypqqs4ghYBKJtVYmNbJtaepR4EwdM7lWRrC1eszovSdJefNqjNweyKZT3q6wT61AEBEA
 3YG1xkEtc96Wrzbrh3yXF28lF0dFEQ0KZhJChhNk8g1IMyoLxdalfvu6GEqJ8rUri/tl8y
 s424SDa6zxRM54w+bIAIFek+F81hCP7czfEvof+mQgCZk5H/sgCuLdftF3I64A==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=valdikss.org.ru
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=valdikss.org.ru header.i=@valdikss.org.ru
 header.a=rsa-sha256 header.s=msrv header.b=vf5ISdOy
Subject: [Intel-wired-lan] [PATCH] igc: fix disabling L1.2 PCI-E link
 substate on I226
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

Device ID comparison in igc_is_device_id_i226 is performed before
the ID is set, resulting in always failing check.

Link: https://lore.kernel.org/intel-wired-lan/15248b4f-3271-42dd-8e35-02bfc92b25e1@intel.com
Signed-off-by: ValdikSS <iam@valdikss.org.ru>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 031c332f6..2df36373f 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7116,6 +7116,7 @@ static int igc_probe(struct pci_dev *pdev,
 	adapter->msg_enable = netif_msg_init(debug, DEFAULT_MSG_ENABLE);
 
 	/* Disable ASPM L1.2 on I226 devices to avoid packet loss */
+	hw->device_id = pdev->device;
 	if (igc_is_device_id_i226(hw))
 		pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);
 
@@ -7143,7 +7144,6 @@ static int igc_probe(struct pci_dev *pdev,
 
 	/* PCI config space info */
 	hw->vendor_id = pdev->vendor;
-	hw->device_id = pdev->device;
 	hw->revision_id = pdev->revision;
 	hw->subsystem_vendor_id = pdev->subsystem_vendor;
 	hw->subsystem_device_id = pdev->subsystem_device;
-- 
2.50.1

