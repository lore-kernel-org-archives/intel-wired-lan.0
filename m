Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DC9CA601E
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 12:15:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C98DB40942;
	Fri,  9 Oct 2026 12:15:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LzSXKtfnbtb3; Fri,  9 Oct 2026 12:15:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F05EC40919
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791548108;
	b=VbsxIbVdFHTZNVyFeQOv3gvebbb93FwA8TxWs2fR/9gryYyNwXePSp+awD1C0J4WStYI
	 0v/Rof/nmQcjDwaSIN66wSAmDUxuBzqwS8E3LXqtTiiCcoanS38+uX7obGzdx+bECf/gq
	 J9q6DNbnInWp7t9WL1GXs+mbT34FYHLWxxkQ08aFrkyze38eeuQZwBKp5B5Cs0hkjWGEP
	 e+DFrqNU1Y9UZHOofpyglJ2wX+642MVszF8uk4htGMOXo60/uGHdWJkjtMMPjHlPTQXrN
	 FvZccTForoN0q0zdNt1cjd+Yx8iXk1sT9AKBnAkja5pP2C2JXpm/kzz17qwV/OVJ51Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791548108;
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
	bh=0h79ankLyCZJbUgTYcHkkC2K706XkXDQh7wfcswY9rw=;
	b=l2ycPLknSWk0tkmM/klXosFsCexZ7JFRQOgApuie0sGVsS5mmf3P/D01ffaZWOahkSoS
	 Y7+ChIFzawNqc0Xn5ILDaT88jb/miF33d2pXW7etk8yL8M0GaK6ucZQVQNwrssikrCFsu
	 lCTz/RXt6BVSz0ENGiXQgi1MO3q7ebVMZ9067YnZyJhQn86Nen3NDuTvi0BJ82Uj1+y9F
	 QLMK9YbnE+N9Vkf/BWq2HLnJjBCkuzqwk09Rft9loN3h8HzB45jSb4hXpH81gYyNo4Bd+
	 c4Yg0jUVyzfrzeYJka8/K3L4NhvVwq9tDsPjN1yk5X1yepwos3LBuEFBUwGLRDpyKEA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=P598jYMo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791548108;
	bh=0h79ankLyCZJbUgTYcHkkC2K706XkXDQh7wfcswY9rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=5P2WCn+XdOM3DVYDJ2q2Gq1730VU1s3/yKL/ZWNrF3bn2VMvknRl2ZpmFYLI4AS9i
	 8syM4rcWs+85o9pYXuMTXrU73r6EdUl6VoMAlqA3yq3POsSQ3fedvuSzFCy61YG8oJ
	 aDINKF8sAd+PEzaEkA2euuxEMjjU0/7XCKk8897HDAnvJ8yD0/f7C0qswxPKO41nMc
	 /9NvQEM67X/bt47TXB6SClpHvVmoeryPjuYAqpfkgKogPZUj4LcCuGBTR/2S1ZvvxZ
	 +nq36f1sNPoSWVLcL5H0ZY02q66QQYBPJYK5CpUYOw4/2Ye2oZfbMDnMuybcmLUhRY
	 pXIwXhC6NaNjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F05EC40919;
	Fri,  9 Oct 2026 12:15:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3ED6E317
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 12:15:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2420840902
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 12:15:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SjaC2CCx5EZ1 for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 12:15:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5963040919
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791548105;
 b=IKXO9rtID8UOnRS0CuB+pBif7lL/wRXaNVRY4ei6typT5u5Wzm6s3lxHsuhV5x5mVeBb
 ubFkMeEqfD9A8WArDc+ZG2H5S5NNCwPGK0ohktbJe4ljjaugXc6D01qQvVQcizOIsyjzv
 jkkdZE5J9VYhgnsdTmzU6viav//Qa277AwGXPdrXVDTVuy3rNilZSLhs1Tpt6slaOnF5V
 M/ATb0Pr51xGYV6bKzilHOfmTmuX1BtEHbr77m0I+qPbqCTgWBoZJDyMuzIV57t5kRIxe
 wa+kAtlLYy7JlVrcUi9wMqw7XzChyNO2wab4NeT1aib6T07GRglH3DO+oBU2BKJVvJg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791548105;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=0h79ankLyCZJbUgTYcHkkC2K706XkXDQh7wfcswY9rw=;
 b=D63gywKK9y8Vs5xlPiOgGSVZyIXo4anmWOIwQcZvxQkGHcEP9dkww6uKQnfQaNaFUhHk
 EfGkqmhn7dN9e0DPOKByiSmcVD/6sEEUPC5DDbKl6Y6tjpAP/e6XOocU7LfYySBIrvECf
 3JqAcilGhNbMe1r3b12oELjqt/AtbSwMNrJ/R4tAw3iShLzyVfmsKLl21x79lOSo/+7xP
 hNEG6aztdED5A+3m1OpDSiaEgCM2sYH5uV7fjxjPyL2sUsnxLk1C6xTq8z4p1scz0K4ww
 kIe7r6/dXSuAM10xroci0cRWWoDWxceTA5RNSrJ6qOdxY8fMB3/6eB8kw2AnA98Pbvw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=P598jYMo; 
 arc=none smtp.remote-ip=192.198.163.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=P598jYMo
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5963040919
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 12:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791548105; x=1823084105;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RG1SwPGWFGqPnGDKptI3PY64nF94VTae+e07ogWdYRQ=;
 b=P598jYMoL3HG1DMtm5zBT2TRWAy+j0CvVi6nTb4oJUsCFMdbVoXH74oi
 j/vR4GFtEIp20o+fb20faVaJWnTZeDveqBZ9q3r8ubW+YnCmSW4OKiYsI
 xaVt7SeRrokZjtynTmdjvWVGpBOsQYpDkvgQll1b4uSPQ2/yR2RWmKvtT
 q2ZwAFPXmdbYN9axWg0L4SaKoN41+AZSlBGNoKFSE9pOEiuF5BUBrinet
 7zDz1wxY+bMPNbQ4gMnqGrTXR78BezOdQmE3EBXNEnioHyMYIvq2fJw7k
 TI2fVSnkUHJbd1lsLEDFxr3UZ3pIkjnmLzpkol1hyBLNSO685lcv8FhUo Q==;
