Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593F9606A334
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 10:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=PBSnmPdq;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=m+ioguzH
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3669680E46;
	Mon,  2 Nov 2026 10:46:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XcfGt4hz2zuH; Mon,  2 Nov 2026 10:46:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 774D680F58
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793616412;
	b=XNchpUURYoWhcKeq1FELkcc1lmmjTQ44D1kKoWwyOOmzP45o9qJ1eK3vFk+qbCFjfjiO
	 vdaB1H7ArWJJy98x2q5PTDMWtBN4BFdCyNquxBdAlippbHLA5jhemKbWqbMYIEwF9CQ9G
	 jfj86iTkwz359XJXqyN5idXmTUr1mZN51qPZxk9Zs4II2owmJkt8HK/Q5uPkCzNLI0eeW
	 fIE05HC8cYQao+lK5atCv7PsK3appALIiNslQyH//yWCLLAKWZwzFpgZgxJbcAa+/Pper
	 NCanQkJEIXpJcHr7l00Rg/XAbn4LdBCHB80dHZtSoTEp8rmq3i8nkhf9KntSdFb3dwQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793616412;
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
	bh=/7xDlceIeNbo7lDGt7hMq0QjN6wX8+OHWkN6IukYVwI=;
	b=iKyCRTrZrYnH0FItzVu7yY4cpCSmycv5vHY7XwiFJsD2GajsRjwARrL9cViWmta6BLe7
	 8Jbd+62vdfLOVsc4ZPjMk2qTvbGogPk8FaqhP09Be7ws4Dv1tg1lzCVNR/aNyVGLwhl8w
	 Z8l3D4z7qDUZzoToO5lQCa1zxAD+3zDYFjlJJR1OnlwCXVg1i3dorZK1jbci2rIeD0hpP
	 SsZ5aWa9U4QQIfSOjlifykJkERhVSIdgS2PZ+EAX/RKKHHnKsTC2/gZ24sNlaSZRokbr0
	 W95hGbV4cQqV14HF0Q6DjFmA0sckgAA9Eihi715d0Th4ts0L6UshMc5jd7omS4RmrjA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793616412;
	bh=/7xDlceIeNbo7lDGt7hMq0QjN6wX8+OHWkN6IukYVwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PBSnmPdqtwOaur9IjWCA1f+Vij432k9aerISd17Q5gaZzW9wHtyvd1N/gKRTenASo
	 mbyJuH7fA3qQWJ1DMlmxoHByNDfsDy51JOgWt5Quo9dhr49mI0ryIfjhhD4VbKsuU4
	 0tZMEYeITmzmcNsnaSPkwWrcFUAaV6S5HyyRObC5+jQwkIdDZGfPrsA951ErJEhb0+
	 1bAxSfk4btgmL4oy1Dp6tiQgCCqYIJa4L+ty7nUl0xc7hYkhIM7cduG7Z9OBjqnvqD
	 Qwvr6xmdsgsW457zXw1Ne6UMU+EaEtIws+vb1vdcS9w5xzHv0byVckLW5g8Lg2jcuo
	 vI57c4rR3fNZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 774D680F58;
	Mon,  2 Nov 2026 10:46:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AA2E6D3A
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 10:46:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9BEBF60792
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 10:46:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L7LK_OS7LXhu for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Nov 2026 10:46:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B8A106065F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793616409;
 b=YLwV9/G+1sesnPnzz7+wVvXtZWhC8qlNM0rLNVEwNc0yOwKVblN4+MKF6mZu63avsQ/Y
 vY4oCCJVdE/Li0qtSBohNFIfHSNUTPhm2b5+OBDHF9/BWIoTwC9CZqXi9ba8r3a0gW5hu
 e1SsuulRcGnsYn9C6h6iEhY7OyYo9jAKvGzvx4zuBXHskEeNT+qc6UKPdvqvbsdNzzgEm
 YzWhF13X3kbqLHmiMm+eu/rZtOMguDyzff24Almv48TyZOykRf4eEKPxQZLzMcU+2rh8m
 PUaB0Tu33SdmKc2DQw6hSM6qXM1u0Miyof/KQA2lg7ueK0PelTx95nqkxW3/4a4E90A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793616409;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=/7xDlceIeNbo7lDGt7hMq0QjN6wX8+OHWkN6IukYVwI=;
 b=FjuYiSMOjXS20z34gKnZiwq9dX1okfvG7L8/W2Ed7kz+yHAdIuKmnUxcb1bfyouFVwLy
 BEa1g9PQ5tloikmRlvIRKQ+VzAjIfs35TeD5KyF5g+uKkI/hUX46hFk8SWXQVnkytdUk6
 CVIMRLw0YM65+T7vF/ZO4fG8IitPjhpv+z89yn1ikeH7ctmDtM0hXyTQyHor9OpGeRDxb
 Si7KF1IlBFNd0J5Xw3kV8EEVlhyneaAnWv5RofwSjg9f1Ozm8YPGEhpSt0J3uR4GRUlm9
 orw1sT96IrHQmGWtQGmdRrHC4P3dzh5JfBGWdf5HOQ4ZDpNITvbCeXkAqeaYCfNLpXw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=m+ioguzH; 
 arc=none smtp.remote-ip=192.198.163.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=m+ioguzH
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B8A106065F
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 10:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793616409; x=1825152409;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EfBBOEZZ/St3wrXFXXFhlsLqHhhbxpnuAZwH6hLbGGE=;
 b=m+ioguzHdYdWlq6qxRyrFXbMbTPEOZrF24xCWv29AxGk0Dqj0mGrIsOv
 jqaAZ9nlcQ+KprlGrfLDRQANLbrh2lBvL9j9xMzOBWqy/ojlNowRB1rHw
 raYwXuNXMptrI9YArTnLlwaFd4LRieGwjYjqq9kN+6RqvB5awzs6kiDQ5
 NRc7bL+aO6D5LFQ7vUj9QzZtOmsr1UU3Z7dKx31Q0+qBouEK+WWQH53od
 +c0rRFyjWZb8osU9DMZIQyfU0Iv9h/DVWPOYrraKZjnisexfUwBhGk8lc
 tfVi4uNrT8vXvbmT3i4fyAsIgpWdZP8MZP6pXP4Y+7TdGCOSGLuap6yz2 w==;
