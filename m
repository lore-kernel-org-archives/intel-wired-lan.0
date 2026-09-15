Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C455DC88E75
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 12:56:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 93A7380E12;
	Tue, 15 Sep 2026 12:56:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kLO7mxEzCNLu; Tue, 15 Sep 2026 12:56:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 116A980E15
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789476976;
	b=JGL4zQUip2L2mF/iEKk99wCICooofnA3I+6NsWRTnTeDh9yHeZZxnYdw+Mcukqz0HvTa
	 214s0g7IOVXHjsLTqoZaGZpuEHfj7F9nwD6QzLZHGugUMnVK9Q5FAQhvbBNGvTVthw7PF
	 x5ttHYoMo6LVUpnfNUPFfzQLrOe3628kj2tRo74gDY9vL7elMx5WXIbWK4L9m90xy/VMz
	 /8DAkGh5luvVEMYaP9ZBrUyCcWvNk8KYYO6LGnmor7AlcqG6qTNiFChCUSkymH4jW8KRH
	 zHlOOrRAQ/hRjODQ5owmb/IrDztvO2LL2U1qak5+leRr8EvaFhGGDwakkZdnVWR0e+g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789476976;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+pCqEr9lLw+dH6q9nSPT+xqGs/Szd1f3MeMEStKrMkA=;
	b=bDjRYtMjiM+g9SMzbXgGDo4IUY6iNRXZS0cxAuILHvX0u3eg+AIMlAcF0QGC8d97Guzi
	 ElkTZy66RVPd8XWRiUFJF80kFbrml6krnZXhYIBz5YkdRcNuCD7eYbPkx20xj3KHCsuTe
	 oPk2nKsLawySmHbtU8WF5/hY0AgKBJUetVqbQPiOeEPfmhglkE0viEt9snluFrH0YJyqZ
	 Z2srplo8qkvgo3XpDi9NIvAslTvNrwmzp+d9vWXbGfkYgBCJFtqKkVhH9l1ZRv+qyzna9
	 ofKS0JdYaoeV5gZeiP/4sY/FL042eWQhr///VCcFVwXHVPH6jOgw04W5pSDpVR+UZvA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789476976;
	bh=+pCqEr9lLw+dH6q9nSPT+xqGs/Szd1f3MeMEStKrMkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nEm0IF/bNEh4R258CN84NbV3v0NQ9OLZJKVjF3j8WqL59Ddd1LTZAkMAu07mLfJFi
	 SoT3dzQbCPFscJUI8ynBocBcjrPw/bJ2ZoLBDSyitFNEEZrmnfset3bdPh9hg1Y0V6
	 Zh9+fbZPw8x2l+0eDVvadh31ewRwhY/v0FSzpJVSm/D1XCZM4VTo0fP32aE2GSmD36
	 eWFPi/kZIaK6hmKUt7oURAtRE9akWrWjiQc7aQej21fXV1XTUIwhIIaT5M1xFPeNyx
	 PKr7nRtxZMhZM/h6D9vdxQxo9W1sVQg2lu1PgqRXrAuU/ivzCeg09fLxFDfEQM7Ppg
	 yGKB+dh/pcuuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 116A980E15;
	Tue, 15 Sep 2026 12:56:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DCA10259
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:56:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C30484002B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:56:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JMYqwMOMUrIP for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 12:56:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 1B95C400DC
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789476970;
 b=c4Q8A7IKPrhULpQCvA++8xZxDkMZ0bs9GhXlb7loNVMDprQ9RsRq7E7UWTHw7c0qH5mk
 7yH2px+JNGJzzzSWOHWmKcwV5FO0gY9MqWMOYU8Q75L5kHvK5kTlSRsP61YZFOQ2xsRT6
 p08OI7iVTtIhdqYBP+Sgz4f+yxgLB/b/a+IrN46h0fBJWsJZZnD6fquFf0zxtda03mHk5
 BGHgc6STD7jqa1scy/FvXxi243YDXl5y1rfvWNLd3bYCljArTJ4NJyELZNimXxIU9WyFU
 rwhvfRQr36nAKOkv0KxSNIff/+IynCylL4rv8uG2qHfEsqHVcexK6gEnI9dFlfhkGmw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789476970;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:Received:From:To:Cc:Subject:Date:Message-ID:
 X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=+pCqEr9lLw+dH6q9nSPT+xqGs/Szd1f3MeMEStKrMkA=;
 b=K7S+J0ZWvox5XqOI96lZjodPDuZymhkaE16t32BGtrYH1cPXZBvlGV4cZ54MNj/AMTbR
 PrAGsQM2smx/5KJasmJ16xSnSNRJLkt4MwecIOioz0C7hlR5Rm5YAqrCaW2TwTF3rTBWS
 VCZ3p1rYIcVd50gtJ1u5a/M4mTzAkmmnM+ly6iZj1o7/wpiEJ3nX7SrTzW2WhZljpA2OJ
 SbwDhaJPRjsgb4ZA8NxzCFU/WTPjOb6jeL+NEbOMWxgD9OLFFBTlNWuUS2ZW73cuKRlQw
 ooNYYjG+aWA3KKBVEjBVd3alXzhk3Bl+g7zG8saTUdkjpH+YW50GOAvRoSkK3XnNbZg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=aEopU1ng; 
 arc=none smtp.remote-ip=198.175.65.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=aEopU1ng
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1B95C400DC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789476970; x=1821012970;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aM4iJYBdmPrwxDojTTWajxKiBW00z3SlPeWCh6QehOg=;
 b=aEopU1ngbDG507IRRGSA/byQU38lRZP4c0nrBXMj4tMH925Pv51pRXsD
 X5VRf1KIsny1V+R2YfCsNCgBiuNVDpXkKR3L/PC2kYvdNCInlv/7XkB4o
 Dlq+B5vx0hcxOoKbakh6m7F/pfrtZl/Dd7fxKRtuuKSGIyq/yBPwCG+dA
 7O40SR1PNY+67mkTpGjD7lgVMMuEXFXyRlN9AlIAC9+l6UtmETvw1+BLZ
 33ndDYSiAHVsradr5wPfwBGROeaIXoU6s4LwvLjdpPClLjmfKfkUqNSkM
 x17YfDgDFr1Uootu2i9fZ+oZM/MvPAlwpZlNTA1Kv3ARzQEWwe2RLQK7S g==;
