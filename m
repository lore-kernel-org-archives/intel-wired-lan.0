Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC677F8E499
	for <intel-wired-lan@archiver.kernel.org>; Fri, 17 Apr 2026 03:35:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F61660BBD;
	Fri, 17 Apr 2026 03:35:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RZeaHcB6_m0e; Fri, 17 Apr 2026 03:35:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A77736073D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776396920;
	bh=hvouVp4w0YbHvQbdpa7mn27k6mvB2sHRdWB4T5BpS3c=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zBIUxfvhX7+wDAggQg4qOGxiqnyf0BeHEyfG3flzMauqwrrLiMeCVGN03cHsFHZG1
	 pVMSbPpgwUUfJO095a9WuQFaqenPu7f9ieY/TCqsPJ+uNDADlYCz8gQr0RxNluQDJ3
	 hNU3NRXgSM91+jQ2DaBxb78m0WnP+Z+9PwVv46VOl8jozJO/xNSmaDyVs57pf2zZGz
	 n9ZZjpaEYAzgoFzaar3FUCM2l33YyfMQaUmAeVwnMhAWSo0GLGkGl5jAVcmTpziI7C
	 xW7iL8EgoWLYIoJ5UUoswfraRFrrAMgWEbUyCm3a88iHahykhAdIZdFLVLNiok0k3Q
	 +PbD/N9uq9Y+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A77736073D;
	Fri, 17 Apr 2026 03:35:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 057D5259
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Apr 2026 03:35:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DF6AF81208
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Apr 2026 03:35:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nqcMrAolSNhn for <intel-wired-lan@lists.osuosl.org>;
 Fri, 17 Apr 2026 03:35:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1231; helo=mail-dl1-x1231.google.com;
 envelope-from=tactii@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3DDDF811F7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3DDDF811F7
Received: from mail-dl1-x1231.google.com (mail-dl1-x1231.google.com
 [IPv6:2607:f8b0:4864:20::1231])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3DDDF811F7
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Apr 2026 03:35:19 +0000 (UTC)
Received: by mail-dl1-x1231.google.com with SMTP id
 a92af1059eb24-12c726c30efso218244c88.1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Apr 2026 20:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776396918; x=1777001718;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hvouVp4w0YbHvQbdpa7mn27k6mvB2sHRdWB4T5BpS3c=;
 b=AvDI5m6+ALNFydEBWxokTCNojuaQBUPyAbf8ZtMA4GVjAY7z6uMk5TdSobfLLPHUPE
 gm0l6GZZvwF1vWvJNf5qHeOkOli92N5vKFzOT/SLn7quUTwMUlj4Qm+ejuqgRJXdIxAP
 CSNFKpmvI39m/IqHjD6SvjYatQTyeRE7EyfDcW+N5oiB4iOzoSyDTb/eznsBgo2vRVsW
 xZyaeUTj3Ri0+AB7LSfiaoAmjtEpaMIKUCeS+Fi658XS+1mQ8flm6LEEwVZ0SH41cjGB
 tp3V89iFEkrcFE52GzuG9dh2NlskZ/oBa+ypZQQOEme1G2Z7o4/0JP4X786hXMe6uobe
 Aztw==
X-Gm-Message-State: AOJu0Yw8OM1dMD0rhewo/1cz4Rbc1jU2EiQqx2h3/K6V4XxbpKt6/e7p
 fJo+9wcgOVsYTPjSPi7CDqLujEOAuxBfEaR/AU6jnm7fFRc6ZuL2ccaKaBm0lpV9cFs=
X-Gm-Gg: AeBDiesN4yHR4ENTyCZljgkOpAvLY68Fa2pPJ+sp/pMAbqp0sFGmrh8AL15Ga1gPwFq
 P3T2KnQiM0wSYBASxEQwxe6TtZxYCwhcrQKvhxwCPQlJAOSMMTcx5WtUOCXizey6mzNP4RsIraY
 7U6DvpQTc/dfTzZ+LTcA5YILvwJENs1ofvL5A/+DCb9RejIaGKg3DahvgeEnB3tmvwBvlmhnGi7
 rAhlJMN8aySsNlGmKlpUJ6GCuvuXjaS6A99LbPDrk0e4sq5OXTxHg5OhjxmJ80isUuWD3njS/BS
 adNnsPrW6Uws65n6gMBDYt3+k7D28CE6EJGdjfWHac+xwY9lqfr3mB3ehhTurgfaX+POkGX5U3E
 U+DpwMP74wfXaer1sfct/F5SXy19cLTL7IXw6eSvOvnyIR4aIuN84+9IzOIRxYx2WrlNocMx7Sn
 YyMskz+X9+0PMIjAIteRmmo/+A03FXtiKBMK0=
X-Received: by 2002:a05:7022:220f:b0:127:5cd6:fa45 with SMTP id
 a92af1059eb24-12c73f72632mr449412c88.14.1776396917545; 
 Thu, 16 Apr 2026 20:35:17 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:ba4:7419:7bc9:9c2a:7cc2])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c749c46c8sm511978c88.1.2026.04.16.20.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 20:35:15 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Matt Vollrath <tactii@gmail.com>,
	stable@vger.kernel.org
Date: Thu, 16 Apr 2026 23:34:52 -0400
Message-ID: <20260417033452.640551-1-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776396918; x=1777001718; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hvouVp4w0YbHvQbdpa7mn27k6mvB2sHRdWB4T5BpS3c=;
 b=s8qqftE9LWJmp/JmG8UAcDwRlI5IbObXTOyaJ7jcGI07GLi/hbiCLU7L9h52/kkq8d
 RVrqe2hcqRGYr8caDgzEG2tinTZX2c50sffbYhthOPzQt7HPcIo5j8lMqnf0ElSVEqS1
 BFBXFk20FvySKc8J+UGN3OL9QyFlwnBi0QZ7Zs96o6nPijPfjfRpbpa2kZReeQIUlC5G
 gwe0oYaPn7tVgaY0K6wtpLt98GonSZUAV9J0GPWkG+zMwvCSkUZeNHexh/+wU4x9nq2V
 o8BHDmGbPBDhqb7VzsXDFXeZMdiAHfI454v43ieKu1FoLpzIFd7peTms9OikrHAWQdXg
 mbdw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=s8qqftE9
Subject: [Intel-wired-lan] [PATCH iwl-net] igbvf: Fix leak in TX DMA error
 cleanup
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

If an error is encountered while mapping TX buffers, the driver should
unmap any buffers already mapped for that skb.

Because count is incremented before each frag mapping, it will always
match the correct number of unmappings needed when dma_error is reached.
Decrementing count before the while loop in dma_error causes an
off-by-one error. If any mapping was successful before an unsuccessful
mapping, exactly one DMA mapping (the head) would leak.

This bug was introduced by a 2010 fix for an endless loop in dma_error.
All other affected drivers have already been fixed.

Fixes: c1fa347f20f1 ("e1000/e1000e/igb/igbvf/ixgb/ixgbe: Fix tests of unsigned in *_tx_map()")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-4-7-opus
Signed-off-by: Matt Vollrath <tactii@gmail.com>
---
 drivers/net/ethernet/intel/igbvf/netdev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index ac57212ab02bd..19b2228e80bae 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -2190,8 +2190,6 @@ static inline int igbvf_tx_map_adv(struct igbvf_adapter *adapter,
 	buffer_info->time_stamp = 0;
 	buffer_info->length = 0;
 	buffer_info->mapped_as_page = false;
-	if (count)
-		count--;
 
 	/* clear timestamp and dma mappings for remaining portion of packet */
 	while (count--) {
-- 
2.43.0

