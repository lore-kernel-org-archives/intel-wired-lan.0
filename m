Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B34CA600C
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 12:58:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 904DA811A8;
	Thu,  8 Oct 2026 12:58:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id efdy0mSg6ihQ; Thu,  8 Oct 2026 12:58:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CAC88811DA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791464325;
	b=gicVCYrdNPclmMOYAdbKLRPfBnhUf2J54JWrx7FZ5Ut5BPUZrSHPO3k6a3G4gS4Gcv3W
	 /RTMwxUkt1RXz2a1JT0K1yL6hPp8vpl6OQ4WdMUCPGLv5jZRI80Mq6jA77cgEs9zJcg71
	 FYjS5B0IzL/x5FIpkp1AntIDqlg5oT20BMaXufUixUN6upWlqLmmXvlmjP3n5M6misRKW
	 F1ER9/R/pmIO4dcXTh/P6EkpyRGd2qeE/n053AIywbhPGmriy+UlPSoPIszR904fvrGIj
	 HBWkhpBIINq0oQW4Il/oWHdb0D0I/cmvyHTgJua2WUmG016/Rwo4DzA8rBOmNuFnkRA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791464325;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TGZAMLTLMJ/U9F3xyOxtk6/R8MPsbxMjndAIpvxkZWw=;
	b=ceObZ71DPuSt2Hbre9taQE2s/euyMuUeskTrJXte1ZZrZy8yTlbkyWmw59dzWXsOP3HF
	 Zjg9PCD9MMfj95g8wOCNLagzzt154zvOLGUbhiKGfeEQPKOx1LAp+dI/7RgAoqp+21cbr
	 VSxc4q2/yGawdmx5f+rBEeDJ/DRkLYMewsFvr1WxP6YCkSNJPCfFcSMgZMB4trod1I3QH
	 PPrhKlCRYWxXPvitNCNJ7/Eie0eJqs7KnjvMI3yyWodMtKScMG+5lLolXFlieL52OqKoH
	 Rez0FCqvnxPd8YL4qJ4IDrRv9MffX9jAtHMN0focz9Kx7DUJaomHQ6EDBi6QEKExprg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791464325;
	bh=TGZAMLTLMJ/U9F3xyOxtk6/R8MPsbxMjndAIpvxkZWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TyNmyYsnYvO3Pd2qQ3tF2J95hwlHRM6oshyzqGF8bGSrnbfSKidiauEieRqUIDuwj
	 9KuTq5rmnzTmz7MBX7jR3qrnr/0iFwTHvMh2IE8lv5nkHERytPxPMOTMf8Zl1mKUuc
	 auTCcZqpy0Acq+m/9FiYhn7a/UGHEzIf6nbFauKK3IS9/uPB+11N53/dpmUVFkNCma
	 EXCa84gcuxxbQP2BDpNsAvJWqqBBoyd42jWpp7yjJKDjEhBW5Hlf20Wc/BAr0JJZ3V
	 HkWZABMbIlvE/cotxG7nDxuvlnqAM83DBhgyn2layqeR0E2gBWA5leudc87cRLAKho
	 jzRtuy3wT3tbg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CAC88811DA;
	Thu,  8 Oct 2026 12:58:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A1296338
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 12:58:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9332760B3F
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 12:58:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z1RrtpmfN0v1 for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 12:58:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 917406068B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=220.197.31.7
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791464322;
 b=dt6MvJJOr0+yq4Yca4FuRtPgpi31s+dbflV/zmeq9UbOb34Sq061fnVA+y/RrcB2Gjlb
 rQBg5V2iSJPxtJhAJjhqAPC66ZPHC08kO0cNYVHDEi9FlqZLOommg9C8Wwm8TZeisjyAc
 y5VHwyZRsjKn1Mk8yDU8/H6ACkE27Yz3JlC4RYpRyH/euBOZIsxx+B4hCG5J0hYoQbMPq
 kcaTijPHRKS0HPRuhh+PdB31hquUHPfDujY7q3a/sz/yo+M1x8/rGhVJFL7r1qQreVtEz
 QKe98zAFkYkaeXdk40efqOd3cZLu6nUnwURKCxh7gMySrNxYav28kb70V1rp0JUTnFw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791464322;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
 X-CM-SenderInfo;
 bh=TGZAMLTLMJ/U9F3xyOxtk6/R8MPsbxMjndAIpvxkZWw=;
 b=C4DjKG6v9AAW2kE9LXb+DhVRqx1Qiqb+Q1B732ezo8cXAGyEvXzjccaEH4ZEpRHfVatp
 hGr5kxPspYSL33xvUD6b8JAPGu+cfhokkeP1hspK1wSKByMMdb2Kl3txlQlISpKGX1F8j
 ptPiY3tm2uWhzXpA3/M7iAyPm+S6NUe/W3E3LFBM24mJNl6Knl+m2Kzgn7JNUMbkHKcCK
 Y/xVmM4NPRXLvs9O88WSIO6yGakLxH1b7YwVZ/QkrUeypSSSsKv3A39lwKXLayr/y4Uy3
 wPf2o44ylRd1I09AW3iEP/b5qdokWSzJyvcyul8bF5yONrLT1FIYzUQb8v+9LNDqn4Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=126.com; 
 dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=Br3kibwO; 
 arc=none smtp.remote-ip=220.197.31.7
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.7;
 helo=m16.mail.126.com; envelope-from=xiaolinkui@126.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=Br3kibwO
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 917406068B
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 12:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=TG
 ZAMLTLMJ/U9F3xyOxtk6/R8MPsbxMjndAIpvxkZWw=; b=Br3kibwOVh9aVODxn3
 aAB0sRSF0FR3IM53DYdBHaogS34SFGvaYUxGWh66hHdYTFGxTK4VUGZXIsPNnaO5
 hpOxGvbMBTmWE0ap+nAdWddHiB7y1Yr2jX2ME1a7ijUPi+uIItOpIfWPUcbxJGJG
 gahZvJx3I5hCLqyvSQsBO/w7M=
