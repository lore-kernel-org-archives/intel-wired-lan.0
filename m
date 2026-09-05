Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F230EC624D6
	for <intel-wired-lan@archiver.kernel.org>; Sat,  5 Sep 2026 15:32:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 908C9605FF;
	Sat,  5 Sep 2026 15:32:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xPzV_6_JmEDD; Sat,  5 Sep 2026 15:32:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org F2C366060C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788622345;
	b=ctt6TZ/5/mVhR/wB2+dGRKCg2SnJJrI4mg9ZlnTOBWsBj/VFxK7moc6amXtVfmAMXyxS
	 WYfJkzZfm2bFE5VPMIAzDHISSa3fEFtCFpZ0ar69pYBIvclw+8JLMgKvce2R5Zkx4C7az
	 ZxpdLmLLhzjPzjgxaP65zAWgmt3m4xOobVRJ1L1tWY9i+nwmJS9WnmOthf/07i2FYP9v+
	 9NQh4aIO8cZ1du4zhLK0AdRkd3DbjsT5OkQnHxPilAe8xBI8w2f01czOzDtiwaKNGdE+q
	 TSob0OGFVOF3jEPqYTYnCPKCWyCs0yokIdc6+/Nwn3CDACVruZURYOMoHwTeNztnA2w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788622345;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wvfomyvOKTuvngpY/hxeNfz5FMbtqTR3RJdLKytrsyE=;
	b=QrtTJC5wqFhzp6rHx184uYbg3ZvN18DdGwJngLYMi5J6i6ukfTZPKxjGoSfsRi5eVa2n
	 yZhkPZlZ2uThn+uEnT7oIjQLygFR3q+6GZ+Vkgj0M0X874xxmPrTFZNN8uDSAtr/Uau9A
	 zPaSd/D2cJ+SS0kUkbGXiLFdAKZzs+1qa2gdSxs8GAK/qW2HE4g9I0JgftcFOvMqLCNxg
	 89lVYJ82fCwp3hrcHyHLKZiIa4/xTNQrCrQ4qdImvI7OTaocPgLz7V3rbBW/pFZ+uL9E0
	 1Am+bQAvW6WjvNN5kYkIp5MPQ6wWs4qadezfkuOtx1BczQWWpdshc2ilOqgOr0OlXfg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788622345;
	bh=wvfomyvOKTuvngpY/hxeNfz5FMbtqTR3RJdLKytrsyE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qxA2Tg5hM9xuEXlZzLZ8XYact8MCNmZevL1NGMvBRIzkZWfu+5rJRGbURd0a01Za5
	 9/1UX6noHjrnU58mOehr7ASvww4UsFbEJO9OsR1GV83WkFcq5frEuXSeD2czxX/nQa
	 AGKwvJceu8pau1G6XeCvajDjroHazapKNqytK8Jq8eeHfxdB36EXJF7P1OZ6wGYbK+
	 uza0HU+egk84R9mDlUG3V9PG9/FRiB4A3d6tQlmhakxzI4aNCOb1RzHjV63mpWse/5
	 eeOje5ng29r05NXpZ44Oa6Ge8IgErWlQMDxYzbINGcaq+dRlpXtmsCGWw5L5AYq6dL
	 YTeiJiUUc4big==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F2C366060C;
	Sat,  5 Sep 2026 15:32:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 85425279
 for <intel-wired-lan@lists.osuosl.org>; Sat,  5 Sep 2026 15:32:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 76F4340051
 for <intel-wired-lan@lists.osuosl.org>; Sat,  5 Sep 2026 15:32:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7DVvYH7ZZ00L for <intel-wired-lan@lists.osuosl.org>;
 Sat,  5 Sep 2026 15:32:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org C51294004C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788622343;
 b=bMD423/usGG3cmg1sYMHaFO+Ng0WtYhnUCOwwcHY+PDS9tOUoLX3CP34DAYhoyoEJyxf
 cy62/G6gou3/S/0uME3KpRmTg9VuNZ5BvFH/DresqYVGv98tCnHOoBmiZjCSpwi3nnXKU
 gYkknx34sErb47VMf3rpKa3KGx0Zzogf4Hnj+420hE8myeuxH9/70tpsmLMbG3fgRHl6q
 zfZNQB4Gq7/9PqlDj3rGR1Nw+grCOXP+HJvLCdb/biK6SbM/erzDSq8Y8ETU8L2wsY6VF
 inUfcW6Ym6cCgbfQB6+aEVAZel9wggfzWfY8QQ0zlWrRvkippn+nw4qA/xPFBckdh0w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788622343;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=wvfomyvOKTuvngpY/hxeNfz5FMbtqTR3RJdLKytrsyE=;
 b=HsbVfRLuxCkJJbEiFyizuiJj8wVmmqUZ3ls6zND9pfBv+fFSWWjdiP6kWuRTTRp/rZn5
 kq44MLhhuSkNvN1D3pZSjzoj43csiDgLDOSQJZrki53JU2HuVRjsgglNg/ICD2ToiKR3o
 Z/mbWZu4sNizMT2ArG9wnMjALsvqK31jg+fHgnH0z7MmoaFRlq0enpPCcdlILEJ9AeOzZ
 V0YgPCKcwGNFzs85+rARqnVjHbF2A9Iav6f3U1Ttn7C43ksKGNGKAzuFj/ZTWvLb/W9/x
 j+PRaE2TKXZOQkF79U6IWrEFhata2MEMVqOA3fd57MUf/va1H/4RYYpGLm+yFY3ewuA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=M6i4KLqT; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com;
 envelope-from=rivaldihormat@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=M6i4KLqT
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C51294004C
 for <intel-wired-lan@lists.osuosl.org>; Sat,  5 Sep 2026 15:32:23 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-39b2ad862bdso1998971a91.2
 for <intel-wired-lan@lists.osuosl.org>; Sat, 05 Sep 2026 08:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788622343; x=1789227143; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wvfomyvOKTuvngpY/hxeNfz5FMbtqTR3RJdLKytrsyE=;
 b=M6i4KLqTN9H5kStdnC4My+3q2uKee+9XXYpMRNi2+Q6SH5lUi7z3XL41a8ADbZUTcx
 0EVLZI0Ur64dTnbbPrLnZmKb22+WABGqcUr5IiTrmnYT8Z54i3tsNNpnBfiEwtloDVMi
 oXBg+YKUELzF5dtbNYHsi6YAyuimHsz8H5AXQxTkBRsuB8F6ws1wWaIsdxbqEM/yAjAl
 yp6bD4hff/gRJd7jzw+gDowtgVaJNs2IjxbDYRnUN6ihwO+mP+KgJ9hg/CBo2UZiUr29
 6fixJt1WLk+HQY7N9XHZvqYvS/YsbijzTtVOHmJUA3TDHOeJKO8lCku37Ca7INgNHMJp
 Paww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788622343; x=1789227143;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wvfomyvOKTuvngpY/hxeNfz5FMbtqTR3RJdLKytrsyE=;
 b=EZxY5rgT2TT9TiOXdLGBYg2m0KTnBAZyngA+xvpO9jfVmsSrcH0PkwBijfI+bsrZWM
 EigFJ8aaAu4M22zi3OpK5EshPYGGueeb9Nd7DBAvvlM6rLztIBJZcm8SXgLlchG506e3
 udkwr6DG8LKeyW2Kvi88slw3rRQ6Mzi3BUnMJwlD0JwzY5u25MD1tSHYUpJ5+cYUg6OU
 q4Y54oH/Xb58JBBtmibU5TYf/pgisiUSc0O9AjlJzb7/gXIgyed5hJdE2X5j5qDhTFO9
 bXZbfzHQsTZXpl20Q1RrFf/oofNNGCFQJOfPr6EbutQb2KC2OUTbYgjFPllg91Pc3lA4
 VzgA==
