Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF18606A321
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Nov 2026 11:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=c7nUBHC1;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w+HIKaqu
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2EE5E606BD;
	Wed, 25 Nov 2026 11:32:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xla-s8zAueXi; Wed, 25 Nov 2026 11:32:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1FD0460687
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795606365;
	b=YMC8QLWFWTAWjr7Z/9WSRx2z03OmpnH9idedguCZFDDREKCdzQvXcpy5b4KaHFk0I49q
	 +MXFr+/pJl5iEMURTjVlsS6fRA48ys+1KHp/xmJrtoaKc3T1XokCN47pbxx/ztWLJKUCQ
	 Hzq/6z9jNV4F1e8dWow63i0OhiDaDRNz8J/Z1Xe/tdb23Wmn8djzXmE1+lQb47ZoRNhL3
	 pVEw8Ae7EC0diokjKNUFXpLbJ+a9yiISdihuMpDTz4uk66+dShNb9pJLUFFyMfweXCy0G
	 CaTBbH2AI0FMd6PmLVxpQFmtHcu7D2tW6cw5RjK3/YpOpuHQAHx4zCjQBNB4bRRyvQQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795606365;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/8mK9Pc/LwL3p0KdETOPDtZzeFtwrz4pl0i0E317N2o=;
	b=ixxKF02d8yfka/glYdV9uggGB8w+WC56LNCOFKWl4xgFeAaouwuJydVsPVfClQ+D/g4N
	 6LZ1pQkGVtopxKvMFbzSryDMOdyaMsmmGI0MuJSAy+5z/Q5aw1cBMgVSlwLCztgRVCz/v
	 07MBwhW8kPxduS06zLxa5pawSGT35mYQyNwNIo1APXIeSxUrpdERf5yuSBKi/QprPEKyv
	 orJARzAKRSd9aXzJnPK4dktedlETAf1nZcSKjDcv1g7N7XycIdjz6agAFW5zvi32lHdjR
	 qkJz9JTbGDwWRty5ExZ3ty4lqg1okFegyw7c1qfDlNL2ylHZze/3TGWnaV5EyEGCgKA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795606365;
	bh=/8mK9Pc/LwL3p0KdETOPDtZzeFtwrz4pl0i0E317N2o=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=c7nUBHC1zF3ST/UU4NywC5LEWnqZLfUWYeXhSVLXLRhTTEVdV/EnjUOHE4sz4CW6k
	 gsCENw7vp2QgAMjkNUxcy/rUW3shJpI/YiU/qWN9y0eTYojmfb1nAG1YLk/xz1eGwA
	 6eWOhYePUpFO19anDQBPbUFoLPujJPUjUl7c79szjYMnWzIVKO6kGUePrtOkerOf+2
	 YsDKs8cj+os/YmPa9FmqwhU02VP7N7xvOXsFRaTxaRELViRxc8WZ7X93AEPvAvI2CG
	 I6grvllHXzmNKSYvOfkQ6a+k2PtUx+0ijUv/MYG4V0MCPLr9yKczqFpAh/D1JBzAuP
	 fDl+cKXZg6tUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1FD0460687;
	Wed, 25 Nov 2026 11:32:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AF4372DF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 11:32:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A0CE94064E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 11:32:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cOpwvURSpB_O for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Nov 2026 11:32:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 94EAE40619
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com;
 envelope-from=kor8821@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=w+HIKaqu
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 94EAE40619
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 11:32:42 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3b083afebe4so649874a91.0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 03:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795606361; x=1796211161; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/8mK9Pc/LwL3p0KdETOPDtZzeFtwrz4pl0i0E317N2o=;
 b=w+HIKaqumsbZeIBMRxyqVbjjfdzuw0sP2knpjCyUn45V3PJeiGwgbH7lYFH2tQNaBm
 X6O7silzxv1/5RgE0EtoajaattnLbpvrQevccLwpKOzkM84vCKc6Uh/3KAbFOQSzuceN
 Mr//lC3KRiEKkoRf6klq7Z8vJtj+TU27NY6BYjH8tMp5jkgLeR/PTRX9bgUrOr0bdm2p
 4HEoetpillAD8NDIwcc40MsCi8RCQfhZReCII6CwDE4UjOoeXHgH4PJz8KsaIkYHztW8
 7c6JIuiSCoudi2gLg0IwqEDH9fk7gFSSPkLTnXiCsPZgObxTsGqtgPgxRoAQxkTzZ95O
 ugag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795606361; x=1796211161;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/8mK9Pc/LwL3p0KdETOPDtZzeFtwrz4pl0i0E317N2o=;
 b=n2qzGsrcgRp4XplhXub01yPan5tnw3jEpIWMUqpzmZueheNTYIFnIMWepl9xhjEF1c
 6ph0TX+uoRpOPh9YcdWm7lSj9K5FLusf4oN82CZmlZTMfpsu07t+ZUFnhiSZlS8cpqSu
 jz1WQugDQpnmhJ0vXmq8WMZRLVuc3UTdcYurHT3UxBDD2KOstmO/qooOExX6CUIqz5Zs
 Cx/a7AcoZ3A+HkeWslwArOHTpAvzDMdRkAEN+QIOoNpzVLVvtaOSznGaH3B5ol9XLgZP
 o6/THZISr3L5knmEKBpi0D7D/EhgadQjqt8fkwpOVgr/lM0E7+gqLwzsadni51W2YZnb
 HUkQ==
