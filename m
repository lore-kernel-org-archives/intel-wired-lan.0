Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0178C982D0
	for <intel-wired-lan@archiver.kernel.org>; Sun, 20 Sep 2026 06:48:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 59BD860614;
	Sun, 20 Sep 2026 06:48:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aW5Nzq9TYy87; Sun, 20 Sep 2026 06:48:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B48116064F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789886921;
	b=QsGRDEArBeiuesXIIAV1nqNUd8f+hDsfZfr67sG8XQybGKn3WQQ+I3FkgNLskVW6J2p9
	 ljFEqnhdt4RVDaETlKH/GX2NvbYBx5oLeogdK+fOptFWRQAD1Oo+kIIUjavQ6K4EHAwX3
	 jH0xeUfbhzs6HfX3UKixagSX5sxemIp8/SFbQYHN2RI/h+fYzRNbX7jjNvpk/xn9MLmeH
	 QaI+F5MFhCMpGM47mmeYcHbUu5WcyAFGTstNM1aKCT7TQ0miCFxEq3gTbwHAIdf5ktrKo
	 oibQPtrerRwf311+3HXGdpghYf1uzb82SrYlp5YoF4j1I11pdPreDpkws0i6N+b/8Dw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789886921;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xnnrjYHteaJiELISGRVvsK99/RZqA1Xfx28O81X6+Is=;
	b=Tf7NfbUDsXiE+R+iTtq9njYXMG+7oVLoxBug2Yfr1PV6ebhCSRzSZ4zZeLaHSRYdNDch
	 PhrSY8udyUA40lylVvfxJCMxrOV5Sikj3VBrMCCSGrQNLgwAZNIPXZS6J/m0nljgNOQhz
	 AVNiX7N/5f6Pf7bFBOLCV5nC8n1t9clXaiw5EjbfKWPl1UUEjdL7qn/OR7gn7ReeTD0Wy
	 VOEx3/IshYpQnuvZRFbCNcBZQImnDRZOXxeqZJwjmuGKpmBo45+rzZ4SFooLnIkqqpeNY
	 36B9HT/rZ9GdFgqOQhilyaMjgY9uNoTWJT99XsCScnsn62owLLazH1+E+UU9m7gey5Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789886921;
	bh=xnnrjYHteaJiELISGRVvsK99/RZqA1Xfx28O81X6+Is=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=X2okzrHT69fUVem5eCHKGd7ghF6cArwjbqBM4xHVBsXSYA2s2hxr8wMPwfvmii8oF
	 XKG8nJWZWQistcUzkwfSbdTu4s3KmEIEQIzps5RUjQYhHW2GoY2o1gjvlnU3jrtnLT
	 YJUuiHBjX4LCfitX+8/rLPCgAVNK42oan7acX7zvDA3vg/i4BtPd25NUO1rovDAGnX
	 gh5u8re09hLF1lxJ0VACLi2XjYa9jAnr3C4kEgsn4nQzim4Mzaig/b5dJmiZPhXUI1
	 yXDqVH9YaYYzAhD3RG7fQqIAAJyxPLK8WEAowN+4P8nCxVZtgUfFB4ehZs49nfH9RO
	 7o9omxWtjHBuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B48116064F;
	Sun, 20 Sep 2026 06:48:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DB9CA13D
 for <intel-wired-lan@lists.osuosl.org>; Sun, 20 Sep 2026 06:48:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C1A574065F
 for <intel-wired-lan@lists.osuosl.org>; Sun, 20 Sep 2026 06:48:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4S4R48CtqGFB for <intel-wired-lan@lists.osuosl.org>;
 Sun, 20 Sep 2026 06:48:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0FD0940659
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=220.197.31.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789886919;
 b=oZqIahNQ6j4L2r3tiBaF6WVYnkg/Lx7GPZPHBqdTlx3WbHTEJ8m8n7wjCcvhK+ADBOZv
 +kH8ku4X5QAl7RGIQAk2TyjM8le9EGf/MOMk9G08Gzu7R1nkBt2HmPel4/59ckV4eCliF
 OPoaXtGIa3tL4w1pzCJkt5auSavT1voo4pMrcpf5OPltGF1QFlWFsk5bBXj1UtTTe4/Fc
 Oru8/YL9AJgS72ZxtcZJlHBD+ioLAgRB7sm/GoeRG9afA8uRz3AuYsc6eIsoxySp7wUKE
 BW76V6TAqyVva0HjuD/UXEw+ob0xcpVGZUtpXYVELlbRBXODHLiXi7+CVsAlQQ1CgYg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789886919;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
 bh=xnnrjYHteaJiELISGRVvsK99/RZqA1Xfx28O81X6+Is=;
 b=WTBGT1mOh0HUZmnJqOtoebF3IFo1eFqBOM8dDf4oE2ZnPKR402bMmHsZpqwZPNuxmBPs
 ur5tmryJYfu7vBq67jUEfsPGvSVpaJTnC6FIPW8vm8848tNbdbexTU+pFEQMaVeIEegwC
 K6byIPJ78lIrEQgUQdGy2WbG5JRylEaeLTne00LWQRmHPKKSmgdN4HN3tvMvNleIDDhh6
 hhRr+c6m5PBaMUJndomX+iAqC7LEgBfnJxtGsqiAo0DjKdEGGcEpd3vT4Jhp++EerZwIG
 U7rnhzUlWh2GoVjq+wWmmW5eUlJoL1IG9pgBTkiJt2Wv7OUeORgShxPnQGf+xYBwGnQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=126.com; 
 dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=bDeDEz6o; 
 arc=none smtp.remote-ip=220.197.31.9
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.9;
 helo=m16.mail.126.com; envelope-from=xiaolinkui@126.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=126.com header.i=@126.com
 header.a=rsa-sha256 header.s=s110527 header.b=bDeDEz6o
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0FD0940659
 for <intel-wired-lan@lists.osuosl.org>; Sun, 20 Sep 2026 06:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=xn
 nrjYHteaJiELISGRVvsK99/RZqA1Xfx28O81X6+Is=; b=bDeDEz6oGiGVgjsWkd
 n4s2Ilyj6sRYaNugFzc6W2sq1M15z5Z1nGuLnXuGpW/iGGccEsUQN0MZOeHsLb69
 KHLzwvwV4Gszrzuedp6ZTnXfLMnfi//5k9EYFGOnll+4Bpyl/25131c/Whc3dsqa
 hU5EPdmljeksYdW2D+fbQIeh0=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id
 _____wD3j5Kbga9q9QbHBw--.42328S2; 
 Sun, 20 Sep 2026 14:47:56 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>,
 stable@vger.kernel.org
