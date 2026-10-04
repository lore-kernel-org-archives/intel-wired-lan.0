Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B403FCA5FE6
	for <intel-wired-lan@archiver.kernel.org>; Sun,  4 Oct 2026 18:10:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C0E380839;
	Sun,  4 Oct 2026 18:10:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V7lEFjgNcndH; Sun,  4 Oct 2026 18:10:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A10D680E08
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791137406;
	b=qWarvuV0aLcKd65SV/Hwfoz5QY4RdZy84rO/7aRu/fLGBuLd0x9opcOXhCy9AoGGWutb
	 YnQbYMiIWMpf8tg4DEyDwRdqrt1a4ebRpOSBzAhKtxD2M9jOytHM9DWMb5g8k20m/nZUf
	 XMmM8kjcQiXsQugNlPZ77u8CPPHzC3a2dcVIssv23maoTzc2jFgpiwHZ3PWbVH8z2txU8
	 Y6+vjF645rByPakf2vjbd2SxVIk5qXPq0m2E1a2AqtHeVbNRvhgIT1vemnW4ZSLxjm7RG
	 2/2z/k91epZuPKCUoZm+Mlu3nnCiZqGmmKHUNImTFkmgpighRF1AhoVkK3x49FgM4jg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791137406;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XN2y9HoEh/B+DkH2/LgEo5mNVmafbb4PxYEtM4F0P2g=;
	b=FAr2AmP7XNgjK/Ve/54aM1NBMat6zdFW5ihsYSZT6DyKXOHZ/HPDeWGRrwPQn+l7O59X
	 xU1MRGW4Sz9xiPvN2/QLdJxhI5C9HXyTdMY044MA7yekOG1OLcIFrdwaUz7Oh869Oc+zv
	 HbjhFxJbtaKRFRJb24dyKhC4O+fyrvMxFn2i2e1r5vMdwSIZ4eAdS/0wFuRi/wUSYNzVh
	 WFtf5jjWQOE3vtWw5dSv7uYY5Q6IvnPdWqfdIpeo0YMf5o880oOT1ABNl9b1RGcLQpnR4
	 bLzNntKdy5s5HoOsj+/C+9LmJZaX/eiOMdkCUa1Qf2G0nxIvtRvkb/DsG2eRTqkhMhw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791137406;
	bh=XN2y9HoEh/B+DkH2/LgEo5mNVmafbb4PxYEtM4F0P2g=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JLs7fGYLEH0DIAcfF72R/6jgQrzn48rZjRixkluEFB55Q2k01HDErLwMZteFfqN+K
	 LfskylRixvjbVDz+t9LIeZsucvknyYT8lm+z8xXRPgys2xrg12MQjP5O7qSJuuO2w3
	 FDWlTjHs8FVWXD2YPhxceneSI/g/LtUJO/pFBGRsK9h0p2CCBcAJ4P9yRZ9YsRZL2K
	 +utr93SvL0djvtmbh5W1kfswmVYhwxCqShFp1fXl745LQXueyvpt31COTrn87XlSsd
	 A5A7saj/f0/I8C0MsTxHapzAZkDUQKzW4SDRAttaHW4qPyqcewm4TE0Svim3HIGWGE
	 7efzFkxOHP/zg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A10D680E08;
	Sun,  4 Oct 2026 18:10:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AB93C32F
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Oct 2026 18:10:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A92AB606B0
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Oct 2026 18:10:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1enCQP0Hec5f for <intel-wired-lan@lists.osuosl.org>;
 Sun,  4 Oct 2026 18:10:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B2B50606A3
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:33::d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791137405;
 b=IHUVPxzBNaiabqCwmFSDP5T8xzVsRdbC9O7y3BK/5JnFMX1lIDMTtcGC4wfRhlVvKKje
 +PikwfB1G7pQ4uCXL4UI4XYnI3lDEE6ZJGI8AQ8RGe1MU+n/SEn0BejkK5xB4CPSY9bBc
 fjY2tRtDC9mQ0HTA8A3YPZyuzQEyS42maxXK1xfL4T6uEQQpaMZn+V7MiO7ltrT9y2gnA
 fsu1713vvoA2c5c7DfXppWf34tkgfJTHnlk5ncMyMuPm/XKYShYAEMQS+/i033MXWGKbz
 REbzLVtaoIrnMP14Oq4P5tKba3xAz/pZqhCKbMnniCAnxpIlPyL75tnW2+2bmCgBRrA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791137405;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=XN2y9HoEh/B+DkH2/LgEo5mNVmafbb4PxYEtM4F0P2g=;
 b=rrBmqNcll37V8koTdYfNuszZ3w+V66ZjWMEYhghsnwhmKNk+a7uR+T3hn098MoQ9YI6j
 aNkMCjyadfOxdgPfwZ+YQqwPXjI5yJRWoKwUmtgJjBPNgLPLWU1Yz2A9q3Nogvl3AEwU9
 VM6P0Glk34KUeWP7fReGoZc5gn1+GLyjyez+kKAQNmOAxUuMzoTw1JycfMroUeR2BmVkg
 g7RFk405gy2ESOVBMoInvxbpgo34euuB5EhznsQAmKt3nIRLSj6I9wpzNPVde3T/gKMCg
 8134hUC7ekfJRyUTAYJgVpwVrZUEUP1AgXVKoh2adWDXzJEqz2Xw7tsYmvGnUv8+bUg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=i+IRk8LG; 
 arc=none smtp.remote-ip="2607:f8b0:4864:33::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:33::d;
 helo=mail-qv2-x0d.google.com; envelope-from=oss.patchbox@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=i+IRk8LG
