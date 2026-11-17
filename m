Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C3F606A31C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Nov 2026 16:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=mF37ZTGW;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WrRYRokd
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 259474093B;
	Tue, 17 Nov 2026 16:29:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dJ5nctDtrzA1; Tue, 17 Nov 2026 16:29:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5D30B40946
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794932953;
	b=n9ew3S+NODaH6y/NF0KG7We1+oqI+683gVjaVqLpEJc4++X9wT+MvB4r3FRfEXuvUu0c
	 xDeNABdy9zkdKLBRcVAQbGH/I4Z0mehiFEFHzRl2ehc9UB12nMolKe4Vb69bsqnuWyOGt
	 d+dIG3P5yqvH2NldS3S997dWIRS6V3N7T/yimdJRq12dleVqaMH6WMoZNH+scvVqG/Wpb
	 pGialr5jaRq3cbzpyDg2XQJ2wGd+uP/naf/7EkZj9rxiRQPNWlZge/p9TxPAz734Xpa5c
	 LjB3UDoYMVtpwpj214cwlVO01cWyoZeadL5DmIkbg70cstEAGPNptEj0x3ya9DWnU2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794932953;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HLnUN4SFxuLePJET60hqALFh8R854ScCCjNPuZCVkMs=;
	b=TnHyiFH/d/B6HzZn34HUEiCE9WjC0QfnTNaTMwTOeHCqh4H1Um+Z36HyIA4efERI42I6
	 2YlhK/5mtMn+I7+LngY6cxqVX4bXhvLLHm9yXzhtS/uBwEg29XJRyCTyJc/ESsPk4Wxmx
	 gv+dAs355JU0Y4x9I+qcLR+SR2c9/ox0vY/u0Sppc/fg6A0vpUJseq5x/f//eDIYN8pB3
	 4hr+qDozUAKZOPenN/IflOlf7w6t5MCsO42NunCB6Eoo+2T1Se3Uovwu4b+jgMfmAH84b
	 VZm+VwIxHckzuRvDZG/rbvQ9su2dbe99PvdkU9fgK6vLApIzJ3JRSu9yTboOdW0uB0w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794932953;
	bh=HLnUN4SFxuLePJET60hqALFh8R854ScCCjNPuZCVkMs=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mF37ZTGWZ6pxfJogxmuxEyuvb/hTEqrHpaMBg3iEepXz+t/bnIdremjJW8KargCcD
	 AtujE4+X7jlB9rGiDVqAkjL5OEMByQLMh6Aa3XJrjcVib73VTB9RyKmmQHWQpPL44E
	 W6qS6+/gsZdxbfRtYpFyW+aTax8WW9AT1SOBMYQgpUIZ0PyFpLc+HQ+IorEB8QnygG
	 NZNH5mJBEOHk2QABIeCICE6RWKfC1b4PiThaCFsY5lxPFkohfWldu9Th1Ewvwwe2/8
	 aSiUGY42lWKp+CxfpLUHyXdS8GhalKH7veJU5TKoPWI4kB17Ff6fUaCRd6wzp6G8sM
	 qFLozK4lEhgRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5D30B40946;
	Tue, 17 Nov 2026 16:29:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 277C770B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A7BBC608F5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k0BGWF0MF4L0 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Nov 2026 14:55:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D07C9608EF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::747"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::747; helo=mail-qk1-x747.google.com;
 envelope-from=37wr8agukdxqcdu7208805y.w8627dy5-g2byx-5u752cdc.8ce8c5.8b0@flex--stani.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20260707 header.b=WrRYRokd
