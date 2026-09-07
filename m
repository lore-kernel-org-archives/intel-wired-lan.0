Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45426C79F9E
	for <intel-wired-lan@archiver.kernel.org>; Mon,  7 Sep 2026 11:52:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0BC71606A3;
	Mon,  7 Sep 2026 11:52:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CmxsJVgt0Ixc; Mon,  7 Sep 2026 11:52:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4729D60692
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788781978;
	b=SSMEBKr7SslwOmRafU7Xd4CPaBTpCcPBVzZO+eVxbc/9qjYJDkYolyVVkNPvFbJJ6E5X
	 feR6Zkpa/QdjvYG78nz4rRzM5PsG1DIObU9YXdevXk8CqBCyydkPf6+C6G6BVRXym3aGD
	 pdJFWrSnh5rshWvrtiLxFhWOAQHIjIBjO67tzuaVJOdenOy6MV4jJYMc6bz1mD73ZGw68
	 rQNQtFtgZz9A9cKMHQgg6xZHF4EZR69o2AxzZsjz2CJHJy2e8nBnuciB5QFjTp6NEPDd0
	 48OGrqldPk+Z5BumyT4v/bIehE3/A6Qc9lEf7IngkzzO/6m9VUQqt7v5sejYcTVh2cg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788781978;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=f719CSeWdbk3xX0dreB43mfMPTEcjgTdJiglOAe4/WA=;
	b=WoHrRpuYEUFaTvdb1xEbO6Y8ZXWmwzpxYT1Qj7DKhHnWvup92DiQy+ZV+evJNRkPWndV
	 X3QhnnV7qh1mJs4HZJu/ymzoyHakECQiuILME+wgOrXmT6AJWJmiibu9c9h9pPkJsyI/t
	 /QXXRbWIxuWt+UgKXVNV8VlLeSr06ERg3U2zNyp1HscH3BNL0DFtD+H7Cf5QsnuCSIwU1
	 Bw1g+QmjVyJTCMOT2TOAXP9eqysAcvCpZ7TSMdLR2JWDXYkmfakvaO6S52WkyQWimwxWs
	 UzOdSIHUxaJFPC0Bq865oRhg9wEAXWfccu/zofifPV26vaXBcRim06vinF+cctYjvEA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788781978;
	bh=f719CSeWdbk3xX0dreB43mfMPTEcjgTdJiglOAe4/WA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EFMYbAkUDmLJ7EGmrgrPP0lhCaAvTt53YADLskYKEOB77HWLGHxa3EQk00SVkdwXZ
	 sOwHDZ4qceUDWovdio7QMjlpWaBsSTtzweRnEWgkbJzceiZbYULlVdsBjkrERUSOeN
	 phCutTqSak9/wHFbVEte8fUVBT3+8UC2BXxPGthLlxMl1LJWSayVZHuQW0UJNAbFA4
	 hfUouhLBumFwhp4Bf0lobgIMLNP7BnwOKvJi1VXcPF2H65W6zIVr8PgGpIsfcIYYWa
	 zo+GDZSaEfJYQzBJTz7jOTKRG+PMt7XwVuj/CCxA+/UEsfO3rOrgQ9//A4oM9+Cezc
	 c7Rofn2SUzjhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4729D60692;
	Mon,  7 Sep 2026 11:52:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5B517990
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 11:52:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 590A840105
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 11:52:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nj4fHiEPhQ0o for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Sep 2026 11:52:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A180940103
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788781975;
 b=ECxHIYMkS8lfiWHGVSxGhAaEEHAQlKWtTd9CvW/hW80nX4zgFTKrWDnDyMDIQS8YkitN
 f1dECeYmA2cUbMrdo/4gCM0UiVMPs4mm6RiuEDZmgkUMENQ7CeSnCPdMBAozN3e6GffT1
 pflwWsKXHUV5sIIYp7kR+NRSCvv5P17kawZdLc4SznJBV/7L836+OqX2bUkXutsr9GHdN
 1WB0vXvTIsq7SncDgFvuPUiX0ZSsJqz/MwfduEGAvFEudE4jgIuMxelYDFSENvUdCKysj
 0qUNTXpk4LGgX4izpGxb3J+lBbEQuYdZlPL/lnaRk27t0y1M//J9TVxbrYN5BG3dnVg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788781975;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=f719CSeWdbk3xX0dreB43mfMPTEcjgTdJiglOAe4/WA=;
 b=s/MLWWnXRaYZ/mx9SrfgAVb7hdLQgw0dPLTMiAiNVHjim9n50krqrvZPblyi0EXwaX/X
 yQ3RgIUCESU4Z6XNuX2zxpD+LfAc38l0Pc8MfSdyEb9VH0hYiSMeuYtq2jq9KfNNpOZvl
 sOj8jvzaLH4iLib0WBN0lDfo88FxbaS6VKoPc6gcwqUwhmosW/TKezluZVjcLBf72Fdo7
 bOVBVvOtlCpar/uSVOHndIjZ8E//pzWu5EgHR4kg0fFkEpN+fgdMInda098Qd2IPIJPdz
 HtZ04ZdCkVypMIYsaUNV2+qg2YYSErfUbWYgNb0cuai+Ho9ZYIL/s9RkneboJEHW7MQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=Whg17Uq2; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com; envelope-from=aaron.ma@canonical.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=Whg17Uq2
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A180940103
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 11:52:54 +0000 (UTC)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 447DE3F28B
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 11:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1788781972;
 bh=f719CSeWdbk3xX0dreB43mfMPTEcjgTdJiglOAe4/WA=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Whg17Uq2/9WJNAegTGAoRBoMdMxoEFNHFHP81S4ZW7ob1Asyaxd5HMQk3zV7lvAa3
 zduU+p0BFfnna34vftKjn2hLsKKpJuuWQ0fMgTM/JXQ/PUPAZIdtzCJT4JWMjq2PiK
 kI+C/+13T+J6xbH5SIs2hnmtKJxzOkT/EkHSEyIdwPKmGPUzTlA4OUFneScWUxyoEm
 2/LxtbljXV9XRfQEQZfHwE/sntZfCy5iyfprJD8FLHEtUlLerLBqTjVA1Ewh0PlkZb
 Qlx76N67kta1QVuZ6PGLSt0Th4tAFJ5rX2FDUh3ivl7L4t2CzyliVeM8pC2dNN0WXI
 ZOWHcfA34tk4eHGDtakUGIS+LNyPV12UgyHGtafgsMCdagFOys8xbjq9x5PxVL0pXZ
 DvNExD6r9oyeqU3BBy5ZDA9wRfonJTmRWJpxCyDqzwmzVLlAGXCRP91Pnk5GlxktyT
 RfGnBTBd2b70tJNEx2G5EfV5kgGUK0J0ka6SPdPyZFovTaLwE6B4watCoDpq1wZdto
 JZbVYFTML8czicUow6m68GQtiWV5M0C0S1+4iELdLUdjBaG2RmV8UyMSkC0LHUlpu9
 91x1nJzaSxKyiodh3G+cTSQXvlQRq5Xk0rR7QyKWISEl5Zb06ID2G88fDZoUfNQyfD
 jo1JfMNjENs3kBoCOFf4FQTk=
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-39af92138f9so5361161a91.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 07 Sep 2026 04:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788781971; x=1789386771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=f719CSeWdbk3xX0dreB43mfMPTEcjgTdJiglOAe4/WA=;
 b=NG7wW5LW1X70r8BmmFupbXbkq1kiiOFmjbmwxbXTlXAoB2bE2gIY1XC8bzm0lxM5d/
 ZN4eRTyo7rMBnlqaJGu8uBJQlQ9oSrsnM/my/+uetu0M7Y7mahfI2n4kNB4MyzBRlzOn
 EvJFFK5DnxNgM/e08EU223XHeutne0c2a1I2EHkylFWYmTC42MepRexfecvuDAmv2Pp1
 I9T+Wso/jVhaBkvCWHZREYRpUzruHT0TkPVFs+GBD1s2cLKu4D1BP8hy6twxAH0ffwue
 SBH9T9e35JL9Rcp8I19IhP211VT1sr1S0URswFnrqLnNaGkSnuj1TiO1BpQasaCnpfed
 TCzg==
