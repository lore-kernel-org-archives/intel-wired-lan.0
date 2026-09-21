Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 368D0C982EA
	for <intel-wired-lan@archiver.kernel.org>; Mon, 21 Sep 2026 03:17:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BEB4B6065A;
	Mon, 21 Sep 2026 03:17:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tbHp_XU4xDrR; Mon, 21 Sep 2026 03:17:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C73D560628
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789960620;
	b=oLHESKImFx5eIRPXe1mQZLfoi7C9B6oQFbirjYP9mGvg9gxBv4cVs4g8n0iZ+Oy2//wi
	 1bO7IjPmdoyx48Xh7NB/d2cn/kY89R4WjbDzlnYIoWuPaViMy+osJbSFNgpk/CfXxhiPj
	 6GP1eVMgyfsXsKym9md01NkdlpRML50VbeMeL+N+6j/3xqg0zlshs/+j+9R5Lf4nnQf3h
	 btibjEmPMAoPN6WQiIB7vvddaQM4IyE42H/7VAxMoWuVDXAibRYEg4P5soaeAioQRmfZk
	 9z7+Or8Pvy9GUXuv5fw5grX6MkD7ZrZlLoCVS8fjHx7fdoTy3wSVH4qm4cwSL7Cy23w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789960620;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=I7fYR/PDwkxcuXTwn2JWJPrIY5xxFViS+7lj7SyyQ5o=;
	b=HrG7EN7c2bP0ET2Jh6rZPGfYeUblWFgs4DnthoqJAfi6g+BNUEaLa/T/xmFMmz9lZSUl
	 tb3KkmSIqeZwppP+bgTWNRIQypDjysaESdUCiCu9etK/nY7lDaWnk8crErDBbpVIZfBxh
	 JX4xfcGSBgWz1WXAVhveZi+R7Y+1cEAj7m5Q5bRRSUjcFTkV5AFDIWU2H/ZT/eRao7HM6
	 LM2+fhmCQY/gJauRK8Na0mk/2Ca159Yhws/tqZhOlbzkqstI/Vy1hhS9Z4hm0CiN3P8+b
	 GNJ5w187n3ZEVdvy2Dm/yr4ZrSYiIe+QkrBI2bdq3bTnPwAQNlEJ96i2eNdoXsYRM6Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789960620;
	bh=I7fYR/PDwkxcuXTwn2JWJPrIY5xxFViS+7lj7SyyQ5o=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fJBV/qJxlbWpcQoWeNSFYX26mq11vDH1kXyMsAsxUnqGewS6xBwxt3mEJAUc2h84k
	 KSfJ5onJWsYS6QhdQpWumvMJOkAkRp7hkZVW1JQVV9Gg1ScZy8FNsCbzKHlkCg/ALz
	 p0oDRXtX6gsdxXSRLWlq7P3Oqx0B0DX9fWZbnYRfIoVs1O0vR/QGxEwNznP1zZJBsH
	 ZL+lCLaxZ/F8KPnJ8YE/wBcu713SOe9Kq8V0JyySlWYbRmm7BhVBkhiOp9yN4ike/6
	 zyfl2zu15Bz1zwVfBMshcmFCGmbORaq3Gkfsgocq8T5V1kLhMGb0BUnHMCQjRA+r6I
	 9ZhWP+2QXl/Xg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C73D560628;
	Mon, 21 Sep 2026 03:17:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3AEFFFEA
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 03:16:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2B94380D8F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 03:16:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6pE54Nc8VWOR for <intel-wired-lan@lists.osuosl.org>;
 Mon, 21 Sep 2026 03:16:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0E72280D34
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=220.197.31.6
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789960618;
 b=WxUSVv/j6r5wDakDlqyoHFfKM/ecnR9B3Ns1a+DCl/jgWCsUhmEOTvCcjuKBIxADUccw
 yU0FvpjkNasGwRPJTyTZTpsTHoYISZ0xrzQAdkubRvcmSAtfp6QWr9qVTyxYV4AIIHtfX
 THC+CEGH3MJw1tezQavIyrTGm8A5weR5l2pBNrOgWaPMCZ/+q9vVQcg05rswyhDJaKnNS
 YM334fCHbTK4Mb6xTpAq3HJLLlFg08HC2RslTge7je/5C3o2mtrmI/t2kMUNDMs/6NIoA
 YEgujM2eTk9usg4Ii7eAf7WXgCvUARiLMGYZ7Qym/X5tCnOyXzMTUh0JQaS4WgZye6g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789960618;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
 bh=I7fYR/PDwkxcuXTwn2JWJPrIY5xxFViS+7lj7SyyQ5o=;
 b=sBFl6wHYjJgi+xDjvRKNwWDh83NvL9BLh/BhTRAfXu+KUug5zEB+aw3bA5G5EsTjNYaL
 Cfqc0arbkN6+uAMqcWPk2E4jzbjwZic+1ALNI6SOFMsjMMZw9LVGaNeeHJOuLE5Mhp1VT
 AGFxO8JUgG9k7zHyU+8ITSkRRICXDgd1mpQx5ksYqKrRN1N0FmkVZ9j7Cgohx64HzHYV+
 E2npFotIY+QG3ULH21Ak6krF4nniH2EksI/NYCBp9A59ujXAj+qmzEB/qcMdstQxLX6Lm
 tZnYfdvmjGeyz53XMDTUVw7aviL3OXoIG/7X2H3qHeDO3zydLsATJ4pN0P8nuqsBOIg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=126.com; 
 dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=E5Sxtr9m; 
 arc=none smtp.remote-ip=220.197.31.6
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.6;
 helo=m16.mail.126.com; envelope-from=xiaolinkui@126.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=E5Sxtr9m
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0E72280D34
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 03:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=I7
 fYR/PDwkxcuXTwn2JWJPrIY5xxFViS+7lj7SyyQ5o=; b=E5Sxtr9mv7TTHc9AAA
 LrEIXxnJfo5Yvkv5/6raj4FFU0qzpTX8CV3hMt9/4TRlCLMYlEDWB+t+kO4AErj3
 qiMPan3xkxQiW3rYzB7QwHnA9Nc69H+HueBKRJXjK8nA2hpSDqJYE0CBMJP3+7qq
 WZyGhI8NI2+JZG7rBdsHroXHo=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id
 _____wDnr6yCobBq+hKqBg--.25902S2; 
 Mon, 21 Sep 2026 11:16:19 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>,
 stable@vger.kernel.org
