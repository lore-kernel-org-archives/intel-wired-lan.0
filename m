Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C05C001DB
	for <intel-wired-lan@archiver.kernel.org>; Thu, 10 Aug 2023 10:38:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1182B81411;
	Thu, 10 Aug 2023 10:38:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1182B81411
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1691663937;
	bh=UDItUu4T+smB6ln5o408TgK+HUOF5/2FWYxBsc+90qY=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=wBTzfEnRD2gyGWthFcUXRcpCcqnn/DXUymyb+BP6DcR1GPOnjvBB/wKT3Sz0Xbs0I
	 KLsgniU6LSJDYRyKirK0kG6ysAjSCXmTIezPR2+tAzCbnO46XqjizN5yWl2uWu3cO1
	 Q/aYcmd0WlHqCSulEgdNhOS0gAhDMecSQPqK3J3FeoCVv4CpPlLfOZzr/6fjhQiwWj
	 FgAbHyqDB2k1K11wvjmQNl5zTM1KAtn43pjDWm1gUDpaLYh7pQUsnvTcZ8YtlIf6Ze
	 3hcSHtr5rhTjHfTd1N37GUCSnjAjMHRpVfpFCwdR5Br0qrla3iRBY+k63d/XJcR2R6
	 fszrpJJaMlWHg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z98Ox_7iWjuh; Thu, 10 Aug 2023 10:38:56 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0BABF821B2;
	Thu, 10 Aug 2023 10:38:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0BABF821B2
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 8A89D1BF34D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Aug 2023 10:38:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6C4FC417B6
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Aug 2023 10:38:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6C4FC417B6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ktLy7SVB0IZj for <intel-wired-lan@lists.osuosl.org>;
 Thu, 10 Aug 2023 10:38:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8AE57417BA
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Aug 2023 10:38:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8AE57417BA
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="370260807"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; d="scan'208";a="370260807"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2023 03:38:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="767237167"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; d="scan'208";a="767237167"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orsmga001.jf.intel.com with ESMTP; 10 Aug 2023 03:38:41 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 3886A332BB;
 Thu, 10 Aug 2023 11:38:40 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: Kees Cook <keescook@chromium.org>,
	netdev@vger.kernel.org
Date: Thu, 10 Aug 2023 06:35:03 -0400
Message-Id: <20230810103509.163225-2-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230810103509.163225-1-przemyslaw.kitszel@intel.com>
References: <20230810103509.163225-1-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691663924; x=1723199924;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=whD5FVxA9A5hKboWwZaDxzNXpacfLK96uA3KJdXm3Us=;
 b=FCulkeuKGYoeFwjZyCJyiLZ8YT9pmHVseL854uOeknFYbh2aHIAd60lG
 s7GiNEH2aqMEARfSNcTyj02zTTqt/ON1rz9M45btgrO3VlQFr4KPaTQCf
 DT5PHfSZNUMIgjuFq6fNoAp5nITXgWyZhixLayTbwY2DyjgPWMKWsQbKg
 0gbYKz7amv+Xn9CEoXv4iB3J7yweQo9Mn23RugeAO2JmPO7ITd1hgq5Xp
 OtWS5EDP9SrAv5f2rquqRjF+CxIE9wEkuQDca6tg7SticnzVJqvb7tVeX
 RHWxdnFlMRc4nnHg8ilEetNofHmFKNMyV9syxlY45qPu6QoACDVef76O4
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=FCulkeuK
Subject: [Intel-wired-lan] [PATCH net-next v1 1/7] overflow: add
 DEFINE_FLEX() for on-stack allocs
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
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Steven Zou <steven.zou@intel.com>, intel-wired-lan@lists.osuosl.org,
 linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Add DEFINE_FLEX() macro for on-stack allocations of structs with
flexible array member.

Add also const_flex_size() macro, that reads size of structs
allocated by DEFINE_FLEX().

Using underlying array for on-stack storage lets us to declare
known-at-compile-time structures without kzalloc().

Actual usage for ice driver is in following patches of the series.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v1: change macro name; add macro for size read;
    accept struct type instead of ptr to it; change alignment;
---
 include/linux/overflow.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index f9b60313eaea..21a4410799eb 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -309,4 +309,31 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
 #define struct_size_t(type, member, count)					\
 	struct_size((type *)NULL, member, count)
 
+/**
+ * DEFINE_FLEX() - Define a zeroed, on-stack, instance of @type structure with
+ * a trailing flexible array member.
+ *
+ * @type: structure type name, including "struct" keyword.
+ * @name: Name for a variable to define.
+ * @member: Name of the array member.
+ * @count: Number of elements in the array; must be compile-time const.
+ */
+#define DEFINE_FLEX(type, name, member, count)					\
+	union {									\
+		u8 bytes[struct_size_t(type, member, count)];			\
+		type obj;							\
+	} name##_u __aligned(_Alignof(type)) = {};				\
+	type *name = (type *)&name##_u
+
+/**
+ * const_flex_size() - Get size of on-stack instance of structure with
+ * a trailing flexible array member.
+ *
+ * @name: Name of the variable, the one defined by DEFINE_FLEX() macro above.
+ *
+ * Get size of @name, which is equivalent to struct_size(name, array, count),
+ * but does not require (repeating) last two arguments.
+ */
+#define const_flex_size(name)	__builtin_object_size(name, 1)
+
 #endif /* __LINUX_OVERFLOW_H */
-- 
2.40.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
