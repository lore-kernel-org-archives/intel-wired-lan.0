Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9700C48297
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Feb 2024 14:04:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 741C261162;
	Tue,  6 Feb 2024 14:04:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 741C261162
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1707228289;
	bh=z/M/WwmGUvtmKpZSZnWHOmFWw5R+K2qMdURhljnGxJs=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=jpxN9AQc0fAkQainLiD0EuRXztDeV3pooAnNDHCIf1MCoi+z+AyBYQQL8Kvfs/1sq
	 98z4vAmIssxM0JPVNwOjdBoHCJCm0lVvIet2EH+WNtfrZ4WkwVHJxYA7v+YdkaYIJu
	 kf8HqzOXTI+XmhbruiyEAc/KM32S5l6R92Ekv6+sn3UW5tcSluMuf9eO2s9HLXUQ9q
	 OP6dnBLa5KZShMQ5kFAhk/obKisOg21HIuEKhHZ+3nrgeZKcjmc7aZ7lZe6ECTgCy1
	 flT3DnCuPEH8nAhiQlXySsybXBEZSgYgbYNDpb8Yq8JFk1fS0/6webUEXytvRhb9rv
	 z0PkTLCtu4Liw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0RRaLVwSww5W; Tue,  6 Feb 2024 14:04:49 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id B027F611AD;
	Tue,  6 Feb 2024 14:04:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B027F611AD
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id F32421BF576
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Feb 2024 14:04:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CA40D40B5B
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Feb 2024 14:04:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CA40D40B5B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tw3TzJUhdtNm for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Feb 2024 14:04:46 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EA407404D8
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Feb 2024 14:04:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EA407404D8
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="905192"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="905192"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2024 05:57:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="1008739"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost)
 ([10.246.36.139])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2024 05:57:34 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 "Oliver O'Halloran" <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Tue,  6 Feb 2024 15:57:14 +0200
Message-Id: <20240206135717.8565-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240206135717.8565-1-ilpo.jarvinen@linux.intel.com>
References: <20240206135717.8565-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1707228286; x=1738764286;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ra907z3zlnnpibGxKFs9lZMq1UE08Wke5uzxQlZ+qJU=;
 b=XEApLcWMdNjcy+PhBDugvvcQju92+/naJoL+uUslSYg6FS1o7ZcsejUO
 JtKalZw3Vdgw6EykdKWp1bjlVJbHiu6R3LuiOHleMK8V2lUJtNnTNm0YR
 FnYG9GE93iMYC1hrV5QfjaGY1GonFucs/4O09ezk9xn5HWnafLeatpfpi
 6rYWtMK5I0KUEIzZYymRDUZ1OCzYklrRtzgzdpbu3K/pZsVBIMHOMrQ9J
 KC+Lo/yO/MEe7q/ByGHk85isprNwdKtjiz2DDyjrHSrVPHWmeV20zkIxH
 qjWmNoVZ+ApKwhewbO7B0hAdcuJgiekZea9Nd2rGuLrh+v52GWqU2njdv
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=XEApLcWM
Subject: [Intel-wired-lan] [PATCH 1/4] PCI/AER: Cleanup register variable
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
Cc: linux-efi@vger.kernel.org, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ard Biesheuvel <ardb@kernel.org>, linux-edac@vger.kernel.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Use u32 for PCIe Capability register variable and name it aercc
(Advanced Error Capabilities and Control register, PCIe r6.1 sec
7.8.4.7) instead of temp.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pcie/aer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 05fc30bb5134..e31e6a9a7773 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1210,7 +1210,7 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 {
 	int type = pci_pcie_type(dev);
 	int aer = dev->aer_cap;
-	int temp;
+	u32 aercc;
 
 	/* Must reset in this function */
 	info->status = 0;
@@ -1241,8 +1241,8 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 			return 0;
 
 		/* Get First Error Pointer */
-		pci_read_config_dword(dev, aer + PCI_ERR_CAP, &temp);
-		info->first_error = PCI_ERR_CAP_FEP(temp);
+		pci_read_config_dword(dev, aer + PCI_ERR_CAP, &aercc);
+		info->first_error = PCI_ERR_CAP_FEP(aercc);
 
 		if (info->status & AER_LOG_TLP_MASKS) {
 			info->tlp_header_valid = 1;
-- 
2.39.2

