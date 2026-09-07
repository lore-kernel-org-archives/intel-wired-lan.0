Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6408C79F82
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 15:13:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 882F480BBC;
	Tue,  8 Sep 2026 15:13:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LkdhbScG1G07; Tue,  8 Sep 2026 15:13:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C8B7080BB8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788880437;
	b=piS/fBikCKztxud8jK12z/bfzlhnSN5Hq1ezWPjJxc2P3B2J3bO0nIlltwBInwzwDLWd
	 ZaldO6xTGGS6OFsnUABA3f35zWvLQRxLOVYVkTEG/2TADw89rIYIb45wR2JqTbRDajaT6
	 f7h8wikakkiVox8H+WY3psFnGUalJWPjMvL82K2O3/rxCwQtR8zEMwoMmoVV69rmQm7h7
	 vJlqZr5pz+T0iMDHAjFfbuVQqjlzD+POigB97ZR1j+KmjOfAxVjjcAd0cREaH+6lyJofG
	 unRdf4xEtWSlc48ll1mOEJRSglJSoGfPIF/9FSlyeXYwImElj9P4HRqn275PQrprCPw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788880437;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lSjjPSQYL1+9wjdu1C6hiIJblaC71FvAqWZOYXHWgd0=;
	b=VABVv9oA4MQ+Q87cvDwKxy6woi3Dg5XqVrOf/U2L6hTTq7XM7rcqyreDkL9F+ORgzCPr
	 pJd53kuNd/zXdAsHRNJe5gLfXQ/jMk/t1OFUNcxhdufbyU4jCAqsssok4wokSO9CFL1xU
	 h0XZfuLlUAZ8kegbACS1b19tVvnLpnWCb8T7KdvM9rdQRm/G9CUbBwJ4zry1B9KM+2NF3
	 DRIzxt/NABCngFHN9wzufEDfoFwiFK7777DM+JObNL6SEP9tUvwx3HbVAsmofyte8I8I8
	 7eQ/D5IF0rymm/OzB9GGPCmRiyjlGD4Qc4dYhuNRjP7SCMenHldmqac9PpLHE19vVXg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788880437;
	bh=lSjjPSQYL1+9wjdu1C6hiIJblaC71FvAqWZOYXHWgd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=2Swla69K1wjiQucWeeI9WOTOMGib9vW00LNMLfUBX4HRZ/vIij8LlVWZAVzww7pja
	 rhrifuTebBDufaXSS//wRsjSV+CHKxZ9Q7ryMQgI9bStntEnhM8avY6dPiujkycGZG
	 c79NCiYWWGdBCggk8KK8xryVZcspgAgYw15J+YYt5yifB5vHuzWkIfkg8/tLboyPiZ
	 zCWJJ1vwImyKFVPDe9bnDRpDnoqkDg29csuGphZV7mnDN1wWO/hg8+rx3ldoKyupO+
	 VsIPDJvOu1nd7g25Lhkt8Q2GJEeVrqsL2n4vKwQ2n79crR3Mdv7Jcs49uX+Kq/HNml
	 M2nPHdhLMSccw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C8B7080BB8;
	Tue,  8 Sep 2026 15:13:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9DA8929B
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 06:45:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8FC37400AC
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 06:45:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JH4LhBofizEL for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Sep 2026 06:45:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 79EF940068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::42e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788763542;
 b=ljn+uiW8bCg8q4knYoHDqkrB7pJehZeQCeQaVOOjOBA+5E9DNvyXJIJ6XOA3u6PqMbgd
 4kHPsfzmGHBiPuPDQNwLhVCEMCjyzCnn1T81t3Nbwk738TKzBZglnOO03pZI5p2LYkidU
 OesnKOjYu/xwozSTDFrXUnN9gNA0E5oJ+Tc6IrwGEk0OMyQoAVKtS955RYVBbwUalzE7n
 gDhLV06/AVutDVm/2fiZcd9/ZR5chcH3IYr3UPsflLw5Mul0w0eXoY1lCASI5MwkxWQo6
 zrLMTlJPczSPTxYN1twwZKJ7Y2o97pp26YmwfNHkAgzf2Q4xqzcTF24EnCHDPtxozZw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788763542;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=lSjjPSQYL1+9wjdu1C6hiIJblaC71FvAqWZOYXHWgd0=;
 b=FEMZFAON7gW9fjxGe079akeVskNkA4jmbrklgTsCPuQFqQ7ZUtpZAgjCBlp2dDsD4tWL
 9ov8XiBA8KgT0kKbTTEfVUd8shvobTvufACsUDxpZIpnTiv916H5sVKt0iLoE6ka77r3a
 CHdt+Yf+W5R9IPbQtfQ5M9YgsJxMICQ04fcOTo+ZgceAWgVRxLj9yFfJ9lU2PYh8O3+ma
 i1dZGunQSNBQPdHlk1ZgAizWYgeo2HUp6+DI1dwItr0NRWndwqmgIw+mr3xpZHm0dUS+L
 8ZSb/xWmTf6PwcoX8CKrAKHhvgzzVVtgRQjtL1z1+5Hdr2Hw9JrgdXcT3Pu2yGdMxQw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=cjoq1VDD; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::42e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com;
 envelope-from=hemanth.selam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=cjoq1VDD
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 79EF940068
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 06:45:42 +0000 (UTC)
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-86265451beeso1303740b3a.0
 for <intel-wired-lan@lists.osuosl.org>; Sun, 06 Sep 2026 23:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788763541; x=1789368341; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lSjjPSQYL1+9wjdu1C6hiIJblaC71FvAqWZOYXHWgd0=;
 b=cjoq1VDDcHYhcIa3Y8UQ1eJMh8RgFy5/W/wpESquDfZ9qTGU/KynzGwsuPVDfuETco
 8meoSFE4O8DuAYvRqoHQ8MDBxUaXLUnAEV/XHRrq+sZ0HdotI6HhtEh4/FZXJ1K4HWmQ
 UC9PGKSjGP3CxFSlzbdgP2d2A0X7+t0M+VtlrQ/JSii/t6xRxXorTcT3dWvcZ2iKXTZE
 TkDaZvuAemU2FeVTUK0d4g3/k5j6MT2aDUjeeA2uH/ef5iW/C8FvoSGJwyU1TDJKhlvR
 zvPRGMxxIjDTQsqv6LrlRT4NJlvBdRIvoCr5kXSEuZTcOdEb19uq1BTd7hL2WOKUzqK5
 Nq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788763541; x=1789368341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lSjjPSQYL1+9wjdu1C6hiIJblaC71FvAqWZOYXHWgd0=;
 b=H5tveDco+cFRhKS/NgLl0hbHbDzhPkY1EUHiyJ7xjvR3X507HwD8zOevzvrMyb/+pW
 fPvk/n9K5cyKyViAM2SN4I+EElr3dSJwjCRMOpp9Uire/uzOpln9ROCeypsWfDnFRLwX
 McU1tIUjdJepFpc+KrbnZfAoiK0Jj3+rLG7EO8wEJGjdUiNYI97Kglx1IOu0lJOgrXXb
 HuTNLKjn3/jAhWCeYVnCCYAlcPFKBOMiB6rXMUxk4h7JfceX+EZxkByQQ8StcNU58mpT
 342XWB6rxv5HjY8z0eSqYvlJfSSbU2QC1/pRA+V3a26TBpapIop8/wCX2i4BaeV0BOla
 nshA==
