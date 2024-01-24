Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B46EC47258
	for <intel-wired-lan@archiver.kernel.org>; Wed, 24 Jan 2024 00:19:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A60E45BC3;
	Wed, 24 Jan 2024 00:19:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2A60E45BC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1706055581;
	bh=EnFvRZBnsvcpI3gHwuga0QTf+dfPhLSs1JazEtKrgbA=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=hMoGD+i3kbzd3/qmQNCVDIOF66sQVLwtLwVXaBXn0BxIzaVLJFbpTSg/ukRyl8Nnn
	 pvui20EDWqMhqIPAk0T6njhqJJiIbYvxKH0xsNZPbFEAMGfApjJWPz9E758/sh+V1z
	 Qn8+hKbTw3GoPjBZxDb2gBizRfrRMstkvQTwZuWH9k2+L5VH36pULtk06CPCa1uslB
	 VV8Kk2ZXB0qpTMjaRvlLBIdpcF4Lih3+l79KIE8PIifAXpEU1Qf3asdbnVqD4cO224
	 w2NEmBCNxZ7EpIDWsRXdsgM6+GJStw+SKIvvyUG3wa3sNPATk7zXkw1ywRCYwM9/ar
	 Q4pjVQfufyyiQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cg3IBk5-hBa8; Wed, 24 Jan 2024 00:19:40 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 20D7F46D76;
	Wed, 24 Jan 2024 00:19:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 20D7F46D76
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id A7FDF1BF27A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 24 Jan 2024 00:19:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 731FB40278
 for <intel-wired-lan@lists.osuosl.org>; Wed, 24 Jan 2024 00:19:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 731FB40278
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YkJMJAZ6VfHw for <intel-wired-lan@lists.osuosl.org>;
 Wed, 24 Jan 2024 00:19:37 +0000 (UTC)
X-Greylist: delayed 427 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 24 Jan 2024 00:19:37 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0DB344026F
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0DB344026F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 24 Jan 2024 00:19:36 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="592857"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="592857"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2024 16:12:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="1793470"
Received: from unknown (HELO localhost.jf.intel.com) ([10.166.80.24])
 by fmviesa003.fm.intel.com with ESMTP; 23 Jan 2024 16:12:28 -0800
From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue, 23 Jan 2024 16:10:26 -0800
Message-ID: <20240124001026.2627-1-pavan.kumar.linga@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706055577; x=1737591577;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=VxtsDY4+0bWaGP6Z1n26I6a4V22qrx/u5kJOx/eshW4=;
 b=Efpbm926w1lbVQ8gpSRMw9HXIQ4okwpnvNgG2Idc4F2qC7ewLTpIcRfq
 UJnN2ClzbUQsRlM6alX4C9wyJcvcsFlEFRTbwL5krpKjweGe8W+OAKCd0
 zdP27YHFn0om/NxKrS0JGvdvTPCcVQkGDUGCUrMqQcMLHYuXUKXIma6vS
 s+7klffHrvyrpgJjMBeJDYfl0JgM17+h3AGEHTa7HkrbLdsf+hbx/bB7e
 so0ifk/MirG4PXK+7QLXAJ2/FanOGjVXmMK2ZSqM0W5S+K3EnmxQX0xP2
 q92KmPUXpgApLTm9aG0nBKDyuUfa7KlouhAWfEcwUfStB7n2nsPaxLpmH
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Efpbm926
Subject: [Intel-wired-lan] [PATCH iwl-net v4] idpf: avoid compiler padding
 in virtchnl2_ptype struct
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
Cc: pmenzel@molgen.mpg.de, Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
 emil.s.tantilov@intel.com, netdev@vger.kernel.org, David.Laight@ACULAB.COM,
 horms@kernel.org, przemyslaw.kitszel@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

In the arm random config file, kconfig option 'CONFIG_AEABI' is
disabled which results in adding the compiler flag '-mabi=apcs-gnu'.
This causes the compiler to add padding in virtchnl2_ptype
structure to align it to 8 bytes, resulting in the following
size check failure:

include/linux/build_bug.h:78:41: error: static assertion failed: "(6) == sizeof(struct virtchnl2_ptype)"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
drivers/net/ethernet/intel/idpf/virtchnl2.h:26:9: note: in expansion of macro 'static_assert'
      26 |         static_assert((n) == sizeof(struct X))
         |         ^~~~~~~~~~~~~
drivers/net/ethernet/intel/idpf/virtchnl2.h:982:1: note: in expansion of macro 'VIRTCHNL2_CHECK_STRUCT_LEN'
     982 | VIRTCHNL2_CHECK_STRUCT_LEN(6, virtchnl2_ptype);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~

Avoid the compiler padding by using "__packed" structure
attribute for the virtchnl2_ptype struct. Also align the
structure by using "__aligned(2)" for better code optimization.
While at it, swap the static_assert conditional statement
variables.

Fixes: 0d7502a9b4a7 ("virtchnl: add virtchnl version 2 ops")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312220250.ufEm8doQ-lkp@intel.com
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>

---
v4:
 - swap the static_assert conditional statement variables

v3:
 - add "__aligned(2)" structure attribute for better code optimization

v2:
 - add the kconfig option causing the compile failure to the commit message
---
 drivers/net/ethernet/intel/idpf/virtchnl2.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2.h b/drivers/net/ethernet/intel/idpf/virtchnl2.h
index 8dc83788972..506036e7df0 100644
--- a/drivers/net/ethernet/intel/idpf/virtchnl2.h
+++ b/drivers/net/ethernet/intel/idpf/virtchnl2.h
@@ -23,7 +23,7 @@
  * is not exactly the correct length.
  */
 #define VIRTCHNL2_CHECK_STRUCT_LEN(n, X)	\
-	static_assert((n) == sizeof(struct X))
+	static_assert(sizeof(struct X) == (n))
 
 /* New major set of opcodes introduced and so leaving room for
  * old misc opcodes to be added in future. Also these opcodes may only
@@ -978,7 +978,7 @@ struct virtchnl2_ptype {
 	u8 proto_id_count;
 	__le16 pad;
 	__le16 proto_id[];
-};
+} __packed __aligned(2);
 VIRTCHNL2_CHECK_STRUCT_LEN(6, virtchnl2_ptype);
 
 /**
-- 
2.43.0

