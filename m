Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E6D4C04A95
	for <intel-wired-lan@archiver.kernel.org>; Fri, 23 Sep 2022 20:29:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A9194415E7;
	Fri, 23 Sep 2022 20:29:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A9194415E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1663964947;
	bh=H+xeqo3EybTPkukIaY6f7PqQuPURa14hfQ7E1VOxLDU=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=g4bkaq3PKiN2rXjQDJAS2U/yafMVzA7CTzVvFAwhNTRd+n97jLH9/TaB6fB3gARol
	 moxcIwRlVP3J+PSFL2L89qJ2kTSQVs/dv06D1G0PutCD6BmgmsyoiEpw3/xQlqRhsM
	 4rmc7V33vuzgFFbTGGgL2HKwB89jsqQYcZ0r2Csv4vZVnPCw6XdhhbjfMvm0DhdtND
	 FCSpofbbhBw99BYtEGU5Q/2+TX7tzSOS455GOd+l+Ll4xaqvQ5t5ywy6Ge9jT3FcvF
	 8bL7RfYWb0KLw3WpwHN27JRKY5qWB8xwuUz31ZTmAvYxcp7pjYHXLf3TJ2bUHuDPXB
	 rzd+/5eERrDnA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mw-n-HCsH0ua; Fri, 23 Sep 2022 20:29:06 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0A63141595;
	Fri, 23 Sep 2022 20:28:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0A63141595
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 18F381BF8A8
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Sep 2022 20:28:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8E2F4400C4
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Sep 2022 20:28:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8E2F4400C4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WPDqcaifZw0C for <intel-wired-lan@lists.osuosl.org>;
 Fri, 23 Sep 2022 20:28:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D0B4740122
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D0B4740122
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Sep 2022 20:28:28 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 g1-20020a17090a708100b00203c1c66ae3so1274292pjk.2
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Sep 2022 13:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=EL9n9wbZi9fyT3aGiQZS2LpEJMU3d55TaSniCttQvBQ=;
 b=2D2/V86vxB/R6zGgCDsl/t8BQzR0o4V0xcKTyuvqm62t6WWSXqkF9GkThzkKlJZ0Ju
 I7AUOkhBfYUW30xkVEILjOIyxTIzNnxMvdntAEFYHmQIvGiFa66pq46u9XP6xGLQRNEE
 AblyObZZQeBpvkhcuFlVGPQ9apP21jFyfCnD9uQ/kWm7flw/OEiOiybtdOtBqq9Sf5W6
 6C5eughKGy8LIUBdoc3SWCRSSvCjMZYYYXAEYbQIwBGcSnLkAPbM165+PBTOVrlE5weL
 x8XypFY3pLiyW87ZHIMvralaT7A0whutnt8yQEzG/AIbBXAAxAt4YVdkxoTbCABpaGUh
 rstw==
X-Gm-Message-State: ACrzQf2z2QErCDhig6fkkvrkH/io+UUeTYl3fKTuA8BjrCftrN4Kx9Yn
 ofQIly+7H4t06VtoEBo7h6i6lQ==
X-Google-Smtp-Source: AMsMyM7eoJHZKH3YSKsY5YkDiy457iONKP31BWBrEV5/G3nKELCTwmbb5LPc9LXMuh274JI0xAYzRw==
X-Received: by 2002:a17:90b:5096:b0:202:df4f:89a with SMTP id
 rt22-20020a17090b509600b00202df4f089amr11673659pjb.25.1663964908260; 
 Fri, 23 Sep 2022 13:28:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id
 t13-20020a17090a2f8d00b002005114fbf5sm1954043pjd.22.2022.09.23.13.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Sep 2022 13:28:25 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 23 Sep 2022 13:28:10 -0700
Message-Id: <20220923202822.2667581-5-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220923202822.2667581-1-keescook@chromium.org>
References: <20220923202822.2667581-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3087; h=from:subject;
 bh=G1YS7lvbIYUjmUGwno5SYLunWPBrx5E5JtrQIsKL8KI=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjLhbk7fSVXcqHZwwHnEeVt5B6a48oJZB6JZP86UHM
 ZPzL6leJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYy4W5AAKCRCJcvTf3G3AJgnSD/
 9W8qNAP6Zy5DglrKDnwHBrzpsDiEdH/wfMvohIguBt7D/fftewFQ4tqvtjrxneIk1J3RM14QXLiprH
 MUqZq5kdW9AT1gvmup3TGoweA6Yx2DkGWfJS/v54NRzjRIE4dACjOblKj7iXYFfF8t8R+Eq4nBKII9
 TtYqLSNdRoXH3/bTtnUl7LTmAdi/LlTAD5DefO14HYsKFvyt4sCVHmhAxt18rY+VU63ZvvyAm75jOE
 ZR2xW54lIyrI0P7sO/seLIt5lpZoTOmLb/2IuExPeQiVWZFeDBI6TgHBjXJ5TOb6BsMRqG8sI9zSyc
 6MhJzTpE707Aaq04PeuqtOYkHPiet/lPnkzL7Jf3YqGCLil4ZfuartpWRK5sXfMjIprr+a8J/H57il
 rl0UdHycAw6+EZw2Ra62Z127chdyksyXQQxNCS8S2c1TeagVM0kidDWKmLOnnDdNUnMbfbAVlHUTHR
 rF5BX3KXr4Ue1fmCW5vyKzPqxV9i4JLKOP4MtwhcXHPRjwtzQFVVUnUTb599qTIHj79TLsip/gadnE
 1mfwmisADtH54xLJA8r6vchWr5+CdtzvV8R+im9byluK6q2JHt8Z0ggZ0ffFpYPDovV1P8s8oO7xSv
 C3cPN3vqpfjit9qEKLh+sCGFKp0EMfSwbJWaKupNHO2K/+ug5RCFyPYhfwhw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp;
 fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=EL9n9wbZi9fyT3aGiQZS2LpEJMU3d55TaSniCttQvBQ=;
 b=KSB0ryauelIrE7oREtJPxrYTfb46QmB7O8hzK0+cy+92LZCq5Nz63nwaqh+78ACaPs
 Olaj8m72mRzC/PVKFU0FisO8X9DWDdQZNFNkYIUifwiQsMgCUkFHt+ReTq+9Up6aPWOW
 bZkQ8bZsmvsZxcYJ3ShxN6tlH5c8ZEFyuIKz8=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=KSB0ryau
