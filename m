Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D76B7CCF2D5
	for <intel-wired-lan@archiver.kernel.org>; Mon, 19 Oct 2026 10:52:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9BF1A80F82;
	Mon, 19 Oct 2026 10:52:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nkuXwICzwOZu; Mon, 19 Oct 2026 10:52:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EE7E980D9F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792407177;
	b=C+optoFFhALI0b5XYwVJbhrIaHdAcWPUQDlccF1cKvwqTPYtEqUkgEWd3rlmcxwvnfD7
	 JeXk1WDzOASS99RR3Gozx7517MSwOjCHtmlN5bjjULbW95UlC1FoQCTUUniZrEVab3kWZ
	 KjnFBHk59+4q0RPQAgRehGe/CLq3Ryl7LvpXgTBx86exwMdNfQ/c6/7YyNpZ7tfXMoID4
	 PKldZhY74zTafODhmRITK3Uw6AayPgDT4ufCVYd+fQ1ipWKluKjq2e8pMJZsU7TuxLrcA
	 cVmOddynXnx7DGuPMc1Gh0HmSh2uTJZArKKpVXl1kL/vLJsdAlV55MSg33ZfkDIuYNg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792407177;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dmQ8DG056mR1G4V+Df41oNaFy9WQpehuB2fwvz+jBwo=;
	b=q8LGH5e/RIvFzLQRZ1WMCNA79A7vkjM5Twmll0Df8uTJ2JiDCT0wSU9p4G7QrezLLj72
	 GR1d6HyY0IuhJSuqlgiJrgaQPaTfAfAWowFi9LB3Y6Tm1F7s8mksRiqGL6wgnSVGJa+1e
	 jhjw8M/9NbKbu4UJjDoqRIWAeVcOCZi0vsS/pPGhKwXjmM3RBEAL5d1hJMA98ta20vIVV
	 5FApBrXuZnKxpRklRlc6gmgahIqD9bgUKa3/kyTLJAG06i+u+nAlNVPBzaaUegEhSYXKV
	 +r8y96H1S3mxtdOL/Lb18UyEDcHhjrxp9PuHzXX2hvCZTdwly2F/pn2KZ+2H1elBhrA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=fZ8m06GV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792407177;
	bh=dmQ8DG056mR1G4V+Df41oNaFy9WQpehuB2fwvz+jBwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Kf0VywahLJMPwPj2qnMpCwxTQYMhpte6GX6Q4qG1EVDwzwCWFJlrJvPOgu4fq41Hj
	 xqjtm+GtFQX3wVzytO/0EVyP8+fGMdWp5+0gM6f3S5vcOB7VoE3OVxytCCKhBpZF48
	 w1Te+p2ILSHsJkC2j6+rS9rYjP9cMw3chHHMAAwPle3M8tsZsHEQbQrGT3FO3c2DS9
	 ztBlccYzKhJ4NmchPgx/HPr65A3BPWt4BDe161rtCeIZR4rGyQUXyqGctIqPh0l+WK
	 lHhtu1iWRB7HihBd+f06nBtvpEzJzMSkmKgRtA3POV9MbvORLSkCxZ4+gG1gOfNtNN
	 7lNZBS/NHe31Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE7E980D9F;
	Mon, 19 Oct 2026 10:52:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C07521DE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 10:52:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A69A380D9F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 10:52:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hjq6xL4khQp1 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 19 Oct 2026 10:52:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A034A80D1B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792407175;
 b=b7qiL4NkV7AYNFCeabdzenE6kykiMqOM91qzPvAU7DmkB0nQDRIhU0AVpoBSvlYgbKx6
 /aCUp9CVq/IbeNNXuMWR0ZYU2Tcny6y+Z4wn/F6IpBUGlLBTi+pWpps7TFRBzOIGLDFL1
 T1t8AToyAbyj8m52IqCxL079FbD8eZelsEQqaPP/tYfNFqDDiujL3C8xPbMvE0CSWIZbc
 2G+X38STHuo78dBm5lnXeW9IluilxWlMkp7IHPm75KXZa9EgrChss17j3XZKdyPs5BeX4
 SygCO6jzWmaICRHONynKeZrOgXgmY89D9CAzdTGGJZi5I6xFG53DVYTD+gca+y+dhcw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792407175;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=dmQ8DG056mR1G4V+Df41oNaFy9WQpehuB2fwvz+jBwo=;
 b=Kmspwj8wHG3Q8qLrujiCi1eDA2MiI+/pdc48xCYwrXX07G5pPN919wbIw1KX1HabMpfs
 y0liJMz4wrGojfSsopRSuNY+FKbrtfaLned5KWD8TNSk5QNgKAnrGhv/2WWauw6ju4inQ
 MMp7fu0kk0Mas/1Gt52OdhQGoJYH4IamIy5dw1G3tSWddRBrslx+4f1B7cQSKu96EgExc
 MEm0T1EIgYSh5aBqJ9qc4/7AWEW9ZBOMHLUbT/DnilsK28gNhIOO/7PHmYTUCyqThOYhR
 NEQeFFprCFaBY4u6drznC9idYZdrwLkR7bllqnjzHMZqZT2Tq/Ss1CqPda3GMRG8juw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=fZ8m06GV; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com; envelope-from=aaron.ma@canonical.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=fZ8m06GV
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A034A80D1B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 10:52:52 +0000 (UTC)
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7693E3F442
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 10:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1792407170;
 bh=dmQ8DG056mR1G4V+Df41oNaFy9WQpehuB2fwvz+jBwo=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=fZ8m06GV1ZuiW7JMEa3DweI+p1KXneKFN6IQfbtmuMn+RbA5evOd7jxR9SMnPO9mG
 3sqRWn6tUFwIpmH3eqcZXU1G1Fp/t3xCwefvGoTv+u8Bm5oPrykSgX6Zi7hZ5hg1uS
 Tp2UnQPTcp61/RZymmrpQTtbw59zfbb/rxGN4j+bhMl6vK3D5xgGKyf6EBB3rJE5cu
 GjdyoR4sdM6Y1fEpw0Zx55q0uh1E1LT28KM0mNMBV7x2Ksi7FCh7XzfmdiTuWlCAej
 abgCHMQ4PzvWFDUdP3Agwt68SeCPOHGuBgGQcrT3qkFNRdeMoPQi1Ml8QJbexIjtxw
 4WCz47U3++WgtX6FEO2xnCxWvl29AfdQCbivpJC28D17JfcvoQvqwS1PchpshJWcJ2
 8Lxtad8aySkna9OrLpfIbvWWc2rGH2KwFQJTY24sgjUs8XWzdkyHHuu/jt+VWlE0qy
 w3bSFdn4BbtleNOkNnrGvBIAslLF/pC4J0maDO+FOKEAQq8njMTk+bs2w3c+o2qMeh
 6pZF5EX3Qmq52EqZ/x6GTbFlSr32z+6eyuEexB1qLICbmtdiOHWMYrbZi/MLbfpQN1
 59R2OWwNUOtzX3fbn+3MxGrHe+BMwoZZ1JtBtSjG5ALBzsPcE34FKAo+RSCuhPXfax
 mExhmxu7zXsO045AvhbZdb0U=
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48b027578a4so1805862f8f.3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 03:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792407170; x=1793011970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dmQ8DG056mR1G4V+Df41oNaFy9WQpehuB2fwvz+jBwo=;
 b=J4ImlDt5/eGPkrGGMzK/U2v5LlTjU6W+mGz/IU0SJLaxzMbZXM7OugPb5tRNEynKFv
 tXv1DAOzXmT23Cqiue2h5+OsluYRv3ZfgACkKtjgWw+yOL+GaVeFmkgZiXsH+Y/niuqY
 Hhq5aQVJY8awUkBpOBiugbRgjRVUW3ksm4SlOJVu5ReRVg0qsUYmVlS1Pvco5oIcCdtZ
 y0/ZtZg9Nt/nSOw2BSzkrUEV1j8Z7tvl5LV8uqTUk66suQHQwH/7epqLPr+6jS3QKgeB
 LrzAIwxYYfCfimxTtPm9SqK6DJvbgIQHDACFriWKwxTK+j7ow4xEXcgV1WrT3uMV4Rc5
 96Rg==
