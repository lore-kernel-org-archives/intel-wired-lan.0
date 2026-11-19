Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF57606A32C
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 17:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=KHAFTJQs;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ipgeeSvP
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5679460D5C;
	Thu, 19 Nov 2026 17:25:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3iOu1_kdp5-5; Thu, 19 Nov 2026 17:25:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B383360D98
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795109106;
	b=aQlgSpSCL3NpX0j3gA9cd2Yrly2HM4HV4sWJo8C26KHx1yGzYnWOttENQCKtrAaHwE5D
	 zMjf+gquAD77mtBU0Q+h3vivLmkTFnXSvPQoJ6BnzvE9rTNENmlRacBeaa0his4L08FEl
	 yh7ZKsNKBShZavDA718tEhjBJawGZXtQGghT8Yau4Armel9/oZOUmBptt+V2lR7BCO+Kv
	 Y8EWUPi6OlxZ6PXavZ4Ig44XoypQAhTDBWgUn3VRpi7Sw9T6n48+BK3kn69OtlC/O0efR
	 atuX1L0OaLAJtBgfTMyR8h0dZy9K5y2w1yXg+AWeEC3LrSUKZIPMY2BtPpprQInESsg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795109106;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 Date:Mime-Version:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2o0ILC3keCwMhrgGZ6aMyUvzYh9D8kgarIcL8NMwQRU=;
	b=N/G5b0GvL702z66/0857x9IkxKEe/NAhao0JyZ7K1WJbK5mtBEbTRRmviWXW0UDEMp5p
	 +yqGShGWePlMfn4aqaPQnajcVHc488pKg4Z5SdC9VptfNAMoCeWxhf5yKr0DCn+6GGQOs
	 EFsTCyA99b1qmh50vOlVbaNVxEyPt5wPna7Q5YZNFtd68qPIVQYYIbgY8kGipDQXsfXrn
	 sr1EyjNGDBHMrCy/d9xrZ2xfn8pp+CAYb6JpLyQHTMz3BO2wVDoISnolphdUlkxdZAq94
	 2aBUfjkCzVBucoJYV+iKxQmxfWPblhYvvn4efPVJCuaSWUgajc8J4yupOy7nuH3m1/A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ipgeeSvP;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795109106;
	bh=2o0ILC3keCwMhrgGZ6aMyUvzYh9D8kgarIcL8NMwQRU=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KHAFTJQsdtqAnVepH1qwSh6HbrZWdczSjzcyt8+ioMSVK7Onj5qH65+C/b+eckGrv
	 qhGKpCM6z3ul75cfmVrV58RJRC1y6og8UHsXiiQrSwdw6+j5v06Il7cYA0FzVpo4aK
	 +sUkJjgD55xgzb3fbRZdOJyIUuAg5YXvCeAgzKmlLr2QzfPf05M6wWgofryjLj3wSV
	 iviTOJdf/PIaKv9eV4QwPsd8FE3gmW5KtFFxgi2P4ZMBSl9ef2rYriYoEquJtcr9Us
	 awVY1C5uC9N4k+w0hARP9+BtS5P+KpHobBok+X5HdT7mNqYBdI8L1VlVPfsUBWDftW
	 pAvyb36J3l83Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B383360D98;
	Thu, 19 Nov 2026 17:25:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 503982FB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 17:07:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 412DD606A8
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 17:07:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IITWz_CHEbbh for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 17:07:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6F64860699
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1345"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1345; helo=mail-dy1-x1345.google.com;
 envelope-from=34cz_agckd5u7gd53gh5dd5a3.1db7ci3a-l7g32-azca7hih.dhjdha.dg5@flex--irogers.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20260707 header.b=ipgeeSvP
