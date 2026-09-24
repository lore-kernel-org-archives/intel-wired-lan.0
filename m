Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0C9C9830E
	for <intel-wired-lan@archiver.kernel.org>; Thu, 24 Sep 2026 10:00:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A085260B4F;
	Thu, 24 Sep 2026 10:00:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DxNRrCEqVLQ5; Thu, 24 Sep 2026 10:00:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C2AA360B68
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790244036;
	b=qXd9FeaLrMfQQQVGiLbEX6j7BvAGrqU4zJDgp4GMLY8iVK+h7NXvPxgBwpPRwvtt7QI7
	 gw8HZv46rr+Hx2cLoeSGLS6mjOZxCyJVE+U7G7tMEon0OoLUOjBdBq2/15knMkisPAUhD
	 kCDWwlSklYpSxSXveQOV12qItleBghpSrUVaDYr+WyvLEmAS24qhuhJwDTmOg9owjs4OY
	 tnAPlx8gBsG5TCdZqcqWXTghP4St455ENmDIr7pVD4gQm03AfcpCYHDXIf3KCqcXa/auf
	 npSfdIu4EFPiQLVEyeyV+HDfb3+wBnRI6G38+EGQ16bE9H0f3fdB0BvNgk/obkxoYrg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790244036;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=U6oEIghWvcJ4GRb1a00MSWjde3NQ7RviSDO9ePyO6Z0=;
	b=jVCUdg/gGEE6JZRNrUfA6wvBCjU7sYUEO+hr1Q26b8Ez2f4hNgw8D2TCvRun+IAMYtmP
	 cTmx09kYhdTfYWQGibhLCB+Pq3XxYerl51sTCEab3uwwKr42TA+W0TYX7mBOYHIJv5s3V
	 06O2hQ/r2J0kJig+rMczh3vtplAI5V8MXFZADaUNaNaPoH1cOrJ2/4M5cFglASSxMtoEX
	 NYThf7s4618rn8yRX+x0X0YvSyGsgplBVHyKH4l2IU9AjUF2OoSEZzXagvpiXc55C9A6q
	 1o78CrgQUnVROVHUjJMUxk6xOmb0tqhdhAEYbNUpj+f8cVxBg1y3iP8yoad2NApECFw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790244036;
	bh=U6oEIghWvcJ4GRb1a00MSWjde3NQ7RviSDO9ePyO6Z0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Zp2k2ReUQeUrPWvt/PhHz1atOVEnBov9sx1Ex3Pk/hXGpMQDvARgk4zmjplXfpgPl
	 puKNLEbO6SlVCPqP5Dv9ItQaUX6WtKJjQ9KEBz9Chs9cCcsnjwFmSR7mIpnniTO6i6
	 KeqBcWWa2XFgp2c1wtnl5qsmH+153/c8m4PwUFkR0B8wS/ShauPJsSyuD8A2w05y+d
	 E4MkN+b1/c6idigJmE9sPpCixcVcTpoD9qkizAVyTLHljz9zRIuyjXOYYoQoCOTCgE
	 /l6+P3psdnhgKjA0WkjE22V+BF3yRJyLxo459j0T8/8AFHl8URGFQ60x31L8ugISQ5
	 RdrdHlO/dZe1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2AA360B68;
	Thu, 24 Sep 2026 10:00:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 28C781344
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 10:00:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 08E0B81A5F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 10:00:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FW79LqJObyA3 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 24 Sep 2026 10:00:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C310681ABA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790244035;
 b=YwdgFBInBq7tTm8UVcOgKHxugahMvhchCbPPC4OI8S/wjAbrBoSq/zp8QRNCvT91jVnF
 lJGwVOBFr1igBWfS5y1ocMCCcF3UBfQcI45KHpMzVgSmfRjcnWV5MypfHhrE9SOsQrKuH
 MnQ87xcnPQEeiLune6uQUEZ+pLlbzTvm1wK9JjhcMVSpUfUaezDgl6+4iAVR4XR09Yami
 IwiMHgvslhYAOkNV2A0YtJogRdUyDzxDxDqePU9SQau9kEDEvdZhZdwCe/naZBL1+tSvt
 PLFGcTx0BGfcwkwWEiAP3bcSruM/YbrV9H1TmeJtZdH0ypyFgAIAYFFtY+LLlO01JsA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790244035;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=U6oEIghWvcJ4GRb1a00MSWjde3NQ7RviSDO9ePyO6Z0=;
 b=snoHrYz/gIT28q+JeFsEJ1HaBe0jAXOqXBCOvckYaRJjicpPWxo7fOJu9FYzn6MlN8Dy
 EVtiSR2CzXSvWWZCzz0an0HuzmjnyQhpTYID/znc8ttVEK5VpsG6484ktjyQQQRPmF8GG
 h7zwpBugywpTzS6OTEY7ZWnvLm3Iu0qyuFV4Duwzpb0YBI1igpekcyXb2y57VA0srzpVL
 my1xBfzw8N1eX2JyaIy/daYu6h/pZN3MVF1G4Nviq3ar4VveSPwkgBQYgQEf5Qce1o9YI
 Yy5I6+ThXq3EhcqGqg8WdV613Sgp7FnZ/rRvYDIyqPOoZY1aWp0i5LqTkhE4J0WtN1g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="tBjFTi/x"; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=nsvatoslav515@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=tBjFTi/x
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C310681ABA
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 10:00:31 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c254f9f0b20so285512066b.3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 03:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790244029; x=1790848829; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=U6oEIghWvcJ4GRb1a00MSWjde3NQ7RviSDO9ePyO6Z0=;
 b=tBjFTi/xbV7dzBpXV8SJ8S8RYkltzG8Ar9j7a/4z+gY38EsGuPbi2bvTRkWzj2JT8n
 YoYLquP91fHpnkDVIO7KJiFpIuMm/vg+MjrokFfNPkdLKKWs6uPul1F/98YngKXKVzRt
 l9kAjYaRZxm2y9Y/9Si93SOKSpZOrzjTy3VDPjpsuCAwM1ibLJ9IQo0XKEN31li7cIUV
 g9M4PaLzSncOwM+MG92vfU5ePdG5K/yFK04xE8pkkLOREl1q2S7G1T4ETryUNid9MSaX
 qFEwZ3Jso9U8AGtg/KXNxDwZ31MPf/+FTeFDQqomPx6oyrH+jB5jHLFAlzgwV3fK/oOk
 xzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790244029; x=1790848829;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U6oEIghWvcJ4GRb1a00MSWjde3NQ7RviSDO9ePyO6Z0=;
 b=qVoVtTXTuDcXSA9VPyReJ1dTntmN4qVEpk+Minm/w8PcO9fSguCxpjSrdy9tbeOFQn
 SbvtFpluPbsZBJOQmTjO5vvfJyrEeAvUe6SjY0Uq5IaCz0RgbgraYJepSkW45c/8igZe
 VlLRHo5utEnV8s5Lcayvl6mT8C0YiVDZeRDGBHsiGuerkpHloBL0rojUEGNwr0PaV1nj
 rd7uM7dJh8vkn02KOdH5udLvzs30+n1aFOUIidK9L4OIFT2EMpzKwjeFb7mssvg4sOzX
 JyGZf6F+He8azIjg0BgubNqdjSZYEREbwGfPjKz1+AaxHn+BIBTnlrtEwI8yYI0/qLzA
 1H4Q==