X-Forwarded-Encrypted: i=1;
 AKwUvByePiIVQRWcOs0hHrg51mYw5WhJhaJTbMtbckuj6zeQPb8NnkXZ2dsRAgMNVMptSCQuJwQpxFeq6ZKoSASFWiY=@lists.osuosl.org
X-Gm-Message-State: AFq9FYKNz25urNp7dcZdgipFGNnr/uq1AAGYVq1xu5Bd5LCXNUj7lbrR
 2/CzdPprj0jradaLW+gzcFPfo6USdJ3ZEtm1bF1t8+H8cM552cZ4xojM5+nEBkRjvRO1wajQusN
 A4upvDeY2t8uVQb6mCy3YbMrOinKCIJpZ5cAALSM7EZReufiE9mP12SU1Y7OF37BIFyjn/hyZg0
 yycf1PyYwfRno9wQWBLe90JA==
X-Gm-Gg: AYBFou0f688/LMa0c6MTf5XpTqj08Gf/PrDCihWKrF7RQRew7ja9cX/PXEWnahlQFMX
 GsD79Ca33TcLda7EkOWByxH7GHRJOuFU+u9fPHb3e4+6rTckH46mqnjNVtzc1VVEXSWPyh2+Nft
 nkD1s4tf/MPHQIL3QHslU/tZs+RDD9BtMMac1NZrlqj+02uxH/Onir92lHkpqB1tNgKoTd0yrk8
 dn+OZrUFcltWjPQnJlrUlEAA7r2DT8h6U26WK5XhCrFPdxCQUztBCmM651nyhppyNGa+HtiN4P3
 kLc5/pwGUjYNnWJA6bdUJFli96QhUN/7Aof97r2zvwQLALa/D5dSwj6yEFkIMaV+oub1vIt+RZC
 KUxQo30HKS7jBH27oRF8RHDM7hX1XrQUSRIjiQeR6j4Y+hKoOpawC4zHlWYJMY8+8iW7szgEMT3
 BE8FrdfJ+YhPgSnk2etFRQ3sMfTTe9sDM+27l8IGd1ZEKtcvnMuqq+7kG42x9/LgpLqSV1skJVY
 +yobSHK/IeYaZYSpPw5fqJfxWZLIOKTypCNzeUC
