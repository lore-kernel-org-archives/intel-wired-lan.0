Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C91C6FD1F
	for <intel-wired-lan@archiver.kernel.org>; Wed, 22 Mar 2023 13:13:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D2F6140125;
	Wed, 22 Mar 2023 13:13:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D2F6140125
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1679490787;
	bh=TN87rT/yij0x18sw4qaBzPCbT+Uhsswum4rZ+mrBtFs=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gPussgnsmCLFyEkijbSMUrilBGFzXWzXb/TWnWjT6vZkBqdfFBoCKRceaGRaIztS1
	 DUiu7AKi3LkHp0V4/rRrsk4HuLoem5gf9nHjbvfvVJ7EHoHoNUbIFD1sunnjqq8+ZB
	 w3qmBcOeqTLr4tNEICuKB4LWCDTUWllhH8oLsO4XFYWHMooPL8HK+PCApHa0BZyBO5
	 3J0EEHAdI/UB7MUIBi/XxXfjBKAVBv+uCKHcXFKjpa9lfkCwUsbFCFa3RFVenkiiPH
	 NixV5G6Y4J7ud1H8cT3hoWJxYxfrQtBwpNnTB++dxByx/DwiLT2AbRcwCJF+SqzbC/
	 CgciOTsqSYQ7A==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nlQBbjoc6pEQ; Wed, 22 Mar 2023 13:13:06 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 97A574019D;
	Wed, 22 Mar 2023 13:13:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 97A574019D
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 0C7021BF5DC
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Mar 2023 13:12:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D9E6041D6E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Mar 2023 13:12:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D9E6041D6E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d0v8_Qts6bsV for <intel-wired-lan@lists.osuosl.org>;
 Wed, 22 Mar 2023 13:12:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 05B0E41D6A
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 05B0E41D6A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Mar 2023 13:12:51 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="340743729"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; d="scan'208";a="340743729"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2023 06:12:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="714394689"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; d="scan'208";a="714394689"
Received: from hextor.igk.intel.com ([10.123.220.6])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2023 06:12:50 -0700
From: Michal Wilczynski <michal.wilczynski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Wed, 22 Mar 2023 14:12:27 +0100
Message-Id: <20230322131227.244687-6-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230322131227.244687-1-michal.wilczynski@intel.com>
References: <20230322131227.244687-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1679490772; x=1711026772;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XrRAUTvg9mzwWYTA4owbQ8TVvB6LaWlf7Uz1MazZA0c=;
 b=UeZV6FJYH60FZitXRDt/+/9fjXl7JONh50NTg96UogaXN3ridcb5vm8A
 blVZHF460+FxS6YcpfHRZvk98Q1/Ezokv9wZL3pC75gZDr5oZOu1FnSrK
 /STpceH7ofw774SCXfs2wBmnGlmpJXBD13qkiaRaLH9lcYMuzYepynNhS
 sLkHO7Ra2y5G4rv1X3XPpiev49QmS/K4IP9kSdyfYswrwpBViYFqqLn8E
 NtViEQ8KSWrs5z9O80N63oFGiYj0utLE5aBtyiV1BvXtmdPdzNCQATI12
 YmTR83aWOag2tEjwMCPSSb8GKLrs+9tfb5xvL+/bIhH+VLwhT5JZeBOGw
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=UeZV6FJY
Subject: [Intel-wired-lan] [PATCH net-next v11 5/5] ice: Document
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
 Documentation/networking/devlink/ice.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/networking/devlink/ice.rst b/Documentation/networking/devlink/ice.rst
index 10f282c2117c..2c58a25550d2 100644
--- a/Documentation/networking/devlink/ice.rst
+++ b/Documentation/networking/devlink/ice.rst
@@ -7,6 +7,26 @@ ice devlink support
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
+       transmit scheduler topology, which helps to smooth out the transmit
+       performance. The default topology is 9-layer. Each layer represents
+       a physical junction in the network. Decreased number of layers
+       improves performance, but at the same time number of network junctions
+       is reduced, which might not be desirable depending on the use case.
+
 Info versions
 =============
 
-- 
2.37.2

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
