Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E49C982C1
	for <intel-wired-lan@archiver.kernel.org>; Wed, 16 Sep 2026 21:10:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7D9F84071F;
	Wed, 16 Sep 2026 21:10:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0DC_SA_w0rWV; Wed, 16 Sep 2026 21:10:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9543540722
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789593040;
	b=phcC1AHOiNbRhk+2cvdPy2xJG7wfaoGVpcc/BmTlbGq+Ivn7T04BAfpdDEq+ITt2C28F
	 BNu7NHwo7sUQ1ooW/qNQqYleceskkhJJXIRxbvhT0VB7faaur3ZMoySghRruOD/GZ2YAF
	 hlwfVJnmf0rb1p1+GwbkM27jEcuZFZ/ihB9OyYKPI47tuAV/0x1Y5VYsc/Y6ShKcaQDZV
	 eEYzKBiekskHmEFyxObQwfrnMcOjTicebZ/rii8H0/QFBaP1H1FACxS2Tu5tQy8UeF6j8
	 NTXUpscVqeELHbA2ic5X1PK63T1M8OMZmU1bNLVtz58lBnlf+/VdhTmi3oPyk8lB50w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789593040;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Tamt12O2uhKCFMMbIkEpJmlX30Wke4onDdSC/Kq2BvI=;
	b=hZnoWF/NhxThpzlwlE+PHu9wbpToyn35UH6Xe/agu5tyVVMyZEcUb8I0MUNMe8f6J3Pt
	 KSI8RdPT4Q2pcwp7q8+O8MTOGo2jzhW8Ft4gNOx+fbse8tqdgW6RhL3tGdB1V/2NZ3Dgh
	 G4O5tOpK9BghMRJoB+jQalYJ6zFSKLaL4Yl68Gv6Q3KTT89F+eywdbm6B76NzvipCJ1ed
	 VkZCR9pD41trZx+tIYFqd+wxQuWopo6dJ/gVJJtbJKvbj00ht/MSceL9ZNGzSeBbxyCLB
	 i1jpZvbrzqtX6AxkLwen5wbaxjYB+NjbiSNJq7yR6UpUIJy5jYtF0jzxGMNY+5d97gQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789593040;
	bh=Tamt12O2uhKCFMMbIkEpJmlX30Wke4onDdSC/Kq2BvI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=6waxn2I3PG6czs4WKYL7xITf38sUSp/v8kBhCaEzgRRi+38QwCo7PYVAI0RIKr7Af
	 oXtlhT1xBBC/8oDuKI18H/DM4pSa5+VZq6cIvbY0qhrguq+Ym/hQSAMofoSlYYhING
	 6rrbci5xZR/oJd/Fn8piHW59zlcbHr94BKmIqLtUpjrawHnIO5kTwl9oQaeRSqW6Rz
	 KmvR6e39EcSzBG2MyxZh+uyGC4s6EjdKSWNHt94JkBAPAC0m9V9efubgoXo4ggBCZn
	 0NT1k+SciDE9Aqvk6FNVAz5Sv43cmpnvDFOrVMVojQZtyAsVlZal00EjyQkYbUWarq
	 PiDU0Hq8tZwJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9543540722;
	Wed, 16 Sep 2026 21:10:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2320E24D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 21:10:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 13CFC80B80
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 21:10:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HndfiIO2I3lb for <intel-wired-lan@lists.osuosl.org>;
 Wed, 16 Sep 2026 21:10:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CE4FB80AA3
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789593038;
 b=dPZzII3NS968gWuFjr1Rrw+cZGnte3izFkGJGUNustUgL/4wCtT6qzDT7TQeKgxRTF3T
 zdtcjl8S2gyBLtIp2kL52jhV7UfEjB5/pfY8/3tcCGJ0I8M/UU9hlTfrAqgvKOLFqX8fN
 oDyyDDMnx0IDm5284y0RzWNnDiy9e+Whu2oTnoonhHb8Yy8LzHQlYyJRnkRVgi87f/gcC
 Z55bcSuItcn8CHEnths7oipi42BP2C7FSLeF98Tgpcz62T60AdmjO4sXzEKrs1NpxJvbA
 F3W5TuTF9GQQURUSr7KW4H+t90M2/ERcAwmCyllxTwMDvqAD19+qWCKZcjFnF9QbixA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789593038;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=Tamt12O2uhKCFMMbIkEpJmlX30Wke4onDdSC/Kq2BvI=;
 b=o23LOX1dErHo02dMWYx3H5vbcmBt8cOWl44cUjG0q2uXaBF/c0u2IPmm+j4P8tfmaIG2
 CtaOO4CQuqQM/6ovdQz5ee85KjvrDkJ/9LTLwDYj01/DzS89ofgGvtRILfN0XfOAhN5d3
 IvLOAU2OTiPpVIQ5IYi0Dr7umdi3DNs08uzVj5tgFneBYccpXyvL1WeVkuWbM/AQ932/X
 5NKDSEtGqBQJE6BYB5LvUbEsDsB3Dd49cxPCCTwf8VIEV4jH0euEKsNM1YsCONMOkj7FW
 RNHmWGPLp2eOdgzySW8lGdfXiKPeIwzdGQW+L4eDf2YtLMkzuymCmGBBL59RzWjonzw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=FCUPXC4w; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::25; helo=mail-wr2-x25.google.com;
 envelope-from=emmaonana18@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=FCUPXC4w
