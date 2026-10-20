Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1051606A31A
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Oct 2026 19:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=3DCzpDYx;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=gCU5Nxy9
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D2D2440707;
	Tue, 27 Oct 2026 19:57:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id epAb1VavSMCD; Tue, 27 Oct 2026 19:57:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C6BD5406C4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793131047;
	b=Mo+h/W2VeSkvv+vdTmR7vPqO7xJStY9oHhQPiXBTZTXOdchX8cK1zHK6bCv65CwAhzOI
	 Kvh11UN2xQl+iSnCnuwQ/iMArv1yhdBLZ7GL4ieAdVH7JyvnX6UhgCSfB3CFk4I3f0BW7
	 CApbrXhyHjRPZ5645n2fz+Fm3w31GYQMfPnQr+O4JWrarKEdi3bNWOuTUwwLHYy4kQfgd
	 VZnquLLEh8J5DeEXltilPPa4fieXfllDsg/nn1YqE4Pr/Tukw2Mb5oFodDXsUI73N2n4F
	 rLc/nh3cPCwXUke8v7sQpj7ZWJFqeCuqGKZpr3rPu54yBNZfhbPMmBK9C9WtAKpmPEQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793131047;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BMmQHiAE36nIASIRrotnQa66U6rilX4DL+YQyDlPz+A=;
	b=XGLVFT/5SlLbDrydQHyutlRFnPotSQN5OyQQzqTIRlZoS8Jlk2ntntaVQoUlzreBJuoV
	 hHykxjequCX/hXqtLynRiSUfyGg4SRG9YvMantgjwpITU6YhPlxyS6EGYu5Ay0lM0xs4N
	 VaqDTK6wQ1MlpiGFt5duRtkYjBB5+BVaRyF6RYqdQc/yS/AWaEoBfh2JxqiSUShOIh8UH
	 Xhn/EIsXKzBIYid/3yJLKi0DCuXLPlymSF4MtfV19/BltILUKRhrlMhAD5ZgeRe2oZUYQ
	 x+JrFF+LdkzsmWX4iKiAyfdniFGCDKwPTzqKI7C+BOxrFeky7LhRFCLnarY1+PYAIqg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793131047;
	bh=BMmQHiAE36nIASIRrotnQa66U6rilX4DL+YQyDlPz+A=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=3DCzpDYxDYunaf1b/xKRZ5S0BsXYqIqOL6xtc6HQTpa2S5Uemhk1VJuiNw9gN8zkx
	 v84znCXJcvU3e9BFp19s9uKmQI06HGmKNGXkVsOm4NbodYxstxnxHmTtQeQ+RqgtGJ
	 qObD6hL95521pfP58ER9Cu7z1PZZOXl1WI8k6f1S1ETeg73tjvpZaSbN+8PFrNZXRL
	 8q8aO1MpNdjkPWYUL/CVIPKNXW0ehV9vn97ebXxPqV2ByDdj5FzscDb8vxgTyesbEC
	 HeXJKW1MPckq3KYGPhrheZ9TUjHvSADZAiZQV1+gT79BQ+yESovGZ2SoWciTWo8ZqC
	 Nf2B1YDEH5HOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C6BD5406C4;
	Tue, 27 Oct 2026 19:57:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D5C33A8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Oct 2026 03:01:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5F797607E9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Oct 2026 03:01:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id igWnp_giVc8C for <intel-wired-lan@lists.osuosl.org>;
 Tue, 20 Oct 2026 03:01:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 540CC60774
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792465317;
 b=mXN5wAXMnA1vTUgSyZ5nleAQeP4+NYWoWnfOvZDmkjGDN2GJ+YLvluiAJNL9wc1m4rpG
 MpDFc9rTdARJXW5j2xPcloDz4KdG0QuBLh8W58233KZIcapoLY5XF4kyGKYAeDeo6iDz0
 xQBTUxhgjtxr5RtErzXddt1IILPtVLe65RIDQ+eYdF+qC7+vLon5f+xBPhHJKhHTlw6hu
 zALTrkYeEB5A19ZVMoREXzMZupMJ6ggr7poaz7DX8djWAz0zRc/3ABYZszV/HShenh85B
 FZRdVIE5eBxEqI+MRbpr07oe+GB416ugEvqmZSRcm71E8I0sSX6OjXpSY7TytPUim7A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792465317;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
 bh=BMmQHiAE36nIASIRrotnQa66U6rilX4DL+YQyDlPz+A=;
 b=H9sEqneTujNOrsvcC0ZrT7gEnvNEHNTO8io6PBNetvF1+EIBZgs1NYFaOpsmQhN6+74O
 jZ/uOMyV7N33qhHO1bMcXgcSJZ5hfHyhj/2Vg2gt6xxpS80VVytbYCTND+Fkmln7KU4v8
 3cTH2aOARmQUmrGGdLAlqgQxaaWMlCaGNEmuRZj6abZahXkK0DTlcY8cWwBYn8Bf/asC+
 FT2JLyO9CJON3S1MWtVEEmwPVpE4Xt6PC0+esk4pQdrQ00pc+sp3iJQuODZ9xooKr3Ngv
 iAYYQ1nOYykPASPXJZ/Fd7e+e+klq1BTP/pfUYdRar1Q3zOBYdJRtEp6E2DZaBDSuxg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=163.com;
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=gCU5Nxy9; 
 arc=none smtp.remote-ip=117.135.210.5
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.5;
 helo=m16.mail.163.com; envelope-from=18983559317@163.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=gCU5Nxy9
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 540CC60774
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Oct 2026 03:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=BM
 mQHiAE36nIASIRrotnQa66U6rilX4DL+YQyDlPz+A=; b=gCU5Nxy9iuFLzF8Shl
 KuOARUY8tjIrvLjcwQSTaDenxZSfeH3Za6uNOfiGcJePgr+I+hGskY0bjYr2mVMh
 aT0KA6V4ybEKYa5xElXS83CgAmxPDSD5pr8mYllXN3wKd9k2BFgfXLBx9000NoH3
 uxwExbzo5dICDpJNvs7VBL45Y=
