Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840CEC9830B
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Sep 2026 18:08:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 56B9440738;
	Tue, 22 Sep 2026 18:08:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uuxpn5ZCRrAO; Tue, 22 Sep 2026 18:08:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A47E54075C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790100518;
	b=FcKNwQjxd++egteg7K5bxdky2TYPvfNGH2xnxip/G+hWrJr4rKzZOWBDBamK0Ifw95iF
	 kXofpMk0tOxi7aV6M2Mr74OfoICBCcOdDzPaxRRbmZZyEXp/XztY+B1HzKcTLNxUQF5d1
	 hkOlcrn6D2Xz9rNNtT/n66NiOWHRCU51WBCAC6KSU+8MJwxl32TEYP0FLyufziNZKUQZO
	 IkMunqYvoWgliVbVm/THC3cIq383fEaYEhkdR+MpMLTg/avFtr7tGUFcXwNFC9hGZpiSg
	 ihgPTYfdkAi6w5EH3x+Qg/UOAmiRGXa471BuXsNWYjVLXxVpxa+Q7AjajCjgLjIrEfQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790100518;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UqBxGmvgoDGr9GJNTVvAqJoPzo1rna7ARy/mi18Ixf4=;
	b=Fa+9FaZvXdJACvdGdyNrMcnONSdrTzkqdQhQyRa54PDOrBk942PduiGJPxPDZUb6TLYy
	 w7QNx4dqKhti9x5dB7Kl9l250t3kDdIMxSxnNeGwiQJ7vdq37APAkStU0LQqieCyfv0cm
	 1xlIqaPgbFpNMbX8kkqfHcszQKd3GSDAjbpyntKdRlZEjcK+rcfk1i7jvDYoIGEP5YKoI
	 S0o9FI4PfzW9bTLwP9mN026ESqlLu7x/7rOGafeiSJkzGfXp6s1tYjhm/G1UFkRT71C2G
	 6uulLAwOHk6ZiSg2MMATLD4BWJWIkwd7jN0Vcpf6mVIDUqrHITn2jbV862r6Zm32xGw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790100518;
	bh=UqBxGmvgoDGr9GJNTVvAqJoPzo1rna7ARy/mi18Ixf4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=8w7VnRYUwrHS5pxc//O5S1oGiB9y9jMPPG5OG44rDJ1a9AlyqUsez0MPOpv5L32Yq
	 Ati2jnlMg9N7BvKZb6T1HPZAE21drTYojTT8R1UfaIpwbIK49AhJEWmvaz2F4PY2q4
	 9M3/0g5NDO+O+5U1WNPS+KP4IuiLGtFVCTR1nFdxjdXxIzUOUzZvL6h5JBX+kn4fvE
	 TdLaD1pI/AZjc4VZcgbRuuo9zQZNuQ/QQ9AKhHGGdhan8iGppwHm1s20MmMGNFpfSm
	 /+WsljtNT5JZeAfrZrN1CUZ1NRave86iijDPzQLWUNbdRoOXqgkKa8tVu4HSC7XgIq
	 rFrWpQYQzzqGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A47E54075C;
	Tue, 22 Sep 2026 18:08:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 921BD12C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:08:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8442040076
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:08:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rsc1sfuk4dHG for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Sep 2026 18:08:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D4A80401D0
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790100508;
 b=dt+hapY6ztJdzJ1MJcnJ5qe7skL/qPN5yehd61tq1pLoz5v7GtSLNk3diVRH5+Bjckxg
 2v8890/ou01e/LZkx6KOINFH+tXAHb1T1OpG+LqzM+C+E50zEOEJX0kIoXofbjPVPpMXw
 ZJx8GOiU45cLSzNMawm3PTIpi5DarjCWaogSsrOiV3yv0tTFmsmd20+YDKu7+n5Wd6xtL
 gprGXoMuk0mRsGAAMhanKgxSGZ07vtq55c3uoehJZ7FUeyirYfArBy3RmoKpU6WZ+gTC+
 sIUmo6dNnKPPLldiBxeXhcDxV6qCZsapOVviFADcTag5Z+bogrKy4Wlwp3BARKW0NWA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790100508;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=UqBxGmvgoDGr9GJNTVvAqJoPzo1rna7ARy/mi18Ixf4=;
 b=POrIGFmDXWNgKo7ZUwKFarUKE2B8J5Ypr4NMRGf9vvT6hyRL/rlAGUhqZ0gNFkCmC6eD
 6n9XI2SJyj3TzWHcN4WNCu6p/kHV7VaN8M45eugoH1tszkfkyo6cJK91U3tMG1q6ZgNLI
 RL5ARQvi0Ys5WrmbtcbwAqDCSTfrmFxJ3oJHOXaa1N7eBtgsJX0/hNJnPKZvp9dduL/Iz
 4/DLLfKi8TjGpOjF0eKzudJTvreabgtPGShPs4xA1nYSNxOjev6/jGNqn4yB2wc1Bz4ei
 9C82fAlHL+3WhyNgOSqSMUiGD757aZTR4m8en3OuY0rqBYiQlZbo6k8sa0Ro/YlmyQA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=mCP3yDVH; 
 arc=none smtp.remote-ip=192.198.163.8
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=mCP3yDVH
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D4A80401D0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790100508; x=1821636508;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=uYQTnh0Hg1Gx19CjcekG5cvjGDYmClExgwMLJ2AUOzw=;
 b=mCP3yDVHVzTDNbvE5JKnVf1wbQN/hBSV/TDOpI1FIMe3/HunfGp6HyCK
 9Edp8t5GnST50VypjKEGDnttb4X1rdxvSaVUzHxNpDTKu7pXkeKea0r6H
 uawpVbeo0vhqroIPxPZKv+HhUe7pp0UKyGeDgODOL9+d/q8q+95MxHtgt
 ktxE9Bs5n0eUWV78VFMChymufCb1PioCKo3h9GoUtGdT7a60ZktLqqP8S
 YtlW7bSJNCMjXC5tcl+Q6ihh+o+ZYiCY9CXzkSGX7ilHWjOjBemEe++Pc
 8RZQtlv3TseTWnsnkun/Xwv9mvOswDoO+BznLPKY9RCM8d0D2Lw5P6J74 Q==;
