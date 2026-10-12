Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B31CA9ED1
	for <intel-wired-lan@archiver.kernel.org>; Mon, 12 Oct 2026 08:30:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA0B4605E0;
	Mon, 12 Oct 2026 08:30:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fY7HXKZCVU5L; Mon, 12 Oct 2026 08:30:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 363AA605F9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791793806;
	b=FT3edUPhfbfGpw7CJq7Gxq+b7YCjngHRxugFGQUESemoIpmS/qIAODHERYCt/c2gWL8k
	 MznyaKsMobTemrayQdUDqKbNFmas2RXh5bbqdfIaqNJIKOsV+19HUdWU2279uYvbzGbn1
	 C0H3/TyDvqBfnvhaPIh59KeaCBuUIGp8bFNqBbyFNCXrTx71W1t9zLvGIzwywGV/mxZGw
	 qXr8gKm7thiqnxGBNOibUZHwV5PDw7yVZvrwdgzei7VYEgq/eonu65AAw+Kwn59Rh9F7C
	 6GBiVywAGdSeFDw/qS7FVHlp/wgP9/LarIVMa+1tdepEd3T4RXIO3L+AwkBKrw2rLcw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791793806;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/arq3bSiNUhGTgx5pBQcL/wrpeLjPO31tz1LQ4YP/D4=;
	b=GuiNfKimzHfe+qHfyKCizpwDbI7Z2SmU2KH47gpDgPCvT9JtC4VCWLM8SWyNYgp0zlV9
	 GsQKpvo79hQQCEDDBJE8tdmW/Wp7QrvXH7BgPtJHHkdxz1J9fEjJBWo3bGT4EwQ395W5X
	 VHxvR0tFt85Pi5tHD6c+Eg0jOCwFHLe6c6IGXxtxmB5pzhHsrFWqxrwCfTTljKqWsjXde
	 04ROWtkWO1cDMwhNniAyccQwvK0rgJ9ryrBFLYaquIMldaS4MalmmI/zWRZ1eW6b0/LHD
	 XLnsM47JUf9mOLJ9mv6kPNoEQu0bAelUAGOdi/ESVbHp3SNaCYNxenpdLRJ894MPsJQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791793806;
	bh=/arq3bSiNUhGTgx5pBQcL/wrpeLjPO31tz1LQ4YP/D4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JrkJONmVL0qeEIJMIqtoRYl5sLTuyNoVGBQvuB2IeAA+u44M3INhMmCK0PBtN0qtr
	 8CKzsFMZJlQKyGb0V87WkUWxrh8lh8304tYWYGflfVKfSzwcZUeR6CF96F/uNcLBNp
	 3cH43CYNa3cunGnMueoRcqbYv0oblHDNYyL+CJBD1u9UqvGsKZA1ZDaTL+j/2CGwbM
	 7NueFqjPfgWssUdA2JuxlnBOYNt4IQfcMSLbE6Fj+FGruHc9Xb3BAkI0fvgiCSRvuZ
	 cXI/YFi/ReAQ7RnReuwa0DgEwp18u1/Sg2ti5OK8Wns7kt5ZYJE0gJvqszWjr12T29
	 S2xbEPmv/F2hw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 363AA605F9;
	Mon, 12 Oct 2026 08:30:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D9AA9DF
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 08:30:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7F40740024
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 08:30:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FPDCo6lLbu62 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 12 Oct 2026 08:30:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9B8FA4002B
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=117.135.210.8
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791793803;
 b=UXukRjSKwrqIdk6iab4uPtNLzI/loaF8KFTpei2D6roiGRTGiEEHvnHPfZtPLEhgL6YQ
 FHHwQ7FdOeiglRlaIDx1L/H0eJAYmlbDZyK/sgdUIzWAZg1Xaend0Ts4XPk6Z2dBu9tXN
 F2XmqOe00qM8wC36FVIPvRtoRcReVub4fvMdVIOxRlMu4V3GOsOmLDH2+egAQq3v2YfV8
 o6arS88gWp/3kQ/LNQlUWbm7Hyt7wma/+hOWZ2BY2CuGnXuO3GwnSbL8fcoPuT0DVpe1I
 zY6uyvbGp4SDxvggNxkDQuFiCTExiCDJpQ9k34g0CqA8f8y1Vo1GLfuckHh1eul3rdw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791793803;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
 bh=/arq3bSiNUhGTgx5pBQcL/wrpeLjPO31tz1LQ4YP/D4=;
 b=WZw0m1GyDm4ZXvsSvD60YuKcSPGway+iiFdVTb7mo9f6ScCtjDclWPgdlP8cS5hhlg3I
 lj05dfGZNN5kzc7V1xQpS5djT3mh35A6LiGS5yd8xGwXn5y9BvP/2rhhri5pwcKN1EziG
 Yq2v2YFNTJzrFK4gU0xqjwm4G/AKVdQeylcwPPMKX7MpakngPBwKUTRSubUOt3Kh3gBfa
 rGZgbTZV9XWCVBLZNC2nfM/W2e5yLFJcmvuoiSUpH19bdWWYjot95h6SZ43zG+B3nsyj5
 yOPwvA9mrTAcv8P7VJacfkZk1h3NtLQHXcMogCfLSMcZMK82ow3pA2Jt6KqSeXfilrQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=126.com;
 dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=MWJUXpCH; 
 arc=none smtp.remote-ip=117.135.210.8
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.8;
 helo=m16.mail.126.com; envelope-from=xiaolinkui@126.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=MWJUXpCH
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9B8FA4002B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 08:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/a
 rq3bSiNUhGTgx5pBQcL/wrpeLjPO31tz1LQ4YP/D4=; b=MWJUXpCH8MV8b2ZjXV
 T6V1yMhz/BkgyCoZfS27C7lmG/tmk4F2801CG27mceAPC/gDMhnBDdeecqLW/61X
 w3ZZlgVAkHW1vMZrGW8pRUwYIi5sJ18ATp3XP+t551w1x25JtAEbmXuAwQsdWKu1
 +1teoQolx0YcCAEsIFoSHC9fU=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id
 _____wD3NzBXmsxquD7DBA--.7129S2; 
 Mon, 12 Oct 2026 16:29:12 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [PATCH iwl-net] ice: do not report success for a VF setting that was
 not applied
