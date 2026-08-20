Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C569C5DF81
	for <intel-wired-lan@archiver.kernel.org>; Thu, 20 Aug 2026 09:41:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2176B809A4;
	Thu, 20 Aug 2026 09:41:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CPc_48YrjpjL; Thu, 20 Aug 2026 09:41:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787218862;
	bh=yF1JbB5R/FVZprSXPu19zqoBb23lz+r7CLHDK21Q7Ng=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=9nwil3+hwZ2e+mBq/RYb68044kQ2vqvZIkvw/1aWEpe8d9ITHbpCzORLTbrqxEnJR
	 Et1Xp8AaHd1d0Cy1uKo1uZoF6aNj69upLQrOc3oJTdrO3drxB9ONX5T4yLmjwwcb+s
	 cgL/XAFgpbCPNO/MzNgRYA9QeCWoczSppe1bRJ0HyycTc/HrPHdbMbf8RcZxBM7TiH
	 X3LLDKIQBJXF00YVuuYW1sNus8V3GDP3RwjL9lYbNRkLjGPsh0QlO1vbD4v3NpoYgP
	 guFP987WtcZnviSbr/uBvJ//REDMrGzmtBiYt55Yl721vmNHUdFX7I5Sp3qlrZ9zcg
	 cAkA+5hEykyGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 588D980ADE;
	Thu, 20 Aug 2026 09:41:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D5312FD
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Aug 2026 09:41:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8ADBE80ADE
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Aug 2026 09:41:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dcctxllwJmFM for <intel-wired-lan@lists.osuosl.org>;
 Thu, 20 Aug 2026 09:40:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com;
 envelope-from=pavankumaryalagada@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=B2EW1piA
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AF95C809A4
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Aug 2026 09:40:58 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3811f512167so2841571a91.3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Aug 2026 02:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787218858; x=1787823658; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yF1JbB5R/FVZprSXPu19zqoBb23lz+r7CLHDK21Q7Ng=;
 b=B2EW1piA2dxXTz8iISIR12OvJ2c3nWpd/SpKYNkKkR6yAC0M8qMgS8z65uO7pMekWj
 W9fG4ttSF55uW2aWonY2uVWGlKLJp0foCkwCvxO+hYDIZMPnyxjEW+vOt/EO/7Y4BMIh
 Q/Q2kE8WjROGvQ3ekFn58syx0qE8SRhh8EuTWZxSNpZkTTG0h6yxRVgIhuUgL8FeWHK3
 kheg/wJ6sd7ywDpm9W6Jzrw2y97CqASST0NdOhEwDjT6qnH+hd+qHgkoZq58p02mAfSf
 XadvaA70lfLZk0JvdYoSUeguW/DlahfPLfBrvLydVj/gm93oGkWQggz7b8hKMat+sRDl
 sw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787218858; x=1787823658;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yF1JbB5R/FVZprSXPu19zqoBb23lz+r7CLHDK21Q7Ng=;
 b=atzkHE9pgpAkG1uZ+SYZwWWTWqbCKbVAHoPNZd8jMQhPrhynvFWRsAO3XsQMv540cW
 7SVkn6sr4PEB4LvB9uPkqJ1+9Mg8PWkMgiMzc4k1u6EaSogrDGV4NJvupONoy1+NYQJi
 R8luZwnfIUn7/+ohyU9ojZVmWKFBqQGEC8UrimXEcl7+13YrWn6oCUIEI1/Q58aPR223
 kX3UUOPdzTC2lgRjW24o/UZYvl3MQJRX4qabOKXtlrDDo7HxQQ14PIVXeT9D0rZqgz8o
 db5ohARpDt3M6ROYkZQ43NgL/HFSJXwfo4yd8pEEOT8oKHkyQRsnTvLKrXYoMW8lQBQo
 dilg==
X-Gm-Message-State: AFuF++n7QC1KkzJr1gp9KmfYwtsv39iCveuA06wrAp7CUIR4UORO7ytM
 k/bYqH5WMmsYlvPc0gbDW6Nqh1B7adseaAA+dVqcYbmfY9jJs30IMcFx
X-Gm-Gg: AR+sD136EXhUfG8Gnat3pmrZRP0M3UkQFzxRIUQ/QNUVPCijGuk9dLFKo4MCYKcELMx
 ONt8w+2J/hJEr6WdU0PNsPMXnKbXm4bKxrwWDfVMDNg6d+8EtBTaypVQ27id5PTLwDVSDTIGfMl
 tmAnsZveof8POL/vylx9OL1JYXBTkG9w5PI8CZBK/J+g2j7Im0Zf+INaAE/KG1CrUeIMvyDlCOD
 P9ZEJe+TaR1z60Nt+j4Fud8mqm2pZK5Pluc8vqT79RTq/DMnrOYmWLXHIHXcok84Gi/5egG4zm5
 XJRNEkHWE2WyIsi5EomDI1uFjFtnxvnWBzUydz/Y36z9l39KWBBKm+ExG+uqhvPYoJSUAlBCH75
 kMHCLF8i3z1d4m6NCHao5mWJBs7PMamODO/qa2zaR/J+wiFMJpyh/KHsxyTNvdPgsaYqMhNT0Uy
 pWyM38AmvJ9mHOmzYBvwZZsjeOg46WbnfGAdJG029/brvkV/X2CZYyp/Zx7zMRa2W1jSCxCHTG8
 qQ0Cv3Y
