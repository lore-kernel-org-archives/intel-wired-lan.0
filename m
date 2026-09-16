Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A42C982C1
	for <intel-wired-lan@archiver.kernel.org>; Wed, 16 Sep 2026 21:44:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1161B80E1E;
	Wed, 16 Sep 2026 21:44:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bV2XRy5xCO8K; Wed, 16 Sep 2026 21:44:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 36ACC80E28
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789595051;
	b=Ni23hPNkZ9Afmr5gcLLpji8gGNWoADDQtTxnLloAedSrSQS+LJUvuidthvdN/6VKPTBp
	 Ji5UJM+Hp5ZNEL5X/+8Rszcjf1o14leXjviem2TsP5wWGV4umeXm5tklsjHAjK7s1k/lt
	 Y995QWcN7AkylHnv1qdXq1CKKM1REkCN56rZEc58idnNK6aRa/l481jblsgxlIrsI0ETo
	 vBJk3Bh4PW/Q0LjO95Ywh46ky8+BIhvtcQsEmJ67Ib34pibUB/muFbIZzZi9pgMHHN3tS
	 0bQo/GGGNjbQCB30tCa2s/TH37RcJbHIve2lkCB+oXhMyZ0CosEUzFDyB4Ml4KYAeTw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789595051;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FjY+yTooIwgjzGQxDpIA0K3uDvsszA1PxNKQSXHovCI=;
	b=GGEi0v89W+3A9ie0iJRdPaoRE0RoygUVmbsOGfb+da3sqhq8L/iBPWqrhK1ZgAILdvsv
	 gMbzENfn+oo0EUPTu0v7MaLtVe6z2ooCfkGxuncTu3cCSviq/3qRe5gLx2sE1yf5KTE75
	 QmNLxmQ76roC5hk1gYtVtR6RbIzlRITpQXrzG+TaSqJk4X8mARTfcdofgjIQ/pDHA+a8e
	 HpQiMO6l9YqJgSvtM5bgIpiIoJ4BtTC0hNMh5/KmUSQemJWRMGkfE1tj65tiHUaMkrFEj
	 chxXo2F5mPDsPG+CXfN0htPvknq23AfQZQpF5cFLaipBp9JWiw/JZoXzrL7o5cml/tA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789595051;
	bh=FjY+yTooIwgjzGQxDpIA0K3uDvsszA1PxNKQSXHovCI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ktq6a04HUNmrUhN1vblcXSo3jQJPHvSWdO6Guh421LYtUv6pmE4u1tvRW/jKjdZsA
	 nPQ8Z6enSh+fwilv19aiamcFyZLqTzTIrn1QVWdrjxsAwMTxjAFjY4SWebN03VDkc8
	 6RZkHtpK3FTDHRGWGcuvUHQG5v3ylsRBIaIQcy2lc0NMM9eWjbi2PeJxtXBoO7alLT
	 Jge7Ia1zws2qI6F+tpz6XuEgbKnl7FgapbkRDeUu0VLUYZEIV+Or78j+i5Xqo8884/
	 Ccu6FuxcSJp8tvCkyLWf3OPKxI6y+zabW95dqn8InFP0bfenD3VbdfyzSJAC294oFy
	 rnTgXYE+xpggg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36ACC80E28;
	Wed, 16 Sep 2026 21:44:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B27B32E3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 21:44:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AFA4D403D3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 21:44:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PQ47L4ydUC5R for <intel-wired-lan@lists.osuosl.org>;
 Wed, 16 Sep 2026 21:44:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 67CFF40357
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789595048;
 b=SKfvz4NROhDsvpbhk7+ZFXNNemFnS/RPMLGi7QqzNJxVGzi2ZkMd01i3k5Bo1uh1YDm9
 jdKL752x6JpLRCJflPWRrF5uuW3xDtqZmLYJZolBjqreAPLsbzSXsy6x4TpnVdOslfxct
 5NyK6vsZxtGWy2LgiecjjKUaos01nBWFklKe1LCftZzBQvjK9u46OL/dX38hIbqO0yq6y
 JrPrP9oOhEJ8jdlvmyuXg5srA4LIMBa7WNo+xTes6kZAqrXu7DmjUNO7srJ3ME5vvsHdE
 MPdpvP6RYwioI9tFWlgLIUhrJ3pP36rjULjlEB3IFl89Qa/AEqgN76PlJsqxyvUIqMg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789595048;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=FjY+yTooIwgjzGQxDpIA0K3uDvsszA1PxNKQSXHovCI=;
 b=QN11FgcT84pW01cCTUhp9DDRayLJQmj11lVuVkuNyv53hdzXfxbtR7RaaTKsJg8ZK7wv
 rXm2JqQpMsrOrhk3EKyvSabvaVR07uFFqLWz9XkVDRvnCAY/EGTzv8IgMxQQ7NWHH1Ld4
 ftBuQYYFTcqR+4kH6V2wOK2+/MBcw2Q6a+w4hdSc05YMEAFKZaGs/fOAUU+7FjcaD/PnU
 KEmZZ+3KpUXUFyIZHQQ99U0eupfUY3dY3ZDSziV8kcBFk6BNUTpvKslvaZFlFisu58rWm
 jty/XrQoxtQj2EopvwFjkXI2i2fRRC+eK0/1FP7nwZV4gllNzyRSH8KPWgFP20tlD0Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=am0qeYDh; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=emmaonana18@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=am0qeYDh
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 67CFF40357
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 21:44:08 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e71974de4so262695e9.1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 14:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789595046; x=1790199846; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FjY+yTooIwgjzGQxDpIA0K3uDvsszA1PxNKQSXHovCI=;
 b=am0qeYDhywOrqQyjtVOBBI7YZ9hHGEK8RhZVA/l4x2Iq3/cEOzCGsOYvC6ekIcOI63
 JBUdjbFWEMythDloHqasT/RTlDT+NZyc1f524/lwZOUvKF4HAIcxMloQXx0X1JWhUEUh
 o6gE/+/dsTtzKidwd0DsAWNsHQFNlmAa5h14RTkdrJvILFpABxmyt7EVih+EsKARcXWj
 EYYehMyjWGS/6VmGCLszAtgk0KalDA13HUbP5TtiwhHi0jyG1tWS1KjLqfdmJYRVz22+
 sDvyfGmKonZx0IPnWKXJ7gIGrPyKnRalsZEC4qJFcAgEVk4XCShKM34o/FCkDliJiwe9
 ZufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789595046; x=1790199846;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FjY+yTooIwgjzGQxDpIA0K3uDvsszA1PxNKQSXHovCI=;
 b=mq0TXKK+/Fuyi1sPd7ILfzeIeazqjRA906iSKRhOIhyoeRAht0BAmn+gXzhWdQlZsa
 LUG/1XfUfFMtQvAnHmT0278agJ0tgfyZRZDMiNHi0cflmAVcbPQkG+c3vKtJlEzhF9iI
 +ewsaFFO1T8sLUQlXjmJ0mIEfy78JpRQ+D3u3cP+0zjvtJhKDUxL3XWURT6J4P83IPj6
 B4gr+auOpvq5oa7pSSbGCADIVbdt1ge/QWcbFgj8LXSaPPZJKxWe95/QiPUzASsxnS+y
 nllpB52G7Y3UZRx+xvjVZK7Im67iCrcErS8eLE5Nl8zeBdNjeeBjPLnpNhtApuRB959j
 /+6w==
