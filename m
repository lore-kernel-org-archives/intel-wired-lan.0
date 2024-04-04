Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E77CD1284
	for <intel-wired-lan@archiver.kernel.org>; Thu,  4 Apr 2024 16:04:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6295741989;
	Thu,  4 Apr 2024 16:04:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5skROHLb2A3D; Thu,  4 Apr 2024 16:04:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 52FD841960
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1712246678;
	bh=QigOU9+0+vlUq30HWsJwxxztgCVkP2RBt7nhmgU0aNk=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=Se+30Run3bHL4oonfip6mSFxvBighWR49VS/L/sJkG5S3DqNA3oZcOAmm91EbhQPv
	 IBhPNDCv531a/vuOrJ68QLh9CrCWIbwTwpxQkuXpUq3BAY46cMLWwLZu04PQQFc3pK
	 Ll2DEhV4zaJME2QP+NQHBIIqLpDRxfmLtYufUS6m7WeCo/w0a60W9ky8XXym2Ehomd
	 bRfeMvqhyFztM6rdcc2ApXYxq8f7VNeWoJXjTHtlusPtvFDqkQmZ+XyiLuYryKgJuE
	 tSWaZAAL8P3Ti71HpMR+zuBBl+RE4RWZ50hLAvpKToe29bBVhmdy2WBDJ4J8maALui
	 DYKRWHHfTajnA==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 52FD841960;
	Thu,  4 Apr 2024 16:04:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 46DB71BF366
 for <intel-wired-lan@lists.osuosl.org>; Thu,  4 Apr 2024 16:04:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3FEEF40480
 for <intel-wired-lan@lists.osuosl.org>; Thu,  4 Apr 2024 16:04:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xW7Lb2_tTnwi for <intel-wired-lan@lists.osuosl.org>;
 Thu,  4 Apr 2024 16:04:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=aleksander.lobakin@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3B37040476
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3B37040476
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3B37040476
 for <intel-wired-lan@lists.osuosl.org>; Thu,  4 Apr 2024 16:04:34 +0000 (UTC)
X-CSE-ConnectionGUID: 2NSOE21mQnmfRkDYGKiGdg==
X-CSE-MsgGUID: pPX7rAQaTwqeGq/xfJtuJw==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="11315331"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; d="scan'208";a="11315331"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Apr 2024 09:04:25 -0700
X-CSE-ConnectionGUID: KVv5SIu9Tma6YHAJYSBMlQ==
X-CSE-MsgGUID: TTKSY83AQ5G201GXjbgN+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; d="scan'208";a="23292859"
Received: from newjersey.igk.intel.com ([10.102.20.203])
 by fmviesa005.fm.intel.com with ESMTP; 04 Apr 2024 09:04:22 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Date: Thu,  4 Apr 2024 18:03:02 +0200
Message-ID: <20240404160302.3585661-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712246675; x=1743782675;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=JAnb7ekQrdFs07fy9SPZ/n1vc9+Tp4GolLxUfCmpr/8=;
 b=WFtrvMwEtILW/TX7bdyjJJ6xVuA2NW1+wgaUD5y3jH0+Oye/biZ3YuoE
 PMY46S9JHwO5wpjgDCq2lfEZTvk6TwJk5ssMqM/pMIjYKucvrknFpkd3S
 tdZzRlLF9L6wlbZEEVB6WnORBk9zn+ZQbA/gqSjdobgx3dCaP1NpEDyt7
 wfkAIBRcc9HP/sVYMJpd9YbHEWGJo47J7l8onEZm3H9Ng4nFKVY04mEAl
 GA905HimcZHeI33M8VTQrByaPmpM9+TB/WEKSMMNCEAo00xo19C0Qaptr
 fSjhpKZKNB1OeKICO1u6XV4hqZ+V7T4Vf3/HrCfofDn7G+yblt4jVFtV5
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=WFtrvMwE
Subject: [Intel-wired-lan] [PATCH net-next] ip_tunnel: harden copying IP
 tunnel params to userspace
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
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
 linux-kernel@vger.kernel.org, Alexander Lobakin <aleksander.lobakin@intel.com>,
 intel-wired-lan@lists.osuosl.org, Simon Horman <horms@kernel.org>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com,
 Dan Carpenter <dan.carpenter@linaro.org>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Structures which are about to be copied to userspace shouldn't have
uninitialized fields or paddings.
memset() the whole &ip_tunnel_parm in ip_tunnel_parm_to_user() before
filling it with the kernel data. The compilers will hopefully combine
writes to it.

Fixes: 117aef12a7b1 ("ip_tunnel: use a separate struct to store tunnel params in the kernel")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/netdev/5f63dd25-de94-4ca3-84e6-14095953db13@moroto.mountain
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 net/ipv4/ip_tunnel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index f63b573f66dc..6ec4365cefa5 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -1034,6 +1034,8 @@ bool ip_tunnel_parm_to_user(void __user *data, struct ip_tunnel_parm_kern *kp)
 	    !ip_tunnel_flags_is_be16_compat(kp->o_flags))
 		return false;
 
+	memset(&p, 0, sizeof(p));
+
 	strscpy(p.name, kp->name);
 	p.link = kp->link;
 	p.i_flags = ip_tunnel_flags_to_be16(kp->i_flags);
-- 
2.44.0

