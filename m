Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0147606A31A
	for <intel-wired-lan@archiver.kernel.org>; Sat, 24 Oct 2026 16:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=rS3BTcge;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FZqV8o47
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA66740688;
	Sat, 24 Oct 2026 16:24:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OzYl987EMRoB; Sat, 24 Oct 2026 16:24:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2FE944064F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792859053;
	b=Ycb0syz5lC1RmwghDqZvW5f44KMG17DctamY/0PGHkez2F7J/g05YyWcuPh3xFEiVklo
	 TKRxIZ1oowZdphKNuSOxAp1jg3k8GzLnI+Rr9Cc+gWDTPN8SnN4cJuDdj0TSy7vMNKZs+
	 vGWjRRo3/qNwoB39gLDNHYgiDimGDXY0w0XTSpGZ3CNXsTDO7tPcJiOfXalgoz9YF16YF
	 7zoKkEJbi8fsISUhAaFKknOjn0HBixXCz0QSqG9d00L4vXG0yMecgBdiHW9SZf5zRsqic
	 W6hxj8aHeS/VMB0BJ823Oa1QXuAZgsjOMFF27HPJzAEUu4/IwxuPxzTeSGLm4E1O//g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792859053;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=pPR0LJl2l94QbeUT9FulqVDPY0pe4vv+IF+HiDzRSec=;
	b=IPRfjbG48cRxlFVEuAMwVL7UjHxQR9avq6nIXusWXCsMv3StEWqGtmXe3nJb7vJS20xI
	 igqYUtFQtAMp29fFNNhfLAeuXvvjOZcPDlHr0nFLXM/LzvAdqSkj+CeTpJS1Skgyx35in
	 sW29Hd/I/swIUAUJw5jMCBku/N+CBm58RLOCAPtKc15Uf/vKhxPLJiTAWI8oq6QP2k5MB
	 fMH4yKYWapZXYtyyOKLK4XACNl/vlELl+da4cxxSdstaF81DCyUO/xwLWk1/OorzSua+T
	 50EDht8iZF+rdkAERDKfnO/wR8oxDwBH5hxnrUQYdXboL8Yk8xKKLnct2dx6V6NKvvw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792859053;
	bh=pPR0LJl2l94QbeUT9FulqVDPY0pe4vv+IF+HiDzRSec=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rS3BTcge+u3Ba8HzWhGRNTIZAYTJkq7LFSyzvAfRfx8/JsQ1/k2gfURgpNlgMZXxo
	 w/tfXBQKo+Tlxx2g7w9/MChDyjrH6Mo22Ii0LH9GSI9N+olPq5jkbWTvTI+uxzbDGs
	 XczjeC5rUF+GMIBH9cmA4AkMuMVbupepyJStKVflGeeCqRghi7eDkDTTkqxom4EVWD
	 4Fffpnz7nB+DNH5pl5F/j6DfmFMsBnsZ3LAC1EQRP8nYsoF8vckxMcVWOLYPHFZUze
	 oDWB4qmVpjbieMnZfpLVUSmayYrSlMXedIw0Zigd3xMwr+1O/x/vbvLHKZrgEc1WMc
	 3CrD0z2edUfiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2FE944064F;
	Sat, 24 Oct 2026 16:24:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DF5FF380
 for <intel-wired-lan@lists.osuosl.org>; Sat, 24 Oct 2026 16:24:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C563D6062C
 for <intel-wired-lan@lists.osuosl.org>; Sat, 24 Oct 2026 16:24:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8azpDm0i5hJg for <intel-wired-lan@lists.osuosl.org>;
 Sat, 24 Oct 2026 16:24:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C4D9460628
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792859051;
 b=Sp/5+6DjESl29fl2ntNcryhO3KOn/tGS/qSWYbY3XohyXHbHaXMuHPV2X15RKUfN+1S8
 YbmUi9ehnBbufH+ObvRtiu2KSB2P6oHC29SnN09HFObQBgcknjlAoFdA3qwSsfntDaSCJ
 Z6iREsdnsFPbICKySZOp2ViCyfDOKp9/d5A5znB14W4u5DC7kQEkb9Tnf/IACjP3eaRf5
 nvIkujRK/e0cLC6F4c2aeNHjSeGBff4uQxzhkG1YivxqCFZwMEEJWfk2GGma+o/y8jhZO
 xPyycFA73Q9VCok0EC14lMulezMRrcrLiqGEuuNrWBx753qisO6869z7G5Z18mMsC3A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792859051;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=pPR0LJl2l94QbeUT9FulqVDPY0pe4vv+IF+HiDzRSec=;
 b=gxIeWLgaHdKCCiEpzmqWfG50d7SHCI2AufPoAla2BjTL5saWpUNXneAm4cYUIrqOAvii
 G/jhpvEubQzRQijBfSUrIgRNzB0aozaWhwv1lbu10yiaL/eDQPm6uTCphuLy1GprDYnX7
 nhiYv8lv7b4qJ9k8N89BmawOMYEJ+jx5vaRITbH7JeSNpJHx47L6OnwFAat9PodSeHQ+j
 HkDe9KbUj0U+/iqm6CG0tuIpV0CNg6mR17v9LWAXPep7aCVDTSJzCuamrUHFO/7XRnXQl
 tca4vLaYY5ab2d5ZHEUlNhN67Nnbhn+ebPXGReBMMYXIeblEU3f60xBCq+9XbFVKE+g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=FZqV8o47; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=sashaneftin@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=FZqV8o47
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C4D9460628
 for <intel-wired-lan@osuosl.org>; Sat, 24 Oct 2026 16:24:10 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48df4f540ebso970028f8f.3
 for <intel-wired-lan@osuosl.org>; Sat, 24 Oct 2026 09:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792859048; x=1793463848; darn=osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pPR0LJl2l94QbeUT9FulqVDPY0pe4vv+IF+HiDzRSec=;
 b=FZqV8o47Uo44HZ3qXYuAvaxfkIZutViE9FOv9hNjjbPXcEhjFYIoWAfPLwQdi1bsvn
 xps/oECHAyRCiRl9SyWROBXhJAyIxd2sTmrvbUmikPRYLcYSt1U31zlxeHIwz8HBJTkf
 JYbdorOW2/my9zQrX5Ggi18pdL2O5r2LabhlxcvBAoiHDw9aiesVHKph1JzQfnm8VprX
 kXxhilP7n71lfd/kAFXfOkbuG973xVKW+aEgejRWFSCmeXxqKZYlynkil7/b4OEcF+TC
 AgKtznxor6d6WHpIhT5G5z2EH4z/nI9UOPyxXWytZcJoLRarlQAubx8Vuyr357wg1G+p
 fuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792859048; x=1793463848;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pPR0LJl2l94QbeUT9FulqVDPY0pe4vv+IF+HiDzRSec=;
 b=H/kBSjEzlJKmDIEcLB6Y6OYDrszc+ek9ad8GceIWqxIboMxeBKM+MTnZhOTlBRrBc7
 Psc6EUDSdG6jWLsxQ2Vfn+8aZksJPdDBM6g3xQBO98ZLHCWOpQb/ddUdCGfapfvQcm0s
 Fc3rQfXOxIvzeE4f+N6/ck0hOJuYNcqeFTlTm7PoVqYVDQ0eAGiJGgSnX48mWn1OHqHK
 akUFqcRX9EE9lbx2Akagqu+9fmReJ5B/QFFUaYJz1Z4dY69baNPdL5KSfuyZrFrNdADJ
 2U9dXEb24fkc/UwOv7cTaVXqhb4zwQ23I9lm1Qt9Xsitzap8bsBjrpc9uwAdNWphc7fI
 Z0Yw==