Subject: [Intel-wired-lan] [PATCH v2 04/16] skbuff: Phase out ksize()
 fallback for frag_size
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
Cc: llvm@lists.linux.dev, dri-devel@lists.freedesktop.org, "Ruhl,
 Michael J" <michael.j.ruhl@intel.com>, Eric Dumazet <edumazet@google.com>,
 linux-hardening@vger.kernel.org, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Christoph Lameter <cl@linux.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 dev@openvswitch.org, x86@kernel.org, intel-wired-lan@lists.osuosl.org,
 David Rientjes <rientjes@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-media@vger.kernel.org, Marco Elver <elver@google.com>,
 Kees Cook <keescook@chromium.org>, Josef Bacik <josef@toxicpanda.com>,
 linaro-mm-sig@lists.linaro.org, Yonghong Song <yhs@fb.com>,
 David Sterba <dsterba@suse.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Alex Elder <elder@kernel.org>, linux-mm@kvack.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Pekka Enberg <penberg@kernel.org>,
 Daniel Micay <danielmicay@gmail.com>, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

All callers of APIs that allowed a 0-sized frag_size appear to be
passing actual size information already, so this use of ksize() can
be removed. However, just in case there is something still depending
on this behavior, issue a WARN and fall back to as before to ksize()
which means we'll also potentially get KASAN warnings.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/core/skbuff.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 0b30fbdbd0d0..84ca89c781cd 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -195,7 +195,11 @@ static void __build_skb_around(struct sk_buff *skb, void *data,
 			       unsigned int frag_size)
 {
 	struct skb_shared_info *shinfo;
-	unsigned int size = frag_size ? : ksize(data);
+	unsigned int size = frag_size;
+
+	/* All callers should be setting frag size now? */
+	if (WARN_ON_ONCE(size == 0))
+		size = ksize(data);
 
 	size -= SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
@@ -220,12 +224,10 @@ static void __build_skb_around(struct sk_buff *skb, void *data,
 /**
  * __build_skb - build a network buffer
  * @data: data buffer provided by caller
- * @frag_size: size of data, or 0 if head was kmalloced
+ * @frag_size: size of data
  *
  * Allocate a new &sk_buff. Caller provides space holding head and
- * skb_shared_info. @data must have been allocated by kmalloc() only if
- * @frag_size is 0, otherwise data should come from the page allocator
- *  or vmalloc()
+ * skb_shared_info.
  * The return is the new skb buffer.
  * On a failure the return is %NULL, and @data is not freed.
  * Notes :
@@ -272,7 +274,7 @@ EXPORT_SYMBOL(build_skb);
  * build_skb_around - build a network buffer around provided skb
  * @skb: sk_buff provide by caller, must be memset cleared
  * @data: data buffer provided by caller
- * @frag_size: size of data, or 0 if head was kmalloced
+ * @frag_size: size of data
  */
 struct sk_buff *build_skb_around(struct sk_buff *skb,
 				 void *data, unsigned int frag_size)
@@ -294,7 +296,7 @@ EXPORT_SYMBOL(build_skb_around);
 /**
  * __napi_build_skb - build a network buffer
  * @data: data buffer provided by caller
- * @frag_size: size of data, or 0 if head was kmalloced
+ * @frag_size: size of data
  *
  * Version of __build_skb() that uses NAPI percpu caches to obtain
  * skbuff_head instead of inplace allocation.
@@ -318,7 +320,7 @@ static struct sk_buff *__napi_build_skb(void *data, unsigned int frag_size)
 /**
  * napi_build_skb - build a network buffer
  * @data: data buffer provided by caller
- * @frag_size: size of data, or 0 if head was kmalloced
+ * @frag_size: size of data
  *
  * Version of __napi_build_skb() that takes care of skb->head_frag
  * and skb->pfmemalloc when the data is a page or page fragment.
-- 
2.34.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