X-Gm-Message-State: AFuF++kYp5yDRDQkGorBgqaq7Gyg89GvNjhYngcBPSt8c94Kb6Iz5TwH
 ARdePzoGxgSQhzSR0w0/BUWAmDhjBqbKp5KiQ5XYsz1d4bF9UFilLEGKfje2hw==
X-Gm-Gg: AYBFou2M9y3N6UnK20E1MqSiBE9t1RGSax3yap57JZoFPC2DMJNbJg2+/kKN3lvhg8y
 Stz6KXBOcUbuU9uL7T3xjPGwfKidZRUNgBu2IDmjLkzax+lfF7jYnqPqb9RazgnscJmkGlxVMDY
 yys448vsvLNDFS/oTOA00ZPe5VLaMNx1bALAT+lthWgfcLr2G71NQ0yCJTWyK6bBgFucu0YQTu3
 WA/z6BEyOHwpUXy8ApN0g2O5w8wuHDVvWAd0QCWQz6FiuLeZZEoqdpdR+NT5eD/XnRaPF5kZIto
 2uj1I3bBWENlCbHs7b6hdFjxenj94kR8jLInpinHy6+Aq3QlejIaUt08g56WWrJC+Wst4KZgrGO
 ohfuN5Dx5wWvkNGLQloRi3pIvqMKeZ+bnyp1FIzsL9mkLg2+UFY6dTrdYJvK41mccyDp5UuUh3s
 1bzDIeK6d9S/psHqoNeqQKBpkW0HcTjOWWTq+Nmk51qUPwDvZeScqSHuVDa0ZLmrM8gi2hMdc/E
 tbSLHrLfzyRl4zHLm2+lDgy9yWGU6yCdNhdtVnKxlYW41dv2xBgLhVVMHdObfdItbFimcc57AJn
 UQ==
X-Received: by 2002:a17:90a:d646:b0:398:9bd5:490d with SMTP id
 98e67ed59e1d1-39b26214798mr21121113a91.20.1788622342693; 
 Sat, 05 Sep 2026 08:32:22 -0700 (PDT)
Received: from
 codespaces-1adab9.ktkhmpmw22vebpok31ngjx2qsb.ix.internal.cloudapp.net
 ([23.97.62.114]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b083e4fafsm16658688a91.1.2026.09.05.08.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 08:32:22 -0700 (PDT)
From: rivaldihormat-debug <rivaldihormat@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: linux-kernel@vger.kernel.org, rivaldihormat-debug <rivaldihormat@gmail.com>
Subject: [PATCH] i40e: fix integer overflow in i40e_dbg_command_write()
Date: Sat,  5 Sep 2026 15:31:55 +0000
Message-ID: <20260905153155.2252-1-rivaldihormat@gmail.com>
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

Signed-off-by: rivaldihormat-debug <rivaldihormat@gmail.com>
---
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 0b52509cb14c..ca77636bf3de 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -722,6 +722,8 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 	int cnt;
 
 	/* don't allow partial writes */
+	if (count == 0 || count > PAGE_SIZE)
+		return -EINVAL;
 	if (*ppos != 0)
 		return 0;
 
-- 
2.53.0

