Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B217C9830E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 15:32:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D0F98103B;
	Fri, 25 Sep 2026 15:32:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eQVE_oNUOFLi; Fri, 25 Sep 2026 15:32:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C9E7181076
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790350340;
	b=ARaC0KWh335I9J5SzOaxFn63A3K603f0woN5h4oFDi89PaT6jSyR8/x4/Ob4DWz2Snif
	 byK5VxAx8bSsbxWyjSh0x7v75b3mMe31g/ObZOFPZn2k9/CJ6qVNz/hoop/Wus2e9jdad
	 cp/LhKSC27/JqBZajZp6jC7rKL3b9e25eHp1q0gVWQspG4BXl2deGS6ui7gF4Z8J8gxGj
	 3PYzN5gkdlD88rznAE5dz6Ky80j+HEbJGv0hZjBbibsWuYKm9s5z5j0FpVnnX6cWIWW1l
	 Z4Z1XxscphgH+7RnX5JLmS46Mm4sn3mT8bzTiazGnDecmc2LKCPT486WWiUlu8n7WKA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790350340;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+voox/U6tCkxGYTDLWhRDj4A0ThgP+32hpU9k9pFGLo=;
	b=Ha0mUgNblzgdXsKrNINq5So5lUSf4rs+ON+E4zVMlQzxAK8vpENdsAx55nYH+lX4CMio
	 Zthc1iMRvRELSm3uiFmkoMP53f5FjQhJjA73ITDYuC8JuvTI0YOYrcRf7CzXZf5xmKOkZ
	 omLqRws2Tuk0AXbR1yf7mbeyVJGc9ZE2qgIEVUGPHfkO9zh04hJXXY5ROq83uSOWdxmrd
	 OqM4216qXPwvyEQn+2nnE5WNpNwY9lNzEpd0m/8FmxcViLXAbr8evFfhgc19BGsaGeYf3
	 TN2ThZB3QiBHAQbkBtFqgePZGVdTTLIhMHkVerJX0VvhTr5gq7foI6AnmblCwKRlpww==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790350340;
	bh=+voox/U6tCkxGYTDLWhRDj4A0ThgP+32hpU9k9pFGLo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=3gZEckT3PioDMHBT5xQZx4j9mc2sTiHDA86VdRvhgPNR2G5Bq2CcdmNENs6I06Ceb
	 qnA+rHHJp8a4U5TXNNiXQqMf/oguJG/uGkA55GLnaqTE2XPNyH5MMH0h/0QbfpPc2e
	 O1nkprdyTYOxGqzw+7OHkjaYm5IxCcF1xVXXjFYX2dtctNC0qJ+qcZi73KP0y84yFM
	 6KTSUzvK4pkdKb04hhy6eEXHslJsyYDihbwsYomHJEgwiV6kEdAHA5PgesfQ/dFjZ5
	 ZHomnmtjIASlJ/Plk/oS2WAXZe9stCBKB+oHbBoKOrmQyiNWHBcRBEmBkEw2hpBBP9
	 l0RrEYYtCXsrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C9E7181076;
	Fri, 25 Sep 2026 15:32:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DCD0B334
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 11:29:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C247360BA2
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 11:29:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y-Z2HOyBZJWC for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 11:29:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 784D460793
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790335748;
 b=X7fk8U/nZ0ZI6eNLGFnQ/spt3YL4OoI6khPBhx3w9LChWePB2TkVPIxeCxPyZv8s1jri
 LY5xqXkvTzjdk2oampGvuodxva3jN9rpKteRyO95+nmz2D9qSDIl8aclKON0RdMwLDU1g
 hAC1rd0QOif8ecdAMan1e8FrSuDAueOk/RAnNaZiLQ0k24Vg1FgYW0PC2leOJ80OdD2M2
 iN/QxvohEnARLAz3InhGK+h19DqG3DIhQuswFBcdFt7rkE5Oj8201kx9NfKVUxamYCiXe
 U56+ZlLJmqFh8V3F5m3n8LakywPMN0EfxfRn+ZW7un48/lfvFHLkxwLg2MWO0Xxdi0w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790335748;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=+voox/U6tCkxGYTDLWhRDj4A0ThgP+32hpU9k9pFGLo=;
 b=mhZxLMOqwa7xCuT3yXqYJVnsesUmIOtXa5rp+zqPyNQpLDJG8UwT7eyx9QZHKmkLGjRB
 0s9fIN7pslYfbdVy7HVRoEkGAr+8zG1bzcDguC0mmzxKFkmrbAMIE8Ltm25gqXXnOQ+do
 imk6jYEwLb+shFowGkFnm2ZpeXmP2qCk+Tvlz+gxUyrUHbjkElB3q+qNsx+bIfwcHcokG
 vG3oVuDRRrccB9P2qo6ujrR462ezMI+OQuruRc6jxffbnavG0fhDIPqRKVwgmviyd1Cez
 CM8NN4iykfOr3uKtnC4wO1rkcMjjM0CAyNWETVrYiGTCGpy1oqghkMbZVhcAH1Qs3kQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=DQ9gMhGg; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=danividanivi@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=DQ9gMhGg
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 784D460793
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 11:29:06 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912e2406so3994135e9.1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 04:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790335745; x=1790940545; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+voox/U6tCkxGYTDLWhRDj4A0ThgP+32hpU9k9pFGLo=;
 b=DQ9gMhGgY2EsUlcKo2Ts0Z729XGf2HzA840EuEPTQGcl3QLaUKrJqXZA062j4mbAg4
 xMxQfVTUvo89ERhrkEotn/jNQZk18ZxRXkfsn+aiV58kURyHGrQH/3Y+ancC20rUJW44
 DM0G8wnieRGtDdHLX9pI0lpxOQLq18vJgTSBt+5ySrhZM/VxQRZPJY3aTM+r+PNPhovX
 VQiwSuWcN7kvr/+m6OyQYXbpoOK/EWxXMv/1ABbskeRUAUW1Zff4oBJKIrMDRBVkkJxj
 8LI2LRqojc4RX0STWikIIma3fabzZsUbLTtY5JL7fpXrObb4BM3m3YmDG39Ww8FULcLe
 G1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790335745; x=1790940545;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+voox/U6tCkxGYTDLWhRDj4A0ThgP+32hpU9k9pFGLo=;
 b=EART93xaY4NPUbfpBTyrJygvz4pszUsTR5VlI82x0FbUymdHTaL6F/m02tE/h/oC32
 VlmMYJJ0kKLrsHflolqNOjHR9f+mb5JOvCxR4wvtdowf8RvyOJQqvhFJ/iq/ApQE0ms2
 R4VATLrzB8YbLFjy6xpXoEVoHJdmueD6hU9Lh6/DsUwGIuAA/g1xeRmApvL6GJ6m0YKX
 GqcKNiXnWFDn2AnW3sRngsf7cdWjV+41LDAakqOCdMZ2UJAD+4+kxNZvVnAUkuWs/b4p
 0tbKkVfi0azArA5ZEWFWQNVdMOK/DjDHyjRJ12hWx3iVclJFAFev3s4izPZScHSHfkX+
 Cufw==
