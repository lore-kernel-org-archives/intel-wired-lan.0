Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A614C624DB
	for <intel-wired-lan@archiver.kernel.org>; Sat,  5 Sep 2026 16:32:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E194340A9F;
	Sat,  5 Sep 2026 16:32:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Eqk8NAeHb7cy; Sat,  5 Sep 2026 16:32:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5FB9D40A8D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788625925;
	b=YolqUeVsrtQCZ3VR0cKpPu3NSyVcouFYz6CWroSSKA1B5gmJfK/6CK6JCMe0LPtN0zTJ
	 LSIgxl/6irNJUBYn+1tid3BtIZ/DaYNUswEckQ7SFo0AA8EC9u5coj4qRRms+4KFCeR7c
	 aZNgXHiDuAbYHP5ZbCb3jxQoYEIb4a3Q/5V4Ey+142kHLhaXTQiAMa5rUfwYsQ5c418Ds
	 perQwcmJxchYNwwqlM0e3ltx/Twizak3Zrou8UUcRUEE6Li7PaBe2dtIc+u2p4HnECvXZ
	 f3dO7UgaE08ew/ryukHnXBg0jNxQWu79uCjiplTBE3P9Im0tp+ZbDsz4YnOrOSOt2jQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788625925;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=tKVHrL8n9+eK06z6dZ3CMW+ik7hM+TIs7LDRylnIPWo=;
	b=JSQGmAsm9Po5yHEK3D3iOC6E8/pJwxKtBAIh/nTp6IzzgBrgzbgHKnGcMft54U89P/Le
	 6eRaz2rsQmmF77ANbxr+0xXVoXPOqcw3SYLyE6Nq2fwJwh3HCXtfN5nNvI+LRYuWP3LhZ
	 PDjOBLlJhe0kUwI6MJP01qllhBvLWLBZlD25DyqY0/9V27u9IxsGa/KGIzVBbesMnHO9M
	 UQZuQeG9Vcu0F6ZvpWlCNiz9y8JrgI+2/Fs04ba5x/mNAWULFmDh+StaEn7mm/6BZI8ii
	 RuTyAZTT1fOv/DgqNENsUkDw1qrRVw2Otir3otigmtZqIe5qMVjvPRY8vxmL2lZ9d2A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UcMrL4ar;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788625925;
	bh=tKVHrL8n9+eK06z6dZ3CMW+ik7hM+TIs7LDRylnIPWo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hZbl+dvq3+Hq3LKl4tG/JUawBjlJBuDGBqgPvpcK4iq1jv/B1T6ReIsbF12r6wQXp
	 2hMKa79OyRCde6dsS15u5BSPvVC5jfw1aATra4D1BZjZO0YxWFes6nYOkscUTqR7FL
	 NqtNXQKxipRC0xO6JDzJOZZ6iqlVKSIeLTI4XNsZCl1tFGn068cDJD6b+I0HKuoy2W
	 Z7UYEFw2zmcWUjHlkybK0GvDFKy9zdxYRHBzvQD6U1/3RppC9cJSxV5djZEg481kwp
	 CBqSzx14wOJZyz0Rxc6X/VipjnK4jy2e5OlM9zlGcVgwJE8nla2UuDBiH8iEs5+VPk
	 47rYSGCRTrOfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5FB9D40A8D;
	Sat,  5 Sep 2026 16:32:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 180F1118
 for <intel-wired-lan@lists.osuosl.org>; Sat,  5 Sep 2026 16:32:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 00DAE40A8D
 for <intel-wired-lan@lists.osuosl.org>; Sat,  5 Sep 2026 16:32:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uPXpSvekEY3s for <intel-wired-lan@lists.osuosl.org>;
 Sat,  5 Sep 2026 16:32:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4407A40A79
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::62e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788625923;
 b=MluWdhiPmvjnLsLij3CAPg9KonktCZAwPb04fG/FX6/A6v6i8dOkLIcEvS6tA+GF0LyI
 36zXIE+AHi4fB2sJ/0f8MlAVBmztS2ILTbM+FRYQGq2FtbLduCcfLssFw2kItZTrlG9qw
 1Osge/sa+/pj4HrSJR1jX3ABh/rMMdE2ZbbYXd5Z7MKnYQiiVTF2cYvZNuEg0WTqL5vbW
 VLFSOeWrLbuCBAF6VYY2v7FNxiceQ7kvo+BzvxUPDfOcEj4k3jpxv7BqRhjBSbpzLE7dL
 QGRZaHJufT6bqQalhZ3LB2XsvRmnspEZFuxAqdYGBhjaJoCkFYF5SF2Sgj/pJSt7TPw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788625923;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=tKVHrL8n9+eK06z6dZ3CMW+ik7hM+TIs7LDRylnIPWo=;
 b=ZINyisFWACFxWS2hM14zItZWk94TEQCG2/nzoGWyjAS8e9YM5IqvXnCJb3rdfUQDwP74
 g+D5fcq+xLCMsrXVHsATYlGIVKrHW8HDJ2NGjkjjCxX192V+9ZMTAtpjykFNsE2vk+t0f
 8hKjB61aNS12lMVjaTth0SMRj1hV/fvmP+h5Tj2UIyiOaHStxD6ZwavVqWq27Swaslo+6
 spGbJ1vNDeE/dwD469Eh6us+Hm4WsvVNZzY+/Mha4SjtuRG3KuXK2uMd5sM8HzYbhzOvO
 6z+cRkzUyFwLsGlKodHneOeRlNNkpzVnH1VLXFkXlC5bDVoO0r4OGqgAFnqudXQ+hSA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=UcMrL4ar; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::62e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com;
 envelope-from=rivaldihormat@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=UcMrL4ar
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4407A40A79
 for <intel-wired-lan@lists.osuosl.org>; Sat,  5 Sep 2026 16:32:02 +0000 (UTC)
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2cfbbdfa60bso18740665ad.3
 for <intel-wired-lan@lists.osuosl.org>; Sat, 05 Sep 2026 09:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788625922; x=1789230722; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tKVHrL8n9+eK06z6dZ3CMW+ik7hM+TIs7LDRylnIPWo=;
 b=UcMrL4arlbZ11QTGA12I8pZLtJKKPUieco0p39lJSdDql7FgIx9l8MyyOtHNpryMT5
 ixYAP81DqKXwImBpcQzMyw6Xb+rBBT7/biGroJ/D6vAuCBX7pg6VrQWz8G0w4iCaPobi
 jb0n/g57knHWzrV6UfHG8dDNSlC+8KLF928ePeehpyJ9sWIm/QsTJ0oseDAD1//qGfHK
 JYiF96nzFD6jWKRCUzWJTDbeHOgn1T6adoqkC9ycVnjdGDMI5jHXDqdcyZpPxUusO/Ac
 xPTwpoizOrVUjVxanWON+TyCx1dMjsg67jMJmktPZRjt2EdXqVCHdgqTsM7VXVQJ19F7
 gRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788625922; x=1789230722;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tKVHrL8n9+eK06z6dZ3CMW+ik7hM+TIs7LDRylnIPWo=;
 b=ETOY7b4lN5ggGfuPpUaArpQiDM3xO6au6XHx5gPaKuND+2hX3PLftsrpgpB8NJPv/f
 JzPCBoTRiW6Egg56EhprgZA7aJEGRKnx+sWAB+HyAyXXwYttL1WB1ANnJjEKYrm2jXNg
 tuRR6iPZ9ahfQemFO+ttJyhkF6ICReg8mdNWFYVUdDAe4qtRCGbkUHF/A+f9QoqwNF+Q
 7ZmpfyokXiEANUPN8TyiUYdCQrVRqvOklKE6eTkFY9NuOGouth7oenJ7/0o1PwOzO/wA
 nb0VUwV3jCJHRTD74ACZiCNu6/BdHxqGIOykXmsf0q19h23zBrVHbjjSkD9b2b4Cip5Y
 LTDA==
