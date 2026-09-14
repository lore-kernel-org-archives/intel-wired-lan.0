Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A07C88E6E
	for <intel-wired-lan@archiver.kernel.org>; Mon, 14 Sep 2026 16:34:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5BC02405DC;
	Mon, 14 Sep 2026 16:34:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HRoOgfw3lJtF; Mon, 14 Sep 2026 16:34:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 66D8040611
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789403641;
	b=MGQ6mAqNSJTXgRgAa5VqAF+ztiGT6Nc4bz1PnJI7udVf+BfZ0QQskNqEK5Mx/NJ/H0Vi
	 O3/Au80uvnRBV9FJug/sukAE2k8NQs7S/ULB88FFiSjUirn00p24lO/qxo/E745wrGtwr
	 yxL6aIK4rCD2hnV+olRPaCww4xbVy2wmcBbaaV/zBabcGp9e8ZyFKCPHKiBVPyZSnu5J2
	 i/7KAfwLOh1+mKdeaR/ZjnXWlY5iFQKsrT0e85XDoSRauO7M+TNtsVStsmpESDn5Y1Ruc
	 pSREVF7SSwI6ENb27VNHLBnpF3q1WasXzpiuiIRg995alN2h1hvrwNBSs81QctqbiKw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789403641;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Tamt12O2uhKCFMMbIkEpJmlX30Wke4onDdSC/Kq2BvI=;
	b=l1uYipBhiP15OlflpB+TS1VZCumM2zSLG9r60nsY1N7asTnjXD5BNakpKoTBS/w3ZWV9
	 Av7+uubZmiSBeqrPDsibjRXcEYfsVz4kqWiiRweEODRrYM+BdAFZHjWR1OgApymhqV8cn
	 2e29wd46KWMttqkyjuduo4Gs+QiSpxvoeMc9PubYS/++km/Hw85kLIrC4vAzK4v4CG6gx
	 lJrCqYKQ+8IdaqQs6/1epGtisQ98ovgjqi8VnA0W8AtdHY26635eEMEk3Ex4RjvrFPMC3
	 UIzTdXkUgPFC9sFT2AU4NQiHswVMFC4RHJ2DdtrGwiCUO4UvfYGq766+3gO+Msyl25g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789403641;
	bh=Tamt12O2uhKCFMMbIkEpJmlX30Wke4onDdSC/Kq2BvI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rZGWiJaHTJ9Fzv8yjCkEXgQrYMEry8tCgiGrTtQetARFQan2qTfFcuG8LHozifzZP
	 65pGGBfeXpud/K77qGjnIQrN5HaxqJ0hfIoZfq6SIKkVphTe+gdN+uQd+Fs97wgNbX
	 +uTmHypAM33v0PuIXMfEUr0NHJJHyTL6NnTBAyv0vG3hKUKo2qBG+bD4GjDZe5SyXv
	 KEsDB8Yfj1ZddhE2LQrYYqKa59lR7HZ6JZPKHuf+HAGXtqRYhMfGaPIxRPxYPD9LKV
	 sXdBVLx5e5TrGv7Kgm2VY1v0Co/IgXtGQN88RNUVj/uXWJ7y4+1INTbxwIVCjWocc7
	 SQdI0tQEF3WDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 66D8040611;
	Mon, 14 Sep 2026 16:34:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DDFB1465
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Sep 2026 15:57:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CF6CA40144
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Sep 2026 15:57:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Av14vYxIJNLF for <intel-wired-lan@lists.osuosl.org>;
 Mon, 14 Sep 2026 15:57:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B77D44013B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789401432;
 b=OpbBwOoIjn9OQ3T3MfcJ2WJbbUOzcZ4KkFrONWkNykv43eBNWmGT4bv/b+Ps2PwPHp3c
 4YYZbw8aSXwa4WREJcRq9aEpjswl6MQTvkSxBMdZJXzGsqjM0hb8kZTY+QC6/80+yuuw8
 0HlFBwURHWVm4DK+ibkhlXLS22YhxGaTLZvCXRpq4YRvbxz/OByMytHsmzq0lu37j1LMV
 +I4JobxkyncBv7DU/kC6AX9uxz9LSwgqMcTjemLa9lD4q1wMoQ3Kh2g19lPEF7BBZSwfj
 KFxE8uqnC7DicWT3RSECVRKfjqNAmA5sMmIDWGqo63xnpLyyPa26YTr5j03zf/ubWdQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789401432;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=Tamt12O2uhKCFMMbIkEpJmlX30Wke4onDdSC/Kq2BvI=;
 b=Na91nJImOulCORg7rVL+CYDBhvxcj0Qg1XW7DjqH7amXFzq1UDqqUZu18bnzgtZijCa6
 s+SLSj5SO8Y4aig0xTwwpB12xYD+ifRl3pj+Zw7H7OaiAAVxvVuFmR55g8Lb4G6VUoyd2
 zcdszRaF9nlF6bEar2bo+SjLWG15QcQfBzXAQhw7ZG9mtbPzSrkKuCz1/tdOLFv5nPS0V
 Es0W42SgT58l8n1NsuNB+hdI9qyZ+sYRzTesgjcjSqI3og3CR5QXCIjze+VZJ1s0ODb3o
 MHB0f+uczxsDQpmo/I9FjxpKwxgx0cI7d6usBmZGu+XWYJgp9fMU3eaagZCtbB7tQTw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Gm6MGf3N; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=emmaonana18@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Gm6MGf3N
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B77D44013B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Sep 2026 15:57:11 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b0dd3e1d0so847045e9.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Sep 2026 08:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789401429; x=1790006229; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Tamt12O2uhKCFMMbIkEpJmlX30Wke4onDdSC/Kq2BvI=;
 b=Gm6MGf3N6HxANgfPbaG/0BRL+8mjokYfZJmavXYyyQWs3RcCbuRjo+wDwPy8XOHslH
 SNuB0LHKffJCQ8hjq4914RJMlMt06vi4bOlGt93AOxcrim6RcIq/yODpcwUtzuWNJaYF
 ZicJRCJsFHdiFLz3xSbN3p5xqaTpI2bHTuo+0rQPXB1LMfHkSCFWdD5dwAL4F5Ceclv6
 69GRejQZlNk9A+l6V+Yw6fFodkX0bTJ0SEUIgW40URJlNIC0H30yWLozBtJCHbWaZPq9
 K9IG3Ka+ZbsphSB4I2AROeQF9SIZWZiZZiUq6mmh60wVYUAGMU2xFogRd8EJw1C6ddLs
 dScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789401429; x=1790006229;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Tamt12O2uhKCFMMbIkEpJmlX30Wke4onDdSC/Kq2BvI=;
 b=lkkGjQKf4JRZPAC8Z1wft70z8C3WCYOJW3gvblwJHK//oezRjc5oVOqctaHYQX+Lpk
 YIroOHmwQJ16TcKGybCUySFRlMQCcf7S8h+x57ouYkO75GfRJDT6PorUaBOXhwyhCcX9
 Gf8OyHgSzhHM1Q5XP2ESriWn22EQAp4B1k+241a9U7tRJEOo8/Vi5ihI/7wjgZxAAehh
 yyIOm+7ORwlqlZ82au0JctDQ3VCDT5ER46jG8zranlhwXCXE4Y/+XJb82gcYHco/HOJf
 0H6stG+I1U2wDd/sqIF/TrM3h0YmbjaLq1KjDW3b3lsvM6V78Y6D6Vbg4W3ut3SnGwU3
 xcDQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzrgZMyRbyUJ3/OFDMfpgKc9Va/+B1rLvKPBFBsW96wRNmQfIyHhNCNxNAtRbANBAlotKDhBCsXI6a9lO1pfV8=@lists.osuosl.org