Received: from mail-qv2-x0d.google.com (mail-qv2-x0d.google.com
 [IPv6:2607:f8b0:4864:33::d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B2B50606A3
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Oct 2026 18:10:03 +0000 (UTC)
Received: by mail-qv2-x0d.google.com with SMTP id
 6a1803df08f44-91786b004f2so14187016d6.1
 for <intel-wired-lan@lists.osuosl.org>; Sun, 04 Oct 2026 11:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791137402; x=1791742202; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XN2y9HoEh/B+DkH2/LgEo5mNVmafbb4PxYEtM4F0P2g=;
 b=i+IRk8LGdfxVC7ve5AAV5UP8XCSCM0/tXGrzVeGf6/R0Pm2f2gwRbZDUkJJnXQCcmK
 y4bGYJ88GzCBTpufILXFLlglm7KP9UtZjlReqSuAEmgI/dV3MH4P2NfJmxZoXcwwKlAq
 Qlc3mGU7ocZ1mAwsGHl42MBmDcPoqPyrlg4z9UM4rvQZDwIQzwCWJW0ygJ95/Mgw/dXv
 8WANSDjEmwBpT4KGT3GvQjVd1dNdb9PGndtpT05j4oxKat7RyTy43pbF0pYMsjhuvgGT
 dgHEnrFXg7DXLuES5BsHdgPQrFZysukMiPDSkrgSxIDYGM+A7PsZANlbxYYIn/eLQj2Z
 w+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791137402; x=1791742202;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XN2y9HoEh/B+DkH2/LgEo5mNVmafbb4PxYEtM4F0P2g=;
 b=Ntt+f74Ob7FDSHibidbec+/ZqvAkZDw6nttHQvOVw0tLyrMq6cd9mLXxPz5zhthUTm
 FDNLt2LS+g3v+pJNflXETnsFY8BBJp/bl7Hv9Wllfe/GUhtZH9o9x6OHwocao9g8A9EU
 6CT5HwPT5MalFwW1tgeCh6vqWun+tYkAjAsgk4cD4FLugps6mym28dzldL0HiUDwgtij
 lW8xON7TdunMdSwhUcc/3EHIZYUeaCTyQghTktkulIT1xYxOYW9TmPe19khG0BVAeTf0
 dWr8xOa0Zfd/YJjomUz2MhqwXNqZSAjtJ2pZ/+olouINHEVc92RnqNcpPvQ7SGs2FlRW
 qNDA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxiwv5GH2V1W5TXUJayVi85aolrxRzY/Wmqs79EBUmo6xxSIvn83HqqhisKDqHy5nOmajlYy92mDz6gOPc1TjY=@lists.osuosl.org
X-Gm-Message-State: AFuF++nPIUm0GJGRZvrMh8zjrYsgcBwa54Nb88y8WkEoyEgfuzALawer
 +XNp25rL7kias2gwdePsocndo9tDuSIwMnUoX0SlXKuEXzVDgP5OhhBc
X-Gm-Gg: AYBFou1McBhTUesicdxsS1Ui2Yq9tAWAloC/Oz8zUIEKN+6YcmZEZWc6wuWxod6CwZd
 EUNfwOnY7kCImXy+5iwzyATKM5FUXaspkUjClnAkubR5BK4ftrYoIRFGqRUDVxDjIjO7tNdD+kL
 2ac+PyYkdB+lXQ5K9KqjO/8atJzVBW6GOdSK9epKmwahaRmc5YT5d1owJH7XgbnRbjsNj8YyxCe
 guiNIN805rD1mHw5qyxVSo75nj2DSKWzAa7SHb44fKuWcBfYnHQH7mka3vPhPZ8owMVDXLJ+0Ip
 vVk1/lA//PS3LB62Eu3tgW6TwCeFUWe/FK7MTu+7g5YYTShtxQd5l7M5hvfLfe7P47XnVg0Dvu8
 m6rmt5HuLT0Z8j5oCWd+RlT13OY1CFnsWY7PPs5f07jz9f4wkq1L1Fw4EQMRPD2IAtPNeDe63Un
 C+Y2Py0Ei9JGk1T1QtCqOnn0KXzq1wOE5Y8uXyvi3ykitxTuVOaVjrFl5ppqqhynophdjerBFxp
 N16maMEFxkci1aoFsnEaLKL9oUq70Xk
X-Received: by 2002:a05:6214:8593:10b0:912:517b:40e5 with SMTP id
 6a1803df08f44-917c01931a7mr120128746d6.44.1791137402128; 
 Sun, 04 Oct 2026 11:10:02 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-917d593b181sm70354166d6.6.2026.10.04.11.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 11:10:01 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Simon Horman <horms@kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Joshua Hay <joshua.a.hay@intel.com>, Alan Brady <alan.brady@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Phani Burra <phani.r.burra@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH net v2] idpf: Fix vport IRQ name leak on request failure
Date: Sun,  4 Oct 2026 14:08:39 -0400
Message-ID: <20261004180954.163789-1-oss.patchbox@gmail.com>
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

idpf_vport_intr_req_irq() allocates a name for each vector IRQ before
calling request_irq(). On success, the name is released later through
kfree(free_irq()), but when request_irq() fails, the error path only
unwinds the previous vectors and the name for the failed one is leaked.

Free the allocated name on the request_irq() failure path, as done for
the mailbox IRQ in commit 9bff30482c10 ("idpf: Fix mailbox IRQ name leak
on request failure"). While at it, fail with -ENOMEM when the name
cannot be allocated instead of requesting the IRQ without a name.

Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
Changes in v2:
- Correct the Fixes: tag (Simon Horman)
- Handle kasprintf() failure (Simon Horman)

v1: https://lore.kernel.org/all/20260923234819.702327-1-oss.patchbox@gmail.com/

Compile-tested only (x86_64 defconfig + CONFIG_IDPF=m, W=1).

 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 4311ffa30bb1..af3213eae393 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -4067,12 +4067,17 @@ static int idpf_vport_intr_req_irq(struct idpf_vport *vport,
 
 		name = kasprintf(GFP_KERNEL, "%s-%s-%s-%d", drv_name, if_name,
 				 vec_name, vector);
+		if (!name) {
+			err = -ENOMEM;
+			goto free_q_irqs;
+		}
 
 		err = request_irq(irq_num, idpf_vport_intr_clean_queues, 0,
 				  name, q_vector);
 		if (err) {
 			netdev_err(vport->netdev,
 				   "Request_irq failed, error: %d\n", err);
+			kfree(name);
 			goto free_q_irqs;
 		}
 

base-commit: 551c722f40809618230001baccf219193e22fc5a
-- 
2.43.0

