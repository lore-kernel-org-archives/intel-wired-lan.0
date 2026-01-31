Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D518ED7977D
	for <intel-wired-lan@archiver.kernel.org>; Sat, 31 Jan 2026 16:31:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 854D460B67;
	Sat, 31 Jan 2026 16:31:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sqngYqDkSRn3; Sat, 31 Jan 2026 16:31:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C871E60B64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769877063;
	bh=/LaTNBzU1ZqwGjSbsitnVGu2AjeEHf5402YTnnjokBU=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KaeYrPGmAp/qWo/qubCHN6FW/9Ol+NR2sX/LeFRTu4OcQcuYubCFt/rfTV/IGr/Lc
	 GevZ5vKUKtyzfAyj0RGIl8hbkhoIyYWd4VoSfufJ8kKflQkL78SwBQefChcCvqeiLL
	 tajvd1Uo+qSH8clT7V7utnTJSE4XiPd8amyx3fYzDtEt1g1SwAxVGFWwH6CWlkF10n
	 l4fL7y+0E6NJaHjTa+VHaFvzlfbjD5xDRuN7PO17ixI+bdQMVMAtXEA9YZHH6ab/41
	 Bz8G1NItTG/7rDDVB7waMpbdYrJA3SZeShuJ1PvVj+PWTOcy9fgf+IwZQ685jJ12ph
	 OjWmSPA6faFGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C871E60B64;
	Sat, 31 Jan 2026 16:31:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C337E1E0
 for <intel-wired-lan@lists.osuosl.org>; Sat, 31 Jan 2026 16:31:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B19EC40826
 for <intel-wired-lan@lists.osuosl.org>; Sat, 31 Jan 2026 16:31:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zzoIhuF_RcbU for <intel-wired-lan@lists.osuosl.org>;
 Sat, 31 Jan 2026 16:31:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=49.212.198.91;
 helo=www2881.sakura.ne.jp; envelope-from=kohei@enjuk.jp; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 580DA40711
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 580DA40711
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 580DA40711
 for <intel-wired-lan@lists.osuosl.org>; Sat, 31 Jan 2026 16:30:59 +0000 (UTC)
Received: from ms-a2 (248.212.13.160.dy.iij4u.or.jp [160.13.212.248])
 (authenticated bits=0)
 by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60VGUcS2039137
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 1 Feb 2026 01:30:39 +0900 (JST) (envelope-from kohei@enjuk.jp)
From: Kohei Enju <kohei@enjuk.jp>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Vitaly Lifshits <vitaly.lifshits@intel.com>,
 Simon Horman <horms@kernel.org>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 kohei.enju@gmail.com, Kohei Enju <kohei@enjuk.jp>
Date: Sat, 31 Jan 2026 16:29:35 +0000
Message-ID: <20260131163037.88108-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: a=rsa-sha256;
 bh=/LaTNBzU1ZqwGjSbsitnVGu2AjeEHf5402YTnnjokBU=; 
 c=relaxed/relaxed; d=enjuk.jp;
 h=From:To:Subject:Date:Message-ID;
 s=rs20251215; t=1769877039; v=1;
 b=up6oGSR0BnRs59uNdGoleUeQWdyRDQ1MElhF4/8+iH5g+NjR6xMa5NPi0uQGc0Lc
 Sn8X6xDFmfx5RnABSQEnBr4vEdlmxHqxr0YlNjIVnne6sy2f7rW1iip0mRLmN+wO
 bfT+FxNqbgTnU9MNTQu2DFS1eAzeDKSVN+S5m6PvR82Cux/11vQhSlQxGCQvXn3O
 1cU6d4yMVvlHPgabxes/UyCw7oJWaeuSsSMrkmvNzj6kpBvLx2ttCdP06MLfDP/N
 i1mVIfqUHxCV3TJrP0J05yxRgfRcFqQxtFC5Hx+XWOcO85GD1EJAtr2m9A7s7LXw
 tT37C7Wd08/g9ZsTVq/mfw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=enjuk.jp
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=enjuk.jp header.i=@enjuk.jp header.a=rsa-sha256
 header.s=rs20251215 header.b=up6oGSR0
Subject: [Intel-wired-lan] [PATCH v2 iwl-next 0/3] igc: add RSS key get/set
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

This series adds ethtool get/set support for the RSS hash key.

Without patch:
 # ethtool -x $DEV | grep key -A1
 RSS hash key:
 Operation not supported
 # ethtool -X $DEV hkey be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef
 Cannot set RX flow hash configuration:
  Hash key setting not supported

With patch:
 # ethtool -x $DEV | grep key -A1
 RSS hash key:
 dd:7c:1f:06:1a:42:dc:e5:7e:90:2c:48:aa:3f:5d:5a:d7:da:ec:44:3e:3f:df:78:89:1e:3c:68:2e:59:da:a0:23:5a:32:5c:cf:5e:7e:7b
 # ethtool -X $DEV hkey be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef
 # ethtool -x $DEV | grep key -A1
 RSS hash key:
 be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef

Also tested with rss_api.py and toeplitz.py.
 # ./tools/testing/selftests/drivers/net/hw/rss_api.py | grep rss_api.test_rxfh_nl_set_key
 ok 6 rss_api.test_rxfh_nl_set_key
 # tools/testing/selftests/drivers/net/hw/toeplitz.py | grep "# Totals"
 # Totals: pass:12 fail:0 xfail:0 xpass:0 skip:0 error:0

Notes:
Since the 2/3 patch is unchanged, I preserved Tested-by and Reviewed-by
tags for the patch.

Changes:
  v2:
    - call netdev_rss_key_fill() in igc_sw_init(), not in
      igc_setup_mrqc()
    - add documentation for igc_write_rss_key()
    - drop has_user_rss_key flag, since rss_key is never cleared except
      for user operations
    - change email address from @amazon.com to @enjuk.jp
  v1: https://lore.kernel.org/intel-wired-lan/20251025150136.47618-1-enjuk@amazon.com/

Kohei Enju (3):
  igc: prepare for RSS key get/set support
  igc: expose RSS key via ethtool get_rxfh
  igc: allow configuring RSS key via ethtool set_rxfh

 drivers/net/ethernet/intel/igc/igc.h         |  3 +
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 67 +++++++++++++++-----
 drivers/net/ethernet/intel/igc/igc_main.c    |  8 +--
 3 files changed, 57 insertions(+), 21 deletions(-)

-- 
2.51.0

