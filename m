Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20EF6E810A4
	for <intel-wired-lan@archiver.kernel.org>; Wed, 27 Sep 2023 08:32:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D12764210A;
	Wed, 27 Sep 2023 08:32:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D12764210A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1695803549;
	bh=D9vXBMeqGN4shLJ8gUqD+RhuVqZD92nvJcZkbrUM/bE=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=3m/DsRvjaqrpEaWrNuxhXpGIFW2zqlfNqp5qisLvQql2Y3bmIxHxDkHirbxjA41Wh
	 Tk4N+1KoxxuWyeEkPQjLOGXaDSEO/8UyhaW01hlNpa3x2Sr4DJUDSpGrWhcmq2tl8Q
	 /Ltk03V/iPj9LMr6kW/eKPRs87keTLUU8NhL2zU/GCXLfTtT/2lB+hU1Tjlj6nF4i8
	 D2Sc9DpfcSGW0LoNmsTLfhMODV9If6+nO1NpMFo9i6kLXrmKZwVg75SQwMf0AIcgsg
	 rpfAQZSH7+0fHaJzzIME/V8AKBpqd6E/GTCMw0ijpDXPYawrvJKwVZOS8lk6Hf+1Dd
	 BRRsJhnDmJQnA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hirb1ptx_IXi; Wed, 27 Sep 2023 08:32:28 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id A7097420F6;
	Wed, 27 Sep 2023 08:32:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A7097420F6
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 5ABE11BF5DE
 for <intel-wired-lan@lists.osuosl.org>; Wed, 27 Sep 2023 08:32:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 343B94117B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 27 Sep 2023 08:32:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 343B94117B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aqJ_kQMrDAQD for <intel-wired-lan@lists.osuosl.org>;
 Wed, 27 Sep 2023 08:32:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5CB73408FC
 for <intel-wired-lan@lists.osuosl.org>; Wed, 27 Sep 2023 08:32:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5CB73408FC
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-JaT273wkOba_BfGclRbSbw-1; Wed, 27 Sep 2023 04:31:56 -0400
X-MC-Unique: JaT273wkOba_BfGclRbSbw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01216185A797;
 Wed, 27 Sep 2023 08:31:56 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.119])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4417B200A6D2;
 Wed, 27 Sep 2023 08:31:54 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Date: Wed, 27 Sep 2023 10:31:35 +0200
Message-ID: <20230927083135.3237206-10-ivecera@redhat.com>
In-Reply-To: <20230927083135.3237206-1-ivecera@redhat.com>
References: <20230927083135.3237206-1-ivecera@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1695803520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ale7t5nl21L3c6+f7HGf39TkfmwA9pSSLTtCbVSuLOg=;
 b=FM0JsOf5Jeeg8ZJBy1Lk0pBFgF0Gf5G/RZ2FZ7Npp5cIoRVo4BZh/uMT+IGcybu4dedC40
 g3Pi5aML9eeD95hs2BMnHJQ7OlaVVPGSjXl9OKBwTEvbvVdWLjpiCoqNPFc75z0kmV55lt
 sGThenGP6tLV9lbfv1ondEulibdif2I=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FM0JsOf5
Subject: [Intel-wired-lan] [PATCH net-next v2 9/9] i40e: Move DDP specific
 macros and structures to i40e_ddp.c
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
Cc: edumazet@google.com, intel-wired-lan@lists.osuosl.org,
 jesse.brandeburg@intel.com, linux-kernel@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Move several DDP related macros and structures from i40e.h header
to i40e_ddp.c where are privately used. Make static i40e_ddp_load()
function that is also used only in i40e_ddp and move declaration of
i40e_ddp_flash() used by i40e_ethtool.c to i40e_prototype.h

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h        | 24 -------------------
 drivers/net/ethernet/intel/i40e/i40e_ddp.c    | 22 +++++++++++++++--
 .../net/ethernet/intel/i40e/i40e_prototype.h  |  5 ++++
 3 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 107826c040c1..214744de120d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -4,7 +4,6 @@
 #ifndef _I40E_H_
 #define _I40E_H_
 