X-Gm-Message-State: AFuF++lVG6cFlsdLmm2v+KpmlRDh/l6Kxwyb4vS8zUubBf79vNkYMXDJ
 Ec0gFwT1WyJ4F/lWO7AvjFDeQCJ3hAuoXQrA64WTk33eePkmxbprWhv+
X-Gm-Gg: AYBFou1qullW5I6oSdouWHSfDijbK76Y0W7T2Y2wUXPfWrPzjRlZadn1qdNuOt2XQpu
 6iR0XQHidKMXmtYmYt4qpb2+IwntWICOpDD8BmDnXMsrrDMO7YKinICcy/U+08yJqJIvrfDoCKv
 Cec4tKF9aiy5uQAxiSI86Qo5wgDGEksUy3AaJksZkZa4aA0T9gN1xIqjX9ej7TQynt9gniIXAVX
 /r2+mzdPWq1MJAkwhxGNNynyjkNJE88/GT109mPcEhQCJjc+zqAKMPVhW6WrKTtNVlnF/kuoNa1
 zUqGTV2lhVFcIIpzXxUqYVMDAeFCl8C7NLl+cXiSOIkUsD0ZYQwBbyEiS9oYnqawW17fRA0oiD0
 7rusxxpXaIx4UksXW3jF7p4fWDMwVt/UlgjVgEo/u8XZc1Ks+jMaYSCH1gbgr4Q/i27AiZPkwAj
 lfQRsyznG86C1UbxBepKiQdkE5IquocpvDbmgx8gJx4f4J5VhN3HHppx4TtYyqdoPNWrfIVGti1
 5gSBHayD4fPIrkm
