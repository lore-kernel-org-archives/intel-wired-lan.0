Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 632B7CC6B38
	for <intel-wired-lan@archiver.kernel.org>; Fri, 16 Oct 2026 11:17:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C2DE409CE;
	Fri, 16 Oct 2026 11:17:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XwdJyfOUPH6Q; Fri, 16 Oct 2026 11:17:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D6883409F6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792149430;
	b=csA+69iJGt9OqiZILVYfzED9Ed7Kmq+0HhDj7SD8mjtwjz9IIR2k8LvuNW7bV4RfULrf
	 CN6aEPf8rsOQYQoJRI7aiecrU2Sa4nDbvkT5ePw1WGGw5l8Kt1XuLPZ+aSNnlavEXRT2L
	 g7nORExPiehx27WEPhITLyWKVkaNWOGWpMJjIXnmeI87Dhi5gzLIMYDaP648KzfF98UW1
	 t8KVL1VAo8bxVXGdy7vOhpCGw2y3ylefZBr/wtI+eHiU5ieGyOAcahrOciY7q/SrdLspF
	 9pMVTDW8484ygGqvQ61XlXhMMU8FT0LtBw1ZwX/DVL7PjjYFed1EXvnpYCvj3eT/UEg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792149430;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uIUTbv3E4qlewC+NDzKpLf+zWX7jadFKGEi7VZMZ+fM=;
	b=Cv3py9TJEj9JhydfZuD5Ra6Wh2YovkKq5fykLlEmwKwVmr7nijz4OPA11h4M4YBb6BMT
	 OJstCbNdEaDK+5E3jdEJjzRlXJuEqYAgQMZXo3bsHTbnJy5kYx4/y9iFq+NtTz+I16ZRW
	 MnrD8YE3mFrjVIGQjv3JmAXKwzAcby7DoGgcrrOTJTZBNnjo1amaU6fNB2dXVFrTzNho+
	 f7HgNW1gmRF+A8uvXwLP3q1CcYfwK4A1GGVkTWcNk0E74DtLs4Wb0sWlmyrGxHzSoxpVl
	 klfcCcHjFs7cZyIs31FkmKiesEJWsvbXVbWVUcqgwpIwAm+PUNblATuuwigZFBgOrLQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792149430;
	bh=uIUTbv3E4qlewC+NDzKpLf+zWX7jadFKGEi7VZMZ+fM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=W+05V2teIZAmaYtiddXtRT1x4HEJ/91lfAH2OnR7Eh728zwUX4nyRUwDuZ1RYlRQE
	 hMjdvyv1kalgWE2DIHzqKX/b8VcCV9RH97sze3ZXtVzdEhmjcE5fDS/0kY6QbkZVoh
	 zlr0rMuczAwHBmXOQkYExagvehlqDBrqw3gbtRfUe3ErVWOicC1klVj5MNeo1XGm+Z
	 5B8jYwxN7f+F0mharOO6KM/51YDlsOpwF+AqX1rfOz9n7ItSuT1wijFLMcWQz/c789
	 Mru5kecPyd5LtZ9NB6lK1rLNhCUAiRcekQNpMxLpJU1UiV9pvvkFxEauAO/WxNomND
	 vosNiv6w+aKFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D6883409F6;
	Fri, 16 Oct 2026 11:17:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C2642A8
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Oct 2026 11:17:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5DD9360A4D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Oct 2026 11:17:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JpraDqzqfsVb for <intel-wired-lan@lists.osuosl.org>;
 Fri, 16 Oct 2026 11:17:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D1A9D608C4
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792149428;
 b=W5K1RBKwK7URiOq9jTZaYCzaFmFbaJlc+E6VLGrSzE/iGU4seaUgrIP4dg95wbhbw0jJ
 E6b6LbP99y6AVbb9eDFm7Q/3nwu8ZIFYEjRQDbCagVLdH4kwkKL0v0LVed/xxxJ+FjNLI
 Ca0BzmgJheLmqAQGra6+8CQ2A6mzOBeX52MKGQWKVrPlF7Sz25a0jR+dVBCKJleK0Fh6y
 GdnpoJQpmaxKSA8O1RKvX+LLNHQUDlQkFfwjhLry2QqW7jjEjw3YIuafRiTgPY3mSbdar
 1MraYoVhRaHB4SX99Hq6bQjcwUbWPkl4amxXcMWr/T1pR1qCZLJmHUS0sfI/lzds7vw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792149428;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=uIUTbv3E4qlewC+NDzKpLf+zWX7jadFKGEi7VZMZ+fM=;
 b=lcOAm/+XtOCLfpy57agRa5mKhpwSncjqywGxR8fqhN86Kj4pFx+2MuIJ09nqquGDnFco
 Qcm9xoTnia5gUaOC5dTNJD7p+b/3Lkk33b9DlyOUkW/I+nkmM3z1e7h4xnFrWn8poo6o8
 16gqiquAOkgizN31WyoVetL23yl07geQrTgiP5OKLB+zIKx6J6B04NPdHeX1frWC+nu7X
 2MmeSZiPg3yRFCrAUlZKS2vh13spUxG3Ypi+P2MVDY+JnCI1XWiu4rhzsAmzVGJ6teImY
 eCaYDFL/i2UDu+2QToGm2v1rxI3i34utIYbWqgFpQ4wGNVc5CVPFcfuyynJ9TmQAQTQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=lhGvZK1F; 
 arc=none smtp.remote-ip=198.175.65.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.10;
 helo=mgamail.intel.com; envelope-from=lukasz.czapnik@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=lhGvZK1F
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D1A9D608C4
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Oct 2026 11:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792149428; x=1823685428;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=zOm+7wjCUpX0sW2JmO2I97+hMW/Wa4Kx3vhTZ4QLVh4=;
 b=lhGvZK1FAvUdYSxsWLvTGQpJNEUYUxNc5fCrBZkhUa6algTASTpuZ0a6
 Sver0TdAXbNI1vHeYT3BPuctZ8vQhTk/3y6G49M13DveXcgAEfC9Pr9qT
 B6DkjP/3aT/Pr+SBTX8XWGnv+ld64ULpy+sIyJPHpfQMp1MKCftRgtBnI
 3LGRdl0OL8RQZciShfDzXAsbSZegM8V7t9lPL1HFLYZN4WMMDnga7JAWZ
 VJSjPnk5nbaATXry/wLQ5ki23irFPl7+UOWzMKbz6S6ycEj5iiBBbhy0V
 wm36d52qhbEZ4eCZp5E7ui+6m5IMXhC01m1MBe9n8z1wjgy30Fqtv7YSJ w==;
