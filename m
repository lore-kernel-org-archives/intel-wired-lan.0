Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6187C88E53
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 12:56:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B4CEE60794;
	Tue, 15 Sep 2026 12:56:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NmJzFmg7aCn3; Tue, 15 Sep 2026 12:56:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 298D360786
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789476975;
	b=cosrC7xwNycAYlqYIQ+A/86Ghg8XIigO2gVHOqY+vOq9EBP9pJYqE2b/VVcRdZImYW7t
	 rMAA9sZzPVxhzqlk3x+I2kR6vFU8OZXjcS4d8sRALBdyr0fuSmFsT3YLKlXZKr8h3TzkF
	 qRcZLSeAy3qvxTJG5ZQhyqZC+c/ijkoquXgBXwhiKGTHnjHpx/MSz/45sV6q9xYEMYBH+
	 RdMU9BSME207qQQZuHNAa0EH2R/Y7rycebZY6Ddv73LR8k1AeAR2WPEzoysjHDEVmUAX/
	 FVAXZuj8deKMwbg8HhF1BtIpMnYTa1TUq3SyFPk5t79BNmwKF8n159slij2HsFa/faA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789476975;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=AnwrEzHqLaA/DGUahrUo8iuMuW8GGkjoQoJVIGUoRnQ=;
	b=sRPta/Y7UYK3Oz2jD0JxQcci5XYMewRcK1uXupRb1Wfb6/88l5H+inyLWE7fDX+rMfnw
	 38fb9dvyueZvb05xbtDZMR6L39l0PHMKLXncpm0q3N5YK05a33kOpmEUPjdRTjncaPoEU
	 +yhW0ma+xkydnjBx5DdU4v+JA9Y7u+utWEsKg0Ud8cNfd7RPGG5MNO+BZpn6aNGwWOIvt
	 E4vURpunq1c5Kdw9iShMdtsCLt/PdDpJ0KhPjOFg/TlIcOGZksUPJS3kCZAQf57pugVwv
	 2LVAfuncHKSWH+j96Ou3Jpkm/mWWUOLFQ07RWdkIjERgykuvNiZXqAaDZHhvaM9DTHg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cSVEMbV8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789476975;
	bh=AnwrEzHqLaA/DGUahrUo8iuMuW8GGkjoQoJVIGUoRnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pnztRSUDx2xOd5kp1BchjNH3gA4flqjQG7U9pkEaarSLxN5M6QUvkTyksSQSPU5sz
	 NcSr3y6z19ry+fMwoI9lIJKOWVqWC/XQDHYpI2El5EbGuxHn3ot5/sq88/tzZTQQDR
	 ul38N6YGmxuUMQqYkzGOkrN269YEkxuSQmOZ8g9RHcgiF93zMSWW28dsv4rwUvitlJ
	 CdAJpFKmJhfmvQjjNyoEqGXkVK4tdcevPYMFeSaR3kkIJKfAG0FQbfdY0OYHINveKX
	 xS039D4QzApUGsoS4KePBCQP0YG9ovIMVhkHrDOvEPm6Aa//+bc39BoanUZEOdoSEh
	 z/5wj4DFARE8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 298D360786;
	Tue, 15 Sep 2026 12:56:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BDB31259
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:56:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A3BD5605E0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:56:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LsEHFkfunQc2 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 12:56:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 026556077C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789476970;
 b=fUWsJd4NJpfvX6yYy7SKGa594HZnEs8i7L/81y9/GbGEfBTCgta5eINHKaAhRyzvvJ58
 qHHXQCJUnHgSgzwqlyQenk3vL9vWtiOnwZ21EWC/iVeqs4UdbE4X47o41lOYycjcBZSgF
 YX95crEadCRrycCcC2Z0Wj88XH6zrD3FMTBXUsGZaopdOXXhBbtWiUhd730SJH35VfBkf
 ABHlqNCGMu9vKNxrz1QdgtiYhQ/9tHnYH01S6cclLTCjiEB+D+ZZOyP0BblRvHVa6lBjp
 FVlPRrd97czTV3jmE2HnnUyat3jns6nVluJI1U6tZ7ABTp8F3wGgJ3U4RQ6JLHQOSjw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789476970;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:Received:From:To:Cc:Subject:Date:Message-ID:
 X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=AnwrEzHqLaA/DGUahrUo8iuMuW8GGkjoQoJVIGUoRnQ=;
 b=sqpnNgbvFw2b73oCrQ0q9HGm0CMpPi1IPSNKmsmaXBfhr6QTQghWLtYU2BP+Dlrj2Ajt
 YYl+3wp0xaJnxEXjN1XBpTugA5MLO2vHgWnWXQtUDBRT5BNgcynagiH8wZxDWrL2nEvUQ
 5U5KjNjO9C+iAH6xdRCqNMVNkhF88/nhSWkf/LaSqcCFPgB+xOrq6FB+4SOnFrPbOrrsE
 4II1rpIgiPcg+kfSpXnByXlBGDlbB2PcGQe0SquJx7vOqya/C7wSEFgRSgbtlACHXACWJ
 IXD7wrh+a8Dl2SfzTNjonirZi3twJSxPUEj7Lfee6RSw4DecL6wrtLArUS7NgMFySdw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=cSVEMbV8; 
 arc=none smtp.remote-ip=198.175.65.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=cSVEMbV8
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 026556077C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789476970; x=1821012970;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KehZcwkWdnhWf0oheib2pksWiItrtHlAvJaoTz5VeWw=;
 b=cSVEMbV8GFxEJa3Ol/CqI7tzj1AIjd6usx4b0LePHGS+pgZ0v4Q+eCW5
 zQTA5H1RnsqVOf2haGd9IL/Zpc+FiWZyxoIMvORV2DtJOe8PKr8LdUGdW
 6BGa4/kHtU42yrYPRYbpdMzCACaAt/t4DpsXgV9AazIoeZoIk9jv0L/fK
 lvH0mszQHJtlKxTwsgG5yPHIN+OB5Hpsy0M1L73goG9iWIkxwC2iBKcSv
 miPhT7uQL4a9vQ90P8yd5TJFnTtRuvsGPuoC3NYkWCyXfo4iZy6+tlvde
 nRbRFbQKuH50NfuQ65j6TvbG2VDSuSxWnvgCLKYWeiXHWJCWtbg0bj9j9 Q==;
