Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4188ECA601E
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 20:12:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 113B0810C2;
	Fri,  9 Oct 2026 20:12:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wCg2xonx7X6n; Fri,  9 Oct 2026 20:12:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2884A8112C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791576775;
	b=eSH1mi55uKhbsI3TwTsNt/cTf6aMjGpP7vImRwBvjqd+2DAGCmb/ipOxi//d2HlEXo1d
	 1VLtjT9rWINYM2zseG6uMJIqy5a2QeYNg2Ju5/fQwBeZ4G58bg2RJdxkoRYj1tHBQiLvp
	 s6TlkfD07QWbLAZqrKKazJdzkjPwADMKip2vfQbw9GhTk+Snwr92Gf1K+SUdz3G/JnPX+
	 l08IsT4jBMN8TqVz0F0t3eAvseQrO9fBFczBKw0h0IjD1O9vFqzibmn5ZwHloB/Ih1K9W
	 Ido1Vxt8xxInJgJKOO4eaJHnnqOycD8f/Y66pZEbonPnIXAHz1Kg8F/VXKvFRBaWZQA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791576775;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SgeVbnG7zHzfCJnMCGPB9MNlJmGyNJXoBQDl6SHX2cg=;
	b=lZAw66QuBIO/xr0bfN0698MMJqXnEFKkkNwLRq8dCAFf6fNuYBoq5DgfrHNd6+BRMWt3
	 qySxdQ8IthUSmjumUAhWLbpfzH5ocIgRbby2i0z4/6lkTuDdlcYko+mNB2Kd1AkHqFW/c
	 inXdKyFRCJoi4ktF7bDuW59MdQwky8mXhCdezzVjsM6NX8jksWdH66/XRszyr0Ag/HAl7
	 iZNkrBRvjZ3fhHtRO1STJEQyxj4r2AzpST2z/jH99y6oKVH+qNbMqp1EgPn/6qVIsvWfE
	 RbN27Rw7feE3mEzVK0YPAdHm8XyE1RyTW2B7UPZYfzSCre47/NcLjeT0ZFLzEsaV6pA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791576775;
	bh=SgeVbnG7zHzfCJnMCGPB9MNlJmGyNJXoBQDl6SHX2cg=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bSfQvGap7otEv0ZqCGB6Nc/AU2g2wcbWNHHJDw8TZxbFKIDrjtqJQfMPhT0pjDbmv
	 DpvBYv7gC4G3a73J0R6v00ojJQQHHacZPho0T5bXLpAmFW/xtv2dZLWhojBXtJadGe
	 sOvCVnihAbKgOya4Px54sG8XR4kxH3Cx6LPhulhnBPUM4mupIS2VYFsG6tHEqlRcwz
	 mxsqrFBKI5CLE8qMqNp6YQnbrz+qKvwLlPMAzsIazrNYPHng9OzbQxgCHTn0/R2bMT
	 eS/DUBB0mL86fgGUkB5I3z/Ljx1YiPBBkA3UNJ7QDMpiyN2bD5QDHZ3RmLnrBZozNt
	 ZC+xyyI+TVtgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2884A8112C;
	Fri,  9 Oct 2026 20:12:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1B32D3B4
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 20:12:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0D17D40080
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 20:12:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0rqB_iuyDabe for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 20:12:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 448A540053
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791576765;
 b=bjJ6ZQyhMw1bg4p8A0EdlNFEbVCY5laIPFOchuWFjbNIwSgWVoSP9B21CIeLn4bgamSJ
 vQ09aPQbTu3zfpCYHz7NwBt+MkDFNTWA7fBBDzgxi+667jKtEdlMVa9bABnJ6v7kRn2u9
 /pQAjRriLTSCTqU6e8vCMQ1zQn+cf+KlO7ifJfQ91YdH3x+tWmdu1KvmxtBT+vpLoYvVI
 jXp28ZLjKmRPNkLdAX/xnheQ0yPeKhGcxF2tcrTe7OLcSZba6YQrYHGXHc5PIIuCHXMt7
 tNwhVmrdIFkqYAvrpn2QhQudBjbYVKYaglNfrTPb8nWOQ9HufpYw+sesBjE4qRAyWNg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791576765;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=SgeVbnG7zHzfCJnMCGPB9MNlJmGyNJXoBQDl6SHX2cg=;
 b=SZ4nKYWtKQu8LTk6DQKzDK+lACj8Qt1fsDiIxZXLJe4ci4AJ7SOOhTvH9nK5/DGYpIwW
 ItcJrRzvnHpNaCg8oILi6Z7a6yJ3QxiGqt63sDmFtIW3KAn2sBbC+azar+p6BWK2CfKks
 KFKlroYSecu0F5TLv0wysc7J0h88wWvA4LiQ/EezSVyIqyiMvUxkKMZs/i+XLOFV3OtoF
 eNw52GPjolMXqLcpVGD3VwxEZW3ZzdKRkr13wudeNmHkQH7iYRt1x9bvqW0SAC8efsSok
 +h0nCCeBEaBclLouWgg3seEaW7LT0gNgyNyBxuKglYqr5uw9dgT65nDLuQV2pxb57pA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=L6jvWuHW; 
 arc=none smtp.remote-ip=198.175.65.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=L6jvWuHW
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 448A540053
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 20:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791576766; x=1823112766;
 h=from:subject:date:message-id:mime-version:
 content-transfer-encoding:to:cc;
 bh=5G4mVo/JZPd3Ard6dbQxkAEt+0dS2VQriAypz4CJ+/8=;
 b=L6jvWuHWWruCXFb4+85HVqJhD8jjwVH7fcKkuB1Dxv4sPesy84YRD7Hq
 pJffMWthd1r+fNdG8ARVr1/Cr8qfi/+IRgTU02jFbFioiCJb+eaaL5oTP
 kU7zVdgY7fEmcltQyuyrs4/et2ePK7LssybTU/94eeBDGKH6QLex1XPTy
 1SZAx7B4EYBzHTz7+WgAxKDxUaHSk8zm7rv1ic9iOP2g2cJ2DLp//DkPk
 51XJYrzIZOITaPFGwmUZZCgtp8jouicn/S0uCnAcvidL+qDKPEM8vPwqd
 EPJns4TDS6YIb6/wobzAfNMgLt/aZ1FlQxLkAQNZf30uRBwuh6+Ccpg6X Q==;
