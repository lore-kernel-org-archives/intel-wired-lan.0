Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DB5C79F82
	for <intel-wired-lan@archiver.kernel.org>; Fri,  4 Sep 2026 18:12:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5136A60B86;
	Fri,  4 Sep 2026 18:12:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tzuR934I9UED; Fri,  4 Sep 2026 18:12:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7C22260B6C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788545559;
	b=fY16iIEta95L1Bcb9AxrcBaOanoNjpkMMQ8PyFnSsc0nLykv9fVDxJnxYes6IAmxRhW/
	 HWxiFt7frNNeBZ2H35G60YEjLaRX8HRYUsupfAmR1LiC9kxRRNx7fvlJ1uDXEY/8yMGzi
	 +C7euvgclftogmf9wMtK8nAVPODhFBWOe1WcMAkV7rfiYMikUXgsbBt/02PbJA319yaLt
	 0fGEb7Fwyu1nzxWjBi9Ik7dABJ8cw8nun5wJ4DtpsENHkY+ybV/zNuP9KyhyMoPWhx5mx
	 6DPWI8Zt8PviETxhSvesE1bSEA0cU4dl+RZlwUTeallcl/LCwv7TwyJ8zXCNy3f+MiA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788545559;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wgRV6vQFtgD/ZtMJ9DwlubloegD8SZicn6+VX0AdMN4=;
	b=UH8S9Il8I7wPS55lmGEZIKZQpHuf4OglyBs6W440ttpGAozcHGG0MbsNJCR+JhwTD7MX
	 BRcQVSdEYRP4SGc6JTqDdlFdsN8t5dBMQPgqnHFaFIvJrfW2rF/B7JzvZt/0oHeUOo1Fb
	 X11Erc4ZbPj+RMYqD4bfe+JLHNM5Ra45vHXRnwVJssGKfo5nTVkNLBTaNw7QHHcSL/fOj
	 UXQdswXVdmwU8QmgMSKkHDU6dSgIC7vVml63VtcKjcR8PjFSt8VpOQ/EushP2ShW1lSXy
	 OMKT1DRZSuPNa4R0eApqb5GaIw/4Qh9tkxeGptJqhT5157peJHCgSHag6DJr6/LALJQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788545559;
	bh=wgRV6vQFtgD/ZtMJ9DwlubloegD8SZicn6+VX0AdMN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jS9uayhp7IWpE9suURITx9zhVvuXZi02QFJ+bgmfl/1JKIT9vwnQ8nBz2EsySXw/1
	 HBFurec1gFx42soU2Fe4QzcnmV0RDY4+0/j8rEr/NNXvw73z/l9SGH8a+Pbkz3EJjn
	 aizANzF1zUD3iFmVYQOmEjJP8VYowHWxsawsrf+S+qq9w06G94U6NlZ9aGyWL6ToEt
	 ai90rzWI9esPhc7KSxGNpuCRRWpgzKtN6coR65jMZEgqSvYCJTLaNYWMQEGjwbbJB3
	 V5yN3O5R9ejEx7MLARjG1yMOjWrsxUwKL3DoCkkS3KkDA2o0ta7o8VM7CLz72Yfi4P
	 Lx4UpAYJ047WQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7C22260B6C;
	Fri,  4 Sep 2026 18:12:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 64C0729B
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 18:12:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 56FCB404EF
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 18:12:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fGH5ocRqcx9I for <intel-wired-lan@lists.osuosl.org>;
 Fri,  4 Sep 2026 18:12:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5C11C40143
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788545557;
 b=G57C4pdacy1gYNHQlKG4nIyqCb33qE49QZv2TrkQm+2ChFj4vrVHKpKZEaHW7NlHd87L
 RdCoF9IaFLLC0wibfc0IZ9jyOYAyZ2uR4I6ZDRjBOB1R1vUE+4SwjCybjWmV43w+Ok/TE
 bigdnMBvwP5a5v0m900p2atpQPbeLYQe+Gd+aEbrtc5Z8WD3j02eBby7ecymzFMucgqTe
 y35J3zHnf2qTxKgiwqbvYBiMX0tpznuEURQQK8Nvc9PQx7LQIH49LZDGTsNsxMmtdyiD8
 iRu+yS+c2bWsVQv3DGgeORuR6O1M6Rb0ax1GX4d+8N1C5c665WhQANSQfQfvJZ9QaFA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788545557;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=wgRV6vQFtgD/ZtMJ9DwlubloegD8SZicn6+VX0AdMN4=;
 b=MYFFMkHNn9v8RU6VAVSlY6DQ5C0qPTVx2ZwPrqItaPpqLgj3XuO3xyQMk14eHwGtIOL+
 WGq6+N1lJnDS27h/N50IsTMlQQCcDBP4xCEfKReXjceYVwzUDweKC+PIVmV+6noRIEXHL
 mkq5O9E4JB/RAqLEDXfdtL5DlzNEepEwCIAyrRXGBfZ1mqnX8Vjofv39q1jkSBa5TN1Ut
 yY9c3aWDRFP+Ulx9ic+Y6uyxKa0wmkQjOqRS0eGyBscW+wgNccKY8ozzuDLp9MU7HEKtq
 9WBI1PppGkNQjuCIF2P3XlFlwNIRS6R587yNVdyCnx6Gx+bY78MnYKCda2D+pukNELw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=BjjQDojU; 
 arc=none smtp.remote-ip=198.175.65.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=paul.greenwalt@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=BjjQDojU
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5C11C40143
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 18:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788545558; x=1820081558;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Um0Hm4c9zBE6+FlO1pMm/K+tZ6BSLmlXIMFuZBZYwyI=;
 b=BjjQDojU8h3eNeKFrCkGjDD7eJA2qYWzuwvZV9+QSLqktkxrCq9mWcPC
 rMbYkuqtMBTMG47eD8s+01+iKzk0szhCMmm+ryrFGoVAcna01uvg8J2iN
 WnPy2Z7KAlr+xRCQXitCYUTflZelHMfomsHT+Oy55WSBlVmSu9hpdY5U5
 rg2w1JIyWzcSUDbsOxEnM1c0sPO3ssw97r3+Ub/gi0rzjDUIl0W6adW3A
 VGIaeNDN841zu/J0H8P2Sy66gz706fbDZdoTx6yPfvyvDkkgkGBd4e4G0
 wTiWcb1GpwZr8EMxb6jRf9Fy4D6MwRwxXmPhg3ErGGzQhMsYbEOMbe/GF A==;
