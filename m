Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C98EC83F27
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Jul 2025 11:07:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4433E42A37;
	Tue, 22 Jul 2025 11:07:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xrZjHQ2JYQ7A; Tue, 22 Jul 2025 11:07:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AC01342A36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1753182441;
	bh=UTcIr1l8JKmEGFUTEFBRbDlRzR8+tE6HeHyLCYQhAvk=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bcaVlq8kec/MAezTEXnIcpehcVg2vTNi/DCNS0GhOFVyrTvLtCZD9d3K0JaZ9jSIn
	 +MDftH38zvIcB2szRYLkui8esSYANelbNliSeCi8a+L7N3cVmKC+HkTnLXLiGlssQU
	 /XiJdaAjp9OkRs1qEcZGyEBi68GH1UXt+mj4gY58Akh38dGp4/+Xgp+bKWcCswHMGm
	 VwYOUoiAEZRdLZFw2+dhdnmvYbv3s2jr3bK+GjldOUnwl23D2+R6r/j2itvJR6URkO
	 oGR25mtH6G6Al7X3bi/I2bDqBUWUDWn1l8dh4UGvahnQ75bbWvRngyuyEJ459Zj1Hq
	 C5T5M6z76ns0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC01342A36;
	Tue, 22 Jul 2025 11:07:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A61CCE0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Jul 2025 11:07:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9836984B8E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Jul 2025 11:07:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ziw9CoyYteLM for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Jul 2025 11:07:20 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=michal.swiatkowski@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E627284B5F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E627284B5F
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E627284B5F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Jul 2025 11:07:19 +0000 (UTC)
X-CSE-ConnectionGUID: QKWJWNCeRaWExRrO7vqZEA==
X-CSE-MsgGUID: zv6Eu6WdSqWVDep++84/mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="59083628"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; d="scan'208";a="59083628"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2025 04:07:20 -0700
X-CSE-ConnectionGUID: psUPYx6ETTOhJSpvXRJcbA==
X-CSE-MsgGUID: 8LdxDishTt6XPQ/+3H2dnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; d="scan'208";a="163154006"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
 by fmviesa003.fm.intel.com with ESMTP; 22 Jul 2025 04:07:18 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, przemyslaw.kitszel@intel.com,
 dawid.osuchowski@linux.intel.com,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Date: Tue, 22 Jul 2025 12:45:58 +0200
Message-ID: <20250722104600.10141-14-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250722104600.10141-1-michal.swiatkowski@linux.intel.com>
References: <20250722104600.10141-1-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753182440; x=1784718440;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UaUPbdCMu84U9XA3Acq479SpwOPQHptEGSZ2V1MPSHk=;
 b=Xf+sCMhfeu76uFBkcQCqh0rx8HoRyN3O2+5HzxxAQY6k21QcBQOirQBY
 PfSiS2ad5DP/P+rJA+LAXXNhByy09W/yL9DTIZe9gS95MLJgz6M1kQ1XT
 AEPdAA2zPX+we72QVYlJgsS9qWKvr2kMEwvqXB4wt50Yr8vdIIgPWJu2C
 re624IINjzbEbHl+7Bv8PCOAau2u+kM2JD0qzpDasDEScAdkgivdBRMZh
 UpEZtuu/tzdJTguwwdx/OnpEYjlRWx8PTsfRvyZJlrV6RFt8G+NDfmBeN
 t1RBvYEBgT7PcXgXNV3TbgemrqH2km0uDw60ieF+vYLgNIFX6y+38u23H
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Xf+sCMhf
Subject: [Intel-wired-lan] [PATCH iwl-next v1 13/15] ice: reregister fwlog
 after driver reinit
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

Wrap libie_fwlog_register() by libie_fwlog_reregister(), which checks
first if the registration is needed. This simplifies the code and makes
the former function static.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_fwlog.c | 11 ++++++++++-
 drivers/net/ethernet/intel/ice/ice_fwlog.h |  2 +-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_fwlog.c b/drivers/net/ethernet/intel/ice/ice_fwlog.c
index 775581163e04..e76397ade68b 100644
--- a/drivers/net/ethernet/intel/ice/ice_fwlog.c
+++ b/drivers/net/ethernet/intel/ice/ice_fwlog.c
@@ -290,7 +290,7 @@ static int libie_aq_fwlog_register(struct libie_fwlog *fwlog, bool reg)
  * After this call the PF will start to receive firmware logging based on the
  * configuration set in libie_fwlog_set.
  */
-int libie_fwlog_register(struct libie_fwlog *fwlog)
+static int libie_fwlog_register(struct libie_fwlog *fwlog)
 {
 	int status;
 
@@ -1096,3 +1096,12 @@ void libie_get_fwlog_data(struct libie_fwlog *fwlog, u8 *buf, u16 len)
 		libie_fwlog_ring_increment(&fwlog->ring.head, fwlog->ring.size);
 	}
 }
+
+void libie_fwlog_reregister(struct libie_fwlog *fwlog)
+{
+	if (!(fwlog->cfg.options & LIBIE_FWLOG_OPTION_IS_REGISTERED))
+		return;
+
+	if (libie_fwlog_register(fwlog))
+		fwlog->cfg.options &= ~LIBIE_FWLOG_OPTION_IS_REGISTERED;
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_fwlog.h b/drivers/net/ethernet/intel/ice/ice_fwlog.h
index 3698759c8ebb..e534205a2d04 100644
--- a/drivers/net/ethernet/intel/ice/ice_fwlog.h
+++ b/drivers/net/ethernet/intel/ice/ice_fwlog.h
@@ -79,6 +79,6 @@ struct libie_fwlog {
 
 int libie_fwlog_init(struct libie_fwlog *fwlog, struct libie_fwlog_api *api);
 void libie_fwlog_deinit(struct libie_fwlog *fwlog);
-int libie_fwlog_register(struct libie_fwlog *fwlog);
+void libie_fwlog_reregister(struct libie_fwlog *fwlog);
 void libie_get_fwlog_data(struct libie_fwlog *fwlog, u8 *buf, u16 len);
 #endif /* _LIBIE_FWLOG_H_ */
-- 
2.49.0

