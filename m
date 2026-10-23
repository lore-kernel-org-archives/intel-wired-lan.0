Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BE3606A31D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 23 Oct 2026 07:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=z3lppMxt;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T6lZceyc
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 01D8C81164;
	Fri, 23 Oct 2026 07:03:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4S6HcOxmk7lv; Fri, 23 Oct 2026 07:03:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 77DA6811A8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792739008;
	b=E8llJmIbpWdhJZgYoaMFHts7BR73r3I47YWyyGzIMBGqeCFrP5i5stS8C6sk9ja8tXM3
	 s0J215HHlVCRQIrsgksVJl+0dQxv+J68SdSzNC5eIytXawk143qNVl4v0tajJU1IsWlW4
	 IcX45cq6/uhel/5bMYzPl1IIYTrKBmn81/70D7DioK+9KauLPpmlkyC4Dk8LPEJ/I8N7g
	 WSGOgtD9oK1X/C0REgJ7hYqSCdL1qt68cPTbmpXG3er8MuMOtvoPOdsB7GM6fMcUkUZJ/
	 xEVxUo4viLzbLx3mHh9cXu3mxfJYm0kytGboSydKk6uWVh17ffVdGOklIdFkPbPXkhg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792739008;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fjvVqcSfa+2zBtBR5VJVLHJipBPKH87jRFs97wxFpX8=;
	b=LrVLgZjeazvv+xD/qFHCzhL+mZ9A+8p0ei6nDXzhB8igP/UefmrZms+5jy1nyrfEWcYT
	 /N8A9dcj8oMk8dHsttvhyPwwfNSSTHWNd2eTnUD1U0PiKosFveJhIu6gf/rmlyr7d5U5H
	 iqbq92uOBMHrokATTsJfhpsoB9x5fKvBYD5pbMkU6rMIkbjDb61BjUP7UVP6Uwnnk0k+Q
	 njN0qrCCg3gotpZzOaFgxdozJMY6GKWsMYP6q4CxT52U/6cxtuoz9YhX4UIWG1n5zgC5D
	 QMAoTDZ1qt8TPtiqRgy4Sl4QzQeoB46tK35wf+RRnq69mkw4TJjzkuWe63q5Z18eA2A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T6lZceyc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792739008;
	bh=fjvVqcSfa+2zBtBR5VJVLHJipBPKH87jRFs97wxFpX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z3lppMxt16aUGCZc/FZ7CeVebai7Ul7TKJus+fW/yItLWkCoa9O0bQw/aYQLyaK36
	 b3TUpD9lgIqoBzZ8LxrgakkNlvpqsNhL9mRWOna8iTfbFx8UaueTncxDWos+OMtap5
	 k9HVEG5u0p746J1iiHEngKyIHVlQVLQoK0/ZwSpWqxUUAdDA2TQ5O5DRUI2JE3GU0v
	 OYQXTGdOmGOr6iIU3ATwb6QsZJiXOL0MruP4xCcNY0SbnfEhxBRhtEXa8G4Z9wHaiw
	 egyKu2+LHabBpu+spMQVhfp+T+fo2Tnztl0toFVEhuNdJT3g6bpUmT1/HGKF3LUZLI
	 A+s7CUp5RQzzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 77DA6811A8;
	Fri, 23 Oct 2026 07:03:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A1A649D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Oct 2026 07:03:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7BB78811A8
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Oct 2026 07:03:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lRgmXYafDBPk for <intel-wired-lan@lists.osuosl.org>;
 Fri, 23 Oct 2026 07:03:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E9B0B809CE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792739006;
 b=OXUepWecTt+7CrBhnrctkC2/QX1ZUQM0JsA5zcTx95ezGn9XoaQtGB4x2dWKcldrAjmK
 95qrR0/Zn0O+5Yvvy+lJINBCKVwzAIvlc3d4kkTvWSBJ2p6dTeEzvIbiT91ps4iwxGRQ6
 8jUGSZk/nMObP0pGBVHn1CA8y/Pd7J+n+0nb1Hdo5E0HlAiaT68tY9g09J0ypV7oBn3bL
 ZJtSjlF1L/otK7brImOP/H10avtJvIU1PbN+w6vfyvhZb/sXeaz05fl0w0VzCQcYK4cYW
 nwM+xN/J6fxm4ej7MU73sQr6SVG5i+FktzZbNvzSRFNq7zf87lSZxdJ+/Bu5iqsf7Dw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792739006;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Transfer-Encoding:content-type;
 bh=fjvVqcSfa+2zBtBR5VJVLHJipBPKH87jRFs97wxFpX8=;
 b=NasaOT9sDkAeyO49XpwoxPjJEuNrql+DnAEZ+SEJSuoXjlnxkWGpugRGA/SR2+/cVZPo
 4FseNrXPy4u2lqDsnfgEAVCNoYwvBnl871GfbSUKrh7Sk9Od5i/PeuxoYaGEjUxN/3B7p
 X0qYX94C+8Gqf+LkKdIlkErY9HkT0V7PS80yQU4QeQUKVsENFvwnhcQgYscrfLwFv903z
 qI9eNXk495UjdFc4ijaQxU7JeOxsjuWzRY/IqazPlknrOIscG8wmaMGIFhbd1/cM+Ggvw
 yW6VStMQ+lIGoJehtHZdXBZnQoF1mzH3CShI0ygXDASXdZMf2zyCyCWC49UAbyDyI/w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=redhat.com;
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=T6lZceyc; 
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=T6lZceyc
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTP id E9B0B809CE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Oct 2026 07:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792739003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fjvVqcSfa+2zBtBR5VJVLHJipBPKH87jRFs97wxFpX8=;
 b=T6lZceyc96vW7PzSFuuhbXhpeRDjCV8xLnXsw94CBjzBB1kJRj8redEIIAkF0kXfXjn1hX
 Nl2JqKF2P7a2PwYCArazXI12c/wI2qwZsJ+fB6vhBTSGnsByaQOXUQ/Z5OBb+IePK5wNTL
 jaJ99mmWlPvvSdEQz8peYp/B6vxiZUc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-mX9E7ey5N4iP5lpaaMmYTQ-1; Fri,
 23 Oct 2026 03:03:17 -0400
