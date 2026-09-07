Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2410C79F9E
	for <intel-wired-lan@archiver.kernel.org>; Mon,  7 Sep 2026 11:52:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ABFA2605F5;
	Mon,  7 Sep 2026 11:52:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 70oe-aLXfZHD; Mon,  7 Sep 2026 11:52:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5270260686
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788781973;
	b=ODryGRzH5NtfgIAhA2JMUtNsuKZi7Sz0jPSYBwy4XySPNoqbNs6KTPizxuYKDS9o9kaW
	 MaP2iqiGFK/Sds2ecfW/jsKEbGiJF7fwMYRmUEWIurkvoPSZ6ntj3iB7t2a3x+qgyZubT
	 /GA1k5Quu/jKKfv6tPNKu+fwvnam4KbhsfE9513P8XRCukHzl/69L93OB/dh6R/iovYHu
	 CnFl9sqEgQWjtmRDTV+Nul3a50uKFR+Ia1IglHhh/D2ftLmxyWAB7mqg3dAPv+pn19zwL
	 3wcUFOD0H2FT9k03aL76Wp0XdS9dQks/EATisA0U0iMj3V+vPyD8tYAr3cPDlvSRWnA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788781973;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=t3fkNHFm1RR4RErP9CR45D7pPPNRjAdZ1eP2jcftRKs=;
	b=ftgxRWlSmNQkZ94gSO1bKdROQKu6jREnBFJI+isXnJLFJ1fP2gDdg4czU6iQcxkWb89q
	 HdWv80q2OTZ0MzKH2PJ5EiWTnGSdJ+TinVAhPjcZZ1Xmu7H9PvzBjqFw0aRkEWgyq87UX
	 3ao7RIGle8lLE2DnzACQnkMpApjSKxeU0v7ZaZqtKma19C/Lu2jyY4LDGToZqr/LMREE+
	 YTQL0hg98bOjdttXlnCXkBawtY69CgQ3fdxoSyMsW/hW8of+iKrb31g9Z2JKgDrjk9yIZ
	 Qwm1Ovls6p7gqo0bGb9hr7jfEpI0SyRR3rKBDtF215cLg6wG/JgmRBT5BWzU5VBI08A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788781973;
	bh=t3fkNHFm1RR4RErP9CR45D7pPPNRjAdZ1eP2jcftRKs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PfAmLhs0CiMZgkSfPnweuJNdAv3hbeExRjkqhcAyVd45NygUNJgKe5NC3XMRRl1rt
	 eu/jNE+6pqJ14WSi4fx7Jv/2PNHSUmu0OUngBqUhDFA1kVrK5b3jjpKfgqO6M3rQft
	 LWO+jfXoNWNRwXLYcu98xZNiMBNTFEAODLPCTw//dfH6mwrYG9aO1IFrrxzNhtdniE
	 PCaPFnpsizhqMmXGMzNiwkuQvJv7eFtlKeSuTiU+vvBaaav7+VUoiqX6L4k045y29B
	 VaE28DMzahGxPrmwqndzaX5upv05myxyvlU3dnAeFMg4k7rLbGl+nvJr0GFNH0ufmh
	 3pqxGQo42K8SA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5270260686;
	Mon,  7 Sep 2026 11:52:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C5893A48
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 11:52:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ABC534054F
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 11:52:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Il5Fug-qB-FJ for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Sep 2026 11:52:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A9A7D40518
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788781971;
 b=W6ZK6F+Cf2S4tTRB33wRXA8i/ytieHNVxdJ3pzuWxKLK6hAkJA73fxQEgjw7MJ3ak28O
 S5b4JHXZTyRFdPes/PG2KH+ao9ahqE37C/JsMnvfG8SLJZeR1IKeraDOgQudYFjMPv3J5
 WOODDtbiPQ36mV2aelTMqXhlQ1EhbBM3NrEKPTktH+OMY0BGgzCjZvLCdNdjcDTgVMJV5
 h29QVAsfExUjuAJbgjLkD16GcOqZ2nnXQ/twh7scGC4iomq9MvdkY28//k/+vQyuHEzh7
 q5qDEG7AmaAGxZOaxW3fuBLMYi4ujEuOh6m4PAmYrfXyKo+0llyArWegfYSsnCo7jiw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788781971;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=t3fkNHFm1RR4RErP9CR45D7pPPNRjAdZ1eP2jcftRKs=;
 b=nVhtDgVKRlJQQsuqG+hvPqIzQOQ70Rpx1KiNUcdXU0LFc6eXsCiyaCbZfeDTD3QM4bro
 Y+imC5jwqz9w+xI7atgEeUCDdQJv2YOTydCYb2SZswMK2LvPnhPDU5wlcI28DMWp/U1Yw
 u87xm7am3mnVkGNoxRfOkbq8/p1e1omQV7GFYLxRUGSJvfp6qM6QvheDAhsxJLYNG7SxB
 YEXP5JPq6zzoyWGqwayAE/D7eobXMMhdXng1P9kw29WIBsLz3ppBUNE9sJqJmTa20laTS
 1f5eTB7EQpg7Qy7bUIuiwck1cIbhuxok6RGG6YZVOvULMPw3UFsgQ+C2G0fY3P6++EA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=crItAjf4; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com; envelope-from=aaron.ma@canonical.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=crItAjf4
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A9A7D40518
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 11:52:49 +0000 (UTC)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DE1303F28B
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 11:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1788781966;
 bh=t3fkNHFm1RR4RErP9CR45D7pPPNRjAdZ1eP2jcftRKs=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=crItAjf4t+qa6L6x7N9addrM0OkHNh2XkTzg45dJVRubBz0mEKerfAbfcs+lKpS4f
 SSA6e+LsNqfEJoTW+tBefdVdW+yjNsCpPFWgcyys0Hxtn4U228qnIs8T0AZI/6gCUY
 9mkgHrm0g5LR8JK5ZvMSDbgK0k2vXJJt3ZqkZpckMe1etQe373WOzny9Jh7/pSiy+p
 d/mYWvJ2nyQwvR8iZKrlq0lkeymgB+AvlZSaf92LdGMElRQuKll1aenDtJS6Jzs1ec
 tXvvuuL03ZTKzPpYRedtPfXtDdiB3YARLgqmbxyzBWbhwT5JI8JhuWx4Kaa+uyCXt+
 qvIm7ZoJe867IrEb0QKh34QI8VcdaUH4U8c9cPVhvVf/JGGh110LN7f+w5m1FPznCN
 Wd7RpLkiAue8GgSdTbvpXUvAB3VpfWqSqgf13YeoHsNuk//jRtp9sVmVu+gZtnaadI
 iL3ddRhErNEODXvptSDj9cSsgcYAcuIGvcIXKk9ACA95fqDaI94EZ7KducYlrJYiPv
 vjEJJKQAcgYdFfCTqtySI/c9sBqXZgNLIHuLjPrCtxZ/03sPYxnDr22lC/XLIjFZv4
 viBXIumSHyRJ0qGhyLtxHSncYAhhUACMSwk4vqQ88jenV+gEB/o/qZXEFJPjC3cph+
 JY48yWqYkqLwTy0tH7ZfNptg=
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2d7443e0f0bso52094045ad.1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 07 Sep 2026 04:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788781965; x=1789386765;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t3fkNHFm1RR4RErP9CR45D7pPPNRjAdZ1eP2jcftRKs=;
 b=Yqcw2+Md0Ga6AyY3aHSm78M1FJxcE2HuExCjTlZIatEBRRJRa8V67VgIuZi8XTB8Q5
 66IjCbjymeAs/jKUlY8MY1gvKddK/H3SmpLPLkdMXu0qybL8JGpqsPWsxa9WXedTDcau
 RPTC+c9hfJ3muDVn+VNiw8tZR3xY2FN35Ok9O3Ikg3xqsC5hbxOmE74XRfhOw//ZWrBH
 Osqw6yZeM3ky7ziz/U1iY1Uk75H8//MeKKlvdnN4htADJQHEiD2irr2mu9rdtkWEfpam
 DXnslv8Uzap5Exi32x5oTbt/oYF1+0srCNtyXXC+ZeUSeeHDLBvWua+mZcm7tTqdpqJn
 4a+w==
