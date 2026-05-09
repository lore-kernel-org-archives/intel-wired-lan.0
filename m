Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA0ACD37B2
	for <intel-wired-lan@archiver.kernel.org>; Sat,  9 May 2026 23:37:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 729D442430;
	Sat,  9 May 2026 23:37:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kEZlJlkh7Und; Sat,  9 May 2026 23:37:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EC6964242C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778369851;
	bh=r29aosCtCj2cefpBkZvqnxVffaLPnzU1untTuZlKxNw=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=1dpvC7GkZXFYYrnezG1jJjhJO/6KEMvcNfv727jlVg9D8gxWXStAaNoZQ2t6L0hPw
	 LjBZYyjItnjMjcCKtAJwMTIx896Pis3oMeq3sQt3iydoD/+7pL9vXm6yYrQlr2hww6
	 VaVM7W1a6puyF3hTp2Q0HZ5IJeMm+zqYAntbjflvPgHK+xUHkWfn7Wh1OPKkSmVrgY
	 tg81G3nerEqBdGrRlH69EqFOvhqdTNgbREM5kQZDCc89M5FtNQZTrm+t32aGDmrjDu
	 WhpNwHtGZl2sqYU7k+7OhTIG38UvmiC/9zfwQt6sl5Scvx1hvPcEkDJbWYgPzTEDUU
	 2zQbdXBHeGlUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EC6964242C;
	Sat,  9 May 2026 23:37:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B8EE25B
 for <intel-wired-lan@lists.osuosl.org>; Sat,  9 May 2026 23:37:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 30CE54008A
 for <intel-wired-lan@lists.osuosl.org>; Sat,  9 May 2026 23:37:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G_t3KkGknSW5 for <intel-wired-lan@lists.osuosl.org>;
 Sat,  9 May 2026 23:37:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=devnexen@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 520F14007C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 520F14007C
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 520F14007C
 for <intel-wired-lan@lists.osuosl.org>; Sat,  9 May 2026 23:37:28 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488ba840146so27392165e9.1
 for <intel-wired-lan@lists.osuosl.org>; Sat, 09 May 2026 16:37:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778369846; x=1778974646;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r29aosCtCj2cefpBkZvqnxVffaLPnzU1untTuZlKxNw=;
 b=nbff9FErNpNzCqKYW/QDzrgQ25h0j4L966CmKZ0Y0z8z8tjt+gAw7EHS9jd/Oyo4dG
 qhNTc8DaRcXp55PXUFDljjGGlkR/Qh7uM6vzugDipjFzc917CTU/mwY+rXkNC+yvltXU
 qcG4sJ6q4SUCPRkg8Yq7Rlcnh201VgdjDRpJdFEm9rsh40t48oiBrL2kq4cScXsO3rrT
 yhiOrFLooOxyOrlunZlEaTTvDsqIN4YaJk7hDjTBFKJVi3V7HvLkCg/OBeKOqH5SzKsa
 t6TC4E3QBs67HR80FGtsccfDZ1l6yTJA1Rp3X6aeJI7IlgelYYhNfjScCmOpgfnUb9ne
 xbBg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+/JR23XPVfWkkM0NaXCIsjwB4MK92z3ozrQjj43KMS/LLFDyMA5Bkg7WJAHex1DtByndZg1I4W3irUfiyKPgo=@lists.osuosl.org
X-Gm-Message-State: AOJu0YzdlVHaXuyfCBOjcJ0QfnWBaugon5GGLiLwZQVB5dTqhscS6B6o
 7PKtAFGDLlHLo4p1oFwSN2+MoylCvD2bVyIxxRNs7b8G9qOWR3omI5+k