X-Gm-Message-State: AFq9FYLEbGkKdI4ZLNS22eZK6nL2HL93f3FABnX43NJg/LqEODzjx5o9
 WSMKLd0mPRBBditmfoTSbJts7SixfquEfxXHk64qjcVqG0cFkJIC+8ldR267Ug==
X-Gm-Gg: AYBFou1ftMVzD7L7nwk16aTmlhcLEH1zHZVUr1D3BmkTeek465UZRgNRbaixZsm18SL
 8jtZoV4AB90g97peGmo85eZyocNHMClszZGy5GXclUcv98MmFHx9I0Xwydy5H7u4BipLs/DHZ1r
 VISNnqGRPwzHZt/4U8Jixz+RZWOLeWUP0yq0TuejnBjRMqKC6StuoyS2v9acV7vE6XEu3Td5GJq
 ICCflrgTGPFdV0jIg+FOIpVytYLFnbvykGDGBVxy48S/yBhunURaAi+hc8tlMJGYaZIwzLFkU0W
 uIJ0aBvu7gRHL5qsGnRvVuP1SyEiyovcplC45UgsOjIiwK6xjPh5ltnhjFWIGXKzylbQtK24N35
 j0HsKvPkb51vGIAYtjLMVEpugzM++hH0SsyGFQ3bNuevzmYirETDlLRIAGrJZHupUAcBknHO159
 FncTfVv+MYwttCfU03ZIj84tH/w1IzUptriiVDqNOK82VEGUeYhYaw3js/K/oD4jwJODVJ6KiD9
 oywwOkcS9kiUqlt9E9+qdVGOGCookK6O9ZnKUFE+GG2Pig+GfhIujbO11ubeo20Rr6e9HsmjnBj
 UDL2Dj6UeriWbVmds7pFAXc8DhLj3cnoMGHerXM22tw=
