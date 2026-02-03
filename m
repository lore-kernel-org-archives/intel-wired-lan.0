Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C45AE87822
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Feb 2026 12:54:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 109EE80AFE;
	Tue,  3 Feb 2026 12:54:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iUvsfLjU5UJI; Tue,  3 Feb 2026 12:54:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2C90980AED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770123279;
	bh=OXp+EGxucYPxD48JSNx0qV+Yw8ErjHN/lXwrb+uzKyk=;
	h=From:To:CC:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=4m9yPms2lQT47fDgjsW9zLlzPQOkTr5MdFKTJKojZGY4jaDr1UekHEyFe6Bh56mtD
	 4GVaxm0t+fzkzZONewXGrBu+DK7LBS69zAJnJFoUBisPdg4BYEYbRXyDQXKEseyqye
	 QxwyzQ7Cf7eUQWPElurzJxBXdPEhhnxvjoBn8QTeozRiDNQiVfREiKjZR+wQeWjDqM
	 cWYdJ5foW4kMIB/xAmEr1r/4tU74diERoG24j9M3C+5b4xBHPk7/NNulPsb8d7cMtE
	 JiNQdVoQ9dHyXmNqpEyREEqq9gVtMoqcQKo9ogv7i7evpxcZxxY3Y4NGIETAxojYKu
	 0DiphNfcF04Dg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C90980AED;
	Tue,  3 Feb 2026 12:54:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E939CF4
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Feb 2026 12:54:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CE08640248
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Feb 2026 12:54:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ovs5SAK5KnYY for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Feb 2026 12:54:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=44.245.243.92;
 helo=pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com;
 envelope-from=prvs=487b0b5b4=takkozu@amazon.co.jp; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 53FD440060
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 53FD440060
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [44.245.243.92])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 53FD440060
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Feb 2026 12:54:35 +0000 (UTC)
X-CSE-ConnectionGUID: LCyvKWRqTWqhscHaIuLiVQ==
X-CSE-MsgGUID: +1eosR/KRcquiZCc2Q8WTg==
X-IronPort-AV: E=Sophos;i="6.21,270,1763424000"; d="scan'208";a="11723383"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 12:54:34 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:16885]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.67:2525]
 with esmtp (Farcaster)
 id 8566367f-1b4f-41de-98ea-1ed2801adaaf; Tue, 3 Feb 2026 12:54:34 +0000 (UTC)
X-Farcaster-Flow-ID: 8566367f-1b4f-41de-98ea-1ed2801adaaf
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Tue, 3 Feb 2026 12:54:33 +0000
Received: from 603e5f7bc1fe.amazon.com (10.37.245.7) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Tue, 3 Feb 2026 12:54:31 +0000
From: Takashi Kozu <takkozu@amazon.com>
To: <horms@kernel.org>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
 <netdev@vger.kernel.org>, <aleksandr.loktionov@intel.com>,
 <pmenzel@molgen.mpg.de>, <piotr.kwapulinski@intel.com>, <enjuk@amazon.com>,
 Takashi Kozu <takkozu@amazon.com>
Date: Tue, 3 Feb 2026 21:54:10 +0900
Message-ID: <20260203125417.37285-5-takkozu@amazon.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.37.245.7]
X-ClientProxiedBy: EX19D037UWC003.ant.amazon.com (10.13.139.231) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1770123276; x=1801659276;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=OXp+EGxucYPxD48JSNx0qV+Yw8ErjHN/lXwrb+uzKyk=;
 b=LWz7ndKj5lniEpXyVFiS0E9tnr9r6XUs0RTCvcQSmQirJaPwkrkC22D0
 49dR1rbcC2gNY84mY0maQyjCe/X2n9FOgCcFNZp+tObK3EyQ3vamXRM0S
 d4PL1SWqV7ENcXl0123M5KDJGsle6ewzvLk2bpb2kxqlTTqsvwB427JxN
 o/DFVjyU4bYT4P5D3f8sIYTIK08XnbWdk2FoLhaF9mP7H8xnBRuImnRPy
 dDBDMPD78mZuwtrkdwAvC48nsC3wxReMsqRip8Gg4jpEVERFDj0btFEYR
 v+d5Fwi4/ppDB2dTjHcE/JryfEUYlzajvVR3KeBrCxQRFxGbYJADYP3cF
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amazon.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256
 header.s=amazoncorp2 header.b=LWz7ndKj
Subject: [Intel-wired-lan] [PATCH iwl-next v6 0/3] igb: add RSS key get/set
 support
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

This series adds ethtool get/set support for the RSS hash key in the igb
driver.
- `ethtool -x <dev>` to display the RSS key
- `ethtool -X <dev> hkey <key>` to configure the RSS key

Without patch:

# ethtool -x $DEV | grep key -A1
RSS hash key:
Operation not supported
# ethtool -X $DEV hkey 00:00:00:00:00:00:00:00:00:00:00:00:000
Cannot set RX flow hash configuration:
  Hash key setting not supported


With patch:

# ethtool -x $DEV | grep key -A1
RSS hash key:
86:5d:11:56:bd:6f:20:38:3b:f8:bb:df:00:3a:b0:24:95:9f:f9:f4:25:a3:01:3e:4a:15:d6:7c:4d:af:39:7e:4a:95:f2:fd:f6:b6:26:f7

# ethtool -X $DEV hkey 00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00
# ethtool -x $DEV | grep key -A1
RSS hash key:
00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00

<Changelog>
  v6:
      - fix a typo in the 3/3 commit message. (igc_set_rxfh() → igb_set_rxfh())

  v5:
      - delete 'has_user_rss_key' flag because it's unnecessary. 

  v4: 
      - modify the position of the declaration in the igb_write_rss_key() so that it is at the start of the block.

  v3: 
      - add ASSERT_RTNL() to explicitly show that an rtnl lock is being used
      - Move netdev_rss_key_fill() function from igb_setup_mrqc() to igb_sw_init()
      - Add kernel-doc header to igb_write_rss_key()

      <Test>
      - tools/testing/selftests/drivers/net/hw/rss_api.py is successful
      Run the following command

      # NETIF=enp0s3 python tools/testing/selftests/drivers/net/hw/rss_api.py | grep -v "# Exception" 

      Then, I checked the diffs before and after applying the patch

      $ diff beforePatch.txt afterPatch.txt 
      9c9
      < not ok 6 rss_api.test_rxfh_nl_set_key
      ---
      > ok 6 rss_api.test_rxfh_nl_set_key
      16c16
      < # Totals: pass:4 fail:8 xfail:0 xpass:0 skip:0 error:0
      ---
      > # Totals: pass:5 fail:7 xfail:0 xpass:0 skip:0 error:0

      The failing tests originally fails due to hardware.

      - tools/testing/selftests/drivers/net/hw/toeplitz.py is untested since there is no actual hardware, but since the logic around wr32() is preserved as it is, key writing to the device remain the same.
      

  v2: Fix typos (igc_* → igb_*) 
      https://lore.kernel.org/intel-wired-lan/20260108052020.84218-5-takkozu@amazon.com/T/

  v1: https://lore.kernel.org/all/20251205082106.4028-5-takkozu@amazon.com/


Takashi Kozu (3):
  igb: prepare for RSS key get/set support
  igb: expose RSS key via ethtool get_rxfh
  igb: allow configuring RSS key via ethtool set_rxfh

 drivers/net/ethernet/intel/igb/igb.h         |  3 +
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 85 ++++++++++++++------
 drivers/net/ethernet/intel/igb/igb_main.c    |  8 +-
 3 files changed, 66 insertions(+), 30 deletions(-)

-- 
2.52.0