Received: from colol4bi5.localdomain (unknown [])
 by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id
 _____wDHf2Hy2NZqJUlhBA--.53240S2; 
 Tue, 20 Oct 2026 10:58:59 +0800 (CST)
From: Binbin Deng <18983559317@163.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Binbin Deng <18983559317@163.com>
Subject: [PATCH v1] i40e: Lock VF cloud filter list operations
Date: Tue, 20 Oct 2026 10:58:56 +0800
Message-ID: <20261020025856.519623-1-18983559317@163.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDHf2Hy2NZqJUlhBA--.53240S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxArW8Cr18KFyDtFWkArWkWFg_yoWruw48pr
 4ruwnrKr4DZF1UW3yDtr4DCF1rG34kKFW7uFyftas8JrZxtF1Uuay7KFy5ua4kCryUArnx
 XF1qva1UZrZrC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piL0ePUUUUU=
X-CM-SenderInfo: jprymmytvvmjmrxbiqqrwthudrp/xtbC+xPCpmrW2POUbQAA3i
X-Mailman-Approved-At: Tue, 27 Oct 2026 19:57:25 +0000
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
	FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A VF's cloud-filter hlist is modified by the virtchnl add and delete
handlers and by i40e_del_all_cloud_filters(), which runs when ADq is
disabled or when the VF loses trusted status.  These paths do not share a
lock.  In particular, the PF's async VF-message handler can process
VIRTCHNL_OP_DEL_CLOUD_FILTER while host-side ndo_set_vf_trust() removes
every cloud filter for that VF.

The race is reachable from a guest by issuing cloud-filter virtchnl
requests while the host revokes VF trust or disables ADq.  The VF-message
handler can traverse nodes that the bulk-delete path has already freed, or
both paths can remove the same node.  The result can be a KASAN
use-after-free, hlist corruption, incorrect filter accounting, or a panic.
The virtchnl operation-pending bit does not serialize this host-side trust
path.

Serialize cloud-filter control operations with a mutex.  Hold it across
the firmware add or delete, hlist update, and free, so bulk deletion and
individual add/delete operations cannot observe a partially removed list.
The lock is file-local and slow-path only.

Found during a static-analysis-assisted audit: candidate sites were
surfaced by a Coccinelle rule, and the reader/writer paths were
confirmed by LLM-assisted (GLM-5.3) code inspection. Due to a lack 
of hardware infrastructureThe issue was not observed at runtime.
It is identified by code inspection only.

