Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C1B7C79F82
	for <intel-wired-lan@archiver.kernel.org>; Fri,  4 Sep 2026 15:39:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E656C40BF7;
	Fri,  4 Sep 2026 15:39:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TmB99OP-eMgp; Fri,  4 Sep 2026 15:39:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D6C7040BF6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788536365;
	b=pGGZSXdPlTxWbFDFeH0k0K7G/sDYFXXJc+k66lCRjFYrrmjz1J8L+v1obmDWcFI9+6dW
	 3APXxY6RnZ8y2DYsbZ64Shcfg8KN6tuAdwHNdo+Mh1dACElnbnpz7sm5h7b1n4DsTywqi
	 AL/Hi/Sr2YXg7EoL5kRhOhuduyl0yGeM/h1lJyCOCwLNWo0NyVHkxnvaQTtI7SNMqssyG
	 3eNtF47/BqENtHSsTYD/k3EXbsFHpy5N7+d4U4IdVl679nzeY+FL/nKfDL2qUCwzJ3Qoz
	 9YQZsy+EKswUTcRXVZAjjX0ySGjj4wKqhvu1cT5EikzBmgNXitYfKHzh9b6EtRmHB5g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788536365;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=DWmGOPT3T1V0QbR4ZU9i41fdA26ZNjTQm+SJiNpfKWo=;
	b=Ny9SalNokJr6A0qVPlaLe+rqK/FY+ZVGvWQhUPnpA7RaephirS1n/UfMq5JE4kcER/vY
	 ARIfJqO9uXmPd2uKzAzt1pfN8bJAPD+BpUw8OcC/9SmFPEbe+yEH9od0jejq4HsGbnpIx
	 1xVOhqQnUSgu6XifQD3eOQIPZW6yW+aBYiRwBfVCY3l5b6SUpTx1lOJTBMMenbTjRufMi
	 AvNHEpabSo4L7Pv2My/Kt+UdZc65MzHqN72ATVYeBo6Ty640q9eMlujO+nKftr46wL52b
	 7hFjQsTQVrz+EAdmHvG8ec25vAOMuR/AV7e4YMq6sK5+5V62kWOGmZHqlpuq9KDVefQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788536365;
	bh=DWmGOPT3T1V0QbR4ZU9i41fdA26ZNjTQm+SJiNpfKWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=4jAKIsHqy/IccCmSPEgqXb4pLwcgv3cTKZ5FGfa2Sv2p2iOQSqk9qdDOwDUUgal0W
	 KP48u1yLoqNWlqqyJMF2yLMVcgJqQur09esrIFoSO3bA6SiwEq/RV64deLQxlnNOBc
	 AAP/d83zHNlVUasjn+5JQ5Ye3EOfLXoPK1pFn1xgbX/NPtyximIlK0DkZvTz+A+Q0M
	 gP0Qx1CVKARUkE89BV8nBRi4NCK2KoLdTPZghJvujcB+ugD+xhyMKxyXEWXYqmDv9y
	 nVPXvNANblGFMRgudy0CBj5WBrWygfmX5hZsAWBtQYyjqNsrXoHaqvu65Si2/tgrrw
	 V+l6/LR++i8fQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D6C7040BF6;
	Fri,  4 Sep 2026 15:39:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 73F30363
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 06:27:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 65ECA80FFD
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 06:27:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ginNM1V2wXq4 for <intel-wired-lan@lists.osuosl.org>;
 Fri,  4 Sep 2026 06:27:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C44D080FF9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::62e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788503224;
 b=n+STAhlHbQMk5uUsZzTnvWEbTWqN24u+72UaNLykPUDxWkCh1Ta74QnCBemaUl6A9p1r
 px2DMmxr13+MMKg4Di8r4GMzQoKat/ZadJNpMsOpwHuvYgCQAOQVOk1AaqhK8hnmSggug
 rTPpWCdA1BTJ/NQYYg2hdb7FD0gAIQpVDl9sRVVRn9UgSBX2YfVWbbefBrHy1apl6bLeZ
 de+vLHSxELmywhyzvWb1Oh9wvqyTcG6MkOK4CZ51+8Gga7hE2qN6Hvn6sNakRT3O3M8o/
 0wDrh7p0/rp5tFn26h9vT8tQTcSfvJqHDmtpu3TFSKWREd1mjuCBppRKI4UcEsTVaIw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788503224;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=DWmGOPT3T1V0QbR4ZU9i41fdA26ZNjTQm+SJiNpfKWo=;
 b=f0thsdhnvXdoqasVXZv1FxaPVDSuWoC4cprw/VLXBCCIprohaFSGczVoyp7vPq4kscZf
 rEVB+K5pTYkYtpJW5qMApxhFNnVV0gg4XAMVu/xr9gEpyNnY78C8fhA2iBbroVSSDku1A
 yZIn6rVeH9k10ND7QX49Sca4K0z8immBXH4XpbxJ5LUqTpB5GOaRXiR618raNEMI2NOee
 Biry01fV2YpbzRKla12IxYakw9YMJ6Q1shMPYVAyM9A3Fxs0pPDFDY2Zqy2nH3Kri8GsG
 5DMMXrK5qly5wft71LJ8MkD4g9Kh6ZVbeGHrcuCyu2TA+QQ1JE0VwP5gfWsPq60ubDA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=SVn5iC4U; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::62e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com;
 envelope-from=rivaldihormat@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=SVn5iC4U
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C44D080FF9
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 06:27:04 +0000 (UTC)
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2d8fd3b729dso5797315ad.1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 03 Sep 2026 23:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788503224; x=1789108024; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DWmGOPT3T1V0QbR4ZU9i41fdA26ZNjTQm+SJiNpfKWo=;
 b=SVn5iC4UjW729N0QsA1E7S2kgpvJJCxSRBOO59BNvTf+CFhwe+FpEgPHMMJskSAh4j
 17oagG6l+krEcCHs+Eq0mP5n6BYpuFnm36gC7dHsR2y71EqC1pMY1wafzSOqKMgp/yHS
 1YWmo7z9g/ahhhibWn/bZPY+M1sHEXMr+ujUxrLor4Pdx1UDzVgMup+nSsjoc3aodR57
 KQSj/2YrExMwrWyhZz990k6H+oplPZak/4ztsZLjg8A2bqU3/wIvvZetC00Pec7M4/Gy
 z4LFlIu7DLEcJsEVGWs94TsYpMxZstIWw0R80sZ1iRnusD2tkcHg70HfZo8Q8nkLWGr3
 J8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788503224; x=1789108024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DWmGOPT3T1V0QbR4ZU9i41fdA26ZNjTQm+SJiNpfKWo=;
 b=rXyHNfYofOLh2F0xtjPrB1W606zdnmqTSfSB77H6JVTaRc3jAEM1eNl+ps3xjzYlyV
 /A81Cfd0U1rS1UQNZyd6QAbA1salhzvqQCYyuQU8kf9tij81w5sx+YzHCmJQ+NAI9f/y
 Zr3NdVYZ2uHc7u6b0R2tOV94DsPrNz/Ox63pk8OxMhtOlovxXpTg8FBCg6vETLU6A7FM
 VDcGkk1Eqzv48v88wMXhaH/aDr22w3hZMwSr6A9n7HmXRJ0hPU60203JTt16OJUeoHSI
 68AWoWFzaXkpYQhTnhSC335Mod9zXbp8UcngpKhqLGjSq1znTWkhCqLPOZoA1bYjf7Hi
 W9Tg==