Received: from mail-qk1-x747.google.com (mail-qk1-x747.google.com
 [IPv6:2607:f8b0:4864:20::747])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D07C9608EF
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:42 +0000 (UTC)
Received: by mail-qk1-x747.google.com with SMTP id
 af79cd13be357-94960131b4eso582111085a.3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 06:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794927341; x=1795532141; darn=lists.osuosl.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HLnUN4SFxuLePJET60hqALFh8R854ScCCjNPuZCVkMs=;
 b=WrRYRokdHcDNxXw/Ml+ATYcwzc7VSGLVa20mvZirAUO9nSNpAODVJOlbeFsj3QEgtG
 6UP6epubelzPua9hgsdoAQ61cXireKiCQe2HmkVyhWQIlE85yftNNNLa8srr9BkV5Ywl
 nIn3M7wO30617/fouB8LeTkQUCy+EFBkGF2tADMYUKnsepIQXZPbykI+DPbILbh+gg6t
 Go56XZFncnhfITEo4JYuKeUcrgWgDC6p9vOIpzIMMBcRFUFiMC9quf5iC/LG9aB7qdY2
 2z5Dfm9K8UlebpNoM9NjX/xOUIeTT+5voTNY09lRsA5nxfmKABrmpywTVBCpR51GLF+y
 U4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794927341; x=1795532141;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HLnUN4SFxuLePJET60hqALFh8R854ScCCjNPuZCVkMs=;
 b=tngMNmPQdmYfIoD/In+mMEnM2kap9C1Xn8gLBYFL1l13c8lHjWojXTsXIPgrRAtY/E
 dyrzhYMAW3KdKrNPTT3+rMt8PxGlxPzPTlx476D39EX3VgWTDq+9UDZL0iNcfj0hQ75e
 IB1A2Ol8vslq4reaEsAe2IPtYiUBwNaf0AAi3lZH6rjWj+128hbbxUUPOMy3R7/gQQ2Q
 fyoS/PbIrg4JKnmK/jTLhOH64yJqhAJcaIT0XJJhfJyGnoaDByhF3mKx9Jn6TkHfPHjY
 8yOb1l8VCbE0feDGvuiXaRCQ00FJcJtGFjJ0XK9X6jv3gjqiMyGict3q8Du1pK9Wiawu
 terQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFXzaU0iB3QqjtJJjZndqRO6CnGWMmL38m+t1FW5RGBtVQ2nIloKr+ArjAIQ079uZXdKZ+tmzZnY9892m0yX94=@lists.osuosl.org
X-Gm-Message-State: APuU4Z+h0BMVOwf+XkkgZKOdPu6CuehjMWuiWgaY2RLH/5xsKeq1DAdA
 aIZIJY+NlQ53TohoJ+ZZ7RvZ+2+mlSwbUtgHcMMu4KVV0ScCRaN3Mc/pR26VI8KMsHj9HDaIilg
 +Qg==
X-Received: from qknvm11.prod.google.com
 ([2002:a05:620a:718b:b0:93f:43a4:a480])
 (user=stani job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:bc7:b0:944:1291:6cd9
 with SMTP id af79cd13be357-9494bbeb488mr2333610585a.68.1794927341308; Tue, 17
 Nov 2026 06:55:41 -0800 (PST)
Date: Tue, 17 Nov 2026 14:55:09 +0000
In-Reply-To: <20261117145522.1910636-1-stani@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261117145522.1910636-1-stani@google.com>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261117145522.1910636-4-stani@google.com>
Subject: [PATCH iwl-next 03/15] idpf: make the mailbox workqueue visible in
 sysfs
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

Add WQ_SYSFS to the mailbox workqueue: the workqueue attributes are then
exported in /sys/devices/virtual/workqueue/, e.g. to inspect or change
the CPU mask and the nice level of the mailbox workqueue while debugging
mailbox latency. This is one of those cases where, when the need arises,
we wish we had that flag enabled, see https://lwn.net/Articles/967016/.
The PSP workqueue added later in this series sets it too.

Signed-off-by: Stan Iliev <stani@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index c855572c5315..566d5804c8c1 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -319,7 +319,8 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_serv_wq_alloc;
 	}
 
-	adapter->mbx_wq = alloc_workqueue("%s-%s-mbx", WQ_UNBOUND | WQ_HIGHPRI,
+	adapter->mbx_wq = alloc_workqueue("%s-%s-mbx",
+					  WQ_UNBOUND | WQ_HIGHPRI | WQ_SYSFS,
 					  0, dev_driver_string(dev),
 					  dev_name(dev));
 	if (!adapter->mbx_wq) {
-- 
2.56.0.679.gc527c65306-goog

