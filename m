Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 566C6C6FD1D
	for <intel-wired-lan@archiver.kernel.org>; Tue, 14 Mar 2023 10:27:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F2EC140111;
	Tue, 14 Mar 2023 10:27:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F2EC140111
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1678789632;
	bh=CTLzrRG3y84CpPXU8RRDLpLOT/ccLa7JGCskDoMvOx0=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fGoJcpFYDS3xVue2BzQA2noLIiiS//pynv1EB5nqXVf+L70QOk06wmidqTMjabVXP
	 F3/IBPdvGe6BcgUUafEkQlKO8DHd/LdV0tko+V4QBXdV7otzlH2J7DlMBaWNYPe9W6
	 s5YFQ67jD8uVMxrPN9W5qvjBYuevcTAIVXRbnzR6wKaqhUPxPOs+tRDRODwE3JLa8O
	 W1a8GznDgn44ccB5yCRBeflkxl7SJUlRkS2R2X6JuFxA8HIlnmtPBNBJwtnMPPxFUT
	 SaIxWy4+su0gKLkYM05h9H3lTSvS2REyeF4cebHFgBfE1Zm9rV9x1e25kd/ojjpXRq
	 psbylJsieo6QQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tuPPELEs7qRu; Tue, 14 Mar 2023 10:27:11 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id CBB9C409FC;
	Tue, 14 Mar 2023 10:27:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CBB9C409FC
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 9882B1BF33D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Mar 2023 10:26:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 728E3402CE
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Mar 2023 10:26:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 728E3402CE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SPNr4mbFWGbG for <intel-wired-lan@lists.osuosl.org>;
 Tue, 14 Mar 2023 10:26:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C3F5E401ED
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C3F5E401ED
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Mar 2023 10:26:56 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="325749603"
X-IronPort-AV: E=Sophos;i="5.98,259,1673942400"; d="scan'208";a="325749603"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2023 03:25:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="656292672"
X-IronPort-AV: E=Sophos;i="5.98,259,1673942400"; d="scan'208";a="656292672"
Received: from hextor.igk.intel.com ([10.123.220.6])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2023 03:25:40 -0700
From: Michal Wilczynski <michal.wilczynski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue, 14 Mar 2023 11:25:14 +0100
Message-Id: <20230314102514.46636-6-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230314102514.46636-1-michal.wilczynski@intel.com>
References: <20230314102514.46636-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1678789616; x=1710325616;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=K1DYs1dQ66bNGY8cZrGWT0LFE5ifpSmcR5jYHoQ2Q3g=;
 b=O1sYu5Oy049KPvNFI88VYbGFkgoGAIygpdanI2EgaWDnFc2saISTsaQf
 u7ZOirCn3nGVXSN4Cy1JnVj+B7/gfkks/vt6zLzpN2HR4nexBUzu9lFZg
 aLhXQ4Nrt34OjgYXYPsRjCLCc1H++xQb9RO70ANaXJ5ElV3Sb4cdXN/LS
 wWHQnJkAgxGRqBFrG6TRXVmio3Wk7Bs/n1se5tGWeVWj2PRwDMwULbF/c
 fhIBAojq4u9AcSCa8416ygArQX/JxR18n5juzThMh/x2Xc5UISjjbxqBW
 BSoogLuTcsXuB+YOZPPi/NkHpko7nFzeuuZZmdF772rOlJa+OFC3MQKi1
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=O1sYu5Oy
Subject: [Intel-wired-lan] [PATCH net-next v10 5/5] ice: Document
 txbalancing parameter
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

New driver specific parameter 'txbalancing' was introduced.
Describe parameter in the documentation.

Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 Documentation/networking/devlink/ice.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/networking/devlink/ice.rst b/Documentation/networking/devlink/ice.rst
index 10f282c2117c..6ffe230f71a5 100644
--- a/Documentation/networking/devlink/ice.rst
+++ b/Documentation/networking/devlink/ice.rst
@@ -7,6 +7,23 @@ ice devlink support
 This document describes the devlink features implemented by the ``ice``
 device driver.
 
+Parameters
+=============
+
+.. list-table:: Driver-specific parameters implemented
+   :widths: 5 5 5 85
+
+   * - Name
+     - Type
+     - Mode
+     - Description
+   * - ``txbalancing``
+     - Boolean
+     - permanent
+     - This parameter gives user flexibility to choose the 5-layer
+       transmit scheduler topology which helps to smooth out the transmit
+       performance.
+
 Info versions
 =============
 
-- 
2.37.2

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
