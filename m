Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99398606A31C
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Nov 2026 06:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=6ZUapckL;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AYemS90Y
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E44E80FFE;
	Thu, 26 Nov 2026 06:44:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dE2AE92mv99r; Thu, 26 Nov 2026 06:44:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9875181004
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795675449;
	b=RWDklOzGw41kpP9TiCPZbXFYV7tOAlYXtfgBKLwr3bxWTgDOjeSshylAvZFgjO/kB4nB
	 Nsd57ALgm7YFjjDPAAX+Ip4s7sA8LTQNg9uGrDfxI6/3WRMCWY2F7fPP4jTe/pPixSW4b
	 /iH2/MvXBc0Y8TctBdd9yYWSc2CSf6vf7SuC5eZC4XCQ4pdPFmnVufFzlgjmyzb13hfWN
	 HJIOlTWQk3Oo/7phn1O9tB8ae6ovLSYCi4Y+IskTle0QCuxpItZQR4xoaay9NDduerw43
	 iVi0nds00uxhCLqOzX9Zs3gFccS8oVzN+he6bB3GY40NZkj+Vs8EBBDQ5ugDi/m4Cew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795675449;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IGOZXvHj7Kp3VoWvYB9VXQ2RIbnpFsMHzOt42EfzF7E=;
	b=ogAqdzjZtCQPjG4eCNDqm13PJLtuXpswXxhUR8wrdpTenAMlZwoSRM3etlhqSeDP4QoD
	 OMOz5RPm7zvS/J+FbOKOpXp/JROYL/vcdqoVa+aipdMx2P/wsON52R/MmQgGrg/kKhZVO
	 PGQxO47dOZ00JGG1W3pra8avTIGKTz4WgXCdR+WqAO4f2wGetZNTmogwmiaxBOUvca0Cj
	 2jjj1AkaJeVP+Yoa6E+cclTbk9qx0Hk/dUV/lA4deXCx6wQa0t9Bz0wd+ntaZyr+b5kVz
	 VoWRoRDtl1DF3+ezmbPLh97FctyYQeFW3v62WNoYGtPqJpF/meEftjOxYtFJFguXphg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795675449;
	bh=IGOZXvHj7Kp3VoWvYB9VXQ2RIbnpFsMHzOt42EfzF7E=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=6ZUapckL+uYUdjov1XugpVZBt+74tY4DTijHPhGM2VCnVwcrFz9uJwwP6U+DZoAW2
	 Oes14GKd2OB5989xu2FfEOuW41MamESrezs8A/j8F00KFyGVnR77/fSVjpCBVmp3Qh
	 yWnOwZFP597HB8hRn1S7IxI6sHVB1ni0eBKBiyVczZM19YvE9VoNqfI9oWQ9OdNe7U
	 aWNc+8O1Djdsd1TCKmFODDwB3gXNL9NfiE5lb9oL4RBwKx7JeY8da4+FvX3v4y9cWF
	 RFCEKqJW7DUoDpI0WWByRp3P+0olGZVAWu/6euGus7ffvY7ujGxDUlfIkoda1xHMxI
	 AAci0un6hvHeA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9875181004;
	Thu, 26 Nov 2026 06:44:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 567AA1C9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 06:44:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5428A40490
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 06:44:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1U27w3xgC-mb for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Nov 2026 06:44:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 87F8C4048E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com;
 envelope-from=kor8821@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=AYemS90Y
