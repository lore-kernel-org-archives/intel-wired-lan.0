Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35860CCF2C9
	for <intel-wired-lan@archiver.kernel.org>; Sun, 18 Oct 2026 18:54:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C254680DC7;
	Sun, 18 Oct 2026 18:54:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OZQt20sZnZNO; Sun, 18 Oct 2026 18:54:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 367C480D01
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792349640;
	b=XBZ/2KEpEDOft6MwKo/QPm6XxwPtQbktmf1/2gNCmEyHiTWjw7diwriHW3kVdu4/E44E
	 lkSGKzKK1cwgnF8NgWe46F1YUrvPui7Q3bIPUBctONUJHCdQ4I/OUJrw13WwvP1yefZza
	 oXelGTMYtwZ0KQGwkA3rjGvnozxj+77fy3k+D0WNom2hW0AMTEFf5vqrU/nJU8zG9bcVO
	 0WO/5fOreI2rgOLtsfzPczPT1yMu+G58HYQfD7vIzRIkBwQq6JyHA09gl1TFo5SKd2Nfo
	 pAB68k4HaVXkuEIMC9vtKRKVB/ZnchSTrWOno3a1uHZFIJAsO4Qgt5SbVhpU5bqrtyA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792349640;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/3fg+lkov9OBgqy1YYngrJKFNVHtl6ib2jKnzWngp5o=;
	b=jiH38PmFHUzrKMIvZCR1R6GqNxWUNaTNZpOA4ASbj5YJDb0eD1BL+uTRA4QVcLTiID0j
	 wxQ9JMaZFuLMfGfcUIdISe4Dam32BRjcqzzgnzScv8TF7K4kIP7adLLDMNQRS/FbHPMQm
	 oXQZ8OjSTJ5jx2KqopxnYhvoz9DdezdFux1r1fmdCXUk2F/ImoTM+G+huE6VjU1q0vPLl
	 QV4L2AOZXYFurAXUFFD691geoHrNsPQ23NVXNRaROQyMywFJhd/04MHe36MODLlu2hikq
	 Sgbl8jKtSfdnihV5mnx4aDsBFj6amm6tLIRXAU+fZpVLafjBzsRmcbFw6e1PekuR/xQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792349640;
	bh=/3fg+lkov9OBgqy1YYngrJKFNVHtl6ib2jKnzWngp5o=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CfVtVf5AuZPb+JfjGFDSaAPMeLgsWCo7gK/JJNNK6a/IGBUue+tlsQtiG/APHuEC6
	 aAkK7ulezNuwXnb7opHOtI5uSq9anxV6+1WAnHtrFWhKIPzbm1zSBWEZ5sH8aL2Tn9
	 6J5c/rYbfcY4bvcbcymEfR8T0prFmDKVd0gVaOouUwIuoMXvxplS9ndKJN8dJ+7ZzI
	 teDTZrNKZRsPnC3rzsIfMtXVFNlZbiNOSTz+BW3NLzpkcf/zANuZEJCQrWwkb9UTZ4
	 WfKbGiOSU4YNdEzjY95BzWc+2s/Pjic5mnzVuRIUU6KdOU0zpbp1EfZz6sZqC2cGC2
	 PpPluYG4CelTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 367C480D01;
	Sun, 18 Oct 2026 18:54:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7822B2A8
 for <intel-wired-lan@lists.osuosl.org>; Sun, 18 Oct 2026 18:53:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6A73D60622
 for <intel-wired-lan@lists.osuosl.org>; Sun, 18 Oct 2026 18:53:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mLj4qLpcws6F for <intel-wired-lan@lists.osuosl.org>;
 Sun, 18 Oct 2026 18:53:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 96F7E605FC
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792349639;
 b=XlToS2b/mPyFWwSDerfSnWjZPZqE+q5sh/0EyNfRIaq1SoSSf61UgTUXihdefcqm+BWw
 zReo1xdZf1C5Ww5IIO5a6Tc9mAiKVnRxtgNraee2VLkuhetPa5zZ4RElItIVsB8A6FYq6
 lbWYfzTig9hBLdrAzpQGlLQtg4i5q6nMWnI24gb97NArOYWq4kXYG3lLKyXEHCeqoL3Nj
 VS2oS3wUDwHmLbjBrreEEpTjuCjg85d7n5zsG7OmxBZl2j/K9Iujy4QPKU1ujHMFgndkh
 7Z5BMaMNjWgoJ/R8TWO371aoJ3D4qXB+TSta/54UbfUw/4zLX+eDAVjbsDZ3Xwt9BVg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792349639;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=/3fg+lkov9OBgqy1YYngrJKFNVHtl6ib2jKnzWngp5o=;
 b=GWrOOUv76KotPtlb3Le3ihr1iivpUuIGKjOSvLv6+dC2i3SDKs8TwtNHLTOXuZ01Himt
 iroLl5jBvvmcPBlJcQvRIJNnWGbFY9a0r647nDK57DgZ0f1oR28Vj+ajxvExre9SDOQWQ
 Nd19tZg1jvrqsB04Tgstgg4Jm5WQ7C7pzvca5AKayF8gT7M9LGr0QmKrcy0w32oeCo5//
 luuSyFU6G8ISZTAitmyxAbkIqCOIoSkNNPKu6cWHxVC4mvsDjuv+uDghFm7cb38iS0gvk
 aW0NNoGc3+CRAlJY4WbOBx7aSsaF25fNKz0DB227omJvkX3fmg6QDfdvlUs4E4T37QA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=PVi7Fdwz; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com;
 envelope-from=sashaneftin@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=PVi7Fdwz
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 96F7E605FC
 for <intel-wired-lan@osuosl.org>; Sun, 18 Oct 2026 18:53:58 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48e00eee27dso668430f8f.0
 for <intel-wired-lan@osuosl.org>; Sun, 18 Oct 2026 11:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792349636; x=1792954436; darn=osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/3fg+lkov9OBgqy1YYngrJKFNVHtl6ib2jKnzWngp5o=;
 b=PVi7FdwzJfciz0NfHyq/T7jrmTrsTON2znV9O5g7NfDS6Z5FzSBeaZJjBPymICOjlf
 qS3UAPGtCo2yzZhTvLGxwl7970IgUSpvdECA5QIOCdTPdzdhxJ/d1yiIJaU8t7XIO+Ya
 zARSVy2qB9irvA3vX2QWN6wozAUaGjD2T9P+JchGnMJ2tKCwbuyTLsN0XCp3HsNkJfrd
 5HSZlUZYRnwH4+CzpjI1UVlUtWHQseKBnKMewof9BdU4hWzVZqG3L3PDp5SJF4pEXGUM
 B4WGW0Af6cp6a1lSZ03Ypn156B7NIYtTCE4c0DBsrj+PtR8P/VBTpHsLtTQouqY0TwVy
 ATbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792349636; x=1792954436;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/3fg+lkov9OBgqy1YYngrJKFNVHtl6ib2jKnzWngp5o=;
 b=x0x6fPnQL++XCjWtNK6UqHlwC1lUqKQD6vURPfrtC5rCxQWYsiGZ7aIPpJ3q6zPl9l
 AhxJ7XGw8DIa0Yec4xVRfF4e0e/wvy4coVTbrfJkRXZb0+3K81e5C1fhtIHh4Erq9OHf
 1k8bZ/sGQiH/rapM0MU1278hMSb7tygX5xnExOSxvftavEJ+H4NTuC6irZjUEgA4cVN4
 gxLfb+gyjtPjrlszfV3UnHIVlH/NqcepDzvObV1fZN4ryk3aiSVO2mWx/YFUbhPjM3yJ
 gnDjABZAlAg7s+hZJQad7rzo/8UjuI+PvTvhs++rCt7L6B8Ytt0opu0iba6n7zCU7DMe
 na2g==
