Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A92C98328
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 13:27:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BFF5860D7A;
	Fri, 25 Sep 2026 13:27:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cxlSWm-YMchY; Fri, 25 Sep 2026 13:27:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 25DBD60D6D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790342823;
	b=ZJeUIaT1+05rIvdpaSqk70Ic/QqpfCQXpJYY8HxcRmWmyLjo3jmzKYGFt09fYS75CrFh
	 VcpjwY00rq49tELF8AN5G35a6sKHpTTZVsoS5kPRrqOiRDNnd26dSs8qUa/hnDMiCr4Vd
	 TRsWWDruLSqEIdsnT0tcgv60dAhhx7czwrC5cg9V7XwBMkpl2jcacgQ094VCydwlzTohV
	 Bjd8CDQmZwE4Bcxr+SdgelKnM3YPh4LV2D4emvYna+oGd4MrVugkusdS2jVWGi2szTQdK
	 VxDKfE9uH0U8Ksds4Z1ioDG6inGyfkMj32AOwWYTcSZu2P7N7PjoXK/dOcSMAB6n4Hw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790342823;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=4x0/WJkyO3IbDTXlHHMTggHj3/u/Oxh5WOU4HWQXCgI=;
	b=WlTHIGTCRKqlQT7Du8SDpuQonLgJ86r2HzJeIn6lGCrjDxF99M0G/jbdjITayifZJSR+
	 tzoRCabfT36LFS8KMwqqETAvdcJoCKTAUV9tuByCN3NZQBPbP9xvomYOHS6MH52a1ztSV
	 0KOlyGesm17my5zh5scn3MSzgvH+fwupwWXT9iSh4MV73Tfaa9NSB31lAq+E7qp6m696k
	 +2cgtI+sOBQu4Q8VniQ8D1wAzylk8Ponu/8KHTKdpGt717BvU67S/HDVH33A0JL6ntFEc
	 4RPMDQAnL1+paxqn683uVsowVHAeDIkwo5CHJyaOTTisozWWOENicqrKl0MWKXKfUzQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=efBhm6Jq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790342823;
	bh=4x0/WJkyO3IbDTXlHHMTggHj3/u/Oxh5WOU4HWQXCgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RaUF/+Is36tg3iNwa+E9cnpxfhXl6c3v+61OKDuybBL2NU1A7F+FzYL44mpENvKIY
	 MaywibLGN376/WnbuU6QVEB2AH8AI+QL0Wj9DoZuuHmWa5QlGHgm8MEaTZFMtsmyxT
	 wuYXzYDOVj1WyX2gQdOByqN7ysx5oRcFnKG6EwZzC+FpxL5sI1Di9Mhhijy8mESGK1
	 EVC0stgXMpm8Q90ub3IiKtPqKGQITmV3KjfiRoCmBvOM7yZmdJ4eqrdmcH6OssNdId
	 4sPxKMgmJd5C6HvGgT1Dhm3KNPLGAbnKyljwap+kz2BgHLAYYvYh/O0m85Wlbq1akS
	 I2EEvMRBesRgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 25DBD60D6D;
	Fri, 25 Sep 2026 13:27:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 57B7932F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 13:26:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3DEC660BED
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 13:26:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vJL3YyGz5Apl for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 13:26:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1E70C60BE4
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790342818;
 b=h8lsa38Flu8y8VRGan1TFjuF+Zwpv7k73VsnkMsOFi4l40H410FQJTN4yvus5t6DmMyo
 VCRrEMWanz3kj/laVizg2J13SMmEP/TqbCuawSS7+iusJt+nR1CAycPp6NL1edH7cdW+f
 Co3aNMeEoyaB0sr35cb6o+aZKko57L4JW1V1EyVkCvXW81AjwYlWbSAMLNBD/voISY8j6
 MO1wpLyTo6W6nfqFvVcHw5IKgh6S3vhmiK7JQjiZ8u70KTwEnerDhe+3bSW6TbO+W5RXb
 aErZnIMZTS7p21mDgPMnpNjY0JHd7i7Ql91yaaKakJ91LGSwa3jB/IIHztnmkRcD9ew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790342818;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=4x0/WJkyO3IbDTXlHHMTggHj3/u/Oxh5WOU4HWQXCgI=;
 b=SNd8ZlrAemEBohHoQlWXYs/loBYE3/8zq+BzIkXksM55V+QbAQkTF5XPZXh44bZ+GXTd
 hQ3gYWns5DEx6M436LUfCN9ut4LifEPRfzKzV6mZm9gLMkYo090NfA4xSwqM4IeUD0dGk
 jlTTJfkcn13Bz3pfyCmoX8USM2N249yHSXpzKRJyKpcOmyYWs47YTIeD/TbH8xttoYUR2
 DBzTqEJtI1j2r6HDUjvy1BtIgId3HX4pYdU1MLALRq97+cLfATLi3BWPc1J1211kWDUIN
 Q0R1DoaoMzby6RRPZZ4NB2Ep8K6QqDCDjAh9oHX+Ty10nGE8W1W+jkqD5GSTaOIH6ww==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=efBhm6Jq; 
 arc=none smtp.remote-ip=198.175.65.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.10;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=efBhm6Jq
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1E70C60BE4
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 13:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790342819; x=1821878819;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6yPigfA5k4VyxOof2B+E+5f+0Y2tBW6P2rB/PQGm3gE=;
 b=efBhm6Jq91bAwRCS/AIp2SzxMHeIfYayDzBUTOpknouHvZ9T2I1UvDZ0
 czPbhBx7pqzKscok+xd/etsQumb6zxPEaF360pmTDY9GV770+chfxpWrv
 VwQOgkMSRmlPY2hXChHYyCP3TpfZQrJlAllOE+7v93yLAl4fA4dbYdxT+
 hD05/Um1hPt/3J8TQXO7vuDyjh4RIXLIL254WJli8In68RJUerWxrvB9l
 hhcCnz++WMGaKHlNCwKl0DjDjsypaqlqxY6OgXis3kBQajIPeOkAt+7Wc
 44TUKaOLTHnDb8x4VDL5YaHBwmFM+K4Y+RpwvNn6nfAiqvfhKzhvJNHPE g==;
