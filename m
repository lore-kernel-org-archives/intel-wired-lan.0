Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BBCCF34D5
	for <intel-wired-lan@archiver.kernel.org>; Thu,  3 Oct 2024 23:39:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F97C60F79;
	Thu,  3 Oct 2024 23:39:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9a6CnN7OIwFi; Thu,  3 Oct 2024 23:39:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9168D6070F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1727998746;
	bh=X5uM8+CsvXiU2bmxtLKhHDD6o30h8WQH0Z1Yw+U9EME=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=hwBlEL6PV1IRuEPz0iL2JbnptYfZcqRY5rLQsZtev4PnEz1rYFUQ6GUGfdo1WMVu6
	 w3TudR0oFq3IsrO2wfksba6hZ7yO7zKmhAipvq9I4zCNq95Ox4FAxnvBadsSbxeRkO
	 6Np2ZJhT/PeO3DllmfGQuCg7xm3atwLUBlPhDA1VpVCRMCHMEqVVpRtLVpOVi6y5Ic
	 6lsNX5wztnsosO4NEfRfkWKQvI15PVE12z7n4hIoDzwe9rhOQts2jNDKnfYsKJzU6p
	 /EWE5HFj4J1mvb2LfciIN4yL99Gwu5/8R7ErC8/KfmQezxtK+NyF2Nf+006Ot2sRY7
	 TMYpDC3vgV7VQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9168D6070F;
	Thu,  3 Oct 2024 23:39:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id AF8341BF370
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Oct 2024 23:39:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9E52D840AA
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Oct 2024 23:39:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OjGa6qdX565K for <intel-wired-lan@lists.osuosl.org>;
 Thu,  3 Oct 2024 23:39:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com;
 envelope-from=jdamato@fastly.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6805E81D19
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6805E81D19
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6805E81D19
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Oct 2024 23:39:04 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2e091682cfbso1212333a91.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 03 Oct 2024 16:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727998743; x=1728603543;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X5uM8+CsvXiU2bmxtLKhHDD6o30h8WQH0Z1Yw+U9EME=;
 b=J+CyPd+bhICmqx2I+Hw9MIs4X5KO7LJCKw33o4XbiZs1T/an1SylcWUoUCSH+R2Ys5
 DpOeKQU/imGLcmohC5jnh1O3ONX1GixZgUaaHKpFxSsvXVcTZB4d9jLK2KlwlbnapVL3
 m97YnsDt7DqctTQSa8jys1VYXJzd5rFtXv0Nmr72OFSEqK1ZVPmgMZK8BpZgTwDVHpuZ
 YazRn8w5OHz0ioDwcSXh6eQPrYWfxE67qFQHksLgjF+ByfAaVsEE1mGkqEAbT76GKZl8
 8Ta+M4tOO9FuaVcueGB1CzIO5ftC9DEfKz52ymSLVEOlDWe45OTVItaBt9cYPabBObGP
 wqfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYRwsredLoD40ovPFTGeXKBgf3rFRO8LMPYcz1aZlqnCR2PYezwzcxBRMcGpX5B1OqC64TGeGIoQO1gIn6RnY=@lists.osuosl.org
X-Gm-Message-State: AOJu0Yxq3Dfha7lQqRbdHk7xw0LYLE3KYuTmb58Py41gWE5nfWo6ZlEB
 IMcHizNvbGwvFCBp52PXAy04kOXn02pxBCI6tAJd9eh6Vonip/hdG1ifQJ7MQKU=
X-Google-Smtp-Source: AGHT+IHEWYORPHjnHHVp6I9/kLAbZHfWNaSuzgQt1JIWu8FqZigoY7u1EMlJMMl+mRfWDmx9NcDWEA==
X-Received: by 2002:a17:90b:4f87:b0:2d8:8430:8a91 with SMTP id
 98e67ed59e1d1-2e1e6221b1dmr1015791a91.10.1727998743501; 
 Thu, 03 Oct 2024 16:39:03 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20beef8ec6bsm13960705ad.158.2024.10.03.16.39.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 16:39:03 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Date: Thu,  3 Oct 2024 23:38:48 +0000
Message-Id: <20241003233850.199495-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fastly.com; s=google; t=1727998743; x=1728603543; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X5uM8+CsvXiU2bmxtLKhHDD6o30h8WQH0Z1Yw+U9EME=;
 b=iH7732TBN7oHQaSBsVZQgAkWW0YdfqFs8eLez9p+9WqeUhkV/yJqsd2tsCAYbrEEY+
 KPh+3x7FRrftSJlBfYtRQISaSQ6sZvclkEjO/+XytmVQoojUEz20tb8VtVUhw/oqlxtE
 UR+l3YBuD/Er899WDN3UId1O10THbKwsU3pJY=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=fastly.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=fastly.com header.i=@fastly.com header.a=rsa-sha256
 header.s=google header.b=iH7732TB
Subject: [Intel-wired-lan] [RFC net-next 0/2] igc: Link IRQs and queues to
 NAPIs
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Joe Damato <jdamato@fastly.com>, open list <linux-kernel@vger.kernel.org>,
 Eric Dumazet <edumazet@google.com>,
 "moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Greetings:

This is an RFC to get feedback before submitting an actual series and
because I have a question for igc maintainers, see below.

This series addss support for netdev-genl to igc so that userland apps
can query IRQ, queue, and NAPI instance relationships. This is useful
because developers who have igc NICs (for example, in their Intel NUCs)
who are working on epoll-based busy polling apps and using
SO_INCOMING_NAPI_ID, need access to this API to map NAPI IDs back to
queues.

See the commit messages of each patch for example output I got on my igc
hardware.

My question for maintainers:

In patch 2, the linking should be avoided for XDP queues. Is there a way
to test that somehow in the driver? I looked around a bit, but didn't
notice anything. Sorry if I'm missing something obvious.

Thanks,
Joe

Joe Damato (2):
  igc: Link IRQs to NAPI instances
  igc: Link queues to NAPI instances

 drivers/net/ethernet/intel/igc/igc.h      |  1 +
 drivers/net/ethernet/intel/igc/igc_main.c | 33 ++++++++++++++++++++---
 2 files changed, 30 insertions(+), 4 deletions(-)

-- 
2.25.1

