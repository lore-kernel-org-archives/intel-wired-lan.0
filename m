Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A50C982FA
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Sep 2026 15:22:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CEBC240709;
	Tue, 22 Sep 2026 15:22:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T4yVuM7SKrji; Tue, 22 Sep 2026 15:22:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 113A740674
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790090561;
	b=q4UK+i1xGe3kTpbmq3gsplCHBKxB+WyXzfP+J3xAcz9hpXRypAU+lm+W1iexSsU73YzX
	 IRhp1TwliGi3gTDD2JAcaEbf8IXFFpH9edyFwcGP+hWmL003swR4TvuLktqTfEF3o9e5/
	 qVIZF2rd4obacOj1b7lAuLr7bmYKOKurIswiZv043rH7drbSui+/6oAF1xPds57c65REP
	 cIlBoKmODEUOglX21V6Qa/fdtIWESlI48HwuWnLSTmWMuDIXM15+E3Uw7favLAzLjkDUb
	 N5pCl6Dso5flJ9Qe4UF/r6ka0Vvsr9IsuTv/yAcP1UTsh/Vb7LRuy+aYPG80RQGOigw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790090561;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ezI6opJL+TJWnK9b0Jz6azXtBu0v4XKOZOc9c416xu4=;
	b=TAZdlBLaMzI7MeOSUYh5xpG6yZBvczH0QicWa1CmFPEVFg9qi8phN7tnPeQULkXtZ065
	 WrZ/owRpmQMjM0fEq4uqAyJr5C5gSZgaH6LUIk1ZODhEMWwhoDiWYVr1OZhcvbRPuiGlU
	 L3CQ1j59sjLwYYMqSdr2Nt8N842UPQflEjW1mFgitNxiE+oakMKNa/i06kpp9jV1Dc6rW
	 aRCK7nHQI+ar7nhNtWW1sff5VxW3zz/nX9EsqUnoXfFvLhkM9TyaIKyXdyK9A/oYW8/Oo
	 Xz8rKnWg5y+DRznGRwtbbSepTVKHyW+u/fHrLU9j8SdgFifNpxYlfkYnvMam/4qPCrg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790090561;
	bh=ezI6opJL+TJWnK9b0Jz6azXtBu0v4XKOZOc9c416xu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PF7j42ly+8XebK5WnSREqrjVKCzmc4q8RK0UN1DeXz9VvzPCSKUV9lqIEbFTIaQdR
	 2atbrHBOIzElbkyboITUV+kPsuXNt2g7j3xmm7u1vJ5Peu/BojwtsRK3dllMKcRkFP
	 lSe0nQ8vgU8ChMxOfu+I1JCh5yXtotUN5NqFWOM8HiJF9t4lm7v81orrQYXLObeyw/
	 sJr8jW+bM32DoLX1VjlGlJguoucHDD2Sc32Oqmyvwqvk519kvSPcoUGC8uJRhTEn1M
	 5rSSvz5HJsYqusKKylliRGI0POv4IbxWjyr0G2Bv1IDKIj5FSl3x4TfumIHT3pOcI6
	 8vcYuxojQ5+WQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 113A740674;
	Tue, 22 Sep 2026 15:22:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5706FD1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 13:33:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 494DC60626
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 13:33:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n5OCxffzEVp1 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Sep 2026 13:33:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org F36D860625
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790084027;
 b=IPN6s7eLClPDy+6dZ4cZhS/+Ot9zcvEJBvsKNy31so68GzpxPx9eUk4ECNxD0m9dt0PL
 /BoIGFR33u2kXBfAkUXKVyGnsxXKhjFjot+EOQ9eHA5pwo6TH7vC87x9xpj8BQruVUHug
 jPYxKprkRhKU0j+gWTH0bFiDj/bozsGq8K8/yTYl6oGYPFzVJgtLPaOAyG7qbNBcQ4P8a
 nP3V8a2llg6LzT4T0v+mWL5Czir00uKn1xoc0Z3f/S4sw9vowBNBRHEtkg9xePDkhSHBV
 rW+jzW6xnNZ/F+6bHqP48sUIZso2XnLLippYtn72DwyOwNkhMLnzJd6mdCxdZ7atWXw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790084027;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=ezI6opJL+TJWnK9b0Jz6azXtBu0v4XKOZOc9c416xu4=;
 b=E9te1n1D0PUCLwIydIrRC+90cJzhFMp7q1CTgaek0B4T6BTTsG/PxP0xIjL0VHlN9HMk
 ijPgybkMWgtUsOexjTRdI3M+AHR9QiWWm6dTaD1yfx5fa+0sJHZ9q+v+cLYzM0kW3IvQs
 3KSL70CKaXHmS2vHTMr95hrrbituB6NK+ntyqXUmII+8aK5IdgEvuj0pQ03cbGY5SVTar
 7zq03TM0KYZ8XHuRRUg6UrjA6H+f+DKeKpl5vsroosShEcIOwmaXklQ3WH8YmvkwyBIDR
 ChNKu0dDsUWmPnkEUPXOjMz3yPiqSWISPTiRkadIMr3u1lPFo+rXwASXUnQvjBzA5EQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=suse.com; 
 dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256
 header.s=google header.b=T1cNiJIB; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=petr.pavlu@suse.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256
 header.s=google header.b=T1cNiJIB
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F36D860625
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 13:33:46 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e8185e037so24105655e9.3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 06:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1790084024; x=1790688824; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ezI6opJL+TJWnK9b0Jz6azXtBu0v4XKOZOc9c416xu4=;
 b=T1cNiJIB8pnN26y0udqUzrFA/tQ6q5n4WS0J22+rAhjEfLRnv3gQteHbSEdQ76z91J
 aND0VTYPtTA1mV+Og3qm8I8/ZmYHAeqxLv5+Hja1n/76PIzez66EtP8UneFzaQtJsC4d
 S32bMRRLGq2ddnIBjjPOuh0Pi1C3Jzm525q7eMBraUR9MbDPrNJa7SstpQpUq91xQjVJ
 CE3/JYA0WN+X+lDmhw+EXwsqYzd8gUU05bXzGbEbkfE6nM7Y/HqPCmkb+kS5TUbnj7W/
 sLNnFMpZKU+cCdYHdZ1VNcg/5ugFwnI3i6R3IaBuupVqUWvaNBi2EZBux4TDlFByqORU
 A30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790084024; x=1790688824;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ezI6opJL+TJWnK9b0Jz6azXtBu0v4XKOZOc9c416xu4=;
 b=2gRSpAp+5ZzjvC8znjVdKz3I9ihAB9icDP/7F1bEcKkiBLHpGDJr4Qu48Egne9XGvs
 LxKq3aSlfdy/duwOOyYWCzUVLucJo1aGkgxSESRoc9zHJLjo6WIAQS0Mk7clMIfXdhrC
 Utt45Wh9mUR4R+M4D+YLYq/ypGD5jvK9pTz5IMWR7gOzJsCeQIbcHInlcRQWe3yOk6GA
 LcEi8+Hv8cjNmHD+WcDKctLPMI9Ir+zqTnjnjUsqmJmt/p6zRfWslprT4gDp+nWStA+j
 n91vrpl+zHfdkbU1DbBcmD9GbZM+ZvtbYcGHWA7XkwZK3N+DT72mgs8UEi12Mg1TlA0c
 HXPw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxxNI+tJm8ly0x2aCePOSoJRcKiD8jEYEonOWsQElHsNty4bSYSRSHl+GixVhIwP3rebU7EXQPR2Ccwn72UHgM=@lists.osuosl.org