X-Forwarded-Encrypted: i=1;
 AKwUvByqgVV8eXzMj36z4TdA2wGat2Hu4G38zIzsVGIsdOgY/wf5l+xup+AAxIvqmotvLE/rOcZNoQsZWnbtyx29aHQ=@lists.osuosl.org
X-Gm-Message-State: AFuF++lFARrH0qDLfbm3fSSmQx65CcMq+00KnKzrPcX233kRB2JVOfNt
 EN6j9PP2D/YFC8yWDJXMX4Kj6ZFvRlbNjFzNYNnRoaMRsteOAko0teep6BXLxZrwmL/rrmdb7TN
 i51kiEgFGjgdUC3KVVJG53eyfEtR20XA5zG4AzKrDww+7Zzybqxom4Cr5ZwV/Uabx/OW656rrzn
 WHP+VZIMTZ6j8=
X-Gm-Gg: AYBFou1aEvUMyJ4J09BF8eionlHSF9lIn7OQUqopl0znPxKyXXWdPOeC7jdatQnSt/N
 i+i1KVYt/Q8pqimY+2PdpLFn7cMu/85cdg8MU7P3poYVIFXCji9QhzeFZyB7D4qYllwMMrE2nel
 ANUfki1D7c2T5gWZ/u2XbRnlzitL6CoI1gpRAlEMPgEI9wQr7d0xNaBQm1OvexNyUY3hBKJE8JG
 6N3oMEgVFnCGszpBZ/iteWIr2C7PmvJeznvLcaw9BciI3WnELB1q75ghjaXuML/8p5ITakZdAb6
 v1qxUU1YR6dy5APaZ1VP12KccIAW+KUEI1Z0c9qZ4z9wGYQGwllCQTTCc3H1Eo0Vg0dWzBzQUka
 jx+bFblq6H6IQsf318phhI/WqqmhiZKOCfpjBVxljP1KNFDtLqAlGCC+7+R2WBLWPk1GqW0GdE2
 cYoSAaUR/cJfC1fKL+ooldcDqtHB+6XP1dBN0Iw8I=