X-Gm-Message-State: AFuF++nLfGIWW27VW5ruqrfh1DwL0zVk5YFxUdSc/SLNhilFusWmNlE6
 FRpgozfjqLgOrB4dQqfskwEsiYqBB1YazgZdACaaxEHJoeP3pSwzmCHfTg1Nnu7AHbkb6Q==
X-Gm-Gg: AYBFou349qsOhaId/Be/XWuuxQtsKFUIvxZ5pStODOwB4yrYvVwNEilUQXBjKXMNa5I
 egKxma+HvOoIyIowBIQUHSeWtr7+ayVyb5V7ISjDdA1ZWXvE17iEYESTiKw0oZSTb5EfCu9dTvj
 /BndJLuBtk0QZA+xcg29OM2obom2R8GeCpgNjIthrVsbYrn3AgRMw2IAvk6AIKyU1X2rRjPpyum
 g3MpgyNGq7ug+0om9SRuwc6b1+mi9QnZNWIPDNkE1LyuU0/dcEP8zeEZ/mc7JvAoHxchG97pYZu
 ShUq0A4r3gpoQghNJAHFShYuC491wBY7V7EBQvWOOAyqN2VpvuCDNFkQ+Q+KKaQzGRJ60aMz+Kv
 B9RczA9gSuHPSdSI/1R+wO+ZLMPANSNMlqZJDxXyeXtsppvd/aDcxbGQScyqQLCAcxGJC0QaQHG
 SmY7HqWKLTjuHYprouVWWC1BBAALIAlQmIjCBlDaKKn1beHyi7t71NbYw9ILQOl7PK0XPYffA4o
 v6UaUKF0w5FpZZdcNGLPAaA0gqkgyi5wxSz1x7P4+GSGI7LnP0PTz+gjVTChzJrbq8=
X-Received: by 2002:a17:90b:56cf:b0:398:dcf6:d40e with SMTP id
 98e67ed59e1d1-39b262aa580mr6042954a91.17.1788503223693; 
 Thu, 03 Sep 2026 23:27:03 -0700 (PDT)
Received: from
 codespaces-1adab9.3gx5x4kts4veljes22u4ri2f3b.ix.internal.cloudapp.net
 ([23.97.62.151]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33450e140d3sm664209eec.4.2026.09.03.23.27.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 23:27:03 -0700 (PDT)
From: rivaldihormat-debug <rivaldihormat@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: linux-kernel@vger.kernel.org,
 rivaldihormat-debug <rivaldihormat@gmail.com>,
 rivaldihormat-debug <rivaldihormat@example.com>
Subject: [PATCH] usb: core: devio: add defensive bounds check for len2 in
 do_proc_bulk()
Date: Fri,  4 Sep 2026 06:25:54 +0000
Message-ID: <20260904062554.18628-2-rivaldihormat@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904062554.18628-1-rivaldihormat@gmail.com>
References: <20260904062554.18628-1-rivaldihormat@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 04 Sep 2026 15:39:23 +0000
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

Although the USB host controller hardware prevents len2 from exceeding
len1 in normal operation via babble error handling, add an explicit
kernel-side check to improve robustness. This helps prevent unexpected
behavior in virtualized environments where emulation bugs might break
this guarantee.

Clamp len2 to len1 if it exceeds the allocated buffer size and log
a warning message.

Signed-off-by: rivaldihormat-debug <rivaldihormat@example.com>
---
 drivers/usb/core/devio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 101cb9425480..9d8930853e8f 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -1343,6 +1343,10 @@ static int do_proc_bulk(struct usb_dev_state *ps,
 		snoop_urb(dev, NULL, pipe, len2, i, COMPLETE, tbuf, len2);
 
 		if (!i && len2) {
+                        if (len2 > len1) {
+                                dev_warn(&dev->dev, "USB returned more data than expected\n");
+                                len2 = len1;
+                        }
 			if (copy_to_user(bulk->data, tbuf, len2)) {
 				ret = -EFAULT;
 				goto done;
-- 
2.53.0

