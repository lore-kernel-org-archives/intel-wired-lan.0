Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8653E1073C9F
	for <intel-wired-lan@archiver.kernel.org>; Wed,  8 Apr 2026 11:44:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1C55240E7D;
	Wed,  8 Apr 2026 11:44:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MVmA_7AuYWUe; Wed,  8 Apr 2026 11:44:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D5E2B40E4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775648660;
	bh=apvxNvFh6zczRf/Be5XiSSGrUuihP4EaQpIATgjjTDg=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qT8q65Mz9y7A18Tu9zZk5BC0VZj9BtBs3wpYKgxYgXHxW8FDBqTV0QG9etC3G9rSu
	 /DdPArmLx9JdUasxgQLpuq/l0eAxzVGUYLtT4AkfeODsRjH0WLhyF7FSl8FkOiWGfR
	 qiYUrwNvDabfdMMywVpOh0BTen5phl/Rbqe85HRgB7SlYRifnjug7sksErp2ojfL/B
	 aU+8/CpFdcuZdGIBZnja6141kkWUzW3w2uuT9QUKY5tdK6TJnYyXAkIjhpf4Bkn+yL
	 /SYsVzuMKKYtIbsCHl6KUJW6JONQRYF9/PGby8y7h4jJqTZuXPfvVtzMkqOPjIuF3O
	 XKn/aCbugX75w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D5E2B40E4B;
	Wed,  8 Apr 2026 11:44:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 949391F6
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Apr 2026 11:44:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8641982299
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Apr 2026 11:44:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NCZrrFdBNS7r for <intel-wired-lan@lists.osuosl.org>;
 Wed,  8 Apr 2026 11:44:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=pabeni@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7DDFF82178
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7DDFF82178
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7DDFF82178
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Apr 2026 11:44:17 +0000 (UTC)
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-IOHacHi5N5KJHQgR41Yfdg-1; Wed,
 08 Apr 2026 07:44:13 -0400
X-MC-Unique: IOHacHi5N5KJHQgR41Yfdg-1
X-Mimecast-MFC-AGG-ID: IOHacHi5N5KJHQgR41Yfdg_1775648651
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D3F5D18005B3; Wed,  8 Apr 2026 11:44:10 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.173])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4AD8C1800361; Wed,  8 Apr 2026 11:44:06 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org
Date: Wed,  8 Apr 2026 13:43:44 +0200
Message-ID: <cover.1775648513.git.pabeni@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: HRzmk7oKQUkkZHAGXNx2y_BCWXu4IhPTaI5_XQOS8xM_1775648651
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1775648656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=apvxNvFh6zczRf/Be5XiSSGrUuihP4EaQpIATgjjTDg=;
 b=Xmn4ySaXKCqgMSlPpwmnaEJMES23EqE+stL4oux8QPEJ5oSZPXP+ZkSxRU+/RzGvInM9AS
 Kzrs8Yb2CBB0CAxCyMSwMwXfdyJGNK0CBJr5gyRyQSNben45zj40g+nKBpoG+Ruc48Uhxo
 ly+fvDIY4tQ9wQo1ZbfaaVvRuXAYX+Y=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=Xmn4ySaX
Subject: [Intel-wired-lan] [PATCH iwl-next 0/2] i40e: implement per-queue
 stats
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

The i40e driver already collects some per queue statistics, but does
not expose them to the user-space using the standard interface.

Implement the stat_ops callbacks and extends the already collected info
with basic GSO counters. Overall this allows passing the kernel NIC
drivers TSO test cases.

Paolo Abeni (2):
  i40e: implement basic per-queue stats
  i40e: keep track of per queue gso counters.

 drivers/net/ethernet/intel/i40e/i40e.h        |   9 ++
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 144 ++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   8 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h   |   2 +
 .../ethernet/intel/i40e/i40e_txrx_common.h    |   6 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    |   2 +-
 6 files changed, 168 insertions(+), 3 deletions(-)

-- 
2.53.0

