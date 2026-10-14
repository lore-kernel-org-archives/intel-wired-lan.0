Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CE3CC6B1A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 14 Oct 2026 11:06:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1CCB0809E7;
	Wed, 14 Oct 2026 11:06:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WHzCKfEh1VV5; Wed, 14 Oct 2026 11:06:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 80086808D2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791975989;
	b=YxQ0epkNf+XC+FTbkt5PWqhTHUEBy3pTsn97t+60Ig2lCDXDxIafXq+TQCkNNRen5aWu
	 jbSPbvV5bsWxX3N/2B9cLc/H5MuAi0H4e5z6Qs+qiQARZLA628NPQhd26xEwd/nPj7kUU
	 49eKYW0k5IC9EwO6wDpp2LVug2vC5UgNDLrcOY/YZjeev9eEQJikWUPegPlJ6BTXVnst5
	 UhhRkgSDx4m8NxWwEsVB3V2+WbOcULY9CRTnB5daTI+UyWRWRVZmvMrSt5zymEzUrb1bU
	 Zdl45Sw6hHAqlL1NgoGdGVRk03f7n0Gjy3zxw8BDGcH6QwO4ZXm4ICK2oGJ3FHaQfMw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791975989;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IA9MBfKgv1sdcLYi/BMK4mg1HgVG9k9DlxSmN5iI1MU=;
	b=sH34z6RAbB+LhGnPUcVpmlP9W2214Kxkf4pI/QtF6aR7ss3gkOwEZTQqJPXx2BjJ1+lZ
	 2OYvmOXUBi30DjrfLj5lCCr/tx+ugH80pB6bscNPaKM/M9E5T/X6+wcPV1HjCIfa2/6uC
	 QAzNThfOq2c3p4pKmc4K9oHJ1m4plFrocyS3OV0dkPVkzoihKVJK3rLwSUYqcvOxsfV1R
	 H1oR6/vcrXGyWqtijJ883NdH5rJ6lmYpNL6rWpdFYOU7cl+Oa9xzAQd1yrU/LpaE0Z6tM
	 myP9sDeAF4T2wHvQpmLLbn9fNOkCctEAnHS5C5YoZuygqjylBamWVyOplOGvtzLMiMw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791975989;
	bh=IA9MBfKgv1sdcLYi/BMK4mg1HgVG9k9DlxSmN5iI1MU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=2hHXAtN1YCuO5LmSiIEmWYQvDY0pMyU5iTdgEKhrPlAflYwUKnFs7TC9+iC2j/80f
	 tYQ0Kl3s6XDkZujaw9C4g8WvJPSyjQOKgdJaSwqEITJBoXuiWKkDWdk8rwChb1R0Oo
	 VFX0xDM2RCkzYqe8dKvZEUpSH28Hw/Cx77QTFt8jNp2m+HwBbIfLNgrmHFxJoYkxYU
	 JqNfktOIW03Uat8xS4RKC2j14dovNpnCk43HWbq+FWe0iLN8kBRYpVfkCj1QWxU0eK
	 7L844dXSaGBxeBgEBXK4HZSOn8ZCV5Dxy0QB5bPZXuo48ngaff32Jo5jXakLjgX2P7
	 lhugq70qRxSrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 80086808D2;
	Wed, 14 Oct 2026 11:06:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 78DD81DE
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 11:06:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6A26A60728
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 11:06:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yGkU9sB-dv4i for <intel-wired-lan@lists.osuosl.org>;
 Wed, 14 Oct 2026 11:06:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CB9CF605CF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791975988;
 b=d3DnM+zyPhCacnsWGe36o3zqHY42Dc2UyBD++83yuDUHQ/spTrlXk3OAsXW0hYMv1TTi
 6ykxyr2kIbjY4186CTOn0L25NqzM/tdQhmbLpD152A9n29+FyfeYlrKKjUQpbCrZWGdMA
 U10BKF7p60upz9pyMaHw789s5EpK06mHRV/QAECYAZznPAiPCbEqV67dAuHs+aD1hYRk/
 DGpoJrDxUWbn8amAepM5MFXmZc9dl2u/c+8IRDjDHNfZvfaf4f+83NN8lrIVyNFERq1To
 WQZE2Vt0OOPwarAkAQzHcFgdsa7M7jSSwHCGbDlz3Ov4iEAjPWC4HrXHyrmnBwcivog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791975988;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=IA9MBfKgv1sdcLYi/BMK4mg1HgVG9k9DlxSmN5iI1MU=;
 b=ht3C/4KLTj+zCOXMuELtVcraPzB0CBj19mAlx/XL8g5QOeQf9/rt00Mwf36+cp+W93gT
 w3tv1jSwLrXx8J+hvyPamntiSpZZzFwuZxeArO/mdFnEG4rhooQO1w0LjszspCIv4jsNs
 u0Ujaj56mE7rZoLABrArG9To49UEuagoG17DHXXAKVAs9yqTvG+ZtIFd2TTw4xOrrhoQ3
 Fprrf+MBhuO1oNI3N+XD6vOsNcNmu25GKpjYAFZDHXjOVJSog8/wWspDHSFh+BApkD7Ud
 vsNDL91q7udil3Jf+qWFY8BDdh9pDTNSDwzEdgS73j0rIgZufemMox/DJI4rqo2Pm7g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=GfBz4kCw; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com;
 envelope-from=ayush37735@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=GfBz4kCw
Received: from mail-dy1-x1331.google.com (mail-dy1-x1331.google.com
 [IPv6:2607:f8b0:4864:20::1331])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CB9CF605CF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 11:06:27 +0000 (UTC)
