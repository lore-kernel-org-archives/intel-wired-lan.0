Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C50CA5FED
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 10:26:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 932488096E;
	Tue,  6 Oct 2026 10:26:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EsjCgXhSAV00; Tue,  6 Oct 2026 10:26:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B42E380BBD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791282409;
	b=MM7Cp41uBjtiw6767HGjL6Qebrzsn20EJ6R1WwcBONYHM9xYzECQkWvftGuAmbDT6jpu
	 aSEGfwz/KRpVt1IK9g4CgjXsD76GmEna6phTjPBiINLVXr3qSLoawMWUBAatQA2E15v23
	 iOB8K6zuPSnvkXXQxNQvVyaJN58ruZ5FCI1M2RB3kSfyRMAeImlEMBB/n9+CgkGwo2jaQ
	 nwY6iZLHUITSYPcIdyIq1rTIs2MJp6mKnygxfODcjqRXl89LcRSGarL8CWpq2EBQngEZ3
	 7AGvIA4ixo9v3b+WR7AeOuTRhhIw/GXF0QlnaJZi1jPVt81qFoQdZcxPqO+P3Ra/fsQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791282409;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=4RFivH4B8abVqhmom6ABKgjx6EKwXx1ZnhzGqdiDZPg=;
	b=HvlTPCT8asvreZypikJcmI0ajte7ym4YvhQhMPQEtTvTe/ucxb5NDawDDHpjzkdzWVFb
	 e4NSgg6nuKGekFFGwJdN8FDV58cIlgtSYrXO2Bxsf+mrIytRAdkzwk/SUq7Itcp80c+sM
	 E83P0Tq3C+IDuSXhEQ42XYlg88YyLAguhOQm7Bw800i9TlgSUMcqjTsyuhO2vyfcIyREf
	 e3vRmz7TzPVmiy1CqFZC72c589BtXueGVg7Ugz1FuOMsAzgLFSqBxbc6UeZH58Y2V7TF/
	 0Y4yPYAlu3Pw+uAFOxaOav4EXgSpyCj0O3eZzssZ2TeMv9cxr+mSgDBQKiEwap9JTUw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791282409;
	bh=4RFivH4B8abVqhmom6ABKgjx6EKwXx1ZnhzGqdiDZPg=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=O0h80SR8NRnONgbqJCJjgzmpNk4NOWq7H2Q7VLRCsOGeUd3kpOfWDQR8dx65hjPfA
	 FzD/ZgHjPyvD78kMHwQ8R8slnivqVlP4EGsXwyK6jmfLNB3MEFF4yIQzErvlXMYCOj
	 +mbveteBvl47k2wM1Drp3r17prRfrqbPXWEALjg8xx8g3SglJHF/GfndnKCVTrq1+s
	 CgREJ6d6sQpvR0Rku+evzw02d4zqhbscdq53ZtOtaFi32UT9dZrtQ2hcgfSYL0Oo4V
	 6Uf6hNUtrJxziTjJmoHwrKnbRZUBtfNt0OKj15cBBqVoYPkOaAL3A3AAKSaii0Mq+8
	 eHE2TjAMdPI2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B42E380BBD;
	Tue,  6 Oct 2026 10:26:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E8AD4341
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 09:54:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CE6054021E
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 09:54:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zdBC0Wu5sISf for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 09:54:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 9337E400B5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791280477;
 b=d5Pri03YaGHPT0M32ttwOh0EvluQWc04zICCBY7qmjdby4wSVru8393GD4akDVi9T0GF
 QBBdRS+xNGLcB/QP4rD1H/VKKB/aIn1E6fvpCnckCIptf7pMlwAitwrgFrEk604WrjPvx
 tj+W2r5iQ+mNXMZXVlGZzBgohRurj/3CVUJTN5Tp7mAU7jkRtYYLJe/f83DdXnpNPGcZm
 oqJFi0vksGHLomdyLpiwGGkFE8LDXcQb8EjmtTO5wyZ10deAJiIJZh3kveC2OCoAUZjjM
 glBSMuXDmPaBp1KXvZb7CA5IJ8Axvp/SGF5+TfyhGnA7sMIp7p6PWhhJ8hI/IOWnFdg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791280477;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=4RFivH4B8abVqhmom6ABKgjx6EKwXx1ZnhzGqdiDZPg=;
 b=LYTCESspuw+hd6hUMnI3jYLdSQGy0k8nQiMg/32w6d+vuh1uOvGXpJDvs0nbdBvIdP/C
 j+lE2GKSD+oBWSMZYVbGFf6oYXd6Up3IGKENHHc5s0cJZOqPLTE+j4FUvR7q9oQhENtch
 BMsmvUOQo1q4/01vglnn1G4cO5rXd0rmx+VEof1Fzs8V+6Tu0l32tSK05zwED6eOpz1Ll
 1EQRgLn7vO6nFmAaP5NnLNHHgK5M8DxOdHCBBW2xMXLOWW+2UbkAhsZN2tLMirxg0+OWI
 druQ/bYAXJ99o20+kIXoKZVA8TVYcxiv/7CLTkSna6uU9dIgFt4w5P6xgzrWxYQ2nAw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ZyXTPWyH; 
 arc=none smtp.remote-ip=192.198.163.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ZyXTPWyH
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9337E400B5
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 09:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791280478; x=1822816478;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=DZ/roM5lghoM64QlmR1qcaajAf9MEMIiUkauoGV8M7E=;
 b=ZyXTPWyHvrw4WQ6EnNAmmfQwyM8NZ0UhX79xQCr65o1O6jgJXIoIK0+t
 JToAMb9A9bHzrJXm05vdzW/BxpilHAIIN2GwOruQZsh4IMz7gXnewmRpQ
 bqfD/sQI4EmPXyY1hX0ifeGXmdlAQazx8bYuKe8SM1UtIYeYl6Dyh518b
 jh4pGRN1/byZTJkYANMjU9JyilnQCe/N65FQuEoZcUzWi67PunDs1hNl5
 moCKNCMTKPSzRwT3HRocYbglij86ouds8hb06bLHgY+MqpNs1itM6ttTb
 hnlEu9AOgPprySS2ocnD2wGfEJQqz7o0oCl6hhfGG90R96WYg81A9z9HX g==;