Date: Mon, 12 Oct 2026 16:29:10 +0800
Message-Id: <20261012082910.283229-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3NzBXmsxquD7DBA--.7129S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFWUArW8tr4kJFyxCw45Wrg_yoWrtr1fpF
 Z5KFWqqr4DXF4I93sIgF4UZFWYka4FqFWUGr95GFyFkws8ArnYvFWFyrZFvFy8A3yxCa43
 tFsru34DuFyDWaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ULFxUUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlRiKYWrMmlh3xAAA3x
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

__ice_set_vf_mac(), ice_set_vf_trust() and ice_set_vf_port_vlan() all
check that the VF is ready for configuration, take vf->cfg_lock and then
call ice_reset_vf() to push the new setting into hardware. The result of
ice_reset_vf() is not looked at, and it could not be: it returns 0 both
when the reset ran and when it bailed out because the VF is disabled.

The check runs before the lock is taken, so a reset can disable the VF
in between. ice_reset_all_vfs() raises ICE_VF_DIS in pf->state before it
walks the VF table, rebuilds every VSI and clears the bit again. An
ndo_set_vf_mac() that passed ice_check_vf_ready_for_cfg() just before
that then waits for cfg_lock, stores the new address in vf->dev_lan_addr
and vf->hw_lan_addr and calls ice_reset_vf(), which sees the VF
disabled, stops its queues and returns 0 without reprogramming anything.
__ice_set_vf_mac() reports success, so ip link and the devlink port
function now show a MAC address the hardware never got, and the switch
keeps enforcing the previous one until something else resets the VF.

