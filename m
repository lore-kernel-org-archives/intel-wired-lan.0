Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C28CCD98CE
	for <intel-wired-lan@archiver.kernel.org>; Thu, 11 Jun 2026 15:11:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 136308175F;
	Thu, 11 Jun 2026 15:11:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xic0VLiEhE_9; Thu, 11 Jun 2026 15:11:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9E7868174D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1781190666;
	bh=lxKXtOKyjTv+sAJ/+Fz+4at9+0jNf2gFTtOvWpxVwCw=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=IYkwHtHK1n0iMbRpI1iD68Kb/YEzBfFpEV5EMElrcor0jENkWkFBJ4ynvAIIKtxgq
	 9drYvbRldPzwS/M2FW/8lR9uS9Of4si/L/M6gJ97/WWLzXZGARlgVXkjIJrPeZoFRo
	 Tg/elO2gA1uvl/ZhEAij3mJWl25YPk1ttG6xsT6Al1ZTs/vkNPW2W3Xis3EPobvbVx
	 Ip941vP3zPSOeFjViQV5HKUtTJitN2yAVY99WWfweIqZyz198bvq59+2kWfqc4RyIZ
	 sTsLcE4xMgynB/dkboA5ihrV02KuvxSHbKPaTV+z54RAsxzVT4asxs5RrsFOvOxhtQ
	 cqovc1amFYzZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E7868174D;
	Thu, 11 Jun 2026 15:11:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A07B112F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 11 Jun 2026 15:11:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 90B99401FE
 for <intel-wired-lan@lists.osuosl.org>; Thu, 11 Jun 2026 15:11:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 33kwMd6T1wmM for <intel-wired-lan@lists.osuosl.org>;
 Thu, 11 Jun 2026 15:11:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1235; helo=mail-dl1-x1235.google.com;
 envelope-from=brianvv@google.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D5AB940243
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D5AB940243
Received: from mail-dl1-x1235.google.com (mail-dl1-x1235.google.com
 [IPv6:2607:f8b0:4864:20::1235])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D5AB940243
 for <intel-wired-lan@lists.osuosl.org>; Thu, 11 Jun 2026 15:11:03 +0000 (UTC)
Received: by mail-dl1-x1235.google.com with SMTP id
 a92af1059eb24-137dd523634so12724693c88.1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 11 Jun 2026 08:11:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781190663; cv=none;
 d=google.com; s=arc-20240605;
 b=HA2gYhwRfo8qNlmxij9rxI0I4Gh+3YpncigRTZuG6DQN78WC1RaPGoHOL/z9XfOEUs
 D2C/baqSwmrh5/P9p0IY5nKhyEuxEo9XlFaLvv9vjJO90y6PRgdz/sRuxMWOEmCADEo/
 Qccu4ASdc5iVoz8Ok/PJmO9bT0KPh9rw/iPdxgky1DU2CNIVPJxm2ebFIWp1/I7IkESG
 DW+N4cZiM4zJhhtdvmf9R/Q6HMSUDIK78rxUpC7tKm7eLsXGN7QcRf2N90BZaMsNqGhD
 DOzw/EqN1j+4h4db5cFAzyYxquu0UlLBJpAPGSjLTxUkiFJEb0ivYOTnQPiocxbFmA/P
 kwQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lxKXtOKyjTv+sAJ/+Fz+4at9+0jNf2gFTtOvWpxVwCw=;
 fh=GmyPshop3ABGxrUG+wY2RwD/+MiCUSbAFIegzS9pdpE=;
 b=lGrYhET1MQSYy00uDWceVrJzLV0J3cm20Kl294cS4+WbUN7wBZLu0SgWMvExT560Cc
 il7jHBrW6QpD17m3ovGl4j/sb1Iz7FdoS25Xm8V42VYXfPCMJoR8Np1UlZ/d4h1np78p
 a8CXX5Ac7OKbu4KGnsVUeipO0+w348SLbFwJUtBzVDf9IhCtF9a3Gq5QZ9f+UUNoBJ+v
 /UOWIVEnKxxVRyydKptC4Sbch1wBhQkRFSEpyyoFbAhAD6c3wCtF/6aWlsO4d6udwV35
 W1BsF6DQze2gWTObqD0biwerGfmmXyCQAR4ijtRtz8QXdTbpu5Gf/sMTlKgSara9eQC1
 dWNA==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781190663; x=1781795463;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lxKXtOKyjTv+sAJ/+Fz+4at9+0jNf2gFTtOvWpxVwCw=;
 b=GmnTVvZhSbVCp5SnMTcLEa6TcFf14Fc0Ba2VWSM+Ki2mf7n2f37T84YgzyCRRrzgQs
 a197R3qysfViZyhZ96fhHm3zdfDoi//K2IbeGSDPas5OJgGiljsnRcIA0CW4Yptb0vNY
 aUzlYDkBenL7bUaAB0P1Eh7D3hiwRNliuNzRnJczJszQhoO6m55iDeCWlPZ1CLkVS9TL
 PFwIIivXaAM5V6ac2aex5wuR8YBw3b/MaGl0HE76NrdJltUq+HxJ65wz/aEJoTLAssZP
 GFs6rTV7km0rRUuESvjTLuv+uu3sQdTmu16xd4VXP7INZon0aj3OiWzeD24Kna0o9MA0
 fNjA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/h/KlWWyJzQhBssASLXm33bFBYp/C6fxaHHDz8UPoF0LWPF2R2hbOAPXypTL1QAz3HCeDhvK/+SjlQTxiueYg=@lists.osuosl.org