Received: from mail-dy1-x1329.google.com (mail-dy1-x1329.google.com
 [IPv6:2607:f8b0:4864:20::1329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 87F8C4048E
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 06:44:07 +0000 (UTC)
Received: by mail-dy1-x1329.google.com with SMTP id
 5a478bee46e88-3861d608cdcso833340eec.3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 22:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795675446; x=1796280246; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IGOZXvHj7Kp3VoWvYB9VXQ2RIbnpFsMHzOt42EfzF7E=;
 b=AYemS90YsCpTldWLtEMmQsGiliQ23xjwylZm9qZuY8ZU/VLyTjZHHbvYocR79+iwIn
 HGvez970WWv0sibADxENgFdDi6/nrCjwSzoadLIM5ENchB3csFOm4beWrhsMw2adEgww
 gTsFbaO2g+Ine4nLdOa8a47SOh0Uyk+9fZQQiHV1h9TV/NEBj9jRF+jhjo0Q97PIdG6Y
 8hDEy1a48IAUG8++Qxcgs6evP3WwcppCAuTq80oAlOjY62wGlTB4IT0tf4h2edCzEEHZ
 nfsNkCPXRj7DCCR5Kq5MMm2tZ3GDWogZ0gX64qf2ixqdqC2feW9y5EDRZ1e+4Py+vH0M
 wbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795675446; x=1796280246;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IGOZXvHj7Kp3VoWvYB9VXQ2RIbnpFsMHzOt42EfzF7E=;
 b=F/PE9tsXX0RGOg2GwecNwwYdejjOThunU7oFPBH3MvnRahTdsgh751s1cH9EHheCSd
 eH4lgMiPCa/R/tv1ebljywiRk8XB+26STaRG350BQu0chc50ajz0y1ARAqjQu+OG4riH
 P2LgXmrlfOfLOOanX7ujfsPQRfDF2ZIa7APvHw2e+t5RXKBy/u1Jp9LKzWOCuPJP0s1E
 O8N57PUOzynv9O0I/DevvGTfhZjBCSRO42qZQK61H5huCEyJeLNyLIsKwAEtUclJtSnR
 uaFJVElmEm10GTTv0bO7GLBMc7GZ4z5lGPen2dMv9F5KW36YkvBr5DNNT8Oqivt8GgmL
 OTQg==
X-Gm-Message-State: APuU4Z8nbLiDXx6+VnpYtcQWpCDZP5DJTRs+Sa4sftL+6BoHytryVZ0m
 pwlURztSMyZlGH29mh0VU4vQW28BLE4btZX3URRsKMMqPMOGDdogVqJi+5Cu2qp66S0=
X-Gm-Gg: AZFdTZeXznF6WIbCEmPyQRZG4ss2ez/U3YX/zID4P/XmuP8BFstgrIOixk1csaRc2WD
 oAGNibXfWByNKdz/QnbduZjT2vI+Mv68tF9PZGc+f+AfyyJ5oRolXSldu9FcMu49nS8UTSPJgQC
 WOS5UUR63tYSCDreNBR7dddP0w0+dtusQ9DKsUAxNVAjrO9EMQnXzI0EyawVM2PhNO2fA62SIWx
 JifTVgqN3rAUolNTRDiRINOVRtimTqnAF7Bd3Fs97sf1Dtk5jxi8H2we2+xlJBH0tkknQH1b0UB
 SBeF9TT+rZsVl0MesgxA/McluQbKA2yJ+kEFixY0zf/O2kXEVnW1E3q+dIvEK/Cd0myJ+RIEs6D
 Xo5d23pxuZ5YauOFVuSPNqYLD1BQJad56L5nJWHTY5/T+ECbNPyrwEIs3y4QCZNbyteBJ5dg4nu
 YeIF1EdwDkm0L4jvoZDRDUA32NtYAw+WQEGbz3s3kP5I8yIqMKoLP2bbmR78KDEwVk8ZzAWGfRk
 fUFnw8cvHKCJb59Y/Pr2NEQMq2TwmQzLz/LTiuPhZeZKiM2JUjMAcKEiLaqZ6brwB0oXDKbV8h/
 QGpUI3pNd8Y7oAdpmSfrSQ0oTV2FNcICpecmlZ2ESHB+k/crk55W3g==
X-Received: by 2002:a05:701b:4558:10b0:183:d275:cf76 with SMTP id
 a92af1059eb24-1b5568bfe8cmr29796063c88.2.1795675446057; 
 Wed, 25 Nov 2026 22:44:06 -0800 (PST)
Received: from localhost.localdomain ([14.47.155.101])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b556829d31sm76548135c88.9.2026.11.25.22.44.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Nov 2026 22:44:05 -0800 (PST)
From: Minseok Kim <kor8821@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, m.wilczynski@samsung.com
Subject: [PATCH iwl-net] ice: bound the node count in ice_sched_add_elems()
Date: Thu, 26 Nov 2026 15:44:02 +0900
Message-ID: <20261126064402.87229-1-kor8821@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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

ice_sched_add_node() appends to the parent's child array without
checking that there is room:

	parent->children[parent->num_children++] = node;

That array is allocated in the same function with exactly
hw->max_children[layer] entries and is a separate allocation from the
node itself, so a write past its end lands in unrelated memory.
Neither ice_sched_add_node() nor ice_sched_add_elems(), which drives it
in a loop, bounds num_children.

The bound is enforced one level further out instead, in
ice_sched_add_nodes_to_hw_layer():

	if ((parent->num_children + num_nodes) > max_child_nodes) {

ice_devlink_set_parent() does not go through that wrapper. It calls
ice_sched_add_elems() directly to create a node for a devlink rate
object, and has no equivalent check of its own, so re-parenting rate
objects onto one node is only limited by how many children the
firmware is willing to create.

Bound the request in ice_sched_add_elems() rather than at the call
site, so that both callers and any later one are covered. The check
sits before ice_aq_add_sched_elems(), so a rejected request leaves no
hardware state behind, and it returns -ENOSPC, which
ice_sched_add_nodes_to_layer() already treats as "this parent is full"
when it retries on a sibling.

The existing check in ice_sched_add_nodes_to_hw_layer() is left alone.
It returns -EIO instead of -ENOSPC when the full parent is the TC node,
and that distinction is caller policy rather than something the callee
can reconstruct.

Both callers of ice_sched_add_elems(), ice_cfg_vsi_qs() by way of
ice_sched_add_nodes_to_hw_layer() and ice_devlink_set_parent(), hold
pi->sched_lock, so reading parent->num_children here is serialised
against the rest of the tree.

Fixes: 42c2eb6b1f43 ("ice: Implement devlink-rate API")
Signed-off-by: Minseok Kim <kor8821@gmail.com>
---
Found by code audit of the two call sites of ice_sched_add_elems().

Notes on testing and tool assistance (per
Documentation/process/generated-content.rst):

- Tool assistance: Claude Code (Anthropic) was used during static source
  auditing of the two ice_sched_add_elems() call sites, to draft the
  commit description and the bounds check, and to run the build and
  style checks.  All findings, the code change and the commit text were
  independently verified and edited by the author, who takes full
  responsibility for the patch.

- Testing: compile-tested only, on x86_64 (defconfig + CONFIG_PCI_IOV +
  CONFIG_DCB + CONFIG_ICE) with `make W=1
  drivers/net/ethernet/intel/ice/` against a baseline build of the same
  tree: 0 warnings and 0 errors before and after, with an empty diff
  between the two logs.  scripts/checkpatch.pl --strict reports 0
  errors, 0 warnings, 0 checks.  No runtime testing was done: I have no
  E800-series hardware, so the capacity path was not exercised, and the
  behaviour change should be treated as untested on silicon.

- Not Cc'd to stable: I have not shown that an over-capacity request is
  reachable in practice, since hw->max_children[] is itself firmware
  reported and the firmware may refuse the extra child first.  This is
  offered as making the two callers of ice_sched_add_elems() consistent
  with each other, not as a fix for an observed overflow.  If you would
  rather rely on the firmware here and drop it, that is a fair answer.

A separate patch to the same function is on the list, "ice: Do not free
a preallocated node in ice_sched_add_node()", Message-ID
<20261119055731.55798-1-izaiahsun@gmail.com>.  The two touch different
hunks and should not conflict, but they may want ordering.
 drivers/net/ethernet/intel/ice/ice_sched.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index a5c7a4e1c..ae4528347 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -909,6 +909,14 @@ ice_sched_add_elems(struct ice_port_info *pi, struct ice_sched_node *tc_node,
 	int status = 0;
 	u32 teid;
 
+	/* parent->children[] holds hw->max_children[] entries for the parent's
+	 * layer and ice_sched_add_node() appends to it unconditionally, so the
+	 * request has to be bounded before any node is created.
+	 */
+	if (parent->num_children + num_nodes >
+	    hw->max_children[parent->tx_sched_layer])
+		return -ENOSPC;
+
 	buf_size = struct_size(buf, generic, num_nodes);
 	buf = devm_kzalloc(ice_hw_to_dev(hw), buf_size, GFP_KERNEL);
 	if (!buf)

base-commit: 25faec9ce61c01fb45abf812a222c5b43c3cd5c5
-- 
2.34.1

