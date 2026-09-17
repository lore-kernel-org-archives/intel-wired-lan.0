Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A389FC982C1
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Sep 2026 06:56:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 527F34075D;
	Thu, 17 Sep 2026 06:56:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ACfgUA2X5Ukf; Thu, 17 Sep 2026 06:56:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AA29E406A7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789628217;
	b=EhGhofbQf1lcdLChQQweWFP+ydfAT5VeRlyCw+oIlPUbp8v1UQFMozdAEm6W84T43sZZ
	 qnX511srwRIXU3zlPu1tOwRgfoZd6AlqtbBUzUPh9Ab63dK2c75yFVsgvTuiyAaZkhUvx
	 ciQB98arKYSAvTaF1ulifUZ3TONCanPheuE7Q6rNG4E0m5aHqH2NvSwn/1p1rihCmhgXu
	 1wVIWOqywqf+SB5x4SNMstjzkcfGWN1zOPlH+prbo8K/4h6aM0A2KqNkgnOzQ3xmHGBep
	 voGeNHUWeGk+RioVwtcbXF8fWjhyXZF3BQIW8iGBZhnJReipL1Nf8JJlVxFFMdxmzbA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789628217;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=W7QVInwog2OZRxOhpEnTpBcnqOtnYxTp6Qw+8w3MYWo=;
	b=f/zQ/KgGXnbOdwp+D+iJFUsu2acyHzwqU6FFEGYdwebn1iZ2pRQqmVATltOQ9O7x3/Kq
	 +WQOovzui+bbgFRAwikO1UX+tHc7+KmnhJV8jycpJfM+K/6pq+xCc2QriUorCt9ddXVD+
	 aQpz0Izy8tOTeY1wWuY+T0lKLOYwinGM9pwqxk0PK46XLLZzwCD9HvSGcoj8JtINj/yom
	 rBcJ1iLNKffZlQoJv/yaxdLZyPsO8Z6lMe5INCzY599rulmpRBKvUZ8vDmivIIAhGzbJ9
	 DlspoM5aNE6zPgryteU6nj7XMD2hQbczMWP20rp4Y8OrMVZeb1qCOKC5GhHqbtYhuOg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789628217;
	bh=W7QVInwog2OZRxOhpEnTpBcnqOtnYxTp6Qw+8w3MYWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WXLzdjupm2167kDLX3GjXEFAGPZpksZuD70Ke1ejbnlZvCQd8A+G811wEy06Vm5n2
	 0ZCnJTjTDgXoeUpwn5NFRuMbwqvte1CKmmVZgxj4fICaCIT+5W8afrFn4viPw5iJ8a
	 grdLUxEh2oh24qM1GR87qNrGDELWNYW6un43aODNUBkZOVRgkXYb3HtsWZK+SrZYzx
	 7LgAgytTWrKGASNBiIOQQ5MJW1MdamTt2SjuX8YzVR0Z8NR/m6HgyNBWL0CyYN5A6T
	 4QA+AQ8rgqbiBB5Uh7IPhCq0GM3MEOB3Ab1iJASNWjYXR4cUvnpnIfYvcmgT8QJwxt
	 y/ethXNjS+bhA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA29E406A7;
	Thu, 17 Sep 2026 06:56:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CD23C42D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 06:56:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B289380C3D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 06:56:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BufLKoOpf5TR for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Sep 2026 06:56:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F30C280A91
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=220.197.31.7
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789628214;
 b=V46xzV6K+i6IrkolC9jn4VsU4qZ/uirmXP3Yicv+9jqAHQb8i3DhGf7KbpUIXTxgBTb5
 JinTGjMd7t58pi4b1eLfBBSdX3STS/4DiMBFRfQfDH5QUhUwjYSXK7NOyEBQZqRWYjMDj
 m4lWh2nVg6qDSfdbKe+W9WSWDgWgxHE/3JCyi25PRg7jt52ey9oG5BfmGrliwqTHwoIFa
 tiJaOkMzEFIp88UgF91toirKFqHosKSZt65n1I4Lq/ktUbwXGWO/yw0LLLDCxoo5pe/3U
 d+yJINtImXg8gsAvqY/OE/TiWuHFIiCH8AYSJedBjasSoWPiyZDBN3oAGjk57CBZHhw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789628214;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
 X-CM-SenderInfo;
 bh=W7QVInwog2OZRxOhpEnTpBcnqOtnYxTp6Qw+8w3MYWo=;
 b=BRdUUEgHRdrmDUENxvTMiNkpvBJwRDiWYMg1MjGDJQGAs6DlxxtgwByPTg5GD7z0H6O2
 a9LmoW6qcPQWwV5O3PkyUJ7D+JwfW41Nh/fFrGx3+0N2+FHSMhYkz7q6nGdgPfsGHBmnd
 6Lo+VvIGc176WzMAJfrTkGVXUlSaHwoqByZv6VaFKzD8FbRqeZci2JiEclHhVmKBzPdTa
 VH4O0Uda6ZVl5lAK0wCt7fRFdq1ceKBFK5k9PrNHL02jNAdkamAY7wvkrd+watjKfIAGb
 QIirt4y85I2MIfTsImb0iOlCT1b3bGjZaSGmdZnl2BOhfnM/C1v79FBxbfWeXOQfctQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=126.com; 
 dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=ovrsHTcz; 
 arc=none smtp.remote-ip=220.197.31.7
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.7;
 helo=m16.mail.126.com; envelope-from=xiaolinkui@126.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=ovrsHTcz
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F30C280A91
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 06:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=W7
 QVInwog2OZRxOhpEnTpBcnqOtnYxTp6Qw+8w3MYWo=; b=ovrsHTczf1wDCRLPbL
 pj5zMbxRBCkQ8z2tCJKCIWKzDn9JGNNnJYCnFNAG6AvmNIhyKyD9jfHCKsjwFyzA
 kN96ClZwkSd2W+352Gbv4mabM3KR26ZLslU3PChxAWNdrmIufshm5zrcHAV0ITpo
 BulBxn2/cWMRn8SRmJ3PfidBI=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id
 _____wD3X7IAj6tqQTSDBQ--.47835S3; 
 Thu, 17 Sep 2026 14:56:02 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jedrzej.jagielski@intel.com, kees@kernel.org, aleksandr.loktionov@intel.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [Intel-wired-lan] [PATCH net v2 2/2] ixgbe: rename the EMP reset
 timeout constant
