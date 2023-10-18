Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A78CDB484
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Oct 2023 23:25:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6BA3D400EF;
	Wed, 18 Oct 2023 23:25:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6BA3D400EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1697671519;
	bh=DBb9BTzdumAhBY8FbMRpfagq/UA1iTwTKcqUxBC0tKs=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=398AWI3qn6yYJrMpAyp+Fns4wI3VsrQTHi3SF7sWIv38US2n8z8Rl+t4mOCnURU/R
	 Wl0lxVLC1l65u3+jSwlIcRTUzbhpG+EkSG8u4qbe8Mvo6gZJ0C1CWByEFrHfY4RQcp
	 t3uWVLk2QFFohyYrpNktauzbxrlSjTdujCbqpytFqhOuGj0aGhcKReWJNVAUSUU51x
	 wQLLRCnOJv69kF7tSBGqaiNrbHsrsc7Iyag0Xbu4n9HTphdv9Gz6dmKlkyAD9sDeoL
	 A/fVf652xoG3Y0Z6QnFf1kqeRdqQDMEJ3kpvmXLGeDpVZRETRHlGtdWNJnfJ0W+L76
	 axbkmXjdGsNTw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qkyzINkCsEKQ; Wed, 18 Oct 2023 23:25:18 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id C76A040A21;
	Wed, 18 Oct 2023 23:25:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C76A040A21
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 2ED191BF42E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Oct 2023 23:24:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2634C4198B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Oct 2023 23:24:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2634C4198B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iiBaIxXgp2VL for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Oct 2023 23:24:49 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 39CA8400EF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Oct 2023 23:24:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 39CA8400EF
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="388996743"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; d="scan'208";a="388996743"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2023 16:24:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="4732367"
Received: from unknown (HELO fedora.jf.intel.com) ([10.166.244.144])
 by fmviesa001.fm.intel.com with ESMTP; 18 Oct 2023 16:24:51 -0700
From: Paul Greenwalt <paul.greenwalt@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Wed, 18 Oct 2023 19:16:43 -0400
Message-ID: <20231018231643.2356-7-paul.greenwalt@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018231643.2356-1-paul.greenwalt@intel.com>
References: <20231018231643.2356-1-paul.greenwalt@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697671489; x=1729207489;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3oeLdPZ4E29kjd284PYRPlBekIGJzdbuvuJVazBGSfI=;
 b=JBQjpNwQkGZw0cOlIPqSwcwRH5I1FX+JOkS9qx0yHlj6q024xNq6B95o
 ykiKH0qmQ2MInquuH0UbuXHZFHYLxBr6XmfXE23zmKvSnGllEaTNzvfSN
 MbOYYXRT/cQu+wR49P7MlJBmzGZFEmQkpn8D9j0uj+0BiAmaHICtxsZRj
 5Uv+xbG+NkMPfDUETkNqswoHuIpz1mXc1Ek8miDQ1bwjnqudgt+GCwaUV
 +inNS444lZRNuCSUmUabK2s6eJz+hYeb+T2nyL6uVkLro/MrfPKM/emO2
 TZNlDrIW5W5uGRnl7C2dd2m0YKQGelqmIXTNGwxHcyxYFGMoxInpjY5Qj
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=JBQjpNwQ
Subject: [Intel-wired-lan] [PATCH net-next v5 6/6] ice: Hook up 4 E830
 devices by adding their IDs
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
Cc: andrew@lunn.ch, Paul Greenwalt <paul.greenwalt@intel.com>,
 netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>, anthony.l.nguyen@intel.com,
 horms@kernel.org
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
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index f47db07df679..66095e9b094e 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5611,6 +5611,10 @@ static const struct pci_device_id ice_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823L_1GBE) },
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823L_QSFP) },
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822_SI_DFLT) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_BACKPLANE) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_QSFP56) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_SFP) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_SFP_DD) },
 	/* required last entry */
 	{}
 };
-- 
2.41.0

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
