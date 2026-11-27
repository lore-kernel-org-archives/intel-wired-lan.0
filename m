Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76146606A323
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Nov 2026 08:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=byhcczc1;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MqGQPoM3
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 59C8080E45;
	Fri, 27 Nov 2026 08:58:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wuEYQdLaErBM; Fri, 27 Nov 2026 08:58:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 16B8D811FA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795769886;
	b=rRc/86RVLDbAofe9oRHjS+j1h+nfovQHmf4TJXRnKP5NS5FJJ5IyLs1uXdIPq38LI9er
	 2+1luLxRZr4CQQvPou3IisrhOUCJoUm9bdp0N8R9xa8bJQ+VlqwDE2DGjnaK8Uo+k73CB
	 pgj2n2IfSTS0PDIb8Eu1MqlfERZZ/7Oyvw1aBr5tatZCxVDYEw7SgSHI6gtr2k/1eg5ZB
	 AC5vIbIzpwntC14nk7S5lC3+DAkMd/r06A5Izmcg6kPTs2DfrTXpHwkb2ysgU9HVDkidP
	 bKUKIpNTRplxfH5SWRF11iws6WToTFEV/1FcRCh0npG+4/XXE1pEyocHvzJRWF/Wxyw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795769886;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2j8ifMVRlSo3mopi2EWSAjV4LqxvVKQKGhHs1B/SQio=;
	b=cMse/pYSG+T3Yx2aZ3w2emtfD/R3TmJ1ZtI+6Co2Z8dsA7JN3DUlDW4rmI85/Ck8pBGq
	 kiL8tIV4Z/KeCCojQZ4klFyJeedzdTnaQJtH0K3/nXwxT3dkmMmXGPQGL4rnehkzL8JpJ
	 hO50VaxAUcsmwKcvIcrhWCP9IYnvIEUdbGhOolcCD9QW/GOUf/GGqjF0Haqs2zoGUBkmy
	 wT4oPbdvZzR7JqrY+kCtN18qb/6bhUSdrUXTvZu88R4BgCwfbe6u80OdBU+f44qlCK++c
	 WSdw2enEdCWvh7guuFtdlA09/p1SB2XmobItqhzzGmG4Fc3HL1A5Luqrg3E0IdwUQlg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MqGQPoM3;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795769886;
	bh=2j8ifMVRlSo3mopi2EWSAjV4LqxvVKQKGhHs1B/SQio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=byhcczc1jQrMjhN+fmqCEUx6sFVCPaJoiZDwbml3/UDPhrOtM/cEBjd/Rx2GvS2Ko
	 4ReWhsYz3XHgE/MkRPsWDh9BOx5MO4T3baJakcdkfmlDWBue7d/A8WMzd70eVw/uxN
	 IwNUOakJw4RFzBHLCmyLg+fBwNj41E3mNMIMuhBdq19PK9c1r325/EycI/z1HaJabk
	 H6eJ9kwc8DOyyboQc6143B8O8k6lGKsWZxMaz1EmWfG79DURUYHnO/2Zx+TkL1uAxi
	 o2axtjoHha2MF4Jbwh/pbIyLzkzrXzyrsmZYZA6oKJmu0d9VvdM2Ne9JLfI0WTENZb
	 RYugKsKIyxHOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 16B8D811FA;
	Fri, 27 Nov 2026 08:58:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7ED2B311
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 08:58:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 63CDB80E45
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 08:58:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6qKZv-BsB9b0 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Nov 2026 08:58:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E636F811FA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MqGQPoM3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E636F811FA
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 08:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795769881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2j8ifMVRlSo3mopi2EWSAjV4LqxvVKQKGhHs1B/SQio=;
 b=MqGQPoM37xsrTl0olBxvBRj+YJmQPUFtGsmjGVOn/SXDQPbylcr4krQflNieTvjNK0P/Dq
 kYv6FuEVcYtc8Jve4UVeaTlxXUoMeCQsxQTW9DHSzyDwocVvcaPreva4fDqZ8dNrfIiKsW
 aprKPOWEjh1Og1+FWfOBhPwByBRfF1c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-JtZ597VVOYa0N4WQSKWePw-1; Fri,
 27 Nov 2026 08:57:55 +0000