Date: Thu, 17 Sep 2026 14:54:36 +0800
Message-Id: <20260917065436.1181073-2-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260917065436.1181073-1-xiaolinkui@126.com>
References: <20260917065436.1181073-1-xiaolinkui@126.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3X7IAj6tqQTSDBQ--.47835S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF1fCF47Cr18CryrGw15Jwb_yoW8XrW7pF
 WUXasakr1fJr4Iga40vay8AF9xW3WDKrW3KFWSy3y5u3Z8tr1DKrn5try3tryIyrZ5uF4x
 Xr1j9rZYya1fCw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UVMKtUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqQJpQGqrjwLwgwAA39
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

IXGBE_DEVLINK_RELOAD_TIMEOUT_SEC is misleading: the value counts 0.5 s
poll iterations, not seconds, as the comment right above it already
explains. Rename it to IXGBE_DEVLINK_RELOAD_MAX_ITER, which says what the
value actually is.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 drivers/net/ethernet/intel/ixgbe/devlink/devlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
index 781f13240a0d..15b14c5a7c4e 100644
--- a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
@@ -430,7 +430,7 @@ static int ixgbe_devlink_reload_empr_start(struct devlink *devlink,
 }
 
 /*Wait for 10 sec with 0.5 sec tic. EMPR takes no less than half of a sec */
-#define IXGBE_DEVLINK_RELOAD_TIMEOUT_SEC	20
+#define IXGBE_DEVLINK_RELOAD_MAX_ITER	20
 
 /**
  * ixgbe_devlink_reload_empr_finish - finishes EMP reset
@@ -464,7 +464,7 @@ static int ixgbe_devlink_reload_empr_finish(struct devlink *devlink,
 
 		fwsm = IXGBE_READ_REG(hw, IXGBE_FWSM(hw));
 
-		if (i++ >= IXGBE_DEVLINK_RELOAD_TIMEOUT_SEC)
+		if (i++ >= IXGBE_DEVLINK_RELOAD_MAX_ITER)
 			return -ETIME;
 
 	} while (!(fwsm & IXGBE_FWSM_FW_VAL_BIT));
-- 
2.25.1

