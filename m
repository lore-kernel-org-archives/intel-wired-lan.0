Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A47C43458
	for <intel-wired-lan@archiver.kernel.org>; Mon,  6 Jul 2026 09:25:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2EF79402B3;
	Mon,  6 Jul 2026 09:25:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5jPG-I39UC6G; Mon,  6 Jul 2026 09:25:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8E37240A76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1783329919;
	bh=krTz+Y1P84eScbryMKCxZic6Jvk4kHzG+oyEobkFsa0=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=u7/Gi0C0jADa1lNcKIMbgxJsVPMasBowjOKP6EbO0gvH29oNmrUDbT0PBMimy49y8
	 8kKp/D7I7xS0HlXKtlUZU5HimHjDH7kbp1+A9/Vcwtnz5TGX+Sbm7m5TKYBvNQ1G0z
	 YkRvSnLRvJIoozE/22LljTXxqhMztWIWR09zhKWSJaU4j54kicDMbyZD0phUxk13uv
	 77OAV2puAV+uF4xHk/1utW5ZJMCohXlN/4EVCdACkefqoT/syT9ufSQyR5sTKoCslR
	 1hpDKmZRaB/+VEr3xIfxujN1tnNATp59REq+lFAwe6iIEitNO1k1n6p7Q0HdpxnO/D
	 oZq+AHXp1+rcA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8E37240A76;
	Mon,  6 Jul 2026 09:25:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A925DF2
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Jul 2026 09:25:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9DE82608C6
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Jul 2026 09:25:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EwPZQHc9lN2w for <intel-wired-lan@lists.osuosl.org>;
 Mon,  6 Jul 2026 09:25:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=159.226.251.21;
 helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6E86E60635
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6E86E60635
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6E86E60635
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Jul 2026 09:25:12 +0000 (UTC)
Received: from localhost.localdomain (unknown [111.196.245.140])
 by APP-01 (Coremail) with SMTP id qwCowACHK9RudEtqxUvxBA--.35001S2;
 Mon, 06 Jul 2026 17:25:02 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon,  6 Jul 2026 17:25:00 +0800
Message-ID: <20260706092500.79044-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACHK9RudEtqxUvxBA--.35001S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Gw15Gry8Kw17JF18KryxGrg_yoW8JF18pF
 48Ga4fWr45XrW3WF4xXw4rZFZxuayI9r4fWF9ayw4rAF4q9rWUCanxKa47tw1UAr4UWr1S
 vF15Aws5A3WfXFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
 CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
 Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
 0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
 zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr
 1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
 JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
 BIdaVFxhVjvjDU0xZFpf9x0JUDOz3UUUUU=
X-Originating-IP: [111.196.245.140]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=iscas.ac.cn
Subject: [Intel-wired-lan] [PATCH] ixgbe: validate E610 PFA TLV bounds
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

ixgbe_get_pfa_module_tlv() walks E610 PFA TLV records stored in
EEPROM.

Stop parsing malformed TLVs whose header or declared value length would
exceed the PFA boundary.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 4d8ae5b56145..03e88bdf5a43 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -3895,6 +3895,9 @@ static int ixgbe_get_pfa_module_tlv(struct ixgbe_hw *hw, u16 *module_tlv,
 	while (next_tlv < pfa_end_ptr) {
 		u16 tlv_sub_module_type, tlv_len;
 
+		if (pfa_end_ptr - next_tlv < 2)
+			break;
+
 		/* Read TLV type */
 		err = ixgbe_read_ee_aci_e610(hw, next_tlv,
 					     &tlv_sub_module_type);
@@ -3917,6 +3920,9 @@ static int ixgbe_get_pfa_module_tlv(struct ixgbe_hw *hw, u16 *module_tlv,
 		/* Check next TLV, i.e. current TLV pointer + length + 2 words
 		 * (for current TLV's type and length).
 		 */
+		if (tlv_len > pfa_end_ptr - next_tlv - 2)
+			break;
+
 		next_tlv = next_tlv + tlv_len + 2;
 	}
 	/* Module does not exist */
-- 
2.43.0

