Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C80F1C5AD55
	for <intel-wired-lan@archiver.kernel.org>; Tue, 11 Aug 2026 05:08:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 799F580E51;
	Tue, 11 Aug 2026 05:08:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uvH06D0w1zOV; Tue, 11 Aug 2026 05:08:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B426580E69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786424905;
	bh=tZtc/eD52PoJvgCx24yZu3Y7VDOIu1uYZlUVL1bHOF0=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=81ZPKzp6ELWhDmUy3kIo+eyae93cQbAx0/CTztL+eNZjaWPPn2NoieGSjlBUfiqt+
	 ltLzTCtNcwwSwjYTKGDgjTJcvZa11US49EH6TgnbL8lMSS8lAcMH0evB1ILZp9qd0N
	 5kfjs+F2H3PoGtc2gdU2P99ZfSqxwbgMnTKrpmX3mprCN8cuF8TYmapYZo3GjtYCEq
	 7NkWEo/4dGMpjiMIgTA2WtwAu/+3xXSGR4ib3mC3NzUOi3T0A6gqbLMkwv4vd/m5Z1
	 daJLe1B8aOLpC/ntDNZSnQDWBy7yPvHnAlYB+cVgTZaOat/yDlZ9eD5T6CgZRDqtig
	 NBOUENmN+AEDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B426580E69;
	Tue, 11 Aug 2026 05:08:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 80C4040A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 11 Aug 2026 05:08:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5E51740714
 for <intel-wired-lan@lists.osuosl.org>; Tue, 11 Aug 2026 05:08:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H3Gq0km8HeGw for <intel-wired-lan@lists.osuosl.org>;
 Tue, 11 Aug 2026 05:08:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com;
 envelope-from=malathi.a2000@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9761F4070C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9761F4070C
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9761F4070C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 11 Aug 2026 05:08:23 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-381c51fde6bso3191563a91.2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 22:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786424903; x=1787029703;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tZtc/eD52PoJvgCx24yZu3Y7VDOIu1uYZlUVL1bHOF0=;
 b=ps/yem4aJYbRVqLpbPcSLyMugQA72ywiBmV50wo25UgiJ45/TSuJ3jVzb5EjnGT4MO
 /PKpClpYcu03u+pqlPexeSprbENbF9Qg8S+nF0VaxH5logozXt6mav6pjJiDxitnGCJH
 8DXBSdHxZRijKnxxjp5oxvZ7PmGh8KmuXJX/eGsdkbjUAApb+CIv/yzyZOuZ4Wey8tZS
 aDEos81zXyUj3jzLuzE4GB2dpeXQqeC+EHqguFdgx2Kwe4aKCVNgxZ1pED8N0qymk9uW
 sH/Hpmj9yWrwV/pqI7Z9fq7p7+6YQnVIBXG6kiJA7CPOcAWptHmSMIjgg4q7mPGk2BVs
 P0Lg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqLm8OitJ7GghRQ1fr2bjf6peFAekvwJkDUHGoWpn329iNuL0mbOz5U6VeWVhjz21MyGzQ3K22MR/umxayJFt0=@lists.osuosl.org
X-Gm-Message-State: AOJu0Yxz//Axo0Yd9wYmk4KS+mgyWhNHhXqjKfvVt3tHnYzGfEk9x2io
 iLBuv29yktvl4L5NeidgeDTqFy/qmXjYosk+zlNrKFMVtOj/TwOCd5BH
X-Gm-Gg: AR+sD13ADlZKNCXyb9UDtTrbtt0+WmqtxqWEYrk0fhqaTLRFNzeaSDBF0YdSATIWhzl
 MX+KOC4VKNBZhmZ+j/1MVO31A2sRREu22dY6n7WQUvcaQuBo6kJuwnzSBOq6mxSh9vPBKsSIKDf
 xlrSTzq8SEIhr1i52GGOX1skL+kV1XtKwgayr6enLrlBfztTH28hbuzjcbD14j/r8ijPHME5Bdl
 FoaT48PccdffTEvO0q6QhsxKCiozMd5buFfkQD9hLpQ4L6ztpzM1SLbWBFimSqruLDwceH36d2M
 0kRcNP1CWMTlCraWVggrT+LottTsGdNhZ4XHylFKSt9HdrP1eajUcKnK8WP6m3JLIvS5BxrTs75
 /fmTv+AECSurxiwdab2L9idnjRe2nhTWXZXXAjavDUEUan+B+qHsJmr8zUq4N86Fvlx+S1E13Jj
 kBVeXuHtFdI4pxonE7MB/5CC7igRqNtcpDhbQ/OHXykOXQ+VC3dB2zHN3ZXejBOo+HwC1w+SB9z
 AsMiFcdd74l2wt8RGgLbrzhx1rXNR1nMQLDqg==
X-Received: by 2002:a17:90b:3c84:b0:38e:9045:babe with SMTP id
 98e67ed59e1d1-392ec5068a1mr800863a91.7.1786424902737; 
 Mon, 10 Aug 2026 22:08:22 -0700 (PDT)
Received: from amd.ban-spse ([165.204.217.251])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14120443418sm1389450c88.12.2026.08.10.22.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 22:08:22 -0700 (PDT)
From: Malathi <malathi.a2000@gmail.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, linux-kernel@vger.kernel.org,
 Malathi <malathi.a2000@gmail.com>,
 syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
