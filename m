Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6BE606A330
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Nov 2026 16:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=LslNfs4Z;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BsCUaxvw
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 04AAA60653;
	Fri, 13 Nov 2026 16:15:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t-dIPkJOqTz1; Fri, 13 Nov 2026 16:15:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 192AB6065C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794586522;
	b=Q9iJSXVmNQkNYPBIqkDiq6y6SHTBAXDWEUWyscwHMRsSAoVk55nTAsJLin5Ufpd4lxZm
	 EeFRc6LkIT+U1IvqJSQ2VYFKgSo7M4yyrG0t4iL290lE8DwD8J9AKpAPUVCDOJcCOMMpO
	 D6av+OYSsrgTZJp1b8b+SEGAVox7bhqYyXV8/Hx8ZY4Qyt6K/8HORl44WMyhRluHGB8YJ
	 xwo99N2NgM6KdKUkmtO4tLyu9EUMtsvNtLiaNgsonTKJL2g1CrfYSNPBecDlRyVfRfcrM
	 m5QEQrFDfs8Wgp1XxaCi74+R2THQnOzq1MNOZI9a5rlVdI3e1+DPztpK7De34iDl8LA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794586522;
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
	bh=B4EGN/QWS+dBKSkBnfEHH7MWFb0J/8CtMsmqNJ2RZlo=;
	b=jaIJ5WLpBNX2Lq3NMaQFzVlW3f2i0zO6rS7T9H6oVhSk48tuefem7g4vsW9kOtZGvRl5
	 mEtzsH0VpGynrSDzJawNxdo/0pP9EUO+dtm4g1tShsbW65HO9Y3mFxoWqlY4vzlXvFfCI
	 wW6Un0ETRtXXJ1Zqm8JKieEdGRFY8c00ZrGecl3hnqUzT5LFvrPPzmN67elXJ5N2/MFas
	 tccBm7mcSrTBmhP2T8gphHDykFL03X4yjDHT6sY82DiBxg/qFmZnRQGefKYyAJ7iGR2bd
	 PI+RmV+CIwwsnUnQLu9y7V8TORNX/oVrC4MVHEHIExTpemWfcrqbqOhSrG142tXmpdA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794586522;
	bh=B4EGN/QWS+dBKSkBnfEHH7MWFb0J/8CtMsmqNJ2RZlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LslNfs4ZYDAgkrkWgumrPrLwV6emPBPklepoNHIobOOMrfgp/daJTZU1xXmNvB+Vu
	 k48BEmMqSXx/cSaRwsyI26WxOJIxJg84Kv2NK9UyHoMKghUaMRPdE3JHlkCckPHMEm
	 PglaX8UAcBu40s7ATF/o0I1yWfwR11oWY7l1E5kTWVVbmsnzUosNQyg6kmf/Yvw+yL
	 Et18M801E4i4+o0aq5Wy5sgLfYlg20beSLv31NYMd92YK9U+6aWrlmBLcoXlcaHViy
	 fQ8AvE8y+KwYQ6xTWF04D6R3SRtuPV4Kg3dFt6cGfv4j1sApIk35cEUlf2GsyYdkXv
	 6cuEQ2h3G4sow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 192AB6065C;
	Fri, 13 Nov 2026 16:15:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D4E6AF8
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 16:15:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7E941401BC
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 16:15:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g1SzneaZdWPI for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Nov 2026 16:15:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2E30B40199
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BsCUaxvw
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2E30B40199
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 16:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794586515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B4EGN/QWS+dBKSkBnfEHH7MWFb0J/8CtMsmqNJ2RZlo=;
 b=BsCUaxvw+a4RtP9YQZnZErf5k6hMynDu4s21q+uBX0ub/+0noY//iGctOjXqlS2IntZ9w5
 NddyL2VcnVf299ib18pfmrMii62+fMdBt9AJNLSGRBz/sLweY97Ce+AS3D93iUFNwUwOTR
 N4XSXH4ng4wJjv9CP+p08hPkebLFw30=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-s9umwf6-MCSXn_R8MpUOHA-1; Fri,
 13 Nov 2026 11:15:13 -0500
X-MC-Unique: s9umwf6-MCSXn_R8MpUOHA-1
X-Mimecast-MFC-AGG-ID: s9umwf6-MCSXn_R8MpUOHA_1794586511
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C1316180029F; Fri, 13 Nov 2026 16:15:10 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8340018004FF; Fri, 13 Nov 2026 16:15:05 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Petr Oros <poros@redhat.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
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
 Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH iwl-net v3 1/4] ice: check the auxiliary device pointer under
 adev_mutex
Date: Fri, 13 Nov 2026 17:14:50 +0100
Message-ID: <20261113161453.1234851-2-poros@redhat.com>
In-Reply-To: <20261113161453.1234851-1-poros@redhat.com>
References: <20261113161453.1234851-1-poros@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0LLZKtN2IU7l6jhh-N9_rPdc9hcWLFbbABoug_IAEv4_1794586511
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
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Petr Oros <poros@redhat.com>
---
v3:
- rebased, Reviewed-by from Aleksandr

v2: https://lore.kernel.org/all/20261023070258.730168-2-poros@redhat.com/
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 22 +++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_main.c    | 22 +++++++++++++-------
 2 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 35dff5e937402d..910664b35b4d35 100644
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
@@ -3943,14 +3944,19 @@ static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
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
 
@@ -3966,7 +3972,7 @@ static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
 
 adev_unlock:
 	if (locked) {
-		device_unlock(&pf->cdev_info->adev->dev);
+		device_unlock(&adev->dev);
 		mutex_unlock(&pf->adev_mutex);
 	}
 	return ret;
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 1c6e85f3388668..1cc481ba4ca5f0 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -9538,6 +9538,7 @@ ice_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 	enum flow_block_binder_type binder_type;
 	struct iidc_rdma_core_dev_info *cdev;
+	struct auxiliary_device *adev = NULL;
 	struct ice_pf *pf = np->vsi->back;
 	flow_setup_cb_t *flower_handler;
 	bool locked = false;
@@ -9570,14 +9571,19 @@ ice_setup_tc(struct net_device *netdev, enum tc_setup_type type,
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
 
@@ -9586,7 +9592,7 @@ ice_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 
 adev_unlock:
 		if (locked) {
-			device_unlock(&cdev->adev->dev);
+			device_unlock(&adev->dev);
 			mutex_unlock(&pf->adev_mutex);
 		}
 		return err;
-- 
2.56.0