X-Gm-Message-State: AFuF++mqCZevcB/ZS1M2tMLroY85N3bCjFlLKM1vTgkc3o9d+cNM1RgV
 crkOx2y8/LyKKGU8NZ35FV4TR3jXlGLLhC7SxsezLTDfhtw7zWMySxy+7ZI/JfKwsfg=
X-Gm-Gg: AYBFou3MF1KBX9WlLWsX+oiQ84jqZh/AL/rYiKx8yWVOdu9T3GWYfALeE67vgBAOHF+
 L5m9n6FmSedXaD1c5FASq+zQKNJqxdJEaDAFJZF+quaNZdSvV/mKR6STsyKiWovRkAszmWIcBGN
 Izhgs9LlFAT827g5Oo6L8zaDr7IzutdrbSx403xNTo9gQv+tyG/hT/sydTwL55mvYqO2r3cDnbp
 V87DZ8T2K3jD+C+ZRunnPv/nGYtzoOdgDxBvz1yF9zMMl3w8Qu249hanIVx1qfkfAXMJ6QnIFWH
 0h1uohCr6eJ1BzAOTxa4TmwlEyUfwvHe/dmdJbXlZz4/PMKfN49O5L7JVZFKqbkmKNooeaBq+tV
 Le8uCKeWK8fVqexBMH86KZPVglA2QTa+fEbSKfGcE3AgZ3EJBMPLzT3MxxPby0AbIDMfpIiMyuj
 Zk9PTE4UH+KP4Mt57xW+YeMVCNT2XUkNGzY8ernLl/1cVVXJ9fIWKglCBV5AkFkiWV1NUT5z3YM
 ePT7YhllQR8G4PbqjmGUfAz3+rCIuvbOWIerDNpkoOVLhmH6i8RwM8e0OVObCLl7nvnuLM=