X-Gm-Gg: Acq92OFUCgdbuoBxZ6S2JB7X1hvKkvDN8IvZydEwIlZHNeLtzPTzNANQx8AQt0sCLhk
 n6+bRSb0HZe7FPMaBXya8owcl3A2ikPKPF+OcYfaoHn4hXKE6+11jw5N2lPQjT6Rm3Mzk2psArI
 rUppE2wE72RMJwSvHALGw6kYZHJ+dserD5KM8mHNmE7za8Acd8keHEsBTYtgV2p5fxv0dMfv2YC
 KpK14gOrJzgqi43uZB7NvHqChv4WmUZjCClxl5HwV1sOzxPGmwpxK0V8gd0+n3gebWYr+KxDpab
 mElRTi1TGZOT6nBhSNzzghtqx8fxr56a7ua+EtIlOg4KW8ZvN305O3vbDat4vSRzHSObRNGz4Mu
 rG4vlLIsOszUZsRWDufvYOSObxkSlGewOq6voN6FLuD7SWTxo/q8KjKymg3ktVhTi+nKLr04ubm
 7hFaroQikjfKbEDPvoAUq7KU20LjDRlTxOnpaAD3qbY0vvm51vnhizg9vfHB7KoE6Qlk5uf5OgL
 zjUvni+1ak=
X-Received: by 2002:a05:600c:3548:b0:485:3abe:ab86 with SMTP id
 5b1f17b1804b1-48e51e0a6a2mr271656275e9.4.1778369845918; 
 Sat, 09 May 2026 16:37:25 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e6daf496bsm43195395e9.4.2026.05.09.16.37.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 16:37:25 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 David Carlier <devnexen@gmail.com>
Date: Sun, 10 May 2026 00:37:22 +0100
Message-ID: <20260509233722.111895-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778369846; x=1778974646; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=r29aosCtCj2cefpBkZvqnxVffaLPnzU1untTuZlKxNw=;
 b=lpGlBtK4BM2F/1ROC6vMhBLmZbzbIQjsrPZlA8b2lzkyyy68HZxwvCd7VGfsqY6L8w
 22H2FC+Dpolzm03uJO5mfHZixER2KaKZCEJZ2OsNYtgUOpdECe0pNTKWvo6M2C/LKaVW
 R6S2B++3f0kmlPK10BzevrrNk8ylmUmV0RY3AH9MpQLi/kEEVhBu3MNt/K7csdnK7WLr
 wVVO+ArspCTk2E1Efzuwxsek3jyrzDirHGVQU3s6PnY71h4V0jb1HyEgx6WwyelOjh7R
 QGlTcCQRvyfOTt/FyKhyXVVYagKFNMh6cbLsbq2Sa0xvHmEc49m4xSOlVu4iZLpOK11m
 5HRg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=lpGlBtK4
Subject: [Intel-wired-lan] [PATCH net] idpf: handle NULL adev in
 idpf_idc_vdev_mtu_event
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

idpf_idc_vport_dev_ctrl(adapter, false) sets vport->vdev_info->adev
to NULL but keeps vport->vdev_info itself. An MTU change after that
calls idpf_idc_vdev_mtu_event(), which derefs vdev_info->adev for
device_lock() before reaching the (!adev || ...) check.

NULL-check vdev_info->adev before locking.

Fixes: ed6e1c8796a4 ("idpf: implement IDC vport aux driver MTU change handler")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/net/ethernet/intel/idpf/idpf_idc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
index b7d6b08fc89e..3ba52a80d52f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
@@ -162,9 +162,12 @@ void idpf_idc_vdev_mtu_event(struct iidc_rdma_vport_dev_info *vdev_info,
 
 	set_bit(event_type, event.type);
 
+	if (!vdev_info->adev)
+		return;
+
 	device_lock(&vdev_info->adev->dev);
 	adev = vdev_info->adev;
-	if (!adev || !adev->dev.driver)
+	if (!adev->dev.driver)
 		goto unlock;
 	iadrv = container_of(adev->dev.driver,
 			     struct iidc_rdma_vport_auxiliary_drv,
-- 
2.53.0