X-MC-Unique: mX9E7ey5N4iP5lpaaMmYTQ-1
X-Mimecast-MFC-AGG-ID: mX9E7ey5N4iP5lpaaMmYTQ_1792738994
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B731E1800149; Fri, 23 Oct 2026 07:03:14 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com (unknown [10.44.32.22])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BED8E180029C; Fri, 23 Oct 2026 07:03:09 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
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
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: [PATCH iwl-net v2 1/5] ice: check the auxiliary device pointer under
 adev_mutex
Date: Fri, 23 Oct 2026 09:02:53 +0200
Message-ID: <20261023070258.730168-2-poros@redhat.com>
In-Reply-To: <20261023070258.730168-1-poros@redhat.com>
References: <20261023070258.730168-1-poros@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: fqL82FY8lONDprccliUbe4HIqEy1uhciLf40Sgq4GKg_1792738994
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ice_set_channels() and the mqprio path of ice_setup_tc() test
cdev->adev before taking pf->adev_mutex and dereference it afterwards.
ice_unplug_aux_dev() clears the pointer under the mutex from the
service task, from ice_prepare_for_reset() and from the devlink RoCE
and iWARP parameter handlers, none of which hold the RTNL lock, so the
pointer can go away between the test and the device_lock() call.

Take pf->adev_mutex first and test the pointer under it. Without a
device the mutex is released again and the rebuild runs unlocked as
before.

Fixes: a6a0974aae42 ("ice: Prevent set_channel from changing queues while RDMA active")
Fixes: 4b31fd4d77ff ("ice: Fix RDMA VSI removal during queue rebuild")
Signed-off-by: Petr Oros <poros@redhat.com>
---
v2:
- new patch, the pointer test raced with ice_unplug_aux_dev()
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 22 +++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_main.c    | 22 +++++++++++++-------
 2 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index bf9a821c543b7f..5482a64c81c95a 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3888,6 +3888,7 @@ static int ice_vsi_set_dflt_rss_lut(struct ice_vsi *vsi, int req_rss_size)
 static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
 {
 	struct ice_netdev_priv *np = netdev_priv(dev);
+	struct auxiliary_device *adev = NULL;
 	struct ice_vsi *vsi = np->vsi;
 	struct ice_pf *pf = vsi->back;
 	int new_rx = 0, new_tx = 0;
@@ -3942,14 +3943,19 @@ static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
 		return -EINVAL;
 	}
 
-	if (pf->cdev_info && pf->cdev_info->adev) {
+	if (pf->cdev_info) {
 		mutex_lock(&pf->adev_mutex);
-		device_lock(&pf->cdev_info->adev->dev);
-		locked = true;
-		if (pf->cdev_info->adev->dev.driver) {
-			netdev_err(dev, "Cannot change channels when RDMA is active\n");
-			ret = -EBUSY;
-			goto adev_unlock;
+		adev = pf->cdev_info->adev;
+		if (adev) {
+			device_lock(&adev->dev);
+			locked = true;
+			if (adev->dev.driver) {
+				netdev_err(dev, "Cannot change channels when RDMA is active\n");
+				ret = -EBUSY;
+				goto adev_unlock;
+			}
+		} else {
+			mutex_unlock(&pf->adev_mutex);
 		}
 	}
 
@@ -3965,7 +3971,7 @@ static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
 
 adev_unlock:
 	if (locked) {
-		device_unlock(&pf->cdev_info->adev->dev);
+		device_unlock(&adev->dev);
 		mutex_unlock(&pf->adev_mutex);
 	}
 	return ret;
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d88835482d3aac..984479f1e1f6d9 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -9406,6 +9406,7 @@ ice_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 	enum flow_block_binder_type binder_type;
 	struct iidc_rdma_core_dev_info *cdev;
+	struct auxiliary_device *adev = NULL;
 	struct ice_pf *pf = np->vsi->back;
 	flow_setup_cb_t *flower_handler;
 	bool locked = false;
@@ -9438,14 +9439,19 @@ ice_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 		}
 
 		cdev = pf->cdev_info;
-		if (cdev && cdev->adev) {
+		if (cdev) {
 			mutex_lock(&pf->adev_mutex);
-			device_lock(&cdev->adev->dev);
-			locked = true;
-			if (cdev->adev->dev.driver) {
-				netdev_err(netdev, "Cannot change qdisc when RDMA is active\n");
-				err = -EBUSY;
-				goto adev_unlock;
+			adev = cdev->adev;
+			if (adev) {
+				device_lock(&adev->dev);
+				locked = true;
+				if (adev->dev.driver) {
+					netdev_err(netdev, "Cannot change qdisc when RDMA is active\n");
+					err = -EBUSY;
+					goto adev_unlock;
+				}
+			} else {
+				mutex_unlock(&pf->adev_mutex);
 			}
 		}
 
@@ -9456,7 +9462,7 @@ ice_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 
 adev_unlock:
 		if (locked) {
-			device_unlock(&cdev->adev->dev);
+			device_unlock(&adev->dev);
 			mutex_unlock(&pf->adev_mutex);
 		}
 		return err;
-- 
2.56.0

