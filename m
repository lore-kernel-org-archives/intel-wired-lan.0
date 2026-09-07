Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE2EC79F9E
	for <intel-wired-lan@archiver.kernel.org>; Mon,  7 Sep 2026 21:54:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 74D7D606C5;
	Mon,  7 Sep 2026 21:54:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R75VjD3DfoPt; Mon,  7 Sep 2026 21:54:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A459E606A0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788818096;
	b=MPFNkMLCio7eoXt+R/d4xN+D3Uph4GL44CnBFNUSh4bAAiWMZCks9ABtogIAoGzJEi1C
	 UOJlQxG1hEpVIlXaq77BTSTUjcVJW5//r1GxurR4JUqcjcEiJFudISWUykAdppEUBd5pJ
	 9nlm2GeX101k3P09H7jAV1I62vfw1FSwd1YiIsscPKAX+S63SbMKxdmqCZzPPAlmlmMGt
	 4dH+o3i6H3h9rLM5Vg/2Jfz0jek75okYw8QSnT9+ArliozwZDT/5mHoVSNisGlEbxZW6S
	 CGbaOKiXsxmwSWeb44d1d6rgwvGzL/CcRDDBx1akzPHitXbSTxQ5HW08P+uWwTHcxzQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788818096;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Kb2gmiVIlb5vlxpKkwwNuzRtWNaOFk2YDHgZ7G5RM8s=;
	b=UMKYalsA2sYWz//enutX4HeRiUkKi7GuKAsDJEVaXmaW9lSYJDIxuwhWompfckaxHjcb
	 piNvfdaXnCB70hAZlXkGpI3QXgDOtcDZrhcRI2vgR2NzwS7XunpNouF4unRWuFHVVxH5/
	 eZOf8nxKRpO2wDBjfiyPk5sl76P8QvkN51DIvghKrwirM2pp/puEwhpfxkgKhwSNAkZQZ
	 qUeB52sJFd+RzW5KH1JRoNAQAmp+HEwJNxeNybpGNPVv+PDNrH8pHO3m6YCbDu4ilcPm7
	 +95MpR1U1yLbW1kUDrJCSPg3HrC5R1velbY/A8Gg1PvVMgrF9v3rTIQ0Dq1Id1OckKw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oXnQRXG+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788818096;
	bh=Kb2gmiVIlb5vlxpKkwwNuzRtWNaOFk2YDHgZ7G5RM8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m43z0adNp+R8JMWq1GsC/QkTImHn72/xb1q4zo+Czb+7pmCEPmS/t/emUCfvFdiTN
	 LUhCHpTH8lRJRwEUYcb9yxz/dxyXDIvkcwnygtv6D+ATuI/tI5vxylohHKoF2FfIPF
	 IuwvInP53eHbIhRprMkpTtZ7GfslboLoDuELaKg+6QXBJyIsfZvVyDTmsr+gQGJRoy
	 Vm3qnm8rj0Px7Z03CIpPXdhcYxCMSw7O5IHRzR0Qn8BqCFO1oq9Txjh7mYkvU1CAu/
	 p3NHQ6iQ4J6KtoMdigCAIhf9SsrpzlZLUNROl4MwBHkTwoBvPHu6XAudRXdoZr8bQQ
	 q385lu/Uw9zkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A459E606A0;
	Mon,  7 Sep 2026 21:54:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BED8A230
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 21:54:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B0E0F606C5
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 21:54:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WbqV0N68Bvon for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Sep 2026 21:54:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org ED1B360650
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::112c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788818093;
 b=VVurkUmbWr/VQqrcrZHsW3tODYpqI4hC/41Ikj+/t1snR4G5lZH5V6mOK9XwTwbLrhlo
 Hzl1NgstIe9YIhzAajBo0iLqjSh4E3XWSazI0uwFxz2WYtgjXabBWsPix/YPfVM/BrC49
 qXVNhWz6FQ2LKwMM+CTVvi1cSX+pgmEkG9FiIsegSvmaUHCHGJsQ63FNqE/dYYKUoq9yf
 8eCDvY0Yr7pEilukosVxCHQVOPc2fYyOmFFP0sE07DWUFpXKfSoVnAZ2RnXhpl7t0szO/
 4r7NUx+VVeTDGT4Byc4Rrexmcr7ezYtTT8vBsoPZTgCN/pV0JCU0QYGh1cbGvegMtHA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788818093;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=Kb2gmiVIlb5vlxpKkwwNuzRtWNaOFk2YDHgZ7G5RM8s=;
 b=WgNY9cTXLkdIK4qvm9GHIzfT5aOlgcNfUrvluJa4HZkW4TrTvWFf+TQaZ+732CuVBEj1
 VdvbSbFC7RwfkUzbGb6IPL4YOWhsHwHKH1TSHzKR2aEO0wZhJlxeZgIMHEgFpJC5ZSy35
 MSbwdHfvNiUdkPu5vzcOjGDJlAUlGJR2tNfzgyEEZDVzL7N0qZXBfYEJ9e1kILJ+JlJdH
 0etgENCmK/fdya1DZc5FdlMRH2o6qgXJB2wyCIV5OgIDoAdjeZhMQmaH/CREblS0pUHRH
 3pe8fU7UfSkxi4oUB33V1HH/3CbVxmvGP4IYXI/kH8o/td5xcnPSE69bKN0I73HDutw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=oXnQRXG+; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::112c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112c; helo=mail-yw1-x112c.google.com;
 envelope-from=yury.norov@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=oXnQRXG+
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ED1B360650
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 21:54:50 +0000 (UTC)
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-865bdc6ed72so66848047b3.2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 07 Sep 2026 14:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788818089; x=1789422889; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Kb2gmiVIlb5vlxpKkwwNuzRtWNaOFk2YDHgZ7G5RM8s=;
 b=oXnQRXG+GQTpRW32LTpYTlooe55goNsnzv02MMuDFmkma1KzQk3QpA8BfhK15SbdOU
 SWfYgMWTmnHUypTJ1yQJSCj6CvNNk8gdvhExAjpnqJaXGptVtFdrNY0diRCipH0EUVbj
 2+D3XRcT7YTORIzb6iPFiaefTbsb4KZcocST4b+oC3zvnCW5weCvb8kbxChcfrS3ZrcN
 9lhzFoJRuxjfb5JZifDLauKAGj0zOyMMaTD8VfSHAXFreSziLrWfJ+l81+HZgWktSMG9
 TaWjh2N7c0N7gLAM6ZaC3O4Wi1sulP4BNmNoLxKQ1amC2W8jWfboUxqtHoatBgMSE3ur
 +MDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788818089; x=1789422889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Kb2gmiVIlb5vlxpKkwwNuzRtWNaOFk2YDHgZ7G5RM8s=;
 b=JXZamv6f/kb9IO4qtxpsfskG3fwDj+q57Ue/HUPLXPMDk+wnRFjJHDjUJAsK7dluPD
 JdzBBih1nLWXtbg9b5vH0dKbWl/qM3iRnS3HW115m+HCFfQIXHdBA4/b1vrv+YoAYAcd
 CHhlIPQ9VWoV9EiaW37WSEh1A2Wk8R3MALZe0rlVLVvhD2Q5u457zIWeyf9R60N+UFqi
 ui2RlHIblckmiW+ONmOdMESapI1a4RXUj9xKUVc8pJ/ejeWAZdvMyNREon0wNZ3u13pM
 qIIDJhs+PsRXfa5xgwcUI2faCgn3o6D4ip9DP/WxOhliA1qiyzpxcoduugbuxFKcFE2N
 6zsw==
