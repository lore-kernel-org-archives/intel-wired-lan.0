Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55844CA600B
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 12:58:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 236648115C;
	Thu,  8 Oct 2026 12:58:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FjSUlJXHRDgD; Thu,  8 Oct 2026 12:58:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4BF90811A8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791464335;
	b=FM9AB+7GfavZAPO13i+Md3Zf+OdE1CS/5aODueps09iUHU+Pm6y94tnYSXzMsQ5DRB8c
	 MACgFp9ENsbTyF0n6GWRV1E7+BBMlRGE2GI8VIAkZH4mR1SpPM3/tfcn0b5eKWAyxt4ew
	 KlPc5/tdXUDuDWzL7JMu2mg37ga1xmO+tevaAHbIyLtIHi7PaNptuQZ9qGqbbBjFmL5z7
	 CJ+JWP2pOo2GkULGNVcJRlSOkrG9vak1SWgeSLrp76gK41YCiPpT/wJpe4xvJUf38CKkh
	 UZ3PE8HepxU0IcOxPB+Br59SDfS/rP4izsIA/XrW522+5Ru8YcAF0Q98WTnImiU86Kw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791464335;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sv9Nz32IunShNXMIlQPyrxK/eryKBOVBKQ/L3Je5vIg=;
	b=MlDzDWuML9wYUy/JD4/mwmf0wBFlllDIC2XR18wXMpv8DNQzM3AICvuBRxHiMGc4kKrw
	 pxv9MQiMDNLwfOI3yEgX9VZ/kkkwObaTiWedAdJO+j6iz5pJO5f+wjZoNjQRI5CT/WdcD
	 44jjuo5wenwWlDG/UIyWUc0jT/HBWeU9hbRczUjLinkkfK/VwegC1ZHFM1BBgIdxuOqxF
	 oTH9C2RbBjcm8TnzaaclZ65pcm9dCXZBTWappUmuLuw5viiMgDWVSTiVFEiEambVbOB8v
	 iNspWLFs9hmAMAFcLWdAiHkmkCrxUK+8mQyNh3tmS1ojjuMYPzAF+P/UDHNprD7dnYA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791464335;
	bh=sv9Nz32IunShNXMIlQPyrxK/eryKBOVBKQ/L3Je5vIg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZU4wPorB2dJmPRL3wQHaY2riuhnu0g+fp1ys9dlxKd2gPXP54KnGlnQ65NZ69YcSJ
	 VsXkWPk+HO4DbDUAE/KYtmsg3z8idZZkMYtlcWmj21ZHO3GMJJDDJXS98h6IMG5BiU
	 Gk+92JQxgLEsbjiaHcIn2HrbMisxy6/9/J4td96LhWIR8rJGYwPdbmJQiMfNAr5ia0
	 nRFffhUO0vatsCvKWlQC6CIgR4XcSfagi5OqfsFLSw0kxP/vSpYFtHN0s1yiOWbbDk
	 XRu1qMRLcrXCV4rv2r/rijMoLL2RZvtiXJKlcLzI80BZrs+Sg9ukdlQ8RJ10lACZ1+
	 NIpeYnNwCzkdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4BF90811A8;
	Thu,  8 Oct 2026 12:58:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C01B21A6
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 12:58:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A668B6076D
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 12:58:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D7PFbjCb-KfI for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 12:58:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1FA4A6068B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=220.197.31.7
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791464332;
 b=ZYeG9L8En/8vWY+/WaGpJqvajv2EFnVpoJusi/61ilTHVyeKnKPLNSYlwGSfabkBDIZu
 m6HuXT4qSEN0qM4t/xitvZLoLOxbcDlxTwGdCJNNo2WJ4jcqbLFws/Vta8w1yIzw8wiEP
 Y3rTsX0vOAxljjfzfZlJdoiIOgAM28D15FWqz2vMDayP6OLaQZwIVm6WfGg7zkDYV83jG
 l1PstdUwTUsJspi6Ncy9guEOrpH7M94sYoZLxY+wuyXwsNp1Y5WVM1DQR4JAixVtoBrLm
 Z9B2dxljuuip4W+pU/IIsuo0ex1mcgNsO80B0jFG9uDPASQ+2/1vrtdJWfH3SI2eUhA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791464332;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
 bh=sv9Nz32IunShNXMIlQPyrxK/eryKBOVBKQ/L3Je5vIg=;
 b=UGLK/czBs2PbwwYq/9yZYMx9KwYNnxv3eU+j8xXcGfPDiYCAl+HZZN7Fekho37QLDr52
 0b0a4gTyI0FYz7b0Yft87Ks7ZV/09dBNNi10g+A2jnsZ9SgTlCC0v5PdpbyX/z5vq6TlY
 MK+J05Za4qG+Lx2Yc/JpbQL8qJjJpsqF6z+Keni2Ajq0bsl7NabM/gBIS72cooFcmusO6
 +o/mfVPFoOJlQ3rrrIZmONEOZAetNTkihhgrqmzHKJx4aEz0zBnPXTxUT3KtWnoR1X8HX
 rXd88BGq6QAMmcoBFo2ZOpilOCsY8fu+QXlKujR9vC08dJxHlzgXyCJKf13rnWte1Iw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=126.com; 
 dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=I3NNF9k+; 
 arc=none smtp.remote-ip=220.197.31.7
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.7;
 helo=m16.mail.126.com; envelope-from=xiaolinkui@126.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=126.com header.i=@126.com
 header.a=rsa-sha256 header.s=s110527 header.b=I3NNF9k+
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1FA4A6068B
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 12:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=sv
 9Nz32IunShNXMIlQPyrxK/eryKBOVBKQ/L3Je5vIg=; b=I3NNF9k+TpXz/MgOh6
 mZi8gBTJ1nwX+dtWMAiwb1vczdKrCfAVx+CeWMpiZD4BUNJt6R6JRp+QmVsvaQzE
 gKCFtNfqVbMtE6RrGa8EspgL96d0AZ/5fnBMiHdasPYSCsjeDNt+fzCfi2fTXx/H
 t8uvcoVa0uu03P6TUp8y1x0VA=