Fixes: e284fc280473 ("i40e: Add and delete cloud filter")
Assisted-by: GLM-5.3 coccinelle
Signed-off-by: Binbin Deng <18983559317@163.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index a26c3d47ec15..f73a710f42f1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -3740,6 +3740,8 @@ static struct i40e_vsi *i40e_find_vsi_from_seid(struct i40e_vf *vf, u16 seid)
  *
  * This function deletes all cloud filters
  **/
+static DEFINE_MUTEX(i40e_vf_cloud_filter_lock);
+
 static void i40e_del_all_cloud_filters(struct i40e_vf *vf)
 {
 	struct i40e_cloud_filter *cfilter = NULL;
@@ -3748,6 +3750,7 @@ static void i40e_del_all_cloud_filters(struct i40e_vf *vf)
 	struct hlist_node *node;
 	int ret;
 
+	mutex_lock(&i40e_vf_cloud_filter_lock);
 	hlist_for_each_entry_safe(cfilter, node,
 				  &vf->cloud_filter_list, cloud_node) {
 		vsi = i40e_find_vsi_from_seid(vf, cfilter->seid);
@@ -3773,6 +3776,7 @@ static void i40e_del_all_cloud_filters(struct i40e_vf *vf)
 		kfree(cfilter);
 		vf->num_cloud_filters--;
 	}
+	mutex_unlock(&i40e_vf_cloud_filter_lock);
 }
 
 /**
@@ -3856,6 +3860,7 @@ static int i40e_vc_del_cloud_filter(struct i40e_vf *vf, u8 *msg)
 	}
 
 	/* get the vsi to which the tc belongs to */
+	mutex_lock(&i40e_vf_cloud_filter_lock);
 	vsi = pf->vsi[vf->ch[vcf->action_meta].vsi_idx];
 	cfilter.seid = vsi->seid;
 	cfilter.flags = vcf->field_flags;
@@ -3870,6 +3875,7 @@ static int i40e_vc_del_cloud_filter(struct i40e_vf *vf, u8 *msg)
 			"VF %d: Failed to delete cloud filter, err %pe aq_err %s\n",
 			vf->vf_id, ERR_PTR(ret),
 			libie_aq_str(pf->hw.aq.asq_last_status));
+		mutex_unlock(&i40e_vf_cloud_filter_lock);
 		goto err;
 	}
 
@@ -3901,6 +3907,7 @@ static int i40e_vc_del_cloud_filter(struct i40e_vf *vf, u8 *msg)
 		kfree(cf);
 		vf->num_cloud_filters--;
 	}
+	mutex_unlock(&i40e_vf_cloud_filter_lock);
 
 err:
 	return i40e_vc_send_resp_to_vf(vf, VIRTCHNL_OP_DEL_CLOUD_FILTER,
@@ -4002,6 +4009,7 @@ static int i40e_vc_add_cloud_filter(struct i40e_vf *vf, u8 *msg)
 	}
 
 	/* get the VSI to which the TC belongs to */
+	mutex_lock(&i40e_vf_cloud_filter_lock);
 	vsi = pf->vsi[vf->ch[vcf->action_meta].vsi_idx];
 	cfilter->seid = vsi->seid;
 	cfilter->flags = vcf->field_flags;
@@ -4016,6 +4024,7 @@ static int i40e_vc_add_cloud_filter(struct i40e_vf *vf, u8 *msg)
 			"VF %d: Failed to add cloud filter, err %pe aq_err %s\n",
 			vf->vf_id, ERR_PTR(aq_ret),
 			libie_aq_str(pf->hw.aq.asq_last_status));
+		mutex_unlock(&i40e_vf_cloud_filter_lock);
 		goto err_free;
 	}
 
@@ -4024,6 +4033,7 @@ static int i40e_vc_add_cloud_filter(struct i40e_vf *vf, u8 *msg)
 	/* release the pointer passing it to the collection */
 	cfilter = NULL;
 	vf->num_cloud_filters++;
+	mutex_unlock(&i40e_vf_cloud_filter_lock);
 err_free:
 	kfree(cfilter);
 err_out:
-- 
2.43.0

