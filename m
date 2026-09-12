Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACF8C88E72
	for <intel-wired-lan@archiver.kernel.org>; Mon, 14 Sep 2026 15:25:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E28A606E0;
	Mon, 14 Sep 2026 15:25:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZamT3OCRlo3c; Mon, 14 Sep 2026 15:25:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 19E3B605DE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789399544;
	b=LxW4D9X98Z7QcLw0Bbu1Cy1FDTQvCYpNSnhswDFWV8thWbpIsmRmjEiBUBY0Bn+XpqtE
	 73L61T11kYlBQO3g5a9Pwh8NLaPdOIj4NZPuHhwIlwAIq6wJXzlUaMEWekE2VWbfpvU8X
	 lWfvmzKCd+aCGBFYMd+9r5mG0yaaWwfEQq9jRHL2jid+8IwCiS0CKcgzgmSj1xOo6miD7
	 MUrGC0U4WONwWrbQKB8vTkirGJQTIQZKqE5pa3g/psbcjBiLyw1r8aURVWYj+iQYLCuyX
	 lf+ej524tzEhdt73R/HCoIj0aKP3Sy4ExTAzECPn4ABgElfE0fJCEgwUwe7O/t7xvzA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789399544;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=o78Hqq6g/lBoilGmoy0z1ftAj0h9kvkoIITlXb/oArQ=;
	b=AUtovabb4bNXekwB6obrcrFkNBYBjeNRG6pDlAtC++eHagM8Lh8C7ssBAaosQPhAZd/I
	 Zup6B/2n1wjvMe3GyEtIvbnaebXdC1v5wN9WzSX7EiLNRlVyBWid6Rum4MMOYBoelSU1M
	 XLoxxf6m9EKw7UvG9gmLpFaJ23CPLIhn170iW+qsr40Wc0owaFEb+1+EuIECGks/pYlyv
	 0+b29ocrhPL6iZXW78y4CQfSz/t9b1ybnJlpnUXw0C80x1ukr6q1JxOi2NSAQFkOvkTo3
	 ZDeygYhlm+0IlW4eQQ4+grYC6fZ9TcbNujl7MqDfIRH68HNvixkhxSNYbZAfzNkN/5A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789399544;
	bh=o78Hqq6g/lBoilGmoy0z1ftAj0h9kvkoIITlXb/oArQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=s1MDFf/k8alwD8TNI1n1a0B4OveDJH09WwXDFba3xekHqDonuETNzurlCH77VeSYB
	 3Ry/5dpjpxP56X04xQ7u6WTSWVcH9LkAAF85XFK7mLBcfePVak3agLE8shWJi4GXGc
	 wH3RMfJjeZzdIFKJZMN6VCJTOYQulZJ+x2FzgLYT+9rLtXzQcKNbjC7dc/wXk83tEH
	 7NUsYn5hrnQNsDFZnxQBFEvSSsihN/tpnhpZoF9LAbFY9+sz41DFmhPPnYWzrafIGH
	 Gmhz/Rw0hMRWcYDqgBOuYVp+gWawfIokpkJ/y3VrpjENaOGXeDY1Nn/oC/eq4sHtr+
	 McbxzcOVB+j2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 19E3B605DE;
	Mon, 14 Sep 2026 15:25:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 005577AB
 for <intel-wired-lan@lists.osuosl.org>; Sat, 12 Sep 2026 01:41:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DA95E407F4
 for <intel-wired-lan@lists.osuosl.org>; Sat, 12 Sep 2026 01:41:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hQ-7fHcQr9Fe for <intel-wired-lan@lists.osuosl.org>;
 Sat, 12 Sep 2026 01:41:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6BF80407C5
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=117.135.210.7
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789177293;
 b=fDl4wTnV0J3N5kp6j8Cc124bdll+yR2J5QPHFgRIQVRAk9Omlszj0hav3mEybt4F+IF6
 tvNZBArF9x7A+pOF7n2fThIQie8XnXVOQXP2Njgyxkid7GIn+GIEvGjeMd1zRtsq1cuJ7
 vJuLAv2Tx1BN5dhWvA5D5E4AZeo/H5QlfmzxqsqqpdroWUbTnZqLcn/cjIZtqpKJn1TW6
 3IF6NPXJkwSw7V95a6E8XZyvMSpX+IxoFUuUmlpDZHF8rJ+RlK3v3rI7yt0gG+nbbxSbX
 zVCxBbjwcDyuXwxfJh3CRzKfB5JByv+xzuUvHRZfWlhu+MxtK5bZmWEkQO3OpxMqPnA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789177293;
 h=X-Greylist:Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
 bh=o78Hqq6g/lBoilGmoy0z1ftAj0h9kvkoIITlXb/oArQ=;
 b=Itz+EFfEOWpmf7cz6ukh0avrEky3Yux2TXiHGnw3+mIb5ZraZDdztDzlaF3gF1C9SGkw
 nBnkXn5FdZK8pNozbwgNZEhRWX7DQ8LbmI/z8XiqH0a4X9kcWvUHc6GbML+CA5EKlvoMs
 4rPfUCYQGy511loS+FQ4wpUpls+u2MFRrwR3q0TDGBXE7pHjRvEEIcRdAyLGvQE0m0PFY
 Yf7bfRKrv6GhRyHwPdmZfYDvz2syo9CMKkTV4I9xT8ubcz8mwtXxq2dAwzz5qj4Vi8jKE
 ZBl6vf2adanYl23BWT+/w3Qq3QQHuI7Yvd8X6W6skjYe1H2sIElpphYm6tyuUnmxqdA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=126.com; 
 dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=oLXTLqak; 
 arc=none smtp.remote-ip=117.135.210.7
