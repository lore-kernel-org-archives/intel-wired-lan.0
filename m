Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9AECCA487
	for <intel-wired-lan@archiver.kernel.org>; Thu, 21 Jul 2022 14:44:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9ABF88479B;
	Thu, 21 Jul 2022 14:44:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9ABF88479B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1658414652;
	bh=kMfxhub9qWPgLf63qlKL6DSnopbliBebOP30JTBj3mg=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=EJgYnOoNmKqVvEYfr6X/GiZAN4XO9FPkLe5LPsfnkZ+8RHvJ+PCEPc8k4kkIuZWQl
	 wU8ANgMlF1kNiGqB9ymrMD8mHyCwPdgLzKCzc1BsMRDYgu1zPSQbjBPI3kG5XFEc0i
	 59XOAy9XnqQq6Z84vKEqL+c+p9qYnnneTYThtoOA/9OQOJ8iP8o6Zc6Dj2mX9h3pRv
	 RF72qkwIH5t54YWFa3lahDKj0tObNGdgfalIFu4O5z0r5sWNKQg7lQ25g5CPVoTeoM
	 5fUEfBSUTN2yGH/T4VoIMg9cHTtJdiuZj8XGhqJ+umx9OBkj5efHWtDxYuR+FREBf7
	 H6+Rm0kI3Qy0g==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bCiuygVloXj4; Thu, 21 Jul 2022 14:44:11 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9BBA3847A0;
	Thu, 21 Jul 2022 14:44:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9BBA3847A0
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id D70321BF338
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 Jul 2022 14:43:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BE42142307
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 Jul 2022 14:43:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BE42142307
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W-US-jrPoxH8 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 21 Jul 2022 14:43:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 08154422E3
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 08154422E3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 Jul 2022 14:43:54 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="285828687"
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; d="scan'208";a="285828687"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2022 07:43:53 -0700
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; d="scan'208";a="573766619"
Received: from moradin.igk.intel.com ([10.123.220.12])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2022 07:43:52 -0700
From: Michal Wilczynski <michal.wilczynski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Thu, 21 Jul 2022 16:43:24 +0200
Message-Id: <20220721144324.141416-6-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220721144324.141416-1-michal.wilczynski@intel.com>
References: <20220721144324.141416-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1658414634; x=1689950634;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tufK50diQRWMUPRJoGqADhw/+l5i6dGqFp9lUj6khtA=;
 b=M4Xvm3sHKcOd8SIBr7V2UGHM8j7MGHsuI0QfFcBcTp0qscS3uRcbN4Zu
 nreUXjYP+hm7w8kJAx3pfwPkuS+pN5HkL6QNetM4mAArlk8o2HYb7Oh2X
 f62vj9JBzMEs3f77ZxZc7kgEV2VbZTSwIHyvmw21izWVTeLBIkVODEQ5r
 romfsan4TnNdj2V7kFQvYlm+lyxoeVzB4yvbERt0auKa4AUn56sdK89MY
 5LZ2sh+xnFadMS0krI7fA9+QbmmMuExvxl5K75bkRNGp9PExqWRyAcs14
 M2ykn3azh7ffQeN4xiTnDNffE42siZvO5DwNrORa5c1F4sTcCSKjMpvvL
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=M4Xvm3sH
Subject: [Intel-wired-lan] [PATCH net-next v7 5/5] ice: Document txbalancing
 parameter
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
Cc: Michal Wilczynski <michal.wilczynski@intel.com>
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
index 8c082b139bbd..d260a58d1d5d 100644
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
2.27.0

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