X-CSE-ConnectionGUID: vJS7sVkTSG6XueN8EFnewg==
X-CSE-MsgGUID: DmEWohCbTkKXcaie05EEfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="251204"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="251204"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 05:15:05 -0700
X-CSE-ConnectionGUID: /ooeTN/2RGesoPH3NYD6ng==
X-CSE-MsgGUID: uHy21p44QHSZgW0cSaOLog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="420493"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa002.fm.intel.com with ESMTP; 09 Oct 2026 05:15:00 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.245.238])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id D923C2FC43;
 Fri,  9 Oct 2026 13:14:55 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Michal Schmidt <mschmidt@redhat.com>, intel-wired-lan@lists.osuosl.org,
 edumazet@kernel.org, horms@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, Jonathan Corbet <corbet@lwn.net>,
 skhan@linuxfoundation.org, rdunlap@infradead.org, andrew+netdev@lunn.ch,
 saeedm@nvidia.com, tariqt@nvidia.com, leon@kernel.org, mbloch@nvidia.com,
 jacob.e.keller@intel.com, jedrzej.jagielski@intel.com, anzaki@gmail.com,
 brett.creeley@amd.com, jtornosm@redhat.com, ohartoov@nvidia.com,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v2 09/14] iavf: increase max number of queues to 256
Date: Fri,  9 Oct 2026 14:04:20 +0200
Message-ID: <20261009121433.30347-10-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20261009121433.30347-1-przemyslaw.kitszel@intel.com>
References: <20261009121433.30347-1-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Increase the max number of queues that driver will handle to 256.
Use old legacy limit in the virtchnl handling of iavf_map_queues().

Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v2:
 * change iavf_q_vector::num_ringpairs to u16 (Sashiko)
 * drop the stale "_i=0...15" range from IAVF_Q{R,T}X_TAIL1()