ice_set_vf_trust() and ice_set_vf_port_vlan() have the same shape: the
port VLAN lands in vf->port_vlan_info and the trust flag in vf->trusted
before the reset is skipped.

Re-check ice_is_vf_disabled() once cfg_lock is held and fail with
-EINVAL, the same code ice_check_vf_ready_for_cfg() returns for a
disabled VF. The VF is being reset or removed at that point, so the
caller should retry rather than be told the setting is in place.
Changing what ice_reset_vf() returns on that path is not an option, too
many callers rely on it meaning "nothing to do".

The race was found by code inspection of the ndo VF handlers, it was not
reproduced at runtime and no error message was observed.

Fixes: e6ba5273d4ed ("ice: Fix race conditions between virtchnl handling and VF ndo ops")
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index e04de0215596..de0631673149 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -1327,6 +1327,15 @@ int __ice_set_vf_mac(struct ice_pf *pf, u16 vf_id, const u8 *mac)
 
 	mutex_lock(&vf->cfg_lock);
 
+	/* The VF can have been disabled by a reset after the check above, and
+	 * ice_reset_vf() then skips the reprogram and still returns 0. Fail
+	 * here instead of reporting a MAC address that hardware never got.
+	 */
+	if (ice_is_vf_disabled(vf)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
 	/* VF is notified of its new MAC via the PF's response to the
 	 * VIRTCHNL_OP_GET_VF_RESOURCES message after the VF has been reset
 	 */
@@ -1345,6 +1354,8 @@ int __ice_set_vf_mac(struct ice_pf *pf, u16 vf_id, const u8 *mac)
 	}
 
 	ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
+
+out_unlock:
 	mutex_unlock(&vf->cfg_lock);
 
 out_put_vf:
@@ -1401,6 +1412,14 @@ int ice_set_vf_trust(struct net_device *netdev, int vf_id, bool trusted)
 
 	mutex_lock(&vf->cfg_lock);
 
+	/* See __ice_set_vf_mac(), the VF can have been disabled after the
+	 * check above and ice_reset_vf() would skip the reprogram.
+	 */
+	if (ice_is_vf_disabled(vf)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
 	while (!trusted && vf->num_mac_lldp)
 		ice_vf_update_mac_lldp_num(vf, ice_get_vf_vsi(vf), false);
 
@@ -1409,6 +1428,7 @@ int ice_set_vf_trust(struct net_device *netdev, int vf_id, bool trusted)
 	dev_info(ice_pf_to_dev(pf), "VF %u is now %strusted\n",
 		 vf_id, trusted ? "" : "un");
 
+out_unlock:
 	mutex_unlock(&vf->cfg_lock);
 
 out_put_vf:
@@ -1721,6 +1741,14 @@ ice_set_vf_port_vlan(struct net_device *netdev, int vf_id, u16 vlan_id, u8 qos,
 
 	mutex_lock(&vf->cfg_lock);
 
+	/* See __ice_set_vf_mac(), the VF can have been disabled after the
+	 * check above and ice_reset_vf() would skip the reprogram.
+	 */
+	if (ice_is_vf_disabled(vf)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
 	vf->port_vlan_info = ICE_VLAN(local_vlan_proto, vlan_id, qos);
 	if (ice_vf_is_port_vlan_ena(vf))
 		dev_info(dev, "Setting VLAN %u, QoS %u, TPID 0x%04x on VF %d\n",
@@ -1729,6 +1757,8 @@ ice_set_vf_port_vlan(struct net_device *netdev, int vf_id, u16 vlan_id, u8 qos,
 		dev_info(dev, "Clearing port VLAN on VF %d\n", vf_id);
 
 	ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
+
+out_unlock:
 	mutex_unlock(&vf->cfg_lock);
 
 out_put_vf:
-- 
2.25.1