X-Forwarded-Encrypted: i=1;
 AKwUvByJW/A29dTVO3mOzUI8nPZbU8xJ2kc3qB0NHhfqIMcIbti669zOq8cmSyu6SxAEGQ2t0bnEI7bu1f+AswawW+s=@lists.osuosl.org
X-Gm-Message-State: AFuF++n3/Jhogm2JTDe2WcULJK/LblIoPMMzUKEAPn+cMASliK7oBZtc
 mIqiw8R4SjTtf5k1l7yf6I6sKitfUaW1ChrO4f1pBHmdrGaGkfDDm+0s
X-Gm-Gg: AYBFou3h4gi/2GKLklYM9Ul8vk1Bdq6vh7Y1WyH1A8KwJhoZzlna2oJvrxSP7gLGV4e
 NKgjK+VGMoB6R3E90Dvn3Xb5FCAC2pA8B/zSN50P3fk6GswKYbcUOlzS9rgsGEuY/hjgxSJWtsP
 W8kYEgqJra0rOaDur8bcM8hZXkxiWt7MIAr9H0ebctfDPrOK+CoAeaEB72GtBSQ3XLBOo+V2BcZ
 p7HBaGDZdacgZCljR+bgdvO5KdRJ6WECizOisWX+cVfdJjag7MBnUrHjyEj/RiAoTVQSkZo/ysC
 744ePrmbHEdYXfZTafVH8UaRGeADBivPFC4fTnxHBV9LZg30GdeSz0lt5ftXXBRWpRUjZb88t/J
 2oe9mh43eUrQZFaTgYGDRDk60EZ5i4TaIRTwFNxFPbsGsWTyykuDoqWbcL1KUp5wJY5X7T+idLu
 lyZyLFC3fWjoYSIaFGmxFtMNjyA9NrDToec8Isrw+sPe7EShAol8LmN2n3b9CTlFNruE7Y7dTd7
 8X3r275g4cbSrdmjA==
X-Received: by 2002:a05:690c:4adb:b0:873:5bd1:98c3 with SMTP id
 00721157ae682-8735bd1a0damr49302177b3.53.1788818089522; 
 Mon, 07 Sep 2026 14:54:49 -0700 (PDT)
Received: from localhost (c-73-105-0-191.hsd1.fl.comcast.net. [73.105.0.191])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-871439bcb5bsm78484247b3.3.2026.09.07.14.54.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 14:54:49 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Raju Rangoju <Raju.Rangoju@amd.com>,
 Prashanth Kumar K R <PrashanthKumar.K.R@amd.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jian Shen <shenjian15@huawei.com>, Jijie Shao <shaojijie@huawei.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-usb@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 9/9] MAINTAINERS: co-maintain linkmode.h under BITMAP
Date: Mon,  7 Sep 2026 17:54:38 -0400
Message-ID: <20260907215439.409858-10-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907215439.409858-1-ynorov@nvidia.com>
References: <20260907215439.409858-1-ynorov@nvidia.com>
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

The file is largely a wrapper around bitmap.h. List it under BITMAP
section for co-maintenance.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a19da74d00c..b78f0bccff54 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4646,6 +4646,7 @@ F:	include/linux/cpumask.h
 F:	include/linux/cpumask_types.h
 F:	include/linux/find.h
 F:	include/linux/hw_bitfield.h
+F:	include/linux/linkmode.h
 F:	include/linux/nodemask.h
 F:	include/linux/nodemask_types.h
 F:	include/uapi/linux/bits.h
-- 
2.53.0