X-CSE-ConnectionGUID: 16XOLwMeSISDCG3wkgoGSw==
X-CSE-MsgGUID: ocSn6ptsTqSSJtqghkot8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2305036"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2305036"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 02:46:32 -0800
X-CSE-ConnectionGUID: RA9T3jxwTuOrUyFkHdqI4A==
X-CSE-MsgGUID: BS1LAls0QCWwsc4+M7uwpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6012008"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orviesa004.jf.intel.com with ESMTP; 02 Nov 2026 02:46:30 -0800
Received: from pkitszel-desk1.igk.intel.com (pkitszel-desk1.igk.intel.com
 [10.217.184.18])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id D0CE52876B;
 Mon,  2 Nov 2026 10:46:28 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net 2/6] ice: take rtnl before tc_mutex in DCB MIB change
 and rebuild
Date: Mon,  2 Nov 2026 11:50:17 +0100
Message-ID: <20261102105346.30739-3-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261102105346.30739-1-przemyslaw.kitszel@intel.com>
References: <20261102105346.30739-1-przemyslaw.kitszel@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ice_setup_tc() and dcbnl ops are called with rtnl held and then take
pf->tc_mutex. LLDP MIB change handler and ice_dcb_rebuild() (the latter
only on its error path, via ice_pf_dcb_cfg(..., false)) do the opposite:
take pf->tc_mutex and then rtnl. The MIB change handler runs from the
service task. ice_dcb_rebuild() runs from ice_rebuild() (reset, also PCI
AER resume), and from ice_link_event() in the service task, on a link
change while DCB is enabled. So a MIB change from the link partner, a reset
or a link change, concurrent with "tc qdisc add ... mqprio" or "dcb ets
set" may deadlock.

Take rtnl first in both functions. ice_dcb_rebuild() now holds rtnl also
on its success path, which only sends a few AQ commands. None of its
callers hold rtnl.

Lockdep splat, on the first MIB change that needs a DCB reconfiguration
after "dcb ets set" was used:

        CPU0                    CPU1
        ----                    ----
   lock(&pf->tc_mutex);
                                lock(rtnl_mutex);
                                lock(&pf->tc_mutex);
   lock(rtnl_mutex);

