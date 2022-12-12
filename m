Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6626AC4332F
	for <intel-wired-lan@archiver.kernel.org>; Mon, 12 Dec 2022 02:40:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 034BC40112;
	Mon, 12 Dec 2022 02:40:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 034BC40112
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1670812804;
	bh=cM4ddECo2G7kI0C/6pQniO1oU7tkEHPP06PNyR8f/Vg=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=bWzqfldEfL6OCkkGSaOrG4joGk3j88Kebw10XLGnMwdMh1Q3s2dUiw0yGbKfl9JXr
	 gG5HanK7hs1qE86eA9mUcYNYieVgRKdrdu1/5rXOWYiyvXdWnEDjVaDYH52hvd7JDP
	 G+sv+WySMMPmig4waE6jkkuIgTJbsTOpwfAAc47+ruGXYNvPyzkfGLaMrI4B21jwhC
	 DUnBIR5b5IhGQXm8girQf7hDk5OHAxVeOx1Rf8rV4MaW3spXFuOUcv37CnPK67F9oR
	 cE/k2uXsXxVShAR3jJlpAIIixR3Rx/QLy4kumuC5oi45Cl964bChcupJGHORFWIH3E
	 5MULQjh7z77TA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WXAJs27o0jT8; Mon, 12 Dec 2022 02:40:03 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 00D47404C3;
	Mon, 12 Dec 2022 02:40:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 00D47404C3
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 6415B1BF29D
 for <intel-wired-lan@osuosl.org>; Mon, 12 Dec 2022 02:40:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 399CC60C06
 for <intel-wired-lan@osuosl.org>; Mon, 12 Dec 2022 02:40:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 399CC60C06
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oMAqapw4QhJ4 for <intel-wired-lan@osuosl.org>;
 Mon, 12 Dec 2022 02:40:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A53E760BE9
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A53E760BE9
 for <intel-wired-lan@osuosl.org>; Mon, 12 Dec 2022 02:40:00 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="297431573"
X-IronPort-AV: E=Sophos;i="5.96,237,1665471600"; d="scan'208";a="297431573"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2022 18:39:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="648006952"
X-IronPort-AV: E=Sophos;i="5.96,237,1665471600"; d="scan'208";a="648006952"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.82])
 by orsmga002.jf.intel.com with ESMTP; 11 Dec 2022 18:39:49 -0800
From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
To: intel-wired-lan@osuosl.org,
	vinicius.gomes@intel.com
Date: Mon, 12 Dec 2022 10:37:03 +0800
Message-Id: <20221212023706.13384-1-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1670812800; x=1702348800;
 h=from:to:cc:subject:date:message-id;
 bh=P8q5JqrTmho3NWXsRrgO9I1iVtlocJokqsaDjB7Ezlg=;
 b=kP4+2rMtY+BzRUdjhkgELyiwMVMbOxsFp+FfjY8uw45u8qr3itDqUgv0
 mweMZlwfTgwCUm7goxQiL3Eis+kNL5/qOFwohX272GAkQBmHxBmS6Fyni
 jcAAdQc5VST7H2BTdDjuGu82Giis5BNtSG8FlQDFaVuGCk7aYuj58pfsg
 rQ4cSOPlsvX1taqVDtkdE+kEBVxBFyo4dzsiCmNPNSJWVGsFzlBRU7C74
 m6MPtV+iQanX3GLkeLDt+O5SYTd0VwvKfMqZKpHVlcjd7PPodV52YmM24
 XtpNfiBOTAsW5aZEMp1ykNgcOhHkkyBGA6nksJfesrxoNREwwEp7Dmi2x
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=kP4+2rMt
Subject: [Intel-wired-lan] [PATCH net-next v1 0/3] igc: Qbv Feature
 Improvement for I226
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
Cc: muhammad.husaini.zulkifli@intel.com, anthony.l.nguyen@intel.com,
 tee.min.tan@linux.intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hello!

Improvements to the Time-Sensitive Networking (TSN) Qbv Scheduling
capabilities were included in this patch series for I226 SKU.

An overview of each patch series is given below:

Patch 1: To enable basetime scheduling in the future, remove the existing
restriction for i226 stepping while maintain the restriction for i225.
Patch 2: Remove the restriction which require a controller reset when
setting the basetime register for new i226 steps and enable the second
GCL configuration.
Patch 3: Remove the power reset adapter during disabling the tsn config.

Muhammad Husaini Zulkifli (2):
  igc: remove I226 Qbv BaseTime restriction
  igc: Remove reset adapter task for i226 during disable tsn config

Tan Tee Min (1):
  igc: enable Qbv configuration for 2nd GCL

 drivers/net/ethernet/intel/igc/igc_base.c    | 29 ++++++++++
 drivers/net/ethernet/intel/igc/igc_base.h    |  2 +
 drivers/net/ethernet/intel/igc/igc_defines.h |  1 +
 drivers/net/ethernet/intel/igc/igc_main.c    |  8 ++-
 drivers/net/ethernet/intel/igc/igc_tsn.c     | 56 ++++++++++++--------
 5 files changed, 73 insertions(+), 23 deletions(-)

--
2.17.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
