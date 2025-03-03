Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37235C282D1
	for <intel-wired-lan@archiver.kernel.org>; Mon,  3 Mar 2025 16:15:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D12938146F;
	Mon,  3 Mar 2025 16:15:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u5sTRzuN9MfM; Mon,  3 Mar 2025 16:15:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9840381F44
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1741018522;
	bh=ALzECRug3pCnEgmKD7GaeWIQgfl3zaHcGtQwIkelrJo=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UVPe8Xo8dUUDPBSdvimFXz7PSIeuam+K0c+4uW5YcPyn9/0Si0pdzRmZeJxW9pZeD
	 oYS2IJYgVX/60SAihW+pZAts6k6HW4JOaNyBb062jhYePdhX7SZL6x5P7Zud1kxJr7
	 7gxK/e+ea615MpCYtZEHS4g2NRF8H/9R0PZv7JEnoFdVOwES2JwpwOyPwacPcBl9UH
	 EppoYe2BNItWlITCd6tyCXASaB5L+FGPepG0/+oNBKsJ3gAxSA8CfpjzxoynO3ra5o
	 G6CA4FWdBZatI3ftnzxjq1W/Bq9qyrn47RJGhfvKqwf8HhCFzkXltBYC3tCYr6EkuE
	 ZityXobmlS2uA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9840381F44;
	Mon,  3 Mar 2025 16:15:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3C410D2
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Mar 2025 10:20:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 282C4402F3
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Mar 2025 10:20:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8W3sp5Eq1wNa for <intel-wired-lan@lists.osuosl.org>;
 Mon,  3 Mar 2025 10:19:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com;
 envelope-from=bookyungwook@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 08C33400C4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 08C33400C4
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 08C33400C4
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Mar 2025 10:19:58 +0000 (UTC)
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2238d965199so21155765ad.2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 03 Mar 2025 02:19:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740997198; x=1741601998;
 h=content-transfer-encoding:cc:to:subject:from:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ALzECRug3pCnEgmKD7GaeWIQgfl3zaHcGtQwIkelrJo=;
 b=QyyKe3w/P/VxyWlKK65Yts5I6fdxg4CSREINjAeSdaBM+QkqtqgM2ZvIVRHcS2yCAd
 5IVivthHi/g1SOW0/lKLKbYqv97kHD0vkdQZI9wLnhy7DJrep/w/uEpa2t++AEmKfSLz
 Uk+MngHyc7qVeayHkb1ubmojj3B8LOj5RWPGVeswCm7EMV48LzUyTQsgfO1v2ETTP03G
 cWcnZg41hj7Sj58Gh3/4C+vvCNpPh4Y8o+wxyQy+KWDchv/P4JTJhwJuYCB1FctAmy6Y
 j1UfR02l6zR6tH9Yn3iiQFW2cgt4ZVIRCKmpfGahFu5zZG3IMbM7Aa49dgpIZ4gsUrED
 NwWA==
X-Gm-Message-State: AOJu0YxKzKWxmF0zEELCniyXOo8evNPJS1oltkX9J9HUn6EgrfmXv5CP
 hiXMflYQLBZV5IjbPxRmC+MJ/CKu1OgEUUi/OtIzdcEOdNK73WrE
X-Gm-Gg: ASbGncuHl7eJzXWbJnGfyLuqtzpkkYm6zmqpRhDBJ3SiQOYr9jFQJi92C7xw5IVJL6q
 FewXwHqGfj9EkKc9DJvWOOVCbTycioz5kTQgz1IdyNtsBJUp2Yhk9cHWKvNZHNebGaFsZsduEcW
 LZmF2Puf8s3odCA1sllo15HsGLZg4IXcsa/DHxx+73N8j2qspzyvqmxkoE7AZj8tsezcngHPx24
 ITL14cepyC0B+AJUngXmUZGlG0YdT0hUQUSDgInTGx7KFAxcSkVjXyOlYX68IaQLUp5FjCgicLj
 /VWledl421umTCeMi/i/s7J7kI+k4aZiHg5h1FlueogjKerszXTU4JU=
X-Google-Smtp-Source: AGHT+IHrGUCiyixgFG8XWQdXSW3V+lsIqez0Ar8UD/Zaws7YPzoId5LD3q4VQeuaq9BKNRu60//xrA==
X-Received: by 2002:a05:6a21:3a93:b0:1e1:aef4:9ce8 with SMTP id
 adf61e73a8af0-1f2f4dfc2bamr20722457637.28.1740997198226; 
 Mon, 03 Mar 2025 02:19:58 -0800 (PST)