X-Gm-Message-State: AFuF++mXcpFuJLVg52DOw+FG6emk3Udw6yDqCVAdz96DBAv6J4kPHL6+
 tfdMlN0G97CPfCACg1kqCCJ0FF33A8tp2hYyHJvvma97Hw1GgolJx0Vf
X-Gm-Gg: AYBFou31GF5UNdSJdKKZbItD8rzeoClimAtdC9UOTntFYoJ6p2UaZFjZwm9vBfVpDD/
 sTDaQnaQtD1Wn7sJ/yHfCr7lvgdHIFEFCPThJ9ON9imbGT+isfGNESw5u6TiviUYPucusR0EkHF
 BZf5r0Lq3a0/Z4Po6vttRR6vGfv5WUpA8Zl4FpQQNqeOJa9AP0Cn72mhlc9YzsRZSI4NuVGU3bo
 3znej8dALCxu7xPKSoXo1pyjNgktdxURw0pcu0dCnQJUPhrDKhjuPUMUQAOPiF872pdyAWCn0YZ
 NtOi4Cx23yYT0hDpnEoZBnzLfs/91vr9ijnbuHBB5cKU3fR5nd/IEJ4Wsrm2uMw/ipgeD4wiE+V
 ssYpwB4BL/gn+vVFxkX7GyxKSO+O0zdfHyrbDPjzQE0STkVRVPs6kQxE5rrE9Ua9KC6HGwu1BYn
 7v4kPz2XvKQOAsjVMeEgii7FZmzxpqUWFJg9X+exaDZnmekOiSfuZZDu83q3uawv5aG1oxHQhiW
 J/5bEIPZuUJNmytdJ9v+RvKPQRgK/qb5sbJVM7aIwRDHqEKYmU2nv3uAW0y+sQvyaqxWusjeYPE
 QCJNapQn4peb/4DSSW5rFwd2snQTOOraQogAZSbL17Mev9fcCRERZ+rtix6hm2f6qA==
X-Received: by 2002:a05:600c:3b01:b0:49f:ce79:7a8d with SMTP id
 5b1f17b1804b1-49fe670b3e3mr96282485e9.17.1790335744644; 
 Fri, 25 Sep 2026 04:29:04 -0700 (PDT)
