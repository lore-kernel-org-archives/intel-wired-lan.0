Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD36606A821
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Nov 2026 10:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=xquGxFoc
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0F0980E09;
	Tue,  3 Nov 2026 10:10:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id In87mGK9_yCH; Tue,  3 Nov 2026 10:10:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5865780BE7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793700656;
	b=ky5m5a1ld2HbQRAY+nEVPeKYpttuRLCdlo9bP0O0zL9jt2uuvRRZuFW58cYL5HhBKrSm
	 72A9gKKxH38l6IKRGrE2BvjEF6VQmnaC6oX3bITHpx28Mnin9WgnGdlQZ5pFJL8VyW+XU
	 YHHX+i6qDwvV3wC4lxFhUhZ9JVSWTzjt9Z49akcPXS1mulP0mntdS5DZ+AkhgOm0V1r4B
	 Vq27gazsYjHJxAtawdlC122RquiKFH4+bjgsMgmKsOwqnYTRKGvyR2ZRRnlCwK8Zp7/et
	 1EDTwna4r/+mO7/Pz5sEOcDbD7r0oWRppLesk+Y8dYp1Hd8T+DlmQbHxFOeKnr1b89g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793700656;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-Originating-IP:X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=pHILoWh8cXh4Ja4FuwvyiXCXnwvyYnbih+aBsUhTx5M=;
	b=iWXyurRVTx+Fn2ZFhMaYG8E97oz3jquVYCecgHxKvaBTG3IHyc74rz/AUxznx/mJOvKg
	 rHzJZYl3gCtLdFQp3l6+P4htWeGSFQDcYmhcOm+MGJB8eMIgWIkOdiA2Pph6nkwSjw5Iv
	 vYKtJY38KHoY34phag7ocCd62a48XyEPJv2tMtMVZvz5l6Mw6mGb7yGFjfiq9O/Nc9dhf
	 9lN0hyFgNvlK4Ua/WkVYOlGd/HY6ro3OuRNrU19ACzmmy2YmGTFzANQ/TfdSHnbIIsQfz
	 nNPca7z6yasBlNTFQCL48TZB2ab/EqhWL/h5dC5g67Dt+krG+A6sIaOVQaR/MynEjWg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793700656;
	bh=pHILoWh8cXh4Ja4FuwvyiXCXnwvyYnbih+aBsUhTx5M=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xquGxFoc8Jpr7MINpDRmkzvDd5w1Xg2PVRq5JDap7Eqwhggq77RsekyV0On9n94EV
	 Av0d/R0s3CBuwqDsPe2l5nUZRjrdOCl58e+SLqyfVNXuyouipoS0B0KtczeGz+B3WD
	 4dRGglKQHiFkljg9T4dz+yHHoDvSWTR7AbP2xHIQkG+tx9PPh0MKqDvSYd9mM/3qUR
	 GF2DtFi5Cn5E4XL+OV1D3gqgnDhRoQs3W5mfQGRyKL9gWyCcuHlIM5SoNMZkTzRxEE
	 Az7adUeqx5P8NkJQGauNCFX73pt3nUguaNmo+T0TeNfkCProQLMzjrEMwHNZdzwHpX
	 olVn05K9eErvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5865780BE7;
	Tue,  3 Nov 2026 10:10:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 56C7A2AC
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:10:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3C06F60670
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:10:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KryU-f1FkPZV for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Nov 2026 10:10:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0355D60642
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793700653;
 b=Zd5dGdeNZG+4+UAqfRXLeW19olm/Xvc5XfbweIXEiUq2zSyeg924ecoiyGIVlU17I8JM
 VPeJ3qewE3HHKWFf/xdxshEGj0D+nLikcuRDyuHyfQjwUgIFg1z1mVei47z0Kwl5/CX/B
 Ei/Zj+3Ssz8GMDJQYKGoiB1yPcCQekPZyQkBBcXOth4ujWExLoUZQx4kiP/EhGEGW0JUG
 eeLm96zJIj9COTbLucL66WVnlv1drS7kZoFa7eAU6HRsyqHVlyY6lbI2Jn5RcOwoC4eF1
 IPi7OnqIbXWu1/kIfPb3Oir/h8nRB1QLfSs2qmiyWlViLCSOo6s9sqYDcp+70wPFRSQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793700653;
 h=Received-SPF:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
 bh=pHILoWh8cXh4Ja4FuwvyiXCXnwvyYnbih+aBsUhTx5M=;
 b=bCtMg2xG5Mpn/mMacXynHkHg1hurKnfsfbB55cpFtmAlmPCtx4iesIkvs64znhFwaMR4
 SUXg41e5XDEVqXS4otIbXWGpqjAK4ZZxOWheS4JsvIaPDZVLv89H03oRBzNmDdH59rWJA
 KfntF9Kx7b0Jr+FDzMi2Wl87IaQy3noOW7g1yQ8BdkM7merqvVJYtm+iHPVewgFde+iHg
 1ynGk5VcKWllnQh5dYpyYoep6/Ao3AOCSlmpSXNMm345xANljF7+lP/UsItU++JckIo4o
 affDg68CY3UL0IWTy+6d5ayhXQ3irHWGHNBQ96D5tuIIg/goXeiC/mIpbxxuJfQHeSw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=iscas.ac.cn;
 arc=none smtp.remote-ip=159.226.251.81
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=159.226.251.81;
 helo=cstnet.cn; envelope-from=vulab@iscas.ac.cn; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0355D60642
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:10:52 +0000 (UTC)
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
 by APP-03 (Coremail) with SMTP id rQCowACHkpPlselql3s7AA--.2932S2;
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
Subject: [PATCH] net: ixgbevf: drop the SA reference if secpath_set() fails
Date: Tue,  3 Nov 2026 10:05:34 +0000
Message-Id: <20261103100534.1310071-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACHkpPlselql3s7AA--.2932S2
X-Coremail-Antispam: 1UD129KBjvJXoWrtw17Wr17tF4kGr13try3XFb_yoW8Jryfpa
 n8CFyj9ryrXw4jga4DXa1kuF9akayxtrW5GryFkwnavwn8Ary5CFnYvrWj9ry0yrWrGF13
 tr1jyFsxuwnxZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAQAA2rpnOFgZgAAsz
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

ixgbevf_ipsec_rx() takes a reference on the xfrm_state returned by
ixgbevf_ipsec_find_rx_state(). On success that reference is handed over
to the skb's security path, which releases it when the skb is freed.
When secpath_set() cannot allocate the extension it returns NULL, but
the function returns without releasing the xfrm_state, so the SA
reference is leaked.

Put the reference before bailing out.

Fixes: 0062e7cc955e ("ixgbevf: add VF IPsec offload code")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
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

