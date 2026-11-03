Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947CC606A821
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Nov 2026 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=fk1NUULe
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 777D940608;
	Tue,  3 Nov 2026 10:10:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E6rNSPIF_tDp; Tue,  3 Nov 2026 10:10:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E92C9405B7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793700658;
	b=A+6DoSkTWNUP/9ZJAG4uCDgrWBKOq20Fpkjx5Q7O53ZwkIjkpvhQ+7Ub21rmD8Kp4Yk9
	 0jPTelxWtF2+SZjYXo4o2ne/Vr9aMUfuQseOYOIRatcUyFIJHr8td/48cx55GbCjGZroM
	 XuVrg5vrHosrRW0Z//RxDCWT9rhmpxK8e87HXiouTiA8Bi6M35OhHSpMYNHpyxlE/w1Nw
	 gF03HlTrcyUKjD4SfdQGWrKkx50XRx5YLolxM56p12S59g0AfGip1Zi4PFAxT3jDfWxYE
	 ZzkhFvj5hYSEQd7TNtTkcr+igrVpu0BKV0dnFEl8o60tYzfz/vri5QDWuyO+ubPOI5w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793700658;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-Originating-IP:X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Yt3HBs83jX9B8IR02MP/6eu/676fqC4Ktt+8AJPnvUs=;
	b=IRyS8BL+6pw+1qvMLkBEp7T931rgXVvsLD/aQS3h7i+y6Lm0gAaYruvBJh+M1rJLDxvR
	 GSB0B9aJxbknCItXMzMdcKLHNCFKC+qCTZi3x0d6slDHYxOivfagHiBTv92NXHtkkncGG
	 weIn4qTKsoWbpec3zNgEh0S2uQdXoFE+kQQXkxV2S6aL+SH9+JcBhIkiCQny7YAPOwoBD
	 Lq6HCk5FdVmlGezlzX5Ba06rGCPL214nayGzCc7s5yMNtE2eTblRY/RSQDXiG3B0oTUgO
	 R3X6S59q72f2DDY6OFpNIY8BkbfSnS0yPl3VkEbVlZZ5CxMi+H1/giAdQ94xqGt/2XQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793700658;
	bh=Yt3HBs83jX9B8IR02MP/6eu/676fqC4Ktt+8AJPnvUs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fk1NUULeO2fXH9mMpl9jd0NbLSO82ZoyzBqTNI1v7TJjcIZGqRcHwXy682bKcOF0b
	 +KbPz6OMgmtcC4ztDsSgHgUeIwCLksVRkWbY9ysMf3Aj0Zmpn+Cpx5szyL6LaI0g9f
	 MjQTN9bXNQp9OmQPFZh3jhZ7aTh4SXu3RnQp12Gs+RplRVJJFopJ5XPaPtb78fIqiu
	 IgZRu7FN/VEkgX9+ESR7J5+6KwEOyG+4s9Ni1LS1rNf3NDDdmMX3i80Qn18A7Y33uS
	 yB8GZ1yI3MPG1PiPV9rpIYtLRQVtxU3bZb3qRvdnjsOmr6juRtWQ5MWp1SLTOShjXZ
	 rrmHt2a108wwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E92C9405B7;
	Tue,  3 Nov 2026 10:10:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 07A56A15
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:10:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 050B880BE7
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:10:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7LoBVZOdyUGC for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Nov 2026 10:10:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 539B380B09
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793700653;
 b=ZtYPBgHvgxqLoak0ucatAabz3iuasdl227+ftaDPmTMTPl38Fvbo34d55NALeu5aMXwu
 CFqvC87i12H6XxbNhAZoaUCG/14UoArT4NQTe9K8zDqXgkKBR/yHq5rhe3PhbyQcqsLvH
 yjnKDPnk/EeWfT9uBFeunazvlru16gGsTjFIP68iEFj0m9my3nOX4Awiaa/hx3EVI3zHh
 44Lnng3pBbm9iM7DLT8yjRx7mLvY/rl2R1fyfzTP5f+GwenIKeTWiZ6fXNloYhbDVpjsb
 tvPCptf4aBUbFSBiqgeCpCe9Gltwbgj95JnEBpeDKbWZizMvv9+LVtZsC/DFjrZOcnw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793700653;
 h=Received-SPF:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
 bh=Yt3HBs83jX9B8IR02MP/6eu/676fqC4Ktt+8AJPnvUs=;
 b=Vc00NXi2LLyKdnK4AvBKcBML9k84WNXuN4EzR/pvuLSMdtJtD8XZX68lxppx+aTFe5Rx
 M9awn3ZJCXLt1G3UIVJA/Ose70VEhyBdMUwTJqGU1k19cyLcyw21iaFXhrPbQG40kxqRc
 IGzT4crSCpGooabxAIkK5IzJIgPThu30z/Dd1cv8NBkniFvk/r7O6xQtEXfcP4RYBMu0/
 8OoK10zK+khDdIRFLd8eP3Zuj7axx6B8KU7IczeiRp6pwINJ9hkTVm8XeNOwa3/vzbCjN
 rbIDkSUtOd+XzLBWdwMQwoTmUAbeqYYnPob9ISzW2lcX+dVUQ9XKxYTUsg7ResiZEWg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=iscas.ac.cn;
 arc=none smtp.remote-ip=159.226.251.81
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=159.226.251.81;
 helo=cstnet.cn; envelope-from=vulab@iscas.ac.cn; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 539B380B09
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:10:52 +0000 (UTC)
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
 by APP-03 (Coremail) with SMTP id rQCowAC3xZblselqkHs7AA--.2541S2;
 Tue, 03 Nov 2026 18:05:25 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Wentao Liang <vulab@iscas.ac.cn>,
 stable@vger.kernel.org
Subject: [PATCH] net: ixgbe: drop the SA reference if secpath_set() fails
Date: Tue,  3 Nov 2026 10:05:34 +0000
Message-Id: <20261103100534.1310039-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAC3xZblselqkHs7AA--.2541S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Wr4Uur18tF4UXr4fuFyrtFb_yoW8JF15pa
 n8CFy8uFyDXw48Wa4kXw4rCFZI93yIqry5Cr9Yk3Z3Zw1rAry7CrnYvFyjvr18AryrKF43
 tFy7AFsxC3ZxA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9a14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
 CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7v_Jr
 0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
 8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
 Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
 x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6r
 yUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWU
 JVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_Gc
 JvcSsGvfC2KfnxnUUI43ZEXa7VU8jQ6JUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBggAA2rpnIRi8AAAsE
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ixgbe_ipsec_rx() takes a reference on the xfrm_state returned by
ixgbe_ipsec_find_rx_state(). On success that reference is handed over
to the skb's security path, which releases it when the skb is freed.
When secpath_set() cannot allocate the extension it returns NULL, but
the function returns without releasing the xfrm_state, so the SA
reference is leaked.

Put the reference before bailing out.

Fixes: 92103199f10a ("ixgbe: process the Rx ipsec offload")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
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