X-Forwarded-Encrypted: i=1;
 AKwUvBz7xGKmb43vt59AWNw8Lx4S+r4jBh3Xih29nPR8f/s2wQbtZyytiT7pwzadpc40YCSK9EBPUm4N2PcQNO6eF2k=@lists.osuosl.org
X-Gm-Message-State: AFuF++lqdKZPu5bF43gW9ISZ5STvD3DXJCMbHsvbBUgNnaO9Xv1YcaLL
 QHEWSXBOqLHdMAa+jSw8k0XulDtMq1gHnrtGJyp7TKGzPSzsaHUtG2f+OzYgwji4DICSG+S6DKv
 vDwb6711ePT+XBk2oqj45imytCGRjUtmBFC+0FOESCK2jzI42pdvl7HhXyxCgn1NW/z7Nu+yW9w
 oPJBF6Cv0xhsg=
X-Gm-Gg: AYBFou3nTgL7EkHVxRGOS8AM1QDEuE1QIQzPsw1VDCUsPs4Djecg+quN29r5DcS4D1u
 Z/ekWqlhZkdCUD0FZCtd4h8lcevju6yom0arDMCB411orXycdgm3sc3pFdJW72d02uoe4J3jRr8
 4ODobVFmzmzszmFqrVqK8DCC6//ykykwsBFOSP4lRW/sVX0H0TKfWs4fMIrTo55I62S829ZnXdY
 JszeAjmlUprT3P1Mwv+lcKqivh85lto9+7pxJSmjGPsi2cumEIeahnEhdR7B1bFn6mvKtq+n3oZ
 ptPNcO8UW2d/vm0I3GwwGBH6whAJWXFjcbhxmnaDxoiK7+vug6HwCyiugTsmclvuev7VAFi0tux
 tGMK7hOmO8XFVpBILP5XPjJ1Vqv/73g6UMcGpV8QL+TKxvS7/nb0purzaPIejzM1uigp4FUtKLb
 IzGXkFYkeA3XNazlEBLwTenCGnmaWLW3rObfpFDxw=
