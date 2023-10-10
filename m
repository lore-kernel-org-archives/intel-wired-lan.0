Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71AD8CDB46E
	for <intel-wired-lan@archiver.kernel.org>; Thu, 12 Oct 2023 19:07:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 287A1610A7;
	Thu, 12 Oct 2023 19:07:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 287A1610A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1697137672;
	bh=XBT4/T0+lkJ2hcHG7rMFPHk5q5eV3jHMjR2UFnS6p58=;
	h=Date:In-Reply-To:References:From:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=CV76x7kZfGuCtJ5ss9WFraM5uXqpDPIBl1I8ZtpcmNZpuntu/UjcLVFTbUEgMOYmW
	 a8AXXqJasvZ9JCGQNbQtfL4njVfzTA5bgHweCWazf7JifIOJq+ZiezWG5gvCvIxSY6
	 Oq/azrFa4GmC1cPQpyDBSOLc0I3k26igj3H5rdbNL8ol6A2BCLMOpH8jVPgIfE/w+y
	 AfayDh+UYWyh5rKX08XIfdl8RUNyFl5SmHHM03X/8CbhKlfBosllJ5eq0d+Sue5mvG
	 gJ1n8p7OPSyCvq7qxfk5Fm6QwzrxO5nvhw/uOtNPMubVAysc4AJ7Ib0yQye3qAI3/4
	 EyOQQr0Gzubjg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M3SWahZccLOG; Thu, 12 Oct 2023 19:07:49 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C76160634;
	Thu, 12 Oct 2023 19:07:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8C76160634
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 79E351BF25F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Oct 2023 22:27:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4E9474044D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Oct 2023 22:27:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4E9474044D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DX17hevwDrRp for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Oct 2023 22:27:13 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5FA8F40012
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Oct 2023 22:27:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5FA8F40012
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-d9a509861acso1944604276.2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Oct 2023 15:27:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696976832; x=1697581632;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GtM0w+J9cw3jjb0usGEHfb5iDugSjDgb6JSiT+iZymc=;
 b=eTzJsnwFHqFfCH/jU2bwueMDONwl70zofdHV5ryMWRmtVTTjEdXqxP9CDToTnKurzl
 pjPXNdjRNKd0UADBXp0O1HcXLE37AQ3CB2yMrwcuDjpD5fTFtwDaFRctcUmANEkHdBD0
 QiFebgHRU1XpzgkIA6kbahPLsT8xvK72kU5EG5BdCrMwZ1mm1uH/YyfzTVps7K5nOWWf
 sABjHRvb+n8+TCz2LAgFJ5E5Zr1KumT/c5NNthIwrLQHecV6LIXnnuYar42hJxZwNN42
 YjfQ9k6WbITCWKhsasye6PzLt8S3ddLHakVSl4y8d++rAVHd+wghBRHCqDSJJiUqKjws
 6Axw==
X-Gm-Message-State: AOJu0YwPtvt0vAfOSeeer0IciCmAYx6ypiAMkypw1WeeGk7pMT5fO6ZP
 XcKwbkzMLuTUiehnHcaUqxBQUdhw6oul4mDCrA==
X-Google-Smtp-Source: AGHT+IE90IMRLxbCtK+FWTfBYeHC+U5Cy3qc2KOUif/Mw4hAnclXZq/qXjDbI29Vfn0ZPUuW4ixhfNcK0Pbgbem5bA==
X-Received: from jstitt-linux1.c.googlers.com
 ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:ced3:0:b0:d9a:634d:4400 with SMTP
 id x202-20020a25ced3000000b00d9a634d4400mr53292ybe.5.1696976832282; Tue, 10
 Oct 2023 15:27:12 -0700 (PDT)
Date: Tue, 10 Oct 2023 22:26:58 +0000
In-Reply-To: <20231010-netdev-replace-strncpy-resend-as-series-v1-0-caf9f0f2f021@google.com>
Mime-Version: 1.0
References: <20231010-netdev-replace-strncpy-resend-as-series-v1-0-caf9f0f2f021@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519;
 pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696976825; l=2053;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=tIBhN0dI5KQV25Dn8IjDZp+7IelZH6PsmdLrTBm66Xc=;
 b=hRT8DAV5FRqqSXsHAHmPSGPSEQbQBGx13G3GU53NmuUbzuZgGmmwVJqw/B2WprCOy7JOSEs7A
 JUBcK+9dOy2Bis775R/QWrp3y4385KpGI7leBfVy2b+aVrSU/y1pH0a
X-Mailer: b4 0.12.3
Message-ID: <20231010-netdev-replace-strncpy-resend-as-series-v1-5-caf9f0f2f021@google.com>
From: Justin Stitt <justinstitt@google.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
X-Mailman-Approved-At: Thu, 12 Oct 2023 19:06:39 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696976832; x=1697581632; darn=lists.osuosl.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=GtM0w+J9cw3jjb0usGEHfb5iDugSjDgb6JSiT+iZymc=;
 b=HCZhogpfqvjds7uNBfhVwTX4Eq8Uw663hvqpitFaKyMEcE59il4keVd4kt7nY6wV6v
 3IpYCYMCEey2XeTf1ckMj7vwSgd7Wnoch7EtSXBiSKe2LsYFi5WMwt6+fFBRH8mzWwZH
 LuKH8Xk78CzFcQQH58RlJKyzL+wg4YiQvbKne6TmkZ8YYHdHWtJOpeZ9LPgOqJ+pseWH
 cMd2trTaqXlJoYyuJQcXeplsh77NjHRq6kM937u8BNSo+7JliUnQv+FBxOcHe1wtlcgk
 VVaRKXOu51MGzvZaBv/rrCav+T3U5S3YaXAkqqLdDc3/n3HcLLoT7DMwN4X7lXKBrjv8
 EEBQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20230601 header.b=HCZhogpf
Subject: [Intel-wired-lan] [PATCH v1 net-next 5/7] igb: replace deprecated
 strncpy with strscpy
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
Cc: netdev@vger.kernel.org, Justin Stitt <justinstitt@google.com>,
 intel-wired-lan@lists.osuosl.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We see that netdev->name is expected to be NUL-terminated based on its
usage with format strings:
|       sprintf(q_vector->name, "%s-TxRx-%u", netdev->name,
|               q_vector->rx.ring->queue_index);

Furthermore, NUL-padding is not required as netdev is already
zero-allocated:
|       netdev = alloc_etherdev_mq(sizeof(struct igb_adapter),
|                                  IGB_MAX_TX_QUEUES);
...
alloc_etherdev_mq() -> alloc_etherdev_mqs() -> alloc_netdev_mqs() ...
|       p = kvzalloc(alloc_size, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>

---
Note: build-tested only.
---
 drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 76b34cee1da3..9de103bd3ad3 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3264,7 +3264,7 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	igb_set_ethtool_ops(netdev);
 	netdev->watchdog_timeo = 5 * HZ;
 
-	strncpy(netdev->name, pci_name(pdev), sizeof(netdev->name) - 1);
+	strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
 
 	netdev->mem_start = pci_resource_start(pdev, 0);
 	netdev->mem_end = pci_resource_end(pdev, 0);

-- 
2.42.0.609.gbb76f46606-goog

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