X-Gm-Message-State: AFuF++kLotGzHSWJEvIgZdWgy+ZP59tWz9g3q4Ae853QGaUAgkTgUVF0
 1oFvCVT/zchzi4CxTni5X2UG3zrQq/CHsBTgloYsJJ17SyPTRG1R/M6H
X-Gm-Gg: AYBFou3D5pahMi02f10tFMTjKBQQXIreqGmW860X7Gt4Ts5T9TQIIFKM8CCLT1xdtNN
 oE8aXyXN1DzxX3tcjmBxjcbd8/rTFjoVppUfDzLoEwa0z2aQbAJoxncKd3hhwGcN19XZU9kdZ4T
 cInAbggXA6i4Q8rs+w+IE0hEaKGNwYvFkypH5jM9vXcfXDJf43OcuBS6Sn77yXInSLO6kCO8mj+
 mH+brMpJqn40xF5GoY2mxSoQ/xNhqeuaCaIRaIOlUiN4pso+E7ngY0F8g+MZ3ITeZMgS2jaoC1E
 ThbdB4f1PeZB/FND+mkqTXST8hzD6BMaxOnp5TIzRkXdHyrE1WVrIRZAuYAzlUgIqGhiv0Rdz1+
 2nozs5XyIDE4PUqsL0Rl3OzMkv+7crmdkxVIZuyJXaQa4NrKpvrs5fULb/Zx5wqNPw7ETGTD6Ko
 X+Q1jOYntaOo55zJsJ20J0+WeAWp9KWFCQeOyoWCSBDvamdYM7VNQCdB+BAmhHQDj812dmJIjkZ
 DPAv4aGNTm46Q==
