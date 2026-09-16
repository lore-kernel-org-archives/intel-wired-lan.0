Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27918C88E77
	for <intel-wired-lan@archiver.kernel.org>; Wed, 16 Sep 2026 13:53:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B991C607D2;
	Wed, 16 Sep 2026 13:53:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a259KwUBhU9K; Wed, 16 Sep 2026 13:53:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 23020607FC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789566818;
	b=cxX0ISTV4rH9AXsSSX5/HlT43PrlUJiUC0sScCYTy/jAJV1IGKyyYWg7z5ckv/YN+Tw0
	 6BylXMUEElesaLQeGINGT1NlyLUcoYtTzxUVoqB+eV8Gvxs8c8CrTLcXmWLtAmyIGQYPa
	 TPLhfmtCVyl8gsqEXVZQKNwu8mDNVmyRzSrZlbqFkniKeKF7PX3gJRHwfJpDhucepEU8Y
	 E2cmcOUnGkTlCEtetQJEubloI3PLbjavkJPBCwmhTVRHDUeIuwa3jirCxDCsrBgOIArt6
	 YcNYqKBRIREjo192eg4cyU/oApJp5SR8ib+Q6M1ZyAviu1FuvXdE35VRCqa3aVPZRsA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789566818;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=UxHOqLqY0ioEbW+y+gjnHEMXBft+GOWtp81bJHPmr4o=;
	b=Q9d/JoQ/CqqfBQNSvzRWfaNCVcJGLMww6R/VPmSqOCX4r0PR85zMkJQQfRz1LGQaJhNb
	 t1b1aHVhEMTZLLhjtKoKJgKt8auSULOnaKf2JI9vKmIQNlcdNb/ftfFUEnzjiOIt67R3F
	 2j++7Ex4cnKpv97Yi3uI/WiSBpXRkdA6Ick+S8V9V6R28yPZHKwt2wsM+w5E7LDgTTZNv
	 Lo23XC17AD+243wEaDB480xP2rE2xTiveI0rgbzLFCmVV7D5TljnXRtCtDD80vws9cLVq
	 5KyHq1nkRc0NQrD9NBRDyEPnCgh/O4EZC9iDJ1OLmsJp3YGxwVPYGL/IxOcVjWjTgDQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=iuIxhXR6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789566818;
	bh=UxHOqLqY0ioEbW+y+gjnHEMXBft+GOWtp81bJHPmr4o=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=02BzAqxb5Tlj+PaPG79pyDVvs1euwKykQaAPYe6rB4r4gq2St8wzd0/5cc5TSAnOw
	 PiFh/NjolCl/3KOAxvJZAy03918BvoxFqnqrhZSTtZ5FXsrv2k1pEtqgFy+iFjM0C7
	 y0iY4acDYbNIv/fg2AyGI1D+3ymKS48xTW+cXmbqgdx6HWVSY6j/lLOoQsWLgQtdMh
	 hl4b/L/Jc4G9TYkrEIpaXQkahWR1pHs5sqfFvzBfNlz07iuOEKKzbtgg6syXJKMQSn
	 8nElGhbbAVFec89ltPZaFnpiBsL2L5OLjdi9at/lOjb5R/xjN2aoVBB2HXd50/EJUs
	 YGP6wQM35/5Ow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 23020607FC;
	Wed, 16 Sep 2026 13:53:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1432F388
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 13:53:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EE4CA607FC
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 13:53:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WtGrXU_hmNEp for <intel-wired-lan@lists.osuosl.org>;
 Wed, 16 Sep 2026 13:53:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 86B31607D2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=220.197.31.8
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789566816;
 b=HnC9mFL7p/yCuEtnPRHjNe1LaGY8lCerYUzqMGjKviaVP+Yo31+ozWybhk9U6DSg52lM
 t57NNbkEtmjlaQFi0HGEbLjAU6px/TnHg2WtEzuhlNIwiTF28G4MhkWVplRUPYYHfJEVt
 eyXvEUm4A7qLV35jRxg8V6RT6pdx9+BIXD6uTCNrCgS1Ibi8diJ1G7+YdpqczBjdgNPJ6
 Bn75uU0gUAuVRYMjEAOxAi0w+FWljYNi9j5xvi3QeoS3csb9Cp0ci5ieXEBHutBUSuEVP
 XWeRKVVtL9GdWchPLmmvA+Nl9otO0flizo2bqBq/8w2MF3T1GzWef5dhqOtthZmHgow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789566816;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
 bh=UxHOqLqY0ioEbW+y+gjnHEMXBft+GOWtp81bJHPmr4o=;
 b=krWEbkPi+GE3v1X1rltaTX1Gjdzv0a72vhWOnFFYHG5kv7+iiWttGW1DTawJDwOdRCSG
 5WF8iUXvuTSX701gNe5DBDqoS9w8asNXyfSt5TrIBSxxZKhZNGI00EYvvTahQmuqtIQdY
 wdYy5jkW9vP9eP5aNqPv7D5tBeDOugIVRfWLwSODMya/ngpRkixGRMA3Fv3kEnGd64V2h
 t3IjyjSsmC2CxNsID5wPXxqZVIn3GBCy4OvRrZ2WtaOEgQAkCZAZAgmhHj8T4+eI2fu6V
 ckwnYWdJIOJ9CfoD/QnfdbaiBFRX0Gs42azmBRPoj94OYscN2LQs9qZMX0vJdxmvyuQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=126.com; 
 dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=iuIxhXR6; 
 arc=none smtp.remote-ip=220.197.31.8
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.8;
 helo=m16.mail.126.com; envelope-from=xiaolinkui@126.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=126.com header.i=@126.com
 header.a=rsa-sha256 header.s=s110527 header.b=iuIxhXR6
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 86B31607D2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 13:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ux
 HOqLqY0ioEbW+y+gjnHEMXBft+GOWtp81bJHPmr4o=; b=iuIxhXR6uz/47dNXIc
 6sqlj+Gunny0Wz7yUfYi9IUA8JJsqES5Ozihy/KBOv2HJkO4BbFe3Qyvs+U6j27C
 jJ1Z6hqIgQS/+XjchYDJpv0LMKw8Za1AXoTGkMGHJuVJDlMAnCDKQGUYwgpz/Grm
 YRZmFU7cqwslpi4zZHgrBAhAo=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id
 _____wD3V803n6pqYsHmBQ--.44918S2; 
 Wed, 16 Sep 2026 21:52:56 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>,
 stable@vger.kernel.org
