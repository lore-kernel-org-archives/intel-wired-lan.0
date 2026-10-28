Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D46D606A31A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 28 Oct 2026 09:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Og+NUVSK;
	dkim=pass (1024-bit key, unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=PIDJJGgA
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EC79580D18;
	Wed, 28 Oct 2026 09:32:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5aL8a_euYPQO; Wed, 28 Oct 2026 09:32:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5097C80D1D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793179920;
	b=MemW0eEeL8O6GtwhQ0mIp/DS8dnazD7WolMRb/BlWsHD0QYtOtVawVyYrlwj54WVTeCd
	 8VTnxu5FDQBxB5AHRm+CNCflXk1/NEhWx/JVuRuxZVkezGdGy/kulPB/kHK5fPqkxg6ZG
	 0zHhkwj4ECkmA45XX+wjBPwrUx4Al2A/tkvpEu93BXM+TJ4zsIQAuasdW+xBjBO5UDCTZ
	 wIysDbG8fsktQO1fK/a3GBV0iy4bKevdycGbzILM4gQRSooy+b3vjILxyusgFZnrxfRKL
	 yoZ8RRPRSZ5w4NhY/knU2AOc56hvtWpOauaX1UC8+ZEz+BTEsvhKd5i88j1q7/REltA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793179920;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dgRvAAs+iyfQ3xtuuwMg/qvfxKYNvDAq9ZIFiXETCAU=;
	b=Q8V/8Ktrzu5yUT3nfQudfD+k+Dxax10ijPQtmGHclwEg/uPpVldzDCfIA6SHqwqAHwSv
	 vPld/7uG6YReDGFY/00hzTxjt0qihOxitiVp5Vhw7YpelvnZxO53/PWvbWoPLuOWsWNGz
	 JoudsSaiKqETKj92oSJfr3TUEPeQez79xnJtjoycIjiclBp7k3CYl76b/w9f+DzvrmY52
	 lIe8Lkiy8kn5AW0ED6yPzYoAzJkPxUYD7XDcxoGEC6sMuvIgZNmeBHOwg417hyuzx54c4
	 ZL61SpLbQzxvXX4QrgqtAMpV5WvH8bg1Gj+rKKhO8rkH/RXvKKTNODAeuLynB75qRNg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793179920;
	bh=dgRvAAs+iyfQ3xtuuwMg/qvfxKYNvDAq9ZIFiXETCAU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Og+NUVSKsa4zZyDxFnQMIrVV7pEzPEaZYdz/Y8f1X+1C+UB2u+OB3WBjs/JBJB0f9
	 lDL//wdwR/zn12pY/e3bCVgnZycb0aVeCeKQm4RKJOIda2KlQFP9EriccdLgnLxj9x
	 ymo5ooZgKAK4Mtvlfxx/DcKiIHuNpXaMEo2wG6HoWDaM4cE02NL5QRSWH+Er6W3iEM
	 wYxNbR56VjwnwEv+RJoFOgeSML7bahlxKj5VV+56Blh0MD+r4vCPo+vOfldNGzz5lv
	 U3kAoOuLSKLxPmBEYr+AIhj7hR9fiFQA8mDPLRBjknFmrLK5kVj5sAyhMDur8DKuEk
	 z3uQs42pDB/mg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5097C80D1D;
	Wed, 28 Oct 2026 09:32:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0CF27529
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 09:31:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E73B160658
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 09:31:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rEMMp8QHsHEu for <intel-wired-lan@lists.osuosl.org>;
 Wed, 28 Oct 2026 09:31:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2B9F3605F1
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=117.135.210.6
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793179916;
 b=mG6E72fujcYGxOOgmnyHxgE3T27HeDV7pAesj1ZmnlSQe1wSGjCQekr6BM1fA1lgJNfy
 ZqCMdsBTTCXWZhP9TDwbVz6ymMysO0iiVWXX5RKbZZ96NcbRq+Y3IEd7bibEtzw4dcoCK
 a7GUq99bLuhgdPte705pfoZccK0D5JR5NR1lUtUTazR6mrPAXQck6Od7jZy2XVSXV2BiJ
 lw6YxeVyVWxreAsYjlC5alcc3hll1871BpcfbkjnHznMssZhw55OR87v5KQJrIHTIkkve
 AJHK3XWD8cjgXfqgLoYXau+PxTUCYw+z5KVphCGv9A9n+qMDY7civ/FdY/vxsX/+yAw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793179916;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
 bh=dgRvAAs+iyfQ3xtuuwMg/qvfxKYNvDAq9ZIFiXETCAU=;
 b=F4hSBkJFR87u5eopb743hLv8jctRxeIs7q1B0KpWEMxduHfJnpramW5uGlD5pAjnGBTR
 UhtQir7OdpUPlkKdmfS7SY7fr11g7y7SZ/9w50otlr7FtieAQRPovDA9BI9If1cOqMazs
 32E36CNtDPD0e1W1F1F+5a5Yn1TkY4oWTbHB51bP0PzhonWyYLqCE52EO7KCUg/2euqYf
 pLrsv/+CgxluqB9JAbybmf150BBSgebCbFjYLNhzBG7RZpyTEuK5ckqmDwsQx4/xlSN3K
 w63GMpn1Bnq+9EJaQd/B4C5cA14CYywrgRcpT0w6BxUspfKR3gsTipdpQUoPHR8QD/g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=126.com;
 dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=PIDJJGgA; 
 arc=none smtp.remote-ip=117.135.210.6
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.6;
 helo=m16.mail.126.com; envelope-from=xiaolinkui@126.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=PIDJJGgA
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2B9F3605F1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 09:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=dg
 RvAAs+iyfQ3xtuuwMg/qvfxKYNvDAq9ZIFiXETCAU=; b=PIDJJGgAqta+hyodIm
 xPFZEYgJnJ0StM8s9r3ulHDt6cvYWtSgDp/b5PeGlTVYCrzMZBiI/+h8ynlmWC1x
 stGCYMwqlsGJP8phLhLG32yX4sXk5MytUaQyu27/4ujolS7aL8YSMMQC/JivsPzP
 oVtEUTuUGiHfrbiOYB75GLd6I=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id
 _____wD3l97nwOFq+UpZBw--.58427S2; 
 Wed, 28 Oct 2026 17:31:19 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>,
 stable@vger.kernel.org
Subject: [PATCH iwl-net] e1000e: close and reattach the netdev when
 e1000e_pm_thaw() fails
Date: Wed, 28 Oct 2026 17:31:17 +0800
Message-Id: <20261028093117.2313438-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3l97nwOFq+UpZBw--.58427S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFy7trWxWw4DGw4xGFW3KFg_yoW5Jw1rp3
 yUuas8ArsYqrW7Ww17Xa1jyF98Wa1kA345CF12kwsY9rZ8X34j9r4rKay7Cr4xCrWrJ3yY
 qrn8Z348uayDAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ULVysUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlQd8U2rhwOcPAwAA3d
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Linkui Xiao <xiaolinkui@kylinos.cn>

e1000e_pm_thaw() re-requests the interrupts that e1000e_pm_freeze()
released and jumps to the err_irq label when e1000_request_irq()
fails, which skips netif_device_attach(). The netdev is therefore left
detached while the interface is still IFF_UP: e1000e_down() stopped
the transmit queue and no interrupt is registered, but __dev_open()
refuses to open a netdev that is not present, so the interface can be
brought down and never up again. e1000e_pm_freeze() keeps it in that
state as well, since it only tears the interface down when the device
was present.

Attaching the netdev unconditionally is not enough. The driver uses
netif_device_present() as the marker for "the interrupts are
registered" - both e1000e_pm_freeze() and e1000e_close() rely on it to
decide whether e1000_free_irq() has to be called - so attaching an
interface whose e1000_request_irq() failed would make the next
teardown call free_irq() on a line that has no handler of ours
registered and trip the "Trying to free already-free IRQ" warning.

Close the interface while the netdev is still detached instead, so
that e1000e_close() skips the hardware and interrupt teardown, and
attach the netdev right afterwards. The interface is then in a
consistent state: the rings are released, NAPI is disabled, no
interrupt is registered and user space can bring it up again, which
requests the interrupts from e1000e_open().

Fixes: 2800209994f8 ("e1000e: Refactor PM flows")
Cc: stable@vger.kernel.org
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 7ae33273734f..6da613025a1a 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6911,7 +6911,19 @@ static int e1000e_pm_thaw(struct device *dev)
 	}
 
 	netif_device_attach(netdev);
+	rtnl_unlock();
+
+	return rc;
+
 err_irq:
+	/* The interrupts could not be restored, so the interface cannot
+	 * be used. Close it while the netdev is still detached, which
+	 * makes e1000e_close() skip the hardware and interrupt teardown,
+	 * and attach the netdev afterwards so that it can be brought up
+	 * again.
+	 */
+	dev_close(netdev);
+	netif_device_attach(netdev);
 	rtnl_unlock();
 
 	return rc;
-- 
2.25.1

