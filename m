Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78313C3DA6E
	for <intel-wired-lan@archiver.kernel.org>; Wed, 20 Dec 2023 17:38:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C85F4171C;
	Wed, 20 Dec 2023 17:38:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0C85F4171C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1703093925;
	bh=rSsjWFtDlwpePP5JUdNXTPShf7rGmxGMyNyMrdcmd7I=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=jg+OFkAD9DClev8d5+XtmHloPMVi5Cn0nGcakNBAQy68EAKBJnoXr9AK3Aa9zekqV
	 0gK4elwJ4djnJGsjoi1stPDbdHf7P5u2kgZtT5UWxkUfwCiUpOT7ugPoQkdYnypdMu
	 27/22k8GSd3lQUZwWcSImXQCtWy4xF7J0M7ubNoptrBuIbE4RfgwElURoBDsU+TzTm
	 rWi6w5As6LvrvCNXXHBa75TpRE9cnmhnWMhbp8+OORXp2OD1BW1+Z196O744GQKP6a
	 c4cx641mwF+sVfl3N3nn97Oer3SSqhmXYcdc5GNd/AYmpo3/RkVx1RRKiTmZMCEflw
	 rVsJVCG+mJbvA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OKU7S9kASa_R; Wed, 20 Dec 2023 17:38:44 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id E570641793;
	Wed, 20 Dec 2023 17:38:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E570641793
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 847A61BF36E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 20 Dec 2023 17:38:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6901441793
 for <intel-wired-lan@lists.osuosl.org>; Wed, 20 Dec 2023 17:38:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6901441793
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tmKjUFlDhc_I for <intel-wired-lan@lists.osuosl.org>;
 Wed, 20 Dec 2023 17:38:41 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 560704171C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 20 Dec 2023 17:38:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 560704171C
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="2686210"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="2686210"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Dec 2023 09:38:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="1023550721"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; d="scan'208";a="1023550721"
Received: from unknown (HELO amlin-019-225.igk.intel.com) ([10.102.19.225])
 by fmsmga006.fm.intel.com with ESMTP; 20 Dec 2023 09:38:38 -0800
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Date: Wed, 20 Dec 2023 18:38:37 +0100
Message-Id: <20231220173837.3326983-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1703093921; x=1734629921;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ohevLhZwHFFA2z/8eGI/uohrYFzoGWSxtEckjdNCjr0=;
 b=Jt3SHV9OEFy5xFYrQH26u5FP5Ma64+GfsUBKI+NJxTdlCjTl3tyWo2NZ
 dAOWIuvg0HIcSPRTAs/s/f4qn0kBjt1MsgvNv6CGL5OQbYlilIxHZXofO
 CGJ/ckRJz3wrHisBXMwqjsch/2x8MJCwUnBxSzeuMXv3PA8McSDDdP82B
 pTlkvE8U5x/skCMNFVsQeir3GOzPxFsr+WfugUEe17h6VEKHStemEOBVS
 azLfMwJBAiDBcXDpCO6gHIZyo4BgbKHR23LO6argf1JwxH+siLUWNXvOx
 fD8zNLkFhkeeNaRyVO1rUfhf8Qr/PkDXT3F+t9AXWmXsGmTeNkckoKmfg
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Jt3SHV9O
Subject: [Intel-wired-lan] [PATCH iwl-next v2] i40e: add trace events
 related to SFP module IOCTLs
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
Cc: netdev@vger.kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Add trace events related to SFP module IOCTLs for troubleshooting.

Example:
        echo "i40e_*" >/sys/kernel/tracing/set_ftrace_filter
        echo "i40e_ioctl*" >/sys/kernel/tracing/events/i40e/filter
        echo 1  >/sys/kernel/tracing/tracing_on
        echo 1  >/sys/kernel/tracing/events/i40e/enable
        ...
        cat     /sys/kernel/tracing/trace

Riewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v1->v2 applied to proper git branch
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  5 +++++
 drivers/net/ethernet/intel/i40e/i40e_trace.h   | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index c841779..bdf2b6b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1074,6 +1074,7 @@ static int i40e_get_link_ksettings(struct net_device *netdev,
 	ethtool_link_ksettings_zero_link_mode(ks, supported);
 	ethtool_link_ksettings_zero_link_mode(ks, advertising);
 
+	i40e_trace(ioctl_get_link_ksettings, pf, hw_link_info->link_info);
 	if (link_up)
 		i40e_get_settings_link_up(hw, ks, netdev, pf);
 	else
@@ -5585,9 +5586,12 @@ static int i40e_get_module_info(struct net_device *netdev,
 		modinfo->eeprom_len = I40E_MODULE_QSFP_MAX_LEN;
 		break;
 	default:
+		i40e_trace(ioctl_get_module_info, pf, ~0UL);
 		netdev_dbg(vsi->netdev, "SFP module type unrecognized or no SFP connector used.\n");
 		return -EOPNOTSUPP;
 	}
+	i40e_trace(ioctl_get_module_info, pf, (((u64)modinfo->type) << 32) |
+		   modinfo->eeprom_len);
 	return 0;
 }
 
@@ -5610,6 +5614,7 @@ static int i40e_get_module_eeprom(struct net_device *netdev,
 	int status;
 	int i;
 
+	i40e_trace(ioctl_get_module_eeprom, pf, ee ? ee->len : 0U);
 	if (!ee || !ee->len || !data)
 		return -EINVAL;
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_trace.h b/drivers/net/ethernet/intel/i40e/i40e_trace.h
index 33b4e30..b9be2f4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_trace.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_trace.h
@@ -202,6 +202,24 @@ DEFINE_EVENT(
 
 	TP_ARGS(ring, desc, xdp));
 
+DEFINE_EVENT(
+	i40e_ioctl_template, i40e_ioctl_get_module_info,
+	TP_PROTO(struct i40e_pf *pf, u64 val),
+
+	TP_ARGS(pf, val));
+
+DEFINE_EVENT(
+	i40e_ioctl_template, i40e_ioctl_get_module_eeprom,
+	TP_PROTO(struct i40e_pf *pf, u64 val),
+
+	TP_ARGS(pf, val));
+
+DEFINE_EVENT(
+	i40e_ioctl_template, i40e_ioctl_get_link_ksettings,
+	TP_PROTO(struct i40e_pf *pf, u64 val),
+
+	TP_ARGS(pf, val));
+
 DECLARE_EVENT_CLASS(
 	i40e_xmit_template,
 
-- 
2.25.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