Subject: [Intel-wired-lan] [PATCH net] igb: fix uninitialized first word in
 igb_set_eeprom()
Date: Wed, 16 Sep 2026 21:52:54 +0800
Message-Id: <20260916135254.1016847-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3V803n6pqYsHmBQ--.44918S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw47KrW7ArW7CF4UCFy8Xwb_yoW8WF18pF
 WUCasa93y8XrnrWa1kGa18Aa4Dt3W8trWYgF10k3yF9ws8A393Zry2q3yUGryYkrZ5uFsI
 kFs7Cwn8A3WDXaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ULFxUUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlRg7EmqqnzjGbgAA3r
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

igb_set_eeprom() does a read/modify/write of the first EEPROM word when
the requested range does not start on a word boundary. The error from
that read is stored in ret_val but never checked, so the function keeps
going with an eeprom_buff[0] that kmalloc() left uninitialised and
programs it into the NVM. The read failure is not even reported, because
ret_val is overwritten by the result of the write below.

The write is followed by nvm.ops.update(), so the corrupted word is
covered by a fresh checksum and the damage survives a reload.

The read of the last word already bails out on error, do the same for the
first one. Skipping the write also keeps the stale ret_val from being
lost, and igb_set_fw_version() is correctly not called since the NVM was
left untouched.

Fixes: 9d5c824399de ("igb: PCI-Express 82575 Gigabit Ethernet driver")
Cc: stable@vger.kernel.org
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 65014a54a6d1..19ff9eb2c4d2 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -814,6 +814,8 @@ static int igb_set_eeprom(struct net_device *netdev,
 		 */
 		ret_val = hw->nvm.ops.read(hw, first_word, 1,
 					    &eeprom_buff[0]);
+		if (ret_val)
+			goto out;
 		ptr++;
 	}
 	if (((eeprom->offset + eeprom->len) & 1) && (ret_val == 0)) {
-- 
2.25.1