Received: from mail-dy1-x1345.google.com (mail-dy1-x1345.google.com
 [IPv6:2607:f8b0:4864:20::1345])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6F64860699
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 17:07:45 +0000 (UTC)
Received: by mail-dy1-x1345.google.com with SMTP id
 5a478bee46e88-3724667bc16so872457eec.1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 09:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795108065; x=1795712865; darn=lists.osuosl.org;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2o0ILC3keCwMhrgGZ6aMyUvzYh9D8kgarIcL8NMwQRU=;
 b=ipgeeSvPAB2nqjJYeYektFCV7mcKTchUbugb0DnLBfctnQ0YbI1S43iBaeZYnAiFpV
 lwnYhX18YQ0T2/HBQtncUkcQfU4yhQkBv9Iw1wNyrp/kcXe/tucctsyBcylFxxchIwKQ
 J9vw7JRzOB9ixNihBEaNY9jLqXKWjB9EzmbKQEC38OgZd3qx4LjAxjH+gHBAq49FNHSv
 6QTd9Roz6rA+Ewne09gDEylBkv8v0xP5aNWZAp4m3M7JmTiLQz67DSJytrJxV8k50L69
 Bl9GVB9FSlUEbzfm1W8Jd1fHizAkwWpO0Agg1WFVf4Q6UBrJoWFujaWjub3YTUovaOnc
 IhkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795108065; x=1795712865;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2o0ILC3keCwMhrgGZ6aMyUvzYh9D8kgarIcL8NMwQRU=;
 b=k5xOdCg1Q/syB3O/oowb1flPbFK3vLfgfIPLRyoGlWhdA1FnWxmvPYb67A1XvaoZ+r
 h9HFbJJ6LA+z/7KW9LRSkNqyPZ77NBanT5Gy0oSEKb8q/J2WCNpvEMUI4/Efurb5FMte
 F1tpys3BHktZngdLh779j1BscfapcoVpXMqUSLbn5UMpYU7efXx3lmRuphOQzu4hw77w
 yjzFSdS+22vxowV2W+OMie3mhMYVqfWyoEd6Upg3qq64FN76j8rgkXL43/URNCeM+jc9
 vfgCXdC++FeDgCPxUdsvDLu1eMcwpEU062L7+HPG8QT61LyngWySltG17aymc/w9h6yd
 7CVQ==
X-Gm-Message-State: APuU4Z+9+E0frAD25hrLVxqPRY0TsQ0rW2+Z3yfJd0PhM4ScTxNqnuI0
 EcKP5KkKG9FLfc/+T6vi1+DWd6XTSbmgFrFt+9VWmgq1JPbF7C5wk/t7ADbQ9UHqP4v91CZgMSn
 ukxTJVlo8tA==
X-Received: from dyr9.prod.google.com ([2002:a05:693c:4009:b0:385:23b2:bccf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:51d4:b0:384:fef7:5876
 with SMTP id 5a478bee46e88-384fef75c78mr1005650eec.24.1795108064646; Thu, 19
 Nov 2026 09:07:44 -0800 (PST)
Date: Thu, 19 Nov 2026 09:07:41 -0800
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261119170741.1525395-1-irogers@google.com>
Subject: [PATCH iwl-net] i40e: ensure owner VSI is found before dereferencing
 in i40e_veb_release()
From: Ian Rogers <irogers@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Elkin Cruz <elkin@google.com>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 19 Nov 2026 17:25:05 +0000
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
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

i40e_veb_release() counts all VSIs attached to veb->seid in 'n', but only
assigns 'vsi' when I40E_VSI_FLAG_VEB_OWNER is set. If a non-floating VEB
has a single remaining VSI without I40E_VSI_FLAG_VEB_OWNER (for example
if the owner VSI was moved or cleared via debugfs switch operations),
n == 1 passes the 'n != 1' check while 'vsi' remains uninitialized on the
stack and is immediately dereferenced.

Initialize 'vsi' to NULL and refuse to release a non-floating VEB unless
both n == 1 and vsi != NULL.

Found via an x86_64 LLVM=1 (Clang 21.1.8) allyesconfig audit with
-Wconditional-uninitialized enabled; fix and changelog drafted with an AI
coding assistant. Build-tested under LLVM=1 W=1 (-Werror) and
-Wconditional-uninitialized; not tested on Intel XL710/X722 hardware.

Fixes: 08cdde310e22 ("i40e: Fix broken support for floating VEBs")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index abbc71e815ae..8d4213b7dd92 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14718,7 +14718,7 @@ static void i40e_veb_clear(struct i40e_veb *veb)
  **/
 void i40e_veb_release(struct i40e_veb *veb)
 {
-	struct i40e_vsi *vsi, *vsi_it;
+	struct i40e_vsi *vsi = NULL, *vsi_it;
 	struct i40e_pf *pf;
 	int i, n = 0;
 
@@ -14735,7 +14735,8 @@ void i40e_veb_release(struct i40e_veb *veb)
 	/* Floating VEB has to be empty and regular one must have
 	 * single owner VSI.
 	 */
-	if ((veb->uplink_seid && n != 1) || (!veb->uplink_seid && n != 0)) {
+	if ((veb->uplink_seid && (n != 1 || !vsi)) ||
+	    (!veb->uplink_seid && n != 0)) {
 		dev_info(&pf->pdev->dev,
 			 "can't remove VEB %d with %d VSIs left\n",
 			 veb->seid, n);
-- 
2.56.1.708.g77570a6a1d-goog

