Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2EE0C88E7F
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 12:07:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4841280D8A;
	Tue, 15 Sep 2026 12:07:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Fp6PoyIVSCj; Tue, 15 Sep 2026 12:07:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B5C8080D81
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789474037;
	b=YEQ9SDyVdvhv/ky0Da4cQpV9b+RHUFWswSKTTM3b+3ELSS9y7ayXg3UBHP7PNMeEPo7l
	 TBzBDT/FexCbhEiotYRY9CRUh6cl6tsvn/S6zvPu6Cxi1LiZ4+ieoIlKVUo/SSGqg2Jdv
	 WI+rOywoTz+UT60uFL1MU60GOnjiLYmgIs9ie1BYpruD6LxSe4eBM+yxYnG4JZPOnMBFt
	 sN4IafsRrI21FBtakPprW7AmMVxwOXZqnnTt0trLYHjGKeXb6IWFWjiM27E7fpvGWvoML
	 MaQXgtXT9iJG5ZdZEhRXSm+AQ4ng+7MMmnjh/j4aQI3f/PYZvNrWN7QzzooRL7KAWLA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789474037;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9ul3bUyHD7wGoCm62vRZXHwUVl+wV8Z92XNjrOcvm0M=;
	b=k8f1aJuBg2oKtVw1cEAzkytsRwsxdj3zLqJw4vHvCbsE6ppqaazbehvA78bhbNk+TwjW
	 3eRG+NYRUg2mHBgjh9Sct+9FwrFV20t4agDfZC8KyU42ODR4GBtrpub6AKqPkY3L3DiZ5
	 la60OSVVyc6Hz4xHsN7gHhvNepm7R6xusIFef8wlzQAyg+MSMYK6zXZ9Pw7tDyaWFx8DX
	 v2Eazi2jzNA2FzGDlrH7oUn/cvJITH5G0Vbh6KzZ4jEqzzTXHtZEsOYYYd3C7u9YJUiFI
	 hlrC2oBQiRR98vK1hBGSIJZSANyGL/B0lS9t+D0QB/9pAuq2P2cBy7iToS4Xblp0gGA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789474037;
	bh=9ul3bUyHD7wGoCm62vRZXHwUVl+wV8Z92XNjrOcvm0M=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=t1AJN1jxzS9oz7zeP55aI9GEfEGlW37cvWLmnJohwZlNRLKli9BuxOr05FKjORCrq
	 dLFFZJcHkC2156FNUcdjjieclhuVg01t2PZArgyfsVpPLkmXcNjaDnzCXtC0BGNoBb
	 lfoA9rw7kf+rwucSYkfD/z8ezV9d2QTJq6F7AyFsIBhaYSmtmgBxPnJZekStpmRmE1
	 2suf4DNp/x2PW9N90Y6jQ+NncwXD8faFCsZdfq47sEn0sO4FThTjtdpQNttokUQzHa
	 p62byT8hk5YHitJb4PXuiEaqMjn8FqnZpSsK4xBc+qnT9pC3dijdtHSGCHk7kVExSw
	 4Id8oibFGXePw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B5C8080D81;
	Tue, 15 Sep 2026 12:07:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 372BE2D0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:07:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2231D40123
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:07:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 84O31nH06p3c for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 12:07:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 41F6A4005E
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=117.135.210.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789474035;
 b=FORrKdlCa3JuSDblO8d/REPwpPZge9LUeoM+mq7x9OYsUv86YGuY+FeIAunkBR9gH/+K
 OhdZJzyJbiiTdVdLbAstMvebz1Zknm40RLJexky9VcvmS5RLSMAKj5LD2CJEXUUFcOuos
 ZWDtOYjnhQr0MPXk7ypls+ST8ISxE6Lvp9gvTMCE+9acEBXc2EGxcweFJtskk/WHI1QYe
 WN7KlNWcauRl634bVgR+h499kpq67swNMyEjQegB6ADrEbwC8xoEKB7iD84JfrWc3W/jF
 QQ5vKiDRZyS8P6adHv9AvbC5L7uvXN/OEMQOSdjrJXPB9/wzAQwBoT4PT+6SeAOZlCA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789474035;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
 bh=9ul3bUyHD7wGoCm62vRZXHwUVl+wV8Z92XNjrOcvm0M=;
 b=f2CpamdkbCprC4D58MNpWanx6pOEoM8MrhpDdi/Koe8+APrl7uC7hORmqBD/JNtLEE0s
 tq834AtvoHcUwCXh7ZLrzTI5vIo4d/PcfDrIquUWBCn1Ktq3G7VD46c9YKYy4XGao9W3r
 GvpdTNd9sUCEr9Z2iVziIU523WNCjRPFqDiw8cos1hrllkYhjDKdtvyOyhsSwdOVLguWI
 McAzqvzvKEphENgt+nPGMLGdqFwkdQ+les9Wz+Q9sn8z+6uEodQ6KhxOcZ8f7wVnxQUCn
 9I8NVQ7Vop26J2+GgfFVZSng1HyAOJ4rjgmNTlMkTy2iJot67nHPYSpjnDZVesYez6Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=126.com; 
 dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=oGsX1BIo; 
 arc=none smtp.remote-ip=117.135.210.9
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.9;
 helo=m16.mail.126.com; envelope-from=xiaolinkui@126.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=oGsX1BIo
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 41F6A4005E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=9u
 l3bUyHD7wGoCm62vRZXHwUVl+wV8Z92XNjrOcvm0M=; b=oGsX1BIoMzahTkB1ro
 /eq6eq5U1rmBR7jy6/K2rQEzrqCXdrsXXyV+FdlcblxR53zl7h6PhSb3ZcwFlqBu
 iqyx49gBeITYehYRLAUbgWCqlpXH6ohUcQCE9cQyUwN2QnVXd+TE6myFhsnN5SUx
 WPr1dLHCatipvnP4/agMxw6r4=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id
 _____wD3Ny8rNKlqchRDBQ--.39588S2; 
 Tue, 15 Sep 2026 20:03:56 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [Intel-wired-lan] [PATCH net] i40e: limit the DDP profile count
 returned by the firmware
Date: Tue, 15 Sep 2026 20:03:54 +0800
Message-Id: <20260915120354.610499-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3Ny8rNKlqchRDBQ--.39588S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw4UWw1Utw18JF1DCF1ftFb_yoW5WF1Dpa
 y5CryDGr1kJa1jgw45JFW7CF1fu3WxAryagaySg3s8ur98tFs5WFykJFWrKF129rWkurn0
 yF4kCry8AFsrJwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UHq2iUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqAwd82qpNCzcFAAA3Z
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
---
 drivers/net/ethernet/intel/i40e/i40e_ddp.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ddp.c b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
index daa9f2c42f70..1d6d8b3835a3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ddp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
@@ -55,7 +55,7 @@ static int i40e_ddp_does_profile_exist(struct i40e_hw *hw,
 	struct i40e_ddp_profile_list *profile_list;
 	u8 buff[I40E_PROFILE_LIST_SIZE];
 	int status;
-	int i;
+	u32 i, p_count;
 
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
@@ -110,7 +115,7 @@ static int i40e_ddp_does_profile_overlap(struct i40e_hw *hw,
 	struct i40e_ddp_profile_list *profile_list;
 	u8 buff[I40E_PROFILE_LIST_SIZE];
 	int status;
-	int i;
+	u32 i, p_count;
 
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

