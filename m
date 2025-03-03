Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A69C282CD
	for <intel-wired-lan@archiver.kernel.org>; Mon,  3 Mar 2025 20:48:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 18EF460A90;
	Mon,  3 Mar 2025 20:48:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cvRS4Dj0mCDH; Mon,  3 Mar 2025 20:48:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CEC1A608D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1741034904;
	bh=fgSaLk7w7tBXl30fyHTRaDLylIq/PN9uL/1guvPWn+0=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=J3NV8tyWMoQ0M8QzVlwCKI480jf8CArP9KtkGewg8zn3FvDbYjj0azrZVdIoGc3C4
	 wXd7Rj+GCnw8pfNdKCtCW/rSNPclTsI/8jiHwusr3hRCyVPZictnHOaYLUpK6R19Ro
	 K46D5hLBNDIZNYkUvB31C66GKeiDdaAhIvZI7lpluAeZNS3ayzvRuOgTfe/66YNJ5c
	 vNjxPoaBSdXrAC5ipgMdeVYQjV2g6wVGcJcknh+QCYEZDlM7IXok1Hq8qOfYOO90Dv
	 nXso/F/PO8GqGS+ffjaQZ63webIyaseX/iOJgGX3hDhd57mzW7T+zKlshUL/VeMEUE
	 LWmjy+BIK7yCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CEC1A608D3;
	Mon,  3 Mar 2025 20:48:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C4D2944
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Mar 2025 20:48:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CA25081DA3
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Mar 2025 20:48:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gJlXM2UIFimU for <intel-wired-lan@lists.osuosl.org>;
 Mon,  3 Mar 2025 20:48:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com;
 envelope-from=joaoboni017@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2B35581DAB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2B35581DAB
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2B35581DAB
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Mar 2025 20:48:19 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22356471820so78192275ad.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 03 Mar 2025 12:48:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741034898; x=1741639698;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fgSaLk7w7tBXl30fyHTRaDLylIq/PN9uL/1guvPWn+0=;
 b=vWsVK4KQHGlq/ijZkjlpN1JJ4wKbDR1CH2BYEfNDdNeT7vlb3LtpkkxHfwyGGzhbdL
 M5G+riCN9W+9Pz1OsMJ8343jxSYGxGhtnQcrBmfaNDoaGK/ggWoKLh8ByGcGVDPwdMAt
 K8puGx0/zIQW3bLBRh/qC1yaZHPzIKGEOKcKNYHYepT2IniK/xBqK1lmW53psv2jEMPc
 PQk+EuMpd5rRaImv8ubYuEuh6IvBytfOHIQalQdQcqK5+z6yjSNFJA7v1TSirNx+1oHd
 pFy1UNcDq2urUED3aCcHHJ3bG7FzNAkw5ma8B/pPbboE1grc0GxMsgNCMXtIWsIzU9LI
 ILUw==
X-Gm-Message-State: AOJu0YyjcuI08lpXBjeLMjFjOfm5o1x9rZnkupo2LTkYCnWXJDaMkRa/
 8l840QY7dNt7oCXzSKD1bfBamrFZYkm2s7ZCSR7M12SNFAci3d+a
X-Gm-Gg: ASbGnctRJCqfjfFWRNvG78jZLz8fPWpRkn+sqRGp7eNu1cDEo42M9mFcMLmXXuz+bSa
 bike2rqcE91PKNRnUAJJe7HSC0Q2WvurCNmn/SyP9d9iuA+Gh7BTclN0cJRxWQ4p+CR8BI39/Qs
 pnnSOywCX+Mw+ohhSP18QIn+AwOQMgXOAPs2OSaEJzKKfLEkCQ/dhH7Afr9KrMFcr4dN9l1L/lY
 v+5DLl0EWiZmGKqAR8uLooXcOJ/4TR9hdJoneUhVu/YVV05X3l+QBNAPA8hGY8uKtlXPsfxREXs
 hw8rY4jRgx+rQ93yt0Tsz7flOWGCZCBvvwn2rYZVqA==
X-Google-Smtp-Source: AGHT+IFFbWklKfcQH/W60SbIzSpV4g5GMRMFfXwE9Du0RkkNIXoYmwwSm6kOFMotBdBvzzH/0uHXGA==
X-Received: by 2002:a17:90b:48c2:b0:2f9:c139:b61f with SMTP id
 98e67ed59e1d1-2febab3c710mr24244355a91.14.1741034898455; 
 Mon, 03 Mar 2025 12:48:18 -0800 (PST)
Received: from fedora.. ([186.220.38.89]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea676c4dcsm10501722a91.17.2025.03.03.12.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 12:48:18 -0800 (PST)
From: joaomboni <joaoboni017@gmail.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, joaomboni <joaoboni017@gmail.com>
Date: Mon,  3 Mar 2025 17:47:50 -0300
Message-ID: <20250303204751.145171-1-joaoboni017@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741034898; x=1741639698; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fgSaLk7w7tBXl30fyHTRaDLylIq/PN9uL/1guvPWn+0=;
 b=BfnFe2KuOIBAzZ3Dbfk6ggsPNG1P7CaE1r5+lKwSVm+VqgTR8MpjTzHaR1jxGybB5c
 zvIHcS1dnIqfvNzpivvVUaZvNKjqco3prSmFBR9ZyB9dl5iqUU125SkvVsf+7cTdr70Q
 n/9zaaBcRz88ApIrpLmN8zGGtnUdW5eNqH5sVSbY4blQUXucA1yHhz6KTWbgarv7csc5
 iWqqKaKeXO6Dxc23VZHm9ahSsuyO3M+YMLravALJCxoX89RJkEYTcO/rSYaQEqnrDHiB
 X+x1cgjfwMbCKu/aH9Eft/EwkHOdLxagfLe6RnnUTNMwcLNHHDlF43106nOi2Euvdkkd
 ZnFA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=BfnFe2Ku
Subject: [Intel-wired-lan] [PATCH v2] e1000: The 'const' qualifier has been
 added where applicable to enhance code safety and prevent unintended
 modifications.
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

Signed-off-by: Joao Bonifacio <joaoboni017@gmail.com>
---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 3f089c3d47b2..96bc85f09aaf 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -9,7 +9,7 @@
 #include <linux/if_vlan.h>
 
 char e1000_driver_name[] = "e1000";
-static char e1000_driver_string[] = "Intel(R) PRO/1000 Network Driver";
+static const char e1000_driver_string[] = "Intel(R) PRO/1000 Network Driver";
 static const char e1000_copyright[] = "Copyright (c) 1999-2006 Intel Corporation.";
 
 /* e1000_pci_tbl - PCI Device ID Table
-- 
2.48.1