X-Received: by 2002:a05:600c:81c8:b0:49c:fc6c:be08 with SMTP id
 5b1f17b1804b1-49fc58581bfmr184348345e9.31.1790084023989; 
 Tue, 22 Sep 2026 06:33:43 -0700 (PDT)
Received: from zovi.suse.cz
 (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz.
 [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdace76e8sm70243845e9.1.2026.09.22.06.33.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 06:33:43 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Ian Abbott <abbotti@mev.co.uk>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rudolf Marek <r.marek@assembler.cz>,
 Andi Shyti <andi.shyti@kernel.org>, Chris Snook <chris.snook@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Andreas Noever <andreas.noever@gmail.com>,
 Mika Westerberg <westeri@kernel.org>,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Duncan Sands <duncan.sands@free.fr>,
 Chas Williams <3chas3@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-watchdog@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] module: Remove obsolete __MODULE_STRING()
Date: Tue, 22 Sep 2026 15:32:23 +0200
Message-ID: <20260922-module-string-v1-3-c18766690185@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922-module-string-v1-0-c18766690185@suse.com>
References: <20260922-module-string-v1-0-c18766690185@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 22 Sep 2026 15:22:38 +0000
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

__MODULE_STRING() has been an alias for __stringify() since "[PATCH]
MODULE_PARM support for older modules" [1] in 2002-12. That change also
moved it to the graveyard section at the end of linux/module.h

Remove __MODULE_STRING() now that all remaining uses have been replaced
directly with __stringify().

Link: https://git.kernel.org/tglx/history/c/136839a1b4 [1]
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/linux/module.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 96cc98568eea..0d9157a2d487 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -886,10 +886,6 @@ extern const struct kobj_type module_ktype;
 
 #define symbol_request(x) try_then_request_module(symbol_get(x), "symbol:" #x)
 
-/* BELOW HERE ALL THESE ARE OBSOLETE AND WILL VANISH */
-
-#define __MODULE_STRING(x) __stringify(x)
-
 #ifdef CONFIG_GENERIC_BUG
 void module_bug_finalize(const Elf_Ehdr *, const Elf_Shdr *,
 			 struct module *);

-- 
2.55.0
