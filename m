Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FCBC982CF
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Sep 2026 11:55:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5911B80F97;
	Thu, 17 Sep 2026 11:55:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zru0OZi2P9LB; Thu, 17 Sep 2026 11:55:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 786B680F9E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789646140;
	b=WwCh94UMZcro8yy0GPgop2fVz8g1UpepsdxoxMDJefgd/qDgClF+CzxmgIIaQzRQ+4az
	 ofuq1GyyuIoDWM53UWnXt28lem9MdUz23uob+83p5LZ9NhtP/+V22CEtyutiJZE2Lb2Ln
	 DOclqwgAnS0YCGN9vnlX7CoUCJoJDfCuyJKUTe06o5e2WsZgkgPkuoJfhQmUx63KtqnpK
	 wiEtUAjtITVs7MEXlfQvswnI5s0ASlFQVKHWhuguPUPmMbfB7Hy7kaCfx613BhaYTIhwL
	 qE7f3XnnKbQr3wASUk9hyGGMZ36huMsMLmwud9AD6l3RXkzrPHCQz68XrVxDVH2hybg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789646140;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=s9qKYNc97ZRCTEGg6bKz2qHXyTBZBA/5/Nj/f2XJWcM=;
	b=Dwp/ia202NVG6wqTUIqZewZ3sbDpjAjrAOfAt7gJFtf1KCzz42SAOF+SyKeCzaBRk3Jp
	 NpCgfg7JdCVTURNXu/khM25ZWsV1iuuka2HM39tBKMC3NtDMBjTfk0RHxm5uZIZsthEb9
	 JwIOWTPVI8dCn/ErFVqo/EJ0+hFUyW33rlwb1EYHznxtZoT6BOheyZa9Q4Xm6JEvH2TOJ
	 4XYv7EfzyvZon50wI/XfrtxrBjWMUV+G35c9UbObmpoXOdpwl8CjRI0+nsbyJCLGETC1/
	 vikDFepfU9K/08xvDNIUTMWisYkBd4NNFmqgr6NIgK5UYhy8rP7/tcPsopWeSQuJtTA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=Tjy9jsK6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789646140;
	bh=s9qKYNc97ZRCTEGg6bKz2qHXyTBZBA/5/Nj/f2XJWcM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Q7dzllKYPVU9xQwflw68rvfMPCe5IsDiszX1xIVBWTpxQn3GqhfSrREjPm2IQo002
	 XHKAIEgRSS2ahKGx6iXTBIz5XaajBnvcTaAlcCc0e2Qwtpuy6o/no8ljfRBckkGteQ
	 lWzv8JJkWXiHcrMVfnTmsPFfE3pZD60RnDD1uG8ik4jP2fVnlC/VIKIAChbmCOUFIx
	 apzymzUzdcqPvdvW0WAakDrSYOfpkXU3NE8BZmzMwWbPJGPxJB6oDuc+/b2tlW1hqK
	 WeUl1J+Gn7IWlW5awFSkYXpFO5bOo4TqDGuebvj8A6Nw0LC6LRlmakYAN5haETc83B
	 g6erjN98+zdOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 786B680F9E;
	Thu, 17 Sep 2026 11:55:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E8EE524D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 11:55:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CEF2A80F9E
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 11:55:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TJpVJ-i921N8 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Sep 2026 11:55:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3DF1980F97
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=117.135.210.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789646137;
 b=h0Fqi47wMX+3gD4laiMpNvO2SLbsBTnFel5HGiRTp4ceoAJOe+WrAPq2dUT69e+NpbgJ
 1qB/z+c+p4vW0D4V0lE9gJua/EIhOWdBL2Fxpk5xLF6cs34XfMGgyqdTBQKhM7Cer3Xsc
 3X2mlepPIQclxa6c54KRxc6d182oXLH/BdKgcXbyY9U29sVqumG9VqH5M3Qntm49BlvIu
 ZBn+TYetSj7UAxepMwfhvw/g9gBamiTPU0aEg005fE6uI1/1wXXMaxYyL12F27Ofv+SLf
 wkAFEC1OJTCF9MOouelp1s4VP5H94ktbe7RGCy+lfR0DkbScVLGU44Kuh//nFcMfgSg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789646137;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
 bh=s9qKYNc97ZRCTEGg6bKz2qHXyTBZBA/5/Nj/f2XJWcM=;
 b=F8CZcyX9zwyorxtDIqD30H9i4LpVfjpKi3PiDy+HQdit471Sf5koZE+vngBgLVN34GMk
 t5IFgLRvg/UkBClv7zp5PlFCUoNvQjjCzGPbEFJQBqlnyzwhXfBK9Lai/vtLKqXtED3+C
 FUFjb8ClhH3SmvuqPGaxYGu1hIKLJjC2YwYZ0kyXQqQBqZQ9v7ga4m+/TaEdHLVfReF3O
 hDnlGWmuU8SkGo583QVBKymWnt12dG1v3x9CH/Hq+6hLSRoyobv6OURzwZ3rExyCmywxE
 oTmuH3pk3bLiyqZJGJELN95nsKjCIP9J3YeiYoh86VoP792eztLO00TNnVpkoluNxWg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=126.com; 
 dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=Tjy9jsK6; 
 arc=none smtp.remote-ip=117.135.210.9
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.9;
 helo=m16.mail.126.com; envelope-from=xiaolinkui@126.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=126.com header.i=@126.com
 header.a=rsa-sha256 header.s=s110527 header.b=Tjy9jsK6
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3DF1980F97
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 11:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=s9
 qKYNc97ZRCTEGg6bKz2qHXyTBZBA/5/Nj/f2XJWcM=; b=Tjy9jsK6QghTSUSg0P
 Z9aBHdRrDdEclmthhsRT9MieFmSmpbLxwcM4cQe63JpazbuvyhzUDWQKB90YPuCy
 EOEeXSA/a71JW4evSOjIZrjQObWcXhud2rMx7rfhyYHF3D8heMLzl+SJP0sdrO0I
 D2RDpgItVplLWuBu7p+EWa9rg=
