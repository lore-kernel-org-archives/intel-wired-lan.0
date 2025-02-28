Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B394C282C6
	for <intel-wired-lan@archiver.kernel.org>; Fri, 28 Feb 2025 17:56:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 45F1B6FBF0;
	Fri, 28 Feb 2025 17:56:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xhCGIsGcO9Oz; Fri, 28 Feb 2025 17:56:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 937996FB2B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1740765382;
	bh=5hRTl3r3drZ3yXZusZSc/icHJkO/HrAa3AEWepjTDtw=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Fy3HGfY0fMPUCGj8SNcRAJqjo+FrAAq+fmi8zjRUtnVLKB86by3HgLpnCzJo2SB4f
	 EvhpuYzyxyhj/NspCyLOHE3TRHcMMP4hqmDs5y8wL3XD4BgtRKPM1LHk68o+MHvGUL
	 7GbF62mf8z0nHsKVAUd9oKmd7MsCUOSsxr72Rgn3DuiD+iD1tRa11mo5CEALq9Nw9t
	 +T8pIGaPyBcMo2A7h52nolpSgan7PQouQKliCCE3QrVkW0K5J2t7WRNwA0mMIFNjfo
	 OIXlS6o19dAe/PSy/t6xJN7Tyl5Ibg2l2EZAyYLpmW4KlXTOfpYu7WaH3rVPUiyypS
	 Z85AWPZ0dh9Rg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 937996FB2B;
	Fri, 28 Feb 2025 17:56:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DFD2A68
 for <intel-wired-lan@lists.osuosl.org>; Fri, 28 Feb 2025 17:56:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5137F40AD1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 28 Feb 2025 17:56:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MY6NUNoOGKbb for <intel-wired-lan@lists.osuosl.org>;
 Fri, 28 Feb 2025 17:56:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com;
 envelope-from=almasrymina@google.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C14C1403FE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C14C1403FE
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C14C1403FE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 28 Feb 2025 17:56:15 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2212222d4cdso5435ad.0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 28 Feb 2025 09:56:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740765375; x=1741370175;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5hRTl3r3drZ3yXZusZSc/icHJkO/HrAa3AEWepjTDtw=;
 b=RHi2+fbF1/1qyVEo2Up0Q40IxWHYKIsRcfNkpzC45VnyPCK8+vafVrAvdhB3WtrDld
 Oo9pPqVDI/TgxwwxO0MtB8+JNmifENervu+KrgfWLz0mwBD8F6hrKa+pcpMC/3X8jCN0
 /tjSidyrhPhzq3S7mPC7NKkDfNP21uQXNdzkhD+Z6dWwCC4+95437xn2YeWDhNrM+Rm4
 YjDLmnJOOS3VxggIbkSwfxNa3m7WEOtJRXzgKoFefxMvYFZEQ4ApPgSwFyyZDC5ZA+0K
 TEyzJog3sh2XeRa53TLGJ3a976W08/7pz7XQr1/enfxjUkfKa+Xzyi3RrIDE1H3jYvqy
 oTXQ==
X-Gm-Message-State: AOJu0YytBVFIF6QScDh8asYl3PFOAOqwZCpz4ob7ZnzbFtrhTiomx1Yx
 jjGlYZUqSeF5XvsqCt14YhKzI3nQ4dUEhNqZ5raUsDplJYgyU/Rb7PfFUVAKuIXQL9MN3Xl2T8b
 EoqmWlz1x0pAkFL+hBqIAWyNUDodyqnSzj5K7DbTPwrlJqmzusaYkdVE=
X-Gm-Gg: ASbGnctfWGuQLHpHx0wGv43peh7Yew4reXbs+wFQGx+lyVB54UQZX3eY4RUhqEqWzb1
 fBnbFOAU45vCueBCdtqb72xXeeJL1LIzEgfKXRDnfwnHRVoGUFJiCor70IfFaplCVjt57oDVaWQ
 /izYGr6WZySQ6PmmFUHOcbNqIW7/10NZjciHXIZA==
X-Google-Smtp-Source: AGHT+IHvdnKescx2kw3tjKRz2tVygkrDpn+4ZfC4ReaPOfaumZ9avniHlNFfBe8qYKkmDTpQkbHQk317lMLV8Kp1TDc=
X-Received: by 2002:a17:903:3289:b0:216:6ecd:8950 with SMTP id
 d9443c01a7336-2236cfcc5ddmr2648305ad.19.1740765374751; Fri, 28 Feb 2025
 09:56:14 -0800 (PST)
MIME-Version: 1.0
References: <20250227131314.2317200-1-milena.olech@intel.com>
 <20250227131314.2317200-10-milena.olech@intel.com>
In-Reply-To: <20250227131314.2317200-10-milena.olech@intel.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 28 Feb 2025 09:56:01 -0800
X-Gm-Features: AQ5f1JpliY1V3t3crBxg2aKI_RrAsIU8HZYa7-xkZpdESpK3YJeqZioAsHB4XfE
Message-ID: <CAHS8izOL_ZGjN0nN_YTQu_py05QqDrYZvvU-z-Jv8RuWhfBUEw@mail.gmail.com>
To: Milena Olech <milena.olech@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1740765375; x=1741370175; darn=lists.osuosl.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5hRTl3r3drZ3yXZusZSc/icHJkO/HrAa3AEWepjTDtw=;
 b=aNqLXn/DVrKwvkdE62JpzPbticxjk4DxUpzZYLD28/ABHbPTSPX5I7PwpgVqm1ihH1
 PmO1qJ8Tom7QvftZsH549mUDdaT/8CFJVQOQ6jK3HoBeAhNPSOHEGfrsgFrlC9JeIReo
 kRl7mHxCD7/6O50IvB+TA9Atsrfypwc9Bc6EXjh8O+gEIhAvnnZUQ62f7MWSjOaHJTWv
 r6NmuGoV0ZnR6jiIsxb6hY5Aw3lPQS74CABz2mgxSpGKYCumxE7n+AnZP1+BzOMv8CKa
 MVffN0h9U6GtImyXluXC3TOypEanQ+PqlLnUQBZ6NSyYrwRhqnXTQ6F5fqsCW160h5SW
 s0JA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=google.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20230601 header.b=aNqLXn/D
Subject: Re: [Intel-wired-lan] [PATCH v8 iwl-next 09/10] idpf: add support
 for Rx timestamping
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

On Thu, Feb 27, 2025 at 5:19=E2=80=AFAM Milena Olech <milena.olech@intel.co=
m> wrote:
>
> Add Rx timestamp function when the Rx timestamp value is read directly
> from the Rx descriptor. In order to extend the Rx timestamp value to 64
> bit in hot path, the PHC time is cached in the receive groups.
> Add supported Rx timestamp modes.
>
> Signed-off-by: Milena Olech <milena.olech@intel.com>

Tested-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina
