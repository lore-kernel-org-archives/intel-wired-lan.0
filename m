Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1866C982D0
	for <intel-wired-lan@archiver.kernel.org>; Sun, 20 Sep 2026 06:33:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5B866605DA;
	Sun, 20 Sep 2026 06:33:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gfTsKZqW6Suf; Sun, 20 Sep 2026 06:33:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 85D5360609
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789886025;
	b=lf7TfQAUJFoI0i/nF6JF3JFWEaD3YYJ3lY36sszrFoIDKSNEkEcB77qg/3530Zr/RXYu
	 bCL33AFXqBqzKZ0HtfhY0oCfGgCm6F557fzC8Pzpg0ukgIR1hDNyRFyneea7iK4OR8exG
	 U2cXQwOIAdzBkg2i4SBWjVPBW7bcBHWsZhn2sh3iXq9WBnYq4dvtkx4LSR/bEHXZooTAZ
	 4VDVfGipphmTHiKuqdCH62j/zqAWJm3ie6KhxiZWTwifdg0haWsnicNzDhWmVHPfjZkyk
	 0tX9O2TftKPrRoGG8S7bV4Dr8c8V/s2ebCNrcfXXrJFu72x2gwgz6sKSihOrZQBtEKQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789886025;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XRrulCnqLsf892bb7iyH1RkNTddmsqrQPwO48USUCJ0=;
	b=M5pIxdXmTt8J4KGBVoLVlhcQgpk4K3CtADbdUQh11P8K5G480TnGD50MpYn8Sbz9SUcC
	 QNtteXK3x5IPJTz+NBsyU21oA3GoO3EuRV3S2SORKt7lY5KyOMrdbtDhB/JoCLwvBcu0p
	 Gk1yDb/9LNFoeTj+JjVc5oIF6NvD6p1JgEmmvXzaYJ7VkHWQNiHKRUQUX7rceLbGM5apS
	 HfkfQuDGbf7rHDYspGMvNx0ZnCTD/0cOQC0kE93I/W4U3Qa2+4dq0jbYdW8Oj4pFqBejw
	 cMAXzrrKgXkFRJ3Os3HAdYUAgNc21P4YsxaOYwlW90FEKLHq85l9titUGkHJLGOSk5g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789886025;
	bh=XRrulCnqLsf892bb7iyH1RkNTddmsqrQPwO48USUCJ0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vL+bUjVNw4LJUXY+Ml1H5YDeygUnf+gNI12Co6F8vnRo8LgsoCvkJ1SC2Hug2GnoS
	 lvNxpQrZi9HkKaWn4EnIr77uyCvhBBXFCfUux1Hdv+fc8wTwQJhgyujc9iN/X8cla1
	 gZTwuV3yzIHI4nzhNcmy1W+mADNKEmV5Gsj/r5kAoEo/mqpAWVAyceTqCZ3UNl6LzA
	 rNgWbhn3FdN+TEggbuuxsPvqhAtEWasoISrj/+nfNJox6BLAUrwxzELCk0jbKGmUOj
	 P+LEuX1D+QhdVje/3VPVbQXNMe8uTG9LUwgnaDSln3OTcq+Mscc/V4Cy+luEpE62l2
	 q8cIqjaJn50Tw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 85D5360609;
	Sun, 20 Sep 2026 06:33:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BFAFC3DD
 for <intel-wired-lan@lists.osuosl.org>; Sun, 20 Sep 2026 06:33:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B17B040811
 for <intel-wired-lan@lists.osuosl.org>; Sun, 20 Sep 2026 06:33:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oXaEnnYlpwJQ for <intel-wired-lan@lists.osuosl.org>;
 Sun, 20 Sep 2026 06:33:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 759D4407D0
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=117.135.210.7
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789886023;
 b=fYua8+uZkd2+jN48zTtfscc8U1zomfniZvM9RH7CA7Z4NSTAcDsCwNQjiHn/O/ThMai5
 HOiiqdUHnCQuMscQkYyG5WbNGAYf9lj1c6mp2uOHCYuaTvIwajNYpT6hFIRIVxDRhKG6p
 jWU6hP4EfZtdFSF/sAOzIbhYbx77C+1gVn6ATqjExtkoOUZfTXdywr94Uua/n9GTQw8Uc
 gavxh2BFE1S5/Zo2OiAXtlrRO1m3g31rPgL+4Ylc39q/4IeKgvpZecaIMFPWkqjaVC16Y
 0INHWecPC1X5ULrw8ADRWxALqspctSc25m/Km2sdFwoEbI8152sN32IFqHVh8XAju8Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789886023;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
 bh=XRrulCnqLsf892bb7iyH1RkNTddmsqrQPwO48USUCJ0=;
 b=h4TLJYKTGh2Aa7tMo8+06nK1SwO2q2/+zvlIrcGgnonXYq0JjDxx31HSBHTQgT3hrOE0
 MIVOWinmwex0k7IXuhwPIQcUdVEfGhTotu+j1l/4nFm0nx6uDMkYzQhWCE3hmABK69LoS
 R4JX6n3PClpFea0XBcjYPtHxXWUf3Bi5FTmahMzxDPXx20e0Fij1HaMbVimL9xq+yDTB+
 xvCRPHN8gtU01HvYPtd8v8vkm73bxrHutTrtGzIWgg0RsGXFdeRqE2r5DLed1tpVZTzhp
 4LkLqHZbt0yR+GbwPuf3pDs4Y3bXyrgYif3Ggrb2SZ639rantb4TUF2ovpQMm2zj5Ww==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=126.com; 
 dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=KSRL9z7d; 
 arc=none smtp.remote-ip=117.135.210.7
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.7;
 helo=m16.mail.126.com; envelope-from=xiaolinkui@126.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=KSRL9z7d
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 759D4407D0
 for <intel-wired-lan@lists.osuosl.org>; Sun, 20 Sep 2026 06:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=XR
 rulCnqLsf892bb7iyH1RkNTddmsqrQPwO48USUCJ0=; b=KSRL9z7dIwkqL8jO7k
 0uejCw19nGn2/4w0RFxjlQiypeR2CajanCJYENENoCTR3raTIPboRk5gFeA3DNlP
 zweitSXk1mxJXRA7te7mITJzCDqbWO2GtA41ftBYOAky1F8Zdw6lzwhBP1/rw9O2
 XDmv3hVjbg3WhGIWM1rlTAcBA=