X-MC-Unique: JtZ597VVOYa0N4WQSKWePw-1
X-Mimecast-MFC-AGG-ID: JtZ597VVOYa0N4WQSKWePw_1795769872
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D402A1955EB7; Fri, 27 Nov 2026 08:57:51 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com (unknown [10.44.48.12])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 945AE428; Fri, 27 Nov 2026 08:57:45 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Simon Horman <horms@kernel.org>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Grzegorz Nitka <grzegorz.nitka@intel.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>,
 Wojciech Drewek <wojciech.drewek@intel.com>,
 Marcin Szycik <marcin.szycik@linux.intel.com>,
 Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
 Ivan Vecera <ivecera@redhat.com>, Alice Michael <alice.michael@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Jesse Brandeburg <jbrandeb@kernel.org>,
 Patryk Holda <patryk.holda@intel.com>, Rinitha S <sx.rinitha@intel.com>,
 Aaron Ma <aaron.ma@canonical.com>, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH net v5 4/4] ice: use a VLAN agnostic multicast promisc rule
 pair for PF VSIs
Date: Fri, 27 Nov 2026 09:57:09 +0100
Message-ID: <20261127085714.1207361-5-poros@redhat.com>
In-Reply-To: <20261127085714.1207361-1-poros@redhat.com>
References: <20261127085714.1207361-1-poros@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: mQGkND0DlHWWqoukDEZJCI2BwDvj6yj16OymxS6ZCRc_1795769872
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

An allmulticast or promiscuous PF VSI with VLANs is subscribed to
multicast with an ICE_SW_LKUP_PROMISC_VLAN rule pair for every VID, and
each rule takes an entry of the switch lookup table (FLU), which has 32K
entries for all PFs of the device. A port of a vlan_filtering bridge is
allmulticast, so a wide trunk (vid 2-4094) over several such ports
overruns the table. Firmware then rejects Add Switch Rules with ENOSPC,
the trunk of the last port is only partly installed, and the default VSI
(DFLT) Rx rule fails to install when a port turns promiscuous:

  ice 0000:5c:00.1: Failed to set VSI 14 as the default forwarding
                    VSI, error -5
  ice 0000:5c:00.1 ens1f1: Error -5 setting default VSI 14 Rx rule

Subscribe PF VSIs with the VLAN agnostic pair (ICE_SW_LKUP_PROMISC, vid
0) only. Drop the per-VID handling from ice_vlan_rx_add_vid() and
ice_vlan_rx_kill_vid(), and stop clearing the multicast rules in
ice_eswitch_resync_uplink(), whose queued sync now reconciles them. The
pair matches multicast on every VLAN. VLAN pruning still limits what it
delivers to the VLANs of the VSI, and with pruning off, as for the DFLT
holder, it delivers on every VLAN. The subscription now follows
IFF_PROMISC and IFF_ALLMULTI in one place, so clearing allmulti no
longer unsubscribes a promiscuous VSI unless another VSI holds the DFLT
rule, and a failed DFLT install does not remove it before the retry.
ice_set_promisc() adds the Rx and the Tx rule one at a time, so a rule
left by an earlier failure does not keep the other one from being added.

A trusted VF that holds the DFLT rule no longer gets through it the
multicast on VLANs the PF is not a member of, because the promisc recipe
has a higher priority than the default one. It keeps what its own
multicast promisc rules match.

The overrun was observed on a machine in real use, and the allmulti
problem was found by the Sashiko review of v4. The overrun reproduces on
an E810-C (FW 8.1.1, ICE COMMS package 1.3.55.0) without kernel changes:

  for p in $P0 $P2 $P3; do
          ip link add br-$p type bridge vlan_filtering 1
          ip link set br-$p up
          ip link set $p master br-$p
          bridge vlan add vid 2-4094 dev $p
  done
  ip link set br-$P0 promisc on

With the per-VID pairs a trunked port took 12292 FLU entries, the third
bridge vlan add failed part way and the promisc on logged the errors
above. With this patch a trunked port takes 4104 entries, all three
trunks fit with 20387 of the 32768 entries free, and the DFLT rule
installs. The FLU numbers come from a test-only debugfs file that issues
Get Resource Allocation (AQ 0x0204). Also tested with multicast to
joined and unjoined groups on member and non-member VLANs, with promisc
and allmulti changed in every order, with VLANs added and removed while
allmulticast, with a trusted promiscuous VF, and with the DFLT install
made to fail by a test-only change. No kernel selftests cover this.