X-Gm-Message-State: AOJu0YyR7qT0yv/zXLb+s+E3DCJTtPKQ1fJqxARJWTR7VHokI1LpifQP
 gl6TmQd1TQj1vQLGuqdbEFIAETd6u0wsboKshoRvgKIgf2P/nfW2AvZXizi+ojVEvPVlB4gNglG
 MTSMI0vKpYVFiMWcRjZt7weZ414T350NDjqWKqodM
X-Gm-Gg: Acq92OEDlBd7R2zT6+uBzHwGtyDw4nxXkmop6K45AxpqejxwxehNFO+aj5K7Opd5BwG
 4gOIZzi900W1ZREJmJ2efthVL8/qkQy215NAMzP26pP8lWwsG8sJ4smKozt6yDjN/3gyWRtEe1J
 VsSmd9BTzPvpUWY2jUYOe/6ND7VfmecZUbwGR2JKPxkOqSkOdddYd94pyTIfbR/f70gyPfjSroc
 x3aaLUWOdLYw7CwYoCIKxbYUeq2pNqmysLtcJpifiofZ2hzi9nLjy0gkpiklkYYEIOUJo3RIkaF
 OWffXTlN7ZE5UW81/IvWQPFU7Kb7O3t1IZSKZhoqueZsRvX0bhVNUPQW0hE=
X-Received: by 2002:a05:701b:4552:20b0:138:44ab:75f7 with SMTP id
 a92af1059eb24-13844ab773cmr770322c88.21.1781190658662; Thu, 11 Jun 2026
 08:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260611002437.1671401-1-digonzal@google.com>