Received: from localhost.localdomain (unknown [])
 by gzsmtp4 (Coremail) with SMTP id PykvCgD3v8MPfq9qoXScAA--.56095S2;
 Sun, 20 Sep 2026 14:32:49 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [Intel-wired-lan] [PATCH net v2] i40e: limit the DDP profile count
 returned by the firmware
Date: Sun, 20 Sep 2026 14:32:44 +0800
Message-Id: <20260920063244.1927792-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PykvCgD3v8MPfq9qoXScAA--.56095S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw4UWw1Utw18JF1DKry3urg_yoW5Cw4xpa
 y5GryDGrykJ3Wqgws8Jay7CF4rua4xZFyYga9Fg3s8urn8tFs5WF95JFWrKF129rWkCrn0
 yF4kCry8AFsrJrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ULVysUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqBEqAWqvfhFmGwAA3F
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

i40e_aq_get_ddp_list() writes into a I40E_PROFILE_LIST_SIZE buffer,
which is sized for I40E_MAX_PROFILE_NUM (16) i40e_profile_info entries
plus the 4 byte p_count header. i40e_ddp_does_profile_exist() and
i40e_ddp_does_profile_overlap() then loop over profile_list->p_count
without bounding it, so a firmware reporting more than 16 profiles makes
both helpers walk past the end of the on-stack buff[] and compare
against whatever happens to follow it on the stack.

Clamp the count to the number of entries the buffer can actually hold
and make the loop counter unsigned to match the field type.

Fixes: cdc594e00370 ("i40e: Implement DDP support in i40e driver")
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v2:
  - Reordered variable declarations per Reverse Christmas Tree convention.
  - Added Reviewed-by tag from Aleksandr Loktionov.

v1: https://lore.kernel.org/all/20260915120354.610499-1-xiaolinkui@126.com/

 drivers/net/ethernet/intel/i40e/i40e_ddp.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ddp.c b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
index daa9f2c42f70..26dccd4236c1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ddp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
@@ -54,8 +54,8 @@ static int i40e_ddp_does_profile_exist(struct i40e_hw *hw,
 {
 	struct i40e_ddp_profile_list *profile_list;
 	u8 buff[I40E_PROFILE_LIST_SIZE];
+	u32 i, p_count;
 	int status;
-	int i;
 
 	status = i40e_aq_get_ddp_list(hw, buff, I40E_PROFILE_LIST_SIZE, 0,
 				      NULL);
@@ -63,7 +63,12 @@ static int i40e_ddp_does_profile_exist(struct i40e_hw *hw,
 		return -1;
 
 	profile_list = (struct i40e_ddp_profile_list *)buff;
-	for (i = 0; i < profile_list->p_count; i++) {
+	/* Never walk past the end of buff[], the profile count reported by
+	 * the firmware is not guaranteed to fit into the buffer we gave it.
+	 */
+	p_count = min_t(u32, profile_list->p_count, I40E_MAX_PROFILE_NUM);
+
+	for (i = 0; i < p_count; i++) {
 		if (i40e_ddp_profiles_eq(pinfo, &profile_list->p_info[i]))
 			return 1;
 	}
@@ -109,8 +114,8 @@ static int i40e_ddp_does_profile_overlap(struct i40e_hw *hw,
 {
 	struct i40e_ddp_profile_list *profile_list;
 	u8 buff[I40E_PROFILE_LIST_SIZE];
+	u32 i, p_count;
 	int status;
-	int i;
 
 	status = i40e_aq_get_ddp_list(hw, buff, I40E_PROFILE_LIST_SIZE, 0,
 				      NULL);
@@ -118,7 +123,12 @@ static int i40e_ddp_does_profile_overlap(struct i40e_hw *hw,
 		return -EIO;
 
 	profile_list = (struct i40e_ddp_profile_list *)buff;
-	for (i = 0; i < profile_list->p_count; i++) {
+	/* Never walk past the end of buff[], the profile count reported by
+	 * the firmware is not guaranteed to fit into the buffer we gave it.
+	 */
+	p_count = min_t(u32, profile_list->p_count, I40E_MAX_PROFILE_NUM);
+
+	for (i = 0; i < p_count; i++) {
 		if (i40e_ddp_profiles_overlap(pinfo,
 					      &profile_list->p_info[i]))
 			return 1;
-- 
2.25.1