Received: from AHERLNXVDANI01.tail39a996.ts.net ([193.8.40.126])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff044406dsm61608925e9.1.2026.09.25.04.29.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 04:29:04 -0700 (PDT)
From: =?UTF-8?q?Daniel=20Via=C3=B1o?= <danividanivi@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?q?Daniel=20Via=C3=B1o?= <danividanivi@gmail.com>
Subject: [PATCH net] igc: Disable PCIe L1.2 substate on I225-LMvP and
 I226-LMvP devices
Date: Fri, 25 Sep 2026 13:28:50 +0200
Message-ID: <20260925112850.189302-1-danividanivi@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 25 Sep 2026 15:32:19 +0000
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

Commit 0325143b59c6 ("igc: disable L1.2 PCI-E link substate to avoid
performance issue") disabled the L1.2 substate on I226 controllers due
to hardware exit latency limitations. However, IGC_DEV_ID_I226_LMVP
(0x5503) was omitted from igc_is_device_id_i226(), and IGC_DEV_ID_I225_LMVP
(0x5502) exhibits the same L1.2 exit latency constraints.

On systems where I225-LMvP is connected behind Thunderbolt/USB4 bridges
(such as the HP Thunderbolt Dock G4), negotiating L1.2 triggers severe
BadDLLP packet framing errors, link timeouts, and system hangs during
shutdown. An earlier attempt ("igc: Mask replay rollover/timeout errors
in I225_LMVP") proposed masking AER reporting. However, as Bjorn
Helgaas noted in review of that patch, simply masking errors is
undesirable and fixing the root cause is preferable; disabling L1.2
prevents the link from entering the unstable substate entirely.

Include IGC_DEV_ID_I226_LMVP in igc_is_device_id_i226() and disable the
L1.2 substate for I225-LMvP across probe, resume, and error recovery to
ensure link stability without masking AER errors.

Fixes: 0325143b59c6 ("igc: disable L1.2 PCI-E link substate to avoid performance issue")
Link: https://lore.kernel.org/lkml/eb5a9805-3e53-ec22-696e-21c6b8cf0bfc@molgen.mpg.de/T/
Signed-off-by: Daniel Viaño <danividanivi@gmail.com>
---
 drivers/net/ethernet/intel/igc/igc_base.c | 1 +
 drivers/net/ethernet/intel/igc/igc_main.c | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_base.c b/drivers/net/ethernet/intel/igc/igc_base.c
index ab9120a3127f..6865fef4049f 100644
--- a/drivers/net/ethernet/intel/igc/igc_base.c
+++ b/drivers/net/ethernet/intel/igc/igc_base.c
@@ -447,6 +447,7 @@ bool igc_is_device_id_i226(struct igc_hw *hw)
 	case IGC_DEV_ID_I226_V:
 	case IGC_DEV_ID_I226_K:
 	case IGC_DEV_ID_I226_IT:
+	case IGC_DEV_ID_I226_LMVP:
 		return true;
 	default:
 		return false;
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 1fb5f3cbe93c..6c4e04661068 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7172,8 +7172,8 @@ static int igc_probe(struct pci_dev *pdev,
 	hw->subsystem_vendor_id = pdev->subsystem_vendor;
 	hw->subsystem_device_id = pdev->subsystem_device;
 
-	/* Disable ASPM L1.2 on I226 devices to avoid packet loss */
-	if (igc_is_device_id_i226(hw))
+	/* Disable ASPM L1.2 on I226 and I225-LMvP devices to avoid packet loss */
+	if (igc_is_device_id_i226(hw) || hw->device_id == IGC_DEV_ID_I225_LMVP)
 		pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);
 
 	err = pci_save_state(pdev);
@@ -7559,7 +7559,7 @@ static int __igc_resume(struct device *dev, bool rpm)
 	pci_enable_wake(pdev, PCI_D3hot, 0);
 	pci_enable_wake(pdev, PCI_D3cold, 0);
 
-	if (igc_is_device_id_i226(hw))
+	if (igc_is_device_id_i226(hw) || hw->device_id == IGC_DEV_ID_I225_LMVP)
 		pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);
 
 	if (igc_init_interrupt_scheme(adapter, true)) {
@@ -7688,7 +7688,7 @@ static pci_ers_result_t igc_io_slot_reset(struct pci_dev *pdev)
 		pci_enable_wake(pdev, PCI_D3hot, 0);
 		pci_enable_wake(pdev, PCI_D3cold, 0);
 
-		if (igc_is_device_id_i226(hw))
+		if (igc_is_device_id_i226(hw) || hw->device_id == IGC_DEV_ID_I225_LMVP)
 			pci_disable_link_state_locked(pdev, PCIE_LINK_STATE_L1_2);
 
 		/* In case of PCI error, adapter loses its HW address
-- 
2.53.0

