Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066B8CCF2D6
	for <intel-wired-lan@archiver.kernel.org>; Mon, 19 Oct 2026 06:53:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C1D24605F3;
	Mon, 19 Oct 2026 06:53:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UTGRy0tZsg6r; Mon, 19 Oct 2026 06:53:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2C47560612
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792392839;
	b=sh5qHR3bvf+76KMephM6h909j1gj7zOtiErWb4lrtFkep7WJXybrfLaH1F4SSmfePH1d
	 Ow89tD8rXh8J9zHGk08xq0HiBfYtyU5FP4i3AAcMX6Jrrolq3SRcKhVuFaScfr0QGkSx9
	 71TG9+1X1QrZTERXMCvb2ghRsAGwvek2SBNF6f/5a9EjnINRakEaaLGn5VuAm92Xw2GU4
	 i+0UAKPiZWl93ZLGWGfhzglJ/1K0K6EVs0IQsCiwLZg3xD/XlYScXCVRs+5Nml0pmoApv
	 Yra8j8kPWevj9fip3XDf/b86dQ0cIfepE2NTlZjJ8gg6whE4pCAFXRB4zgIB/bgqyFQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792392839;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+7V933gJJwiBIK/wX238Dvmgf2YOL/YBDIJFdDFHDQ8=;
	b=pbHFO6tcAXz5n1Nxv8VjkpM7oJhjt7FP3NARrrB94GgJhNmT5MRalAzA0pb1ML9t1Hd5
	 jbVlf/wWPe1W2EA61o2svO2b2c2sinKjxO7TdVcn80Q0Ehw2sBs/vJGjAnwhOpsAUf09T
	 PFbv2/ThU8h1PrFgt765AMppkLkcyjPwDWo3Ap2FLBjw53kEHM1YeGw4PCVE8czoEovuW
	 nASrEClPUtNtUzYLaHP7BfvvjwdBGoU4ZyHUbrP+V5bul1yWsbr9yqdP+hZ6uP9qnHTJc
	 nZbntkjLqGxosmrNh7o4X1eruKupMZPRSbYI3XurmGjBAKlZZvvbZm7bUUm1F4YrOdQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792392839;
	bh=+7V933gJJwiBIK/wX238Dvmgf2YOL/YBDIJFdDFHDQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MkkjHhZtxxGM7B/vDXb2iSpEgCfwPJY6sIRSbqYL7y5IeMfPsQ2/t9yeyZyfDfQf+
	 D/ta9ILv/ahweXIfJeVdqUn84vHM9DxDcGFs6v6p3UoaLhh4xZiKvnfrNR/tYqwp3R
	 SCOb84Tp7kbXNjaVVhTU0m63Zm6yvqM7p4X04jwmuLPoHAX/xNgnicCMXbuU1UFq/5
	 7EMRxNXXfUsCTUoQG98WclD055S95py+fOnXExI7GMdm+stVDtome3eRsfUa23th1F
	 3dQ5cR9EKDG+rNouTzsm6hMRrPGzkqH0yc5J9M3V/upwXSdxSXTrS+vl7XKmhXpw8p
	 jeQrAwteJ1kgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C47560612;
	Mon, 19 Oct 2026 06:53:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 345D775
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 06:53:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 26ADF4056C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 06:53:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s_5ZPSM0rtvD for <intel-wired-lan@lists.osuosl.org>;
 Mon, 19 Oct 2026 06:53:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2A6C64056B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792392837;
 b=LQCoLaGTabchMSxgPVjnV4KU3Kb6rqCzYazeTqJVOWymFWZWpPNEDV2siPux/HxEJnDw
 ebuhcErcGZ77wZ+mnsJzMtBhn80m9yleuA5eFzPIlhLh2BFEApQsIvMjs91zH5WqHBgm9
 mU177bIBxjOlXelTYr7Q5IWXwPUu4bziDmpvTPQkYEB3iaby/B34DthpyLm4+o5kPuD3K
 m1ZfX67JWAPpY1ige/0Y2acVqCFJR0JTpQi9PIhO7qXmeZmh44lY/gixVyj7fqFG1Qzk1
 liAOPBZu1y4zJTDfb9ViOi8hSgD7Rgs8PhDlw8sIp/7SXlxnT5GPx2JJZ5f3kQ8Lu9w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792392837;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Transfer-Encoding:content-type;
 bh=+7V933gJJwiBIK/wX238Dvmgf2YOL/YBDIJFdDFHDQ8=;
 b=kH+pqP0CChgptexEvfEvIhHAGJGaxh52JNg2nQBVq3mXh6PaJ97F6TVbIogVC17OoVq/
 JfocwnUhU5Yf7dCJa+80VeYhhKr4NhfFRh1jLkeYyZrDP8EGjDF6lNjadCDWMt3Y7mr7V
 sVwFLt775zzNShKzjG8zGVV70AXMZ6PEnavybYY2/n9hcHtV18tt/6vO0zg/Sid7BncSq
 q3HKs6yho9Nmjx4GtfldcdOZAGU6JDeCSMJKvQf95YJbAMVpU6Iq/zxZ9ImjlC9RgiGZ3
 zi+pVtBioA90zztzwSBMj3Oj5Oq1IBM7G3AdEovVV/osZYZNFyPAAXFfoHlzw1ZE52w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=redhat.com;
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b="Zyp/vqlp"; 
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=Zyp/vqlp
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2A6C64056B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 06:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792392835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+7V933gJJwiBIK/wX238Dvmgf2YOL/YBDIJFdDFHDQ8=;
 b=Zyp/vqlpU7IbsKGdIG0z22axN30RKzU53GFNySVHb73t2anT5oOR0BpufNx+DqAAZ/wfnm
 hqh2gu92M1lmtxfZ6uoQuZHES/fPgigJNYvZD4WdZLTicvppXm4nMmd3OxcsS14c7z/134
 zHKOzgvz2HUX+Ml4i2OAhcBoeDznqHU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-489-tqBd2ESLMDC73_C1eKDJ_g-1; Mon,
 19 Oct 2026 06:53:37 +0000