X-CSE-ConnectionGUID: 4m2wzfOhRwGETQnLV+k42w==
X-CSE-MsgGUID: o0wxi378QpK347PlJ9NHEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="821881"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="821881"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 04:17:07 -0700
X-CSE-ConnectionGUID: X+wwU7ifQXeK3uFqPj+LTQ==
X-CSE-MsgGUID: 8wSwv+UxQ+O20d2c5ifnMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="2019606"
Received: from os-delivery.igk.intel.com ([10.123.220.24])
 by fmviesa002.fm.intel.com with ESMTP; 16 Oct 2026 04:17:04 -0700
From: Lukasz Czapnik <lukasz.czapnik@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Jakub Kaminski <jakub.kaminski@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Tomasz Lichwala <tomasz.lichwala@linux.intel.com>,
 Simon Horman <horms@kernel.org>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Lukasz Czapnik <lukasz.czapnik@intel.com>
Subject: [PATCH iwl-net v3] ice: Fix "Unknown bps" during link events
Date: Fri, 16 Oct 2026 13:16:53 +0200
Message-ID: <20261016111653.1196653-1-lukasz.czapnik@intel.com>
X-Mailer: git-send-email 2.50.1
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

From: Jakub Kaminski <jakub.kaminski@intel.com>

The driver may print "NIC Link is up Unknown bps" during link state
changes, and ethtool may report an unknown speed while the carrier is
on.

ice_link_event() receives link_up and link_speed from the ARQ link
status event, then refreshes phy.link_info with a synchronous AQ query.
link_up was forced to true if the refreshed info reported the link up
and otherwise kept the event value, link_speed always kept the event
value, and ice_print_link_msg() read the speed from the refreshed info.
Link state and speed could come from different reads, and the carrier
could stay on while the refreshed info reported the link down.

Take link_up and link_speed from the refreshed phy.link_info when the
link status read succeeds. Check the result of the link status read
itself, as ice_update_link_info() can also fail in the following PHY
caps query; split that query out into ice_update_media_caps(). If the
read fails, keep the event values and store them in phy.link_info, so
carrier, VF link state and the baseline for the next event agree. FEC,
autoneg and flow control in the link message then still come from the
last successful read.

Do not drop an event that differs from the cached state even if the
refreshed info does not, e.g. a down event handled after the link came
back at the same speed.

Add a link_speed parameter to ice_print_link_msg() so the printed speed
is the one read together with the link state the caller acted on,
instead of being re-read from phy.link_info later. Updates of
phy.link_info from other contexts are not serialized against the
service task, which also applies to the event state stored on a failed
read. The missing serialization predates this change and is not
addressed here.

Fixes: c2a23e00613b ("ice: Refactor link event flow")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jakub Kaminski <jakub.kaminski@intel.com>
Co-developed-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
---
v3:
- Use the refreshed link state only when the link status read itself
  succeeds; split the PHY caps query out into ice_update_media_caps().