X-Gm-Message-State: AFq9FYKm0BnV5Rcs3lZ85aYIbJyBF4lmdxSGj9ngPo3Rf8GrnZrT3Q5q
 RPJS1/XetKKUyK4Z3DV90QEdwsNLKJMHTE4yWdJjIuNYmDK4ABp/i811LgaezSqt
X-Gm-Gg: AYBFou14Q1yNKk5XcAHYNC5/14Rwa76Ybyy1I0zctkYJdO3P7DPu6TujW+7RQwtIzVe
 2OqoeHdARlQBUeiTUI+yyinopn6Y8QS4GBSI0VMKX4QDji8sGlbo68EzOtPK8x4eV6ABb6XTRRW
 ommz10rH42/RFnIf5f4r5oxSABS7qwHqqQfdZDkA49SIvPV5csaLIpVT8WPVOfO9bVrURxWOpEF
 H5+YFKAupWHGZyWNqg5iwa10PVQ0bAtF2Z8iihP4D8Ddqxmfb9Y8Xh/xtnyiyo+F9AflS3AxWln
 cFbe3wJCoxVxSUG8VkUs9VNhYQL5zjDTOcJd2NaGPtqTfJ6+OAjcVjTMUOBjbceVqiJ5xHChS+f
 lfHytoRffHBZDECk5fUS8LjfZVlY5urHZ2OrbyqGpS9/N7R4z+INUpmgZPchiN3gl6sIWFGVuju
 3RnmlUvJU0bFBZeWSPBUqF1MJ/suZWPU4REPRiSNp7Ips8rIytfMcdtsmdqBb/pJVcKaB4WWJQB
 +noq9oOAKSi2XAvUrtRSNBCwcAvZdtCLflpH+FgWhzpSC31BcJsdPBgKQd0al0RAaxD2Wg+
X-Received: by 2002:a05:6000:4b05:b0:48e:202:6718 with SMTP id
 ffacd0b85a97d-48e07f9e41dmr12034459f8f.25.1792349635943; 
 Sun, 18 Oct 2026 11:53:55 -0700 (PDT)
Received: from sashaneftin-pc-GB-BSi5-1135G7.home ([185.175.35.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd540bc4sm18624499f8f.2.2026.10.18.11.53.53
 for <intel-wired-lan@osuosl.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 11:53:55 -0700 (PDT)
From: Sasha Neftin <sashaneftin@gmail.com>
To: intel-wired-lan@osuosl.org
Subject: [iwl-next, v1] igc: remove redundant igc_hw.h include from igc_main.c
Date: Sun, 18 Oct 2026 21:53:52 +0300
Message-ID: <20261018185352.46199-1-sashaneftin@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

igc.h already includes igc_hw.h, so the explicit include in igc_main.c
is redundant. Drop it.

No functional change.

Signed-off-by: Sasha Neftin <sashaneftin@gmail.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 3b7dd104d8d9..208840a5bb78 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -17,7 +17,6 @@
 #include <net/ipv6.h>
 
 #include "igc.h"
-#include "igc_hw.h"
 #include "igc_tsn.h"
 #include "igc_xdp.h"
 
-- 
2.53.0