X-CSE-ConnectionGUID: khm8AjWMRECleE7WVmWPZQ==
X-CSE-MsgGUID: 2b7/fc4OTOqoyoaP9AMRpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="261907"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="261907"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 13:12:44 -0700
X-CSE-ConnectionGUID: GUu6Oc9zQb+4PMsffYqafw==
X-CSE-MsgGUID: oeh+HLV+SOmoyH2jhXbDOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="2189790"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 13:12:44 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH iwl-next v2 0/6] ice: refactor aggregator node logic
Date: Fri, 09 Oct 2026 13:11:16 -0700
Message-Id: <20261009-jk-cleanup-vsi-aggregator-nodes-v2-0-313964c25c7b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5XSzW6EIBQF4FeZsC4NXPmzq75H04XAxWHq6EQcO
 83Edy86ixq7sF3eAN85Ae4kYR8xkZfDnfQ4xhS7Ng/wdCDuWLU10ujzTICBYpJJevqgrsGqvV7
 omCKt6rrHuhq6nradx0RLayUY6RxaQbJy6THE25LwRuJnQ1u8DeT9sZKu9oRumAPmvceYMvS1l
 BlhOfHI5Xw3dwTKqC25cMx6ieheYztg8+y685I2Fmuv2PeK2VOB8SBK8DpsPfFPT2TP2KCQl1p
 D+NVPrj2x78nsoeNgpXTaIt96au3tv9uosseZLys0wEHYrafXntn3dPYK0N5UZbDBwdYzKw/Uv
 mfm+/MWvWCMCS+2Hv/xFPvDf+FzP+UVOosSPa69aZq+AR05IMUaAwAA
X-Change-ID: 20260505-jk-cleanup-vsi-aggregator-nodes-9bb5285cceb4
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=5276;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=5G4mVo/JZPd3Ard6dbQxkAEt+0dS2VQriAypz4CJ+/8=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqyTXmuMN7HcEE2O2ba4jvXBhY1BCz4c0ld2ZexumXHn6
 963Qat1OkpZGMS4GGTFFFkUHEJWXjeeEKb1xlkOZg4rE8gQBi5OAZjIVS5GhpPHDjOyOPxnqp/8
 S/Sdp1h2qLTF9dyV3VPu7/Di17y/4Cojw86N4nlGP0sjLMLSnz5mmeKfdt4pJsBTo3wyS+8ep5I
 MBgA=
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

The ice hardware uses aggregator nodes to track VSIs in the device
scheduler tree. The existing logic used by the ice driver results in a
two-layered tracking approach where the VSI has an ice_agg_node structure
that wraps the ice_sched_agg_info structure.

