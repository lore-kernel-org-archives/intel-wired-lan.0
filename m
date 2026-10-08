Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229B8CA6007
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 12:58:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D7AEA811D0;
	Thu,  8 Oct 2026 12:58:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TuuFsmaqRu9h; Thu,  8 Oct 2026 12:58:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CD2148115C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791464324;
	b=rYep9GAncOB+sPGZ9yrKzQNDk/zLCPuWZVtER7nYGe6CLsT1qaTtZWgIXQoGbB+s0uoD
	 ZqWuV4gxnEU26i48NUoUU6QLve3cS95X9yOFKp7dxznlYfJ+4LHE6QejgcpShI2nbiXNG
	 LlW6QXtP8J3je234F8ERVeRTHVdrK6YJwAIuoWkiIMQu01XBucdP8WGaDw3jLoBNkidrL
	 E7EIEqgvwQihCdEl2t5ukFLzGsqsMfI6pmdd97MCzjInmM3oUBjBdg7r3heoHrb1PvI/N
	 7XYjo+ZYFSMsd3w2SxbkTUQ0HzRR/R/xJSrj2MNYnxFq5YS7TwC3y6dR7YCAE/OBn7g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791464324;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=AhVlIdyB2pGt2fs06BKIwmR0kp8M62CgCW63wZLTG2A=;
	b=HxedBb1W0dsOtlhyZo27v056ajYOmB0UHO5Jdt71ND5EYCXGXI+RFGggG63PnYq7uRZ5
	 WQXTVPvHedfSGe1a/vPOKp6an3RqToqfZK+Fca1WDTVmUK6ExFUt/ZnKnTJmQMmR7DvKA
	 nWU6FOL/LWIJ0ybNo0M/URgW4Aut8rzWQS9FWRBaAf7uMoLrpPYCM9ZePb6A+DSCRgjUx
	 H+Q1L97maxGAKKBa4dkYg2lV8s3ZyjUgUL7fkzETS7wUdOiyT8V/sOXDMLOrmCYWDXVgZ
	 NDIFI45nhFvMTE2jGtDZBIC8ptYq7sq7bE79DlnAofXURyrd7bjmkEmVgK1T3UftnZA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791464324;
	bh=AhVlIdyB2pGt2fs06BKIwmR0kp8M62CgCW63wZLTG2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PH7R2FscNJtyQnUSAjKBZjcjBDLvNjBQiOWNHFKIYB1D3DAz4fo2WqWWG0oAeQA+R
	 HqfuCZLDagdazkK6XBraDKFFRV7LgznNGr5R7f9mHLDpTe5qlmJXO7Mng+QhK2aUfy
	 RrzDr05KGj23VTMVTZSZwnxALu91fqdEVJNqUXpEBTJpvbX/4kr1lgrz+VMrwIZ4xe
	 9INOfWmsxD029BK7IDiswFYuutLm/BA/YS3wNO4iSvjNDvr+DdUjCuE73zz8YsULeq
	 xtTEJ2ghm16lB2zfR2yY722ozedAgTdrvkstmuJ1onzpk4kpfBkBFWPVqd8+yNchHg
	 RDjpL/f3tUg3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD2148115C;
	Thu,  8 Oct 2026 12:58:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 321621A6
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 12:58:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 18389400E0
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 12:58:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xJihLFlVs_ch for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 12:58:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org DEA3340059
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=117.135.210.6
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791464322;
 b=inJlZTpgMAy6Wq5YN0Y1SHI6XgTNIkNJH3vh7HcsjQkWxs5cMt8tlqzfozEBPlqsgNnf
 PDhlLtwMdt7o23GHd+pqAHiIGMGSM+EvyfVrXTfk148bYvqk8wgu1LafGAXc4m8QOct/+
 9D+n3WmBJdqcRBhFw+5KD+VoPYCUd4l6flUG8yS2jdqU/Wb8oP3XAc7EM8HWcnRrYI9I2
 AGXj0uffE71S3PyVZ7sAyHTOOC84uAECn3Tu07T8BavUvCCMdmN5Qn5csd2g6Pyh5ktPu
 tHTos0W5i2JZFikefF9PIrdllI8AM1phwwe10921HKtvbP5eQroFKQvN42KsPjKIKpA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791464322;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
 X-CM-SenderInfo;
 bh=AhVlIdyB2pGt2fs06BKIwmR0kp8M62CgCW63wZLTG2A=;
 b=HpAlveXM6Y1+i7et+n7+kL3IEdDYn3+gLBxNkdLBTQCY3t5TpoFGr07JJ6ggr0v66STX
 MRowfqQIhJ1XH5AIDNxab9IFzQ4aURzsZxqw8hzgUB506BhX4mXgG2e+HG4EJ9k/2MYPc
 mgWugaypDIvUsIWsvJe0EWNwJEumIl5FFoIWLQ+SnpnqLRO4TJ/3/h0fn06KtGV38Ps+o
 4Cf6Y9f+58DSWzBkt51xKYgD4t5mwM6VfQkEe6BcY/NThiTRoBvwMc14t0vaU7FOBOGGt
 YmHCP6Sxv62ngSmlPoPpt8YKRsJJEorGEqfbHexlFJRt+NoRECAAMZH3uoEyKcXxUxQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=126.com; 
 dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=jO4yRh+f; 
 arc=none smtp.remote-ip=117.135.210.6
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.6;
 helo=m16.mail.126.com; envelope-from=xiaolinkui@126.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=126.com header.i=@126.com
 header.a=rsa-sha256 header.s=s110527 header.b=jO4yRh+f
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DEA3340059
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 12:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ah
 VlIdyB2pGt2fs06BKIwmR0kp8M62CgCW63wZLTG2A=; b=jO4yRh+fjuK5C8rkAz
 qpP0X7vUNu8tufZChwjsZz8adIQBSym68vNUi3sJvpgyDn15d6wzj8WKQyVhZax5
 m0uK9CbmzbuKdx5WVyIWnTt4mnHphW/mfLzawDMPGFgJIuoChLDKHCgiUh82M9oL
 oVr+Pjjsx867rPowaNpuD6vBk=
