Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E15C61DA4
	for <intel-wired-lan@archiver.kernel.org>; Tue, 14 Feb 2023 21:01:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2A95360EA1;
	Tue, 14 Feb 2023 21:01:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2A95360EA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1676408496;
	bh=JizPfUJh7ZlgxBh4O8nrr7vn7EM+36V+N0zjLUXhGik=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=oFmwPjAbJr07PiME5TVWWQxdIQYOulnA14FH0Gwq6LIaXzoV8IIKhM92vN73Ib8GE
	 dC9t0y6TlLZuXKBQa6ZPzUR+HMR+tvoQ0hFsVN4jetkNknRUTr6RYbiEiPrXcQop03
	 dDCl9vAZKctoQrvMmcLbYi9TKegyOrP+y6BgXx8YRcWoVvg5q5qJkY2bOe3ESgqIU5
	 OW7GixSmWqPsFlUM1i47NKtJ5x/xrDZmSIu+j+x1Jbq+WHMHjfjabzMuK3TxWQx9Su
	 bpq8nox4an87Gyx4hqzHxD+1P9f3ITH2nuky/pWrOl0eYesOJlSwP5me/W6wuWjgOD
	 jXEKSsBm1vvkA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K-ZFY41BJuis; Tue, 14 Feb 2023 21:01:35 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E3BC60F88;
	Tue, 14 Feb 2023 21:01:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2E3BC60F88
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 9F0BC1BF299
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Feb 2023 21:01:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 675A081E55
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Feb 2023 21:01:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 675A081E55
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d0S79HHLC8oz for <intel-wired-lan@lists.osuosl.org>;
 Tue, 14 Feb 2023 21:01:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CCC61819ED
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CCC61819ED
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Feb 2023 21:01:24 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="417490079"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; d="scan'208";a="417490079"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Feb 2023 13:01:24 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="699677918"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; d="scan'208";a="699677918"
Received: from jbrandeb-coyote30.jf.intel.com ([10.166.29.19])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Feb 2023 13:01:23 -0800
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com
Date: Tue, 14 Feb 2023 13:01:15 -0800
Message-Id: <20230214210117.23123-1-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1676408484; x=1707944484;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=sOc8M1eLMwcudngENOO0pUlTkaeNSCKlfXVxLrmzg/k=;
 b=ZHHdecP0klXZh4+nbyUOTEs92DRYE2YdY6Yhmnq8rzrRiukb3d36fGKQ
 puJ8btqcfHj/dlT8zzwolx/qJ8Upt9+UiqqmL/PX3iVn0A2vCyCnNqNFE
 ybo4bqQNBMnjXxddUUlpXuVnEgX3urcMgoHtyQkdavQgk03OZhhaq8zWz
 7S7wgyhQ7tBKv45l0ygn9U1C/HmHQs29wOhRSSiluEL3wsicJWQxlIjLd
 Xye6YRHWO/aW1xmVEzJB2OKsnbArJahiP10X7xLeXIAGLJfahu4xQU6lO
 oQOCK362u1ZygitLc5cWwmZAl/fov4Wn62u5+n2f6WzjMQ5G7PAEFXZSR
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ZHHdecP0
Subject: [Intel-wired-lan] [PATCH net-next v1 0/2] net/core: commmon prints
 for promisc
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
Cc: netdev@vger.kernel.org, edumazet@google.com,
 intel-wired-lan@lists.osuosl.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Add a print to the kernel log for allmulticast entry and exit, and
standardize the print for entry and exit of promiscuous mode.

These prints are useful to both user and developer and should have the
triggering driver/bus/device info that netdev_info (optionally) gives.

Jesse Brandeburg (2):
  net/core: print message for allmulticast
  net/core: refactor promiscuous mode message

 net/core/dev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)


base-commit: 2edd92570441dd33246210042dc167319a5cf7e3
-- 
2.31.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
