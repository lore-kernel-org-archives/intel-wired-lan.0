Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AE1606A31E
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Nov 2026 12:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=sfXK5Kc7;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MTIreWmD
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8875940816;
	Thu, 26 Nov 2026 12:32:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CJHje6Y8Cgz5; Thu, 26 Nov 2026 12:32:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9807C40897
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795696342;
	b=HhE6yvGldMtm3ww97BHPMFHfKAcToPPMnvN9iBWrw7A1WDLsxdruVTjBDiXBVTU/8l7j
	 /TS2DIr2J3tKz57nxALAa6NgrkiS3THKp8MkR/bbr87BXZplV8YNRZp9cvWpv9H3q98hh
	 Qllzh6OmAiEVH5UTFuxJ0WHxmBXDRzDvTjUrMUOiFiuhv1LGqu/vBeHIojgdF9itNQIJ2
	 KNHSfgSMTALZYxB51bRvWsdSQOgeotnXYAgozjC6h8qRvwEJNApM+W8Pxs4qSHKadYYaM
	 P2imgneIUR+RDJvxC8D64OpFG9FQFQHQcuxIAMdfkOHfz5exd/Sf/Fx5cqsF1CHV1DQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795696342;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jYdprvKHgALhiZvOt2hidC2jQNK5vY2AQybH6B6LG4c=;
	b=C9X2O6M4bRLR4ZiDTjc6Vuc9rGxK8oWwAxUeqdUis6RLmJtCITfKLuTxz+Ddd523aR0q
	 LJNficNll3rUYj+HSxg9x3rQhGHdp++zbD/8zMgBbWH5WEijjJkgHwg34/cC9c5MGF6pv
	 rhlFH3N0UPnSLrlwmlZnc/W1DEfVh2WFOIfkc21LSTmT8TE+vZTIzPWZcQpImvQwljodB
	 X4klGPePx+YmlPDkm2JMABv7ccu2yZllexv6wQDpKz2s+28kKwPEwwg8P0TmqfXtsR1Ud
	 zWZ7lZf8fEvX+k6ztXWNRx67XZwnAHHiyjRO9e/SUHkyTnvo3q8Jvmd9kFf+QJIRP1g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MTIreWmD;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795696342;
	bh=jYdprvKHgALhiZvOt2hidC2jQNK5vY2AQybH6B6LG4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sfXK5Kc7yvVLhe/uzOx9Uc3Odihh1M3LMswSZRZYpcrr51613/c7wdi6d3wotkjyF
	 /2tI9bAA3OQ1zRvnhV6FFfZIljthihyXmOh+Mx4OHd3oZ0Dsy5rBzT05QGKd7ZZYLY
	 j0uRR6mFhDZfjzMKGx8E65aMcsvOKwoNx8x0LR37B+CGdNkZdc7B6jlNxGnLli/Kiq
	 lGI04G4/ltdAmKDDKorirM4vJfv5xNTtcn5BeCRLY7rgjjc62rcxcexMulSo17hS19
	 pJY2nuAL41446HF1sH7Aea5tSSIkLmkYN9Sjg7ec1tiwyn0B7ifM0oqkiraxMvk3bB
	 2SftLSjdz0cSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9807C40897;
	Thu, 26 Nov 2026 12:32:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 471292DF
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 12:32:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3908140897
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 12:32:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NAp1Z9kqoCBZ for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Nov 2026 12:32:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 398AF40816
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jramaseu@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MTIreWmD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 398AF40816
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 12:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795696339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jYdprvKHgALhiZvOt2hidC2jQNK5vY2AQybH6B6LG4c=;
 b=MTIreWmDEQnZ+B6DsU4IMiIe3UESPvuuZfYvaSINB4nx4H1krU51cO2QxZkvZIAGbUVXrV
 pT3TeuugeYU6Fgjf8L4i8/SriXsi06dFWldFu6EoxrJoj0WEkaZq+4gEGFfStA8oThk/mZ
 3/RtOMIqvhyKdozG4X7LNSiOrQ1qad8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-s8z-D7hCPYmf1_JK3cIcHA-1; Thu,
 26 Nov 2026 12:32:15 +0000
X-MC-Unique: s8z-D7hCPYmf1_JK3cIcHA-1
X-Mimecast-MFC-AGG-ID: s8z-D7hCPYmf1_JK3cIcHA_1795696333
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2FEB18001FE; Thu, 26 Nov 2026 12:32:13 +0000 (UTC)
Received: from jramaseu-thinkpadt14gen5.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2FD7E3000229; Thu, 26 Nov 2026 12:32:10 +0000 (UTC)
From: Jakub Ramaseuski <jramaseu@redhat.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 Jakub Ramaseuski <jramaseu@redhat.com>
Subject: [PATCH iwl-next 3/3] ice: share all RSS hash profiles between PFs
Date: Thu, 26 Nov 2026 13:31:14 +0100
Message-ID: <20261126123114.893916-4-jramaseu@redhat.com>
In-Reply-To: <20261126123114.893916-1-jramaseu@redhat.com>
References: <20261126123114.893916-1-jramaseu@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: qB0g4xsl4_sH3WWeJjyzz9IZnfsPstKkenXWmunDfH8_1795696333
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
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The previous patch lets the PFs of a device share the profile IDs of the
default RSS configuration. RSS profiles added later still take an ID per
PF, even when the same profile exists on all PFs: with a VF on each of
8 PFs, the default RSS of the VF VSIs and the same "ethtool -N <vf>
rx-flow-hash" settings on all VFs take 4 more IDs per PF.