X-Greylist: delayed 248 seconds by postgrey-1.37 at util1.osuosl.org;
 Sat, 12 Sep 2026 01:41:32 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=oLXTLqak
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.7;
 helo=m16.mail.126.com; envelope-from=xiaolinkui@126.com; receiver=<UNKNOWN> 
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6BF80407C5
 for <intel-wired-lan@lists.osuosl.org>; Sat, 12 Sep 2026 01:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=o7
 8Hqq6g/lBoilGmoy0z1ftAj0h9kvkoIITlXb/oArQ=; b=oLXTLqak803ESVHVfL
 y6pGU8lgTI2EFLofFcZRV0vIm8PIQhsuB9rfx95OZ97ZOLl8t7PH1Hn3U6X0Y4xZ
 rjebZb7KjWysXSMRKIk2Iq34s6P7DBl5Xq33xVGhOtRQNpObeQhSBPPxN6wgo8NS
 RiIV4b6zmwfAZDYFOXxMIsxhc=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id
 _____wD3n3IMrKRqxdEPBA--.2642S2; 
 Sat, 12 Sep 2026 09:34:04 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [PATCH] ixgbe: fix incomplete ACI command buffer backup on retry
Date: Sat, 12 Sep 2026 09:34:03 +0800
Message-Id: <20260912013403.2818191-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3n3IMrKRqxdEPBA--.2642S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFW8Ww4rKryfZryUKFy8Xwb_yoW8trWfpF
 4rWF93AF4kXr4rurn2vw48XFWY93WIqrZ8K3ySvws5uw10yr1qgFyUK3W0kry8urWfXryS
 qFsF9w43Ja13J3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ULFxUUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqQzxyGqkrAzCRgAA32
X-Mailman-Approved-At: Mon, 14 Sep 2026 15:25:43 +0000
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

From: Linkui Xiao <xiaolinkui@kylinos.cn>

ixgbe_aci_send_cmd() backs up the indirect command buffer so that it can
be restored before an EBUSY retry, but the backup only copies the very
first byte of it:

    buf_cpy = kmalloc(buf_size, GFP_KERNEL);
    ...
    *buf_cpy = *(u8 *)buf;

while the restore path copies the full buffer back out of it:

    if (buf)
        memcpy(buf, buf_cpy, buf_size);

So every retry hands the firmware a buffer whose content, apart from the
first byte, is uninitialized slab memory, and on a read command the
caller's buffer is overwritten with that garbage when the retry finally
gives up. The buffer of a read command is an output buffer, so the caller
does not initialize it either.

Use kmemdup() to copy the whole buffer, exactly like the equivalent
ice_sq_send_cmd() already does.

Also skip the backup when buf_size is 0. kmalloc(0) returns
ZERO_SIZE_PTR and the single byte store above would write to it, and
restore based on buf_cpy instead of buf so that this case never passes
ZERO_SIZE_PTR to memcpy().

Fixes: 46761fd52a88 ("ixgbe: Add support for E610 FW Admin Command Interface")
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 4d8ae5b56145..5dd88ee7ea58 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -214,11 +214,10 @@ int ixgbe_aci_send_cmd(struct ixgbe_hw *hw, struct libie_aq_desc *desc,
 
 	is_cmd_for_retry = ixgbe_should_retry_aci_send_cmd_execute(opcode);
 	if (is_cmd_for_retry) {
-		if (buf) {
-			buf_cpy = kmalloc(buf_size, GFP_KERNEL);
+		if (buf && buf_size) {
+			buf_cpy = kmemdup(buf, buf_size, GFP_KERNEL);
 			if (!buf_cpy)
 				return -ENOMEM;
-			*buf_cpy = *(u8 *)buf;
 		}
 		desc_cpy = *desc;
 	}
@@ -234,7 +233,7 @@ int ixgbe_aci_send_cmd(struct ixgbe_hw *hw, struct libie_aq_desc *desc,
 		    last_status != LIBIE_AQ_RC_EBUSY)
 			break;
 
-		if (buf)
+		if (buf_cpy)
 			memcpy(buf, buf_cpy, buf_size);
 		*desc = desc_cpy;
 
-- 
2.25.1

