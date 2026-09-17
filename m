Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827D7C982CF
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Sep 2026 11:14:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4FAC680F66;
	Thu, 17 Sep 2026 11:14:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wPHEc1KA4xZh; Thu, 17 Sep 2026 11:14:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6A71380EC2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789643669;
	b=qtZgeilctmOf69rc2EtYperu0Vtk7O6zkar/qnxauNKHPs4VBQfMqxFkla7MqpxNU3wY
	 4tWn5af49rD6K4xG9nSqxTJR5J2gr3OB9lyr4Gy1h4I1Rqz/n6pXmnl+l7FL4frZVsAQV
	 Jd3hC5JBV8n6ApdXGy5AwKIlxMcXPzeSVZWhTupIaiLfpGL77uruA4GbsHyHzz16nNsWq
	 MZTHGKaIxgQuCs7HxImGeaIFHDbyTP2kDeooF3+jE0UqUtmzrs1C6HyHGnOnt9spBGhON
	 oyVZ0QZTABLMmN89S/wKmdiW/gakid7XTHaf+m1uVKjObQktixK23ZVg81o/4/E80UQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789643669;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-Originating-IP:X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nstP8R9fC7ObTr+7qcN0PZve3bjhdcizEqhZxZK5nz4=;
	b=B71Ay5IfvbKHYtAoDbEwbXHjYvJlKDYrazMlEQrQVWKQhk6+keuuBY7evxqf9nzipJ90
	 3+ElZJq5Svx/EQOdUddiEha0MwxN7UtwfdEdDL2E22K2DE0GUwFW6wHLQB5Mnx5cGCwpF
	 ubdK7nqxsDNQTEE5frohJc9Pvakrl1vkSTkvJfXsh8l8uWtoQpERlnJXCaWe/lO2aWUx1
	 4q93g7EuN/4CAhEdMGcrAwgIrcBCFR+H6wZYuOMuydu8CqRtsofdsBp8+vB5Jlm5rrwCe
	 rnLzOlt6LMuFMRYEA/22vx2WNMPJm9v9wtd3ZxxfK3wAFpEWHH71N9c0t0rMh+Dm6NQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789643669;
	bh=nstP8R9fC7ObTr+7qcN0PZve3bjhdcizEqhZxZK5nz4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aYCQbOeX/ufaPHBoAYin6zm93MP7BZX/Ochj1KIr0Ck1+fvmXGWkhrs8IQK6Cmpt2
	 c4P/kBLMwiPlgXPei4i+/B2SNHfNeIhNCpsgJIeDqGLoV4/r3O3fRZqVzwUO32q9ee
	 Z1Tu0z9IdGX6yHOTLmTR4IkPOb59NlqcqZLvZtoHHDmnsmSvJwTENPK/Y90zlag8EJ
	 ED/vGRAUN7nJzzU/XVuSD7U3AHODIWh+8dEa1SimZfeDBjMKS96RgqoScEJbfHfMaT
	 pXCQhkpIS7kueguX7tCvgYD0P8WGvwRSCE6C/ZXQEd8u6DqgBDgtlMpXO0L+UItsb1
	 rvAfNE9/iPNVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A71380EC2;
	Thu, 17 Sep 2026 11:14:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6503F13D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 11:14:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 56CA140782
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 11:14:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0LksMMfQLKwy for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Sep 2026 11:14:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org EA4AC4023C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789643665;
 b=RERQ2maFVRyCdCovrVTtZL1kpTCKMnt7zhzk8WVhLWXc8O7zQ1RUr9P3gKPlZMOHu/9Q
 MC2eFAGYde3effkveFYzOO/nMdn0hnhds1DSpEXJXbOGPmLcZbKdO7C5xlhoadune9Ewo
 rjWtI4cpj7oxN1mEmG1OX9qijr8Ei8zdUEryHYIdPlrYSYcWnN76l8EvxU0zinbAIOWR4
 hHRsqKwsztM2fBfDAOSMRqMLdt31IJkQbfgXK4UVW2+hSqCsuAr+rEmMA4suKhmn7fIwL
 0OZI3GgK/9GkpUBZlIkIcLDA1Ei/e3jFoJhrUL/3CzjxCkBqSLonIHuP9xFSWQPbZCg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789643665;
 h=Received-SPF:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
 bh=nstP8R9fC7ObTr+7qcN0PZve3bjhdcizEqhZxZK5nz4=;
 b=COEsA0qW62TOCxuGHh02IEmbHe6T51eVl5vFlygDVeD98FvnHpahVASp+hBSZHtY3NF+
 gBTHPeyZ5MhKAfLnqXDg98rUGZjD+fo/yRz63yjBQgLTBwBN+vsVaEkNYFr8VYmd/yAHQ
 asQkOB3RNH0ITrDI3PD+ZBRDcs0xf4LIp4iB4Qq26AV8CxwemFSfvB2KWNLT0c0peby4c
 Im5++HY2zwhfqg1ygKvJ4bl2CAx/O3UqzclOA9rLl81a/OuJOmXBU0/srWITvsfO4Thgs
 59rjvuV4/LtscrOF0gbV8VaTp7OYG5/o0xtl90C1yErRR0gvQOwd/ZAphpzlnpBOQNw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=iscas.ac.cn; 
 arc=none smtp.remote-ip=159.226.251.25
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=159.226.251.25;
 helo=cstnet.cn; envelope-from=vulab@iscas.ac.cn; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EA4AC4023C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 11:14:23 +0000 (UTC)
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
 by APP-05 (Coremail) with SMTP id zQCowAC36EKKy6tqE1V_CA--.1509S2;
 Thu, 17 Sep 2026 19:14:18 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andrew+netdev@lunn.ch
Cc: anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
 intel-wired-lan@lists.osuosl.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 przemyslaw.kitszel@intel.com, sln@onemain.com,
 Wentao Liang <vulab@iscas.ac.cn>, stable@vger.kernel.org
Subject: [PATCH] ixgbevf: fix xfrm_state reference leak in ixgbevf_ipsec_rx()
Date: Thu, 17 Sep 2026 11:14:18 +0000
Message-Id: <20260917111418.2148632-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAC36EKKy6tqE1V_CA--.1509S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKr43XFy8XF43tFW5Jr4fKrg_yoWDZwcEk3
 4UZrn3X3y5KrWFvw4Ykr4fCayI9w4DWr1IqrWxtFy3try7Jr1xJ39Fgr9rZr4DXrW8AFyD
 Ar17Cryxta4YgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbgkYjsxI4VWkCwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
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
 vjxU7WE_DUUUU
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRINA2qrq01sjwAAsR
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

ixgbevf_ipsec_find_rx_state() returns the state with an extra reference,
which is handed over to the secpath on the success path. When
secpath_set() fails, the state has not been stored anywhere yet and the
reference is dropped on the floor.

Release it before returning.

Fixes: 0062e7cc955e0 ("ixgbevf: add VF IPsec offload code")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/intel/ixgbevf/ipsec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ipsec.c b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
index 076fd0a24858..bf3fcab3bd57 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
@@ -596,8 +596,10 @@ void ixgbevf_ipsec_rx(struct ixgbevf_ring *rx_ring,
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