X-CSE-ConnectionGUID: l53jaakTR++JZUl6iiv4mQ==
X-CSE-MsgGUID: JLm7D0DcRz63aphMztV2lA==
X-IronPort-AV: E=McAfee;i="6800,10657,11896"; a="99385443"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; d="scan'208";a="99385443"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 11:12:38 -0700
X-CSE-ConnectionGUID: HR1LPTHmSvWbqACEEU2DOg==
X-CSE-MsgGUID: 173zasGaRZ2oijXVS/OmYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; d="scan'208";a="269577548"
Received: from unknown (HELO fedora.jf.intel.com) ([10.166.5.147])
 by orviesa008.jf.intel.com with ESMTP; 04 Sep 2026 11:12:35 -0700
From: Paul Greenwalt <paul.greenwalt@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Paul Greenwalt <paul.greenwalt@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v3 1/3] idpf: clear drvdata in idpf_decfg_device()
Date: Fri,  4 Sep 2026 06:37:12 -0400
Message-ID: <20260904103714.978256-2-paul.greenwalt@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260904103714.978256-1-paul.greenwalt@intel.com>
References: <20260904103714.978256-1-paul.greenwalt@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

pci_set_drvdata(pdev, adapter) is set as the last step of
idpf_cfg_device(), but its inverse, idpf_decfg_device(), does not
clear it. idpf_remove() open-codes the clear right after calling
idpf_decfg_device(), so the two functions are not true opposites of
each other.

Move the pci_set_drvdata(pdev, NULL) into idpf_decfg_device() so the
set/clear pairing lives in one place, and drop the now-redundant
explicit clear from idpf_remove(). idpf_decfg_device() is also called
from idpf_probe()'s err_init_wq unwind path, which did not previously
clear drvdata at all; it now does too, closing that window for
consistency with the rest of the teardown path. This has no
observable effect: the driver core already clears drvdata via
dev_set_drvdata() when a probe function returns an error, under
device_lock(), before any consumer of drvdata can observe a stale
pointer.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index 1e4dd9b713a0a..3dbbe21459990 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -112,6 +112,8 @@ static void idpf_decfg_device(struct idpf_adapter *adapter)
 		pci_disable_ptm(pdev);
 
 	libie_pci_unmap_all_mmio_regions(&adapter->ctlq_ctx.mmio_info);
+
+	pci_set_drvdata(pdev, NULL);
 }
 
 /**
@@ -182,7 +184,6 @@ static void idpf_remove(struct pci_dev *pdev)
 	mutex_destroy(&adapter->vc_buf_lock);
 
 	idpf_decfg_device(adapter);
-	pci_set_drvdata(pdev, NULL);
 	kfree(adapter);
 }
 
-- 
2.52.0

