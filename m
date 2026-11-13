Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ACA606A33A
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Nov 2026 16:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=1L9djzpv;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yx1DYt+6
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E074481518;
	Fri, 13 Nov 2026 16:15:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7mIPsaLn9BGU; Fri, 13 Nov 2026 16:15:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1307C814C8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794586538;
	b=sC6jQGQWuNKwWQuarSdIRy/Y/5rCpuUIjJrLOPUjVARu42taR0blppnoherqblKBYtzk
	 L7Isd7vyzBQBuiM10XLRa5mBeGOeJAawZXAeFWVP2Gb96ADMZQtxl4SHhdnnqFArQGeYM
	 IlJuhZqGmWkUMQxDRJ41Hhu8EU/yNOf2K923wqAnzQkOkaV3JQDxiqbFdTlR5vqcUxFCA
	 U0WnstfUqtkexGBkbigvB3nX0cFemqA+WEgxZnMBkIZDftdfL89TfXpTB8HRyHur9th9Q
	 5ZmBm5XIj04RFySlJ1OlPgJetuK/ZlMEcNAOz+PnwIr+4gz21z20oaE5h60vByMBCUw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794586538;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5h+z57HWL4/rF/aw7SgHN4Pg6kqjYwrgH+4Rg2LpjLA=;
	b=eZT7PLkePybV1vbRADjgmNo9fTCrzTut9Vu7BzqPGizMp615pE3iYM4DDGFUzVh04iKQ
	 pJFvZCzGaZy1ptpqCCL2ieeiqCNNf9DQFNPbavkBzOsIwD/YA/BYtIwD8JhCvTFywel5z
	 8oNG8XF9JR8KAllLeOBsEn+0L313pB5rUPSfadp8MgA2ckvndtQjzw6+cpDXaFQZKovyo
	 oOtuF15Awo7ewEvNTUiVSnoyip2rIwkCk9UcNDI/DN3CEp9CtpM1XkpfteA1zYXmCfYsW
	 YT1oNj26RZHHRqOhXRHpLtNAQsLKkJyfy+1QEe6QiuwBwTD2ShmDkFVR6BdKDmbJMlA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794586538;
	bh=5h+z57HWL4/rF/aw7SgHN4Pg6kqjYwrgH+4Rg2LpjLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1L9djzpvpeI+0y9YOqyUT5QQFSVAl8XnwzGUoA/vEgg9vhaOIGh61eXvunQ+WMN8z
	 8wBr7edkp0z4tr5YcV00RS4PT3Ol3pQb2dhzmhrnKdFIP0th8B+mdxA1LdXSHnXq14
	 /RknGys/EBrLi1G8iNKZnKnCUfRKOPZPslA70EnSLzjq8RYaNN2+Xh9p+HG9BohL1q
	 96lRqjEY9Z8tGonSjCuFrz3pFlECJ09b4fhBi1qbB2Dgohy1CQFFqz0x2fVOgzs0rS
	 9HEbPzSeehnCBFwM4d7syBNM+WgZejZGG6xBh7Z5tUzlKPp6jRyqmd/5vYWTscr4LK
	 C1uofFbYCXhIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1307C814C8;
	Fri, 13 Nov 2026 16:15:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C508AF8
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 16:15:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4E2F4401BC
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 16:15:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tRq96LgOTLjh for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Nov 2026 16:15:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 518E040199
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yx1DYt+6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTP id 518E040199
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 16:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794586534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5h+z57HWL4/rF/aw7SgHN4Pg6kqjYwrgH+4Rg2LpjLA=;
 b=Yx1DYt+6gxF/JEbuOdo6pcJuN27PKzgi/eCc0wjRDb0Cax2+NwPvd5C80smxSTuWx66+nT
 NGsvT5byb3ESH7ccGdolBfrXiPZB08gOiPpQTXoPGUyJ2G0v6lB2zIlMGMyR8yj6crqZjj
 1joWb3dO+knCCPXNsBBVjinaIiNi6bM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-ZsrDycOTOvaNHFTS-4B2FA-1; Fri,
 13 Nov 2026 11:15:30 -0500
X-MC-Unique: ZsrDycOTOvaNHFTS-4B2FA-1
X-Mimecast-MFC-AGG-ID: ZsrDycOTOvaNHFTS-4B2FA_1794586528
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D91E71800594; Fri, 13 Nov 2026 16:15:27 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 73FEC18004F5; Fri, 13 Nov 2026 16:15:22 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Petr Oros <poros@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Dave Ertman <david.m.ertman@intel.com>,
 Mateusz Palczewski <mateusz.palczewski@intel.com>,
 Leon Romanovsky <leon@kernel.org>,
 Rafal Rogalski <rafalx.rogalski@intel.com>,
 Shiraz Saleem <shiraz.saleem@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-net v3 4/4] ice: do not block on the aux device lock in
 ndo_setup_tc
Date: Fri, 13 Nov 2026 17:14:53 +0100
Message-ID: <20261113161453.1234851-5-poros@redhat.com>
In-Reply-To: <20261113161453.1234851-1-poros@redhat.com>
References: <20261113161453.1234851-1-poros@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wtemQVqm9BQQVnhOocKQ3xD0XjotrzVdC9XUw6NKCp8_1794586528
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The TC_SETUP_QDISC_MQPRIO path of ice_setup_tc() takes the auxiliary
device lock to test whether the RDMA driver is bound, and ndo_setup_tc()
runs with the RTNL lock held. This closes the same cycle against the
RDMA auxiliary probe as the two preceding patches.

Use device_trylock() and report the device as busy when it fails. When
the qdisc is added, userspace gets -EBUSY and can retry. When it is
deleted, mqprio_disable_offload() ignores the return value, so the
hardware traffic classes and the channel VSIs stay in place until a
later qdisc teardown gets through, the same as the existing -EBUSY for
a bound RDMA driver. The message is a netdev_warn() because of that
second case, nothing else reports it.

Fixes: 4b31fd4d77ff ("ice: Fix RDMA VSI removal during queue rebuild")
Signed-off-by: Petr Oros <poros@redhat.com>
---
v3:
- rebased on "ice: fix DCB lock ordering", no pf->tc_mutex to release
  on the new error path

v2: https://lore.kernel.org/all/20261023070258.730168-6-poros@redhat.com/
v1: https://lore.kernel.org/all/20261019065301.3983537-4-poros@redhat.com/
---
 drivers/net/ethernet/intel/ice/ice_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index bbe4409b16cf57..fbcce9bd798dc9 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -9581,7 +9581,11 @@ ice_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 			mutex_lock(&pf->adev_mutex);
 			adev = cdev->adev;
 			if (adev) {
-				device_lock(&adev->dev);
+				if (!device_trylock(&adev->dev)) {
+					mutex_unlock(&pf->adev_mutex);
+					netdev_warn(netdev, "RDMA auxiliary device is busy, qdisc not changed\n");
+					return -EBUSY;
+				}
 				locked = true;
 				if (adev->dev.driver) {
 					netdev_err(netdev, "Cannot change qdisc when RDMA is active\n");
-- 
2.56.0

