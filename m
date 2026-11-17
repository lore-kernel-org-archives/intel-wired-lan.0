Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34322606A31C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Nov 2026 16:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=uhU+N7NI;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=haox9H5O
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 100A84091C;
	Tue, 17 Nov 2026 16:29:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P6fbJzevW62x; Tue, 17 Nov 2026 16:29:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7A443408FB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794932944;
	b=jdR30QbJoEry0YwF7BL+QB+xIlqspCWO93at05A0fYoCAyhReoCHmhjv3nuYw5G2sOdF
	 9vs8HlJJMQgolUrF0By72dZcNmEMSYrasx4UnLdjcQUr2LHS+aLlpPRR0ixxg2NAf8fGj
	 zQjPemfvHtfUbaaH6r8RNoIPPDU3brTd7zCA5DSgQw8SmCnzS0P/khfQ9i7vsxK+A98MR
	 5AUshABreNwj6O7huU16s3itM0MfHIyAkHfWYenlKlBR2Jc7AH3kisSpHXGD/Xs+GqPHn
	 OAQemnbVI74h+T4o0pI5TB3ijYK4LDdd/XJWxSkPe+UEm9LTOFHHgH7aA2xxKZwXwzA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794932944;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VKadNleMHJBLRP4szDxTc4A4+nJ0/Pl3hG9PQuxpOUk=;
	b=lrUVD92bjom5fLAfL69y2H8xdxrq5qqpxvI/EsTAbWDRmZpIuz8OKwkrXSf3p2Oi7WhN
	 i+0lixss3HSOZCsA/kVIKSrxgOdB+iupX+Fk4XicMQKQWzjoAL5hkJCSWVg1J7Q/SKh3a
	 6XytbPN95z4V2YQa9F2pFMnSEzTIGEkdyugJoMJgbTTlAh8YE0TaTZIUt+BBjEK42mXHK
	 W3Fy8SA+CTqm0tmKanqvwi8Wdqm3wE6gJDlGZfDCNAaJC+SF5p8aRd5YVL9CJHoAAWzSw
	 0S6IMOtbgAR3PEm5XW/cqafj2rT4Zi6JiVLkKDXXah0iayrUG+iX6EwAmw5OGB5uHXQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794932944;
	bh=VKadNleMHJBLRP4szDxTc4A4+nJ0/Pl3hG9PQuxpOUk=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uhU+N7NISL+b0CcbDmQgf9zSwfRtgegsh3eDb1IBBZ4OoFKm9FFu8Rayz3zvtxmHQ
	 ueTGrPPF4mhOm1AcJbnCLY8utBiUhN3I0kiJMD+fK4yLncBcKjPt4tGTPwBipsj7cC
	 3UreemR0k2/8oqRX5lXNC0/zabYAniKeQpL3hSeE8x7U4Ly/QQ2YERl1L97xJggSHa
	 ZLi9eyhLeiZnM+osk2eAnJf5+NpN5yBQkykQoAq0RXjqdX9QgzNGDwWI3tj0qSiWC5
	 A8nyjwJDxdogVhEzzXbXaovx+EOaGAdpMXtpvKoI1boG1IgwgYAyriDFe2lF86lkbS
	 xexDycU+U0mZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A443408FB;
	Tue, 17 Nov 2026 16:29:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 79E1F49B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 600858111E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vZKYKo3vuQzV for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Nov 2026 14:55:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A2E4180CBD
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::747"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::747; helo=mail-qk1-x747.google.com;
 envelope-from=37gr8agukdxmbct61z77z4x.v7516cx4-f1axw-4t641bcb.7bd7b4.7az@flex--stani.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20260707 header.b=haox9H5O
Received: from mail-qk1-x747.google.com (mail-qk1-x747.google.com
 [IPv6:2607:f8b0:4864:20::747])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A2E4180CBD
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:42 +0000 (UTC)
Received: by mail-qk1-x747.google.com with SMTP id
 af79cd13be357-93f3969a2a7so728443385a.2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 06:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794927341; x=1795532141; darn=lists.osuosl.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VKadNleMHJBLRP4szDxTc4A4+nJ0/Pl3hG9PQuxpOUk=;
 b=haox9H5O04SjA936opobHPt9lJamYNYJxfz/u4Xr99vzOwn6jLP0vKKqLaeq8yjHdo
 r+uRVPLi6YDVuvdXturG6zgTVC16pHXveqzohDSV2k//BNPa3PQzVtF1aowF/ERIJcaT
 kzkNDbzjaQRx5Eu9lQj2DVP7ousg6WzHQZgWuWmuI70Oz1Pl+dy/JxXsDbGjq4WSHJdP
 WEgi8Y6SLUPerHn+e8OmznSooSQeOlrRFtzkZCYaQcT7EHBJzdQhuVeo61BpTed5sQZC
 2q4//qglu5Cx4evToNRbJ/A9A1xzFsyMnjWHgN9BJ4EZccqxbG+IWo+Jw+U+MIqIrvs4
 ez0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794927341; x=1795532141;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VKadNleMHJBLRP4szDxTc4A4+nJ0/Pl3hG9PQuxpOUk=;
 b=hXNn5zL2EHBKKJ+/zcEo9wqHXck9pRSNvWFsjlB9rzjsuuMjue4X9xLMm8DjYLkkFT
 QRF6fSuLNtJjsrECcT2u0cAZsgXGc5MbPOyS0UqPqvKvM1SrfzXn/D3tKoL91XyL1A7L
 m1vPy30c/3S3coRP7uGW97fC9TiitKJRlGTHm/8VABxAAasxcnI1ov3H1PhXdq9RsTX1
 NGJz6NxWp9nYTu7ItR5K8B68Rn3rf8FS6w+PdZuM5oolUp20RSycLg4TW4zD22IKRbAT
 RVj1aFPf4qRwa285FIztakaRN5OV7Uhe2Mw19uorXzw2Jj9dq7ErIkHxO93pEZjKqyMT
 IlEg==
