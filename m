Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012C3C982CD
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Sep 2026 06:56:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 31159607E2;
	Thu, 17 Sep 2026 06:56:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MyFck--r1Nmk; Thu, 17 Sep 2026 06:56:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C0DF66062C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789628216;
	b=hPMZGMjMwVqltfeiU5045JYH/97brmofR7/IDt7nJyfBsfrD1oV+8x6bFPXmTCYbhG+V
	 n+T+LVheHY2pus1lDLy/L9nnZSJb/bum55NAQ4nlG0Bjmwq/JNa0yGSV6XRFsE7RkKE+s
	 gg4s5HdC8ZDMv/5YOC40sa7mwdSKnaAvhJMFa2RI/ilKqNvfmzIuJXvtSPpcqzByc+4k6
	 qY2JqHLcHTUw0I4gdZfBWZQ4PqHfudXpEfPmKoJmDVisBO7Pv8BcPBFiiRvF0sYo41nbO
	 WlDxEvDM5nh+GszyJDnL1RJd1IV3+HIx55wFqBGZAjZgmhFweW57hXPN6fzBBua0bNQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789628216;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9+5aItjV8sXRWYQrSBqF5NevwNFZO4i/q6ItO4H3KNM=;
	b=r5qlhR2N8PffYE4lQKlIVKAHewxoBxJMgHCi1r4CVHPbiaVb8nU4hzDSpqXZwGH2g9mT
	 tvoR+fwHlhlYyMjHi1unPsqjm5/Eh9Zwro3EueKNfx88X68RaLgrfIuK9d2RM6c57uDAm
	 CjMOBwefDuFmvVPnMZpcg1fBqZbR0zhdY/QPgcVL7iQ+qxLYYcNtaiwgpU+fcoJBAX/IQ
	 SaVrxtpQYIHX+nUFiuBFIZQThIdyQ2O69p8aqVRmcoYQsak2Pzv0h73VhOjt93CuuPUpQ
	 VbFVfjEA9UJUSfxcx39U8OGBVGFNsvY8+We9L9lRUauRSWEiiU8BMkcWLEXdOA3+krw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789628216;
	bh=9+5aItjV8sXRWYQrSBqF5NevwNFZO4i/q6ItO4H3KNM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ex2lpsTOq09iGuD2rb4VBKiL+XJVrxpIwKf02iI8pCUyyEpQ0d0SPG1pG/IANIbR9
	 AIZs/uWx2kESgqvh5QX/5jfpVsXPkxk1+yRvH7tj4I+oC+kRv62d6y3tiQ3FovfptJ
	 N5Z4/dZiHKj6Vo1FsOoNGAV6qPXmBMeIzoAGn+BHcbVrURlre0g5+Tg0RvMC02C+lN
	 E2rimSE1R2AecXLPqKj6FB0LAak77wsjGyXGEUvfCehZP/i+TATfyMB7bIta3yffKP
	 0D2zTABA0VhsPGuiOWCNcGgwKnD6/G3WTd2Dl0v7m1gkVC0ElaPOWgJqWk9RQfje2Y
	 DLGZm57j+xhHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C0DF66062C;
	Thu, 17 Sep 2026 06:56:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A788242D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 06:56:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A48B1406A7
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 06:56:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UgCTuzS19UWA for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Sep 2026 06:56:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B143A40689
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=220.197.31.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789628214;
 b=hzq+XeA4dYYC/E1vI/bgpD/KPlmUGHESKCZwRN6K3CGysR7hCFKd+DSPJIiq/s0G41Po
 WkO+caoU9PnvgKnQEOan++FAys8LgbYfXlHb38ZNVIxXARWuy1+vo9lhibtjySvcJA9jH
 nsqQrWL0udcZu5QAHtN3ftV2NfuBFrCFg6A/HFzxez17yWlzVxenS6VUPcZrVtFLRB5Z0
 Kt2Jtl/3KMfIH6qSeItQ0ZT3px0cXzTaLeu8T9u2q6b3puvAHDSScaAFoo9dT2UamiTfi
 tgR4phWs5niGnCklVGY3gTHe/4D5NqqT2z0zIRKUN3UHkRLbmwmP1+5B/KRe8wMiNaQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789628214;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
 bh=9+5aItjV8sXRWYQrSBqF5NevwNFZO4i/q6ItO4H3KNM=;
 b=CjpGNBsI5TRFpMDM2yYc0XGLtmvkYUMmnb6PGBwSJlDMI3sr5U75ldwtLuHWPCjq467t
 CMkqX9gQcmWRxbuQ38Sk8l0CJ507FcJf+OFNQxiqdGDMMTfBvhDfdllTvGwGgAjGimAEU
 XSAZdNaDXbRKGEDfu6p0t2DLyHMPBgeVBZHXrn3BckizRiART19RMvMpinQa5G3WiVq5j
 Bu8BEgWzEjW5pvtq0dGtwr+sKig4+teK8JzDzq3UOjvIgklWtvmwdtapUHgoYccgHWh3y
 2QMYU6HrmbagbifxEb3TpKOj11FEbzwSDL+NpnZEYE75Qj8S6dMm/c30csg/+dTxr9Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=126.com; 
 dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b="Wq/xXMiK"; 
 arc=none smtp.remote-ip=220.197.31.9
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.9;
 helo=m16.mail.126.com; envelope-from=xiaolinkui@126.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=Wq/xXMiK
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B143A40689
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 06:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=9+
 5aItjV8sXRWYQrSBqF5NevwNFZO4i/q6ItO4H3KNM=; b=Wq/xXMiKny4jxdC7cg
 EWDIOZIGCdT5CPUUUXVIvFNpCj8Kh6btEmSIoM6vfcHbmi8xgH5vgtLwVQNOGfHK
 Tbh1gSadALv11LCQxCLgQcDrRoeySgmtv0UeKOsG3t9lcQkBUnJEE0xXpyELlhaN
 lTIrVVuBKfWaU+1GE/8ER9Ijs=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id
 _____wD3X7IAj6tqQTSDBQ--.47835S2; 
 Thu, 17 Sep 2026 14:56:00 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jedrzej.jagielski@intel.com, kees@kernel.org, aleksandr.loktionov@intel.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [Intel-wired-lan] [PATCH net v2 1/2] ixgbe: do not busy wait in
 ixgbe_devlink_reload_empr_finish()