X-Gm-Message-State: APuU4Z9OzA7mgyeipukZifTMCJkHqFLzJMmA+qa4R43CFnduS1eq1Su6
 7Z5gWkmq6F0CI+lr18WlTeWyR813H/NYaNb8GfNgNBqiB103NtGvXAvXDRVw203248o=
X-Gm-Gg: AZFdTZfAKzz4YWOlj803uE0mggnp9d5Pn3+YDnm43vCgoZlThUjMy22e7QEQ/BjJdQe
 NgjTG5i7wSsdOgW7bIh67+TcfkUFW4lR3K6BBSmtVJak16BERBcu314F+nym+SdYAR9BHUvWpiV
 p3LbIv8oEnebIPQbarUSzBSjCpqr4O2sCsQMiDRvGh+mIKGzv/jOQTw7FzcZv1ZDAZy/xr4uq40
 BRbjNFVogkG83YFLwhIoxgQntEZfL6bIFXZgAQVUk1LwuEJtO+RAmyaWuRzZpa3bRLsEnFF9S3+
 ZeDL7eHGq6TDgtqceADnUXMZhKyt21pM/tgqR66hOqQDSWQr0P3txop/J8DhahyGbCIR9eruAf2
 59x5udCP3OSUiLCPz9WgQue5ELlLAcCT8AzH92NArT9pnTU7txJHJPF/Tuwi4ockEloyXaZcVfr
 xwswaQrF/ZUxRsyo3mXChN7x5KUIIc+vfw/WqvgjtQbjn3Qq4R1L/qVoV6vhxJ7mmtkKl/mEr/8
 AjEiAjC2FvzrAz070O27Ev9qTtKD6RBZUnpzWnJZyaNdBy0JQXRf2yL/n5sJrb6ul0jqG1jbOCY
 qnBhScoAvhVp5m8ix1bz6Q8u6lX628XTe2YvBY4K6JRhrrhY0Vfg
X-Received: by 2002:a17:90b:4a48:b0:3b0:9984:18c6 with SMTP id
 98e67ed59e1d1-3b41c907e3bmr26052479a91.3.1795606361341; 
 Wed, 25 Nov 2026 03:32:41 -0800 (PST)
