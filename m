Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72819EBFD3E
	for <intel-wired-lan@archiver.kernel.org>; Mon, 13 Apr 2026 11:20:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4248F60EA1;
	Mon, 13 Apr 2026 11:20:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id unxUxV5DSjuq; Mon, 13 Apr 2026 11:20:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1972460E91
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776079251;
	bh=iQ7f9KI9JqtBNgCC6+8bgvZa6CW8q9FixqdbvIgHfKA=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=6DxwWetIvLtwxfFN+0ppEWT1OSps7oGn+v9Kdgh8WQTpJJCnVzig5Vs1jGntsX0Xc
	 7RjED9RMPsEl2j412F9S3LgJ9osmQDme/l24mmu+xPsHI4QkSX34gDWf6AyCSONHEk
	 lhtv9UHCQI3oqLVx+C8/dWPUIx8GIbT+lLeYGbAucw2isCGAP9deklf6QRscrnoHVV
	 VGbOJO0QMGbxjtr0Bch29gIjJc/EsZxXkpMfUUbG3K/m5Z6L2OfHp9fy80dmeUWiVc
	 8FQY7fknejYIbUX9fKOKHaNM0JRrYJYO22JnqhxD44bhKSnz3QjRzXj40/THYrMncJ
	 UB9+ZZEuC6ybQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1972460E91;
	Mon, 13 Apr 2026 11:20:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 093C1194
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Apr 2026 11:20:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E4C9582384
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Apr 2026 11:20:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LXu0p8dE60iZ for <intel-wired-lan@lists.osuosl.org>;
 Mon, 13 Apr 2026 11:20:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com;
 envelope-from=lgs201920130244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4A5A98236D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4A5A98236D
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4A5A98236D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Apr 2026 11:20:48 +0000 (UTC)
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-82f22f6b0feso736728b3a.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Apr 2026 04:20:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776079247; x=1776684047;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iQ7f9KI9JqtBNgCC6+8bgvZa6CW8q9FixqdbvIgHfKA=;
 b=IjQV5Qst7g0ofP427f24ccEUpKGmI9aAumgU83T42uhZL0XMdZbfxl1/N4G6Zxajjq
 841djbJIjrVmrBlV7tB8miyxB0cTaC/gtTn8ga5nyjt19BAIOkgynPYIXXBhpOZKhgQK
 aotGbsVLfg75XAuuyhX1kwJlYz5LCyT5JuDLTJi/hLLLxcInokCB1494eiCgKf5qAvbm
 TkxzlwrA+acXFFzQkgqthVHOcfPGuoR3Od5ZLGDv96VsBlklnhhTBvhH3uOxL5Sykeno
 W4W5s/5xp78ZIdh4x9xQZLTDWLUIT56zCK7TQ6yVfq/b8bEYOj8xjq6zHf4BnFZijFPy
 kkrw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/FvCCh/7FYZtovMUjRKS/Fa9AhGwUG1SY4QK8hU1sT/livEEiMiZMHx2JZzbCZbaPpIUj4spwf/1/XUFBTs4s=@lists.osuosl.org
X-Gm-Message-State: AOJu0Yzrmh6W5ZasMEHUshN0GH8LbalPWVkIpdgej7TWT9tUsMK+Jnw5
 0dLewoMwGnzOIAIxCXmbg/gLMPXrpopRj13ZDPqD5OpOv/ZNG8GEIFRJ
X-Gm-Gg: AeBDieuGDSwhRbm5L0C0rWs0lDn8STmKspbdLGxgY/JpVmEiiBWeAXDhaF5NHQwpl1u
 1wfjf7hniFhxJ4s5oNcD5trqhcZSLki/eVlwAfHPHJ8Y0cTfdefBJhPRsKaNO0e82FBgnY2QL3S
 JQb3qfdrZAYuHIpwAddNx79Py5Jhz629HT9vKdnbA0TpGtlp/wrFxiOkfZpdBcTOVdbuwAVhFzx
 AkNSvejW7fW4glAl04D8H3RScKdzn8BnSNehrg6+Lweo1F3yQDDElxVq33a9fwm8hcQpbaROyt5
 jMxAHlMsow8HpmDHPRtuSsJAF6/J7WJHEwTDhSPGRQgv7aNI6Yq0TufmJyUuyZVNsTX4qNCMGCC
 dDZiVEWnyXv4Dd90sECde/t2+gKl/V9C78udk3xm0CETXpzkQ1EZee9/42ek1EfyT3AAK3XMfQn
 oXp/C7n0VqJGPdvQ==
