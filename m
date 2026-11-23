Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700B7606A327
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=yiaaDILA;
	dkim=pass (2048-bit key, unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=XKXfLffB
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E26B607B4;
	Mon, 23 Nov 2026 16:24:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gyIuBZsB1CWW; Mon, 23 Nov 2026 16:24:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4A608607A6
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795451070;
	b=NcxT5tTOnDX1Wl0wr/AgCcSK3mhMQnhWn2m/QHM+VoFLAXcR8a+F1bj1oLz/F0D/sHya
	 jJo7aUSUQVoZFaJ/UOwOCPiJze9EmuB55BS0OLnZDKKUuJgxo+ElmNIXwxjdJxKtrSkAy
	 OOg6KbMPZBOsrMm2MT5Z4AwYfZND6M1aV78atpeBTOYgHfvuj7jee2oVTHsl6XpdpHMKr
	 I28jW6uNvIO+ENl/dLqwomyfoQTzewV4ylf5ZnTGNRg/HJo2g4EpJug988VHwq7U24i5W
	 uRT5+fhc402erzdKznRmOinShCbs/ya7vWyCadrW0Fgl1wnhuFdEcyD4P9CcIIwztkg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795451070;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Rspamd-Queue-Id:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=CUFZdLSuEVrrJUDvAVyiBpqKpftwiDzoT2ikSg1vLJc=;
	b=Sfx+0HT4zjsPKiA/CkCB0mP6VZnpT0Cg8EQ/usxASozXFSwA0V0jCCh+YbdQkLTr+lJk
	 xQsOBaOqW69+Vh9LPR6D0Qr7qJEjBcnJaa51KwLMFKUBQ9FHLJZg4DXhPNVkgO9BkT6UV
	 bgWMlW6SBcmx2jQjKgq9TB4Kn7KwLOLQRaut11Ji2zfTvY90lBjd4nx3Gf740Ve53rZyh
	 oO2NIFu88PGuCrpFtGk7pkWpC5C0mjQJC//9/OovpKiAyBbp4Nq+/NAvygVJogs0SAqYd
	 bv4kzz0o0PSdwHSk2KcMv9JFS2uiCnajQQwByR51vml55oW1vCBsoEJge2kQqc4QgJg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795451070;
	bh=CUFZdLSuEVrrJUDvAVyiBpqKpftwiDzoT2ikSg1vLJc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yiaaDILAecZMGpbszd+renGHCNeQSRGSebaWTLHpI2k3LzJF6waCM7z5Y1Q22LPJK
	 G0a+rNHwP7LVUz56YDVQjB2bvhlfw2MZpwybPxSBGSYBjchpqzPxt2Y+/czvAgCAAu
	 ylzKkZgzaE/py5qGIzUk+EwIW142rVFKTnYyxgMxvc49vhlZAHBwX8pVPUP8XZJhon
	 znbTHYm2t9r30kI0fYShFRFZYtYrLKadp38exV4njm/3BbL/BkvFTr4xocTQAKUQmw
	 ytJ0xhQPz15JNfvV/ROcU4sqqbhjshlpbRUPNmqFIZi6ul3aQHZDdEC107fHnvuSht
	 ibiLvv/kJTVpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4A608607A6;
	Mon, 23 Nov 2026 16:24:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 81CD522B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 10:03:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 730504005D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 10:03:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ek8fmDlJEu9a for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 10:03:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6572640098
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=lists@steffen.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256
 header.s=MBO0001 header.b=XKXfLffB
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6572640098
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 10:03:36 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jY1Xk5Q0zzMlbC;
 Mon, 23 Nov 2026 10:55:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001; 
 t=1795427750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CUFZdLSuEVrrJUDvAVyiBpqKpftwiDzoT2ikSg1vLJc=;
 b=XKXfLffBqBw/lIXDBCbFqd/6OPVIDIymadSqER38M3JIMW1URHVQ5mCJ/iJ2uS1oJmIRUu
 MZKU9tPE/D2lR8SKNNv4orpV3cWc/IHlzxK4v5EDl94L1IGCxgIaxCf3zsWDz50TRLQKcL
 EtwwPNrLW6SRXyG87ujV6t2B5thgLkVyKKLSTtPGLp1TsNeCHZtInA0BWhfWMqSJ+dyTsU
 SMiwf9KjR7xeec3n7xbOsVVaR2bc3Kaa8h2CckA6hZixJdVBYvMk+ugboM+w5qF/igoQVP
 9U43tNVzpwkDck9hHR3OouoK0hBeziwif4vRaHnI99ua3/BbmV9ISDxlRxADWw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates
 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=lists@steffen.cc
From: Steffen Dirkwinkel <lists@steffen.cc>
Date: Mon, 23 Nov 2026 10:55:15 +0100
Subject: [PATCH iwl-net 1/5] e1000e: retry a global reset the I219 didn't apply
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-e1000e-tx-hang-v1-1-ecb4309942f1@beckhoff.com>
References: <20261123-e1000e-tx-hang-v1-0-ecb4309942f1@beckhoff.com>
In-Reply-To: <20261123-e1000e-tx-hang-v1-0-ecb4309942f1@beckhoff.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Ertman <david.m.ertman@intel.com>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Helge Deller <deller@kernel.org>, 
 Kurt Kanzenbach <kurt@linutronix.de>, 
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795427747; l=3258;
 i=s.dirkwinkel@beckhoff.com; s=20260625; h=from:subject:message-id;
 bh=yqmgwh9JQiMyoM4++9UMC+bt5AFLx9eaGnWZdS19Kpc=;
 b=FMYdigKOgk1H5XF+dkBC+6hmwOvfDg/FXDEefvgv4tKeH3aixxHMvqWncMErJg33LFyPqSm0r
 k9osIN17oX1DUblDclZ43OoQpd853YibgbwK5gCaiDTR+mTnQiWdgO1
X-Developer-Key: i=s.dirkwinkel@beckhoff.com; a=ed25519;
 pk=5DcsaSpVtmm7nCi3Bnw5A4vbXI+sg3hBgt8e2A2U/gw=
X-Rspamd-Queue-Id: 4jY1Xk5Q0zzMlbC
X-Mailman-Approved-At: Mon, 23 Nov 2026 16:24:27 +0000
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

On the Beckhoff CB7268 (Cannon Point-LP PCH) and CB3067 (Q370 PCH)
boards with an I219-LM (8086:15b7), Tx sometimes hangs for good right
after boot: "Detected Hardware Unit Hang" with TDH 0 and TDT 1. This
was observed in the field and reproduced in CI, where about one in 140
cold boots hung.

e1000_reset_hw_ich8lan() sets CTRL.GIO_MASTER_DISABLE through
e1000e_disable_pcie_master() and relies on the global reset to clear
it. On these boards the MAC occasionally ignores the reset: 20 ms
later CTRL still holds its old value, GIO_MASTER_DISABLE included.
A debug kernel that resets the MAC in a loop lost up to 7% of back-to-back
resets and still some with 20 ms between them.

Check GIO_MASTER_DISABLE after the reset and issue the reset up to two more
times. In 122 lost resets the first retry always took.

Tested by power cycling affected devices: 13 of 1816 boots hung without
this change and 0 of 2830 with it, where 19 lost resets were retried.

Fixes: 79849ebc0e06 ("e1000e: initial support for i219")
Cc: stable@vger.kernel.org
Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index aa90e0ce8aca..4d4bc262ae85 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -4834,9 +4834,11 @@ static s32 e1000_get_bus_info_ich8lan(struct e1000_hw *hw)
 static s32 e1000_reset_hw_ich8lan(struct e1000_hw *hw)
 {
 	struct e1000_dev_spec_ich8lan *dev_spec = &hw->dev_spec.ich8lan;
+	struct e1000_adapter *adapter = hw->adapter;
 	u16 kum_cfg;
 	u32 ctrl, reg;
 	s32 ret_val;
+	int tries;
 
 	/* Prevent the PCI-E bus from sticking if there is no TLP connection
 	 * on the last TLP read/write transaction when MAC is reset.
@@ -4895,10 +4897,27 @@ static s32 e1000_reset_hw_ich8lan(struct e1000_hw *hw)
 			e1000_gate_hw_phy_config_ich8lan(hw, true);
 	}
 	ret_val = e1000_acquire_swflag_ich8lan(hw);
-	e_dbg("Issuing a global reset to ich8lan\n");
-	ew32(CTRL, (ctrl | E1000_CTRL_RST));
-	/* cannot issue a flush here because it hangs the hardware */
-	msleep(20);
+	for (tries = 0; ; tries++) {
+		e_dbg("Issuing a global reset to ich8lan\n");
+		ew32(CTRL, (ctrl | E1000_CTRL_RST));
+		/* cannot issue a flush here because it hangs the hardware */
+		msleep(20);
+
+		/* Some I219 occasionally ignore the reset of the MAC, mostly
+		 * right after a previous reset, and CTRL keeps its value.
+		 * GIO_MASTER_DISABLE then stays set from
+		 * e1000e_disable_pcie_master() above, so the MAC can't fetch
+		 * descriptors and Tx hangs. Issue the reset again.
+		 */
+		reg = er32(CTRL);
+		if (!(reg & E1000_CTRL_GIO_MASTER_DISABLE) || tries >= 2)
+			break;
+		e_warn("Global reset not applied (CTRL 0x%08x), retrying\n",
+		       reg);
+	}
+	if (reg & E1000_CTRL_GIO_MASTER_DISABLE)
+		e_err("Global reset not applied after %d tries (CTRL 0x%08x)\n",
+		      tries + 1, reg);
 
 	/* Set Phy Config Counter to 50msec */
 	if (hw->mac.type == e1000_pch2lan) {

-- 
2.56.1