---
 drivers/net/ethernet/intel/iavf/iavf.h          |  6 ++++--
 drivers/net/ethernet/intel/iavf/iavf_register.h |  4 ++--
 drivers/net/ethernet/intel/iavf/iavf_main.c     |  4 ++--
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 15 ++++++++-------
 4 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 94ee18058115..47236d5f3961 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -87,8 +87,10 @@ struct iavf_vsi {
 #define IAVF_TX_DESC(R, i) (&(((struct iavf_tx_desc *)((R)->desc))[i]))
 #define IAVF_TX_CTXTDESC(R, i) \
 	(&(((struct iavf_tx_context_desc *)((R)->desc))[i]))
+
 /* for "old" virtchnl opcodes that accept up to 16 queues */
 #define IAVF_MAX_REQ_QUEUES_VCV1	16
+#define IAVF_MAX_REQ_QUEUES		256
 
 #define IAVF_HKEY_ARRAY_SIZE ((IAVF_VFQF_HKEY_MAX_INDEX + 1) * 4)
 #define IAVF_HLUT_ARRAY_SIZE ((IAVF_VFQF_HLUT_MAX_INDEX + 1) * 4)
@@ -108,9 +110,9 @@ struct iavf_q_vector {
 	struct napi_struct napi;
 	struct iavf_ring_container rx;
 	struct iavf_ring_container tx;
-	u32 ring_mask;
+	DECLARE_BITMAP(ring_mask, IAVF_MAX_REQ_QUEUES);
 	u8 itr_countdown;	/* when 0 should adjust adaptive ITR */
-	u8 num_ringpairs;	/* total number of ring pairs in vector */
+	u16 num_ringpairs;	/* total number of ring pairs in vector */
 	u16 v_idx;		/* index in the vsi->q_vector array. */
 	u16 reg_idx;		/* register index of the interrupt */
 	char name[IFNAMSIZ + 15];
diff --git a/drivers/net/ethernet/intel/iavf/iavf_register.h b/drivers/net/ethernet/intel/iavf/iavf_register.h
index a19e88898a0b..11043e330de8 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_register.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_register.h
@@ -56,8 +56,8 @@
 #define IAVF_VFINT_ICR0_ENA1_RSVD_SHIFT 31
 #define IAVF_VFINT_ICR01 0x00004800 /* Reset: CORER */
 #define IAVF_VFINT_ITRN1(_i, _INTVF) (0x00002800 + ((_i) * 64 + (_INTVF) * 4)) /* _i=0...2, _INTVF=0...15 */ /* Reset: VFR */
-#define IAVF_QRX_TAIL1(_Q) (0x00002000 + ((_Q) * 4)) /* _i=0...15 */ /* Reset: CORER */
-#define IAVF_QTX_TAIL1(_Q) (0x00000000 + ((_Q) * 4)) /* _i=0...15 */ /* Reset: PFR */
+#define IAVF_QRX_TAIL1(_Q) (0x00002000 + ((_Q) * 4)) /* Reset: CORER */
+#define IAVF_QTX_TAIL1(_Q) (0x00000000 + ((_Q) * 4)) /* Reset: PFR */
 #define IAVF_VFQF_HENA(_i) (0x0000C400 + ((_i) * 4)) /* _i=0...1 */ /* Reset: CORER */
 #define IAVF_VFQF_HKEY(_i) (0x0000CC00 + ((_i) * 4)) /* _i=0...12 */ /* Reset: CORER */
 #define IAVF_VFQF_HKEY_MAX_INDEX 12
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index bb239e99e450..8059e855dc09 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -439,7 +439,7 @@ iavf_map_vector_to_rxq(struct iavf_adapter *adapter, int v_idx, int r_idx)
 	q_vector->rx.count++;
 	q_vector->rx.next_update = jiffies + 1;
 	q_vector->rx.target_itr = ITR_TO_REG(rx_ring->itr_setting);
-	q_vector->ring_mask |= BIT(r_idx);
+	set_bit(r_idx, q_vector->ring_mask);
 	wr32(hw, IAVF_VFINT_ITRN1(IAVF_RX_ITR, q_vector->reg_idx),
 	     q_vector->rx.current_itr >> 1);
 	q_vector->rx.current_itr = q_vector->rx.target_itr;
@@ -5370,7 +5370,7 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	pci_set_master(pdev);
 
 	netdev = alloc_etherdev_mq(sizeof(struct iavf_adapter),
-				   IAVF_MAX_REQ_QUEUES_VCV1);
+				   IAVF_MAX_REQ_QUEUES);
 	if (!netdev) {
 		err = -ENOMEM;
 		goto err_alloc_etherdev;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 630a551c7566..3b9545d2c021 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -268,19 +268,19 @@ int iavf_send_vf_ptp_caps_msg(struct iavf_adapter *adapter)
  **/
 static void iavf_validate_num_queues(struct iavf_adapter *adapter)
 {
-	if (adapter->vf_res->num_queue_pairs > IAVF_MAX_REQ_QUEUES_VCV1) {
+	if (adapter->vf_res->num_queue_pairs > IAVF_MAX_REQ_QUEUES) {
 		struct virtchnl_vsi_resource *vsi_res;
 		int i;
 
 		dev_info(&adapter->pdev->dev, "Received %d queues, but can only have a max of %d\n",
 			 adapter->vf_res->num_queue_pairs,
-			 IAVF_MAX_REQ_QUEUES_VCV1);
+			 IAVF_MAX_REQ_QUEUES);
 		dev_info(&adapter->pdev->dev, "Fixing by reducing queues to %d\n",
-			 IAVF_MAX_REQ_QUEUES_VCV1);
-		adapter->vf_res->num_queue_pairs = IAVF_MAX_REQ_QUEUES_VCV1;
+			 IAVF_MAX_REQ_QUEUES);
+		adapter->vf_res->num_queue_pairs = IAVF_MAX_REQ_QUEUES;
 		for (i = 0; i < adapter->vf_res->num_vsis; i++) {
 			vsi_res = &adapter->vf_res->vsi_res[i];
-			vsi_res->num_queue_pairs = IAVF_MAX_REQ_QUEUES_VCV1;
+			vsi_res->num_queue_pairs = IAVF_MAX_REQ_QUEUES;
 		}
 	}
 }
@@ -583,8 +583,9 @@ void iavf_map_queues(struct iavf_adapter *adapter)
 
 		vecmap->vsi_id = adapter->vsi_res->vsi_id;
 		vecmap->vector_id = v_idx + NONQ_VECS;
-		vecmap->txq_map = q_vector->ring_mask;
-		vecmap->rxq_map = q_vector->ring_mask;
+		vecmap->txq_map = bitmap_read(q_vector->ring_mask, 0,
+					      IAVF_MAX_REQ_QUEUES_VCV1);
+		vecmap->rxq_map = vecmap->txq_map;
 		vecmap->rxitr_idx = IAVF_RX_ITR;
 		vecmap->txitr_idx = IAVF_TX_ITR;
 	}
-- 
2.51.1