X-Received: by 2002:a05:6000:481b:b0:48e:2f55:8c4a with SMTP id
 ffacd0b85a97d-48e3eb46bafmr3968998f8f.4.1792859047901; 
 Sat, 24 Oct 2026 09:24:07 -0700 (PDT)
Received: from sashaneftin-pc-GB-BSi5-1135G7.home ([185.175.35.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3dcbsm5125505f8f.14.2026.10.24.09.24.06
 for <intel-wired-lan@osuosl.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 09:24:07 -0700 (PDT)
From: Sasha Neftin <sashaneftin@gmail.com>
To: intel-wired-lan@osuosl.org
Subject: [iwl-next, v1] igc: remove redundant headers include from igc_tsn.c
Date: Sat, 24 Oct 2026 19:24:05 +0300
Message-ID: <20261024162405.133786-1-sashaneftin@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

igc.h already includes igc_hw.h and igc_hw.h already includes igc_base.h,
so the explicit include in igc_tsn.c is redundant. Drop it.

Also, fix a minor typo in the #endif comment in igc_tsn.h.

No functional change.

Signed-off-by: Sasha Neftin <sashaneftin@gmail.com>
---
 drivers/net/ethernet/intel/igc/igc_tsn.c | 2 --
 drivers/net/ethernet/intel/igc/igc_tsn.h | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index d23a45a34fa3..868334e9e396 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -2,8 +2,6 @@
 /* Copyright (c)  2019 Intel Corporation */
 
 #include "igc.h"
-#include "igc_base.h"
-#include "igc_hw.h"
 #include "igc_tsn.h"
 
 #define MIN_MULTPLIER_TX_MIN_FRAG	0
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.h b/drivers/net/ethernet/intel/igc/igc_tsn.h
index e08f48543d99..caca3720525e 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.h
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.h
@@ -67,4 +67,4 @@ static inline bool igc_fpe_transmitted_smd_v(union igc_adv_tx_desc *tx_desc)
 	return smd == SMD_V;
 }
 
-#endif /* _IGC_BASE_H */
+#endif /* _IGC_TSN_H */
-- 
2.53.0