X-CSE-ConnectionGUID: 1kJ4mKEDTKSCex0TNICBKQ==
X-CSE-MsgGUID: +pnEoVy2RBmI6hb7QyPXdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="112607087"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="112607087"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 05:55:58 -0700
X-CSE-ConnectionGUID: 0drApu48TcSxA8bkTa18UA==
X-CSE-MsgGUID: O7ePtFbmT6mtTuc3RJveSw==
X-ExtLoop1: 1
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa003.fm.intel.com with ESMTP; 15 Sep 2026 05:55:56 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
 Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
Subject: [PATCH iwl-net v2 3/5] iavf: prevent VSI corruption when ring params
 changed during reset
Date: Tue, 15 Sep 2026 14:55:49 +0200
Message-ID: <20260915125551.3976068-4-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260915125551.3976068-1-aleksandr.loktionov@intel.com>
References: <20260915125551.3976068-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>

Changing ring parameters via ethtool triggers a VF reset and queue
reconfiguration. If ethtool is called again before the first reset
completes, the second reset races with uninitialised queue state and
can corrupt the VSI resource tree on the PF side.

Return -EAGAIN from iavf_set_ringparam() when the adapter is already
resetting or its queues are disabled.

Fixes: fbb7ddfef253 ("i40evf: core ethtool functionality")
Cc: stable@vger.kernel.org
Signed-off-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 1cd1f3f..3909131 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -495,6 +495,11 @@ static int iavf_set_ringparam(struct net_device *netdev,
 	if ((ring->rx_mini_pending) || (ring->rx_jumbo_pending))
 		return -EINVAL;
 
+	if (adapter->state == __IAVF_RESETTING ||
+	    (adapter->state == __IAVF_RUNNING &&
+	     adapter->flags & IAVF_FLAG_QUEUES_DISABLED))
+		return -EAGAIN;
+
 	if (ring->tx_pending > IAVF_MAX_TXD ||
 	    ring->tx_pending < IAVF_MIN_TXD ||
 	    ring->rx_pending > IAVF_MAX_RXD ||
-- 
2.52.0