X-Received: by 2002:a05:6a00:1887:b0:829:924c:348a with SMTP id
 d2e1a72fcca58-82f0c26b71fmr14463158b3a.45.1776079247519; 
 Mon, 13 Apr 2026 04:20:47 -0700 (PDT)
Received: from lgs.. ([101.32.189.54]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f0c4df7f5sm13555346b3a.43.2026.04.13.04.20.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 04:20:47 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Joshua Hay <joshua.a.hay@intel.com>,
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
 Madhu Chittim <madhu.chittim@intel.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Date: Mon, 13 Apr 2026 19:20:30 +0800
Message-ID: <20260413112030.2694563-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776079247; x=1776684047; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iQ7f9KI9JqtBNgCC6+8bgvZa6CW8q9FixqdbvIgHfKA=;
 b=JII1BoFIAOicR6mVj6LklhffFCEeVPjzlADMLwbWau1BKznfJ9GM1qgrLKq7/K6yts
 iogY4sRoU3jOhkyB1d7fliZOn6GxnLvh6qhfcF85JgQOUb1FC9L18qOqW0rcFabcTu4b
 vyJ5zvQAGz/mdoxmSmGSbWpHOAaf+vC329gWg4PNvzHvO+s75rAwU35mMykOw0eN3maj
 B3RGNiU6B1lsHHGwJEKgzQ5b7MP6Q58URoZzXaqDMMeaGLRVqZz2n/wtWU4L5SR/Q/M9
 vj8R3UY+WzxvVd5Dh404aGOd+LhGzkQ4nEA8DUHmDkRcNDhmNC8B1E/aBEKyBXDmXlV9
 Vx0A==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=JII1BoFI
Subject: [Intel-wired-lan] [PATCH v2] dpf: fix UAF and double free in
 idpf_plug_vport_aux_dev() error path
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

If auxiliary_device_add() fails, idpf_plug_vport_aux_dev() calls
auxiliary_device_uninit(adev), whose release callback
idpf_vport_adev_release() frees the containing
struct iidc_rdma_vport_auxiliary_dev.

The current error path then accesses adev->id and later frees iadev
again, which may lead to a use-after-free and double free.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fix it by storing the allocated auxiliary device id in a local
variable and avoiding direct freeing of iadev after
auxiliary_device_uninit().

Fixes: be91128c579c ("idpf: implement RDMA vport auxiliary dev create, init, and destroy")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - note that the issue was identified by my static analysis tool
  - and confirmed by manual review

 drivers/net/ethernet/intel/idpf/idpf_idc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
index 6dad0593f7f2..2a18907643fc 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
@@ -59,6 +59,7 @@ static int idpf_plug_vport_aux_dev(struct iidc_rdma_core_dev_info *cdev_info,
 	char name[IDPF_IDC_MAX_ADEV_NAME_LEN];
 	struct auxiliary_device *adev;
 	int ret;
+	int adev_id;
 
 	iadev = kzalloc(sizeof(*iadev), GFP_KERNEL);
 	if (!iadev)
@@ -74,11 +75,14 @@ static int idpf_plug_vport_aux_dev(struct iidc_rdma_core_dev_info *cdev_info,
 		goto err_ida_alloc;
 	}
 	adev->id = ret;
+	adev->id = adev_id;
 	adev->dev.release = idpf_vport_adev_release;
 	adev->dev.parent = &cdev_info->pdev->dev;
 	sprintf(name, "%04x.rdma.vdev", cdev_info->pdev->vendor);
 	adev->name = name;
 
+	/* iadev is owned by the auxiliary device */
+	iadev = NULL;
 	ret = auxiliary_device_init(adev);
 	if (ret)
 		goto err_aux_dev_init;
@@ -92,7 +96,7 @@ static int idpf_plug_vport_aux_dev(struct iidc_rdma_core_dev_info *cdev_info,
 err_aux_dev_add:
 	auxiliary_device_uninit(adev);
 err_aux_dev_init:
-	ida_free(&idpf_idc_ida, adev->id);
+	ida_free(&idpf_idc_ida, adev_id);
 err_ida_alloc:
 	vdev_info->adev = NULL;
 	kfree(iadev);
-- 
2.43.0

