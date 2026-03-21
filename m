Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6011094470
	for <intel-wired-lan@archiver.kernel.org>; Sat, 21 Mar 2026 11:51:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 32E8F61357;
	Sat, 21 Mar 2026 11:51:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sDEWLApLzNdp; Sat, 21 Mar 2026 11:51:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0905461335
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774093883;
	bh=oyLTWwt1nTioiwAe9v9UZu9ANFhBTLIrCwfF5jN5Q80=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=q9FMO8px3V2Dyn5ITc3/qKF5tDByxoBFqntbAn3YVmaumjQAHL2iltwXjlhfECo10
	 CMANE3uVac2vLK3hWxZHFijsP2iXGlCairjw30QgQVMTjyDNSYsn2+5Yulvc3blAhY
	 4pzc/HsO/C6djj0zS1Ov1siUaJB6UExJU/9B3tIMZUK73Z3X29SWti12oDnGqrDy7c
	 6d/1LzCzGXnm73+bCg1K83xEASGkO3OdenHEv8DkVpAhMp8cMo9abRM4nhU8FC+Iv9
	 Abfjzl1lPQE3Ppi066hIUNXGF8ysJD4DfDCDo7FQI7IUr8Lfj27GRx+0qKiqnLpeeQ
	 iGk4SHGF3dxYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0905461335;
	Sat, 21 Mar 2026 11:51:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D7A7534C
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Mar 2026 11:51:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C8E0140193
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Mar 2026 11:51:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I0VtZ8B570Ev for <intel-wired-lan@lists.osuosl.org>;
 Sat, 21 Mar 2026 11:51:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com;
 envelope-from=lgs201920130244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2EBE84006A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2EBE84006A
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2EBE84006A
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Mar 2026 11:51:20 +0000 (UTC)
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2ad9f316d68so13893475ad.2
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Mar 2026 04:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774093880; x=1774698680;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oyLTWwt1nTioiwAe9v9UZu9ANFhBTLIrCwfF5jN5Q80=;
 b=Cw4vQu/oDSAALGRZiQSzfFe5nGYbeGcpGyH0NQ2uwIUwIa09nG+auadsh2mGQ3oqxo
 2LHHHOsH8Cc7n3kUNOybdPOZkoAVcD/2km2cqt1fEHoTK7lS0fVha+Ia4Q6TJaiQxffe
 YbAa4ItCJ1Z9hLrBug8BWxv9w3iXjENmot3TYfSMwTCoMkp0/BLV+65w6KwiGrkmSQN3
 kEe6dCozqQKNT5vjjBy0vVJZn06C4dWGQ1+GxVwseP73XPANhky3SXdzSy0U2HxQYU7o
 8OZWuOGQ2WqaP50aaXdGEBaaQ2gUisLRoea4XMzRuO0qEVqiheBxC9JF2iCaVRDHVHLv
 0/Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNyzJRLNm96Nv/3R8vA7+O+9gGffdXzW+nUZ0hOW2JZLfzpk8s3LS0kf+euOJcgtq8eC6EvgB6d7818iKu3IE=@lists.osuosl.org
X-Gm-Message-State: AOJu0YzwoDdkCiDTNfWYA//uhxT4sVg7A4d965RU+zT7mBa6JKqrNUSN
 O+b+KNeEMQKlnDE1PRXjyfKXwREl7MGmHV8FxqJGCygOE27aElZ8LOvG
X-Gm-Gg: ATEYQzwrtl7eBkia2p4dpr0a2NprEh5mxKwQeuae0rSCPgitjT28N1+ivKFhMDw8G0U
 jefAMxka4g9CzuE85uGI/StZLRTCMwk2LEjUJh9+hOj622TZO5xcc+LpS33ng9YD4G0xgt0PFj1
 JXrj54pfZ2cG+8cWhtZ2V90W2NSFXTkRGvxz7ctqA/22rtS+SznYE07I2YnadyAqzJiXUj4yDDv
 iLKqzcK8A5XqHfyvin1UMzAbE4MXpwoh/rpA/YgP+dimz4N1aw7dWiA+akWEoRkO/2QvMTdERNC
 DG5q9GxzmksGB/qlL7gBYoYN7PbJv4NNfEKcGK6txBhLOu4LeqLwYXFBRB9wDh7+yKARxxK17eN
 xpdXVy8PBtev3dKzQEn/23sloCWevVF26XhaZYrcj5+1y0CYkxYpy44Dd2R8TmzSannHyZye3+s
 Sd2nBu7YpRV5NUvfRRCGmPhxbACqqQB2M=
X-Received: by 2002:a17:903:986:b0:2b0:5548:7d80 with SMTP id
 d9443c01a7336-2b08278afd1mr50197575ad.27.1774093880318; 
 Sat, 21 Mar 2026 04:51:20 -0700 (PDT)
Received: from lgs.. ([223.80.110.53]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083516ab1sm67487685ad.5.2026.03.21.04.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2026 04:51:19 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Joshua Hay <joshua.a.hay@intel.com>,
 Madhu Chittim <madhu.chittim@intel.com>,
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Date: Sat, 21 Mar 2026 19:51:03 +0800
Message-ID: <20260321115103.815004-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774093880; x=1774698680; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oyLTWwt1nTioiwAe9v9UZu9ANFhBTLIrCwfF5jN5Q80=;
 b=guYMaKkACghvV4lkcBX61kyRMsN2JqX7QEN2+beUnA2eG1Vsxry6cQ2MYzbOMFa8wH
 /Qyo3c8JQmhyxysVBimaCfSEDE6Ba+wcGJecM3NEWKRixrxKi3xXEstfKwfFg/+ZYEWi
 tJCrXRdnjl5Jj290xcImlVmoStSg48B4Er9i5jQvgLauGYKGPajH+H06wzM5v26roFxW
 8SGHJ+EGo3Hq9d26lBos3wXXq9ROJ7lvfiVMbmTlTCJtIRAB/8QpF0/Yt3ugLeP20y5L
 wEFzh2dv7FRDvH9LAuMRBeVWB7JnAQITL8QDeT7fufRbvFtv31o6IWHjPZQBDiDPMSel
 BWtA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=guYMaKkA
Subject: [Intel-wired-lan] [PATCH] dpf: fix UAF and double free in
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

Fix it by storing the allocated auxiliary device id in a local
variable and avoiding direct freeing of iadev after
auxiliary_device_uninit().

Fixes: be91128c579c ("idpf: implement RDMA vport auxiliary dev create, init, and destroy")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/ethernet/intel/idpf/idpf_idc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
index 6dad0593f7f2..a5e7c42a9e6c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
@@ -59,6 +59,7 @@ static int idpf_plug_vport_aux_dev(struct iidc_rdma_core_dev_info *cdev_info,
 	char name[IDPF_IDC_MAX_ADEV_NAME_LEN];
 	struct auxiliary_device *adev;
 	int ret;
+	int adev_id;
 
 	iadev = kzalloc(sizeof(*iadev), GFP_KERNEL);
 	if (!iadev)
@@ -73,12 +74,15 @@ static int idpf_plug_vport_aux_dev(struct iidc_rdma_core_dev_info *cdev_info,
 		pr_err("failed to allocate unique device ID for Auxiliary driver\n");
 		goto err_ida_alloc;
 	}
-	adev->id = ret;
+	adev_id = ret;
+	adev->id = adev_id;
+
 	adev->dev.release = idpf_vport_adev_release;
 	adev->dev.parent = &cdev_info->pdev->dev;
 	sprintf(name, "%04x.rdma.vdev", cdev_info->pdev->vendor);
 	adev->name = name;
-
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

