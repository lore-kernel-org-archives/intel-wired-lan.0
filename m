Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FAB6E81E18
	for <intel-wired-lan@archiver.kernel.org>; Mon,  9 Oct 2023 22:30:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1CA6660F00;
	Mon,  9 Oct 2023 22:30:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1CA6660F00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1696890600;
	bh=AuVSk9aMl0T2qoHE/kgHTK+7Lw+VvNl9pOHEsynAkI8=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=NuEYqvM707Sc9df65EOp60p3aujxLCgVHUdYmjw9u3S7Jt/CvtigWfkatX5YFt3ww
	 rePWrIzmfTatnPCzrO0eF4aUydY4fxk0Kf3oTDCrU0HLzEymWfPTIWeTJ1CGERtgnm
	 jW+NsTh8kfgDGgz7y/Ma/RD585EaT86sm5mq8EtYlSUIrOTTYxot8xZGOZRxPPmYDj
	 q45pY0nCQrKiymU4HOAiCSoPrKy6fp4CRFDkpxSHmXuvtDtlyBkicipbaFrUWyEMlB
	 mBTO83f1/u2yvOjXOG3sqROnvLYPV9SGnJQfqKF0MZI4Pyo6QXj8NGXYV1UlXVlXsc
	 nFBjZPlQOjIPw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xvd4KJAG4ZS5; Mon,  9 Oct 2023 22:29:58 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2597861037;
	Mon,  9 Oct 2023 22:29:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2597861037
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 18B391BF375
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Oct 2023 22:29:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F2E89402E8
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Oct 2023 22:29:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F2E89402E8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9gBNnsphT5rl for <intel-wired-lan@lists.osuosl.org>;
 Mon,  9 Oct 2023 22:29:52 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BB7B9400BD
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Oct 2023 22:29:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BB7B9400BD
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="2849446"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="2849446"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2023 15:29:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="843876605"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; d="scan'208";a="843876605"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
 by FMSMGA003.fm.intel.com with ESMTP; 09 Oct 2023 15:29:02 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: netdev@vger.kernel.org
Date: Tue, 10 Oct 2023 00:26:16 +0200
Message-Id: <20231009222616.12163-6-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231009222616.12163-1-arkadiusz.kubalewski@intel.com>
References: <20231009222616.12163-1-arkadiusz.kubalewski@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1696890593; x=1728426593;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CGI8OCuYRAuMfp/tnwmDEDUqTneEivLAfZlSuk7iWVc=;
 b=jfAItqHT7iFpwgFvwq/vB9+beRa0mzwgIkeJcR7VJqInbAl68EzpaiVR
 qMgbfi+MFkcA/Aut9eyfl6sNnKS8RqkAfNBaW552tGe/4W1NjI2NXUusn
 CLhYkFeQ3c9JjxRBs4FoagP9DRTY1nLd7tpL2ud/IhVHy7jknZE2hJfns
 FZ2mntevtJ5jlJ8/Hwt4W2OWmCydrxDSYbYVfnmiX+cft1EOICGLujRdv
 JK8E5J2Is1YJjBipxvSRTOhFVOwKJUwc2PkaZOMEANBvPWVM8jHqoTKZX
 5a58+R3v81uo9HZfe1gzEuOiUo8jPp4eAQ4pxgI3RwSCqkiYiefy0HDOf
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=jfAItqHT
Subject: [Intel-wired-lan] [PATCH net-next v4 5/5] dpll: netlink/core:
 change pin frequency set behavior
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: jiri@resnulli.us, corbet@lwn.net, intel-wired-lan@lists.osuosl.org,
 linux-doc@vger.kernel.org, jesse.brandeburg@intel.com,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 anthony.l.nguyen@intel.com, kuba@kernel.org, vadim.fedorenko@linux.dev,
 pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Align the approach of pin frequency set behavior with the approach
introduced with pin phase adjust set.
Fail the request if any of devices did not registered the callback ops.
If callback op on any pin's registered device fails, return error and
rollback the value to previous one.

Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 drivers/dpll/dpll_netlink.c | 50 +++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 8 deletions(-)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 09a6c2a1ea92..a6dc3997bf5c 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -615,8 +615,10 @@ static int
 dpll_pin_freq_set(struct dpll_pin *pin, struct nlattr *a,
 		  struct netlink_ext_ack *extack)
 {
-	u64 freq = nla_get_u64(a);
-	struct dpll_pin_ref *ref;
+	u64 freq = nla_get_u64(a), old_freq;
+	struct dpll_pin_ref *ref, *failed;
+	const struct dpll_pin_ops *ops;
+	struct dpll_device *dpll;
 	unsigned long i;
 	int ret;
 
@@ -626,19 +628,51 @@ dpll_pin_freq_set(struct dpll_pin *pin, struct nlattr *a,
 	}
 
 	xa_for_each(&pin->dpll_refs, i, ref) {
-		const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
-		struct dpll_device *dpll = ref->dpll;
-
-		if (!ops->frequency_set)
+		ops = dpll_pin_ops(ref);
+		if (!ops->frequency_set || !ops->frequency_get) {
+			NL_SET_ERR_MSG(extack, "frequency set not supported by the device");
 			return -EOPNOTSUPP;
+		}
+	}
+	ref = dpll_xa_ref_dpll_first(&pin->dpll_refs);
+	ops = dpll_pin_ops(ref);
+	dpll = ref->dpll;
+	ret = ops->frequency_get(pin, dpll_pin_on_dpll_priv(dpll, pin), dpll,
+				 dpll_priv(dpll), &old_freq, extack);
+	if (ret) {
+		NL_SET_ERR_MSG(extack, "unable to get old frequency value");
+		return ret;
+	}
+	if (freq == old_freq)
+		return 0;
+
+	xa_for_each(&pin->dpll_refs, i, ref) {
+		ops = dpll_pin_ops(ref);
+		dpll = ref->dpll;
 		ret = ops->frequency_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
 					 dpll, dpll_priv(dpll), freq, extack);
-		if (ret)
-			return ret;
+		if (ret) {
+			failed = ref;
+			NL_SET_ERR_MSG_FMT(extack, "frequency set failed for dpll_id:%u",
+					   dpll->id);
+			goto rollback;
+		}
 	}
 	__dpll_pin_change_ntf(pin);
 
 	return 0;
+
+rollback:
+	xa_for_each(&pin->dpll_refs, i, ref) {
+		if (ref == failed)
+			break;
+		ops = dpll_pin_ops(ref);
+		dpll = ref->dpll;
+		if (ops->frequency_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
+				       dpll, dpll_priv(dpll), old_freq, extack))
+			NL_SET_ERR_MSG(extack, "set frequency rollback failed");
+	}
+	return ret;
 }
 
 static int
-- 
2.38.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