Date: Tue, 11 Aug 2026 05:07:53 +0000
Message-ID: <20260811050753.234931-1-malathi.a2000@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786424903; x=1787029703; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tZtc/eD52PoJvgCx24yZu3Y7VDOIu1uYZlUVL1bHOF0=;
 b=rRCRw4Q9IGQYa6G0H8oljRAII3Pvw4b4Bya9VsQFXNDr75Jqjha7ndCRgUZ76GVZoS
 c7ZLYzNDuNJ1BluBDnKkZqCIFVQgOZVl63z5g3A9l2EVFg8FdeOPUNPnR9NLSfMVB3a+
 V1IVQbW3NOO2MyjTcci+6NmS+zr/DFYHwpiCrRzblAHBDGNeRTxcxAXZsivKIJFDt4ET
 Ix1fLWS/Onob5SidT7mz4NQsBL/MJ3tqZGcgqyiluiU+mmrPsGn3K1QIOc1LCB+akKVm
 GqOnliAuAdC5trWT5k3iIzrgBcWgNKw8Oo65MfhDP6mP4lUgEbSjqPhd3Tp+CzIhQNiQ
 crpA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=rRCRw4Q9
Subject: [Intel-wired-lan] [PATCH net-next v2] e100: fix shift-out-of-bounds
 in e100_eeprom_load()
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

e100_eeprom_load() and e100_eeprom_save() start with an address length
of 8 and call e100_eeprom_read() to auto-detect the real EEPROM address
length. e100_eeprom_read() adjusts the length with

	*addr_len -= (i - 16);

based on when the EEPROM drives a dummy zero onto EEDO. A malfunctioning
or emulated device that drives EEDO low too early makes (i - 16) exceed
the current length, underflowing the u16 addr_len to a large value such
as 65529.

That value is then used as a shift count:

	nic->eeprom_wc = 1 << addr_len;

which is undefined behaviour and additionally overflows the fixed-size
nic->eeprom[256] cache.

  UBSAN: shift-out-of-bounds in drivers/net/ethernet/intel/e100.c:768:21
  shift exponent 65529 is too large for 32-bit type 'int'

The same corrupted addr_len is also fed back into e100_eeprom_read() for
every subsequent word, where it is used as a shift count again:

	cmd_addr_data = ((op_read << *addr_len) | addr) << 16;

so validating the length only once at the caller is not enough.

Clamp the length in e100_eeprom_read() so the subtraction can never
underflow the u16, and reject a zero or out-of-range length in
e100_eeprom_load() and e100_eeprom_save() before using it. The EEPROM
cache holds at most 256 words, so a valid address length is in [1, 8].

Reported-by: syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e0abb1d45ac291ebebeb
Signed-off-by: Malathi <malathi.a2000@gmail.com>
---
v2:
 - Drop the Fixes: tag and retarget to net-next; the underflow is only
   reachable with malfunctioning or emulated hardware, so this is a
   hardening change and not stable material.
 - Clamp addr_len inside e100_eeprom_read() so the auto-detect
   subtraction can never underflow the u16.  The corrupted length was
   otherwise reused as a shift count for every subsequent word, so
   validating it only once at the callers (as in v1) was not enough.
 - Also reject a zero address length in e100_eeprom_load() and
   e100_eeprom_save().

 drivers/net/ethernet/intel/e100.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 29960762e64a..26a7c0aaa6e2 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -744,7 +744,12 @@ static __le16 e100_eeprom_read(struct nic *nic, u16 *addr_len, u16 addr)
 		 * complete address.  Use this to adjust addr_len. */
 		ctrl = ioread8(&nic->csr->eeprom_ctrl_lo);
 		if (!(ctrl & eedo) && i > 16) {
-			*addr_len -= (i - 16);
+			u16 len = i - 16;
+
+			if (len > *addr_len)
+				*addr_len = 0;
+			else
+				*addr_len -= len;
 			i = 17;
 		}
 
@@ -765,6 +770,11 @@ static int e100_eeprom_load(struct nic *nic)
 
 	/* Try reading with an 8-bit addr len to discover actual addr len */
 	e100_eeprom_read(nic, &addr_len, 0);
+	if (!addr_len || addr_len > 8) {
+		netif_err(nic, probe, nic->netdev,
+			  "invalid EEPROM address length %u\n", addr_len);
+		return -EINVAL;
+	}
 	nic->eeprom_wc = 1 << addr_len;
 
 	for (addr = 0; addr < nic->eeprom_wc; addr++) {
@@ -791,6 +801,11 @@ static int e100_eeprom_save(struct nic *nic, u16 start, u16 count)
 
 	/* Try reading with an 8-bit addr len to discover actual addr len */
 	e100_eeprom_read(nic, &addr_len, 0);
+	if (!addr_len || addr_len > 8) {
+		netif_err(nic, probe, nic->netdev,
+			  "invalid EEPROM address length %u\n", addr_len);
+		return -EINVAL;
+	}
 	nic->eeprom_wc = 1 << addr_len;
 
 	if (start + count >= nic->eeprom_wc)
-- 
2.43.0