Received: from localhost.localdomain (unknown [])
 by gzsmtp4 (Coremail) with SMTP id PykvCgD3v8NWk8dqh6CpBA--.7046S4;
 Thu, 08 Oct 2026 20:58:02 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>,
 stable@vger.kernel.org
Subject: [PATCH iwl-net v3 2/3] ice: detach the VF representor when
 ice_start_vfs() fails
Date: Thu,  8 Oct 2026 20:57:53 +0800
Message-Id: <20261008125754.3520773-3-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261008125754.3520773-1-xiaolinkui@126.com>
References: <20261008125754.3520773-1-xiaolinkui@126.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PykvCgD3v8NWk8dqh6CpBA--.7046S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxtry3JF1DtFyrJrW3Gr4rKrg_yoW7Ww4UpF
 Wvqw1rKr1DXF1agw43uw48u34Uua4rKFW5Gr1xGr4rCan8Cr95Xr48K3429Fy8C3s7AFya
 vr4q9rn5u34DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U9IDcUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqRqHXmrHk1pkhQAA3v
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

From: Linkui Xiao <xiaolinkui@kylinos.cn>

ice_start_vfs() attaches every VF it brings up to the eswitch with
ice_eswitch_attach_vf(), but the teardown path only undoes the queue
mappings and the VF VSI. Nothing calls ice_eswitch_detach_vf() for the
VFs that were attached before the failure, and the caller,
ice_ena_vfs(), goes straight to ice_free_vf_entries(), which drops the
last reference on every VF.

The port representors created for those VFs therefore outlive the
failed VF creation:

  - the representor netdev stays registered and its devlink port stays
    allocated, so both leak;

  - repr->vf keeps pointing at the struct ice_vf that ice_put_vf() has
    just freed through ice_sriov_free_vf(), and repr->src_vsi keeps
    pointing at the VF VSI that ice_vf_vsi_release() tore down, so any
    later use of a leftover netdev, for example
    ice_eswitch_stop_all_tx_queues() walking pf->eswitch.reprs during a
    PF reset, dereferences freed memory;

  - the virtchnl ops of that VF, which ice_repr_add_vf() replaced with
    ice_virtchnl_set_repr_ops(), are never handed back to
    ice_virtchnl_set_dflt_ops();

  - pf->eswitch.reprs never becomes empty, so ice_eswitch_detach()
    never calls ice_eswitch_disable_switchdev().
    pf->eswitch.is_running stays true with the bridge offloads and the
    devlink rate topology still up, and ice_eswitch_release_env() is
    skipped, leaving the uplink VSI in the switchdev configuration that
    ice_eswitch_setup_env() gave it: local loopback enabled, Rx
    filtering disabled and the default VSI steering removed.

