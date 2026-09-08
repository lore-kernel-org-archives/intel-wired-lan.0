Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28971C79F9E
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 15:40:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C198D80B08;
	Tue,  8 Sep 2026 15:40:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PQjJgDE98tbD; Tue,  8 Sep 2026 15:40:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 281BC80BB6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788882012;
	b=Yz9nCPVoPk5/PSNrBSciY7v91JnJ9NHMc8Chcb/vDw/dY907556dx9btzcmL48I7xwQM
	 7+oYdzbU5XxvEMWAvLON3ZFIhI9JDFj0hZyEWFQWO8n69lHh2DmGpnrz2qRcr7ESo7BOZ
	 Es1KjwHYyK3nTxo7MuSQIvWRWUEFbL+4hLcwjxOkITu8lJyEyrOV/VmtuwJHtgJRckVls
	 4jas9IRoTISu9rpBayQ1JKjYvy2tkyDmhF4DPRe3Osi0nWe/pckBFZq3em1H8/27GRzL3
	 zycTvXR4cA4KpGUwzYeaK6zUZ1U79ARH+449ireJkRld2YKiYaOFeV4v52gW+l71VVQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788882012;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dV6ss8HzJsDKo2QErOAqMqREcJvXSKsZBavq9KzN7cc=;
	b=iqcZyy0aKVrob6jPhJF92R/HV3wo+jpfn1d7s23QzBsE/eQYUOHJUxVc6pJ+JfHyosXy
	 Z3fB5clX2JT90s2nOuAa1w4tBKY8nMd1cQhdZl6WPLyNReizXJTw+s6aCwPNs6AJ6UnPY
	 5vLudVMMFyVxoZGJD0XjR/yzcopmaJ6s/yvrXMDqc0rAqVGi/Qs7sPyXzZnAZI9AlG7Fn
	 D0pmNwiyWlv+SiroxRcVqpOMtj/n30wREHdL+hf0OSLI7Afvh81u+4qjbQQe4su1/Vxgg
	 SPxyyHQr0vM8wnTZ9lMoLAXJTLHja+osVZvyv01LFkX+fDpyh8r4wlAef2PqAheICrA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788882012;
	bh=dV6ss8HzJsDKo2QErOAqMqREcJvXSKsZBavq9KzN7cc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SgeLezA+FOW4l0U13nSU4P6A1v7Su0RmUpUPsSzhNXPoYJgq4WE1req0sosXwd9c0
	 mT9rtQonjtk7I8eUhfmZqwmPmlc+7cW7G9LfUxOw2B7Ol7jG4NQzf4KiacKxN8UHl3
	 cNgWUGHNlX2afxBVwIlvZxotMLjyKN3ZPZ5rwrfesPwRsN21xqcN7IWMAJZVJ2VYNI
	 w5OAaqZOxNZIGP23Cn4CP/CZLtRnBzCbTRl/LyLozOFAatWYDFK+sV1C+g+EtS8gna
	 wYToJfjpvWndxNt+76+ropz3f7Gc66nO8wVvZNJYmaO/zCVvrR7KAEeuDskH8RReG4
	 oUdodIM2mjecA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 281BC80BB6;
	Tue,  8 Sep 2026 15:40:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 54192372
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 15:40:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 452414043C
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 15:40:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5MgksVgzCBFZ for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Sep 2026 15:40:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 93439403F4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::529"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788882010;
 b=ZmACeVtilwNKoa/yyBjmMeqnF8YRL9oyJ57qmJ1VWL4ppQRVoMG3ldpKfXrr09uSL97L
 2wWI1t3OQnIulgoSqkAjTzm/BA95gQv8r+ilet6iol9+ZQHav+QONmVcSrbxps7qenJvu
 EVCfTwetd+1AlNIThQP4W5BxICNayR0Wo64vI2e1+cd8Fay7DMLQNQG67kx5yhRYrXMS5
 2PbcQ9KW6MUtvUCjl+R6yHBxJn/XThv3510+qALWz/i1YhHT2dWDemCXGoKg26rrkrAR/
 1bZf0f1KErgSnA4svEH1Oxc0nhzsiVpQLbdoeIluJBNA/8y/Jyp/bL/RmJF4GOySELA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788882010;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=dV6ss8HzJsDKo2QErOAqMqREcJvXSKsZBavq9KzN7cc=;
 b=LpQpIayxvCOo8yEaBo8AflRkfb1zz5rkcEWyphyW12ScyN3WKPTKyXUwaNFBJZMT+Lij
 4NJj85F7IV1hDnr7vJLcYs335yc+G7YIvzazunzGqDF+iGBGndvLJEGBVImZRpnblpJud
 VN+8kQl9+/hXIEUGZgrfIiltWY74G31kxBzyYrcDfx1cMXqsgtesRVDcvMGI7i6X0ImLH
 6agMP/baXIyQ4X7xQGfJJ4tDrSOf1YJaYJ3NrLDTknW5k5KrzgbDbuGODw8vLQvu98eIC
 0+Hf6uXaA54bcNWcDszNQb2fHZoAa5PndKVhm6h4xn7osp5vmwCygFaW5gukmYVHetQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="q7/F9TSF"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com;
 envelope-from=rivaldihormat@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=q7/F9TSF
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 93439403F4
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 15:40:10 +0000 (UTC)
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c9e607d81fcso2557075a12.2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 08 Sep 2026 08:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788882010; x=1789486810; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dV6ss8HzJsDKo2QErOAqMqREcJvXSKsZBavq9KzN7cc=;
 b=q7/F9TSFJoLa2FChbv3a1BYkL+MZOIJoXwTFsQVNxbsjmnS/Vx42iqD25WxpueGkCp
 6HHB1xAJuL7meQ5MAPwh20Ue+toiZnUaZaKU0z4vzGi6ehW4z5W70OHA/9htt+DgRjEs
 2uvoI5Z4Isx/utUP3J4TZpAjw0nLRqasnYpN+AoRSb08D3U2YXYZ4Oa+gaYJxoMs/Yb1
 GteLtYNBb3wFyAYiGiq2P+lt08LKG/vqhcQEeMGQKFsibmfXBk2/KfiokndTvvvLHUEb
 +dLozNX1A3KMB3+aU3OaFfmbPcMeXWdHUqQbA/Tk5do9sVnHWCgiIni0DtGBbN5rggqf
 DS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788882010; x=1789486810;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dV6ss8HzJsDKo2QErOAqMqREcJvXSKsZBavq9KzN7cc=;
 b=sDtNsbO3OCDCUl83nHVjldA80iRcYIzTyvnmaFoClI/NxzpLa6bNCiYbp6pF1ve3lN
 5cmwGnzWM2Eq9KNJQROna28idACm0m4fImaZiU0aK3AqdTMh0QJXlopvUo06C+RePBqR
 laUSDmNOxtM+WvecbsN/eWwdmKxnsm8FR9YGAOOX8Ib0aX6YEuEHHs2jKUS2W+e6r1Qk
 oEamfgt3M+hqtXwy15LxPdH1yXidgc86ismFeUom/FrW/smBpW0+1UBu9TOKQorAEPn1
 kgdJGh/o+fOefG14bzDfa+bALqTRUV0gZD+lahbmJ54o2I6oVAYNk+YBrClB6n5KMJAu
 H65w==
