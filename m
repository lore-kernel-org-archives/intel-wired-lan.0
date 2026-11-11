Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633DD606A339
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Nov 2026 09:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=hYWdYo2B;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pf10BkHC
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B2E581186;
	Wed, 11 Nov 2026 09:30:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vn40zikQcrfs; Wed, 11 Nov 2026 09:30:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8C8CC81135
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794389455;
	b=FhqhQfC9q2YT9MIcXC2d17T/FXYME06P2Ll4+Rll7TrNh4zY0cGQnOs0q6MfghXKRETU
	 T1m8MLtIvS5SdjDjvFyNPN0lRvvGoEPxzNiDfgmzss6qCDQsFU3rdVGqE6yt3LgWmqzVx
	 ivtwyM8eqEkb9mJ6rIRYcF+48WW2fIFXA8tUVi2FtMOAGFGz1m1MJR+EqvR6qNpqAfO81
	 mejF84J4pAqrbzbBLZQ/wrcvfTohBUZp4RiC6H5Bv4kpwDdTPZlF8wwE9AJ+aQkxcI9AN
	 H1196Tug1OJ1+P+Kr//g2dlJM2xjtCsufN8kseUrS9hSpvdCfagT5/2K1ZolXpN86Gg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794389455;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=um2R5SpVc8daNcOs4qf45cuP9GuM58HqVfWdcuuni5U=;
	b=ezZ4rkAph2EDAmmqqGYgBgMKj0xOsiCzZaL48Dupdq5ewn8eFFvG82UgDU9i6UmrGlRZ
	 8piMlRDceQ58sm9oyp99oS0FhSvhgh8MlJGoK0F+cFWCXcoTiH7jaZkXeZob6wy/dEehz
	 RBxJWd4jHNJH4QIen/WvdVoRV8zRBn9KXfWNGRHfbYno2dXJoSQQuhhU6R5X19dwPvYos
	 et4OKQ4TqnAoBs2/MeApfvK8VlBJoYQc1MzCL3hbbWzqr7dVO019zU032kiDouVmXHjO+
	 rG73tC9Mjr6usAyMgRory0edmSX75rdc7Gaa5PsvSa7wQr72Wqnsp36IE4GT7ZdwFvw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794389455;
	bh=um2R5SpVc8daNcOs4qf45cuP9GuM58HqVfWdcuuni5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hYWdYo2B2lqGjjHDWpsUMOO2VrowBvNmnQeAI1dep7/rmCKRWK0YuPV53OFhgnSjI
	 cIPAW8ogps8Yju5aZBPxizMYcG+R1bt3f9XXz/86TXs4QsgbN2rxT1yxdowfLQOHn5
	 EAhvo7QETI0T2WRftwzRr9DU6oMP8U8xQiWB+iK3ts7Ok98/D1v7UQNVZSoFvdNsiV
	 1S/xlRlAUtakk+qVRH9IVc9ihDQnf1JdNk7Cd+RxgFshkAhGaQRaWsBQ/vcSH/v7UI
	 7vmDqUvvcu+5d3WSimoBP/laJIoNidtqNVAdEauJlDiHMB6ye/2vSfE8CKsixEqqYw
	 mxGnEb9Bkdung==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C8CC81135;
	Wed, 11 Nov 2026 09:30:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B3BA17CB
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 09:30:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1D091408B5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 09:30:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hDsCqF-jf-Dr for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Nov 2026 09:30:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2505240892
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com;
 envelope-from=danividanivi@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=pf10BkHC
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2505240892
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 09:30:52 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso2602599f8f.2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 01:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794389451; x=1794994251; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=um2R5SpVc8daNcOs4qf45cuP9GuM58HqVfWdcuuni5U=;
 b=pf10BkHC6NT3VYpOGOzGqQjYDrfdLpZH2bneAvWo5MLx+OMZMMQ6BYVT813mgNftug
 f6S3w7L6l6RPHyyzCSafiy0FrpBwGFEsvxQkXY/WdDg7L6s3HMo4pmiaPA5o7SR56ich
 T0fNX96J/6F91NWGCHLBTFiQ6SXcNq/1vir9rZj6WZHiBVGDg6Weigd959xGdtYdikJr
 zEu8xr0w43WKbsLGuOPUixOPqitrkdsU0EF4LlEBunmLlRcES1j9KPK/Ymb7eOVvjoo8
 r9mC03P7JDE6hEoKR2hUL7K+hv3fFckBK5w+uTL31773NV0aKAWjLRrWU1/ihqz7D/Et
 61Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794389451; x=1794994251;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=um2R5SpVc8daNcOs4qf45cuP9GuM58HqVfWdcuuni5U=;
 b=iOZ4sGKQWs+RhB665mW8Hjeyi3OW0vwvm9S2WbnD88/zpwqgTXL8pybZJs/v+evvid
 Pqzxs1EdvFCHB/+d8ObpvHa906EPaqupYvOCjZmKigNcm0MmpRruP70wvX3nV8LPZtAw
 TgB1NVakI76+YXNSNywV2jB+0aFe//GWP3cztWVXXfBsNc4Hu7lbJy4LImaNAzLCcfq2
 F1V7zaPxZkj414KrT/wBFq076VtAl178lS4UvUC2Ep7l5/ZZtA94pcuqO4PVQux7LESy
 xSy8YxOfddhWLV4M4g8LFAQlMaoLk3Ca3k0v+kXiAng/y6/BT7ao/g2YVWdPkIAvoiWo
 AMAQ==