X-Received: by 2002:a17:90b:4ac9:b0:37f:ed7e:7e42 with SMTP id
 98e67ed59e1d1-395810cad6amr20759699a91.14.1787218857689; 
 Thu, 20 Aug 2026 02:40:57 -0700 (PDT)
Received: from user.. ([2405:201:c052:b00b:6143:5a42:8472:2f21])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327cb5a9831sm8393939eec.21.2026.08.20.02.40.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 02:40:56 -0700 (PDT)
From: pavankumaryalagada@gmail.com
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com, kohei@enjuk.jp,
 aleksandr.loktionov@intel.com,
 Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
Subject: [PATCH iwl-next v4] e100: prevent shift-out-of-bounds in EEPROM access
Date: Thu, 20 Aug 2026 15:10:45 +0530
Message-ID: <20260820094045.41400-1-pavankumaryalagada@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>

When reading the EEPROM address length, e100_eeprom_read() can return
an invalid length. This value is then used as a shift count when
calculating eeprom_wc, resulting in a shift-out-of-bounds UBSAN warning.

Stop EEPROM address probing if the detected address length exceeds
the initial address length to prevent addr_len from underflowing.

Validate addr_len after reading it from the EEPROM in both
e100_eeprom_load() and e100_eeprom_save(), and return -EIO
if the value is zero or greater than 8.

Reported-by: syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e0abb1d45ac291ebebeb
Signed-off-by: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
---

v4:
 - Squash the v1-v3 changes into a single standalone patch.
 - Prevent addr_len underflow during EEPROM probing.
 - Validate addr_len in e100_eeprom_load() and e100_eeprom_save().
 - Use BIT() and cast the result to u16 for eeprom_wc.
 - Target iwl-next as requested by Tony Nguyen.

v3: https://lore.kernel.org/all/20260816113754.22900-1-pavankumaryalagada@gmail.com/T/

v2: https://lore.kernel.org/all/20260810083355.21631-1-pavankumaryalagada@gmail.com/T/

v1: https://lore.kernel.org/all/20260807145626.52692-1-pavankumaryalagada@gmail.com/T/
---
 drivers/net/ethernet/intel/e100.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 29960762e64a..cd8190386652 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -744,7 +744,14 @@ static __le16 e100_eeprom_read(struct nic *nic, u16 *addr_len, u16 addr)
 		 * complete address.  Use this to adjust addr_len. */
 		ctrl = ioread8(&nic->csr->eeprom_ctrl_lo);
 		if (!(ctrl & eedo) && i > 16) {
-			*addr_len -= (i - 16);
+			u16 len = i - 16;
+
+			if (len > *addr_len) {
+				*addr_len = 0;
+				break;
+			}
+
+			*addr_len -= len;
 			i = 17;
 		}
 
@@ -765,7 +772,15 @@ static int e100_eeprom_load(struct nic *nic)
 
 	/* Try reading with an 8-bit addr len to discover actual addr len */
 	e100_eeprom_read(nic, &addr_len, 0);
-	nic->eeprom_wc = 1 << addr_len;
+
+	if (!addr_len || addr_len > 8) {
+		netif_err(nic, probe, nic->netdev,
+			  "Invalid EEPROM address length %u\n",
+			  addr_len);
+		return -EIO;
+	}
+
+	nic->eeprom_wc = (u16)BIT(addr_len);
 
 	for (addr = 0; addr < nic->eeprom_wc; addr++) {
 		nic->eeprom[addr] = e100_eeprom_read(nic, &addr_len, addr);
@@ -791,7 +806,15 @@ static int e100_eeprom_save(struct nic *nic, u16 start, u16 count)
 
 	/* Try reading with an 8-bit addr len to discover actual addr len */
 	e100_eeprom_read(nic, &addr_len, 0);
-	nic->eeprom_wc = 1 << addr_len;
+
+	if (!addr_len || addr_len > 8) {
+		netif_err(nic, probe, nic->netdev,
+			  "Invalid EEPROM address length %u\n",
+			  addr_len);
+		return -EIO;
+	}
+
+	nic->eeprom_wc = (u16)BIT(addr_len);
 
 	if (start + count >= nic->eeprom_wc)
 		return -EINVAL;
-- 
2.43.0