This logic is done outside of the scheduler code, and results in the driver
having two sources of "truth" for the aggregator nodes. If the two places
become out of sync it could lead to imbalances in the scheduler tree, or
failure to use the device resources as effectively.

In addition, the tracking logic requires each struct ice_pf to contain two
arrays, pf_agg_node and vf_agg_node, which track the ice_agg_node
structures. This wastes about a kilobyte of memory (~5% of the total PF
structure size).

Almost all of the information required is already stored in the
ice_sched_agg_info structure, so duplicating this information is redundant
and unnecessary.

This series refactors the logic in ice_sched.c, converting from a linked
list to an xarray, implements a new ice_cfg_vsi_agg() function to replace
the ice_cfg_agg() function. The new logic better integrates with what the
driver actually wants to do.

The result is that aggregator node information is tracked in only one
place, preventing the possibility that it gets out of sync.

-- Outstanding and preexisting issues --

It seems that since commit 47e3e53ceadc ("ice: Destroy scheduler tree in
reset path"), the reset paths now calls ice_rm_vsi_lan_cfg() which calls
ice_sched_rm_vsi_cfg() which will eventually call
ice_sched_rm_agg_vsi_info(), clearing the aggregator node info after a
reset. Since this removes the data from the agg_info structures, the replay
logic does not appear to replay aggregator node info properly after a
reset. The driver only calls ice_set_agg_vsi() once during ice_vsi_setup()
and does not call it during ice_vsi_cfg() or any rebuild path. I suspect
that post-reset the driver will leave all VSIs effectively in the default
aggregator node. This appears to be a preexisting issue since the
above-mentioned commit, which I have not attempted to fix in this series.

The logic for aggregator nodes and traffic classes is quite confusing. We
pass the ena_tc bits into the functions to create aggregator nodes, with
each node having a tc_bitmap of the enabled TCs. However, since we only
perform this setup during initialization, any changes to the traffic
classes do not get reflected in aggregator node configuration. The logic in
ice_sched.c is very confusing because it seems to imply that each VSI can
have its own set of traffic classes, but there is no attempt to handle the
case where a VSI with one set of TCs is placed onto an aggregator node
created with a different set of TCs. This appears to be a preexisting logic
since the beginning of driver development, which I have not attempted to
fix in this series.

Several places in the driver use a u8 for storing enabled TCs, while others
use proper bitmap APIs. This probably should be cleaned up so that
everything uses the same style instead of mixing and matching, copying or
casting from u8 to unsigned long, or using tc_bitmap[0] in places that
should have just passed the bitmap by pointer instead of by value. I
thought about cleaning this up but left it out of this series.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Changes in v2:
- Rename agg_list to agg_nodes to avoid implying the old data structure
  type
- Squash the cleanup of passing agg_info around into the patch for
  extracting aggregator allocation out of ice_sched_cfg_agg. This
  sequencing is cleaner and more logical.
- Add a patch to also pass agg_info instead of performing a lookup at a few
  other functions that now already have a valid agg_info pointer in the
  callers.
- Move configuring an allocator node into ice_find_available_agg, so that
  we only call ice_sched_cfg_agg() once per node. This fixes a behavioral
  difference with the previous implementation that was pointed out by
  Sashiko.
- Link to v1: https://patch.msgid.link/20260601-jk-cleanup-vsi-aggregator-nodes-v1-0-36d6ecbe5ede@intel.com

---
Jacob Keller (6):
      ice: convert hw->agg_list from linked list to xarray
      ice: count number of VSIS in agg_vsi_list
      ice: extract aggregator allocation out of ice_sched_cfg_agg
      ice: pass agg_info instead of performing lookup
      ice: remove ice_agg_node wrapper structure
      ice: remove unused aggregator node functions

 drivers/net/ethernet/intel/ice/ice.h        |  23 +-
 drivers/net/ethernet/intel/ice/ice_sched.h  |  13 +-
 drivers/net/ethernet/intel/ice/ice_type.h   |   2 +-
 drivers/net/ethernet/intel/ice/ice_common.c |   4 +-
 drivers/net/ethernet/intel/ice/ice_lib.c    | 114 ++--------
 drivers/net/ethernet/intel/ice/ice_main.c   |   7 -
 drivers/net/ethernet/intel/ice/ice_sched.c  | 336 ++++++++++++++++------------
 drivers/net/ethernet/intel/ice/ice_vf_lib.c |  22 +-
 8 files changed, 237 insertions(+), 284 deletions(-)
---
base-commit: 4fdf2a2915a3c1baa162671f8c7155cebf02354c
change-id: 20260505-jk-cleanup-vsi-aggregator-nodes-9bb5285cceb4

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>