- Store the event state in phy.link_info when the read fails.
- Don't drop events that differ from the cached state.
- Rename status to err in ice_link_event().

v2: https://lore.kernel.org/netdev/20260806162458.2384818-1-lukasz.czapnik@intel.com/
- Take link_up and link_speed from the refreshed cache for every event,
  not only for up events.
---
 drivers/net/ethernet/intel/ice/ice.h         |  2 +-
 drivers/net/ethernet/intel/ice/ice_common.c  | 37 +++++++++-------
 drivers/net/ethernet/intel/ice/ice_common.h  |  1 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c |  2 +-
 drivers/net/ethernet/intel/ice/ice_main.c    | 45 +++++++++++++-------
 5 files changed, 54 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 009765074a01..4afd9d166d08 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -1012,7 +1012,7 @@ int ice_get_rss_key(struct ice_vsi *vsi, u8 *seed);
 int ice_set_rss_hfunc(struct ice_vsi *vsi, u8 hfunc);
 void ice_fill_rss_lut(u8 *lut, u16 rss_table_size, u16 rss_size);
 int ice_schedule_reset(struct ice_pf *pf, enum ice_reset_req reset);
-void ice_print_link_msg(struct ice_vsi *vsi, bool isup);
+void ice_print_link_msg(struct ice_vsi *vsi, bool isup, u16 link_speed);
 int ice_plug_aux_dev(struct ice_pf *pf);
 void ice_unplug_aux_dev(struct ice_pf *pf);
 void ice_rdma_finalize_setup(struct ice_pf *pf);
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 81187214a630..e60ce0ed2693 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -3639,36 +3639,43 @@ ice_aq_set_phy_cfg(struct ice_hw *hw, struct ice_port_info *pi,
 	return status;
 }
 