X-Received: by 2002:a17:907:9407:b0:c29:f0ec:1c15 with SMTP id
 a640c23a62f3a-c2ac20ab89cmr165652766b.6.1790244029398; 
 Thu, 24 Sep 2026 03:00:29 -0700 (PDT)
Received: from localhost.localdomain ([94.240.182.136])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2aae6682d3sm260123766b.40.2026.09.24.03.00.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 03:00:28 -0700 (PDT)
From: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Svyatoslav Nikolenko <nsvatoslav515@gmail.com>,
 syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com,
 stable@vger.kernel.org, Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net v4] net: e1000: fix warning in iounmap on probe failure
Date: Thu, 24 Sep 2026 12:59:55 +0300
Message-ID: <20260924095955.3471-1-nsvatoslav515@gmail.com>
X-Mailer: git-send-email 2.47.3
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

When e1000_probe() fails, the shared error handling ladder attempts to
iounmap() the hw->ce4100_gbe_mdio_base_virt pointer. If the hardware is
not a CE4100, this pointer remains uninitialized (NULL). On architectures
like x86, passing a NULL pointer to iounmap() triggers a WARN_ON_ONCE,
which is fatal under panic_on_warn.

Fix this by conditionally unmapping the CE4100 MDIO base only if the
mac_type is e1000_ce4100, matching the exact logic used in e1000_remove().
The hw->hw_addr iounmap() remains unconditional since it is guaranteed to
be valid for all error paths reaching the err_sw_init label.

Reported-by: syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ca1ef9e2e234b8d3599b
Fixes: 13acde8fffc0af ("e1000: Fix the CE4100 bus type for the MDIO/PHY registers")
Cc: stable@vger.kernel.org
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
---
v4:
  - Actually include the code changes (v3 was sent un-staged by mistake)
v3:
  - Switched from pointer null-checks to checking hw->mac_type == e1000_ce4100
  - Removed redundant check for hw->hw_addr since it cannot be NULL here
  - Added missing Cc: stable tag and Closes tag
v2:
  - Expanded commit message to answer reviewer questions (reproduction details)
  - Added appropriate Fixes tags
  - Added Reviewed-by tag from Aleksandr Loktionov

 drivers/net/ethernet/intel/e1000/e1000_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index d7f5c6f16142..d7e279b739b8 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -1227,7 +1227,8 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	kfree(adapter->rx_ring);
 err_dma:
 err_sw_init:
-	iounmap(hw->ce4100_gbe_mdio_base_virt);
+	if (hw->ce4100_gbe_mdio_base_virt)
+		iounmap(hw->ce4100_gbe_mdio_base_virt);
 	iounmap(hw->hw_addr);
 err_ioremap:
 	disable_dev = !test_and_set_bit(__E1000_DISABLED, &adapter->flags);
-- 
2.47.3

