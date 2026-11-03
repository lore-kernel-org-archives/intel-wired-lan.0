Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9929E6082BF4
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Nov 2026 10:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=OuEKEKqp
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 774508096A;
	Tue,  3 Nov 2026 10:28:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oEefHqb3W3R1; Tue,  3 Nov 2026 10:28:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ACCD880984
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793701729;
	b=XYntYrNezEbz/ClcNMDOnqLxqoQekpB+kWcQ85L66NGT/8BJkaHrZgpJ8CW8zUjwKnoq
	 b6vkDL0z0qVW3SqtkgQNns4lL71ufSF5c7Ygv3IDXBJ88euXRUgeXuypVlsq4I1GJ+acG
	 w4gDOFIgwJl06Nph/mkVMUL7hFXfP/xDTwzd2i+igAkiJk100t//KXO8kHVIImmIKAn29
	 p5OC6/VWT0m/eu6i6TErpwzTYof1/8dZjz0FdlZ4bi9PTLAarm+x6s6CwgmPb7RnFKt+C
	 ZSVJr0YMusFInVYL4/2VGVZUBY9XOTbzqCDOfRmQVKG3oEE9M6Rof20wMuUCx6J0NGA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793701729;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-Originating-IP:X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=B/4a/m4lL4uRC4yyGPUUOdugFBsiVv9dUUI5/YZ8COU=;
	b=AsyKmyS9KzG10Pg8eggyELpGAW1lO795Iy67ewFZup40zfT2wE4cKBLzkKme+qhjgfLv
	 fNa97XSNNkgvHWgafZs+8mx02u1/jmJ4pfxYFlx6YkNvbuymncR5RIjeq1JvUYTi/3J1K
	 yseZ7tytvblH2utzdfXyhTbISVtjR4Z8X8lfbaES3aJlkw/Zai8iXC9DQW6MGJSkSCZXB
	 UiZCDxiD1mvkazcSbD6XxOIi+H2wMuRjrBUigKJTpwa+1OAYBnyNffj+ZkGV+cFasQxP5
	 3MTccrwki46cMylk2yKlDNHygrj+M/AXEirWy/X2IuqtXakEBTwctWhbPfkc6hzT+Cg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793701729;
	bh=B/4a/m4lL4uRC4yyGPUUOdugFBsiVv9dUUI5/YZ8COU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OuEKEKqpqv/aBPObDmNI7kdPF9Pc1fkJtLy/aDegpF73m12Yp4ttRblarQ6oH3Szl
	 VXqB65NkR2teGJ2g6gio0eRw/JeGxXIUgz69vtSZXKqFZkopxTOK6nj1ZmSFOW/qH7
	 YABvsBrw09nRx7vl8I7Hm5oR/0wSS6ryDoFSh15Hnz16iROJRT52YyCZlAJvkqmatk
	 rT8baRB+hP2qlKTw+atg0hh4z5PAW+i1m/CzTJ+pqd7N5IOLlI5Mx3OM1Nj5SttrXV
	 60Cfwz+9gudYOZjpTx6RwMUXziYKUWnwvS7Bn1w+id1e9zTBH/4TxJKSB5C1xUGvl5
	 rcdNXqhKnJ0Xg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ACCD880984;
	Tue,  3 Nov 2026 10:28:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3260FA15
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:28:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 189A4606A0
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:28:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pSjF5b13Gk7u for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Nov 2026 10:28:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E493D60611
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793701727;
 b=kFLhijp78cKI4S9YB9uJiNk2G2b9dikpVtRbZLV78FH+a4BBM6ZNVhh//kGHCF+F0sn1
 qxUv4BO2rYi4LPVXaXKiIpBgHApnux1qe6EqemkSizYi9tS73B2WEVQ22kML8Z4wMIhti
 z4KCPXijhIqN0KKz8chOUnaXy+6rLiTRYVYc1oAdNsWa5Gh1cME1G20zeuk0ybJ7Whb9F
 NT0eB1l5A1AKG6sBYqBwZ+EpZRgPiIle7bimR9h8rCucNrHNOi6UxcPBjM61Sov+WSlZK
 8TniDOQdfdvmzuKohBVY6k4C4MMYlHE9yxduRzetX5x+sV9xpr2V+TeOHstWclN25kQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793701727;
 h=Received-SPF:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
 bh=B/4a/m4lL4uRC4yyGPUUOdugFBsiVv9dUUI5/YZ8COU=;
 b=npUH8XBXgHOvlMMkhlsLXbZsfUGuk9g2e7wuYLXvGUcjNQHH0iHdk10e58vbGOWhPRHh
 DE5H1+9H/kCSZHJOzOz4kRGfqLNAy40pXX00fBwDPM4RXOeVnMslZoNrZpsQaxZSZiU3N
 8mjZe6gaY3RcPEcckko+qrYEhzC5wvJWEZc/DLpDnUIGPfNIcN0BzgylITgYzUs6nO7mn
 1kYsa5Wm1L+FkjLWG7M9AxsrTMhcdcn0fe1BYWuDITu2v08nu5ludQDgV4SH0PLE667hO
 2vMA/6DsrDMFFKuaql53qGe/JjRqzL0ewnK1t91+dJgFrLHnUNSbGwkc4UchOZJiaHw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=iscas.ac.cn;
 arc=none smtp.remote-ip=159.226.251.81
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=159.226.251.81;
 helo=cstnet.cn; envelope-from=vulab@iscas.ac.cn; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E493D60611
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:28:45 +0000 (UTC)
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
 by APP-03 (Coremail) with SMTP id rQCowAB3h5hYt+lqY6k7AA--.2791S2;
 Tue, 03 Nov 2026 18:28:40 +0800 (CST)
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
Subject: [PATCH] igb: disable the PCI device when resume fails
Date: Tue,  3 Nov 2026 10:28:49 +0000
Message-Id: <20261103102849.1340413-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAB3h5hYt+lqY6k7AA--.2791S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw4rAF1xJFWfXFyfJr4DXFb_yoW8Gr15pF
 4UJa40kry8Xr17W3W8Gw1UAas8tayjy3yrGFn5uws5W3s8Aa4kXrWkXryjvFWktrWru3Zr
 tF42yw18Ca1kAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
 0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
 jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWxJr0_GcWlOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
 n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
 kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
 67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
 CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
 MIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0obIYCT
 nIWIevJa73UjIFyTuYvjfU7TmhDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAAAA2rpnOFv8gADsv
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If igb_init_interrupt_scheme() or __igb_open() fails after
pci_enable_device_mem() succeeded, __igb_resume() returns the error
without calling pci_disable_device(). The PCI enable count stays
elevated and the device remains enabled even though the driver failed
to resume it.

Disable the device on both failure paths.

Fixes: 9d5c824399de ("igb: PCI-Express 82575 Gigabit Ethernet driver")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index d4a897a8c82c..853bc99a1011 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -9621,6 +9621,7 @@ static int __igb_resume(struct device *dev, bool rpm)
 
 	if (igb_init_interrupt_scheme(adapter, true)) {
 		dev_err(&pdev->dev, "Unable to allocate memory for queues\n");
+		pci_disable_device(pdev);
 		return -ENOMEM;
 	}
 
@@ -9647,6 +9648,9 @@ static int __igb_resume(struct device *dev, bool rpm)
 	if (!rpm)
 		rtnl_unlock();
 
+	if (err)
+		pci_disable_device(pdev);
+
 	return err;
 }
 
-- 
2.34.1

