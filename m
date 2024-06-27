Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E54C2BD09
	for <intel-wired-lan@archiver.kernel.org>; Thu, 27 Jun 2024 08:10:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9253140114;
	Thu, 27 Jun 2024 08:10:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5kbppuDAV8lH; Thu, 27 Jun 2024 08:10:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B2620401C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1719475850;
	bh=3rjHvN75SU41xo72HtyttqbgOwKamJ18ERgXafuwxDU=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=rXgN5Er5OqlRNwobA2sKXiEDi/GslOR5E4RGVPMTPfyF47iS7ZbpY5m7vuCagFMkN
	 z33dEQiMqKH79MzocWhAnFTq19Di1iZwoy4jDSjzSHNvAJyNCudS6YvVc6xDTGaE0i
	 DJOceXQUvnsxOeRkbZ8u5oS4a+kW4Np0rzmMB2rZDRIsW7iVbso6sLIz3nBJsO8sRw
	 tEFiQZF2JO7M7lJ66z6Jua+jm+Tf02WkKgYS8c0NWhLriG2sGV8ypAois1wM/aeqsF
	 arEWfeF7MvatTgMoean0aC2HGmvll9+18TxwkaGcxxP9TyO4r+ozixjx3PvHnzsZcE
	 G28l+21IJA+og==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id B2620401C2;
	Thu, 27 Jun 2024 08:10:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 7690D1BF3D5
 for <intel-wired-lan@lists.osuosl.org>; Thu, 27 Jun 2024 08:10:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6E28D83FFB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 27 Jun 2024 08:10:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wVdjde45cuGS for <intel-wired-lan@lists.osuosl.org>;
 Thu, 27 Jun 2024 08:10:47 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=michal.swiatkowski@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 986AC83FFA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 986AC83FFA
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 986AC83FFA
 for <intel-wired-lan@lists.osuosl.org>; Thu, 27 Jun 2024 08:10:47 +0000 (UTC)
X-CSE-ConnectionGUID: NUnYsuHWQsGLsPHhKwD8HQ==
X-CSE-MsgGUID: vcYNENGTS7OL9NUNuPoE+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="12275393"
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; d="scan'208";a="12275393"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2024 01:10:46 -0700
X-CSE-ConnectionGUID: lizahZMRRPquri1pruom5w==
X-CSE-MsgGUID: JHND//+cSqOpvHuJJ+EZEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; d="scan'208";a="44205524"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
 by orviesa010.jf.intel.com with ESMTP; 27 Jun 2024 01:10:46 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Thu, 27 Jun 2024 10:10:43 +0200
Message-ID: <20240627081043.46211-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719475847; x=1751011847;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=zhGHhB7Hpqx6jgn4cBj1RmJNXvPv59skzHuArxqvFdE=;
 b=cCLOJm/WUGoq+yR+NR2jo6+9l22OPiPy586AbxS/CUjlXjnVfgb8dlqB
 Tnko37srDvG/B3/wPE0JVKmsnIynu0qWgdAikqWkX/wvI+IaQy2yNg0de
 wOdVp5szONHIzG9yjuuwCTtGnv035MZN5GJoGmp3/wl2glnTAIeczgrZp
 pSkPOxLeGaXI3O3bOYMyXcamwQvC0USn/VROCA/HRG/xF6NuIGmCBhi+f
 JfnP9OLVlpvLXx5z4/zh3bDbkG3WjXwcqPu+xqxgu6oY+uzYFrWmOogN9
 aDSjyvSvoMc62/oYeuoO4q+vd06Ogs4jc65hu13FEX4SlJ8kN5Ls1AR15
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=cCLOJm/W
Subject: [Intel-wired-lan] [iwl-next v1] ice: update representor after SF
 VSI config
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
Cc: anthony.l.nguyen@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

VSI for subfunction is only allocated when port representor is created.
The VSI id isn't correct at this state. Update the representor with
correct VSI id after the VSI is configured.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
It should be squashed with:
8a469e1a1cf9 ("ice: create port representor for SF")
---
 drivers/net/ethernet/intel/ice/ice_sf_eth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
index 73bb9c5d273d..abd74f30dabc 100644
--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
@@ -125,6 +125,8 @@ static int ice_sf_dev_probe(struct auxiliary_device *adev,
 	}
 	vsi->sf = dyn_port;
 
+	ice_eswitch_update_repr(&dyn_port->repr_id, vsi);
+
 	err = ice_devlink_create_sf_dev_port(sf_dev);
 	if (err) {
 		dev_err(dev, "Cannot add ice virtual devlink port for subfunction");
-- 
2.42.0

