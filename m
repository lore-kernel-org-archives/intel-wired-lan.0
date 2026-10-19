Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BFDCCCF2DA
	for <intel-wired-lan@archiver.kernel.org>; Mon, 19 Oct 2026 06:53:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DE584605FD;
	Mon, 19 Oct 2026 06:53:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YDybrtwWJclK; Mon, 19 Oct 2026 06:53:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3B65960659
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792392818;
	b=jBo9Cdlb2Te0VNTJ8kH5p76iVG92iyeTzJA0PRZn/eq8qEhhBeAPnitBfrEnhBkx40Ga
	 /5aN6EtJPGGT/lU0vVLrmOsG2oajiyz+XF6aJHbCOyMvgRfRtgGy+A8dcGQLE3n1DRshB
	 Qp/AClXFm0ZgqoEC0UDs5vKzaWOPPHCaaXUJpSO7/DC7Lv9WZwc0//4J6Kp8AAwCve5GJ
	 c2q82kJ11gCiGi22K4cZiETvMjVRAfIKcluTiMUc+STWxkr54NAy1dDW4JEdcfNzsWs2L
	 Jqcn3ovF8XJlqgrCzQj60cc5/ytemWkmjuaTdL4xUp8zlR7DR4dBFuERgpoHtppv+uw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792392818;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CTHOWVdv/FbYDqyrQZpXckGg41AN0bG8lahV7yIctow=;
	b=HBw8pjUi9Sd+G1BtoIyuGB8L6cMwxYS9HWVVTpEhtdtdqlEPQIN9yuZ3bfgeKMTZxZkk
	 zMA856BfA3F8KPp8UrnHnbwLdtzVBZ9Z3fIFGceYrM/WHW/vGtLby+qll6gymUWCkR+Kn
	 D4qNYHkpBPIOXCA2n8IxVmD6n9fIAA8W9X83E+qRX64t18RU3xE8Qm3BhymbLYSP48Uv7
	 quLeoSv/87DKD3ZkvDbgszbDRnhc/ogRfZUOKvujhgpy/GEHqTi8cE5UaSLE59ro3l5HB
	 Z2g9h08QioeSsZJYwpqVNgPFiwo86QvKwBAYhyfNSs6Ckfn0wlMmek63ydFeCgnaXwA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792392818;
	bh=CTHOWVdv/FbYDqyrQZpXckGg41AN0bG8lahV7yIctow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WbZuIj5pvAweK4Il+sesyC1MVbmYmPsg0TtM5mDWSg8esSWKIHI0WzgxkApcua7Wf
	 4w4d0I4k/PZPKlQgj/ySZM4JxwjvYmVZ4599WgavJkUPZNz8PWmqSF8yzke0MSmtfi
	 mmb8X7STCoiYAJcTwfUkaj2/bTqUGj2gbDAjhbzSDb3sFmb95hqRUjIWQTHKDRY8or
	 7IRvFv5PV0+wsyKn/U3fwBJwA+7TomIRxnhJ4to/l1/7oYu5zEp+oP6MLuPRraG9cr
	 XYJChFAstRqGtP3Od9f7SSGfGoh2rNa+mmVPjFQyTVTvYVn1VA2ZgLSPVAm1z1xTgl
	 hngZA4UAakPhw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B65960659;
	Mon, 19 Oct 2026 06:53:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 195F075
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 06:53:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0AFBE80F6C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 06:53:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1n8fF4fa9bJO for <intel-wired-lan@lists.osuosl.org>;
 Mon, 19 Oct 2026 06:53:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4AFF280730
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792392816;
 b=XuciKVXB9W6G6MEcfBv081+/yn8w+KHfNpMpkI7V0R/QEu3kFzXZYuHHQgGV9O8BknJa
 iw8P2bm9HkHORnD5CZVC7Cb5V9eR0HKVMGPkxPcj088lNBO+HknGfCvrQAZL8jJNj8ob2
 rvx/WbKCQ+EpzXdEwMA2oCw9jNvq2eDPvio8RqXOCl9g+d21nm+qmGWCxxoFz6AQpfMj7
 9H2eJpRL465ji1lJZEBmedlHbReA6F342GfwJB+pUjQnZprMzxAYr3qpT9CKelJv0NWT+
 hS8VcQqCpLgHYGVpYlQQKDtd0PyVbI/XkUZpqogIXfbTMjbSYjSQ7wJSwLTdR97WOxQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792392816;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Transfer-Encoding:content-type;
 bh=CTHOWVdv/FbYDqyrQZpXckGg41AN0bG8lahV7yIctow=;
 b=XJxnfcNQoTcO/MRlB6EESjHznomkjUsOH70V3MQrNqYdDh/lE8+VtYoi1siHpkYFPa7f
 RX3VEGw7FeTpz81HCi8MNCWoTyTlO9/xMFJ4jZrLIvDtXtW8ZAkwRD2NSIlQ27ciK3tPO
 v5rTdZduNFUS3gLDUJ8B4q/ClPCUd/oUct9hnSJ6ykL4vQPsutkSwrVUt97SSOCoOOTRx
 mOrcPyegDmDqAGXEmevzyYGqJH0jaUj1PIE31lLXGeyWAOKjl3gT60SXe0hWOtBFxf38d
 to7vnuQ9rp5ORO2Xg3LYkqYOnCYRXJsu+bFcBZP13uMaCfDbnjet2iY4w49RAAsKyhQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=redhat.com;
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=ROSQjReF; 
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ROSQjReF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4AFF280730
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 06:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792392814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CTHOWVdv/FbYDqyrQZpXckGg41AN0bG8lahV7yIctow=;
 b=ROSQjReFQuQmLRBHPq1KuLID/OnF6eOnRd/XCQ89x0s05+QM7U5bIl0aZ2xk++AAS2eEiP
 vVpCP5njMG4dGI4QIWLt7CVvrbbfY06Z2O5hf11q7CFdWdIc1woZcm/Vrp4fvp4Gynhuoz
 C5VWb+2c4cypXSnL+FB0WC3L/B3dSzQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-7vzVymaHN6a8IU00hPedoQ-1; Mon,
 19 Oct 2026 06:53:30 +0000
