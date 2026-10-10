Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B512CA6017
	for <intel-wired-lan@archiver.kernel.org>; Sat, 10 Oct 2026 09:57:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB55C6066D;
	Sat, 10 Oct 2026 09:57:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IJwb6OHsf0NH; Sat, 10 Oct 2026 09:57:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 47EC9605FD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791626267;
	b=EKv/5Z2Bp20bvaS16YupOsW8MiEHTIJ3IOxp6v97Z49wOlWmjr1uqOnoVqpt/jjQBKoQ
	 EFjVWpQDslzExkaeIk6B56/3GfSrl22UPk22S1eoFqZKxK0T9nNNMkPs1bLoomyuYkjAM
	 YwnGdQn9ydGuEPGgK6Qe8dw5BaVGVh8iIgjstDchAKRp4zukC0JTiB8XPj7F5jUiOGUBW
	 0YlQQgCpi2xzJ5UzrNb/gYogz750cFHZczBBi8fR2W7cDZakkydQp+hDoS60YBPetSe4Z
	 woQ32+LW5cXOgIves8CFOdQGek499XsEffCx5rnqgYNZ9bJOoIRUgPjft+pb9BZLrjQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791626267;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hQPWRbNeIH7lXXLvr40puSxiAe+yC5sbHqy3bXmapJ4=;
	b=NMA5X9fBe6vtXPq0AJFL6xw7C2GRGiIBGo8ZAXkh11FjV2the+0sz3SW+a93HmB6Doug
	 EBW+yPAhhJT3r2f67ozqqy6W1TmPRr56BTQBnhojC/nldQL22r/BNkF2TNvP0rEyNuWEH
	 91T+cPEj7FGpPz5zptZtt2lbEApTPwrEHXJAfiHyN6z9ZvnH8GHFUSpRUFC43QvQITeWF
	 9C55FT4Af0AQxpKEcZOu5AgZcI3l1m/QTpxQ/tKNv1OKHsk5sQdvuLcIO/t/dtgEoHS4j
	 CnXsfPZVKCgWLtb9dAfztUip0A8z8+jd1oJohv74I9cAqXwkAGDQtiwtlSRuiBEwsXA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791626267;
	bh=hQPWRbNeIH7lXXLvr40puSxiAe+yC5sbHqy3bXmapJ4=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=5jdjm6HPEzT76R3Ku1arqaWliEbMa+JFh7rSQq1MLXMDcjYC8fyBkFnSG7GwxoNS2
	 Ucq3JRF9h5gegfkEZIWJtRfjEUqHyCwlrXD9gxjZKHD5K5R2lBNj6aWMB7G20twgQU
	 BsoEY991edKVnLv5QkZcYeY5cOCDXPxp6nA5fMYW6NC51f3RNPfxS5HKPiEggUceTR
	 6tAyTy2GCQGsdUdrFQqvUwwp20X0knlCp0mzk647pHotZQZYVaG6i3eEopVh4te8l7
	 /g0MjrNEuBco+y3cZolVenqM1nX8G8bL8295eyJyaFNu+YJ6uSrIyk3uFGmoIswDLj
	 VNJiiTNdhTECg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 47EC9605FD;
	Sat, 10 Oct 2026 09:57:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 04D291DE
 for <intel-wired-lan@lists.osuosl.org>; Sat, 10 Oct 2026 09:57:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D650D400AE
 for <intel-wired-lan@lists.osuosl.org>; Sat, 10 Oct 2026 09:57:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f_A8kzIEgV1n for <intel-wired-lan@lists.osuosl.org>;
 Sat, 10 Oct 2026 09:57:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BD47240004
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791626265;
 b=qNXllFKI5OyEG49bMQy5hcbmk3v9jVsjPd1P5nlUy+DeE4lAWHC4TBt0rx/6fIVNKhNp
 KDrItLL7dZNlDBiXDiEY+YJ27AHH9Ywgbqjn6NpKRe3z8kCfm4lsw51XgTAIeO2rjlyzf
 yKrLUAQABtHv/ncpYh9/A9tjeBRgQwnHRcvIP+hPuYMTGYeCgpnd/afIQe2w5puy+T7kQ
 j7+zFGNrfBUKEnDkXLyt0RGXco9pI1mIA/PbB7lMbYroDnFfzI6mY85+P2TpiWe7bdk1b
 CsXBh07Jb8qcA2Ot8V13uyQabGpHUB4vZ7PO8icWVeMxrA69OZUb0dvnUerX4B3GEbQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791626265;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=hQPWRbNeIH7lXXLvr40puSxiAe+yC5sbHqy3bXmapJ4=;
 b=bwc35qPGHEN6gu/qCM+r92ThCTFbdxS1Gq62to8ze/q4WdXn7ltYnKS2V1cFLPILoZ3Z
 qvtwuZftzqWIxWPkc2e3/8SXrCmQdJcE4GVfZxxNJUOhoMRtrVmlS0mNj1ywNAUC6+HHi
 vvKWTOCU/Z7inc1/O/RyGMr/jm09RbQar11Sxn0GMfb8n2U4m4EbfUDZcd76mmOH/eddA
 Uaw2ztIswxci8oaz15qO2RZ5nF4ua0XENc1PTWFlUT23U5ugdNc5e5+4gJewV7CkxFlBQ
 4tzbGvhG6RzhSO7UAv2qOhcC304eJRgF2uZb95RjRPGz4RF0VY+FYxcLTxMR4zd29wA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=lrIgP+0B; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=sashaneftin@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=lrIgP+0B
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BD47240004
 for <intel-wired-lan@osuosl.org>; Sat, 10 Oct 2026 09:57:44 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48c6f764f82so116920f8f.0
 for <intel-wired-lan@osuosl.org>; Sat, 10 Oct 2026 02:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791626262; x=1792231062; darn=osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hQPWRbNeIH7lXXLvr40puSxiAe+yC5sbHqy3bXmapJ4=;
 b=lrIgP+0BI0vu35pahQLcqDUqWFIVDQu7gNZCFKHuRnfP4Nbvh0Jh6iEQuruVPyqWE7
 r2aS4Jko1bs6pyxGg7E8/mD177/NmkKPVL0hGEljrncnepn+NiMcDjt6Lcp0v+j1/ajJ
 pKQDcWrP9/vOre3FUt4qfSWsr7dYbXCEjDX6xK7jwCYEHYCw+tdODCwwN9qqoOvTrl1m
 2USXr9AiaZ2cizP1HhD4YfFaXiGZdYQiVOtOt48T8FRPmBI/SAGCW0hKb/reC0rCBIH0
 AGCQGm23q2wRPPIpeRGTWPXgBMhtqPyurX6fZAtl7kOndak4MKMCx1ZPoHBcKQ2ybmHE
 LRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791626262; x=1792231062;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hQPWRbNeIH7lXXLvr40puSxiAe+yC5sbHqy3bXmapJ4=;
 b=zqouuMlqLQEjb0twMO+VD5CoH65K5eFBuYcexjpzuImLrASFIaZ5eKWONqIUqCPcWd
 WQPKtLsO4UtoHjcajA7ozrswwV4R6jFpPy44auCzbHDM1+nw175WaaPaWSLS45PARHwC
 5NcoSZAaHwGtAOlxXKRxFzoOjQb8n8P60avBf919Jpheop+YKJzXl/dOCH7n7O/6U/Hx
 s+OspNnunseMsadPSg7eezJUq258A70LOfZf//wkkJxLShFbldOiyaWexZ1yTxNs59F9
 3tPopBNaTL3nGY5z2c/VsmycnVenQYn35QT17B/R16MFZKYA7LvtNY70nvQPsQCuYIsf
 lHZg==