X-Gm-Message-State: AFuF++lWvwY7WuNiiFBfDIp6hTCqgilUNrYUiex7bJVqlJadMFIALYHp
 wmhaxsAB2kJBr2UlhcUT4yzpLAssmKXDkoECpcW5bdevDLGPVdmwY7Tw
X-Gm-Gg: AYBFou29S/QOQK41sH+7bdyv+6qkZjlfmkHtrhD5b4U4/JLSChF6Y2jXl3hnFvyfCZ5
 3EUzIa101/1n4dJM2jeQWaCxDUFOeLvZ8fM/UZxiz2B2Fukcju+bWmLFz4EA9FrAy/NGTZtzG3+
 O4cJdXzUQw9L8XOhmDYBfzzy81DAn01szkZuIjYPkxzAdVpXp1jT06stIkoNQ8nehaO2GDyuhR7
 Cp0co59mYjoGD7YIeln/PzyfTUg7yEPcu/yWAshrwpc/WWgwwRYNkD0eR+x9/VDRVI1bCliY6uo
 ZL/Nr5jPTtD2xW12WILh9OSA2er9JesbPY9DJ1nSPRECsv+2oWRBV1FntKsBZBJ5lzUK1z8FPY6
 vsEjl6V92aazMXOeH5QiejXte804Oflp5ycNaeRDOev7ndthEZqrcKDCQooMJrgMgOugmxBXIK8
 WVH7PdejTTtqx3ydbi5tkp0TTsxozStho0TeoC9ROETng6t2Ih8W410StsR9FawSHrWHFpYhfqJ
 LRtegS1JMlBorb+ysIH
X-Received: by 2002:a05:600c:19c8:b0:49c:f9b8:bae0 with SMTP id
 5b1f17b1804b1-49e7a68a919mr41608245e9.2.1789401428854; 
 Mon, 14 Sep 2026 08:57:08 -0700 (PDT)
Received: from Nuel20.localdomain ([105.113.61.233])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e7d6aa69csm787275e9.11.2026.09.14.08.57.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 08:57:08 -0700 (PDT)
From: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
To: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Cc: corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 mchehab@kernel.org, aleksander.lobakin@intel.com,
 aleksandr.loktionov@intel.com, tudor.ambarus@linaro.org,
 emmaonana18@gmail.com, bvanassche@acm.org
Subject: [PATCH] docs: kdoc: fix struct_group_tagged() parsing regression
Date: Mon, 14 Sep 2026 16:51:27 +0100
Message-ID: <20260914155127.21515-1-emmaonana18@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Sep 2026 16:33:59 +0000
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