X-Gm-Message-State: AFuF++mzb0XtSOO7ffZrp6M2WUSgW6YoO0XImYSEvvIVTeWnO1U8J02o
 ni50FRWD0FOiG0X6vXrJ5xHZUjFheyX3wVfw1khmelTlYlw66ZFwvqX/gxiuSg==
X-Gm-Gg: AYBFou3QHXSqcn8fNzdE6MgiCswUu811wFiO/oZkQch7wNn9UArrPRItRPllt+x9Bsi
 MBYwzumK3Ei6VvOXxfQa2kp06Rfi3faqFi3DJPwXWmKh06ArW37SXgrRxldFsrdBHXyUJUGkTnU
 Y4u6EdjZDoWridpcn8QjCdjoar+Qane9TKIL0cfipgqTuRQnundX1HRIuX/umo/4mQaCkJl6ZXT
 5R/ielZlIOhilviqrHR9yuiBNsO4Qz3ZsUbS6ArWEUzXQ5zVB742wMqsozzahDX1BksKhkwIyYX
 q2tmQ4RlimTVvj3rF2K+uHDkDw/cZh4zWUCmcJPNrTcHc1ibo97c8IqN5G/SvdjU/EaaLgsOYze
 Ascl8/XMHVv1xFvUx4LqYPeyC0qZ9VfakKUBgAHtqjN/ZpGb4ETlWSYCYo14p9a7ZYJ97v1dpSB
 Cvm+2tb/fcTf5sTunC4K/YOmBAhApuEWBTJjQrrUmcixMEeYvbAJrI+FgJBtjiNdKhxgjFcYUUZ
 MrCzlg3YrBWCdhMvOyv4Po+z4ugQaq6yWJ8nI3TovVY2MHSIc5ybA89xSUsCz9aj3sgCSxq2Q0j
 lQ==
X-Received: by 2002:a05:6a21:9204:b0:3d1:60d3:99f8 with SMTP id
 adf61e73a8af0-3da39b7183emr50093591637.5.1788882009427; 
 Tue, 08 Sep 2026 08:40:09 -0700 (PDT)
Received: from
 codespaces-1adab9.m2fxbej512jepnsor2itp05j3d.ix.internal.cloudapp.net
 ([23.97.62.129]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-333959d5f69sm35366914eec.0.2026.09.08.08.40.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 08:40:09 -0700 (PDT)
From: rivaldihormat-debug <rivaldihormat@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: linux-kernel@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 rivaldihormat-debug <rivaldihormat@gmail.com>
Subject: [PATCH] i40e: fix integer overflow in i40e_dbg_command_write()
Date: Tue,  8 Sep 2026 15:39:33 +0000
Message-ID: <20260908153933.2417-1-rivaldihormat@gmail.com>
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

The i40e_dbg_command_write() function uses 'count' from user space
in kzalloc(count + 1) without validation. If count = 0xFFFFFFFF,
integer overflow occurs.

An attacker or local user could trigger a buffer overflow or integer
overflow by writing large amounts of data to the debugfs file.

Fix by adding validation:
if (count == 0 || count > PAGE_SIZE) return -EINVAL.

PAGE_SIZE is chosen as a common limit for debugfs writes to prevent
excessive stack/heap allocation.

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