X-Gm-Message-State: AFuF++kU6dC5a7aUJvtRltHfDKk6ZRijP8PwUNdoVRiJzw/ixF0WSYEM
 PmGGjBs8DyYsXaKP5RKPia96HpMNn6Jf+FJU9VuUAXCbXeOD8f/8wRACAk7oyZSQ
X-Gm-Gg: AYBFou3D+tnSr2JBz/IjTOL+7yhcVX/YwJOSkQT3Vrg5r5aNjTq9FeAsL32f4Iaw369
 hjnSsI9s+MyBypUuaNFJLsnUQfU4OMbKiE0MrwU/+GwSxhaPhMFgIqYNtV+NgNmu5UoW0xoanTn
 JL2dZmDB6QCLF5kS8Yra8UuV9cOiTWGfXoCj4b1KOwEz1WNPJjzJcyd2M95hxVyjCeurOHvSH5n
 QaZ0Pj1aGej2ZgbciO9NVJRUR8Cp+HoZI6ICT0s5I8rJtlMphKl+OEvXLAuHuOPMNZ716QFrpPR
 V04r4kW01NQ605Cx2ECI6u4tUwNfx53s3X3IFYatYhAtnV+OCiQfShgf6DNPtg3HkIsWf/RF5L7
 62frE6XLyzpUWxQGPT9Vkx5TvUjTZWBycns9nu5Pw9bGHQIHBoH0tXsgT6YFHvCmGfCYgASvsiy
 Y8M/0mQ6nYZ22BMRoWrVXDXBkVO3pe9oQ07iDiVcLTCIr1OsIobH/e/v0FXq3SFUvKKjZOZL6Wf
 AYR8iF8ui22aycK9Xvr94eNpxmDxanIimxFZuXJSNz2gPddNG9SExoaB9KB8qZMByI=