X-Gm-Message-State: APuU4Z8weReAYjchD7OlO7FsVzvbN5qZudvVbZTE0C+twQYssXZUZjnI
 6PRAUfDgYyJRW+OnBKPbL1HIm3f7lG4VnLlmxPhIQPsNi0uM9z3gstxNo+cnF2dfQC8=
X-Gm-Gg: AYBFou3vha0g+R85tRUyk/HNaUWGvF380877qITJPrFytPPx9frbxXek6r4IDYVy1Fo
 GuehDMmUgYa1nl4TLa0MRCIUvB4y45oiQylSTAHbUg6cp/y/DQxK71k7cGxLRY07bpU0DLDWxe+
 nzst0h+s8vIAkx4RkWB9FUYtvLXeUX72LifwIvvnsa/TyCcYp2G5L9thU8uX4gi9I1TTOo+WaYK
 NfCRzJcX4Y4lRYpukhEZb20Y+uMt694kCoJUyvLawEPCdkVRXuHMyAK6snCuq4nNlYfb0MgkFKi
 mCBu07asKeYjRzdO788K7fbrsYnRH/gpsXvdLowXyRSDnh6PBBZ9T7hyHUyOB45cz+bnDzzNOI5
 C8o44TZEqHP3cyf47T+pDVPGTVka6p7DuKzJEM/QFupWPeU9MF2edfZlOZAJEXSdXnlinv1SlL+
 TPyEYJx0S1BmAaUHolOxwsLJAdrLT4Y46l58vR1p5uNBqN6KulGjqmJLqimgbm8dXCFhpA+GK51
 5HOZseIpEnt0JigqpDmoCoV9pKqIS6oDQhC2ou+ir+WU7tI6UZd6xOYPlNJsnnOXksu4pvhhC+S
 GmC7pZmnxPJM/9I1heAgOFuaPK4b4IVRqji3trcBHxEvmg8u7lqAnSGW/teQo3vZJT8ZPmO1EMI
 V7+afbo8X20jvjwkzNcOfA4bXvDBlKLfin1HJWfJX+pwhIKb0+sTkylTZdazkuF5msdKRnmzMKt
 6PukPNTH+//NI=
X-Received: by 2002:a05:6000:4917:b0:490:6e0f:a024 with SMTP id
 ffacd0b85a97d-499c69ca529mr2701747f8f.13.1794389450677; 
 Wed, 11 Nov 2026 01:30:50 -0800 (PST)
Received: from AHERLNXVDANI01.lgs-net.com ([193.8.40.126])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498362eb14asm9175839f8f.34.2026.11.11.01.30.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 01:30:50 -0800 (PST)
From: =?UTF-8?q?Daniel=20Via=C3=B1o?= <danividanivi@gmail.com>
To: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 dima.ruinskiy@intel.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Daniel=20Via=C3=B1o?= <danividanivi@gmail.com>
Subject: [PATCH iwl-net v2 1/2] igc: don't disable ASPM L1.2 from
 __igc_resume()
Date: Wed, 11 Nov 2026 10:30:34 +0100
Message-ID: <20261111093035.513635-2-danividanivi@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111093035.513635-1-danividanivi@gmail.com>
References: <20261111093035.513635-1-danividanivi@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit 0325143b59c6 ("igc: disable L1.2 PCI-E link substate to avoid
performance issue") disables L1.2 on I226 in probe, in __igc_resume()
and in igc_io_slot_reset(). The resume path uses
pci_disable_link_state(), which takes pci_bus_sem for read.

__igc_resume() is also the runtime resume callback, and it can be
called with pci_bus_sem already held: pcie_do_recovery() runtime-
resumes all affected devices through

  pci_walk_bridge(bridge, pci_pm_runtime_get_sync, NULL)

i.e. from within pci_walk_bus(), which holds pci_bus_sem for read. If
the igc device is runtime-suspended at that point, the call chain is

  pci_walk_bus()                      down_read(&pci_bus_sem)
    pci_pm_runtime_get_sync()
      igc_runtime_resume()
        __igc_resume()
          pci_disable_link_state()    down_read(&pci_bus_sem)

A recursive down_read() deadlocks if a writer (e.g. a hot-plug event
adding or removing a device) queues on pci_bus_sem between the two
acquisitions. pci_disable_link_state_locked() cannot be used instead,
because on the system suspend/resume and ordinary runtime resume paths
the lock is not held.

The call is not needed on resume in the first place. The disable done
in igc_probe() is recorded in the link's aspm_disable mask, which is
only cleared through the ASPM sysfs interface. The PCI core honours
that mask whenever it reconfigures the link, including when the device
returns to D0 (pcie_aspm_pm_state_change()), and pci_restore_state()
restores the L1 PM Substates control registers saved with L1.2
already disabled. Drop the call from __igc_resume().

The issue was found by the Sashiko AI review of an earlier version of
this series.

Fixes: 0325143b59c6 ("igc: disable L1.2 PCI-E link substate to avoid performance issue")
Signed-off-by: Daniel Viaño <danividanivi@gmail.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 62a7c5178..1b5dcc166 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7585,9 +7585,6 @@ static int __igc_resume(struct device *dev, bool rpm)
 	pci_enable_wake(pdev, PCI_D3hot, 0);
 	pci_enable_wake(pdev, PCI_D3cold, 0);
 
-	if (igc_is_device_id_i226(hw))
-		pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);
-
 	if (igc_init_interrupt_scheme(adapter, true)) {
 		netdev_err(netdev, "Unable to allocate memory for queues\n");
 		return -ENOMEM;
-- 
2.53.0