Date: Thu, 17 Sep 2026 14:54:35 +0800
Message-Id: <20260917065436.1181073-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3X7IAj6tqQTSDBQ--.47835S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7trW7AryUuw13JF1rAryUGFg_yoW8Zr1DpF
 WUWF93Jw4xXr4Fg34jqa18uasxX3WYg3y5WFySkrZ5Z3ZYyr1Dtr1Utr1fKr1UArZ8Kr1S
 qFn09rsxAFs8Cw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ULVysUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqQBpQGqrjwDwYgAA3c
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

ixgbe_devlink_reload_empr_finish() is the .reload_up devlink operation,
so it always runs in process context with the devlink instance lock held.
Its polling loop delays with mdelay(500), i.e. it spins the CPU for half
a second per iteration and, because the loop bound is 20 iterations, for
up to ten seconds. That keeps a CPU fully occupied while the firmware
performs the EMP reset, and on CONFIG_PREEMPT_NONE it also makes the
loop non-preemptible for that whole window. The loop does not need to be
atomic and holds no spinlock.

Use msleep() instead.

Fixes: c9e563cae19e ("ixgbe: add support for devlink reload")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
v1:https://lore.kernel.org/all/20260914092626.263886-1-xiaolinkui@126.com/

v2:
  - Reworded the commit message: mdelay() does not mask interrupts or
    disable preemption, and the ~10 s window is below the soft lockup /
    RCU stall thresholds.  State the actual rationale instead.
  - Split the macro rename into a separate patch.
  - The mdelay() -> msleep() change itself is unchanged, so the
    Reviewed-by tag is kept.

 drivers/net/ethernet/intel/ixgbe/devlink/devlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
index cf8908b82f8a..781f13240a0d 100644
--- a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
@@ -460,7 +460,7 @@ static int ixgbe_devlink_reload_empr_finish(struct devlink *devlink,
 		 * may be not cleared yet, so begin the loop with the delay
 		 * in order to not check the not updated register.
 		 */
-		mdelay(500);
+		msleep(500);
 
 		fwsm = IXGBE_READ_REG(hw, IXGBE_FWSM(hw));
 
-- 
2.25.1