Fixes: 1273f89578f2 ("ice: Fix broken IFF_ALLMULTI handling")
Fixes: 43fbca02c2dd ("ice: fix lost multicast packets in promisc mode")
Signed-off-by: Petr Oros <poros@redhat.com>
---
v5:
- Reworked after the Sashiko review of the v4 pull. PF VSIs now always
  use the VLAN agnostic multicast pair, and the per-VID multicast rules
  and their handling in ice_vlan_rx_add_vid() and ice_vlan_rx_kill_vid()
  are gone.
- The multicast subscription is reconciled from IFF_PROMISC and
  IFF_ALLMULTI in one place, so clearing allmulti keeps the subscription
  of a promiscuous VSI unless another VSI holds the DFLT rule.
- ice_set_promisc() adds the Rx and the Tx rule separately.
- New title, was "ice: skip per-VLAN promisc rules when default VSI Rx
  rule is set".
- Added the Fixes tag for 43fbca02c2dd.
- Dropped the Reviewed-by and Tested-by tags because of the rework.

v4: https://lore.kernel.org/all/20260708125755.706263-2-poros@redhat.com/
v3: https://lore.kernel.org/all/20260701133601.2118382-2-poros@redhat.com/
v2: https://lore.kernel.org/all/20260622113428.2565255-2-poros@redhat.com/
v1: https://lore.kernel.org/all/89efbea9831175e6f57e9fe8557f7a0e48e050b7.1781786935.git.poros@redhat.com/
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c |   8 -
 drivers/net/ethernet/intel/ice/ice_main.c    | 232 ++++++-------------
 2 files changed, 77 insertions(+), 163 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index d55c70edb7f7f6..5202c43fa969bd 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -20,14 +20,6 @@ static void ice_eswitch_resync_uplink(struct ice_vsi *uplink_vsi)
 
 	while (test_and_set_bit(ICE_CFG_BUSY, uplink_vsi->state))
 		usleep_range(1000, 2000);
-
-	/* VLAN changes during the session may have added these */
-	ice_fltr_clear_vlan_vsi_promisc(&pf->hw, uplink_vsi,
-					ICE_MCAST_VLAN_PROMISC_BITS);
-	ice_fltr_clear_vsi_promisc(&pf->hw, uplink_vsi->idx,
-				   ICE_MCAST_PROMISC_BITS, 0);
-	uplink_vsi->current_netdev_flags &= ~IFF_ALLMULTI;
-
 	clear_bit(ICE_VSI_ESWITCH_UPLINK, uplink_vsi->state);
 	set_bit(ICE_VSI_PROMISC_CHANGED, uplink_vsi->state);
 	set_bit(ICE_VSI_UMAC_FLTR_CHANGED, uplink_vsi->state);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 2ce2b7138f6682..ea6da46bf7955b 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -269,21 +269,18 @@ static bool ice_vsi_fltr_changed(struct ice_vsi *vsi)
  */
 static int ice_set_promisc(struct ice_vsi *vsi, u8 promisc_m)
 {
-	int status;
+	unsigned long bits = promisc_m;
+	int status, bit;
 
 	if (vsi->type != ICE_VSI_PF)
 		return 0;
 
-	if (ice_vsi_has_non_zero_vlans(vsi)) {
-		promisc_m |= (ICE_PROMISC_VLAN_RX | ICE_PROMISC_VLAN_TX);
-		status = ice_fltr_set_vlan_vsi_promisc(&vsi->back->hw, vsi,
-						       promisc_m);
-	} else {
+	for_each_set_bit(bit, &bits, BITS_PER_BYTE) {
 		status = ice_fltr_set_vsi_promisc(&vsi->back->hw, vsi->idx,
-						  promisc_m, 0);
+						  BIT(bit), 0);
+		if (status && status != -EEXIST)
+			return status;
 	}
-	if (status && status != -EEXIST)
-		return status;
 
 	netdev_dbg(vsi->netdev, "set promisc filter bits for VSI %i: 0x%x\n",
 		   vsi->vsi_num, promisc_m);
@@ -303,20 +300,30 @@ static int ice_clear_promisc(struct ice_vsi *vsi, u8 promisc_m)
 	if (vsi->type != ICE_VSI_PF)
 		return 0;
 
-	if (ice_vsi_has_non_zero_vlans(vsi)) {
-		promisc_m |= (ICE_PROMISC_VLAN_RX | ICE_PROMISC_VLAN_TX);
-		status = ice_fltr_clear_vlan_vsi_promisc(&vsi->back->hw, vsi,
-							 promisc_m);
-	} else {
-		status = ice_fltr_clear_vsi_promisc(&vsi->back->hw, vsi->idx,
-						    promisc_m, 0);
-	}
+	status = ice_fltr_clear_vsi_promisc(&vsi->back->hw, vsi->idx,
+					    promisc_m, 0);
 
 	netdev_dbg(vsi->netdev, "clear promisc filter bits for VSI %i: 0x%x\n",
 		   vsi->vsi_num, promisc_m);
 	return status;
 }
 