X-Forwarded-Encrypted: i=1;
 AKwUvBykvfcCGnr+LuJvlcT9EvlxmnkOXbKf9T8h9nLnoEmqHIdD3frdysvSHAdaNwU2w2HF1mtdVyg9kej1B7IcRw4=@lists.osuosl.org
X-Gm-Message-State: AFuF++nOGlDA8xnC3CLwl65C+5Ud1fgUXnmDh0F7oEZHWvmBjWpAVWDP
 loyO+LQdlzL29B3yvRzSl1BIac9IOPVimUjHrHqPG7ovEcjqHouDmG4Q
X-Gm-Gg: AYBFou1fmDGi8FZ7hJ9BcL8ePyacxylQjTqVFOkJVHUx/C+Kw8Clt3mardgE0Xe+tSx
 mWYsJDMjbgBAM91+NkzVU9lOytTOafqcfYr9J/yaNBAH6Mwj3C8+KzakMMy8wugxnKbfwaJubj1
 sizgz5+WvIcLM6nUxwaCMYQ3xXA6v2ozs7gP6gDb6b1IF4yfek+r4FWcg4VFx8MePdcw5M2YGrz
 zLM0X4mtxPt2siZyFiy9kOE5nCj9inh1SGttRhuYZM6fZSz0apG74KdgRdihI5VM29Q4Raq1mg5
 cjToTyyaiTfQ5DfgX+Qyglo2BAiueXY2Vrmpf41hViXwPZk08AL0su+1QuSeuuABSQJezvCr2Ys
 z/R08vZcJjv/m0ux3ahlsWZCEaZmnXPhTNZNBTQhEVefKeD8L0DxFNtC8haiQCEvkiksy148M6F
 umvO+dQy5XHKCIEbAfXOEieFnFatu7MV7dfdw4+Wmfk1sDqlSMNBK3jxBadtHND64dI4XiRA0gC
 B/s4OkP6e/GYoUrKy8=
X-Received: by 2002:a05:600c:5489:b0:49c:f9b8:bae0 with SMTP id
 5b1f17b1804b1-49eb732b2c8mr49393815e9.2.1789595045874; 
 Wed, 16 Sep 2026 14:44:05 -0700 (PDT)
Received: from Nuel20.localdomain ([105.118.73.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd32c5e1sm35176755e9.5.2026.09.16.14.44.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 14:44:04 -0700 (PDT)
From: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
To: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Cc: corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 mchehab@kernel.org, aleksander.lobakin@intel.com,
 aleksandr.loktionov@intel.com, tudor.ambarus@linaro.org,
 emmaonana18@gmail.com, bvanassche@acm.org
Subject: [PATCH v2] docs: kdoc: fix struct_group_tagged() parsing regression
Date: Wed, 16 Sep 2026 22:43:57 +0100
Message-ID: <20260916214357.22573-1-emmaonana18@gmail.com>
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
Assisted-by: LLM
Signed-off-by: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
---
Changes in v2:
- Add Assisted-by: LLM as requested by Jonathan Corbet.

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