Detach the representor in the teardown loop the way ice_free_vfs()
does, ahead of ice_vf_vsi_release(), because ice_repr_rem_vf() and
ice_eswitch_release_repr() both need repr->src_vsi to still be valid.
Every VF the teardown loop walks completed ice_eswitch_attach_vf()
successfully, and ice_eswitch_detach_vf() already returns early for a
VF without a representor, so no extra condition is needed.

The detach runs outside of vf->cfg_lock, the way the previous patch
leaves it in ice_free_vfs() and ice_reset_all_vfs(): taking the
devlink instance lock and then RTNL under cfg_lock is the wrong way
round against the ndo_set_vf_mac(), ndo_set_vf_vlan() and representor
ethtool reset paths. The rest of the loop body still runs under
cfg_lock, as in ice_free_vfs().

The VF is marked disabled first, because nothing else keeps a reset
away here. ICE_VF_DIS in pf->state is only set once ice_ena_vfs()
succeeds, and ice_sriov_configure() runs under the PCI device lock
rather than RTNL, so ICE_VF_STATE_DIS is what makes
ice_check_vf_ready_for_cfg() reject __ice_set_vf_mac() and
ice_set_vf_port_vlan(). Setting it under cfg_lock also waits out an
ice_reset_vf() that is already running, which would otherwise reach
ice_eswitch_update_repr() on a destroyed representor.
ice_vc_process_vf_msg() tests the same bit before it reads
vf->virtchnl_ops, which ice_repr_rem_vf() restores.

Found by code inspection of the VF setup and teardown error paths. It
was not triggered and no stack trace or error message was observed.
Compile-tested only, not run on hardware.

Fixes: fff292b47ac1 ("ice: add VF representors one by one")
Cc: stable@vger.kernel.org
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
Changes in v3:
- Detach the representor outside vf->cfg_lock instead of under it, as Przemek
  suggested, and mark the VF disabled under cfg_lock before the detach so that
  an ice_reset_vf() that is already past its own readiness check cannot reach
  ice_eswitch_update_repr() while the representor goes away.
  (Przemek Kitszel, Sashiko AI review)
- Include how the issue was found, that it has not been triggered, and that the
  change is compile tested only, as netdev-bot asked for.
- Not carrying over the Reviewed-by tags from Tomasz Lichwala and
  Aleksandr Loktionov, as the code changed after their reviews.
 drivers/net/ethernet/intel/ice/ice_sriov.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 471c1e29a865..470aec8849b6 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -520,8 +520,27 @@ static int ice_start_vfs(struct ice_pf *pf)
 		if (it_cnt == 0)
 			break;
 
+		/* Mark the VF disabled before its representor and its VSI go
+		 * away, the way ice_free_vfs() does, and take cfg_lock
+		 * around it to wait out an ice_reset_vf() already in
+		 * progress. pf->state has no ICE_VF_DIS on this path and the
+		 * loop leaves ICE_VF_STATE_INIT set, so without the bit a
+		 * concurrent ice_reset_vf() would pass ice_is_vf_disabled()
+		 * and reach ice_eswitch_update_repr() on a destroyed
+		 * representor, or trip WARN_ON(!vsi) in ice_dis_vf_mappings().
+		 */
+		mutex_lock(&vf->cfg_lock);
+		set_bit(ICE_VF_STATE_DIS, vf->vf_states);
+		mutex_unlock(&vf->cfg_lock);
+
+		/* detach outside of cfg_lock, see ice_free_vfs() */
+		ice_eswitch_detach_vf(pf, vf);
+
+		mutex_lock(&vf->cfg_lock);
 		ice_dis_vf_mappings(vf);
 		ice_vf_vsi_release(vf);
+		mutex_unlock(&vf->cfg_lock);
+
 		it_cnt--;
 	}
 
-- 
2.25.1

