Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C036CD98DA
	for <intel-wired-lan@archiver.kernel.org>; Mon, 15 Jun 2026 16:36:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0E4AD4084F;
	Mon, 15 Jun 2026 16:36:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uGF24g3I6SP9; Mon, 15 Jun 2026 16:36:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 40B004071F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1781541377;
	bh=2n7ubYPUbw2d5bbeL3JfwCvMX4qY0mWyFpI+QwTZQf8=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mbZfM0+DSzpo218J6ZmxcOrfI2oZ6Zr9cE5t2wCcMQSOFXdZ6xLsb4tsvVtk1NrSa
	 oYWVCYTnl1IvW015rw2Y14cWuzf/m9thrcGiPEMUxeyCNfBouI3Uw3ECOcPl5O/kQt
	 pMv+bD96yZ8g7eojU37BMNb3lsfslcAYOjdnQ/ShVsGXtuBY6+wAQImE0vWvb8KsES
	 SgIy/A/JPp4frPz+wEEUkUV7wyG81cu89ZPWR8CJgNOq/SCJ+SVKT7p5TCrIF/BvXe
	 uVb3XTU7abP8vNRzieJJohDgnsBuMVW+jpYuqCemoAcrIg3NZInVWnQgFnYq8CuNqT
	 Fct3zkM2MdeQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 40B004071F;
	Mon, 15 Jun 2026 16:36:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A5B9F4
 for <intel-wired-lan@lists.osuosl.org>; Sat, 13 Jun 2026 10:15:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 638F5403D4
 for <intel-wired-lan@lists.osuosl.org>; Sat, 13 Jun 2026 10:15:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TfKLBIkfYS4z for <intel-wired-lan@lists.osuosl.org>;
 Sat, 13 Jun 2026 10:15:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com;
 envelope-from=nobodqwe@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 45B3D4020F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 45B3D4020F
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 45B3D4020F
 for <intel-wired-lan@lists.osuosl.org>; Sat, 13 Jun 2026 10:15:33 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-bed2195323cso268431466b.1
 for <intel-wired-lan@lists.osuosl.org>; Sat, 13 Jun 2026 03:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781345731; x=1781950531;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2n7ubYPUbw2d5bbeL3JfwCvMX4qY0mWyFpI+QwTZQf8=;
 b=hEkYFbKI4DYvLaphuzH/qeUhleinrtcE4cAqNo7gazFS1/DkWvZJlGrX0sPkIijAKW
 q2QAyNaZdVKwr1cz5fHIlpHo4vC2OiLal9NixU+CA1syfvC4N2HWmSVNVlTM6Ua4+OcZ
 roFttSCRvuOZZkdqyev64eRfIgvFydJ4iSdiedsU4gc8ktPu/yS7hb2oU+6aXaHDX3fs
 PGvIc7WTsG4q9YIRX1SZibXpaW6TRvLsUW4qMH5LaXEEb/FAnNHncfbN1fcnn+xwHdIV
 tc9fa//NYaubsFGeVNa6RnC3rCt0Kd12eCOkha/eryCI6KqRZW8mSwZ8bJP2B8e0cqIu
 5kCg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9VI0YXOBRoYhrAXk2YFaWOGRey7K3Z0084u73Y/+wG21VJIVbxlyFSN+xqc8cYUBOEt3BmbfF1HA8/ehlXxeU=@lists.osuosl.org
X-Gm-Message-State: AOJu0YxeDEWcvEFWTO2EN+4GfralF39oMVIUjPpWL4EETN2ulA5kcnJT
 fJx1yzpNqbVnVBv9SzmH+cBMW/agNlcdg3TIR/cv0kQvd7KvK14Iyvs=
