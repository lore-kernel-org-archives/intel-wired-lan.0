Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6729EC88E72
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Sep 2026 11:13:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 128F580F4E;
	Thu, 17 Sep 2026 11:13:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QvEfEY3mlc0W; Thu, 17 Sep 2026 11:13:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5C11780F21
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789643608;
	b=ajWO2HygzEOof3Y5YB1pEgg07Gb3HXBMSat3iFf+Ph+FusmJ85oJMrS3Sw/o07nRRlvg
	 rIHSY86BUL5ED8Ioq/GhJVlPMyoVp2RBQvs5c6ITFkEa22CwA4EC+FBBQCp1xAazXVYPo
	 xJsfU/lDcz1mbbFAyZ4D4UgmnwfUwy/gfAeIoyELiYxYj4P5Azv7bRZgoENzn6Jp7tgeZ
	 4/2oS1zp+liS+YN6aq29Y/6aQzSs72UROluSJVWpvcxSDimiANeT0YpdXJkweojCzUE0Y
	 Mphy2JH+FXww6w5sLEgjthU0JPjHsU23dglPp3oydtAz7IZ7k2fryFs7AwiqOczs4pw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789643608;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-Originating-IP:X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ay75+tk0cUcg9XojMbsUXqtU57Ok506eFF/k109WCdg=;
	b=K8NHmhTP8X1FtBT2JfeSxHqZSeKC6bzhloiZQUtc1Iptt5odtIpVYxVtu7bo46LcnEx/
	 BvMshC4adRhuvERe/38xCQYIs2XBNEHcYHj0IyA5Bq4ng8lYnSyBMCxQYxczVGG/Kgwka
	 ueovgAK7NmnkneD+PZ/LA47SuCpJ0kxIvmqtHpSNaWxr0nfmG+ysozt8fRrAvuZzxxIIf
	 5vnOh9XWRAf6xcKKKG94qktkLWKIA6OBSMEMfy01II6AHI8HMWspmHgD+ONF41DjMBKYn
	 RG9W0x0X/jFJo/rAgo/VgnuEXkub2EtR3j7SRrFleu5hteV7mqdmYbg2cVr5uIJZinQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789643608;
	bh=ay75+tk0cUcg9XojMbsUXqtU57Ok506eFF/k109WCdg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bnMb5tz9M31SL9LuOsAHAZ7/wbmXg+Fq+5eArNlDxkH6y8QMHR1ShfDPI+Kea4f1m
	 d4PA8QZQekqwAQxvLj/PZ8jvHGGvU1+I6bPuWpDFKNvprDH9Du+2BxIxWutKVGd/Yz
	 8o9sSIi8csaA6lUuMrrbLtO3iJxgyz9STRzQDoSFlJo3JeAUhFyHXM3TJFzsSyoLBa
	 0Tlw9gx0GDt0HcP7hrNHXP4NUEREV1TdaogVXyqaxCeVTUX0m1/RgdLKL7hA3uUa3l
	 iXodYvDtefOtAHXCzHVww3j/2vyAPTrYnGmUp98dx8KCQaVIkSDi1YcYPCIg/juiIc
	 FTEGSkQAOj8ag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C11780F21;
	Thu, 17 Sep 2026 11:13:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 388C113D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 11:13:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1F94160659
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 11:13:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2_enVazVUPXb for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Sep 2026 11:13:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B8DD2605D5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789643605;
 b=jwW2ryRDms8nS4mqgZ88QJ8dHrb1XUVx85Gx8NPyC3bl3bCIYiidtzR0lp4QAbcJqOUI
 08jxYf4/2jkP0syu9OgkZe9+9YIa10XS/2NaBiu5RPaWB2jJR5kvopqhpCdkXYBmLljoH
 XgMxJsNeqPCXjt/Dnc2mkPZUfEt9YWn7eKANDOW5yul88zLJVPCb1GTIYzN7wenrKa+NJ
 NQ6Y2NVf7enc/VJ3DoG9dyEq+xuQX8OZrkAXoCiVAz771jUBQ32VWEupWR7FnqnB6XshS
 G5iRpMkC3kvWMLucnwg9+rYoo+wpPXeaW2HtHtOvgBXlaBnb+ABqtjqA1jHwX4cP0OQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789643605;
 h=X-Greylist:Received-SPF:Received:From:To:Cc:Subject:Date:Message-Id:
 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
 bh=ay75+tk0cUcg9XojMbsUXqtU57Ok506eFF/k109WCdg=;
 b=PMcoKOhNVRD01O3ZhZvsLnzRKzHigR+AbfsTrNvY5l7D7/y4z4IsXEEcHv5zJYEExqvw
 X0cdyRxeh2HnNAfUPtozj7M3d7CA6IUn2OOcix1XmdpFCYu3GZsHjQASmVW6shPGt9hWU
 UqsO/BNK8HPM4QNkryQ/Vit1O4jAAvpXwePXvyoD2Tenry8oSwZGvdjg9wJGho8xDLrzC
 CHEuj1tcIXgTEya8QYMwc8B0VIW7tQwMReO1MifIaDUYy+1ZiBvdvJ+n9L8mpObcWsXDz
 muVVyIelJ50uws7xqlaKtneNeDiZMLTfvCh4AAJbCRB93MIB3nLoWMjEVyjXoUxy30w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=iscas.ac.cn; 
 arc=none smtp.remote-ip=159.226.251.25