Subject: [PATCH net] ice: detach the VF representor when ice_start_vfs() fails
Date: Mon, 21 Sep 2026 11:16:16 +0800
Message-Id: <20260921031616.3390259-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDnr6yCobBq+hKqBg--.25902S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFy7Jw4kAF4DZF45GF17ZFb_yoW5Xw4rpr
 Wvq34rGr4kJ3Wagw4Dua18u34ruayrCrWagr10k3WfCF45Jr9Ykr47KFy2yr18C3s7Cr1a
 va1q9r1ru34DA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UYzuZUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqQNPJmqwoYNTJQAA3N
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
VFs that were attached before the failure, and the caller, ice_ena_vfs(),
goes straight to ice_free_vf_entries(), which drops its reference to
every VF.

The port representors created for those VFs therefore outlive the
failed VF creation:

  - the representor netdev stays registered and its devlink port stays
    registered too. That port is embedded in struct ice_vf, so it ends
    up pointing into the memory that ice_sriov_free_vf() releases;

  - repr->vf keeps pointing at the freed struct ice_vf, and repr->src_vsi
    at the VF VSI that ice_vf_vsi_release() tore down. The leftover
    netdev is still visible to the user, so even a plain
    "ip -s link show" of it reaches ice_repr_get_stats64(), which calls
    repr->ops.ready() -> ice_check_vf_ready_for_cfg(repr->vf) and then
    reads repr->src_vsi through ice_update_eth_stats();

  - the virtchnl ops of that VF, which ice_repr_add_vf() replaced with
    ice_virtchnl_set_repr_ops(), are never handed back to
    ice_virtchnl_set_dflt_ops();

  - pf->eswitch.reprs never becomes empty, so ice_eswitch_detach() never
    calls ice_eswitch_disable_switchdev(). pf->eswitch.is_running stays
    true, with the bridge offloads and the devlink rate topology still
    up, and ice_eswitch_release_env() is skipped, so the uplink VSI is
    left in the switchdev configuration that ice_eswitch_setup_env()
    gave it.

Detach the representor in the teardown loop the way ice_free_vfs() does,
ahead of ice_vf_vsi_release(), because ice_repr_rem_vf() and
ice_eswitch_release_repr() both need repr->src_vsi to still be valid.
Every VF the teardown loop walks completed ice_eswitch_attach_vf()
successfully, and ice_eswitch_detach_vf() already returns early for a VF
without a representor, so no extra condition is needed.

Fixes: fff292b47ac1 ("ice: add VF representors one by one")
Cc: stable@vger.kernel.org
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index e04de0215596..1b563aba3bbd 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -508,6 +508,7 @@ static int ice_start_vfs(struct ice_pf *pf)
 		if (it_cnt == 0)
 			break;
 
+		ice_eswitch_detach_vf(pf, vf);
 		ice_dis_vf_mappings(vf);
 		ice_vf_vsi_release(vf);
 		it_cnt--;
-- 
2.25.1

