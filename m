Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346D9C98332
	for <intel-wired-lan@archiver.kernel.org>; Sat, 26 Sep 2026 11:35:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E8EB140ADB;
	Sat, 26 Sep 2026 11:35:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R-yRpbRzJ2Pu; Sat, 26 Sep 2026 11:35:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 61A4D40AE2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790422543;
	b=DEtUYHSGR4vrpjABHeOqRZ1C5nt+1OQC4pJk2LDJIXY5qACaaLO6BZky6vw9kyfC800F
	 Dy6RpwQCi8AGz4zq4m69Bhzd5Z5tBvqWjAZXxb8hWsiP+CmwoAAuz0cuS2ddCzcCx6TQC
	 OCRG0EbHW6NbD08oSP79pwPyBfr++Y8kkxtv8dDg7xNm/lWvkV1Q/J+2HMH3D60mGgrVv
	 PQR2tPDD1uWnVhyiMTdpFCnd+YlATIL53DOpnQY3Xr/7QC4ClSTlNw1iAo1mV74OHMXnZ
	 ziQryT7T5Gg9Ljs3RqMhbJa026fKbQqzP0bYUH+EGNadPQgnk3MT0UMJMJtCCn5vx5w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790422543;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=elejCM3I7aiBIJk4EokP1CKIsPf6qMSVFiV7ceA0xps=;
	b=RgXtuDULXADMO/NDdOsLFKS6+ND20xFZDa9QTuCV95s1nt0Rl6Xh/8zZI2WeWrOWN3sR
	 TK9pH2X2bu6Ne6BmmIrNnN3Kt8fNVe39ZCxDSNwetgAsx2ZFwa5YDN7RukOr1RYeA683Y
	 6yarmwh+9+0pd0zmBUvj3PlBsH+tFrv6/R4d+mvazCAcZXwmMmppDzRYHSfb8vtYO2ANa
	 xDUo1bQGsxp+liaosMZulat0vbgYKwvQXuX9sw7bJRXw2OU4iU8At3Ne5HqL11razDwsa
	 RHkjPXwWNYldEDz1TBuvGDMThqCGH3qRD75MHuuBjTwWjghrR5EBlZURk3Yc/5uOM+w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790422543;
	bh=elejCM3I7aiBIJk4EokP1CKIsPf6qMSVFiV7ceA0xps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0boRf4i8UMFSscjOaVVxlHjYi1p08e4hMJQ3pcB8uF4Q0+CGGvMiUPOnbC7tSyAoQ
	 BtOop+n4OWsPL7H0UWzjZLyto2kF4/J8xPiJN3FCNMTQMUCD9GX+GQziRFa80/LCcZ
	 UoG6yPWvR6CRDpVCXYRSp5AlBsILruxlPy8YwIyoMbzmYtfTzO902AVsyZkQCvGQpV
	 kIjdFREM4p+ZF5C3Rm/ju4RNstrSV8PdJ3bsx63o+LiNg4PB1tOU+yJPnHefQyu8fx
	 u4w34ozeujXfhAELHBOjBlmmMQpbk783Oq20fbty6Q3aZwiyGVRLplgokQkIaQFl9d
	 l8s2KrJfR/DTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 61A4D40AE2;
	Sat, 26 Sep 2026 11:35:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 99D4F194
 for <intel-wired-lan@lists.osuosl.org>; Sat, 26 Sep 2026 11:35:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7FBAF4009C
 for <intel-wired-lan@lists.osuosl.org>; Sat, 26 Sep 2026 11:35:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jx_ne35uEzMH for <intel-wired-lan@lists.osuosl.org>;
 Sat, 26 Sep 2026 11:35:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 85E5640050
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790422540;
 b=Lj9jrKhzo65ODvbi6j/zyWec4oW28uFT7MBSG3m+ZsaqhrUHIgJ+BbkerQVntRTbAFCK
 cNkKaa2TSAkyU171JeTJIknmkfzVCc0eQDWN9U2alT9gv4PmZc83pLy4xthbql45odXK8
 fw2lRcI81rbm0a2+pQKJUpuZK1vAC79ZMv/1y0eP7ZnS4GVdX2q+jCXyvR1wqPDBj3kxi
 pGeVZfDaMVsvrdwB+KDzH54/tK5OCF9sz+K4FzVjM2S74oQ1Ra8dblgk+X8XwWTRENvnl
 ZEzJYFAYF2E6i+FyE1FOhsdN4DV0/zjJpoMyhzbMonmyu5OlZ/fBUQmOPhuex3BUnKw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790422540;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=elejCM3I7aiBIJk4EokP1CKIsPf6qMSVFiV7ceA0xps=;
 b=MfM8jvgdlNKkID7iOrmz4dSklg9JXiUQKn71+VTvVdubM/fSIqsDDaKjZmFT10cV5Abo
 Nvroxm4IPBC3E3nf0hHU2SqIoeLdCxHLEigL8E4vMONjEwz1QqvHmCcG3pi3xD64NN6oN
 ulFBN5Rl/TJncW7Pl6jeOX/PXG2yfOKSrTqhegj2+ToxYZ/mnCJtUpaTSJmFA6YJOC38U
 goueQHTKMzpk9N+TJH4XxrccIUqvHQ/kP26fLbv1ucQ3vim6aeT05pUIwL9ecaGRsd25Q
 0B9QlLraX++2o+P8W2eXNCWu50f+HvJ654xbkBn5WlJ74HQvgKpTpDW/0OOUuC8O2gg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Qod6m9kx; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:34::e;
 helo=mail-ej2-x0e.google.com; envelope-from=emmaonana18@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Qod6m9kx
