Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DB8C001DF
	for <intel-wired-lan@archiver.kernel.org>; Tue,  1 Aug 2023 11:20:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F1CCF402B1;
	Tue,  1 Aug 2023 11:20:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F1CCF402B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1690888820;
	bh=hxPf9u5ahIr2aojHHjp0ZaqDt7AXoLPLNBkHFGt/r64=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=8VXaD3AoagJ8xIlb9R2AQdiRage0E0ohLP/zUIqE5JDQws85IuZknNXmyhyXbdV6o
	 dwlSQECi7pBDLUCF8jMdGYDejvryLGsw74BLljkx0vfDASLOjujXCH9mQPAI2EwJS8
	 u0b4LzToD2Rf960DympzdbayyleLDqxJeFGcLPcog+v43bHH0JPvD/ULM6HgxrL4ST
	 GyItXoTLZFC/64THwSQ/A1oADsYFfalG0re2Fi+6MVZ6UxQ/wBJii1EnxoeqyLN8B2
	 MB8FT+LeZu/3BrKNuYdOVWTwptehGcCLODi/+ZkAaC6O/zDKq5RnOZMyIwhtjDVwcs
	 VfNgXR7tdi9Qg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XKb5Ya03VuW8; Tue,  1 Aug 2023 11:20:19 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id DD50840BFE;
	Tue,  1 Aug 2023 11:20:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DD50840BFE
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 1470E1BF98D
 for <intel-wired-lan@lists.osuosl.org>; Tue,  1 Aug 2023 11:20:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 60BAC402B1
 for <intel-wired-lan@lists.osuosl.org>; Tue,  1 Aug 2023 11:19:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 60BAC402B1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2-rOB3l1ecY2 for <intel-wired-lan@lists.osuosl.org>;
 Tue,  1 Aug 2023 11:19:52 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CBC674011A
 for <intel-wired-lan@lists.osuosl.org>; Tue,  1 Aug 2023 11:19:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CBC674011A
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="455644612"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; d="scan'208";a="455644612"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Aug 2023 04:19:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="852415995"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; d="scan'208";a="852415995"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orsmga004.jf.intel.com with ESMTP; 01 Aug 2023 04:19:50 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.255.193.236])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 813B233BFE;
 Tue,  1 Aug 2023 12:19:48 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: Kees Cook <keescook@chromium.org>
Date: Tue,  1 Aug 2023 13:19:22 +0200
Message-Id: <20230801111923.118268-2-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230801111923.118268-1-przemyslaw.kitszel@intel.com>
References: <20230801111923.118268-1-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690888792; x=1722424792;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WtT6XgSWlnrDQ68ZvjZ28IvPo6s0OiqVJdElDVPQXhc=;
 b=NpMFhqeKuGG3DqZcOViGYB/8v8nslc5RWwj0Esa6r+pvPE2/0PoC+/AX
 9W7ReYrApxbrYLAZ8Ty7OZxwWa0CkkR6b652Ta2nXELwg9ZjMiF4nXwso
 pB7KXNjD1W7+MLnaUNuLB+UNS0p6DXDfxnfm1M/CVTPp1UuksdHJtG5b9
 CtdquZRbTr/T3JRZS3nmd+FrhPYnYtr4G8QbqkNwMfE/Recck/3t4POwA
 Zgnr0NaOfV3KxlAGZZTjSg5BZgqlhC87Kq7wCzdP2NpD4J+w5QBV+Snzw
 2zCi+fKGofMEmk4tEJlAWR67DgKLkMQFmM65Ma7PHngnHCSHM/q7ZgAec
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=NpMFhqeK
Subject: [Intel-wired-lan] [RFC net-next 1/2] overflow: add DECLARE_FLEX()
 for on-stack allocs
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
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Add DECLARE_FLEX() macro for on-stack allocations of structs with
flexible array member.

Using underlying array for on-stack storage lets us to declare known
on compile-time structures without kzalloc().

Actual usage for ice driver is in next patch of the series.

Note that "struct" kw and "*" char is moved to the caller, to both:
have shorter macro name, and have more natural type specification
in the driver code (IOW not hiding an actual type of var).

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 include/linux/overflow.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index f9b60313eaea..403b7ec120a2 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -309,4 +309,18 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
 #define struct_size_t(type, member, count)					\
 	struct_size((type *)NULL, member, count)
 
+/**
+ * DECLARE_FLEX() - Declare an on-stack instance of structure with trailing
+ * flexible array.
+ * @type: Pointer to structure type, including "struct" keyword and "*" char.
+ * @name: Name for a (pointer) variable to create.
+ * @member: Name of the array member.
+ * @count: Number of elements in the array; must be compile-time const.
+ *
+ * Declare an instance of structure *@type with trailing flexible array.
+ */
+#define DECLARE_FLEX(type, name, member, count)					\
+	u8 name##_buf[struct_size((type)NULL, member, count)] __aligned(8) = {};\
+	type name = (type)&name##_buf
+
 #endif /* __LINUX_OVERFLOW_H */
-- 
2.38.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