Received: from localhost.localdomain (unknown [])
 by gzsmtp4 (Coremail) with SMTP id PykvCgD3v8NWk8dqh6CpBA--.7046S3;
 Thu, 08 Oct 2026 20:58:00 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>,
 stable@vger.kernel.org
Subject: [PATCH iwl-net v3 1/3] ice: attach and detach VF representors outside
 of vf->cfg_lock
Date: Thu,  8 Oct 2026 20:57:52 +0800
Message-Id: <20261008125754.3520773-2-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261008125754.3520773-1-xiaolinkui@126.com>
References: <20261008125754.3520773-1-xiaolinkui@126.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PykvCgD3v8NWk8dqh6CpBA--.7046S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3AFW8Cr43Aw1fGw4DAr4fKrg_yoW7ZFWDpa
 yvqFy5Krn5Xa1xW3y5uw48Zrn8uayrKFy5Gr1xGF4Fkan8Gr17Zry3Kay2qry8G397AFya
 yF4Durn5uFZ8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j1JP_UUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqRiHXmrHk1hkdgAA3c
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

ice_free_vfs() and ice_reset_all_vfs() call ice_eswitch_detach_vf()
and ice_eswitch_attach_vf() with vf->cfg_lock held. Both take the
devlink instance lock and then register or unregister the representor
netdev, which takes RTNL. That gives

	cfg_lock -> devlink instance lock -> RTNL

while three other paths take cfg_lock with RTNL already held:

  - __ice_set_vf_mac(), from ndo_set_vf_mac()
  - ice_set_vf_port_vlan(), from ndo_set_vf_vlan()
  - ice_repr_ethtool_reset(), via ice_reset_vf() with
    ICE_VF_RESET_LOCK

which is the opposite order, RTNL -> cfg_lock. An "ip link set ... vf
N mac" on one CPU against "echo 0 > sriov_numvfs" or a PF reset on
another can therefore deadlock.

Move the detach and the attach outside of cfg_lock. Representors are
created and removed under pf->vfs.table_lock only, which both callers
already hold, and ice_start_vfs() attaches without cfg_lock too.
Nothing that the detach reads is torn down by moving it: repr->src_vsi
still points at the VF VSI, which is only released later, under
cfg_lock.

Both callers raise ICE_VF_DIS in pf->state before entering the loop,
so a reset that starts after that leaves through ice_is_vf_disabled()
before it reaches ice_eswitch_update_repr(), and
ice_check_vf_ready_for_cfg() keeps the ndo handlers and the ethtool
reset away as well. ICE_VF_DIS does not cover a reset that is already
inside cfg_lock when the loop gets there, so take cfg_lock once before
the detach to wait that one out while its representor is still
attached. Without the wait it could xa_load() the representor that
ice_repr_destroy() is freeing, and that is free_netdev() + kfree(),
with no RCU grace period in between.

