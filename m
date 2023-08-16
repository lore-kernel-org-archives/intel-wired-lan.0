Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6955BC2FC14
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Aug 2023 00:12:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2382F4178C;
	Thu, 17 Aug 2023 00:12:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2382F4178C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1692231154;
	bh=3h1MOIzBBShfeAB463zhlzfMwipzxlzEE24Y73HRKnU=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=LVmJi1zCTbexb3pa2/VvdfcUyRxuyepKinGouBXsXFU9u/Vfh9068cwBsC0NU4maA
	 lm6Dje5W0xi3Df4mT3uU+LrvpTKGWABf0Kqr1a7xmzOLetV78/XrUuLabaq3nbLUJc
	 hvRohOgkmInX2oyi7U6nIAmLywalF8mtVyJnxlGzHXFBKIFvH6wmTp54l8dbfVDrb6
	 /M3tqTbl5cuYjWoRJsh32R38a21+kIT6eM+mg6fdqxd0MJqgLit8DxHqE0LuV5PQ5Y
	 odS9taxg4x7YOxs2uGluSeZKrUlQ/grMEIo/OJZz4RL4EGmtjBA2HsUqqH3Fw6tndK
	 wxN0Jz5i43ezg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3nJex_sfyKX4; Thu, 17 Aug 2023 00:12:33 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1D0B641782;
	Thu, 17 Aug 2023 00:12:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1D0B641782
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 25AB41BF97F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Aug 2023 00:12:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0BFEF61420
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Aug 2023 00:12:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0BFEF61420
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hi1FbdYekh_k for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Aug 2023 00:12:23 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 666FC6141F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Aug 2023 00:12:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 666FC6141F
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="371570666"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; d="scan'208";a="371570666"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2023 17:04:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="824422151"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; d="scan'208";a="824422151"
Received: from unknown (HELO localhost.jf.intel.com) ([10.166.244.168])
 by FMSMGA003.fm.intel.com with ESMTP; 16 Aug 2023 17:04:55 -0700
From: Paul Greenwalt <paul.greenwalt@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Wed, 16 Aug 2023 16:57:19 -0700
Message-Id: <20230816235719.1120726-8-paul.greenwalt@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230816235719.1120726-1-paul.greenwalt@intel.com>
References: <20230816235719.1120726-1-paul.greenwalt@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692231143; x=1723767143;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7CpkAGm9AMDYpLCrvBWk5/DAhJHRJZsYuZXPpX0QRn8=;
 b=invAuFCx0eoVkxiPZHDYIfq0/KMo6d8pd9ESjq+QGjRjUDa+jNMJ0TL7
 ogDE7LV+S8gS+v298ltqJpA/S5suvKG5OkNW3W2c1qw37kku207IlCR7j
 Q+pXz4PammFiA8LSWxougZuLJsz4Loe4ZS5L8RTEgT9uA0krpO9qvIH68
 ShXz/RSk4JjRIruM2OBIVugAGPDAy234orq6hKz60JyGJ6jno3gGeZpmC
 rY+GLEAPB6J4WDdNGl6H/+H/ZhSkan4QflZV4qweCK3oP0JLiurOmU1XQ
 RgIKLKezut5KF22KLmU/6G9xKHKpd++DZQV3sG2k0U8/8ealDnEkAcKvl
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=invAuFCx
Subject: [Intel-wired-lan] [PATCH iwl-next 7/7] ice: Enable support for E830
 device IDs
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
Cc: netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Pawel Chmielewski <pawel.chmielewski@intel.com>

As the previous patches provide support for E830 hardware, add E830
specific IDs to the PCI device ID table, so these devices can now be
probed by the kernel.

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d6715a89ec78..80013c839579 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5630,6 +5630,10 @@ static const struct pci_device_id ice_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823L_10G_BASE_T)},
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823L_1GBE)},
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823L_QSFP)},
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_BACKPLANE)},
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_QSFP56)},
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_SFP)},
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_SFP_DD)},
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822_SI_DFLT)},
 	/* required last entry */
 	{ 0, }
-- 
2.39.2

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
