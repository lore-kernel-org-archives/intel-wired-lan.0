Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E993D606A31C
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Nov 2026 12:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=rnvS7I0g;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Rg5Emr9i
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C7FF94091D;
	Thu, 26 Nov 2026 12:31:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nrpVBbBXzhXT; Thu, 26 Nov 2026 12:31:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3AB2840897
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795696309;
	b=su1fnCwuyUCIC4IthAqxY8e2Ccf9/g4QJCwWGPXRUy0U8OazfZWjnbBqnO6sm9hK8id/
	 jXRTw4tN9z038aGEmpn59ThstUPJ7oRwAhVIm8YmS6PXEKgxL5IwMciBYpIODcZOJUU99
	 kOEM0e6g4XoyP4As7vwwqI4zulvQy7HMJ4W5Ca89ykkTuqQJNb+Nv+82rgV+w86Y1GByW
	 4PR3SB+dZYvSy1GTN931/d9fCGjswMHkXHKElKZtK++82i3MpYjUIxk0Vhwb91scXA0l3
	 p2O8gQqpxUbQhGGZYDWmimPhNBVWsA90a8QkbnBV6uEW9Ny499RVJS6jtQmoZBcqrSg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795696309;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RtyNGEelbIZDyipTekjJ45iDxVB44N9r7jXvjzEw3D0=;
	b=OzL4VtYP5jx+chNbCNhYW1FH8lgKeBbqFy6E2o3Vn8n6M67W2Cqq/7mevX/bj8EvjUip
	 FEraPSp+5UksOFvAb99KRlieiu+ZkxIcQ0xht76dkxKM0wedbU4T+LpFoIjEX7gEjn1Oe
	 fgtEEBx7BTl2V17O7J9T/mjBGv6z5TSan5Hb+OJ/A/Jb641Dpv/BCZoNbjOmxCzixzB45
	 FPWRS1Uc1g8MaRUFRBeqHDJtOF2+8QsbtBO2bXTpd54tU5ieO+8qInYU0Y5biQMG1lDQY
	 TErCSTVopcYcxSqK5KERxnqvhtpAZIocupKB68x6buKAnIlb5eMv/I80Q/q9gwLDEEw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Rg5Emr9i;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795696309;
	bh=RtyNGEelbIZDyipTekjJ45iDxVB44N9r7jXvjzEw3D0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rnvS7I0gtzkWHiZ4ahi0NZBVfyxkt5dDDC9dkUQQJK3b3rXCVpJrhtHhnHtVLAEzC
	 5Juge9qdI7nFlKC/jyq185rXVamT/XbOyct9whrDvw13mXMWwr501k6kZVgeTaLfmd
	 zXQfoFuNNf/nXndVm+RNsuCjNoYjbIaWCFfjFEEIeA2hDLx/GkQg5WbJjRGNUlrTkw
	 IG3QhmspwaE8Lzw9ap5aqdF3icNQbjgex3Ti9IJsCRl2yU+2ET6zr1bS289/JbRbXG
	 csTEmdoLBRS4U4wqco487Ddl0ZmfXAcJkJvFwkgi5VLRz81zoc5UXsMUShv7H7tZDT
	 foLzOOcJl1YLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3AB2840897;
	Thu, 26 Nov 2026 12:31:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B1F171AB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 12:31:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AF43840897
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 12:31:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BzlCh4KMqlsK for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Nov 2026 12:31:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9173740816
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jramaseu@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Rg5Emr9i
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9173740816
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 12:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795696305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RtyNGEelbIZDyipTekjJ45iDxVB44N9r7jXvjzEw3D0=;
 b=Rg5Emr9itwpgtNOZgSN8J5YWFlG9IYHQkLvNBkCOwFke7Z6qNEZlon5YWIIQNHGpMEGEcm
 GFwtG4wjGkVCcVsm0pC4Az/IEB7IEKNRMKTkUktfO6w2jggAVskmGBjJKjxUftLoKfQkUo
 iPovI59puELZ8tVK0eLPDr40Fj9xEa0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-cWeMPNV1MfeXjxEDY4Perw-1; Thu,
 26 Nov 2026 12:31:38 +0000
X-MC-Unique: cWeMPNV1MfeXjxEDY4Perw-1
X-Mimecast-MFC-AGG-ID: cWeMPNV1MfeXjxEDY4Perw_1795696297
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B125180025B; Thu, 26 Nov 2026 12:31:37 +0000 (UTC)
Received: from jramaseu-thinkpadt14gen5.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7DB0130002C2; Thu, 26 Nov 2026 12:31:34 +0000 (UTC)
From: Jakub Ramaseuski <jramaseu@redhat.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 Jakub Ramaseuski <jramaseu@redhat.com>
Subject: [PATCH iwl-next 1/3] ice: release the profile ID on ice_add_prof()
 error paths
Date: Thu, 26 Nov 2026 13:31:12 +0100
Message-ID: <20261126123114.893916-2-jramaseu@redhat.com>
In-Reply-To: <20261126123114.893916-1-jramaseu@redhat.com>
References: <20261126123114.893916-1-jramaseu@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: PJ6QiCM27iBdKOGRL6CkYGEGCuvvX1rak2DdEPMqFFI_1795696297
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

When no profile ID matches the extraction sequence, ice_add_prof()
allocates a new one. If ice_update_fd_swap() or ice_update_prof_masking()
then fails, it returns without freeing the ID, and if allocating the
profile map entry fails, without dropping the reference it took. Either
way the profile ID, a resource of the whole device, is leaked.

Free the ID on the first two paths, and drop the reference on the third
before jumping to err_ice_add_prof.

Fixes: 31ad4e4ee1e4 ("ice: Allocate flow profile")
Fixes: 148beb612031 ("ice: Initialize Flow Director resources")
Fixes: b199dddbd399 ("ice: Support non word aligned input set field")
Signed-off-by: Jakub Ramaseuski <jramaseu@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_flex_pipe.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
index 2a054d3abd466..6d619eeaf0190 100644
--- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
+++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
@@ -3065,14 +3065,18 @@ ice_add_prof(struct ice_hw *hw, enum ice_block blk, u64 id,
 			 * during Tx.
 			 */
 			status = ice_update_fd_swap(hw, prof_id, es);
-			if (status)
+			if (status) {
+				ice_free_prof_id(hw, blk, prof_id);
 				goto err_ice_add_prof;
+			}
 		} else if (blk == ICE_BLK_FD) {
 			ice_disable_fd_swap(hw, prof_id);
 		}
 		status = ice_update_prof_masking(hw, blk, prof_id, masks);
-		if (status)
+		if (status) {
+			ice_free_prof_id(hw, blk, prof_id);
 			goto err_ice_add_prof;
+		}
 
 		/* and write new es */
 		ice_write_es(hw, blk, prof_id, es, symm);
@@ -3083,6 +3087,7 @@ ice_add_prof(struct ice_hw *hw, enum ice_block blk, u64 id,
 	/* add profile info */
 	prof = devm_kzalloc_obj(ice_hw_to_dev(hw), *prof);
 	if (!prof) {
+		ice_prof_dec_ref(hw, blk, prof_id);
 		status = -ENOMEM;
 		goto err_ice_add_prof;
 	}
-- 
2.56.0