Received: from localhost.localdomain ([14.47.155.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b41aab4729sm27132863a91.0.2026.11.25.03.32.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Nov 2026 03:32:41 -0800 (PST)
From: Minseok Kim <kor8821@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, przemyslaw.kitszel@intel.com,
 aleksander.lobakin@intel.com, stable@vger.kernel.org
Subject: [PATCH iwl-net v3] ice: reject an out-of-range CEE DCBX
 priority-group ID
Date: Wed, 25 Nov 2026 20:32:37 +0900
Message-ID: <20261125113237.48372-1-kor8821@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The CEE DCBX priority-group ID (PGID) is a four-bit wire field spanning
0..15, whereas prio_table[] is sized to ICE_MAX_TRAFFIC_CLASS (8):

  #define ICE_CEE_PGID_PRIO_0_M  (0xF << ICE_CEE_PGID_PRIO_0_S)
  #define ICE_CEE_PGID_PRIO_1_M  (0xF << ICE_CEE_PGID_PRIO_1_S)

The IEEE ETS parser in ice_dcb.c masks the equivalent nibble field with
0x7 (ICE_IEEE_ETS_PRIO_{0,1}_M) so it cannot exceed 7.  The CEE wire
parser does not: ice_parse_cee_pgcfg_tlv() extracts each nibble into
prio_table[i] and inspects it to select tsatable[i], but never rewrites
prio_table[i], so values 8..15 survive -- including the defined
strict-priority sentinel ICE_CEE_PGID_STRICT (15), which is not a
traffic class at all.

Downstream consumers then use prio_table[i] directly as a traffic-class
index:

- ice_vc_get_qos_caps() (virt/virtchnl.c) indexes local array
  u8 tc_prio[ICE_MAX_TRAFFIC_CLASS] via tc_prio[tc] |= BIT(i), writing
  past the end of the stack array when tc >= 8.
- ice_dcb_tc_contig() (ice_dcb_lib.c) accumulates used_tc |=
  BIT(prio_table[i]) into a u8; for values >= 8, BIT() is >= 0x100 and
  truncates to zero, causing the contiguity check to pass silently.
- ice_vsi_cfg_netdev_tc() (ice_lib.c) indexes
  vsi->tc_cfg.tc_info[ets_tc].netdev_tc with ets_tc = prio_table[i],
  reading past the end of tc_info[].

Validate the whole Priority Group Table at the TLV parsing level, before
any part of the sub-TLV is applied, and reject it if a PGID names a
group this driver has no traffic class for.  Values 8..14 have no
meaning in the protocol, so there is nothing to translate; refusing the
peer's PG configuration is the correct response rather than substituting
a value it did not send.  The strict-priority sentinel 15 remains
accepted, but is now replaced in prio_table[] once its meaning has been
recorded in tsatable[], so it no longer reaches the consumers above.

The four octets inspected by the new check are already read
unconditionally further down the same function, so this adds no new read
of the TLV.  The rejection is silent by design: the input is attacker-
controlled LLDP, and the other parsers in this file do not log either.

The driver already enforces this invariant when writing prio_table[] in
ice_dcbnl_set_pg_tc_cfg_tx() and at the VF trust boundary in
ice_vc_cfg_q_bw().

Fixes: 0ebd3ff13cca ("ice: Add code for DCB initialization part 2/4")
Cc: stable@vger.kernel.org
Signed-off-by: Minseok Kim <kor8821@gmail.com>
---
v2: https://lore.kernel.org/intel-wired-lan/20261124112631.43172-1-kor8821@gmail.com/
v1: https://lore.kernel.org/netdev/CABBEkySNmAHTuoiC3jZqvAS31AdzMb2bHe3x0EAKQGibf0xi9g@mail.gmail.com/

Sent stand-alone rather than in-reply-to v2, as requested.

v3, all of it from Przemek's review of v2:

- Reject instead of clamp.  v2 rewrote an out-of-range PGID to 0; v3
  refuses the Priority Group Table outright.  The check runs before any
  field of the sub-TLV is committed, so a rejected TLV leaves the
  existing ETS config untouched instead of half-applied.

- Moved entirely to the TLV parsing level.  The ice_cee_to_dcb_cfg()
  hunk from v2 is dropped; only ice_parse_cee_pgcfg_tlv() changes.

- Retagged Fixes:.  v2 cited 015307754a19, which only added the
  ice_vc_get_qos_caps() consumer in v6.13.  The unbounded parse is from
  0ebd3ff13cca (v5.1), so stable trees older than v6.13 need it too --
  ice_vsi_cfg_netdev_tc() and ice_dcb_tc_contig() predate the v2 tag by
  years.  Thanks to the sashiko.dev report for catching this.

One question left open from the sashiko.dev report, deliberately not
addressed here.  It observes that in ice_cee_to_dcb_cfg() the
ICE_CEE_PGID_STRICT branch assigns cee_cfg->oper_num_tc - 1, which is
out of range if oper_num_tc is 0 (underflowing to 255) or greater than
ICE_MAX_TRAFFIC_CLASS.  That is a real gap, but its inputs come from the
Get CEE DCBX Config admin-queue response rather than from the wire, and
that path has no TLV parser to move a check into -- so I have left it
alone per your "here we should have no changes".  If the AQ response is
not considered a trusted source, I am happy to send a separate patch
bounding oper_num_tc where it is consumed; please say which you prefer.

Notes on testing and tool assistance (per
Documentation/process/generated-content.rst):

- Tool assistance: Claude Code (Anthropic) was used during static source
  auditing of the CEE DCBX parsing paths, to draft the commit
  description and the check, and to run build/style checks.  All
  findings, code changes, and commit text were independently verified
  and edited by the author, who takes full responsibility for the patch.
- Testing: Compile-tested only on x86_64 (defconfig + CONFIG_PCI_IOV +
  CONFIG_DCB + CONFIG_ICE) with `make W=1 drivers/net/ethernet/intel/ice/`
  against a clean baseline build, and checked with `scripts/checkpatch.pl
  --strict` (0 errors, 0 warnings, 0 checks).  No reproducer was built
  and no runtime testing was performed due to lack of E810 hardware or a
  QEMU device model; the out-of-bounds accesses are established from
  source inspection and header constants.

 drivers/net/ethernet/intel/ice/ice_dcb.c | 39 ++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb.c b/drivers/net/ethernet/intel/ice/ice_dcb.c
index abea84f14658..86bdaece4cfd 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb.c
@@ -356,6 +356,20 @@ ice_parse_ieee_tlv(struct ice_lldp_org_tlv *tlv, struct ice_dcbx_cfg *dcbcfg)
 	}
 }
 