In ice_reset_all_vfs() the attach moves after mutex_unlock(), so the
"VSI rebuild failed" path still leaves the VF detached, exactly as it
did before.

Found by code inspection of the VF setup and teardown paths; the same
inversion has also been hit out of tree. It was not triggered here
and no stack trace was captured. Compile-tested only, not run on
hardware.

Fixes: fff292b47ac1 ("ice: add VF representors one by one")
Fixes: c9663f79cd82 ("ice: adjust switchdev rebuild path")
Cc: stable@vger.kernel.org
Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
Changes in v3:
- New patch. Move the ice_eswitch_detach_vf() and ice_eswitch_attach_vf() calls
  in ice_free_vfs() and ice_reset_all_vfs() out of vf->cfg_lock, which is where
  the inversion is: both take the devlink instance lock and then RTNL, while
  ndo_set_vf_mac(), ndo_set_vf_vlan() and the representor ethtool reset take
  vf->cfg_lock with RTNL already held.
  (Przemek Kitszel)
- Take cfg_lock once before the detach as well, so that a reset that is already
  inside the lock is waited out instead of being left with a window between the
  detach and the lock acquisition that follows it.
- Include how the issue was found, that it has not been triggered, and that the
  change is compile tested only, as netdev-bot asked for.
 drivers/net/ethernet/intel/ice/ice_sriov.c  | 12 ++++++++++++
 drivers/net/ethernet/intel/ice/ice_vf_lib.c | 16 ++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index e04de0215596..471c1e29a865 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -154,9 +154,21 @@ void ice_free_vfs(struct ice_pf *pf)
 	mutex_lock(&vfs->table_lock);
 
 	ice_for_each_vf(pf, bkt, vf) {
+		/* Detach the representor before cfg_lock: it takes the
+		 * devlink instance lock and then RTNL, while
+		 * __ice_set_vf_mac(), ice_set_vf_port_vlan() and the
+		 * representor ethtool reset take cfg_lock under RTNL.
+		 * Take cfg_lock once ahead of it to wait out a reset that
+		 * is already inside the lock; ICE_VF_DIS, raised above,
+		 * keeps later ones out.
+		 */
 		mutex_lock(&vf->cfg_lock);
+		mutex_unlock(&vf->cfg_lock);
 
 		ice_eswitch_detach_vf(pf, vf);
+
+		mutex_lock(&vf->cfg_lock);
+
 		ice_dis_vf_qs(vf);
 		ice_virt_free_irqs(pf, vf->first_vector_idx, vf->num_msix);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index a54cb2b8d3c7..b91eec0adf51 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -789,9 +789,21 @@ void ice_reset_all_vfs(struct ice_pf *pf)
 
 	/* free VF resources to begin resetting the VSI state */
 	ice_for_each_vf(pf, bkt, vf) {
+		/* Detach the representor before cfg_lock and attach it after
+		 * releasing it again: both take the devlink instance lock and
+		 * then RTNL, while __ice_set_vf_mac(), ice_set_vf_port_vlan()
+		 * and the representor ethtool reset take cfg_lock under RTNL.
+		 * Take cfg_lock once ahead of the detach to wait out a reset
+		 * that is already inside the lock; ICE_VF_DIS, raised above,
+		 * keeps later ones out.
+		 */
 		mutex_lock(&vf->cfg_lock);
+		mutex_unlock(&vf->cfg_lock);
 
 		ice_eswitch_detach_vf(pf, vf);
+
+		mutex_lock(&vf->cfg_lock);
+
 		vf->driver_caps = 0;
 		ice_vc_set_default_allowlist(vf);
 
@@ -812,10 +824,10 @@ void ice_reset_all_vfs(struct ice_pf *pf)
 		}
 		ice_vf_post_vsi_rebuild(vf);
 
+		mutex_unlock(&vf->cfg_lock);
+
 		if (ice_is_eswitch_mode_switchdev(pf))
 			ice_eswitch_attach_vf(pf, vf);
-
-		mutex_unlock(&vf->cfg_lock);
 	}
 
 	ice_flush(hw);
-- 
2.25.1