X-Received: by 2002:a17:90b:3b8c:b0:398:9bd4:d13 with SMTP id
 98e67ed59e1d1-39b26242a75mr31038765a91.18.1788781965256; 
 Mon, 07 Sep 2026 04:52:45 -0700 (PDT)
X-Received: by 2002:a17:90b:3b8c:b0:398:9bd4:d13 with SMTP id
 98e67ed59e1d1-39b26242a75mr31038666a91.18.1788781964421; 
 Mon, 07 Sep 2026 04:52:44 -0700 (PDT)
Received: from u-ThinkPad-X1-Extreme-Gen-4i ([103.155.100.15])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b08c39227sm26922513a91.9.2026.09.07.04.52.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 04:52:43 -0700 (PDT)
From: Aaron Ma <aaron.ma@canonical.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Henry Tieman <henry.w.tieman@intel.com>,
 intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS)
Subject: [PATCH v2 1/2] ice: restore DDP state during PFR recovery
Date: Mon,  7 Sep 2026 19:52:20 +0800
Message-ID: <20260907115221.926007-1-aaron.ma@canonical.com>
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

The firmware package and switch recipes are shared by all PFs of an
adapter. However, each PF rebuilds independently after system resume. The
resulting package downloads and recipe updates can interleave, causing
firmware timeouts and leaving interfaces unusable.

PFR also clears package-derived firmware state on affected devices. The
existing PFR path only rebuilds the driver's block tables, so VLAN recipe
programming can fail after the reset.

The failure is reported as:

  ice 0000:04:00.0: Update pkg failed: err -5
  ice 0000:04:00.0: package load failed, -12
  ice 0000:04:00.0: Rebuild failed, unload and reload driver