Received: from [147.47.189.163] ([147.47.189.163])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7363f2e8a34sm3287638b3a.168.2025.03.03.02.19.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 02:19:56 -0800 (PST)
Message-ID: <ffc91764-1142-4ba2-91b6-8c773f6f7095@gmail.com>
Date: Mon, 3 Mar 2025 19:19:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Kyungwook Boo <bookyungwook@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 03 Mar 2025 16:15:21 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740997198; x=1741601998; darn=lists.osuosl.org;
 h=content-transfer-encoding:cc:to:subject:from:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ALzECRug3pCnEgmKD7GaeWIQgfl3zaHcGtQwIkelrJo=;
 b=fPhSds6n57wFpB0bTk1okDfkFAaZ8bk4CYPR4YQLC1paMpWjrrtns7XPNnQlZtU3Wq
 j/5oAVf78YKn1QBMMnSmkyDBHtvJXx4ejxQ1jRRy973uJyzRtW7ipgDLXrvpudik3sNE
 m5iPg0WKSh5vgg22IoE0G0XBJrkjboRbuirvGSMAptqkrQqaMLdIWSyvhC2kf2SAjKFm
 IH+TM43Kz+7TZO7XYoZr/v6ZU2yTjomiPnl0HTrm+KGMJ7mzqiqfFDVRMRc/WVLHXr+d
 OcyvjOv64/4WJstGqNig+AMjl0vB4ULnwWVuZpkRKbmYCgSxKrNdsGT9a+5qzPZyRNjL
 AFYg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=fPhSds6n
Subject: [Intel-wired-lan] MMIO write access to an invalid page in
 i40e_clear_hw()
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

Hello,

It seems that there are invalid page MMIO write access in i40e_clear_hw()
due to an integer underflow from num_pf_int(also num_vf_int seems possible).

The following is a sample code in i40e_clear_hw():

val = rd32(hw, I40E_GLPCI_CNF2); // (1)
num_pf_int = FIELD_GET(I40E_GLPCI_CNF2_MSI_X_PF_N_MASK, val); // (2)
num_vf_int = FIELD_GET(I40E_GLPCI_CNF2_MSI_X_VF_N_MASK, val);
...
for (i = 0; i < num_pf_int - 2; i++)      // (3)
	wr32(hw, I40E_PFINT_DYN_CTLN(i), val);  // (4)
...
for (i = 0; i < num_pf_int - 2; i++)			// (5)
	wr32(hw, I40E_PFINT_LNKLSTN(i), val);
...
for (i = 0; i < num_vf_int - 2; i++)			// (6)
	wr32(hw, I40E_VPINT_LNKLSTN(i), val);

An example scenario for num_pf_int:
(1) val = 0 (if MMIO read value was 0)
(2) num_pf_int = 0 (also zero after bit field extraction from val)
(3) An integer underflow occurs (num_pf_int - 2 == 0xfffffffe)
(4) Out-of-bounds MMIO write access if access address exceeds the expected
range.

From above example scenario, the maximum access offset value can be around
0x4000347f8(=172G) which seems like this underflow is not intended(also there
are masking operations like (2) for num_pf_int), so I report this issue.

I think similar issue also could happen at (5) and (6).

The following is the patch method I propose:

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 370b4bddee44..97ef79be39b3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -848,19 +848,25 @@ void i40e_clear_hw(struct i40e_hw *hw)
 	/* stop all the interrupts */
 	wr32(hw, I40E_PFINT_ICR0_ENA, 0);
 	val = 0x3 << I40E_PFINT_DYN_CTLN_ITR_INDX_SHIFT;
-	for (i = 0; i < num_pf_int - 2; i++)
-		wr32(hw, I40E_PFINT_DYN_CTLN(i), val);
+	if (num_pf_int > 1) {
+		for (i = 0; i < num_pf_int - 2; i++)
+			wr32(hw, I40E_PFINT_DYN_CTLN(i), val);
+	}
 
 	/* Set the FIRSTQ_INDX field to 0x7FF in PFINT_LNKLSTx */
 	val = eol << I40E_PFINT_LNKLST0_FIRSTQ_INDX_SHIFT;
 	wr32(hw, I40E_PFINT_LNKLST0, val);
-	for (i = 0; i < num_pf_int - 2; i++)
-		wr32(hw, I40E_PFINT_LNKLSTN(i), val);
+	if (num_pf_int > 1) {
+		for (i = 0; i < num_pf_int - 2; i++)
+			wr32(hw, I40E_PFINT_LNKLSTN(i), val);
+	}
 	val = eol << I40E_VPINT_LNKLST0_FIRSTQ_INDX_SHIFT;
 	for (i = 0; i < num_vfs; i++)
 		wr32(hw, I40E_VPINT_LNKLST0(i), val);
-	for (i = 0; i < num_vf_int - 2; i++)
-		wr32(hw, I40E_VPINT_LNKLSTN(i), val);
+	if (num_vf_int > 1) {
+		for (i = 0; i < num_vf_int - 2; i++)
+			wr32(hw, I40E_VPINT_LNKLSTN(i), val);
+	}
 
 	/* warn the HW of the coming Tx disables */
 	for (i = 0; i < num_queues; i++) {


Could you check this?

Best regards,
Kyungwook Boo