Reproducer, with the FW LLDP agent in its default (willing) mode:
  PF=eth2
  ethtool --set-priv-flags $PF fw-lldp-agent off
  dcb ets set dev $PF tc-tsa all:ets tc-bw all:0 0:100 prio-tc all:0
  ethtool --set-priv-flags $PF fw-lldp-agent on
and then, on the link partner, send an ETS recommendation with a different
UP2TC mapping (python3 lldp-ets.py <partner-ifname>):
  import socket, struct, sys
  ifc = sys.argv[1]
  mac = open(f"/sys/class/net/{ifc}/address").read().strip()
  mac = bytes.fromhex(mac.replace(":", ""))
  tlv = lambda t, v: struct.pack("!H", t << 9 | len(v)) + v
  # not willing, prio 4 -> TC1, TC0/TC1 ETS 50/50
  ets = bytes([0, 0, 0, 0x10, 0, 50, 50] + [0] * 6 + [2, 2] + [0] * 6)
  lldp = (tlv(1, b"\x04" + mac) + tlv(2, b"\x03" + mac) +
          tlv(3, b"\x00\x78") +
          tlv(127, b"\x00\x80\xc2\x09" + ets) +  # ETS Configuration
          tlv(127, b"\x00\x80\xc2\x0a" + ets) +  # ETS Recommendation
          tlv(0, b""))
  s = socket.socket(socket.AF_PACKET, socket.SOCK_RAW)
  s.bind((ifc, 0))
  s.send(bytes.fromhex("0180c200000e") + mac + b"\x88\xcc" + lldp)

Fixes: 242b5e068b25 ("ice: Fix DCB rebuild after reset")
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index 0bc6dd375687..3034f461f513 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -537,6 +537,7 @@ void ice_dcb_rebuild(struct ice_pf *pf)
 	struct ice_dcbx_cfg *err_cfg;
 	int ret;
 
+	rtnl_lock();
 	mutex_lock(&pf->tc_mutex);
 
 	ret = ice_query_port_ets(pf->hw.port_info, &buf, sizeof(buf), NULL);
@@ -570,14 +571,16 @@ void ice_dcb_rebuild(struct ice_pf *pf)
 	}
 
 	mutex_unlock(&pf->tc_mutex);
+	rtnl_unlock();
 
 	return;
 
 dcb_error:
 	dev_err(dev, "Disabling DCB until new settings occur\n");
 	err_cfg = kzalloc_obj(*err_cfg);
 	if (!err_cfg) {
 		mutex_unlock(&pf->tc_mutex);
+		rtnl_unlock();
 		return;
 	}
 
@@ -591,10 +594,11 @@ void ice_dcb_rebuild(struct ice_pf *pf)
 	 * Suppress the Coverity warning with the following comment...
 	 */
 	/* coverity[check_return] */
-	ice_pf_dcb_cfg(pf, err_cfg, false);
+	ice_pf_dcb_cfg(pf, err_cfg, true);
 	kfree(err_cfg);
 
 	mutex_unlock(&pf->tc_mutex);
+	rtnl_unlock();
 }
 
 /**
@@ -1055,6 +1059,7 @@ ice_dcb_process_lldp_set_mib_change(struct ice_pf *pf,
 	}
 
 	/* That a DCB change has happened is now determined */
+	rtnl_lock();
 	mutex_lock(&pf->tc_mutex);
 
 	/* store the old configuration */
@@ -1105,25 +1110,23 @@ ice_dcb_process_lldp_set_mib_change(struct ice_pf *pf,
 		pending_handled = true;
 	}
 
-	rtnl_lock();
 	/* disable VSIs affected by DCB changes */
 	ice_dcb_ena_dis_vsi(pf, false, true);
 
 	ret = ice_query_port_ets(pi, &buf, sizeof(buf), NULL);
 	if (ret) {
 		dev_err(dev, "Query Port ETS failed\n");
-		goto unlock_rtnl;
+		goto out;
 	}
 
 	/* changes in configuration update VSI */
 	ice_pf_dcb_recfg(pf, false);
 
 	/* enable previously downed VSIs */
 	ice_dcb_ena_dis_vsi(pf, true, true);
-unlock_rtnl:
-	rtnl_unlock();
 out:
 	mutex_unlock(&pf->tc_mutex);
+	rtnl_unlock();
 
 	/* Send Execute Pending MIB Change event if it is a Pending event */
 	if (!pending_handled)
-- 
2.54.0

