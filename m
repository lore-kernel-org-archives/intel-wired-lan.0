Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB91CA5FFC
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 11:07:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC3EE40363;
	Tue,  6 Oct 2026 11:07:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KxNIlyO2LAUK; Tue,  6 Oct 2026 11:07:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 119FF403B3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791284852;
	b=qDyfZ6W/UUrsGDPeC6bqwRGtDkmjasXy8Qbpycvcfm4XlfzHDhKyp9ngT068Ex2pFJA1
	 zLW5Gyi0nWtUUwqi38opKh9rW3itr3sarvVmGHNSwwxAaXO1QwXlxj/zD7OLd+fqcH+Ga
	 sfEv1bJIgPw2mcV23Zg81LhPqy5tDBJ2ONMt3F8GihQ15QZc+Spgp4fmGmgrl5WeKcgbc
	 6TJf0w+zBGwgI5BmQ00VbdO2TeQJkksaH+Y6K/hQWrLevRgjEsVCctKQVHYt7vizrjOY/
	 2RNKjVyPe12Y3YXYdmC6yEmazRF2/b0visAjonczdyQGQYFuA5MC1yMtUMDeR4ZEBtQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791284852;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NI6ZURTheFOwf7xfJ3T7rNEzU2/d53FWKsUxLaM51H8=;
	b=NhA9Mkm2amYgr2nsvjt6cRkh5Cx5mPn42UTVeFX6w/jbWLClpPfKVuVqvYBJrK1LurQa
	 lMJeJAvTbduXSFfPAQJa4qv97p2//LEfUiI5Xp440PrC6qEa4ufwcD4cEnikkFp1P7g2R
	 wANynhjb9AJALvG6rSdSARskGX3V5sIMaYQIDKH2awf2rLp2qigKs/jO13kJ0Ky2WTZZ9
	 /ZDMtuo7yqR7HrsZJl3Ab6pfxM43gwYV4X3c1fp+Q73l15K9/XszuZQjfVXLUPHfCgSVj
	 CrcJpzxPKb1CRb7kA8DfTxbiMlZcQDLr7/i7U2HElz9Wd5jFY/QkPHgYPCM6t5yiaPA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791284852;
	bh=NI6ZURTheFOwf7xfJ3T7rNEzU2/d53FWKsUxLaM51H8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DosrD3epWtYdUT2zwg8lG2WuXpj3zSiEW/Ye6th2WJQYguJAEwlneUAZZgozj1BEq
	 L7KYA39YvbKXpz6051HuHf6EHlHktDGwVZmZsifq1vzO6fUqgDkJHkMH7kL0nxXQTX
	 qMpbA+kDreqcucpj5Aj7kKHMap9lqbnMbBYeOfQY9uZBLuVcQ6toGaYLu/pPxZ2Vy9
	 zM1sSyKAAZAs0Z3ptQWdvVw4tOTCwshU4211mAHua6wVlKANnC6Z7dibL1k7Z6cxnb
	 Y+SdqD7lKYwQ2nrKlKAPltFJC2cZiwTN3ns7NbP7Yl4/ds1m1ZtdRFFO/Arqt6yGvS
	 TVnjkKX2+BNWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 119FF403B3;
	Tue,  6 Oct 2026 11:07:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1CFBD22B
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 10:56:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 02E4880AD5
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 10:56:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OnyukSx35w2X for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 10:56:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 443ED809C4
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791284203;
 b=iQX6c/hFzDbeqLDJ6Z3fcc5Sf/vizomnNdTFcU0DFnUEI8L320b/6Nkp3GiUbZBrLYgx
 n54MrTlBywQvIQ67UHwW0Fnp3SNQnZWWKsQMT8XKT0gmJyQPsT9KymvrFWMMCzELtC3eb
 qS3HWIUBb1vv524SeHDD11GpK9qwDAFXwMAeQZ9IZCt7Nu7eSjGz+k9/yRGml3tTpRXWh
 fMw6mLnCTbl+iXTSqcoQOYi1bV+LZg2xeoCnG2ZK22OB70I3BZ0s8XCaqCyar5wSMZhT8
 zlAm0VhwxYT2imCZPSnxeoXbwQ5ONktyTYvlAq+eb+32RaujtWE1Q+5/IMOMqIH0c9A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791284203;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=NI6ZURTheFOwf7xfJ3T7rNEzU2/d53FWKsUxLaM51H8=;
 b=KuVUf7zLmAGH8DqmzZujRaZJ65zNUUbknx8eyJ7GDMeJTyJ9qm2YQGWZn05f/T1/vqsI
 tB/hXFPw3FT7Iv35IPaJVaHJFIEcRcfBYQBt8mpmtdQa43/nisGwAfqVcmjyb2YEVxSbG
 4novZsRhOv+ovCDSmMVRY4TiEBswa1BBjPZPR+gm8xaLIyuwIc+93Lcvq1hUPOFRFoWnW
 UtH/kyF9iLFwvigEU+HshMPXmwHYptk2IBoTHHDFJPhPNASJ9gYtIaW90tYwHJg16qgsm
 PRgB2+L5wca/vPYrhC4IKLKIIcJ4hXRItdtbrL+UzDZCulRn1Hf4gG6d8MWEH2GfkCQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=C9AUJDhl; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com;
 envelope-from=luckilystar08@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=C9AUJDhl
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 443ED809C4
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 10:56:42 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-398a4dcf289so403782a91.2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 06 Oct 2026 03:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791284202; x=1791889002; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NI6ZURTheFOwf7xfJ3T7rNEzU2/d53FWKsUxLaM51H8=;
 b=C9AUJDhl8Ly9zzy66gcyKJAS+o260oEFLFn3XO2VNtfiuqh6eXFa0QVn8T3Y0Alwz7
 +oDTdok+IAGMA3NQYa+8mlzJB2DaJMolohdiEC6LPdmtLCQACT44psVwUMpB1VhF+ikP
 inNmaCACeWhroQ0amzwwEHfwXu/SmnrMGOtpiLd26OpBZq+YWQtqXyfbvR4exzrn/zGr
 Dw1AoegjOB3qFrJhHgHm9RcpM3jFt7mn5dLJnrsjForRS9w+5n9Py3m8UXneGs1emIoA
 snFnWROL9vC1z2XSy5s3/iVEEYJjc+zLalxoztxJv8X3D3mo8A3hMFR+7arh9OOeAW9H
 YaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791284202; x=1791889002;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NI6ZURTheFOwf7xfJ3T7rNEzU2/d53FWKsUxLaM51H8=;
 b=waVdMFq19tB0bBQPOiOUQjAQ7s2P+fkVph+zTeiQ4IUIAp+RBQIHyvFBxs+gRWARsn
 EyT+tUTocCgEAjdyQ3I4tpFN7TB/cCteQA5ouk1JDlaoATa0GHvRq4HQPDru1Q7vKPOe
 M2Yz7SVUAnA7nisgCqK4GcedrkFLzezkWEKJKVLxgn5/0J0/G0Op4fbGW43QZQ2mOSjh
 zuuGKe2ZPhC8n/A4D1kZ95E5m/yYwXWW2bEwTRsb2xi6wybsO6h4YT+UItXM3G85AKDE
 zJPuYUe2M/kc5V02ZsCezrn9/oJfceA4H/8Hn2DgKc74pEKlYoBWguf3sJqoymvOxXsM
 4fgg==