Received: from mail-ej2-x0e.google.com (mail-ej2-x0e.google.com
 [IPv6:2a00:1450:4864:34::e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 85E5640050
 for <intel-wired-lan@lists.osuosl.org>; Sat, 26 Sep 2026 11:35:40 +0000 (UTC)
Received: by mail-ej2-x0e.google.com with SMTP id
 a640c23a62f3a-c2dc2d5dc0fso2061266b.3
 for <intel-wired-lan@lists.osuosl.org>; Sat, 26 Sep 2026 04:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790422538; x=1791027338; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=elejCM3I7aiBIJk4EokP1CKIsPf6qMSVFiV7ceA0xps=;
 b=Qod6m9kxZFPAwM77i2IhaYEwbhp8WiVJI0VZzEWhQL59JfJcTsZ8skdJiSEeuhpEr7
 kQDnd9DUuqtsR8qFFRpL1gaNxjdDyHJbOwA0zxm9dJfquqyyV5F3HttauEedhMajLXEg
 ZrKOQqO/RHA2ekVrBagC9GMjN5u1nJYyxsRt597ppMFwR0KSTkQ1WZ+Rop6TH59ccPrF
 o1IXuUVV1sWIWJDV7ReZr7rQJtkAzYKanND82zmTQs2cMjM9TE4gBwa58oH8t7I3Y7Oe
 tJWL1CFEscHC8rdVc9fkgupjUtOyFIrlE0WL65kSkw56P+lg99apVCS2+fYMi2lkyfBT
 eg3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790422538; x=1791027338;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=elejCM3I7aiBIJk4EokP1CKIsPf6qMSVFiV7ceA0xps=;
 b=M9juhA9TYrjFEOd9hvZs8TNhEHHKFwpCjutTpvD0WvBA5NEzmuiyyaboI7lJObGrrn
 DgFT8UH8vUb5gwy7mtMrQV5hgiI9pyvhKV13WsVZN+dG/x/8O6ZQmZmcDID0GePqjEce
 pAt20/QGdS1iybws8mrLR2vaXIOGJg/phSjvdIwSy7li7mvHiktbQEtNlsThZjErkggD
 RctAVlha6gHHeAga2vBZphEChBDLX1JwMo+PtOIJAmp35EWzBL5SA7xEF+K44hgQv3hI
 /YrRQC0PJl/lyH+sn4aKnZxvf+evS4izHS16wG0/IlOsWgtFdCPc9DfHX2X46Gn8Yzqh
 Zuew==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1O2mhiBk5W7iEkIDec2iujN293GUBAhR2dvjXIXGcQ7qBk1c/nfpin8jj7/ivs1gaUcJZywDQ9oTUnPyTUd0=@lists.osuosl.org
X-Gm-Message-State: AFuF++mH1VK960X+fc3itZJ6gDDKaaJND1aQNAOE0ieGo3PLY8is9g7x
 OBJjb2jfohkvqYNzTbOvszRWwUQHbUbk5KWiW1dLB8ii7wqJyPp05TKg
X-Gm-Gg: AYBFou0WP/HIqYZ4N8gsRGFUeZNUdrkb29l9fitj7CAxYrLLIQF2AgtTOHC1EcKPeJF
 vWL1X1OCrIZhU2U15zsh2fiVMOlAeaazt3rbIunsbYVMN0kgneBQZZ4zGVNBqnav6eqHlJWtYBH
 Hm3DUYsNmRSlMMXmM9Yws55RdMmPdqlGVePEwFMF38es6qggBpOw6h3thFA0+FLx1VyFtfMPoIe
 ix5abVMdogvCGTQCQ/NphGU70XIrfxTPJWuq8YXTylkfxVVIi2gwlhXuddfutxjw+BI+mqWBifu
 /4Ltcy78fOHYcQBZ+tZHK+Ybpc1kbrogz9ki3N4etv87Pnpa9s3Mp4ltyeMbutTnrPOc/IcBaTg
 5t9z01FNkrt1jG6odEGJCmIczGmbYJrk4G/Mb1nqL2QL5GxcPa3Z8OADqOZxuG7Rcp5RS17q3Fz
 eltEDIP2GzSZtngYOaI6xt0qrJ55GqxBYdfWt/mg872eLkOqxdyYL9MM8WbgqWqNBjQ75/1Rf5v
 CWukeygYgIk71srmBs=
X-Received: by 2002:a17:907:6090:b0:c29:39e2:4aca with SMTP id
 a640c23a62f3a-c2adbca5396mr461262266b.1.1790422537754; 
 Sat, 26 Sep 2026 04:35:37 -0700 (PDT)
Received: from Nuel20.localdomain ([105.118.3.229])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2dbd3a046asm42887566b.69.2026.09.26.04.35.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 04:35:37 -0700 (PDT)
From: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, corbet@lwn.net,
 skhan@linuxfoundation.org, mchehab@kernel.org,
 aleksander.lobakin@intel.com, aleksandr.loktionov@intel.com,
 tudor.ambarus@linaro.org, bvanassche@acm.org
Subject: Re: [PATCH] docs: kdoc: fix struct_group_tagged() parsing regression
Date: Sat, 26 Sep 2026 12:35:26 +0100
Message-ID: <20260926113526.65577-1-emmaonana18@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e8344a91-b2a1-42a5-b65d-e02939103108@infradead.org>
References: <e8344a91-b2a1-42a5-b65d-e02939103108@infradead.org>
 <20260914155127.21515-1-emmaonana18@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi Randy,

> Would something similar to this work for this warning?

Thanks for looking into this — and for spotting that warning in the
first place.

> Warning: include/linux/debugfs.h:246 context_lock_struct(debugfs_cancellation) { struct list_head list; void (*cancel)(struct dentry *, void *); void *cancel_data; }; error: Cannot parse struct or union!

> Even though context_lock_struct is in xforms_list.py, it's not working
> in this case (above).

If I'm reading mainline right, there's no
context_lock_struct rule in xforms_lists.py yet; nothing in the kdoc
tooling handles the macro at all. I hadn't seen your message before —
the rule is something I'm adding in my follow-up patch "[PATCH] docs:
kdoc: parse context_lock_struct() as struct declaration", which is
currently in review in a separate thread.

That's why the warning shows up: there is no transform to run, and even
with one in place the struct transforms wouldn't fire, since
dump_struct() applies them only to the members after
split_struct_proto() — which rejects context_lock_struct(...) first.
So something similar to the struct_group_tagged fix would be part of it
(the rule itself), but it also needs the transforms applied to the whole
declaration before split_struct_proto(), the same way dump_var() and
dump_function() already do. That's what the patch does.

Thanks,

Onana