-#include <linux/ethtool.h>
 #include <linux/pci.h>
 #include <linux/ptp_clock_kernel.h>
 #include <linux/types.h>
@@ -296,29 +295,6 @@ struct i40e_udp_port_config {
 	u8 filter_index;
 };
 
-#define I40_DDP_FLASH_REGION 100
-#define I40E_PROFILE_INFO_SIZE 48
-#define I40E_MAX_PROFILE_NUM 16
-#define I40E_PROFILE_LIST_SIZE \
-	(I40E_PROFILE_INFO_SIZE * I40E_MAX_PROFILE_NUM + 4)
-#define I40E_DDP_PROFILE_PATH "intel/i40e/ddp/"
-#define I40E_DDP_PROFILE_NAME_MAX 64
-
-int i40e_ddp_load(struct net_device *netdev, const u8 *data, size_t size,
-		  bool is_add);
-int i40e_ddp_flash(struct net_device *netdev, struct ethtool_flash *flash);
-
-struct i40e_ddp_profile_list {
-	u32 p_count;
-	struct i40e_profile_info p_info[];
-};
-
-struct i40e_ddp_old_profile_list {
-	struct list_head list;
-	size_t old_ddp_size;
-	u8 old_ddp_buf[];
-};
-
 /* macros related to FLX_PIT */
 #define I40E_FLEX_SET_FSIZE(fsize) (((fsize) << \
 				    I40E_PRTQF_FLX_PIT_FSIZE_SHIFT) & \
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ddp.c b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
index 21b3518c4096..6b68b6575a1d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ddp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
@@ -4,6 +4,24 @@
 #include <linux/firmware.h>
 #include "i40e.h"
 
+#define I40_DDP_FLASH_REGION		100
+#define I40E_PROFILE_INFO_SIZE		48
+#define I40E_MAX_PROFILE_NUM		16
+#define I40E_PROFILE_LIST_SIZE		\
+	(I40E_PROFILE_INFO_SIZE * I40E_MAX_PROFILE_NUM + 4)
+#define I40E_DDP_PROFILE_PATH		"intel/i40e/ddp/"
+#define I40E_DDP_PROFILE_NAME_MAX	64
+
+struct i40e_ddp_profile_list {
+	u32 p_count;
+	struct i40e_profile_info p_info[];
+};
+
+struct i40e_ddp_old_profile_list {
+	struct list_head list;
+	size_t old_ddp_size;
+	u8 old_ddp_buf[];
+};
 
 /**
  * i40e_ddp_profiles_eq - checks if DDP profiles are the equivalent
@@ -261,8 +279,8 @@ static bool i40e_ddp_is_pkg_hdr_valid(struct net_device *netdev,
  * Checks correctness and loads DDP profile to the NIC. The function is
  * also used for rolling back previously loaded profile.
  **/
-int i40e_ddp_load(struct net_device *netdev, const u8 *data, size_t size,
-		  bool is_add)
+static int i40e_ddp_load(struct net_device *netdev, const u8 *data, size_t size,
+			 bool is_add)
 {
 	u8 profile_info_sec[sizeof(struct i40e_profile_section_header) +
 			    sizeof(struct i40e_profile_info)];
diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index 2001fefa0c52..46b9a05ceb91 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -4,6 +4,7 @@
 #ifndef _I40E_PROTOTYPE_H_
 #define _I40E_PROTOTYPE_H_
 
+#include <linux/ethtool.h>
 #include <linux/avf/virtchnl.h>
 #include "i40e_debug.h"
 #include "i40e_type.h"
@@ -497,4 +498,8 @@ int
 i40e_add_pinfo_to_list(struct i40e_hw *hw,
 		       struct i40e_profile_segment *profile,
 		       u8 *profile_info_sec, u32 track_id);
+
+/* i40e_ddp */
+int i40e_ddp_flash(struct net_device *netdev, struct ethtool_flash *flash);
+
 #endif /* _I40E_PROTOTYPE_H_ */
-- 
2.41.0

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