X-MC-Unique: tqBd2ESLMDC73_C1eKDJ_g-1
X-Mimecast-MFC-AGG-ID: tqBd2ESLMDC73_C1eKDJ_g_1792392815
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B90819560BE; Mon, 19 Oct 2026 06:53:34 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com (unknown [10.44.48.130])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 543621956086; Mon, 19 Oct 2026 06:53:28 +0000 (UTC)
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
Subject: [PATCH iwl-net 3/3] ice: do not block on the aux device lock in
 ndo_setup_tc
Date: Mon, 19 Oct 2026 08:53:01 +0200
Message-ID: <20261019065301.3983537-4-poros@redhat.com>
In-Reply-To: <20261019065301.3983537-1-poros@redhat.com>
References: <20261019065301.3983537-1-poros@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: y_j_78wPtvKwXZLfthFhSw4t4g6EEvWLYaHTq9S2fSg_1792392815
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

The TC_SETUP_QDISC_MQPRIO path of ice_setup_tc() takes the auxiliary
device lock to test whether the RDMA driver is bound, and ndo_setup_tc()
runs with the RTNL lock held. This closes the same cycle against the
RDMA auxiliary probe as the two preceding patches.

Use device_trylock() and report the device as busy when it fails, with
a distinct message for the same reason as in the previous patch.

Fixes: 4b31fd4d77ff ("ice: Fix RDMA VSI removal during queue rebuild")
Cc: stable@vger.kernel.org
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index edb62606d2aae3..7b251136149615 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -9448,7 +9448,11 @@ ice_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 		cdev = pf->cdev_info;
 		if (cdev && cdev->adev) {
 			mutex_lock(&pf->adev_mutex);
-			device_lock(&cdev->adev->dev);
+			if (!device_trylock(&cdev->adev->dev)) {
+				mutex_unlock(&pf->adev_mutex);
+				netdev_dbg(netdev, "RDMA auxiliary device is busy, try again\n");
+				return -EBUSY;
+			}
 			locked = true;
 			if (cdev->adev->dev.driver) {
 				netdev_err(netdev, "Cannot change qdisc when RDMA is active\n");
-- 
2.56.0