X-Gm-Gg: Acq92OEgZZ14YAPqB8SPoyWiVRaD+NMuI5Zeb5e3AaP2fhD1fza7xMhFf2Oc57EbTLy
 oM+F4zK+M1oY9D3It3t4+kEj72AIjZpv2pnOaLQVLa90+NRqW6KoTrZzqGhGXJ7SxrVhFuGPPn3
 T+Dq46tgkYyD621elKdlejM1FkD4X+tbrOLWH+fJ4K5RMSLks84Kv0f2oboOiENaN3tZ4CzO7dz
 Ol4538eKDqIuLmOxlD8/yc2W25/DNSEKFGdg8jjSHc1mSjtmMdf4nabinigI/optEw84Gi8yC0G
 ywlqufSrkhvQHY9dFiQJIIUb8elgUc/GCs5LFFj1o1/qyPwGiB+oZ0fY69iKcaafJVHDEeoRBii
 cLW7gtpO+sR7zljriqb2mQ7mqe2gFKLRkDkDc5KnvtlTktpWAeuH9KdhQnDvvMJko1ERJqZZMHI
 ae9K8f+5b2pMWh17SbMYJDIxUQbErpW+Y2ihuDq0+19Sqf
X-Received: by 2002:a17:907:3e94:b0:bd3:6ec5:f141 with SMTP id
 a640c23a62f3a-bfe28e1ce2dmr369247566b.30.1781345730843; 
 Sat, 13 Jun 2026 03:15:30 -0700 (PDT)
Received: from archlinux ([2.26.254.81]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfdb9113103sm200076366b.63.2026.06.13.03.15.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jun 2026 03:15:29 -0700 (PDT)
From: NeKon69 <nobodqwe@gmail.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, victor.raj@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, NeKon69 <nobodqwe@gmail.com>
Date: Sat, 13 Jun 2026 13:14:40 +0300
Message-ID: <20260613101440.80190-1-nobodqwe@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 15 Jun 2026 16:36:15 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781345731; x=1781950531; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2n7ubYPUbw2d5bbeL3JfwCvMX4qY0mWyFpI+QwTZQf8=;
 b=B9oAUQQ0VMWOgBzogDQ3vxtFLWMPyNvJgrIfbzaBzmoL0gWnai3vkQ60hh3/31+nVD
 14OXp9Y8YhkzAGgjjoQrydsfgmGEgyxvB1sYVip9NjJkCb8SirjfHk5Oo5J/eMBIqYYI
 FG43ZGzU5/eYQIkUqeluH3f3HxlhXba1emzKmq5yjsTupEDfZoavBRPWBerw9iEQV8K+
 kTbBKsFwYy5LxdxK8zb72iUGKVMrvWSB+ibXKbbGDqdIvwxhVXUOod5XcOSGhevlIHIe
 V8TUO+89M3UrYQxG02DGMaurnyqsMQhqcgIl4NF8rPaCM141biNmaiFjQjspzo0hxuic
 4hRA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=B9oAUQQ0
Subject: [Intel-wired-lan] [PATCH net] ice: Fix use-after-scope in
 ice_sched_add_nodes_to_layer()
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

Commit 7fb09a737536 ("ice: Modify recursive way of adding nodes")
changed ice_sched_add_nodes_to_layer() from recursive control flow to an
iterative loop.

Inside the loop, first_teid_ptr may be set to the address of a
block-local variable:

	u32 temp;
	...
	if (num_added)
		first_teid_ptr = &temp;

On the next loop iteration, first_teid_ptr may be passed to
ice_sched_add_nodes_to_hw_layer(), after temp from the previous
iteration has gone out of scope.

Move temp outside the loop so the pointer remains valid for the lifetime
of ice_sched_add_nodes_to_layer().

This was found by Clang with LifetimeSafety enabled while testing C
language support on a Linux allmodconfig build.

Fixes: 7fb09a737536 ("ice: Modify recursive way of adding nodes")
Link: https://github.com/llvm/llvm-project/pull/203270
Signed-off-by: NeKon69 <nobodqwe@gmail.com>
---
 drivers/net/ethernet/intel/ice/ice_sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index fff0c1afdb41..089ad3967be5 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -1074,11 +1074,11 @@ ice_sched_add_nodes_to_layer(struct ice_port_info *pi,
 	u32 *first_teid_ptr = first_node_teid;
 	u16 new_num_nodes = num_nodes;
 	int status = 0;
+	u32 temp;
 
 	*num_nodes_added = 0;
 	while (*num_nodes_added < num_nodes) {
 		u16 max_child_nodes, num_added = 0;
-		u32 temp;
 
 		status = ice_sched_add_nodes_to_hw_layer(pi, tc_node, parent,
 							 layer,	new_num_nodes,
-- 
2.54.0