Received: from localhost.localdomain (unknown [])
 by gzsmtp4 (Coremail) with SMTP id PykvCgD3v8NWk8dqh6CpBA--.7046S2;
 Thu, 08 Oct 2026 20:57:58 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [PATCH iwl-net v3 0/3] ice: fix VF representor lock ordering and
 teardown error paths
Date: Thu,  8 Oct 2026 20:57:51 +0800
Message-Id: <20261008125754.3520773-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PykvCgD3v8NWk8dqh6CpBA--.7046S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuFy7Cr17Gw1xKr45Zr4kCrg_yoW5uFW8pr
 ZYqw1rKr4kXFyIg3y3Zw18t3WF9a1rKFyUGr1jgrW5C3Z8Gry8Xr47K3y2934jyws3Aa4a
 vrs0qrykuFyDAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ULFxUUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqRaGXWrHk1ZkYAAA3I
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

Patch 1 moves the ice_eswitch_detach_vf() and ice_eswitch_attach_vf()
calls in ice_free_vfs() and ice_reset_all_vfs() out of vf->cfg_lock.
Both take the devlink instance lock and RTNL through the representor
netdev, while ndo_set_vf_mac(), ndo_set_vf_vlan() and the representor's
ethtool reset take vf->cfg_lock with RTNL already held, so cfg_lock ->
RTNL against RTNL -> cfg_lock is an inversion; that is the AB-BA
Sashiko reported. The detach is preceded by a single cfg_lock
acquisition, which waits out a reset that is already inside the lock:
ICE_VF_DIS, raised before both loops, keeps later ones out but not one
that got in ahead of it, and that one can reach
ice_eswitch_update_repr() on a representor that is being freed with
free_netdev() + kfree(), with no RCU grace period in between.

Patch 2 does the same for the teardown loop in ice_start_vfs(), which
in addition never detaches the representors it attached before the
failure. That path does not set ICE_VF_DIS and the VFs it unwinds
already reached ICE_VF_STATE_INIT, so vf->cfg_lock is still needed
around ice_dis_vf_mappings() and ice_vf_vsi_release(): the
ice_check_vf_ready_for_cfg() test runs before the lock is taken and
cannot keep out "ip link set dev <pf> vf N ...". The patch marks the
VF disabled under cfg_lock before the detach, which also waits out an
ice_reset_vf() that is already inside the lock.

Patch 3 gives back the MSI-X window that ice_init_vf_vsi_res()
reserves and that none of its error paths releases.

Representors are created and destroyed only under pf->vfs.table_lock,
so the detach does not need vf->cfg_lock to stay safe against other PF
operations, and all three functions are called with that lock held.

The three issues were found by manual code inspection; none of them
was triggered at runtime, and the series is compile tested only, with
no hardware test.

Changes in v3:
- New patch 1: move the detach/attach calls in ice_free_vfs() and
  ice_reset_all_vfs() out of vf->cfg_lock, and take cfg_lock once before
  the detach so that a reset which is already inside it is waited out.
  (Przemek Kitszel)
- Patch 2: detach the representor outside vf->cfg_lock, and mark the VF
  disabled under cfg_lock before the detach.
  (Przemek Kitszel, Sashiko AI review)
- Patch 3: correct the Fixes: tag to 4d38cb44bd32, which replaced the
  computed first vector index with a reservation from the bitmap and left
  the error paths below it unchanged; commit a203163274a4 ("ice: simplify
  VF MSI-X managing") only renamed that helper.
- Add the information netdev-bot asked for to the commit messages.
- Drop the Reviewed-by tags from Tomasz Lichwala and Aleksandr Loktionov:
  patch 2 changed code again, and the hunk in patch 3's teardown loop
  moved inside vf->cfg_lock.

---
Link: https://lore.kernel.org/netdev/20260928065306.1514795-1-xiaolinkui@126.com/

Linkui Xiao (3):
  ice: attach and detach VF representors outside of vf->cfg_lock
  ice: detach the VF representor when ice_start_vfs() fails
  ice: free the VF MSI-X vectors when VF start fails

 drivers/net/ethernet/intel/ice/ice_sriov.c  | 42 ++++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c | 16 +++++++-
 2 files changed, 54 insertions(+), 4 deletions(-)

-- 
2.25.1

