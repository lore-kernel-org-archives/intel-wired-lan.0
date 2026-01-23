Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C98D625E5
	for <intel-wired-lan@archiver.kernel.org>; Fri, 23 Jan 2026 06:51:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC7BD831E7;
	Fri, 23 Jan 2026 06:51:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZhDIQtGism7A; Fri, 23 Jan 2026 06:51:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 16463831C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769151074;
	bh=Bh9xMPBAfEqI5JKP5L7PsbeTrLZpUAW4aLq8P7MxDI0=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t0OLT3weJ/V4wJh7x1z4hAIfldBEExuakAzMTJP90gUX1QtfvvHd3i5fJF7ywIsDi
	 HFrwJq7lT/znxvTigPXGXTcmS3hJ4czvPfRyMu0DY+IgdeeI80UfOzn2rm7pRePOQ+
	 vAhzKH6pBwhSmkVEG+P4p0ZLQKpgoseq1p4/IM5mYCDVyFtzJKK23w9jvmiQ+hQTtG
	 HiUYiLMew+VXa0jhem6PvkPKwqPl8Exi7G4BV2Ni8V7+oJNI+aO+pmEe16n+xWTt7j
	 16bEkKkLqZLR/9VU5hE/PtpgYwCwJTwY5BINoQKFqE55E1F6CgOha1PP6BfLE8Ewax
	 e86i5qzDRvQOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 16463831C1;
	Fri, 23 Jan 2026 06:51:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6DA3E158
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Jan 2026 06:51:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 51FD1408C0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Jan 2026 06:51:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZsIMmgs0x3SR for <intel-wired-lan@lists.osuosl.org>;
 Fri, 23 Jan 2026 06:51:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::122e; helo=mail-dl1-x122e.google.com;
 envelope-from=dqfext@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9A9E740988
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9A9E740988
Received: from mail-dl1-x122e.google.com (mail-dl1-x122e.google.com
 [IPv6:2607:f8b0:4864:20::122e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9A9E740988
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Jan 2026 06:51:12 +0000 (UTC)
Received: by mail-dl1-x122e.google.com with SMTP id
 a92af1059eb24-12331482b8fso113760c88.1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Jan 2026 22:51:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769151071; x=1769755871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bh9xMPBAfEqI5JKP5L7PsbeTrLZpUAW4aLq8P7MxDI0=;
 b=Vqyr3BqAhJJpYAKM3vPZvAAWQYxyCCLAa8sKojvDlfm5gPedBZXJn79ClE85HaLts0
 SjYWbCnSXoIS6oXPKRs1c8b9zbWXvMePJZjd2Piw1e080/gLthnsPoexJSd4UxsFW6AX
 XeaoPDw+8IdjiXGiiU85IpY7LhWpcWxBjm7qpHjxup9mzCZh8FGXSejpK78xV5BiOqZH
 iLz8zXRZEPI5ErtYd9uH24XJPff6tY2/ccdNgOV7f7AqskXP3W73vkPSSMbLw9/VLpte
 o4dH1y+S7hXl2HBglVqwCa0dpNb26etdLukuG37uuYSrU2eeqH0NRWdpHL38zkLZR/uE
 i1UQ==
X-Gm-Message-State: AOJu0Yyuk+idk594E/CpKCAx4ysYRUbQR2f72JRzZPhCcRyHdWcgynfW
 D9cHTl0wcSDdQ6SEq0bTCBh0ZQ9sogPFh35buCrcG0q2RH4AusXVdyK2
X-Gm-Gg: AZuq6aI46XhZ/fcakIKh5PFznzEzwv1EqgCP0difq/QgqrIboJhVcaa0rhs5p6M0Odv
 GziAMJGQQ6atKjz5m+fCYh9N++N+XJCl/eAUWv0QGgN9gdtEIS/UhVmQNAV6/HhCkK5d5wlGzhH
 0hLN/nXbE2xwiKdottxQwDAPgpAcelox7WEOnpF3cfd4ARzNrOtedSwCOp8QUde8hPA8fXKLn+M
 gnAJMSIiLW0n2U8iM7FPLAfTmH2dBZCwhy6LOEXmvFcjEWzT3q7LyxNlKuU5juym1IpKurhcCTJ
 h6MwMmnMeYFxYFYUwNrGVnL9VPwEGwRnKTpABzZFnqJRVjuOMtFv2ee4RTabmVtJfOFM8jvDQIM
 BGT8KG3C7cFRh50d7ApV/HllbLpOBU0ho/7dDTEyVvyoE7R+yL6lE1mg/n3jKiVM=
X-Received: by 2002:a05:7022:438e:b0:121:9f05:7e4c with SMTP id
 a92af1059eb24-1247dbbba30mr972266c88.16.1769151071394; 
 Thu, 22 Jan 2026 22:51:11 -0800 (PST)
Received: from gmail.com ([2a09:bac5:1f0c:28::4:33f])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1247d91c52bsm3071176c88.6.2026.01.22.22.51.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 22:51:10 -0800 (PST)
From: Qingfang Deng <dqfext@gmail.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
 "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
 Chuanhong Guo <gch981213@gmail.com>
Date: Fri, 23 Jan 2026 14:45:22 +0800
Message-ID: <20260123065052.237216-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <IA3PR11MB89869D6FDF168BE8A17C40FEE597A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260122085102.1117651-1-aleksandr.loktionov@intel.com>
 <IA3PR11MB89869D6FDF168BE8A17C40FEE597A@IA3PR11MB8986.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769151071; x=1769755871; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bh9xMPBAfEqI5JKP5L7PsbeTrLZpUAW4aLq8P7MxDI0=;
 b=asFoKHOKK9tIg95FiP3NwifmO2F4ZDqW18tJnWDvFpEJpcrnC1eH+iaXSwd99FcnbC
 cjs+ZWuhr9wljLl1knvRxmbMHsuW2dzYJI89KDvQBm/jhHngcOdiqI8czKTsdLXdl7OD
 j9wCPSxIl56baAKPBq1nq02HqFMemXpCv8I280DcUHyIsdK+B19V2CXT+si0DsP2+rOA
 iXJIrqncfoh+xz64CjZbQZ1Es8JEdjwTJ61zO8wDU/fa5Ey9/4Rh9eAWHakX/GHEKJfZ
 Jt2rZsp/Bb2FgC4SJthWs5K3eolwBoxzFl0fAxX8cp5mW90cb54N86mIYD1D+N6hY57e
 KoHg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=asFoKHOK
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] ixgbe: fix type punning
 in ixgbe_update_flash_X550
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, 22 Jan 2026 10:12:54 +0000, Aleksandr Loktionov wrote:
> Thanks for the review, and agreed on the root cause.
> My motivation here was the mismatch between how the buffer is defined and
> how it’s consumed: the current cast-to-u32 * pattern felt brittle.
> Making the HIC buffer naturally 4-byte aligned is simpler and clearer for
> both readers and the compiler. Separately, while x86 will typically
> tolerate this, other architectures require natural alignment and may trap
> or penalize unaligned 32-bit accesses. So even if a crash hasn’t been
> reported, relying on 1-byte alignment for something treated as u32[] is
> not great practice across all supported arches. This change makes the
> layout explicitly safe. I’ll resend with a corrected commit message that
> focuses on alignment (not strict aliasing, given the kernel is built with -fno-strict-aliasing).
> 
> ixgbe: fix unaligned u32 access in ixgbe_update_flash_X550()
> 
> ixgbe_host_interface_command() treats its buffer as a u32 array. The local
> buffer we pass in was a union of byte-sized fields, which gives it 1-byte
> alignment on the stack. On strict-align architectures this can cause
> unaligned 32-bit accesses.
> 
> Add a u32 member to union ixgbe_hic_hdr2 so the object is 4-byte aligned, and
> pass the u32 member when calling ixgbe_host_interface_command().
> 
> No functional change on x86; prevents unaligned accesses on architectures
> that enforce natural alignment.
> 
> Fixes: 49425dfc7451 ("ixgbe: Add support for x550em_a 10G MAC type")
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> What do you think?
> 
> Thanks!

LGTM, but do wait 24h after v1 before posting v2.

Regards,
Qingfang
