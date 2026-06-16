Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90229CD98CF
	for <intel-wired-lan@archiver.kernel.org>; Tue, 16 Jun 2026 10:51:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3F47185509;
	Tue, 16 Jun 2026 10:51:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3Toi-tX2rh-d; Tue, 16 Jun 2026 10:51:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AF2378551D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1781607095;
	bh=ZMRFP/cIVcQkBD7AO9h8BoH0UYB8ekkkeuemaA4KQl0=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=MCK/s6WErfwnv0F9h9MgafBQjhLC3ibevXh2nonb9SHW+ldUx/PgLnHEIETUV7ORf
	 aSJP4oUiomZmQWVtgqy/gGI+FQfUmKoXTLxu+3mCVXB3YIgvAGkKKx0KU/DpeG6yPW
	 JdewShK/6Pn7nf8zzLRmNxkp5jweaMrdaifyFU8D4oFojHeMeJrG7xWrfVjal+zYAa
	 YEf5pe6H7l6UXOGqtTnXOwqEOEvk0cHzMTBwuAZRyhtzmEekn/i9ASm7iva5glVI4/
	 zB+bd9S41ZCyxJt8ScYW6o5pw1I5d3Ua4DdjxPCE0Y2pfVi8iXAwio1WyQkrBKKfqX
	 nJXD7UDZkXBnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF2378551D;
	Tue, 16 Jun 2026 10:51:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 45F75169
 for <intel-wired-lan@lists.osuosl.org>; Tue, 16 Jun 2026 10:51:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 24193608E8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 16 Jun 2026 10:51:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zqhO_mcWRDPc for <intel-wired-lan@lists.osuosl.org>;
 Tue, 16 Jun 2026 10:51:33 +0000 (UTC)
X-Greylist: delayed 358 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 16 Jun 2026 10:51:32 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C35EF60763
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C35EF60763
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=robert.malz@canonical.com; receiver=<UNKNOWN> 
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C35EF60763
 for <intel-wired-lan@lists.osuosl.org>; Tue, 16 Jun 2026 10:51:32 +0000 (UTC)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C1F7A3F5FF
 for <intel-wired-lan@lists.osuosl.org>; Tue, 16 Jun 2026 10:45:31 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490b61243easo47168915e9.2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 16 Jun 2026 03:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781606731; x=1782211531;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZMRFP/cIVcQkBD7AO9h8BoH0UYB8ekkkeuemaA4KQl0=;
 b=Cz9Pe/UjsbuHbAAb7/jiXFCZnswv2Uf/kvgu0MlItetgOdOyABr4SpGSwnkbEpD4h+
 wrKnbqzSvW0zXm+JYntuHP/ST4mym/nsbtYlrdvNc3yBVjLnb/QGYRa6lrklbrFovK/h
 FYlNHDJsDp4stY+R++/dz6LdCKVDPNHmUFV3pqFocPk7jNseJ86lqAdIvxa5sPKPvAXQ
 8u7uA07GvbGe32nRWTmanSam47uHSChfiybEFeqtqc3M689V+ASsaj0tLG6liFr0j8EW
 z3/o9x5BwiSmHFd8ilrXdJkj0WZg4UFb1kcQ5mKQxq4DLTuZwFy4DcJlEbN645cn59xA
 PGUw==
X-Gm-Message-State: AOJu0YwOqoLdbjr5lnFvvH3v5c+/dxaBLfE0RM8/Y0q831TVn/UGGpe2
 1ejZMDLTP6ZP9Aap05RAbPpPU3rwLCS2JiCaluE4MNaZ4Bp5PMdt9s64HMtTaljAORI4HOJyEBW
 +Hxq8gx1X6cgxFHNC7+j0KmGRpaJKsieMxZf7iBLBzU9Q4A+UYsXUpIdFEqGjMFLDUmNT4C2vQ3
 iR99G768iYeE8=
X-Gm-Gg: Acq92OE+oChPq5jb9gxW+ObilEmbYMFizgkrn+FqORnVcXLX4lLjrHpTzqBLCR/tqe+
 LIWwGsywClnsae/8Kzh50wwmUOWee15n6qWvJamzpGBO0cj7wA7tJLie5C/QkNh4x/jh+p2JsaZ
 K5+tsAXjYHzhJZa+Uzx+OklOT+G2KqK9lSrF3pxkx87lQCB0+yvSHNvQBRmCGT5nGE9oYAqCqlS
 lk2eDuXE38veO/saUHycHvwa5qR+oizFS+T4WLWGsiPdvOGoxvnPGvgJNOX+nJsoqcp1oabCSRN
 0VIXTa30qKAQ4eFR6CpOsSzLBEZQEJGx3yFGuyRmw8qAbAgjsANGyAttqYwWufXscKUT03ethLp
 9m1GQcf7mzM72OrK42bVObJQA4f4mhFTAsysEiOPey2xQuavMPBfft1RHUKODuS0TLy0=
X-Received: by 2002:a05:600c:b43:b0:490:3d62:f5df with SMTP id
 5b1f17b1804b1-4922ff9b6c4mr37502665e9.30.1781606731097; 
 Tue, 16 Jun 2026 03:45:31 -0700 (PDT)
