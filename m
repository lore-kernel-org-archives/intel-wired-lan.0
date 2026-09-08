Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DCD4C79FAA
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 15:14:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D835780BBC;
	Tue,  8 Sep 2026 15:14:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id deS9qa5W7ROu; Tue,  8 Sep 2026 15:14:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3CC9980C25
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788880445;
	b=DIDmNnyrfHODP8lTCIMxt7XWb01QqEjP/uap0YI6RcMoIiAua9AnGmbqekmNbkqQmAHv
	 LH66L2Zf9Bvd3/MIcPNFMBDFWOB2rPBaRLltJ+AtUbo3gd+PMPpKEl08Cnq5zAV3ikKuN
	 zzHlY7SXBsjT6SFc77GGKca65uQAlKlpi8wE+fwcRA8ROyrMmwfvHd7ZvTaSesJr8n+hp
	 NSmdVzHOwpF6T2/MQM2v8UO1rwsdUBoAEYm67WztNGzzjirMlmYHsSo0snEDsSGqkSWsW
	 5W8lcynGjAIr2NC9MRR9wm+8+MbYyvZxt+pJZllyuFhMuSpjv0o4I4sRpqJrVSSxunw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788880445;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=i+9kcEfU+zg9dMswCCCtsz8ghn2YtDfgBRBD9i8GdfQ=;
	b=P/MuZabeZo+6WvjafS6KuZmp2k8CfD+WLYkMKxsx0HOosWcDsUWkpe/9wBqBG71gPArV
	 s34q6EVypigkNRxAfGEaBPdr6EJJkYF/MQVO5ogUOt8kA2joIkvEbOxQZdFu6ib+6n8dr
	 9WaRQTkmKwRnf/CsJyhc9erSYKGyEGXJRo9jP8ktbwEaU2PJguOvq1e9vNM6ZvI0a61jZ
	 BPWMa6MMFu/KZ0feH1anjtMdwLFtL1rHdAPOe0vl8/2m/4rU1Z+vJOCggoVvtjcWrt6iR
	 p0WxDex8VonWz+KjdbTQ8+AuSeb+i1V8cmg5SHYJvYZyhhDzbuVqgRRkeDIHTdZdoTQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ITC0Bmra;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788880445;
	bh=i+9kcEfU+zg9dMswCCCtsz8ghn2YtDfgBRBD9i8GdfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wbqz5NLBpAv+MwahmyIaujiN3HGzdnNWfjWopS2NtKwsi8eOL05TpxUggRlhhFuF/
	 XobRKC7xEreWmPjk4T+rwuE0Lr4di22jLXtt8nhbrU+jpQ9nezc+L9MEWUNPz2VhDo
	 Z/XvsJrHcXBD0XRDTjemKaBMNHB2rvMv9Zz789A3y+ohPRBmeqsslsThnTcUPaQFl8
	 mVsHphJubBMjdH/dtD9KVjMHklxl/fu4ikCIdVatqbgWOjBap4a3s0Hykl1+dXgK6Q
	 EwH+gcBVWVnKawc68g5lZ/S11O8UBuFzXxnDvlnDEnR2mHiXQdKvguQ420NTJY6b3b
	 gHEUm6bDPPI1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3CC9980C25;
	Tue,  8 Sep 2026 15:14:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C5241A48
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 05:46:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C297C808A2
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 05:46:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qxXlr4R5sDt3 for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Sep 2026 05:46:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 291CB80892
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::529"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788846412;
 b=SOa8f0UmHSW/mKbQb9hmUYy0nSERht3IBVy+UOk9y+U29H9oxJ19XdPBxWugde7aRv/T
 hnWVm6Tq0R+F8k9nG2Pdc2WYPpnmDACC9NvtEZtGhz1+PN/7ZJVaFDNzNnjJBN4/Ifp0m
 duHr7ChCZlqX7FhceWuORxM/O/s7o2NNPV9We7GFfaKMJ8DGmPdGR7m5XqskUvOapwHiy
 nbwzD+0udQbfAzkPXE4rgF+weWuhcRwT7SdXMat5w7ovB301YS1TjG7T9nkZ7o/4wvoYB
 +pFCFOL6DZs45LZ70U7Yv2USDme7ydP0oDyvfO6hN3tosP5awH+t6g9vWBcuiNab4aw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788846412;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=i+9kcEfU+zg9dMswCCCtsz8ghn2YtDfgBRBD9i8GdfQ=;
 b=R+yIC8vc17mLB1tJHjQM36JGWNVOo2wOFmhXD6J5qe7vz1aLJdfo/hrBqM99ey0/uQik
 d1ngvM5/IQ1gjVMRFEPSOdQC7B3/VtioT9Nzwa5sJiJ1zD3F66Gsf6la4ZL2NJ71u0zow
 YaohdW6Cte1SrZ1kDxKKV4Mxk2OLrZfX3x/g4Je+EXloldhp6IwvO9twwFjrc2jzudx0J
 JBPOFxU+M3hiP8y0H+GEj+IXWwr47Z3q3BJJrb8yeOarb5rCrjr70t8SP3U39au4vAh4I
 BZeej/uM8/redd5e6W1l7ZytR4BiXKdMsQoVVKdP5Nlw9+GRBihrnu9H3thBjGk7gtg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ITC0Bmra; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com;
 envelope-from=hemanth.selam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=ITC0Bmra
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 291CB80892
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 05:46:51 +0000 (UTC)
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-cc147d86bebso3479673a12.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 07 Sep 2026 22:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788846411; x=1789451211; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i+9kcEfU+zg9dMswCCCtsz8ghn2YtDfgBRBD9i8GdfQ=;
 b=ITC0BmraodBz66PtUlAo9YOzKkub5RADq8Jybcj348JaqGF8gb7nkKViTHAyNlnLXy
 qeig4f23Gf5qsX1USXKEk+TZTc4VpsBfVVswjks5WvOInmYe/L4C5yM941OLmcSlOmps
 j5pKQSRvlKKL3uw6J1n0JuG68b+S/Bwnsxy9HT4MVZ9dYBvyRCuUV19CNMXP1c/zvk5Z
 +xTNUW9534hRjyqwGCOmrKzirhV3JfxdqwfvekyOqWJo0+S3msYaTmQ1XUSjk0yAzNXU
 5TdZoqGatb0UaRvMQn50bgdBvywgdcpZFjbyNbh7LwSX/8m83xNZL9suMdtcwGVkBQKb
 IR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788846411; x=1789451211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=i+9kcEfU+zg9dMswCCCtsz8ghn2YtDfgBRBD9i8GdfQ=;
 b=cPe2yX6jtxMiVioeYEdL72VfKcTUkquhznN7ejMD7wfXW4yUfNB77zFvZapNVX3k5W
 vMlU7Yi/emZSqSRoA5oTyG6/QhNZrKnWT7gl5tatTwU2vY0H72ogoL2sJVc5Jm6hlIvK
 St3oh7L8hBmIWS/DrexwXz7me1QtwHfWEQL1LQ00j88sh5U/7NHcqnQfEew1sFwFZgXF
 Ccl9mu3yezzCK+wlV0vekTDzbcEeDlxZEB2rIhO85Y3+OJ2AQWr0Y5OQ/cE/uyBHwdai
 esM5ihwVDViB3LrIKcKfQSPJSl1V8u1BhjQtEJzKJUlE7HKqm3Um+6fsBPfK+6lES8BO
 t3mQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwjLbc2KdDnREcKEXCHLzCdBTCHb2Do2mOQXZLVIVp3UpeeU2AVKULstDfmRVTS3/kQLnW+SkCTLzzgZeOQyfc=@lists.osuosl.org