X-Gm-Message-State: AFq9FYKVqDtthjjkuxg1xaxYTxRTnx9W9XdOHVoz9Pa8pNZitZG7GB7i
 ayrkOdsPhRPsGkfbamsPvF41e0ms4P+GE1W/grvaa+/0287d0TpTl4ZjlFRRsQt+
X-Gm-Gg: AYBFou0Bb1stN1Yuhdnoyb/WH3YiNNYBExipD1LKgAiyCi7vwZw1Afg+gul9oxAndtd
 PegP3sAKzDQdApz6+B7N/MkbnlWhg941MlPuADLZcTWadaSSKEnqcPpfyrTfy89rPstk14xxMaY
 LaLR9UTqqHXseKKUHgsH5X0HgWOpWQNhdUAXBfikSfAuPLyym51yWhaVXzNB9ckbjy/95TCoEhx
 5othm6adi/ritbRe3UhNmA/t1m3LT6qDXdhidA71f/6PTE/xr4IUlsx/c+aJ9PTy+775fY+qFsl
 PJpMpj070GhFwnNVMahJdn0WJsRjl+wMfBjXUhEY2HBGa+QegzJv7e5OkN7fhlnDDQDiwvfedVe
 87Qb+NIg39DXHQouVvCBYKeTqSvbZmhJH2V7dxSECzMCc5fTohxUxgnbPjQ5yvb/c++3NN+8IP1
 KBE8vq6qzrh08NdaKtnKXUY2YiVe4Lj+m0kAACyArTOGg1aIeWMfmy7W8hHr+6Ytqeme7kA3iHP
 Dat2GZ5VlMXX/zNSZn/cKhguUCSmufGat/IoboS5M65D4bVZhSom0U6CWl0Sw==
X-Received: by 2002:a5d:5e8d:0:b0:48c:4d32:cd07 with SMTP id
 ffacd0b85a97d-48dbaceb601mr7849672f8f.50.1791626262166; 
 Sat, 10 Oct 2026 02:57:42 -0700 (PDT)
Received: from sashaneftin-pc-GB-BSi5-1135G7.home ([185.175.35.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9abda3csm8332634f8f.36.2026.10.10.02.57.29
 for <intel-wired-lan@osuosl.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 02:57:36 -0700 (PDT)
From: Sasha Neftin <sashaneftin@gmail.com>
To: intel-wired-lan@osuosl.org
Subject: [iwl-next,
 v1] igc: remove unreachable break in igc_xdp_run_prog method
Date: Sat, 10 Oct 2026 12:57:27 +0300
Message-ID: <20261010095727.87751-1-sashaneftin@gmail.com>
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

The break after "return IGC_XDP_REDIRECT;" in the XDP_REDIRECT case can
never be reached. Remove it.

No functional change.

Assisted-by: Claude:claude-sonnet-5-5
Signed-off-by: Sasha Neftin <sashaneftin@gmail.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 1fb5f3cbe93c..3b7dd104d8d9 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2525,7 +2525,6 @@ static int __igc_xdp_run_prog(struct igc_adapter *adapter,
 		if (xdp_do_redirect(adapter->netdev, xdp, prog) < 0)
 			goto out_failure;
 		return IGC_XDP_REDIRECT;
-		break;
 	default:
 		bpf_warn_invalid_xdp_action(adapter->netdev, prog, act);
 		fallthrough;
-- 
2.53.0