This was observed on an Intel E810-XXV-2 adapter (PCI ID 8086:159b,
revision 02) with NVM package 1.0.0.18 and ICE OS Default DDP package
1.3.43.0.

Serialize rebuilds across PFs of the same adapter, while allowing each PFR
to complete independently. Reload the DDP package from its cached copy and
restore the default DVM recipes before rebuilding the remaining PF state.
Abort recovery if either operation fails.

In addition, stop the service task before tearing down resources in
ice_remove() so that an in-flight rebuild completes and cannot dereference
pf->adapter after ice_adapter_put().

Fixes: 462acf6aca85 ("ice: Enable DDP package download")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
v1 -> v2:
- Stop service task early in ice_remove() to prevent use-after-free on
  pf->adapter if rebuild is in flight.

 drivers/net/ethernet/intel/ice/ice_adapter.c  |  2 ++
 drivers/net/ethernet/intel/ice/ice_adapter.h  |  3 ++
 drivers/net/ethernet/intel/ice/ice_main.c     | 35 ++++++++++++++-----
 .../net/ethernet/intel/ice/ice_vlan_mode.c    |  2 +-
 .../net/ethernet/intel/ice/ice_vlan_mode.h    |  1 +
 5 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index 2dc3629d6d0f6..7de9223e971a7 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -64,6 +64,7 @@ static struct ice_adapter *ice_adapter_new(struct pci_dev *pdev)
 	spin_lock_init(&adapter->txq_ctx_lock);
 	for (int i = 0; i < ARRAY_SIZE(adapter->cpi_phy_lock); i++)
 		mutex_init(&adapter->cpi_phy_lock[i]);
+	mutex_init(&adapter->rebuild_lock);
 	refcount_set(&adapter->refcount, 1);
 
 	mutex_init(&adapter->ports.lock);
@@ -77,6 +78,7 @@ static void ice_adapter_free(struct ice_adapter *adapter)
 	WARN_ON(!list_empty(&adapter->ports.ports));
 	for (int i = 0; i < ARRAY_SIZE(adapter->cpi_phy_lock); i++)
 		mutex_destroy(&adapter->cpi_phy_lock[i]);