X-Greylist: delayed 121 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 17 Sep 2026 11:13:24 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=159.226.251.25;
 helo=cstnet.cn; envelope-from=vulab@iscas.ac.cn; receiver=<UNKNOWN> 
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B8DD2605D5
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 11:13:23 +0000 (UTC)
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
 by APP-05 (Coremail) with SMTP id zQCowACnFD9Ny6tqSlF_CA--.1399S2;
 Thu, 17 Sep 2026 19:13:17 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andrew+netdev@lunn.ch
Cc: anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
 intel-wired-lan@lists.osuosl.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 przemyslaw.kitszel@intel.com, sln@onemain.com,
 Wentao Liang <vulab@iscas.ac.cn>, stable@vger.kernel.org
Subject: [PATCH] ixgbe: fix xfrm_state reference leak in ixgbe_ipsec_rx()
Date: Thu, 17 Sep 2026 11:13:17 +0000
Message-Id: <20260917111317.2148568-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowACnFD9Ny6tqSlF_CA--.1399S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKr43XFy8XF43tFW5Jr4fKrg_yoWDtFgEk3
 48ZF4fJw15KrWFyF4rKrWxua9agFs8XryxX3yIyFy3try7JF1xJ39I9rnxJrsrXrWrWFyU
 AFy7GryIya4YqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbgkYjsxI4VWDJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
 s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
 kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
 Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
 W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
 7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7
 v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0E0s8F02x267IIx4CEVc8vx2IErcIFxwAC
 I402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrw
 CF04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
 5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
 W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY
 1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
 v26r4UJVWxJr1lIxAIcVC2z280aVCY1x0267AKxVW0oVCq3bIYCTnIWIevJa73UjIFyTuY
 vjxU7H7KDUUUU
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwUNA2qrrRlfVAABsz
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

ixgbe_ipsec_find_rx_state() returns the state with an extra reference,
which is handed over to the secpath on the success path. When
secpath_set() fails, the state has not been stored anywhere yet and the
reference is dropped on the floor.

Release it before returning.

Fixes: 92103199f10a3 ("ixgbe: process the Rx ipsec offload")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index bd397b3d7dea..e44d5eed9ab5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -1197,8 +1197,10 @@ void ixgbe_ipsec_rx(struct ixgbe_ring *rx_ring,
 		return;
 
 	sp = secpath_set(skb);
-	if (unlikely(!sp))
+	if (unlikely(!sp)) {
+		xfrm_state_put(xs);
 		return;
+	}
 
 	sp->xvec[sp->len++] = xs;
 	sp->olen++;
-- 
2.34.1