X-Gm-Message-State: AFq9FYKlRC+eLydQ4MYEJEGnBribrpCfPa42RwHlnFnIoC/vmTyIXKtX
 HHtFMvwUhBnK3c+DqGJcyBZi2tIPJRmO4Ay0Xy3/AAx89yTjBtGk6bJT
X-Gm-Gg: AYBFou20tYjLyU9K1QqDDhC2MMR6SbyZEYAEeOANqne3neGra3cn///V/G4HtsdcLqX
 bfgC6PdfqxEyni4YONKk2vhgjK1PYXefQU9jc0AeJ76/d5aEk9GZbsxAsRm6cwUOQBxNMsiJuDC
 GGcjto4PG/dnTdcqQ1NAzN7ph6dTUNTtI6ReCW0va/pH0ijStrTugbno8+0j5wK9Dwx9Isrdo34
 f0hl/aBhcFZgIcChzPJDKzykcrdaDD3u2D93i2FF7fqk5XuyzRRWIOxGvNFB9t9J/r1hEz4CL5o
 WLBfqEYZOCdQRLv7eJnrnPP9Hzw2L0U3YLMWfSwfzO6VJLqwlsIXw2T916jGziqO3x4uM0oYqTF
 YagSeGfgIA55KOfRVsIQ3BZXabNg0aYpT4eR9+7h/vrzwhGrkyfDlBzm05NzrFMb4/8Ftg1STzd
 Xa56fqwRrZ8X0FMIFVVnmT0QSOnwjgd0g5xGf7wI/RZJmcUwf2fA3amaBiHqFV+k2VSIq1BHhYE
 3/yq03LbnLYPPnwShG9NQzqr8Kiets3YErwWFXJVu4meoxnMvLwTaqHUR47ZLEDkT7OFHHtqZaf
 S38F+2y1tdaXcQ==
