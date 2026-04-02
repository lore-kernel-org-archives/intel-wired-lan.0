Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED9C1D6AB10
	for <intel-wired-lan@archiver.kernel.org>; Thu,  2 Apr 2026 23:48:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 91CE860810;
	Thu,  2 Apr 2026 23:48:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0J5TLG-sw9Ir; Thu,  2 Apr 2026 23:48:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C3F6C60741
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775173718;
	bh=n/tN/fSucZVzXItT34ZMLPR7+Vd6FzvpbCN0/zznqP4=;
	h=From:To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qrwzhUQxdKDqSryA2yundE6YfX2sK/VWvH9Lyt40YTLa6z/9RNgPUzxa1IIO+g+dg
	 rbTlikKTnuHorbfXsycpHlZxsZFzLPAF5pKnvzxOga7Pc82fxVbRqyJiSR+Q4tXDC8
	 CXgA+wazaznG/KImBzXPadMAD7FMnFep4SCj9BQG7rRm348plOkkxtsmEImhMBJjw6
	 NUUeSBcALC4B0+n8u3R12uFFl3jRSmCgz2gIQtJmOevUqpygsqbNYhsaV+H0W4zcsn
	 ofwN0QqRbv58riznND55XM/c0QAnG+o5jaG20hIpGhhx7XlFb9+fKSr6DfdkTbpsyx
	 DkVV2NBxNdUQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C3F6C60741;
	Thu,  2 Apr 2026 23:48:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7268D2A2
 for <intel-wired-lan@lists.osuosl.org>; Thu,  2 Apr 2026 23:48:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 585DD400F2
 for <intel-wired-lan@lists.osuosl.org>; Thu,  2 Apr 2026 23:48:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F_KvgNWOA7Cv for <intel-wired-lan@lists.osuosl.org>;
 Thu,  2 Apr 2026 23:48:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.20;
 helo=mgamail.intel.com; envelope-from=vinicius.gomes@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org AE8024002D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AE8024002D
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AE8024002D
 for <intel-wired-lan@lists.osuosl.org>; Thu,  2 Apr 2026 23:48:36 +0000 (UTC)
X-CSE-ConnectionGUID: MHq78LihTmO0f8jbTCDRJA==
X-CSE-MsgGUID: UylCuEY2QvqQbP7sK6Nd4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="75961996"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; d="scan'208";a="75961996"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 16:48:36 -0700
X-CSE-ConnectionGUID: tjSrim2+TJqzeTDkrUgoWA==
X-CSE-MsgGUID: TiOtLPiUTV+8RW4wpIPixQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; d="scan'208";a="227361270"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1)
 ([10.88.27.144])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 16:48:36 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Bob Van Valzah <bob@vanvalzah.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, julianstj@fb.com, jeff@jeffgeerling.com, Lasse
 Johnsen <lasse@timebeat.app>, Ian Gough <ian@timebeat.app>
In-Reply-To: <CDC20B85-E83B-4AC9-9261-24B3D967DCA6@vanvalzah.com>
References: <D1C3B3DF-960F-40C7-BBD7-994359F0C8AD@vanvalzah.com>
 <65977d5b-16eb-418c-995e-6a918f67707a@linux.dev>
 <B22CCB1A-15FE-4233-9F47-7FE522C8D6FF@VanValzah.Com>
 <CAD61B95-35BF-4BAC-AC26-6AC043DE6FC1@vanvalzah.com>
 <CDC20B85-E83B-4AC9-9261-24B3D967DCA6@vanvalzah.com>
Date: Thu, 02 Apr 2026 16:48:35 -0700
Message-ID: <874ilsyld8.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775173717; x=1806709717;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=y95f5QlYUMwAz4Mebn4afYMRuQzmkG7xApZVnf6syFs=;
 b=GSq0ahLNpfMbvubdL55KmhPPGhc405RU53Vrqn8nQmu9t6kSCVn7xROx
 GoSNcBuBs+dJaoA3G4AyHKEeteHJnDVJ248WJweLZUQKMPZzUsOW7HnZF
 WPII6Qkaoaux5DIRPmiu8RunmgjfoDf5U2rhYBJGPuDBNVxFRA2rTwYre
 5RyOujX1u5cQmk6Sc/oNWiU4UCglIt7ClfRN984lURQ3Jc7xURuIw5dPT
 Neg5XrIh83tDRV0ZzMNqkv5YIg0+7n8O947sFqmhcmoNUYdxTaaHBvOL+
 mz3q4ATrig2+lOnZQRqkXggaq0JejI+cj8Ijx5HLZOIN04MtYb3LpfQjM
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=GSq0ahLN
Subject: Re: [Intel-wired-lan] [PATCH] igc: fix Tx timestamp timeout caused
 by unlocked TIMINCA write in adj fine]
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

Hi,

Bob Van Valzah <bob@vanvalzah.com> writes:

> Vadim,
>
> Thanks for the feedback on our first patch. We've spent more time in
> the lab studying the igc TX timestamp behavior under stress. We
> understand the failure modes much better now.
>
> You were right that ptp_tx_lock was the wrong lock =E2=80=94 it guards th=
e TX
> queue, not the timing registers. You suggested tmreg_lock instead. We
> tested tmreg_lock alone (v2) and found it doesn't fix the bug: it appears
> that the race is between the software TIMINCA write and the hardware=E2=
=80=99s
> asynchronous TX timestamp capture pipeline, not between two software thre=
ads.
> tmreg_lock serializes software register accesses but can't prevent the ha=
rdware
> from reading TIMINCA at the instant software writes it.
>
> Our v3 patch (attached) takes tmreg_lock as you suggested, and
> additionally disables TX timestamping in hardware via TSYNCTXCTL around
> the TIMINCA write. This prevents the hardware from starting new
> timestamp captures during the rate change:
>
>     spin_lock_irqsave(&igc->tmreg_lock, flags);
>     txctl =3D rd32(IGC_TSYNCTXCTL);
>     wr32(IGC_TSYNCTXCTL, txctl & ~IGC_TSYNCTXCTL_ENABLED);
>     wr32(IGC_TIMINCA, inca);
>     wr32(IGC_TSYNCTXCTL, txctl);
>     spin_unlock_irqrestore(&igc->tmreg_lock, flags);
>

I sent, a couple of days ago, the link to your report to our hardware
folks, waiting for them to take a look.

I think that this workaround, even if incomplete, will be interesting to
them as well. Again, thanks for the detailed report.


Cheers,
--=20
Vinicius