Received: by mail-dy1-x1331.google.com with SMTP id
 5a478bee46e88-3535a54bed9so1199042eec.1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 04:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791975986; x=1792580786; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IA9MBfKgv1sdcLYi/BMK4mg1HgVG9k9DlxSmN5iI1MU=;
 b=GfBz4kCwyGmuZxQfJoJRZP7Z4k1no54VMOZy3sysYNdOOSNPZgtOeOwFazd3KVA4oO
 EYBO+76A45+qEgkYnO96aoUUSeUZy9H1QW/eVBSYqcDyOEnVaDQV2c4zFHDjoa6Mtb7k
 qpsryZnUtO+z6T+YSp3waEc+XdkOUKmrQM9eJ/0Z59kDd9izRvKDFYyEDe+o7Thou6tz
 dqKPPqBjjz6mtZd+2+3xzzSz+1/FIpl83NFIG4jTzN+KZ8ekatupOtlItItSSgSSRJrX
 Z/jVGU8lq17uzhSVqimolW1NajYQxlwH7mUPpEayaK/f+S+KUqQXhehc0N9ugHQ1lTU9
 zHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791975986; x=1792580786;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IA9MBfKgv1sdcLYi/BMK4mg1HgVG9k9DlxSmN5iI1MU=;
 b=KV0QBXjHmDl8t3fUIo9qp5N+FyAMUUkU9jVt5gSG9+24s7GD71brFFFnWEA5+8wifc
 dplcjQyA9DOAWEIbnNlyKR9e/9KpmcPMtEWbUSK3XMZnTxth5ltnsxC8n9UtGorCiQq+
 ndeTW4pFl438L0KbOkU4f71JHlVBZfHHSOlSdNFifKALzULl6KGQOFA6UliAkKI4a6Pj
 PoXyGPNY0yFZ2h3AyYWsdC8kC4P43p+d5IBRTrsmQYATEb0/+qox1p70lx5q8vCxrnXs
 35CB8sj0WIWxTB4VgJ/hcGFFWvTkBJOyjEBKuXFDkRt951gXbzTnDsVg1oSGCa24iBGN
 SbvA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx+FRFjIQ6bDv0ILBQAseRdNL95xNcVgNf6AFQJwqjWwOAWDaUW2KbB4vRGRBszHsCfTNtkyPdF7JPBylIwKNE=@lists.osuosl.org
X-Gm-Message-State: AFq9FYLe0Lvky+FSaquP2axP5TOcWObUEzVkQlr/Xu6hfk56DJGKsmnL
 Vp2ABvRCmFRsziuqLWscVtG4TdnOcdqDJL8EncP8veI2I+A/JV7C+zwd
X-Gm-Gg: AYBFou0W9Gb3lPFyMgz6scmghddMtPHdAVc4jAi5lgsaOsrkL3DT/sLj+9TYuuS4qVM
 V08uiYA4FxLLOTxIGl7DX+BPeO5acDSwhi55Di/r1XmYETtInFmAvMxlAFUfzzKc3YpxzQiXyd4
 PVTRQQMr7wfQ3rO4UcS1jZMJdfCDqoS5xgor8jw4xON9Klg0CEbY+eDlM2ylNNf7teEtztxkc9S
 tzuh+aYvnUdG0hFaLPXGn91GXUF7756LjneEEdnrC2oaPtTM0N72g7tUkQ+qamSZ3GeycOZwlbo
 Wz/90B7tHAVzEqtFBAqUkKa0JuHmXc+GSR1S7n+eCX3ZEVli8EJvvjVrnX4GMzLPovPhCqSzvXI
 7tSF8rxVl3QGypgezoVy03NMlLqw06wdRYY59b+k0tTbhn5OK+jCDbhMmmu3glTJ2Ah7zo0Kos4
 Gf5VGe7G4T26MXjrscpS4RKPJRX6v0TRc27imlEnLROHnvhDvhm/2/7vkOt2nGcg74PQY1I04KQ
 oZJNGq4Pl4U
X-Received: by 2002:a05:7300:d18b:b0:351:1e2e:da4d with SMTP id
 5a478bee46e88-3537e0bdfe0mr22517361eec.23.1791975986061; 
 Wed, 14 Oct 2026 04:06:26 -0700 (PDT)
Received: from evangelion-g ([103.196.213.55])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358de54fe47sm38221116eec.31.2026.10.14.04.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 04:06:23 -0700 (PDT)
From: Ayush Yaduvanshi <ayush37735@gmail.com>
To: anthony.l.nguyen@intel.com
Cc: przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ayush Yaduvanshi <ayush37735@gmail.com>
Subject: [PATCH] net: intel: ice: Modernize ice_vsi_free() with scope-based
 guard(mutex)
Date: Wed, 14 Oct 2026 16:35:52 +0530
Message-ID: <20261014110552.56976-1-ayush37735@gmail.com>
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

Signed-off-by: Ayush Yaduvanshi <ayush37735@gmail.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 9e08db376d3d..c695df442822 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -457,7 +457,7 @@ void ice_vsi_free(struct ice_vsi *vsi)
 		return;
 	}
 
-	mutex_lock(&pf->sw_mutex);
+	guard(mutex)(&pf->sw_mutex);
 	/* updates the PF for this cleared VSI */
 
 	pf->vsi[vsi->idx] = NULL;
@@ -466,7 +466,6 @@ void ice_vsi_free(struct ice_vsi *vsi)
 	ice_vsi_free_stats(vsi);
 	ice_vsi_free_arrays(vsi);
 	mutex_destroy(&vsi->xdp_state_lock);
-	mutex_unlock(&pf->sw_mutex);
 	devm_kfree(dev, vsi);
 }
 
-- 
2.53.0