X-Received: by 2002:a17:90b:5825:b0:3a4:b0ba:8e4d with SMTP id
 98e67ed59e1d1-3a8730e713dmr376259a91.13.1791284202002; 
 Tue, 06 Oct 2026 03:56:42 -0700 (PDT)
Received: from C9P9279WY4.bytedance.net
 (21.186.101.34.bc.googleusercontent.com. [34.101.186.21])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a85425eb41sm4735366a91.8.2026.10.06.03.56.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Oct 2026 03:56:41 -0700 (PDT)
From: Tian Xun Ng <luckilystar08@gmail.com>
To: Emil Tantilov <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 aleksander.lobakin@intel.com, aleksandr.loktionov@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Tian Xun Ng <tianxun.ng@bytedance.com>
Subject: Re: [PATCH iwl-net 1/2] idpf: keep the mailbox up while tearing down
 vports on shutdown
Date: Tue,  6 Oct 2026 18:56:29 +0800
Message-ID: <20261006105629.7481-1-luckilystar08@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <008a657f-f914-4191-b5c6-0fcc062bf73e@intel.com>
References: <20260917105205.37561-1-luckilystar08@gmail.com>
 <20260917105205.37561-2-luckilystar08@gmail.com>
 <45ffbd03-653c-46fc-b500-07e9b99f295f@intel.com>
 <20260921032827.32485-2-luckilystar08@gmail.com>
 <008a657f-f914-4191-b5c6-0fcc062bf73e@intel.com>
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

On 9/21/2026 2:06 PM, Tantilov, Emil S wrote:
> In that case wouldn't just the reset on shutdown be sufficient? The FW
> should clear the resources on reset, which should take care of the stale
> vports.

Sorry for the slow reply; I wanted data before answering. On these
devices it is not sufficient.

Same arm64 hosts with two idpf PFs, IOMMU translating so every stray
write is blocked and logged as an F_TRANSLATION fault, warm reboot in a
loop, counting boots with idpf faults (always ~19 s in, at the first
queue reconfiguration):

  shutdown as in net-queue (mailbox shut first, no reset):    10 of 10
  same + PF reset after idpf_vc_core_deinit():                 2 of 2
  same + PF reset, then poll PFGEN_RSTAT for completion:       10 of 10
  teardown messages delivered, no reset (IDPF_REMOVE_IN_PROG
  set in idpf_shutdown(), the effect of this patch):           0 of 100

In the third case the serial console shows the reset happening:
PFR_STATE goes from 0x2 to 0x1 within the poll on both functions, and
reading the register mid-reset raises a TLP error on the function, so
the reset is not being lost to the reboot. The device still has the
previous kernel's queues afterwards. The reset the next kernel does at
probe (IDPF_HR_DRV_LOAD) does not clear them either; only the
disable/destroy messages do.

Is a PF reset expected to drop the vport and queue configuration on
your parts? If it is, this looks like a device firmware issue on our
side and I will raise it with the vendor. Either way the driver cannot
rely on it here.

> If there is some clean way to shortcut the MBX on shutdown then I guess
> it would be acceptable, but I don't know what a "safe" timeout would be.
> As you can see the timeouts are already quite long, so you could
> potentially still bail out on a working CP that just so happens to be
> busy on the replies.
>
> Also, consider the case where a reset on the PF will kill the MBX for
> the VFs associated with it, so a shutdown on such a VF will always end
> up timing out, since the VF reset is a message to the FW.

Understood. Given the above, some mailbox traffic on shutdown seems
unavoidable if the stale queues are to go away. What I would propose for
v2:

  - keep the vport teardown on shutdown, but give those transactions
    a short shutdown-only timeout, and stop at the first timeout
    instead of waiting on every remaining message, so a dead CP costs
    one timeout rather than several minutes;
  - skip it on a VF, where the PF/CP owns the VF's resources and the
    mailbox may already be gone;
  - drop idpf_is_reset_detected() as you suggested, and drop patch 2.

A busy CP that misses the short timeout leaves us where net-queue is
today, which is no worse than now. Would that be acceptable?

Thanks,
Tian Xun
