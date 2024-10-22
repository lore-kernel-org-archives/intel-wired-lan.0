Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADD7CDD0FF
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Oct 2024 21:53:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7377C6065D;
	Tue, 22 Oct 2024 21:53:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AAAZqP93Dx1T; Tue, 22 Oct 2024 21:53:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B692D6078B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1729633983;
	bh=PWinoD1wO6ePUpgD5DMyiNj/aEcCeyyglRhhpFipWcw=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JQTxn7Q/wvbc5AGz2cqeocdxLZMhRYE1GZOWB7s0otTW5q+j2CB5pJyrrR5sBaiEA
	 SYkEd84JecHC87LvEXLF/6evQKWvAYUcw6H25rj4AVh84votgdN91n+imiyfYgwn+X
	 CvpS9oDAcn7SyQlHwzEtg5P+KKaUmYEeioZ5XqgVC6xs0xHEKetBnJ2WLeSTlPYsz3
	 0urc7lFLHVWoTAWIupBzt5+J1SVHK/7yiPgp72tBaD1fNiHaw3ojp2F2bWdGaYwkAM
	 cahnITbregGyCnor4/NoRZa6w6Aj+5eJqZe22H6xN6Nc/MAdZj0Rx7dH5fAIDxJDAc
	 Nn7FyWheSXZog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B692D6078B;
	Tue, 22 Oct 2024 21:53:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F9024C2A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Oct 2024 21:53:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2DADB6070E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Oct 2024 21:53:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N9nJC5xp1hoS for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Oct 2024 21:53:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com;
 envelope-from=jdamato@fastly.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 703296065D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 703296065D
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 703296065D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Oct 2024 21:53:01 +0000 (UTC)
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-71e8235f0b6so4652501b3a.3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Oct 2024 14:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729633981; x=1730238781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PWinoD1wO6ePUpgD5DMyiNj/aEcCeyyglRhhpFipWcw=;
 b=TqiyccrycRvtwJHJQDwZtilIomrB2QkUjC2Gl81FGuLxXIWvr0IlLU4NxPMsg6Zojq
 TPqvAQmiTZxJKMktl8o/EXE2xQ1cH76aZLEoWUYgvKco1iXJH8U3nbmFYC1XuhlgYJhD
 jzO3BRO3hhXgYVYnD5/JGGN/BegShc7LMnro06oavIMy8sjHn6nzoqlRkAkA4bOs7baX
 njOQWhBw66/TzQygVs8NpxwTTQj3N/Ql/kuNqb4eM4Ti5GQa3WRyskrqb64EvTO7xbhy
 +s7bx6iDKWaxeKmGohKRhLEc2t0+7RhKI5ngu4GBmEyFHJDko0oRSziRLLHNrFKBA1c7
 VboQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJs2W/a5YK0ekHK5Xpux/ZW5AhLB94XE0NPLYWO0FE3Sh2/giuJzvFJ/bIAPaEQQmM03KIfF5csA3rWcE2lYs=@lists.osuosl.org
X-Gm-Message-State: AOJu0Yx3Eha0liTkJ97Rl2uEqwZ+xrNxOEN3pdYCcy3sBEKjbv9arkT9
 Qi0jCTTXpUfuHYDgB8102k1Hy78Bk55Ht3z/ATLCwTjw09+C7SLyj+oGgWgHBkc=
X-Google-Smtp-Source: AGHT+IEBGKBqCfafdvHpjRzZnehZKZkddBy+EkierZd4IZWl7C0GOGagj0Q5numluvTKArbqw3mVhw==
X-Received: by 2002:a05:6a00:2e1c:b0:71e:634e:fe0d with SMTP id
 d2e1a72fcca58-72030a8ae4bmr1005608b3a.12.1729633980674; 
 Tue, 22 Oct 2024 14:53:00 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec13d75b9sm5194375b3a.131.2024.10.22.14.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 14:53:00 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: jacob.e.keller@intel.com, kurt@linutronix.de, vinicius.gomes@intel.com,
 Joe Damato <jdamato@fastly.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Date: Tue, 22 Oct 2024 21:52:44 +0000
Message-Id: <20241022215246.307821-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241022215246.307821-1-jdamato@fastly.com>
References: <20241022215246.307821-1-jdamato@fastly.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fastly.com; s=google; t=1729633981; x=1730238781; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PWinoD1wO6ePUpgD5DMyiNj/aEcCeyyglRhhpFipWcw=;
 b=U5Rptusp5q7ZY6/LdrVsrd8OnisMcP1UxVKnlh5EIR6DmbQ/dkL9LoT/8SfdQnmhM8
 ok2istK2nrTCdbfOtcgEkJO2uPwZ2nHgy/H6znb3TdwKlg3PZLklUIs9OZNXcg+O95n1
 H6wRE08GoDYbbDJZcctAUDFLHK1DxwQr0VjcE=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=fastly.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com
 header.a=rsa-sha256 header.s=google header.b=U5Rptusp
Subject: [Intel-wired-lan] [iwl-next v4 1/2] igc: Link IRQs to NAPI instances
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Link IRQs to NAPI instances via netdev-genl API so that users can query
this information with netlink.

Compare the output of /proc/interrupts (noting that IRQ 128 is the
"other" IRQ which does not appear to have a NAPI instance):

$ cat /proc/interrupts | grep enp86s0 | cut --delimiter=":" -f1
 128
 129
 130
 131
 132

The output from netlink shows the mapping of NAPI IDs to IRQs (again
noting that 128 is absent as it is the "other" IRQ):

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 2}'

[{'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8196,
  'ifindex': 2,
  'irq': 132},
 {'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8195,
  'ifindex': 2,
  'irq': 131},
 {'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8194,
  'ifindex': 2,
  'irq': 130},
 {'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8193,
  'ifindex': 2,
  'irq': 129}]

Signed-off-by: Joe Damato <jdamato@fastly.com>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 v4:
   - Fix typo in commit message (replacing 144 with 128)

 v2:
   - Line wrap at 80 characters

 drivers/net/ethernet/intel/igc/igc_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 6e70bca15db1..7964bbedb16c 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -5576,6 +5576,9 @@ static int igc_request_msix(struct igc_adapter *adapter)
 				  q_vector);
 		if (err)
 			goto err_free;
+
+		netif_napi_set_irq(&q_vector->napi,
+				   adapter->msix_entries[vector].vector);
 	}
 
 	igc_configure_msix(adapter);
-- 
2.25.1

