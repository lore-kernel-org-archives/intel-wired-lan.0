Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AEF606A31B
	for <intel-wired-lan@archiver.kernel.org>; Wed,  4 Nov 2026 00:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=q5nnE1eQ;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AvqsbefY
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F10886069F;
	Wed,  4 Nov 2026 00:12:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 200lioZmqL30; Wed,  4 Nov 2026 00:12:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 657F2605E6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793751142;
	b=LnWAJboF4R9LhqNdq/BtraCdgin5oC0qXe580K5Gv/2EiEcTFJRuiBJgmaZLuyUbs5Jv
	 DbzQlhCT8/zEVIB47u/okOVJzRJgOD47r+3GL8EtSSm0DVcoo3rzJGsCpivWOSugcFfZa
	 WIThJixtTgjuLkVqO3rfuBrvBjVGL1co/zv8dCsYwM2pms9p8yZohN00x8iB3nYUPfMjm
	 UFfHOkeO3m0kOtOmaUQTzp/FdqCF1dx8pEXmoQ76sOumrZ6J9eh+QZAG1sKEqny53J98y
	 D30kN9hvnXiAEkKpYnvWU9NTO25P5dteo9B2dXgOz3IOhVEOBQjn5drQEdmHGtco5Qg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793751142;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wuVWVsoReoZBgQlTx5YhNU7j+UPdLjPjb5qlqLmuIu8=;
	b=lp5Z9iH9G+IIxSKNiJjsX9D8eBwRAdpEBLQ3nXzfOM2Dqe66QimU8sblbtghsHOKIWUG
	 7oP58sX2XTo6AwM/f775zdHa7zzKfPmPDY9fnB4aImUbbBQ+4KtuBa6rAe5QDpefkFWm2
	 4mo2h5Z5YzEnBlp/qO2pctafUfkGoVS8zsUUL1u2BF2KIN6ye4zWxU5yTCTrXQ+isLO02
	 o/x5VF0dfxDM/wBZg+Usve0WFIZ42GsNtax6aAmMuz51hkp+1Sk5AKuyzylnBIXd+b63B
	 m+JJ5jyHP/ykCb+uvRt4+xLNSmDTStEf+S6V9MxIF3WX8uqVmS98cQRbMkOX7UVQYtA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793751142;
	bh=wuVWVsoReoZBgQlTx5YhNU7j+UPdLjPjb5qlqLmuIu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q5nnE1eQZ2awfEMnsX5VYGtuGv15R1BHAohupFErxrUUsDAeslcFYnUeQsTWGNk4W
	 3epqrm+Ipyc3sUU6iHTnqHx4ZRExWPNGU1evvPtgQ9mUS0MI6zA4FLjd5t+hzf9ndT
	 xt4DrXDxYh7ijUgoVWCFQDJ/g+RXOJulvXQgPbdZbn7CxUnLHHQZN44YSrtPhdtUNS
	 Gd2U1Lw2BF7nVqErXDrRsQKGbw0vL2UKfDZUj+ZbgzmZaixUscnB/OhLfrAuNNqDbw
	 YGICCEN1ufoHxh4hCehcFSnSNNPsUF+qtgSJwgLTFi4Kd6CKfCl787m6OB4cuuwxjK
	 ccF2Hbxml/JaQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 657F2605E6;
	Wed,  4 Nov 2026 00:12:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C982F2AC
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 00:12:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BB4EA40080
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 00:12:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o5MNxWyoVfwl for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Nov 2026 00:12:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 10F8F40048
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793751140;
 b=BegvbPvYabm1AFW7TEiQKt52jK4awJbHtxqXdCpj0Zi6h54Zujojj/21EptfD8USzGJv
 9oyudg+pdfChRNFugArNYhkNR9UR3lGXkLH98k+I57UgnuPcOE130rtX251dQrI+3XJ5l
 jNn6f/0EA976ZdidUI0WVkrHnOIJs3B3IiJscftSG8gvjbrhA0DzPWFBSVGU0NcSNmrwv
 j2U5BkAYLwrJZIWpgY1XfMENtRx86/2aPmKp4d8mjq9/ndVVCLKF9AdMQrrY4UO00I2t4
 ejSaUJovu8eVmmZmA4N4coxO5nXL0dcE1nYeRiEGi/vQYSmKkEVe7ypsTVlj7lc39rA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793751140;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=wuVWVsoReoZBgQlTx5YhNU7j+UPdLjPjb5qlqLmuIu8=;
 b=ZDWDbGh2sfgaQzUZeRMYumXZqS1nx6CrbmiXafJWait+7tfC1kvgnXmxnbtxlk1BsKUc
 QwdgLm/2WY8mNuNvCVl1ortgTdNeZRFdiNZi9yb5EjuglssmG+J4BHK9xBwF2fvjU9XoU
 eBbO6fTnfk2dEZQVAhZM1Z2w5iEsXfMXrRRJER4uCviyeCzFwIzRXsCRKf83jFc34T6FV
 WWix0NfSir1V5ipnnO2/BzrYT1jT5g4bBJLr4wQ8/JCg4VldxhWb9MOtPd04/U5EpdiZm
 dioeZPnMhdlgbleDUmdUwLaXDQ5jNd0YrK4R9G8y3PDKsiCRnuMO0RBaJgd8iIBj9Yg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=AvqsbefY; 
 arc=none smtp.remote-ip=198.175.65.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=emil.s.tantilov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=AvqsbefY
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 10F8F40048
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 00:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793751140; x=1825287140;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JGT96BfNaeHkrlNILoj0eCXJIzl4YaKUUVw8c1umCGU=;
 b=AvqsbefYV7BW/oX+qnorqvPY9t5fkKs/4N9ZMEJpytcCdXouMbSyHP0N
 OWaqyU1cZv/NjLejo9LTWyDg69/l8C1YzlqaJEpeDa3MinaIPluL2wwtn
 fYRglbCVjuJfDEJj3s3N/57wdWNpCq7+cJ006X03O19N0kChMar3DDWDq
 A/YNX0qW7OoYbyiRE3pb6qNY/OBC6XAaFtjAqd+XSIH81sW8GzcMIjtj3
 h54R6GzVQoc9JkD7i63Y/Z0eCpbOFpsHEPtQ6XETD31EXNS3hrhsRWWdF
 531gDLqPU0p53yf9icnCw7Upc85X6Sz7Y1FclIkfvV5Otr3bryaZi1LoZ A==;