X-Gm-Message-State: AFuF++mB56xQ29QLn7aDQT3T9moMnLr6P1OB9ltVsKj+fM9sNmx/RRwV
 SWWybEt2xd/eGEw8eEEO96UXV7fozsgQuXMDCGksdCDGuE/7CYk+Ovq0
X-Gm-Gg: AYBFou0N93wEolqwENXh+cxCS9bqYwlsio+RjqmP7Hf+LnG5xpJgi7fsQlkjbqds2a5
 xdiHChO5uSb2EBQXUlQfSNYYoE22+8BVsbHSJ3w66UTh7womzIg6iODZljGUxsIou2Y1rvMnise
 G4pZLEPhVYP0v9AJKI7Q1eJoX4q/iW+kBmebYYTUxmzBmq+8s6h/gx5iqXZI+2YCUeOZPmJksC2
 c02mT/J7tjO1r2R8XWDMnIoWPaqqoVnmGx7gvQZRai36lFhCOIWZ6auyZEkLrTz1mib4LScKCDy
 0IOEFEHfxCOecMNyGh6CXQ/tOoQ69C/vHKmbqnOtJ5JhdeB0XtSuE8aNInQbSr1t2zDGxL4HN6Q
 GQ+MijDD535UD3QT8sH9BzDOyLDCw6WERzj55uzgibEDJA0Mn1wG8tJQdPDSdLpWRdZxioXocJV
 jYjKtM5G41Crni3wAREVw2nLMv3y3Os+P4JQPEfJYmXKM6f/02MIl2qb4YKZbvl2e3zqLoJFPul
 votDdJMJV/AgEHMZ+roptXk
X-Received: by 2002:a05:6a21:2d05:b0:3cc:f9a0:3ada with SMTP id
 adf61e73a8af0-3da215a6cc6mr32295410637.16.1788846411208; 
 Mon, 07 Sep 2026 22:46:51 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1434c745a09sm2053384c88.7.2026.09.07.22.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 22:46:50 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH iwl-next v2 0/4] intel: fix typos in comments
Date: Tue,  8 Sep 2026 11:16:43 +0530
Message-ID: <20260908054643.11460-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <45869dba-955b-425c-88b5-a9793ab2717a@infradead.org>
References: <45869dba-955b-425c-88b5-a9793ab2717a@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 08 Sep 2026 15:13:56 +0000
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

On Mon, Sep 07, 2026 at 10:27:00AM -0700, Randy Dunlap wrote:
> How did you choose iwl-next as the target tree?
>
> The closest match to that in the MAINTAINERS file is this:
> INTEL WIRELESS WIFI LINK (iwlwifi)
[...]
> but the patches don't touch any of the Intel wifi drivers.
>
> I expect that you want net-next there, but I could just be confuzed.

Sorry, the prefix is a confusing one.  Here "iwl" is Intel Wired LAN, not
iwlwifi.  It is the prefix the Intel ethernet maintainers use for their
next-queue tree, the one in MAINTAINERS under INTEL ETHERNET DRIVERS:

  L: intel-wired-lan@lists.osuosl.org (moderated for non-subscribers)
  T: git git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git

Intel's own developers tag patches for that tree the same way; recent
examples on the list are the ice, idpf, ixd and libie series, all
[PATCH iwl-next].  Since these four patches only touch
drivers/net/ethernet/intel/ and its documentation, they go through that
tree rather than straight to net-next.

So I think iwl-next is right here, but Tony and Przemek should correct me
if they would rather have them another way.

Thanks for looking.

Hemanth