X-Received: by 2002:a05:6000:20c3:b0:48a:eeb7:5e5c with SMTP id
 ffacd0b85a97d-48e07f99f3fmr9466561f8f.32.1792407170043; 
 Mon, 19 Oct 2026 03:52:50 -0700 (PDT)
X-Received: by 2002:a05:6000:20c3:b0:48a:eeb7:5e5c with SMTP id
 ffacd0b85a97d-48e07f99f3fmr9466543f8f.32.1792407169681; 
 Mon, 19 Oct 2026 03:52:49 -0700 (PDT)
Received: from u-ThinkPad-X1-Extreme-Gen-4i ([103.155.100.4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd510201sm23238930f8f.55.2026.10.19.03.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 03:52:48 -0700 (PDT)
From: Aaron Ma <aaron.ma@canonical.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Dan Nowlin <dan.nowlin@intel.com>, Brett Creeley <brett.creeley@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS)
Subject: [PATCH 2/5] ice: retain the adapter throughout hardware
 initialization and teardown
Date: Mon, 19 Oct 2026 18:51:52 +0800
Message-ID: <20261019105155.3793063-3-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019105155.3793063-1-aaron.ma@canonical.com>
References: <20261019105155.3793063-1-aaron.ma@canonical.com>
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

Adapter-scoped synchronization must be available to Admin Queue users
from initial queue creation through the last teardown command. Probe
currently obtains its adapter reference only after hardware and package
initialization, and error cleanup and removal drop it before hardware
teardown.

Acquire the reference before either normal hardware initialization or
firmware recovery-mode initialization. Release it after hardware and
device cleanup, balancing recovery-mode probe failures and removal too.

This establishes the lifetime prerequisite for moving package ownership
exclusion from a module-global mutex to the shared adapter.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 31 +++++++++++++----------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 164428ba116a0..ddebb28b2454f 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5242,27 +5242,29 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 		hw->debug_mask = debug;
 #endif
 
-	if (ice_is_recovery_mode(hw))
-		return ice_probe_recovery_mode(pf);
+	adapter = ice_adapter_get(pdev);
+	if (IS_ERR(adapter))
+		return PTR_ERR(adapter);
+	pf->adapter = adapter;
+
+	if (ice_is_recovery_mode(hw)) {
+		err = ice_probe_recovery_mode(pf);
+		if (err)
+			ice_adapter_put(pdev);
+		return err;
+	}
 
 	err = ice_init_hw(hw);
 	if (err) {
 		dev_err(dev, "ice_init_hw failed: %d\n", err);
-		return err;
+		goto unroll_adapter;
 	}
 
 	ice_init_dev_hw(pf);
 
-	adapter = ice_adapter_get(pdev);
-	if (IS_ERR(adapter)) {
-		err = PTR_ERR(adapter);
-		goto unroll_hw_init;
-	}
-	pf->adapter = adapter;
-
 	err = ice_init_dev(pf);
 	if (err)
-		goto unroll_adapter;
+		goto unroll_hw_init;
 
 	err = ice_init(pf);
 	if (err)
@@ -5287,12 +5289,12 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 	ice_deinit(pf);
 unroll_dev_init:
 	need_dev_deinit = true;
-unroll_adapter:
-	ice_adapter_put(pdev);
 unroll_hw_init:
 	ice_deinit_hw(hw);
 	if (need_dev_deinit)
 		ice_deinit_dev(pf);
+unroll_adapter:
+	ice_adapter_put(pdev);
 	return err;
 }
 
@@ -5377,6 +5379,7 @@ static void ice_remove(struct pci_dev *pdev)
 		scoped_guard(devl, priv_to_devlink(pf)) {
 			ice_deinit_devlink(pf);
 		}
+		ice_adapter_put(pdev);
 		return;
 	}
 
@@ -5403,11 +5406,11 @@ static void ice_remove(struct pci_dev *pdev)
 	ice_setup_mc_magic_wake(pf);
 	ice_set_wake(pf);
 
-	ice_adapter_put(pdev);
 	ice_deinit_hw(&pf->hw);
 
 	ice_deinit_dev(pf);
 	ice_aq_cancel_waiting_tasks(pf);
+	ice_adapter_put(pdev);
 	set_bit(ICE_DOWN, pf->state);
 }
 
-- 
2.53.0