X-Received: by 2002:a17:90b:2b8b:b0:398:c0ad:711c with SMTP id
 98e67ed59e1d1-39b26272f0fmr21323072a91.15.1788625922125; 
 Sat, 05 Sep 2026 09:32:02 -0700 (PDT)
Received: from
 codespaces-1adab9.ktkhmpmw22vebpok31ngjx2qsb.ix.internal.cloudapp.net
 ([23.97.62.114]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b3312f9a8sm8348354a91.2.2026.09.05.09.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 09:32:01 -0700 (PDT)
From: rivaldihormat-debug <rivaldihormat@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: linux-kernel@vger.kernel.org,
	Rifaldi Hormat <rivaldihormat@gmail.com>
Subject: [PATCH] i40e: fix integer overflow in i40e_dbg_command_write()
Date: Sat,  5 Sep 2026 16:31:44 +0000
Message-ID: <20260905163144.17069-1-rivaldihormat@gmail.com>
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

From: Rifaldi Hormat <rivaldihormat@gmail.com>

Signed-off-by: Rifaldi Hormat <rivaldihormat@gmail.com>
---
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 0b52509cb14c..74e75504fdda 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -722,6 +722,8 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 	int cnt;
 
 	/* don't allow partial writes */
+	if (count == 0 || count > PAGE_SIZE)
+		return -EINVAL;
 	if (*ppos != 0)
 		return 0;
 
@@ -1605,6 +1607,8 @@ static ssize_t i40e_dbg_netdev_ops_write(struct file *filp,
 	int i, cnt;
 
 	/* don't allow partial writes */
+	if (count == 0 || count > PAGE_SIZE)
+		return -EINVAL;
 	if (*ppos != 0)
 		return 0;
 
-- 
2.53.0