A profile ID depends only on the extraction sequence, everything else
(TCAM entries, VSI groups) is per PF. Share the ID of every RSS profile
added through the flow API: besides the defaults, the ones added by
ethtool, by VFs (advanced RSS and the AVF hash enable bits) and on replay.
As before, profiles using field masks or symmetric hashing, and raw
profiles, keep IDs of their own.

The shared flag of the RSS hash configuration is not needed any more,
remove it.

Measured on an E810-CQDA2 split to 8 PFs (NVM 4.30), with all PFs bound,
then one VF created on each PF and "rx-flow-hash {tcp,udp}{4,6} fn" set on
it, reading the IDs the PFs hold from firmware:

               IDs in use     IDs in use after   failed profile ID
               after probe    VFs and ethtool    allocations
  before       33             65                 0
  after        33             37                 0

Signed-off-by: Jakub Ramaseuski <jramaseu@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_flow.c | 49 +++++++----------------
 drivers/net/ethernet/intel/ice/ice_flow.h |  2 -
 drivers/net/ethernet/intel/ice/ice_lib.c  | 10 ++---
 3 files changed, 18 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
index 9be769b105cca..02337d9d3de56 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.c
+++ b/drivers/net/ethernet/intel/ice/ice_flow.c
@@ -1444,7 +1444,6 @@ ice_flow_rem_entry_sync(struct ice_hw *hw, enum ice_block __always_unused blk,
  * @segs: array of one or more packet segments that describe the flow
  * @segs_cnt: number of packet segments provided
  * @symm: symmetric setting for RSS profiles
- * @shared: the HW profile may be shared with other PFs
  * @prof: stores the returned flow profile added
  *
  * Assumption: the caller has acquired the lock to the profile list
@@ -1453,7 +1452,7 @@ static int
 ice_flow_add_prof_sync(struct ice_hw *hw, enum ice_block blk,
 		       enum ice_flow_dir dir,
 		       struct ice_flow_seg_info *segs, u8 segs_cnt,
-		       bool symm, bool shared, struct ice_flow_prof **prof)
+		       bool symm, struct ice_flow_prof **prof)
 {
 	struct ice_flow_prof_params *params;
 	struct ice_prof_id *ids;
@@ -1490,7 +1489,6 @@ ice_flow_add_prof_sync(struct ice_hw *hw, enum ice_block blk,
 	params->prof->dir = dir;
 	params->prof->segs_cnt = segs_cnt;
 	params->prof->symm = symm;
-	params->prof->shared = shared;
 
 	/* Make a copy of the segments that need to be persistent in the flow
 	 * profile instance
@@ -1504,11 +1502,14 @@ ice_flow_add_prof_sync(struct ice_hw *hw, enum ice_block blk,
 		goto out;
 	}
 
-	/* Add a HW profile for this flow profile */
+	/* Add a HW profile for this flow profile. An RSS profile without
+	 * field masks and symmetric hashing may share its ID with the other
+	 * PFs, see ice_prof_can_share().
+	 */
 	status = ice_add_prof(hw, blk, prof_id, params->ptypes,
 			      params->attr, params->attr_cnt, params->es,
 			      params->mask, symm,
-			      ICE_PROF_FD_SWAP | (shared ? ICE_PROF_SHARED : 0));
+			      ICE_PROF_FD_SWAP | ICE_PROF_SHARED);
 	if (status) {
 		ice_debug(hw, ICE_DBG_FLOW, "Error adding a HW flow profile\n");
 		goto out;
@@ -1716,23 +1717,21 @@ ice_flow_set_parser_prof(struct ice_hw *hw, u16 dest_vsi, u16 fdir_vsi,
 }
 
 /**
- * __ice_flow_add_prof - Add a flow profile for packet segments and fields
+ * ice_flow_add_prof - Add a flow profile for packet segments and matched fields
  * @hw: pointer to the HW struct
  * @blk: classification stage
  * @dir: flow direction
  * @segs: array of one or more packet segments that describe the flow
  * @segs_cnt: number of packet segments provided
  * @symm: symmetric setting for RSS profiles
- * @shared: the HW profile may be shared with other PFs
  * @prof: stores the returned flow profile added
  *
  * Return: 0 on success, negative error code otherwise.
  */
-static int
-__ice_flow_add_prof(struct ice_hw *hw, enum ice_block blk,
-		    enum ice_flow_dir dir, struct ice_flow_seg_info *segs,
-		    u8 segs_cnt, bool symm, bool shared,
-		    struct ice_flow_prof **prof)
+int
+ice_flow_add_prof(struct ice_hw *hw, enum ice_block blk, enum ice_flow_dir dir,
+		  struct ice_flow_seg_info *segs, u8 segs_cnt,
+		  bool symm, struct ice_flow_prof **prof)
 {
 	int status;
 
@@ -1752,7 +1751,7 @@ __ice_flow_add_prof(struct ice_hw *hw, enum ice_block blk,
 	mutex_lock(&hw->fl_profs_locks[blk]);
 
 	status = ice_flow_add_prof_sync(hw, blk, dir, segs, segs_cnt,
-					symm, shared, prof);
+					symm, prof);
 	if (!status)
 		list_add(&(*prof)->l_entry, &hw->fl_profs[blk]);
 
@@ -1761,25 +1760,6 @@ __ice_flow_add_prof(struct ice_hw *hw, enum ice_block blk,
 	return status;
 }
 
-/**
- * ice_flow_add_prof - Add a flow profile for packet segments and matched fields
- * @hw: pointer to the HW struct
- * @blk: classification stage
- * @dir: flow direction
- * @segs: array of one or more packet segments that describe the flow
- * @segs_cnt: number of packet segments provided
- * @symm: symmetric setting for RSS profiles
- * @prof: stores the returned flow profile added
- */
-int
-ice_flow_add_prof(struct ice_hw *hw, enum ice_block blk, enum ice_flow_dir dir,
-		  struct ice_flow_seg_info *segs, u8 segs_cnt,
-		  bool symm, struct ice_flow_prof **prof)
-{
-	return __ice_flow_add_prof(hw, blk, dir, segs, segs_cnt, symm, false,
-				   prof);
-}
-
 /**
  * ice_flow_rem_prof - Remove a flow profile and all entries associated with it
  * @hw: pointer to the HW struct
@@ -2300,7 +2280,6 @@ ice_add_rss_list(struct ice_hw *hw, u16 vsi_handle, struct ice_flow_prof *prof)
 	rss_cfg->hash.addl_hdrs = prof->segs[prof->segs_cnt - 1].hdrs;
 	rss_cfg->hash.hdr_type = hdr_type;
 	rss_cfg->hash.symm = prof->symm;
-	rss_cfg->hash.shared = prof->shared;
 	set_bit(vsi_handle, rss_cfg->vsis);
 
 	list_add_tail(&rss_cfg->l_entry, &hw->rss_list_head);
@@ -2645,8 +2624,8 @@ ice_add_rss_cfg_sync(struct ice_hw *hw, u16 vsi_handle,
 	}
 
 	/* Create a new flow profile with packet segment information. */
-	status = __ice_flow_add_prof(hw, blk, ICE_FLOW_RX, segs, segs_cnt,
-				     cfg->symm, cfg->shared, &prof);
+	status = ice_flow_add_prof(hw, blk, ICE_FLOW_RX,
+				   segs, segs_cnt, cfg->symm, &prof);
 	if (status)
 		goto exit;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_flow.h b/drivers/net/ethernet/intel/ice/ice_flow.h
index 97de59776cdd4..6c6cdc8addb12 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.h
+++ b/drivers/net/ethernet/intel/ice/ice_flow.h
@@ -383,7 +383,6 @@ struct ice_rss_hash_cfg {
 	u64 hash_flds; /* hash bit field (ICE_FLOW_HASH_*) to configure */
 	enum ice_rss_cfg_hdr_type hdr_type; /* to specify inner or outer */
 	bool symm; /* symmetric or asymmetric hash */
-	bool shared; /* may share the HW profile with other PFs */
 };
 
 enum ice_flow_dir {
@@ -483,7 +482,6 @@ struct ice_flow_prof {
 	DECLARE_BITMAP(vsis, ICE_MAX_VSI);
 
 	bool symm; /* Symmetric Hash for RSS */
-	bool shared; /* HW profile may be shared with other PFs */
 };
 
 struct ice_rss_raw_cfg {
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index d2e1dc102ce35..f3fefab09f8c1 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1778,15 +1778,13 @@ static void ice_vsi_set_rss_flow_fld(struct ice_vsi *vsi)
 		return;
 	}
 	for (i = 0; i < ARRAY_SIZE(default_rss_cfgs); i++) {
-		struct ice_rss_hash_cfg cfg = default_rss_cfgs[i];
+		const struct ice_rss_hash_cfg *cfg = &default_rss_cfgs[i];
 
-		/* the defaults are the same on all PFs, share their profiles */
-		cfg.shared = true;
-		status = ice_add_rss_cfg(hw, vsi, &cfg);
+		status = ice_add_rss_cfg(hw, vsi, cfg);
 		if (status)
 			dev_dbg(dev, "ice_add_rss_cfg failed, addl_hdrs = %x, hash_flds = %llx, hdr_type = %d, symm = %d\n",
-				cfg.addl_hdrs, cfg.hash_flds,
-				cfg.hdr_type, cfg.symm);
+				cfg->addl_hdrs, cfg->hash_flds,
+				cfg->hdr_type, cfg->symm);
 	}
 }
 
-- 
2.56.0