+/**
+ * ice_update_media_caps - refresh the PHY capabilities of the present media
+ * @pi: port info structure of the interested logical port
+ *
+ * Return: 0 on success or if no media is available, negative on failure.
+ */
+int ice_update_media_caps(struct ice_port_info *pi)
+{
+	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree) = NULL;
+
+	if (!(pi->phy.link_info.link_info & ICE_AQ_MEDIA_AVAILABLE))
+		return 0;
+
+	pcaps = kzalloc_obj(*pcaps);
+	if (!pcaps)
+		return -ENOMEM;
+
+	return ice_aq_get_phy_caps(pi, false, ICE_AQC_REPORT_TOPO_CAP_MEDIA,
+				   pcaps, NULL);
+}
+
 /**
  * ice_update_link_info - update status of the HW network link
  * @pi: port info structure of the interested logical port
  */
 int ice_update_link_info(struct ice_port_info *pi)
 {
-	struct ice_link_status *li;
 	int status;
 
 	if (!pi)
 		return -EINVAL;
 
-	li = &pi->phy.link_info;
-
 	status = ice_aq_get_link_info(pi, true, NULL, NULL);
 	if (status)
 		return status;
 
-	if (li->link_info & ICE_AQ_MEDIA_AVAILABLE) {
-		struct ice_aqc_get_phy_caps_data *pcaps __free(kfree) = NULL;
-
-		pcaps = kzalloc_obj(*pcaps);
-		if (!pcaps)
-			return -ENOMEM;
-
-		status = ice_aq_get_phy_caps(pi, false, ICE_AQC_REPORT_TOPO_CAP_MEDIA,
-					     pcaps, NULL);
-	}
-
-	return status;
+	return ice_update_media_caps(pi);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index 4ca3f5edcb92..bb36bdd34270 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -93,6 +93,7 @@ ice_clean_rq_elem(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 		  struct ice_rq_event_info *e, u16 *pending);
 int
 ice_get_link_status(struct ice_port_info *pi, bool *link_up);
+int ice_update_media_caps(struct ice_port_info *pi);
 int ice_update_link_info(struct ice_port_info *pi);
 int
 ice_acquire_res(struct ice_hw *hw, enum ice_aq_res_ids res,
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 90fa11b22820..abc835613a31 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -2775,7 +2775,7 @@ ice_set_link_ksettings(struct net_device *netdev,
 		/* Tell the OS link is going down, the link will go
 		 * back up when fw says it is ready asynchronously
 		 */
-		ice_print_link_msg(np->vsi, false);
+		ice_print_link_msg(np->vsi, false, 0);
 		netif_carrier_off(netdev);
 		netif_tx_stop_all_queues(netdev);
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 730d48adbaaf..f9f12916d03b 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -845,8 +845,9 @@ static void ice_print_topo_conflict(struct ice_vsi *vsi)
  * ice_print_link_msg - print link up or down message
  * @vsi: the VSI whose link status is being queried
  * @isup: boolean for if the link is now up or down
+ * @link_speed: current link speed value to display
  */
-void ice_print_link_msg(struct ice_vsi *vsi, bool isup)
+void ice_print_link_msg(struct ice_vsi *vsi, bool isup, u16 link_speed)
 {
 	struct ice_aqc_get_phy_caps_data *caps;
 	const char *an_advertised;
@@ -870,7 +871,7 @@ void ice_print_link_msg(struct ice_vsi *vsi, bool isup)
 		return;
 	}
 
-	switch (vsi->port_info->phy.link_info.link_speed) {
+	switch (link_speed) {
 	case ICE_AQ_LINK_SPEED_200GB:
 		speed = "200 G";
 		break;
@@ -1181,7 +1182,8 @@ ice_link_event(struct ice_pf *pf, struct ice_port_info *pi, bool link_up,
 	struct ice_vsi *vsi;
 	u16 old_link_speed;
 	bool old_link;
-	int status;
+	bool changed;
+	int err;
 
 	phy_info = &pi->phy;
 	phy_info->link_info_old = phy_info->link_info;
@@ -1189,23 +1191,32 @@ ice_link_event(struct ice_pf *pf, struct ice_port_info *pi, bool link_up,
 	old_link = !!(phy_info->link_info_old.link_info & ICE_AQ_LINK_UP);
 	old_link_speed = phy_info->link_info_old.link_speed;
 
+	/* don't drop an event that the refreshed link info no longer shows */
+	changed = link_up != old_link || link_speed != old_link_speed;
+
 	/* update the link info structures and re-enable link events,
 	 * don't bail on failure due to other book keeping needed
 	 */
-	status = ice_update_link_info(pi);
-	if (status)
+	err = ice_aq_get_link_info(pi, true, NULL, NULL);
+	if (!err) {
+		link_up = phy_info->link_info.link_info & ICE_AQ_LINK_UP;
+		link_speed = phy_info->link_info.link_speed;
+		err = ice_update_media_caps(pi);
+	} else {
+		/* read failed, keep the cache in sync with the applied state */
+		if (link_up)
+			phy_info->link_info.link_info |= ICE_AQ_LINK_UP;
+		else
+			phy_info->link_info.link_info &= ~ICE_AQ_LINK_UP;
+		phy_info->link_info.link_speed = link_speed;
+	}
+	if (err)
 		dev_dbg(dev, "Failed to update link status on port %d, err %d aq_err %s\n",
-			pi->lport, status,
+			pi->lport, err,
 			libie_aq_str(pi->hw->adminq.sq_last_status));
 
 	ice_check_link_cfg_err(pf, pi->phy.link_info.link_cfg_err);
 
-	/* Check if the link state is up after updating link info, and treat
-	 * this event as an UP event since the link is actually UP now.
-	 */
-	if (phy_info->link_info.link_info & ICE_AQ_LINK_UP)
-		link_up = true;
-
 	vsi = ice_get_main_vsi(pf);
 	if (!vsi || !vsi->port_info)
 		return -EINVAL;
@@ -1217,8 +1228,9 @@ ice_link_event(struct ice_pf *pf, struct ice_port_info *pi, bool link_up,
 		ice_set_link(vsi, false);
 	}
 
-	/* if the old link up/down and speed is the same as the new */
-	if (link_up == old_link && link_speed == old_link_speed)
+	/* nothing to do if neither the event nor the refreshed state changed */
+	changed |= link_up != old_link || link_speed != old_link_speed;
+	if (!changed)
 		return 0;
 
 	if (!link_up && old_link)
@@ -1234,7 +1246,7 @@ ice_link_event(struct ice_pf *pf, struct ice_port_info *pi, bool link_up,
 			ice_set_dflt_mib(pf);
 	}
 	ice_vsi_link_event(vsi, link_up);
-	ice_print_link_msg(vsi, link_up);
+	ice_print_link_msg(vsi, link_up, link_speed);
 
 	ice_vc_notify_link_state(pf);
 
@@ -6831,7 +6843,8 @@ static int ice_up_complete(struct ice_vsi *vsi)
 	    (vsi->port_info->phy.link_info.link_info & ICE_AQ_LINK_UP) &&
 	    ((vsi->netdev && (vsi->type == ICE_VSI_PF ||
 			      vsi->type == ICE_VSI_SF)))) {
-		ice_print_link_msg(vsi, true);
+		ice_print_link_msg(vsi, true,
+				   vsi->port_info->phy.link_info.link_speed);
 		netif_tx_start_all_queues(vsi->netdev);
 		netif_carrier_on(vsi->netdev);
 	}
-- 
2.50.1