X-CSE-ConnectionGUID: pKwB3Mg3SGKGUGVuuQwZAw==
X-CSE-MsgGUID: NXmfbMHwSkeCeOXU+F4xYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="102542575"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="102542575"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 02:54:37 -0700
X-CSE-ConnectionGUID: 2RD4uG+oQIe735BHNwu8hQ==
X-CSE-MsgGUID: hQ807Zs/SyCXOy0bAzVFcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="277217485"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa009.jf.intel.com with ESMTP; 06 Oct 2026 02:54:36 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Subject: [PATCH iwl-net v2] ice: Skip PTP timestamp processing during release
Date: Tue,  6 Oct 2026 09:54:35 +0000
Message-ID: <20261006095435.419128-1-sergey.temerkhanov@intel.com>
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

Do not run a timestamp processing callback on unready hardware
thus avoiding hitting uninitialized structures etc.

Fixes: 88b68f35eb43 ("ice: PTP: fix missing timestamps on E825 hardware")
Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---

Previous version: https://lore.kernel.org/intel-wired-lan/20261001115232.13681-1-sergey.temerkhanov@intel.com/
v1->v2: Skip possible extra work on E830

 drivers/net/ethernet/intel/ice/ice_ptp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 06842c06c689..2da510850a2b 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2820,6 +2820,9 @@ s8 ice_ptp_request_ts(struct ice_ptp_tx *tx, struct sk_buff *skb)
 
 void ice_ptp_process_ts(struct ice_pf *pf)
 {
+	if (pf->ptp.state != ICE_PTP_READY)
+		return;
+
 	switch (pf->ptp.tx_interrupt_mode) {
 	case ICE_PTP_TX_INTERRUPT_NONE:
 		/* This device has the clock owner handle timestamps for it */
@@ -2949,6 +2952,9 @@ irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf)
 		return IRQ_WAKE_THREAD;
 	case ICE_MAC_E830:
 		/* E830 can read timestamps in the top half using rd32() */
+		if (pf->ptp.state != ICE_PTP_READY)
+			return IRQ_HANDLED;
+
 		ice_ptp_process_ts(pf);
 
 		if (ice_ptp_tx_tstamps_pending(pf, true)) {
-- 
2.53.0