X-MC-Unique: 7vzVymaHN6a8IU00hPedoQ-1
X-Mimecast-MFC-AGG-ID: 7vzVymaHN6a8IU00hPedoQ_1792392808
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E15DC1800652; Mon, 19 Oct 2026 06:53:27 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com (unknown [10.44.48.130])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7FFEA1955F03; Mon, 19 Oct 2026 06:53:21 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Dave Ertman <david.m.ertman@intel.com>,
 Shiraz Saleem <shiraz.saleem@intel.com>, Leon Romanovsky <leon@kernel.org>,
 Kamil Maziarz <kamil.maziarz@intel.com>,
 Rafal Rogalski <rafalx.rogalski@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Michal Schmidt <mschmidt@redhat.com>, linux-rdma@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mateusz Palczewski <mateusz.palczewski@intel.com>,
 linux-rt-devel@lists.linux.dev
Subject: [PATCH iwl-net 2/3] ice: do not block on the aux device lock in
 ethtool set_channels
Date: Mon, 19 Oct 2026 08:53:00 +0200
Message-ID: <20261019065301.3983537-3-poros@redhat.com>
In-Reply-To: <20261019065301.3983537-1-poros@redhat.com>
References: <20261019065301.3983537-1-poros@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: GIfhgyU9N_5zh-AWA6v5y1INyqOWn8xAOKnXfbVBjWs_1792392808
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

ice_set_channels() takes the auxiliary device lock to test whether the
RDMA driver is bound, and ethtool ops run with the RTNL lock held. This
is the same inversion against the RDMA auxiliary probe as the one fixed
in ice_send_event_to_aux(), reached through a different caller.

Use device_trylock() and report the device as busy when it fails. The
existing diagnostic is not reused, a contended lock does not mean the
RDMA driver is bound. It is a netdev_dbg(), the condition is transient
and userspace already learns about it from -EBUSY.

Fixes: a6a0974aae42 ("ice: Prevent set_channel from changing queues while RDMA active")
Cc: stable@vger.kernel.org
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index bf9a821c543b7f..f754ffe03285e2 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3944,7 +3944,11 @@ static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
 
 	if (pf->cdev_info && pf->cdev_info->adev) {
 		mutex_lock(&pf->adev_mutex);
-		device_lock(&pf->cdev_info->adev->dev);
+		if (!device_trylock(&pf->cdev_info->adev->dev)) {
+			mutex_unlock(&pf->adev_mutex);
+			netdev_dbg(dev, "RDMA auxiliary device is busy, try again\n");
+			return -EBUSY;
+		}
 		locked = true;
 		if (pf->cdev_info->adev->dev.driver) {
 			netdev_err(dev, "Cannot change channels when RDMA is active\n");
-- 
2.56.0