Subject: [Intel-wired-lan] [PATCH net] ice: roll back the port VLAN when
 ice_eswitch_br_set_pvid() fails
Date: Sun, 20 Sep 2026 14:47:54 +0800
Message-Id: <20260920064754.1935818-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3j5Kbga9q9QbHBw--.42328S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFWruryUuw1UAr15ArW5Jrb_yoW5Xry7pF
 WqkF90krWkXF4Ygw1qga10yr45Jay8ZrW0gr97K395Aw45Ar9aqrW7KF9FvryUZr1xJa4a
 vw1DCr1DCwn8Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UlhFsUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlR0O5GqvgZ10xQAA3K
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

ice_eswitch_br_set_pvid() puts the VF VSI into port VLAN mode with
ice_vf_vsi_enable_port_vlan() before it programs the port VLAN itself.
Both error paths below that point return the error code straight away,
so nothing is undone when set_port_vlan() or add_vlan() fails.

The stale port VLAN is the more visible half of the problem.
set_port_vlan() turns on Rx VLAN pruning in the VSI context and relies
on the add_vlan() call right after it to install the matching prune
filter, so a failing add_vlan() leaves the VF VSI pruning away every
packet it receives, while port->pvid stays 0 and the bridge is told the
VLAN was not offloaded.

The VLAN ops table is never restored either.
ice_vf_vsi_disable_port_vlan() is only ever called from
ice_eswitch_br_clear_pvid(), which is reached from
ice_eswitch_br_vlan_cleanup() only when port->pvid matches the VLAN
being removed. Neither the failed VLAN, which was never inserted into
port->vlans, nor a port->pvid value ever got that far, so the VSI keeps
the port VLAN flavour of its inner and outer vlan_ops until the VF VSI 
is rebuilt:
dis_rx_filtering() turns into a no-op and, in Double VLAN Mode, the
inner add_vlan() and del_vlan() stop doing anything.

Unwind both steps the way ice_eswitch_br_clear_pvid() does: clear the
port VLAN from the VSI context when it was already programmed, then
hand the VLAN ops back to ice_port_vlan_off().

Fixes: 2946204b3fa8 ("ice: implement bridge port vlan")
Cc: stable@vger.kernel.org
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 drivers/net/ethernet/intel/ice/ice_eswitch_br.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
index 1d8a6b95ccda..53ce98ba7007 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
@@ -679,16 +679,23 @@ ice_eswitch_br_set_pvid(struct ice_esw_br_port *port,
 	vlan_ops = ice_get_compat_vsi_vlan_ops(port->vsi);
 	err = vlan_ops->set_port_vlan(port->vsi, &port_vlan);
 	if (err)
-		return err;
+		goto err_disable_port_vlan;
 
 	err = vlan_ops->add_vlan(port->vsi, &port_vlan);
 	if (err)
-		return err;
+		goto err_clear_port_vlan;
 
 	ice_eswitch_br_port_vlans_flush(port);
 	port->pvid = vlan->vid;
 
 	return 0;
+
+err_clear_port_vlan:
+	vlan_ops->clear_port_vlan(port->vsi);
+err_disable_port_vlan:
+	ice_vf_vsi_disable_port_vlan(port->vsi);
+
+	return err;
 }
 
 static struct ice_esw_br_vlan *
-- 
2.25.1