+	mutex_destroy(&adapter->rebuild_lock);
 	mutex_destroy(&adapter->ports.lock);
 
 	kfree(adapter);
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index 4f695f32da3d8..f9265de973efc 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -37,6 +37,7 @@ struct ice_port_list {
  * @cpi_phy_lock: Per-PHY mutex serializing CPI REQ/ACK transactions.
  *               Index 0 = PHY0, index 1 = PHY1. Used on E825C devices.
  * @ctrl_pf: Control PF of the adapter
+ * @rebuild_lock: serialize PFR recovery across PFs of the same adapter
  * @ports: Ports list
  * @index: 64-bit index cached for collision detection on 32bit systems
  */
@@ -48,6 +49,8 @@ struct ice_adapter {
 	spinlock_t txq_ctx_lock;
 	/* Serialize CPI REQ/ACK transactions per PHY (E825C only) */
 	struct mutex cpi_phy_lock[ICE_E825_MAX_PHYS];
+	/* Serialize PFR recovery touching shared FW global state */
+	struct mutex rebuild_lock;
 
 	struct ice_pf *ctrl_pf;
 	struct ice_port_list ports;
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d88835482d3aa..abb6e850ec09f 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -659,7 +659,9 @@ static void ice_do_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 	 */
 	if (reset_type == ICE_RESET_PFR) {
 		pf->pfr_count++;
+		mutex_lock(&pf->adapter->rebuild_lock);
 		ice_rebuild(pf, reset_type);
+		mutex_unlock(&pf->adapter->rebuild_lock);
 		clear_bit(ICE_PREPARED_FOR_RESET, pf->state);
 		clear_bit(ICE_PFR_REQ, pf->state);
 		wake_up(&pf->reset_wait_queue);
@@ -704,7 +706,9 @@ static void ice_reset_subtask(struct ice_pf *pf)
 		} else {
 			/* done with reset. start rebuild */
 			pf->hw.reset_ongoing = false;
+			mutex_lock(&pf->adapter->rebuild_lock);
 			ice_rebuild(pf, reset_type);
+			mutex_unlock(&pf->adapter->rebuild_lock);
 			/* clear bit to resume normal operations, but
 			 * ICE_NEEDS_RESTART bit is set in case rebuild failed
 			 */
@@ -5374,6 +5378,8 @@ static void ice_remove(struct pci_dev *pdev)
 		return;
 	}
 
+	ice_service_task_stop(pf);
+
 	if (test_bit(ICE_FLAG_SRIOV_ENA, pf->flags)) {
 		set_bit(ICE_VF_RESETS_DISABLED, pf->state);
 		ice_free_vfs(pf);
@@ -7674,14 +7680,27 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 		goto err_init_ctrlq;
 	}
 
-	/* if DDP was previously loaded successfully */
-	if (!ice_is_safe_mode(pf)) {
-		/* reload the SW DB of filter tables */
-		if (reset_type == ICE_RESET_PFR)
-			ice_fill_blk_tbls(hw);
-		else
-			/* Reload DDP Package after CORER/GLOBR reset */
-			ice_load_pkg(NULL, pf);
+	if (!ice_is_safe_mode(pf) && reset_type == ICE_RESET_PFR) {
+		enum ice_ddp_state state;
+
+		state = ice_init_pkg(hw, hw->pkg_copy, hw->pkg_size);
+		ice_log_pkg_init(hw, state);
+		if (!ice_is_init_pkg_successful(state))
+			goto err_init_ctrlq;
+	} else if (!ice_is_safe_mode(pf)) {
+		/* Reload DDP Package after CORER/GLOBR reset */
+		ice_load_pkg(NULL, pf);
+	}
+
+	/* PFR can lose DVM recipes after system suspend. */
+	if (!ice_is_safe_mode(pf) && reset_type == ICE_RESET_PFR &&
+	    ice_is_dvm_ena(hw)) {
+		err = ice_dvm_update_dflt_recipes(hw);
+		if (err) {
+			dev_err(dev, "failed to restore default DVM recipes: %d\n",
+				err);
+			goto err_init_ctrlq;
+		}
 	}
 
 	err = ice_clear_pf_cfg(hw);
diff --git a/drivers/net/ethernet/intel/ice/ice_vlan_mode.c b/drivers/net/ethernet/intel/ice/ice_vlan_mode.c
index fb526cb847764..58fb191903a75 100644
--- a/drivers/net/ethernet/intel/ice/ice_vlan_mode.c
+++ b/drivers/net/ethernet/intel/ice/ice_vlan_mode.c
@@ -240,7 +240,7 @@ static struct ice_update_recipe_lkup_idx_params ice_dvm_dflt_recipes[] = {
  * ice_dvm_update_dflt_recipes - update default switch recipes in DVM
  * @hw: hardware structure used to update the recipes
  */
-static int ice_dvm_update_dflt_recipes(struct ice_hw *hw)
+int ice_dvm_update_dflt_recipes(struct ice_hw *hw)
 {
 	unsigned long i;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_vlan_mode.h b/drivers/net/ethernet/intel/ice/ice_vlan_mode.h
index a0fb743d08e20..5dc705435f56a 100644
--- a/drivers/net/ethernet/intel/ice/ice_vlan_mode.h
+++ b/drivers/net/ethernet/intel/ice/ice_vlan_mode.h
@@ -8,6 +8,7 @@ struct ice_hw;
 
 bool ice_is_dvm_ena(struct ice_hw *hw);
 int ice_set_vlan_mode(struct ice_hw *hw);
+int ice_dvm_update_dflt_recipes(struct ice_hw *hw);
 void ice_post_pkg_dwnld_vlan_mode_cfg(struct ice_hw *hw);
 
 #endif /* _ICE_VLAN_MODE_H */
-- 
2.43.0