X-CSE-ConnectionGUID: KvI42CqlQJmWXyUkdyw6tA==
X-CSE-MsgGUID: pgtsjd8JQHCWgIHkW0aYtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="112607095"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="112607095"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 05:55:59 -0700
X-CSE-ConnectionGUID: TI4Y5hk0Tjej+rVZrZOJAw==
X-CSE-MsgGUID: VEK50ZFuTma+yQau4hptEQ==
X-ExtLoop1: 1
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa003.fm.intel.com with ESMTP; 15 Sep 2026 05:55:58 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Avinash Dayanand <avinash.dayanand@intel.com>
Subject: [PATCH iwl-net v2 4/5] iavf: fix TC boundary check in
 iavf_handle_tclass
Date: Tue, 15 Sep 2026 14:55:50 +0200
Message-ID: <20260915125551.3976068-5-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260915125551.3976068-1-aleksandr.loktionov@intel.com>
References: <20260915125551.3976068-1-aleksandr.loktionov@intel.com>
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

From: Avinash Dayanand <avinash.dayanand@intel.com>

The condition 'tc < adapter->num_tc' only gates the destination-port
check for in-range TCs; when tc is out of range (tc >= num_tc) the if
body is skipped entirely and the function falls through to
VIRTCHNL_ACTION_TC_REDIRECT and returns 0, silently steering traffic to
a non-existent traffic class instead of rejecting the request.

Simply flipping the comparison to 'tc > adapter->num_tc' does not fix
this: it would let every in-range, non-zero tc (tc <= num_tc) skip the
destination-port requirement entirely, while an out-of-range tc with a
destination port set would still fall through and return 0.

Fix this by explicitly rejecting tc >= adapter->num_tc with -EINVAL,
and only then requiring a destination port for the remaining in-range,
non-zero TCs.

Fixes: 0075fa0fadd0 ("i40evf: Add support to apply cloud filters")
Cc: stable@vger.kernel.org
Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 29b8403..deb03f2 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -4047,12 +4047,15 @@ static int iavf_handle_tclass(struct iavf_adapter *adapter, u32 tc,
 {
 	if (tc == 0)
 		return 0;
-	if (tc < adapter->num_tc) {
-		if (!filter->f.data.tcp_spec.dst_port) {
-			dev_err(&adapter->pdev->dev,
-				"Specify destination port to redirect to traffic class other than TC0\n");
-			return -EINVAL;
-		}
+	if (tc >= adapter->num_tc) {
+		dev_err(&adapter->pdev->dev,
+			"Unable to add filter because of invalid destination traffic class\n");
+		return -EINVAL;
+	}
+	if (!filter->f.data.tcp_spec.dst_port) {
+		dev_err(&adapter->pdev->dev,
+			"Specify destination port to redirect to traffic class other than TC0\n");
+		return -EINVAL;
 	}
 	/* redirect to a traffic class on the same device */
 	filter->f.action = VIRTCHNL_ACTION_TC_REDIRECT;
-- 
2.52.0