X-Received: by 2002:a05:600c:b43:b0:490:3d62:f5df with SMTP id
 5b1f17b1804b1-4922ff9b6c4mr37502225e9.30.1781606730460; 
 Tue, 16 Jun 2026 03:45:30 -0700 (PDT)
Received: from localhost.localdomain (77-236-28-43.static.play.pl.
 [77.236.28.43]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa47da9sm82502645e9.5.2026.06.16.03.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:45:30 -0700 (PDT)
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Date: Tue, 16 Jun 2026 12:45:21 +0200
Message-Id: <20260616104521.1545053-1-robert.malz@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1781606731;
 bh=ZMRFP/cIVcQkBD7AO9h8BoH0UYB8ekkkeuemaA4KQl0=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=Rbw2tc4DIlXsF9zn2gwPFYzTtd/7SGn12gLirtZrJL5ihJ61tFxZmRbVmTH4KkGyy
 KUDM9XF1azoKaXhTinJyX1o9sk28BOzhHTKk5UEs6cSvSITXN5dN547t0Shb9f5YJh
 o5AvXLeD/fa7LmDtzO8jbvQ65Wdp+ytINv8sm6q0WE+S1izugLq2oBfcAFgiY/WjcX
 X9Ch+4i5I8lVn6EdyZDxVMDfm7kPYSpRPugn214SmJNoAm/9VhsB7qWG345MLBM5Ld
 NsN/VLbAmhlW2EQV2LW0/PnHUzEQighPmFzuk1iyacFVCliX1VQqqtezZ2RzdbH6LN
 arb5YKkivGg5GSQmoQPjh5HXYEIUuLcrKD8Ydg/keUBosUQRT9ir5cXdlmgiHc7Z+A
 HAR4tcmvKHExEzWODmiJJM3MZjrYFcJrB/Cja5g831iUOE4ndtbau/pkT+TSdMbFgL
 erRV/oFizzFhuFMM5kE4UnCIajAFaeINzqbNETWQqqB9EjzHxA5891a9UHoph5Zyz/
 Nczv9Tbx3vt0tcryZbRdTmexRnxvuHnl0CFlbGSZAJtmYLKrhBQ4nt5wAauvt5AUBW
 mRYWqVNR3mtJOBz92C3u89ASwOz2kJb0Mm1qQLRjZkcd+PnZfjvmQV7f2pdD26n7wE
 BXinWt7LAkUnobYmBR7T0YMA=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=Rbw2tc4D
Subject: [Intel-wired-lan] [PATCH] ice: retry reading NVM if admin queue
 returns EBUSY
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
From: Robert Malz via Intel-wired-lan <intel-wired-lan@osuosl.org>
Reply-To: Robert Malz <robert.malz@canonical.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

When the admin queue command to read NVM returns EBUSY, the driver
currently treats it as a fatal error and aborts the entire read
operation. This can cause spurious NVM read failures during periods of
high firmware activity.

Add retry logic to ice_read_flat_nvm() that handles EBUSY responses
from the admin queue. When an EBUSY error is encountered, release the
NVM resource lock, wait for ICE_SQ_SEND_DELAY_TIME_MS, re-acquire it,
and retry the failed read. The retry is attempted up to
ICE_SQ_SEND_MAX_EXECUTE times before giving up.

Code was extracted from OOT ice driver 1.15.4 release. Additional
change was made to reset last_cmd in case of retry to make sure that
all commands are retried properly.

Fixes: e94509906d6b ("ice: create function to read a section of the NVM and Shadow RAM")
Signed-off-by: Robert Malz <robert.malz@canonical.com>
---
 drivers/net/ethernet/intel/ice/ice_nvm.c | 25 +++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c b/drivers/net/ethernet/intel/ice/ice_nvm.c
index 7e187a804dfa..cbe21ef9d18e 100644
--- a/drivers/net/ethernet/intel/ice/ice_nvm.c
+++ b/drivers/net/ethernet/intel/ice/ice_nvm.c
@@ -67,6 +67,7 @@ ice_read_flat_nvm(struct ice_hw *hw, u32 offset, u32 *length, u8 *data,
 {
 	u32 inlen = *length;
 	u32 bytes_read = 0;
+	int retry_cnt = 0;
 	bool last_cmd;
 	int status;
 
@@ -96,11 +97,25 @@ ice_read_flat_nvm(struct ice_hw *hw, u32 offset, u32 *length, u8 *data,
 					 offset, read_size,
 					 data + bytes_read, last_cmd,
 					 read_shadow_ram, NULL);
-		if (status)
-			break;
-
-		bytes_read += read_size;
-		offset += read_size;
+		if (status) {
+			if (hw->adminq.sq_last_status != ICE_AQ_RC_EBUSY ||
+			    retry_cnt > ICE_SQ_SEND_MAX_EXECUTE)
+				break;
+			ice_debug(hw, ICE_DBG_NVM,
+				  "NVM read EBUSY error, retry %d\n",
+				  retry_cnt + 1);
+			last_cmd = false;
+			ice_release_nvm(hw);
+			msleep(ICE_SQ_SEND_DELAY_TIME_MS);
+			status = ice_acquire_nvm(hw, ICE_RES_READ);
+			if (status)
+				break;
+			retry_cnt++;
+		} else {
+			bytes_read += read_size;
+			offset += read_size;
+			retry_cnt = 0;
+		}
 	} while (!last_cmd);
 
 	*length = bytes_read;
-- 
2.34.1