X-Forwarded-Encrypted: i=1;
 AL+hErGfwNUaWLgbcYrhPwqRdd30Z9LXC83m7lm+GQ9YGUiHTqchOyn8DFQ5lKtzNnNn1hvZ6z/72zd/XDkyb1voFKg=@lists.osuosl.org
X-Gm-Message-State: APuU4Z9ysEwy8+OvRbggWIx/v71HMBsBlcZ0QKGrbIcjjOuB3cHCDcmY
 xdm8NEV1inv/R9KgL5kk17o2JVDOjnZjPH2Syo5SfZ5UfLA5DE56TblNK9cLoojg9brJU0GLO9j
 YzA==
X-Received: from qknvm11.prod.google.com
 ([2002:a05:620a:718b:b0:93f:43a4:a480])
 (user=stani job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:8908:b0:93f:47fa:b722
 with SMTP id af79cd13be357-9494bb858b5mr2039910785a.13.1794927340273; Tue, 17
 Nov 2026 06:55:40 -0800 (PST)
Date: Tue, 17 Nov 2026 14:55:08 +0000
In-Reply-To: <20261117145522.1910636-1-stani@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261117145522.1910636-1-stani@google.com>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261117145522.1910636-3-stani@google.com>
Subject: [PATCH iwl-next 02/15] idpf: wipe mailbox send buffers on release
From: Stan Iliev <stani@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Decotigny <decot@google.com>, Madhu Chittim <madhu.chittim@intel.com>, 
 Emil Tantilov <emil.s.tantilov@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>, 
 Brian Vazquez <brianvv@google.com>, Li Li <boolli@google.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Daniel Zahka <daniel.zahka@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 17 Nov 2026 16:29:00 +0000
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
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The mailbox messages are freed with kfree() once they were sent, or when
they couldn't be sent. Some messages hold secrets, e.g. the PSP TX keys
inserted into the SADB of the device. Free all of them with
kfree_sensitive() instead: the mailbox isn't a fast path.

Signed-off-by: Stan Iliev <stani@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index c06b2d9bfe0a..fedac4716b08 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -129,7 +129,7 @@ void idpf_recv_event_msg(struct libie_ctlq_ctx *ctx,
  */
 static void idpf_mb_clean(struct libie_ctlq_info *asq, bool deinit)
 {
-	libie_ctlq_xn_send_clean(asq, kfree, deinit);
+	libie_ctlq_xn_send_clean(asq, kfree_sensitive, deinit);
 }
 
 #if IS_ENABLED(CONFIG_PTP_1588_CLOCK)
@@ -218,7 +218,7 @@ int idpf_send_mb_msg(struct idpf_adapter *adapter,
 
 	if (err) {
 		if (!libie_cp_can_send_onstack(send_buf_size))
-			kfree(send_buf);
+			kfree_sensitive(send_buf);
 
 		return err;
 	}
@@ -230,7 +230,7 @@ int idpf_send_mb_msg(struct idpf_adapter *adapter,
 	xn_params->send_buf.iov_len = send_buf_size;
 	xn_params->xnm = adapter->xnm;
 	xn_params->ctlq = xn_params->ctlq ? xn_params->ctlq : adapter->asq;
-	xn_params->rel_tx_buf = kfree;
+	xn_params->rel_tx_buf = kfree_sensitive;
 	xn_params->timeout_ms = min_t(u64, xn_params->timeout_ms, timeout_ms);
 
 	idpf_mb_clean(xn_params->ctlq, false);
@@ -264,7 +264,7 @@ int idpf_send_mb_msg_kfree(struct idpf_adapter *adapter,
 	int err = idpf_send_mb_msg(adapter, xn_params, send_buf, send_buf_size);
 
 	if (libie_cp_can_send_onstack(send_buf_size))
-		kfree(send_buf);
+		kfree_sensitive(send_buf);
 
 	return err;
 }
-- 
2.56.0.679.gc527c65306-goog