Received: from localhost.localdomain (unknown [])
 by gzsmtp4 (Coremail) with SMTP id PykvCgCXHLgB1atquGrBHw--.64446S2;
 Thu, 17 Sep 2026 19:54:42 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [Intel-wired-lan] [PATCH net v2] ixgbe: fix incomplete ACI command
 buffer backup on retry
Date: Thu, 17 Sep 2026 19:54:39 +0800
Message-Id: <20260917115439.1323766-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PykvCgCXHLgB1atquGrBHw--.64446S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFy7XrWrurW3ArW8JrW5Wrg_yoW5Jr4DpF
 WruryfAFs5XFW09r97XayUXFWY93W0qrW5KrWSvan5ur18Ar4qvFyUtFy0ka48urWIqF1a
 qFZFkw4fC3WDJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UlPfdUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlAL60Wqr1QLJeQAA3b
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

ixgbe_aci_send_cmd() saves only the first byte of the caller's buffer
before an EBUSY retry, using kmalloc() plus a single-byte store. When
retries are exhausted, the caller's output buffer is filled with
uninitialized slab bytes, because only the first byte was saved before
the retry. The firmware itself does not see this data, since the
retryable opcodes do not set LIBIE_AQ_FLAG_RD, but the caller still
receives garbage in its output buffer.

Replace the kmalloc() plus single-byte store with kmemdup() so the whole
indirect command buffer is saved before an EBUSY retry, skip the backup
when buf_size is 0, and key the restore off buf_cpy instead of buf,
exactly like ice_sq_send_cmd_retry() already does.

Fixes: c9e563cae19e ("ixgbe: add support for devlink reload")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
V1: https://lore.kernel.org/all/20260912013403.2818191-1-xiaolinkui@126.com/

V2:
- reword the impact description: the firmware does not see the
  uninitialized slab bytes, only the caller's output buffer does, since
  the retryable opcodes do not set LIBIE_AQ_FLAG_RD (Sashiko)
- fix the ice function reference: the kmemdup()-based backup lives in
  ice_sq_send_cmd_retry(), not ice_sq_send_cmd() (Sashiko)

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