+/**
+ * ice_cee_pgid_is_valid
+ * @pgid: CEE priority-group ID as it appears on the wire
+ *
+ * The CEE priority-group ID is a four-bit field, so a peer can name a
+ * priority group this driver has no traffic class for.  Only
+ * 0..ICE_MAX_TRAFFIC_CLASS-1 and the strict-priority sentinel
+ * ICE_CEE_PGID_STRICT are meaningful values.
+ */
+static bool ice_cee_pgid_is_valid(u8 pgid)
+{
+	return pgid < ICE_MAX_TRAFFIC_CLASS || pgid == ICE_CEE_PGID_STRICT;
+}
+
 /**
  * ice_parse_cee_pgcfg_tlv
  * @tlv: CEE DCBX PG CFG TLV
@@ -374,6 +388,21 @@ ice_parse_cee_pgcfg_tlv(struct ice_cee_feat_tlv *tlv,
 
 	etscfg = &dcbcfg->etscfg;
 
+	/* Several consumers use prio_table[] directly as an index into
+	 * ICE_MAX_TRAFFIC_CLASS-sized objects, so reject a Priority Group
+	 * Table that names a group outside that range before any part of
+	 * this TLV is applied, rather than substituting a value the peer
+	 * did not send.  The four octets read here are already read
+	 * unconditionally below.
+	 */
+	for (i = 0; i < 4; i++) {
+		if (!ice_cee_pgid_is_valid(FIELD_GET(ICE_CEE_PGID_PRIO_0_M,
+						     buf[i])) ||
+		    !ice_cee_pgid_is_valid(FIELD_GET(ICE_CEE_PGID_PRIO_1_M,
+						     buf[i])))
+			return;
+	}
+
 	if (tlv->en_will_err & ICE_CEE_FEAT_TLV_WILLING_M)
 		etscfg->willing = 1;
 
@@ -403,10 +432,16 @@ ice_parse_cee_pgcfg_tlv(struct ice_cee_feat_tlv *tlv,
 	ice_for_each_traffic_class(i) {
 		etscfg->tcbwtable[i] = buf[offset++];
 
-		if (etscfg->prio_table[i] == ICE_CEE_PGID_STRICT)
+		if (etscfg->prio_table[i] == ICE_CEE_PGID_STRICT) {
+			/* Strict priority is carried by tsatable[].  The
+			 * sentinel is not a traffic class, so replace it
+			 * instead of leaving it for consumers to index with.
+			 */
+			etscfg->prio_table[i] = 0;
 			dcbcfg->etscfg.tsatable[i] = ICE_IEEE_TSA_STRICT;
-		else
+		} else {
 			dcbcfg->etscfg.tsatable[i] = ICE_IEEE_TSA_ETS;
+		}
 	}
 
 	/* Number of TCs supported (1 octet) */
-- 
2.39.5 (Apple Git-154)