Received: from mail-wr2-x25.google.com (mail-wr2-x25.google.com
 [IPv6:2a00:1450:4864:30::25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CE4FB80AA3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 21:10:37 +0000 (UTC)
Received: by mail-wr2-x25.google.com with SMTP id
 ffacd0b85a97d-485843116d2so24753f8f.1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 14:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789593035; x=1790197835; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Tamt12O2uhKCFMMbIkEpJmlX30Wke4onDdSC/Kq2BvI=;
 b=FCUPXC4wnlkTtdlf+xX1dvLop1ACfOnW1fLl/KDOAcF5Lh4/SLaOYIKTymV0/dpF1V
 /RwuNi34Xn22CUZ7QKDszTagSBgbqWJJXebLabq27ygUeReBZpLe0t618ktMsrv2d0X9
 bh20yml7Fz6CZGGuBjC0sfHD7FAy93/Ih3cVtvP7zcHu+Gbei3W06g15SSozzSA73L9/
 /wYf3P5vCXUhH+ejtXPUQR0TRnUoKx7EWVyhS8k1yINm4i3m0dcKinRNGQwYKMsVIBhz
 PXK6iULdPgcSqbrNSGYfRoBzWlHaZOu8GUaxlBjDmDppglKsdfYqxOC0RbVSjNFhxwE/
 IDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789593035; x=1790197835;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Tamt12O2uhKCFMMbIkEpJmlX30Wke4onDdSC/Kq2BvI=;
 b=ZBFYoM0B7US861cJpAYNt8L1lw0zuzQ06CZwws9jZcA86tCb/2MdSpktkQk3Adi3Oz
 pbqHDzY/LnWdjGWyrdkFmnHqoO+QcRGa6fcPnrzGXo7iK68JBi9cWYaGevGBkTHBBbuK
 AMP1N1lcs8s4T2BQ8ualLWBj+Aw8XwPa2inOaTd2G+iQx0hHCMoMVe/rCioDBP9ON1tn
 IDelOqNHiM2lKH1VPEDXN7mOtTLbmNQVJ6Gdwjl8dl6xkpS21rNQ7xNzPNBd03VeCtLo
 qcNkiEVmFgb9xjbEu4W3HEr9K3ihmFd6WAtHWifthrwBNxMT+rlqdreAYPudcNwgvK5T
 UGJA==
X-Forwarded-Encrypted: i=1;
 AKwUvByveaTbGhL/EbiZp3bT4FhdLWiLUOYLgtSb7bgxXbDG3sRCeBjzPyaJ/6SnZBEf2eFh3CeFx3iIt9oWtlBr0iY=@lists.osuosl.org
X-Gm-Message-State: AFuF++nl7neAmCzuqrxinS+knYzh8+Iofl/6EWeR4dpBBWgltbaMTCY8
 5RtsJxLAdwu3Irk4LFJOfIDl1rQN5/CpMlFkkwp+E9tsun8/W3YJwwGG
X-Gm-Gg: AYBFou3kXc6HerylYohPlOH1cta0Z1lcSf2fYZR8eyltu8mQzYSeMZmezMZHzuXA7MO
 1J9Ca23BF610gYjSZj+EbhU8s3VQiDsOFlCbW/KatbYmWuAdnKqEqrcpvIrOUV9iP0ZD0YFZ8AH
 ZQ7TD51rOtKs+sStvgmLaaVUds+tfPTzxevk/IQ0R1SDVNHt21zcYJTKNgAyEebaPcg6Q59bAuY
 H3PUIMc8pqxlFCPNfx8B3UGgRbvRqkCtq0bJarWE4V9CUt3gBOUMsAZuCDLxIPMBslpv1xV164H
 EsUnf3BzqJRqGFMVU5qQak0VkndpcoPw1qagvxT0LkF/eQ8GkdPjiu3UsiHsqEjlGTsFf4RIOIV
 DuZUgkwerWasTuErbrXkV1Q4M697sqVj2+z5MYREPswO37Ot3FvcgHPirccLKHsb4DCSz8rJURf
 3Wm2PtyRZmJnFYqhkVXov/hI1qR5XpIkHPceZruhD8so1Re8fxzoP2LLG58Gj185+m3fRJtp9qm
 rwLG3AMHdt54xGHsmC/
X-Received: by 2002:a05:600c:4ec7:b0:49b:9241:7ff0 with SMTP id
 5b1f17b1804b1-49f1d516b6fmr45330575e9.0.1789593034942; 
 Wed, 16 Sep 2026 14:10:34 -0700 (PDT)
Received: from Nuel20.localdomain ([105.118.73.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd226ef3sm19858565e9.1.2026.09.16.14.10.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 14:10:34 -0700 (PDT)
From: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
To: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Cc: corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 mchehab@kernel.org, aleksander.lobakin@intel.com,
 aleksandr.loktionov@intel.com, tudor.ambarus@linaro.org,
 emmaonana18@gmail.com, bvanassche@acm.org
Subject: [PATCH v2] docs: kdoc: fix struct_group_tagged() parsing regression
Date: Wed, 16 Sep 2026 22:10:12 +0100
Message-ID: <20260916211012.16821-1-emmaonana18@gmail.com>
X-Mailer: git-send-email 2.43.0
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

kernel-doc reports struct_group_tagged() members as excess because
the macro transformation rewrites it to an anonymous struct and drops their
member names.

Keep the tag and member name when transforming struct_group_tagged(). The
nested members are then recorded as names such as fast.order; accept the
existing unqualified @order documentation tag during validation.

Add a regression test based on struct page_pool_params.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/all/0cf8ea5f-418f-45f0-907c-3d1ed4f03e9f@infradead.org/
Fixes: 2f07ddbd5793 ("docs: xforms_lists: better evaluate struct_group macros")
Signed-off-by: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
---
 tools/lib/python/kdoc/kdoc_parser.py  |  4 ++-
 tools/lib/python/kdoc/xforms_lists.py |  2 +-
 tools/unittests/test_kdoc_parser.py   | 37 +++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index d9ad1ddc87dd..ced09504f3d7 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -635,7 +635,9 @@ class KernelDoc:
                 continue
             if param_name.startswith("{unnamed_"):
                 continue
-            if param_name in self.entry.parameterlist:
+            if param_name in self.entry.parameterlist or \
+               any(actual.endswith('.' + param_name)
+                   for actual in self.entry.parameterlist):
                 continue
 
             hint = self.get_suggestions_hint(param_name, self.entry.parameterlist)
diff --git a/tools/lib/python/kdoc/xforms_lists.py b/tools/lib/python/kdoc/xforms_lists.py
index e3dda2fe8a53..9e8b3a6b1da1 100644
--- a/tools/lib/python/kdoc/xforms_lists.py
+++ b/tools/lib/python/kdoc/xforms_lists.py
@@ -60,7 +60,7 @@ class CTransforms:
         #
         (CMatch("struct_group"), r"struct { \2+ };"),
         (CMatch("struct_group_attr"), r"struct { \3+ };"),
-        (CMatch("struct_group_tagged"), r"struct { \3+ };"),
+        (CMatch("struct_group_tagged"), r"struct \1 { \3+ } \2;"),
         (CMatch("__struct_group"), r"struct { \4+ };"),
     ]
 
diff --git a/tools/unittests/test_kdoc_parser.py b/tools/unittests/test_kdoc_parser.py
index c4a76ed13dbc..1a8287e99f2e 100755
--- a/tools/unittests/test_kdoc_parser.py
+++ b/tools/unittests/test_kdoc_parser.py
@@ -418,6 +418,43 @@ class TestSelfValidate(GenerateKdocItem):
         """
         self.run_test(self.SOURCE, [self.DEFAULT.copy()], self.EXPORTS)
 
+
+class TestStructGroupTagged(GenerateKdocItem):
+    def test_nested_struct_group_tagged_members(self):
+        source = """
+            /**
+             * struct page_pool_params - page pool parameters
+             * @fast: Fast path parameters.
+             * @order: Order of pages.
+             * @pool_size: Number of pages.
+             * @slow: Slow path parameters.
+             * @netdev: Net device pointer.
+             * @queue_idx: Queue index.
+             * @flags: Flags.
+             */
+            struct page_pool_params {
+                struct_group_tagged(page_pool_params_fast, fast,
+                                    unsigned int order;
+                                    unsigned int pool_size;
+                );
+                struct_group_tagged(page_pool_params_slow, slow,
+                                    struct net_device *netdev;
+                                    unsigned int queue_idx;
+                                    unsigned int flags;
+                );
+            };
+        """
+
+        kernel_doc = KernelDoc(self.config, "test.c", self.xforms)
+        patcher = patch('builtins.open', new_callable=mock_open,
+                        read_data=dedent(source))
+        with patcher:
+            _, entries = kernel_doc.parse_kdoc()
+
+        self.assertEqual(len(entries), 1)
+        self.assertEqual(entries[0].warnings, [])
+
+
 #
 # Class and logic to create dynamic tests from YAML
 #
-- 
2.43.0

