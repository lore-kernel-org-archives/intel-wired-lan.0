Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 834EDCD1280
	for <intel-wired-lan@archiver.kernel.org>; Wed, 27 Mar 2024 15:24:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3CF2B819F3;
	Wed, 27 Mar 2024 15:24:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vQRfJNT6zSAf; Wed, 27 Mar 2024 15:24:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DEBC3812F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1711553095;
	bh=eOUGX/Rkzn3Vmb8lGNkIHPfjzJ9q18KPgrGzwXNQN2I=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=BDm5ehSXsaxliAj3lx/15m62cHEoGK0UXFcZWu2dVGYIqNsO5a0GtiT0o0WsQCcHu
	 Ao+Qq28yGch9xgNcJXyEN5Yd4Au3oCmi+0PGDX7bFSWmx3BfjmEeJuvWSGP9nEzYOn
	 U+bPOXdUjdKXRYCUl8srFQWUxvXKGUi+Aw2Pq5Gxm+6UZhzlPUOn1vLCRDMlAAggXe
	 O/8bgRr2/G+9j0D6s5yZEfC4akYJ4x81NVcDKdltwl6zzzfhpsWNa3iFNpEbUO7S05
	 14QBYb8GHcN2Wuibj9bK9p0HujeE3rYBX4dyOL935OknH8L+qRpUcsfQkiGVoZ2/sV
	 5Thl4NiX/5EfQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id DEBC3812F3;
	Wed, 27 Mar 2024 15:24:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 4DB541BF418
 for <intel-wired-lan@lists.osuosl.org>; Wed, 27 Mar 2024 15:24:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4556D40144
 for <intel-wired-lan@lists.osuosl.org>; Wed, 27 Mar 2024 15:24:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e4Q3CguUSFRr for <intel-wired-lan@lists.osuosl.org>;
 Wed, 27 Mar 2024 15:24:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=aleksander.lobakin@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7ACF2402F6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7ACF2402F6
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7ACF2402F6
 for <intel-wired-lan@lists.osuosl.org>; Wed, 27 Mar 2024 15:24:51 +0000 (UTC)
X-CSE-ConnectionGUID: 6W3EyRfCQkimA+EhQglltQ==
X-CSE-MsgGUID: Q1ZkBsgiTUuT/GwDTD8DJA==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6518109"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="6518109"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 08:24:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; d="scan'208";a="16414117"
Received: from newjersey.igk.intel.com ([10.102.20.203])
 by fmviesa008.fm.intel.com with ESMTP; 27 Mar 2024 08:24:43 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Date: Wed, 27 Mar 2024 16:23:40 +0100
Message-ID: <20240327152358.2368467-4-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327152358.2368467-1-aleksander.lobakin@intel.com>
References: <20240327152358.2368467-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711553091; x=1743089091;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MOQQd/EDW0Rx6coAPnU+ytX7qdeAXugbGRDLLXEZPZo=;
 b=PnjSUpp8GPIRJtkmJzyR87q6IOtlMtY8RQm8pQTJpEgJbt6fSVO60lv5
 CzruY2vWY4QLrD6V8PC27ucmIYLHvZGXmUSX8p6cCj9mUh1aXrsszqe/b
 qndBuJXRl1MNoAFEg3wEiZAsgqF8p0uCtM+bxBzXDG/VTj848WEWV7pfy
 mNYOuXijXisMDDbkizrS0jRqr8dVmbOcxzrlbpUb/n6p0wFN0tcH2HGKr
 5s0uMialSHL7L0YsTCy2eHKbfMOv5xp/a2LGTz/XnORVj9N89MXEuC4K6
 jnsNgzqc46nXxjxKkv+u2FkSw6IcClNco3MPass3BJkhj6xFluGzmWFTg
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=PnjSUpp8
Subject: [Intel-wired-lan] [PATCH net-next v6 03/21] lib/test_bitmap: use
 pr_info() for non-error messages
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
Cc: Yury Norov <yury.norov@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexander Lobakin <aleksander.lobakin@intel.com>,
 intel-wired-lan@lists.osuosl.org, nex.sw.ncis.osdt.itp.upstreaming@intel.com,
 Alexander Potapenko <glider@google.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Alexander Potapenko <glider@google.com>

pr_err() messages may be treated as errors by some log readers, so let
us only use them for test failures. For non-error messages, replace them
with pr_info().

Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
Acked-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 lib/test_bitmap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 9198e93b7985..2870373d94d0 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -548,7 +548,7 @@ static void __init test_bitmap_parselist(void)
 		}
 
 		if (ptest.flags & PARSE_TIME)
-			pr_err("parselist: %d: input is '%s' OK, Time: %llu\n",
+			pr_info("parselist: %d: input is '%s' OK, Time: %llu\n",
 					i, ptest.in, time);
 
 #undef ptest
@@ -587,7 +587,7 @@ static void __init test_bitmap_printlist(void)
 		goto out;
 	}
 
-	pr_err("bitmap_print_to_pagebuf: input is '%s', Time: %llu\n", buf, time);
+	pr_info("bitmap_print_to_pagebuf: input is '%s', Time: %llu\n", buf, time);
 out:
 	kfree(buf);
 	kfree(bmap);
@@ -665,7 +665,7 @@ static void __init test_bitmap_parse(void)
 		}
 
 		if (test.flags & PARSE_TIME)
-			pr_err("parse: %d: input is '%s' OK, Time: %llu\n",
+			pr_info("parse: %d: input is '%s' OK, Time: %llu\n",
 					i, test.in, time);
 	}
 }
@@ -1421,7 +1421,7 @@ static void __init test_bitmap_read_perf(void)
 		}
 	}
 	time = ktime_get() - time;
-	pr_err("Time spent in %s:\t%llu\n", __func__, time);
+	pr_info("Time spent in %s:\t%llu\n", __func__, time);
 }
 
 static void __init test_bitmap_write_perf(void)
@@ -1443,7 +1443,7 @@ static void __init test_bitmap_write_perf(void)
 		}
 	}
 	time = ktime_get() - time;
-	pr_err("Time spent in %s:\t%llu\n", __func__, time);
+	pr_info("Time spent in %s:\t%llu\n", __func__, time);
 }
 
 #undef TEST_BIT_LEN
-- 
2.44.0