In-Reply-To: <20260611002437.1671401-1-digonzal@google.com>
Date: Thu, 11 Jun 2026 11:10:46 -0400
X-Gm-Features: AVVi8Cd9uZgzE9Vtr2KiKxKuSPVMf5kiWug4xcnQibRwcwPz9EwHUXafig-7Bv0
Message-ID: <CAMzD94SgL2QtQqu26icixW4MVL1D-UsauKbFF6qrtZ7TxCgNfA@mail.gmail.com>
To: Danny Gonzalez <digonzal@google.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Decotigny <decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>, Li Li <boolli@google.com>, 
 emil.s.tantilov@intel.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781190663; x=1781795463; darn=lists.osuosl.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lxKXtOKyjTv+sAJ/+Fz+4at9+0jNf2gFTtOvWpxVwCw=;
 b=bD0+FdizsjAmyE4ghJO6pSOlrMLPgk9zngyPGXw+BRNP3VudwnThA4KqSE9DngCgLC
 cO2J2i1nOG/hCTgateRmwBsKZm9geulml4NxkRFxk0+vfNiR4ZiH3ZlitnzFN9ZBi+CV
 yldZmdsAUTPlXG/zBAOOebGWg2ZQKRqaVjfLAklY1rTPXQG28g+MGs5n3+PvDBsJjg81
 XUv+ICZQq48zqoMAI000EwPLGvTwyK1eWta/cDzxe2Cdv7XdtlOtF1WawE0gbf1pbYvU
 yGXJ0sW/QcsLXUiFuhZgEQ9kT19hYM81sx+BL6sq6wid0YDT22GDLToBdVReDhnpMP1m
 ojZA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=google.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20251104 header.b=bD0+Fdiz
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] idpf: decrease statistics
 refresh interval
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
From: Brian Vazquez via Intel-wired-lan <intel-wired-lan@osuosl.org>
Reply-To: Brian Vazquez <brianvv@google.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Tested-by: Brian Vazquez <brianvv@google.com>

Before patch:

# sar -n DEV 1  | grep eth1
08:09:51         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:09:52         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:09:53         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:09:54         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:09:55         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:09:56         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:09:57         eth1   4225.00   1801.00    736.18   1125.49
0.00      0.00      0.00      0.00
08:09:58         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:09:59         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:10:00         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:10:01         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:10:02         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:10:03         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:10:04         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:10:05         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:10:06         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:10:07         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:10:08         eth1   3788.00   1435.00    628.26    535.24
0.00      0.00      0.00      0.00

After patch (you can now see background traffic reported right away!):

# sar -n DEV 1 | grep eth1
08:08:33         eth1    527.00    443.00    261.74     76.69
0.00      0.00      0.00      0.00
08:08:34         eth1    440.00    423.00    101.89     78.75
0.00      0.00      0.00      0.00
08:08:35         eth1    356.00    353.00     68.68     57.02
0.00      0.00      0.00      0.00
08:08:36         eth1    437.00    462.00    114.18    124.07
0.00      0.00      0.00      0.00
08:08:37         eth1    377.00    383.00     61.40     65.97
0.00      0.00      0.00      0.00
08:08:38         eth1    335.00    337.00     83.08     75.39
0.00      0.00      0.00      0.00
08:08:39         eth1    387.00    392.00     58.95     74.58
0.00      0.00      0.00      0.00
08:08:40         eth1    351.00    371.00     51.39    103.25
0.00      0.00      0.00      0.00
08:08:41         eth1    339.00    338.00     55.38     54.91
0.00      0.00      0.00      0.00
08:08:42         eth1    324.00    328.00     54.15     55.71
0.00      0.00      0.00      0.00


On Wed, Jun 10, 2026 at 8:24=E2=80=AFPM Danny Gonzalez <digonzal@google.com=
> wrote:
>
> The default 10s statistics refresh interval is too slow for real-time
> monitoring and causes network selftests (e.g., uso.py) to fail when
> verifying traffic immediately after transmission.
>
> A 10s delay also causes aliasing in telemetry tools polling at shorter
> intervals (e.g., 5s), leading to inaccurate rate calculations on
> high-throughput NICs.
>
> Decrease the refresh interval to 250ms to ensure fresh stats and fix
> test failures.
>
> Tested: drivers/net/hw:uso.py now passes
> Fixes: a251eee62133 ("idpf: add SRIOV support and other ndo_ops")
> Signed-off-by: Danny Gonzalez <digonzal@google.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/eth=
ernet/intel/idpf/idpf_lib.c
> index cf966fe6c759..e2890d219431 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> @@ -1364,7 +1364,7 @@ void idpf_statistics_task(struct work_struct *work)
>         }
>
>         queue_delayed_work(adapter->stats_wq, &adapter->stats_task,
> -                          msecs_to_jiffies(10000));
> +                          msecs_to_jiffies(250));
>  }
>
>  /**
> --
> 2.54.0.1099.g489fc7bff1-goog
>
