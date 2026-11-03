Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02905606BF87
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Nov 2026 10:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=8iJBjEbT
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D590340608;
	Tue,  3 Nov 2026 10:10:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FPl_3hzwYmi5; Tue,  3 Nov 2026 10:10:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 706D24055A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793700652;
	b=PYjWMREdK0oLmHQ+rB2l/5NIOXRvVs7kbFo7zvU0wKNKB0npeCYjacqbGFDYp8nPEEfe
	 tL9YTBRTd2cy3TNMMiAO990d6YYjYlXeY65ST0ZG0kFEHkJabkI002EQQBUxABO+6qLgG
	 PTwVroVtvuWunb7KaXXOyIaXkh/26Zt9EwYvI1HrlZpLP1SaPbZ9vsv9lOjvQeTKXQZ20
	 p4RwYAunHwpWtwSXaAfr265GuCTTvALAxUEc3UGXKs0lUAn0tWwfUZAo2/UFEsVKqeQ5Y
	 GA9JRLglRnnUcLnY9HCxrO2pEBR8a0O8u+vQRzd8phReI1lOw4riSLj9k6xJrLIrroA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793700652;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-Originating-IP:X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rZ9WlIoFMrK8NZbiJMk1yzq1Nay459FdXX6Lq4xdVxo=;
	b=LhKHN45H1c9LyEKWHxQFESECIuXVVhQUZ8Vz3kAh6HDZWf+8wKUyZ0rDtQXRY8VpNKEj
	 JPPb8tnHo10TSKv4yDP/FrHtJ+ii8SMpz4T0/OKsyC5+mbB7574laKB4cMUnhKTNmfPGH
	 N8AvV4mbunnN6xLOKfOdxSUK5xLE6rfq6jr1NiPASxA+/8On896TtQEfWCIkLHgSW82Ok
	 kltb+08KXBNqcT8F0zSb2wdjb1o5VhRpijTIH5R8hqKZrDl5r+tdjC8rHymVUbXTmCSED
	 Z4OaVfdKh+cJHvlPEzFXEnX1UiCDRbjgea/Purs1d90dnqrc0TmghycJrhfHOS8pteg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793700652;
	bh=rZ9WlIoFMrK8NZbiJMk1yzq1Nay459FdXX6Lq4xdVxo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=8iJBjEbT4VLSfSlbk3pIPsKWFI06iztlTnCANL1JiY6Ct88SzmrVQpijHP/yDfIVZ
	 z5XxSDgGcZALktoOfRuNhZxE2d5FFBTtpJLLMzALvwrP6sQ8IrbofgrmhHbvNUuWFp
	 VZzabNGs+Qa2OFidRcVh3hbUpaS4JylJLglHFJSpX/TTTkUgduy1nM+yom88L3SuCm
	 giLWc0KRHQ/tLaLH5PMq1ZMpdvc0OY9cNShwaqvwOvBjZ0l/sdIYP+xRYVoTqf4PiG
	 AyfFFGK8iENR76ZVK8hs23IdYv0Iy176bznKailnsk9I48RxpPsUQeHmJCOVYdJxjm
	 g6IHRCLYRXY9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 706D24055A;
	Tue,  3 Nov 2026 10:10:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0F4ECA15
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:10:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E8CFF60670
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:10:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AnNOfMy0fxoa for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Nov 2026 10:10:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8323760642
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793700649;
 b=URoM4hKfVbo/25uC4rpWqM3W6Wt6JdUXAjoGCSVlVJzjCfWNPvjpcBBDNQJQtTa8+o3M
 twIoYYGEnqLjcOfqqUWV76Q0JGg6d8Ziy//Bm+G9sra5DrQ3yItrAfcYKXRDvLakb1uOR
 jeU0mvuwLHu+NAunIH1xAhk40bYOXEZTHetR82LK6BKZrFbpl/zld8ftrxHuUaXXmORQb
 NNmhRtE/tnrp11obsjy3CdwX6f7AecL45BxiPWwQ6G+pZQ+q+9Xd8d14V67jy14NNqXOo
 Kan+nN+IDODaLrPvGKHSNMlLcQMvXQDeOkN5ScscvRV1+mKiScjOH6lRpArCvnyiHPg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793700649;
 h=X-Greylist:Received-SPF:Received:From:To:Cc:Subject:Date:Message-Id:
 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
 bh=rZ9WlIoFMrK8NZbiJMk1yzq1Nay459FdXX6Lq4xdVxo=;
 b=SJ5Ct1lSv+aUMyhDQWRg6YBzXxJbzVFDYnj3jPcAxzaBgbgM96cH9T3d5qAXHz6miAJX
 RvIa7vhYT2YO6V+ruveKwAOwjNF69Bwg62u4mFYzidJzONrtyFCgJJ8wmxBx/3mWEwEkf
 hRObr1mo6g0VrTbI39CBSrDy3uv/GK9fgkZyOLztx5L5JUUtLL0a+iLYDdbFtCA3cQSjq
 Qvjh3FrNkmuMLcIPQpC6aH5XIXn7FhFJLD4LHE64SkAReuLz/YLnK5aiJLXwZbmz6IQ3T
 n501iaLo1hdNi/Gzf/LgBLKWfBiz+phm1kLnedQgrVGAJS7vPksPOkbXgcOGr8pqzNQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=iscas.ac.cn;
 arc=none smtp.remote-ip=159.226.251.81
X-Greylist: delayed 319 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 03 Nov 2026 10:10:48 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=159.226.251.81;
 helo=cstnet.cn; envelope-from=vulab@iscas.ac.cn; receiver=<UNKNOWN> 
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8323760642
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:10:47 +0000 (UTC)
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
 by APP-03 (Coremail) with SMTP id rQCowAA3QpPhselqcXs7AA--.2857S2;
 Tue, 03 Nov 2026 18:05:21 +0800 (CST)
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
Subject: [PATCH] ice: release the VF reference in the switchdev trust path
Date: Tue,  3 Nov 2026 10:05:30 +0000
Message-Id: <20261103100530.1309907-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAA3QpPhselqcXs7AA--.2857S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw1rKr43WFykJF4kuF4DJwb_yoWkKFb_Ww
 43Zr93Xr4UuFnY9w4Fkr13u3s29FyDWasYya9Fy393G347Cr17CrykWrnxXr4IgFZ7uFyD
 Zw1a9FWSy3WYgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbaxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
 Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
 0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
 jxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVWxJr0_GcWlOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
 n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
 kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
 67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8Jw
 CI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
 CwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
 BIdaVFxhVjvjDU0xZFpf9x0JjU-B_UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgIAA2rpnIRi4AABsf
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

ice_set_vf_trust() takes a reference on the VF with ice_get_vf_by_id()
and then rejects the request when the PF is in switchdev mode without
dropping that reference.

Return through the existing out_put_vf label so the VF reference is
released on this path too.

Fixes: 1281b7459657 ("ice: Forbid trusted VFs in switchdev mode")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index c49f48b5ae38..90bf1becbc3d 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -1400,7 +1400,8 @@ int ice_set_vf_trust(struct net_device *netdev, int vf_id, bool trusted)
 
 	if (ice_is_eswitch_mode_switchdev(pf)) {
 		dev_info(ice_pf_to_dev(pf), "Trusted VF is forbidden in switchdev mode\n");
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		goto out_put_vf;
 	}
 
 	ret = ice_check_vf_ready_for_cfg(vf);
-- 
2.34.1