X-CSE-ConnectionGUID: kjXVVx7CT7W8fJDGjL1sQQ==
X-CSE-MsgGUID: I4DtdyaASp+PBjLqBgpJ9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="108232048"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="108232048"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 11:04:24 -0700
X-CSE-ConnectionGUID: C7mE2pZmRJKQ/eyWUD3DVw==
X-CSE-MsgGUID: Ucuzgu9nStCy6AYIXoT2Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="281315334"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 11:04:24 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 22 Sep 2026 11:02:43 -0700
Subject: [PATCH iwl-net v2 10/15] ice: E825: perform a soft reset when
 starting the PHY timer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-10-e55b692d0e6b@intel.com>
References: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
In-Reply-To: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, netdev@vger.kernel.org, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Maciek Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=2054;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=uYQTnh0Hg1Gx19CjcekG5cvjGDYmClExgwMLJ2AUOzw=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqxNh2XWa6lnbeJ34ktfvm39wg6/8we/cDhP7njgLHXXZ
 od21aTHHaUsDGJcDLJiiiwKDiErrxtPCNN64ywHM4eVCWQIAxenAEzktx/DP4UmPs0EvZmq207E
 L1if/n9L+RGDvi43kec7gw/a1YTGsTAyLFz98XditEIio8FH9aWm/pc2JGfvj8rwOs/2cbKIo4Q
 ZOwA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
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

To ensure that the E825 PHY timer begins in a clean state, initiate a PHY
soft reset prior to programming the PHY. This ensures that we clear any
outstanding Tx timestamp memory, and ensures that the PHY internal state
including its timestamp counter has been reset.

Note that despite the name, this PHY soft reset only impacts the timer
block of the PHY, and not its regular Tx/Rx functionality. Additionally,
many configuration registers such as the PHY_REG_TS_INT_CONFIG and
PHY_REG_TX_OFFSET_READY are not reset.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index e1a5ff5793d1..f8f985a5d039 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2128,9 +2128,11 @@ int ice_stop_phy_timer_eth56g(struct ice_hw *hw, u8 port)
  * @hw: pointer to the HW struct
  * @port: the PHY port to start
  *
- * Start the clock of a PHY port. This must be done as part of the flow to
- * re-calibrate Tx and Rx timestamping offsets whenever the clock time is
- * initialized or when link speed changes.
+ * Perform a PHY soft reset and then start the clock for the PHY port.
+ *
+ * This must be done as part of the flow to re-calibrate Tx and Rx
+ * timestamping offsets whenever the clock time is initialized or when link
+ * speed changes.
  *
  * Return:
  * * %0     - success
@@ -2150,6 +2152,10 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 	if (err)
 		return err;
 
+	err = ice_ptp_phy_soft_reset_eth56g(hw, port);
+	if (err)
+		return err;
+
 	ice_ptp_src_cmd(hw, ICE_PTP_NOP);
 
 	err = ice_phy_cfg_parpcs_eth56g(hw, port);

-- 
2.56.0.rc0.395.gd1f3524e15dc