+/**
+ * ice_vsi_wants_mc_promisc - check if the VSI needs the multicast promisc rules
+ * @vsi: the VSI
+ *
+ * Return: true if the VSI needs the multicast promisc rules.
+ */
+static bool ice_vsi_wants_mc_promisc(struct ice_vsi *vsi)
+{
+	if (vsi->current_netdev_flags & IFF_ALLMULTI)
+		return true;
+	if (!(vsi->current_netdev_flags & IFF_PROMISC))
+		return false;
+	return ice_is_vsi_dflt_vsi(vsi) ||
+	       !ice_is_dflt_vsi_in_use(vsi->port_info);
+}
+
 /**
  * ice_vsi_sync_fltr - Update the VSI filter list to the HW
  * @vsi: ptr to the VSI
@@ -332,6 +339,8 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
 	struct ice_pf *pf = vsi->back;
 	struct ice_hw *hw = &pf->hw;
 	u32 changed_flags = 0;
+	bool dflt_err = false;
+	bool promisc_changed;
 	int err;
 
 	if (!vsi->netdev)
@@ -399,91 +408,65 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
 		goto exit;
 
 	/* check for changes in promiscuous modes */
-	if (changed_flags & IFF_ALLMULTI) {
-		if (vsi->current_netdev_flags & IFF_ALLMULTI) {
-			err = ice_set_promisc(vsi, ICE_MCAST_PROMISC_BITS);
-			if (err) {
-				vsi->current_netdev_flags &= ~IFF_ALLMULTI;
-				goto out_promisc;
-			}
-		} else {
-			/* !(vsi->current_netdev_flags & IFF_ALLMULTI) */
-			err = ice_clear_promisc(vsi, ICE_MCAST_PROMISC_BITS);
-			if (err) {
-				vsi->current_netdev_flags |= IFF_ALLMULTI;
-				goto out_promisc;
-			}
-		}
-	}
-
-	if (((changed_flags & IFF_PROMISC) || promisc_forced_on) ||
-	    test_bit(ICE_VSI_PROMISC_CHANGED, vsi->state)) {
-		clear_bit(ICE_VSI_PROMISC_CHANGED, vsi->state);
-		if (vsi->current_netdev_flags & IFF_PROMISC) {
-			/* Apply Rx filter rule to get traffic from wire */
-			if (!ice_is_dflt_vsi_in_use(vsi->port_info)) {
-				err = ice_set_dflt_vsi(vsi);
-				if (err && err != -EEXIST) {
-					netdev_err(netdev, "Error %d setting default VSI %i Rx rule\n",
-						   err, vsi->vsi_num);
-					vsi->current_netdev_flags &=
-						~IFF_PROMISC;
-					goto out_promisc;
-				}
+	promisc_changed = test_and_clear_bit(ICE_VSI_PROMISC_CHANGED,
+					     vsi->state);
+	if ((changed_flags & IFF_PROMISC) || promisc_forced_on)
+		promisc_changed = true;
+
+	if (promisc_changed && (vsi->current_netdev_flags & IFF_PROMISC)) {
+		/* Apply Rx filter rule to get traffic from wire */
+		if (!ice_is_dflt_vsi_in_use(vsi->port_info)) {
+			err = ice_set_dflt_vsi(vsi);
+			if (err && err != -EEXIST) {
+				netdev_err(netdev, "Error %d setting default VSI %i Rx rule\n",
+					   err, vsi->vsi_num);
+				vsi->current_netdev_flags &= ~IFF_PROMISC;
+				set_bit(ICE_VSI_PROMISC_CHANGED, vsi->state);
+				dflt_err = true;
+			} else {
 				err = 0;
 				vlan_ops->dis_rx_filtering(vsi);
-
-				/* promiscuous mode implies allmulticast so
-				 * that VSIs that are in promiscuous mode are
-				 * subscribed to multicast packets coming to
-				 * the port
-				 */
-				err = ice_set_promisc(vsi,
-						      ICE_MCAST_PROMISC_BITS);
-				if (err)
-					goto out_promisc;
-			} else if (ice_is_vsi_dflt_vsi(vsi)) {
-				/* still the default VSI, so subscribe it */
-				err = ice_set_promisc(vsi,
-						      ICE_MCAST_PROMISC_BITS);
-				if (err)
-					goto out_promisc;
 			}
-		} else {
-			/* Clear Rx filter to remove traffic from wire */
-			if (ice_is_vsi_dflt_vsi(vsi)) {
-				err = ice_clear_dflt_vsi(vsi);
-				if (err) {
-					netdev_err(netdev, "Error %d clearing default VSI %i Rx rule\n",
-						   err, vsi->vsi_num);
-					vsi->current_netdev_flags |=
-						IFF_PROMISC;
-					goto out_promisc;
-				}
+		}
+	} else if (promisc_changed) {
+		/* Clear Rx filter to remove traffic from wire */
+		if (ice_is_vsi_dflt_vsi(vsi)) {
+			err = ice_clear_dflt_vsi(vsi);
+			if (err) {
+				netdev_err(netdev, "Error %d clearing default VSI %i Rx rule\n",
+					   err, vsi->vsi_num);
+				vsi->current_netdev_flags |= IFF_PROMISC;
+				set_bit(ICE_VSI_PROMISC_CHANGED, vsi->state);
 			}
+		}
 
-			/* pruning can be off even without our DFLT rule */
-			if (vsi->netdev->features & NETIF_F_HW_VLAN_CTAG_FILTER)
-				vlan_ops->ena_rx_filtering(vsi);
-
-			/* disable allmulti here, but only if allmulti is not
-			 * still enabled for the netdev
-			 */
-			if (!(vsi->current_netdev_flags & IFF_ALLMULTI)) {
-				err = ice_clear_promisc(vsi,
-							ICE_MCAST_PROMISC_BITS);
-				if (err) {
-					netdev_err(netdev, "Error %d clearing multicast promiscuous on VSI %i\n",
-						   err, vsi->vsi_num);
-				}
-			}
+		/* pruning can be off even without our DFLT rule */
+		if (!(vsi->current_netdev_flags & IFF_PROMISC) &&
+		    vsi->netdev->features & NETIF_F_HW_VLAN_CTAG_FILTER)
+			vlan_ops->ena_rx_filtering(vsi);
+	}
+
+	/* promiscuous mode implies allmulticast */
+	if (promisc_changed || (changed_flags & IFF_ALLMULTI)) {
+		int mc_err = 0;
+
+		/* a failed DFLT install leaves the netdev promiscuous */
+		if (ice_vsi_wants_mc_promisc(vsi))
+			mc_err = ice_set_promisc(vsi, ICE_MCAST_PROMISC_BITS);
+		else if (!dflt_err)
+			mc_err = ice_clear_promisc(vsi, ICE_MCAST_PROMISC_BITS);
+		if (mc_err) {
+			netdev_err(netdev, "Error %d syncing multicast promiscuous on VSI %i\n",
+				   mc_err, vsi->vsi_num);
+			/* retried by the next sync, with the allmulti change */
+			vsi->current_netdev_flags ^=
+				changed_flags & IFF_ALLMULTI;
+			set_bit(ICE_VSI_PROMISC_CHANGED, vsi->state);
+			if (!err)
+				err = mc_err;
 		}
 	}
 	goto exit;
-
-out_promisc:
-	set_bit(ICE_VSI_PROMISC_CHANGED, vsi->state);
-	goto exit;
 out:
 	/* if something went wrong then set the changed flag so we try again */
 	set_bit(ICE_VSI_UMAC_FLTR_CHANGED, vsi->state);
@@ -3686,17 +3669,6 @@ int ice_vlan_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid)
 	while (test_and_set_bit(ICE_CFG_BUSY, vsi->state))
 		usleep_range(1000, 2000);
 
-	/* Add multicast promisc rule for the VLAN ID to be added if
-	 * all-multicast is currently enabled.
-	 */
-	if (vsi->current_netdev_flags & IFF_ALLMULTI) {
-		ret = ice_fltr_set_vsi_promisc(&vsi->back->hw, vsi->idx,
-					       ICE_MCAST_VLAN_PROMISC_BITS,
-					       vid);
-		if (ret && ret != -EEXIST)
-			goto finish;
-	}
-
 	vlan_ops = ice_get_compat_vsi_vlan_ops(vsi);
 
 	/* Add a switch rule for this VLAN ID so its corresponding VLAN tagged
@@ -3704,22 +3676,7 @@ int ice_vlan_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid)
 	 */
 	vlan = ICE_VLAN(be16_to_cpu(proto), vid, 0);
 	ret = vlan_ops->add_vlan(vsi, &vlan);
-	if (ret)
-		goto finish;
-
-	/* If all-multicast is currently enabled and this VLAN ID is only one
-	 * besides VLAN-0 we have to update look-up type of multicast promisc
-	 * rule for VLAN-0 from ICE_SW_LKUP_PROMISC to ICE_SW_LKUP_PROMISC_VLAN.
-	 */
-	if ((vsi->current_netdev_flags & IFF_ALLMULTI) &&
-	    ice_vsi_num_non_zero_vlans(vsi) == 1) {
-		ice_fltr_clear_vsi_promisc(&vsi->back->hw, vsi->idx,
-					   ICE_MCAST_PROMISC_BITS, 0);
-		ice_fltr_set_vsi_promisc(&vsi->back->hw, vsi->idx,
-					 ICE_MCAST_VLAN_PROMISC_BITS, 0);
-	}
 
-finish:
 	clear_bit(ICE_CFG_BUSY, vsi->state);
 
 	return ret;
@@ -3748,46 +3705,11 @@ int ice_vlan_rx_kill_vid(struct net_device *netdev, __be16 proto, u16 vid)
 	while (test_and_set_bit(ICE_CFG_BUSY, vsi->state))
 		usleep_range(1000, 2000);
 
-	ret = ice_clear_vsi_promisc(&vsi->back->hw, vsi->idx,
-				    ICE_MCAST_VLAN_PROMISC_BITS, vid);
-	if (ret) {
-		netdev_err(netdev, "Error clearing multicast promiscuous mode on VSI %i\n",
-			   vsi->vsi_num);
-		vsi->current_netdev_flags |= IFF_ALLMULTI;
-	}
-
 	vlan_ops = ice_get_compat_vsi_vlan_ops(vsi);
 
-	/* Make sure VLAN delete is successful before updating VLAN
-	 * information
-	 */
 	vlan = ICE_VLAN(be16_to_cpu(proto), vid, 0);
 	ret = vlan_ops->del_vlan(vsi, &vlan);
-	if (ret)
-		goto finish;
-
-	/* Remove multicast promisc rule for the removed VLAN ID if
-	 * all-multicast is enabled.
-	 */
-	if (vsi->current_netdev_flags & IFF_ALLMULTI)
-		ice_fltr_clear_vsi_promisc(&vsi->back->hw, vsi->idx,
-					   ICE_MCAST_VLAN_PROMISC_BITS, vid);
-
-	if (!ice_vsi_has_non_zero_vlans(vsi)) {
-		/* Update look-up type of multicast promisc rule for VLAN 0
-		 * from ICE_SW_LKUP_PROMISC_VLAN to ICE_SW_LKUP_PROMISC when
-		 * all-multicast is enabled and VLAN 0 is the only VLAN rule.
-		 */
-		if (vsi->current_netdev_flags & IFF_ALLMULTI) {
-			ice_fltr_clear_vsi_promisc(&vsi->back->hw, vsi->idx,
-						   ICE_MCAST_VLAN_PROMISC_BITS,
-						   0);
-			ice_fltr_set_vsi_promisc(&vsi->back->hw, vsi->idx,
-						 ICE_MCAST_PROMISC_BITS, 0);
-		}
-	}
 
-finish:
 	clear_bit(ICE_CFG_BUSY, vsi->state);
 
 	return ret;
-- 
2.56.1