X-Received: by 2002:a17:90b:5110:b0:390:84db:888e with SMTP id
 98e67ed59e1d1-39b8bd4aef3mr422559a91.7.1788781970713; 
 Mon, 07 Sep 2026 04:52:50 -0700 (PDT)
X-Received: by 2002:a17:90b:5110:b0:390:84db:888e with SMTP id
 98e67ed59e1d1-39b8bd4aef3mr422518a91.7.1788781970233; 
 Mon, 07 Sep 2026 04:52:50 -0700 (PDT)
Received: from u-ThinkPad-X1-Extreme-Gen-4i ([103.155.100.15])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b08c39227sm26922513a91.9.2026.09.07.04.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 04:52:49 -0700 (PDT)
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
Subject: [PATCH v2 2/2] ice: clear Flow Director entries before reset cleanup
Date: Mon,  7 Sep 2026 19:52:21 +0800
Message-ID: <20260907115221.926007-2-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907115221.926007-1-aaron.ma@canonical.com>
References: <20260907115221.926007-1-aaron.ma@canonical.com>
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

Flow Director profiles retain handles to generic flow entries. Reset calls
ice_clear_hw_tbls() to free those entries, but leaves the Flow Director
handles unchanged until replay replaces them.

If rebuild fails before replay completes, later driver removal follows a
stale handle and dereferences a freed flow entry in ice_flow_rem_entry().
KASAN reports a wild access to list poison from
ice_fdir_erase_flow_from_hw().

The failure is reported as:

  KASAN: maybe wild-memory-access in range [0xdead000000000108-...]
  RIP: ice_flow_rem_entry+0xaf/0x170 [ice]
  ice_fdir_erase_flow_from_hw+0x1ee/0x420 [ice]

Clear the Flow Director handles while holding hw->fdir_fltr_lock before
the hardware tables free their entries. A successful replay installs new
handles, while a failed rebuild leaves them invalid for later cleanup.

Fixes: 148beb612031 ("ice: Initialize Flow Director resources")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
v1 -> v2:
- Acquire hw->fdir_fltr_lock in ice_fdir_clear_flow_handles() to
  synchronize with concurrent ethtool filter add/del.

 drivers/net/ethernet/intel/ice/ice.h          |  1 +
 .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 26 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_main.c     |  2 ++
 3 files changed, 29 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index db3c7015c56c4..4739ff882b9ec 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -1029,6 +1029,7 @@ ice_get_fdir_fltr_ids(struct ice_hw *hw, struct ethtool_rxnfc *cmd,
 		      u32 *rule_locs);
 void ice_fdir_rem_adq_chnl(struct ice_hw *hw, u16 vsi_idx);
 void ice_fdir_release_flows(struct ice_hw *hw);
+void ice_fdir_clear_flow_handles(struct ice_hw *hw);
 void ice_fdir_replay_flows(struct ice_hw *hw);
 void ice_fdir_replay_fltrs(struct ice_pf *pf);
 int ice_fdir_create_dflt_rules(struct ice_pf *pf);
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
index aceec184e89b2..04510b36aa56b 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
@@ -428,6 +428,32 @@ void ice_fdir_release_flows(struct ice_hw *hw)
 		ice_fdir_erase_flow_from_hw(hw, ICE_BLK_FD, flow);
 }
 
+/**
+ * ice_fdir_clear_flow_handles - clear handles freed during reset
+ * @hw: pointer to HW instance
+ */
+void ice_fdir_clear_flow_handles(struct ice_hw *hw)
+{
+	int flow;
+
+	if (!hw->fdir_prof)
+		return;
+
+	mutex_lock(&hw->fdir_fltr_lock);
+	for (flow = 0; flow < ICE_FLTR_PTYPE_MAX; flow++) {
+		struct ice_fd_hw_prof *prof = hw->fdir_prof[flow];
+		int tun, i;
+
+		if (!prof)
+			continue;
+
+		for (tun = 0; tun < ICE_FD_HW_SEG_MAX; tun++)
+			for (i = 0; i < prof->cnt; i++)
+				prof->entry_h[i][tun] = 0;
+	}
+	mutex_unlock(&hw->fdir_fltr_lock);
+}
+
 /**
  * ice_fdir_replay_flows - replay HW Flow Director filter info
  * @hw: pointer to HW instance
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index abb6e850ec09f..164428ba116a0 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -601,6 +601,8 @@ ice_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 		netif_device_detach(vsi->netdev);
 skip:
 
+	if (hw->fdir_prof)
+		ice_fdir_clear_flow_handles(hw);
 	/* clear SW filtering DB */
 	ice_clear_hw_tbls(hw);
 	/* disable the VSIs and their queues that are not already DOWN */
-- 
2.43.0