X-CSE-ConnectionGUID: S7WG24hqQEi4KD8R2KBVGg==
X-CSE-MsgGUID: vebTeX+hRTOEld7ITt9r4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="107508251"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="107508251"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 06:26:57 -0700
X-CSE-ConnectionGUID: RDbae7hlR9Ga1lelLy+vVw==
X-CSE-MsgGUID: vhIzYfsZT5+UaAirkRc/fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="282414673"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa005.fm.intel.com with ESMTP; 25 Sep 2026 06:26:53 -0700
Received: from pkitszel-desk.intel.com (unknown [10.245.245.32])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 1EE362FC54;
 Fri, 25 Sep 2026 14:26:52 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Michal Schmidt <mschmidt@redhat.com>, intel-wired-lan@lists.osuosl.org,
 edumazet@google.com, horms@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net v5 1/6] ice: skip stats handling for channel VSIs on
 rebuild
Date: Fri, 25 Sep 2026 15:15:43 +0200
Message-ID: <20260925132636.123300-2-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260925132636.123300-1-przemyslaw.kitszel@intel.com>
References: <20260925132636.123300-1-przemyslaw.kitszel@intel.com>
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

ice_vsi_alloc_stat_arrays() returns early for ICE_VSI_CHNL, so a channel
VSI never gets an entry in pf->vsi_stats[]. ice_vsi_realloc_stat_arrays()
dereferences that entry unconditionally, and ice_vsi_rebuild() calls it
before anything else, so the NULL is not filtered out anywhere.

The path is live. ice_prepare_for_reset() removes the queue channels only
for resets other than a PFR, so a PFR leaves the channel VSIs in place,
and ice_rebuild() then calls ice_rebuild_channels(), which rebuilds every
ICE_VSI_CHNL VSI it finds. A PF reset with ADQ (mqprio hardware offload)
configured thus dereferences NULL.

That combination is reset recovery on top of an active mqprio offload,
which is why it went unnoticed. It was found while refactoring this code,
not reported by a user.

I'm leaning towards removing our limited (compared to OOT ADQ) support,
but it's outside of this series. Bug could be triggered by:

  tc qdisc del dev "$IF" root 2>/dev/null || true
  tc qdisc add dev "$IF" root mqprio num_tc 2 \
    map 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 \
    queues 2@0 2@2 hw 1 mode channel
  sleep 3
  ethtool --reset "$IF" irq dma filter offload

Workqueue: ice ice_service_task [ice]
RIP: 0010:ice_vsi_rebuild+0x289/0x380 [ice]
 ice_rebuild_channels+0xd6/0x320 [ice]
 ice_rebuild+0x4f6/0x540 [ice]
 ice_do_reset+0x9f/0x1a0 [ice]
 ice_service_task+0x4a/0x460 [ice]

Fixes: 5995ef88e3a8 ("ice: realloc VSI stats arrays")
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v5: new patch, split out of "ice: rebuild ring stats arrays instead of
    reallocating them in place" (Clashiko)
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 9e08db376d3d..31af378aa0e7 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3031,6 +3031,10 @@ ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
 	u16 prev_rxq = vsi->alloc_rxq;
 	int i;
 
+	/* channel VSIs have no entry in pf->vsi_stats[] */
+	if (vsi->type == ICE_VSI_CHNL)
+		return 0;
+
 	vsi_stat = pf->vsi_stats[vsi->idx];
 
 	if (req_txq < prev_txq) {
-- 
2.51.1