X-Received: by 2002:a05:6a21:48a:b0:3d0:c5c0:d9b3 with SMTP id
 adf61e73a8af0-3da39ff0220mr32935854637.18.1788763541389; 
 Sun, 06 Sep 2026 23:45:41 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14332405e92sm17209594c88.8.2026.09.06.23.45.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 23:45:41 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH 1/2] net: intel: fix typos in comments
Date: Mon,  7 Sep 2026 12:15:27 +0530
Message-ID: <20260907064528.6602-2-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907064528.6602-1-hemanth.selam@gmail.com>
References: <20260907064528.6602-1-hemanth.selam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 08 Sep 2026 15:13:56 +0000
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

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c     | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c    | 2 +-
 drivers/net/ethernet/intel/ice/ice.h              | 2 +-
 drivers/net/ethernet/intel/ice/ice_main.c         | 2 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c        | 2 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 8dadfef2c09f..026b35e5a000 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -676,7 +676,7 @@ int i40e_pf_reset(struct i40e_hw *hw)
 	grst_del = FIELD_GET(I40E_GLGEN_RSTCTL_GRSTDEL_MASK,
 			     rd32(hw, I40E_GLGEN_RSTCTL));
 
-	/* It can take upto 15 secs for GRST steady state.
+	/* It can take up to 15 secs for GRST steady state.
 	 * Bump it to 16 secs max to be safe.
 	 */
 	grst_del = grst_del * 20;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 3da9ec49cc74..ef9d1e78c16a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2614,7 +2614,7 @@ static u64 i40e_eeprom_test(struct net_device *netdev, u64 *data)
 	netif_info(pf, hw, netdev, "eeprom test\n");
 	*data = i40e_diag_eeprom_test(&pf->hw);
 
-	/* forcebly clear the NVM Update state machine */
+	/* forcibly clear the NVM Update state machine */
 	pf->hw.nvmupd_state = I40E_NVMUPD_STATE_INIT;
 
 	return *data;
diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index db3c7015c56c..e5f940d324dc 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -1105,7 +1105,7 @@ extern const struct xdp_metadata_ops ice_xdp_md_ops;
  * ice_is_dual - Check if given config is multi-NAC
  * @hw: pointer to HW structure
  *
- * Return: true if the device is running in mutli-NAC (Network
+ * Return: true if the device is running in multi-NAC (Network
  * Acceleration Complex) configuration variant, false otherwise
  * (always false for non-E825 devices).
  */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d88835482d3a..fe47ec0ba809 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6202,7 +6202,7 @@ ice_fdb_del(struct ndmsg *ndm, __always_unused struct nlattr *tb[],
  *
  * Features that need fixing:
  *	Cannot simultaneously enable CTAG and STAG stripping and/or insertion.
- *	These are mutually exlusive as the VSI context cannot support multiple
+ *	These are mutually exclusive as the VSI context cannot support multiple
  *	VLAN ethertypes simultaneously for stripping and/or insertion. If this
  *	is not done, then default to clearing the requested STAG offload
  *	settings.
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index e04de0215596..9ef1aa66fa2b 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -924,7 +924,7 @@ static void ice_sriov_remap_vectors(struct ice_pf *pf, u16 restricted_id)
  * is correct etc. Then disable old mapping (MSI-X and queues registers), change
  * MSI-X and queues, rebuild VSI and enable new mapping.
  *
- * If it is possible (driver not binded to VF) try to remap also other VFs to
+ * If it is possible (driver not bound to VF) try to remap also other VFs to
  * linearize irqs register usage.
  */
 int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count)
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 7ce46b4b4821..7eb4acf59dab 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -3995,7 +3995,7 @@ static void ixgbevf_tx_olinfo_status(union ixgbe_adv_tx_desc *tx_desc,
 	if (tx_flags & IXGBE_TX_FLAGS_CSUM)
 		olinfo_status |= cpu_to_le32(IXGBE_ADVTXD_POPTS_TXSM);
 
-	/* enble IPv4 checksum for TSO */
+	/* enable IPv4 checksum for TSO */
 	if (tx_flags & IXGBE_TX_FLAGS_IPV4)
 		olinfo_status |= cpu_to_le32(IXGBE_ADVTXD_POPTS_IXSM);
 
-- 
2.48.1