X-CSE-ConnectionGUID: 9t+J9xIFR1uoSjkfK4vMqg==
X-CSE-MsgGUID: MIsf6TopS1uXoL2OCnbDCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2522936"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2522936"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 16:12:16 -0800
X-CSE-ConnectionGUID: HZ450OvNRiuXqcZnz1zhWA==
X-CSE-MsgGUID: yBef7ZLzTXOVhgsPO+Bn0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="6904719"
Received: from coyote-pass-p6-34563.jf.intel.com ([10.166.80.105])
 by fmviesa001.fm.intel.com with ESMTP; 03 Nov 2026 16:12:15 -0800
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: phani.r.burra@intel.com, larysa.zaremba@intel.com, joshua.a.hay@intel.com,
 horms@kernel.org, brianvv@google.com, decot@google.com
Subject: [PATCH iwl-net v3 2/2] idpf: skip empty netdev slots when detaching
 for a reset
Date: Tue,  3 Nov 2026 15:53:54 -0800
Message-Id: <20261103235354.1063721-3-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20261103235354.1063721-1-emil.s.tantilov@intel.com>
References: <20261103235354.1063721-1-emil.s.tantilov@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

adapter->netdevs is sized by caps.max_vports in idpf_vc_core_init(), but
idpf_init_task() only creates netdevs for caps.default_num_vports. These
are separate virtchnl2 fields, so on a device that reports max_vports
larger than default_num_vports the tail of the array stays NULL, causing
a crash on reset:
echo 1 > /sys/class/net/<inf>/device/reset

  BUG: KASAN: null-ptr-deref in idpf_vc_event_task+0x22a/0xa30 [idpf]
  ...
  Workqueue: idpf-0000:83:00.0-vc_event idpf_vc_event_task [idpf]
  Call Trace:
  dump_stack_lvl+0x77/0xb0
  kasan_report+0xca/0x100
  kasan_check_range+0x100/0x1b0
  idpf_vc_event_task+0x22a/0xa30 [idpf]
  process_one_work+0x917/0x1940
  worker_thread+0x5a5/0xfe0

Add netdev NULL pointer check for every vport in the loop, same as the
max_vport loops in idpf_remove() and idpf_init_task().

Fixes: 2e281e1155fc ("idpf: detach and close netdevs while handling a reset")
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 791ebff98507..0cdbd81b1371 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -765,6 +765,9 @@ static void idpf_detach_and_close(struct idpf_adapter *adapter)
 	for (int i = 0; i < max_vports; i++) {
 		struct net_device *netdev = adapter->netdevs[i];
 
+		if (!netdev)
+			continue;
+
 		/* If the interface is in detached state, that means the
 		 * previous reset was not handled successfully for this
 		 * vport.
-- 
2.37.3

