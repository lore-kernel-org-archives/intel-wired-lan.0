Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D00606A31D
	for <intel-wired-lan@archiver.kernel.org>; Sat, 24 Oct 2026 01:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=vZzCem3r;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CdybPBuR
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9D52140A36;
	Sat, 24 Oct 2026 01:25:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QecfCKAm9jGk; Sat, 24 Oct 2026 01:25:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3416440AC0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792805157;
	b=kpwQiB4+j79VRMLxiUph9nUUWBKq4HlI3aMnpYwQftUp7UtnrfcGp1pg68/pkx8VW+g5
	 o0HtKswdQAKsb7zAQpENpV/XTwgFZyIGHffQC8az9WxWzEML1NcnBqwNSw+Y2piOIBb/e
	 YACOSl1RqE6ZseuaS2fXd1bSqq4uEg4h1pNzNf1E1hO1Xw5egrc7OQsJ9/H0iYMQmilX9
	 llZ3V5AvHVYMUixUo36S8TbF1IhhZUBJf4FaFU213y2bO9Ml1MPCpNd5PJ4wicEtTJyw/
	 X1TWA3c7WDtNS2+s+AfpnDZkJt/Oes5F5tZvUyKXpiNt7pFIzbpeFj+x4IRtSWb3jWw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792805157;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=04gsjwLCnz1GZQQoCjip6AU11BBjP5c97UIJiBbCDD0=;
	b=PxfcDd9wuTL3nnLxIKNb/a0codN5iie0jtaLt73gvjJQ3CDyjBTaAEVbeJg8+O5qRL2/
	 3SzkUBx0Vmo8ya2Lzx/jFbVWonKdoIUFVEhydX1wBQCCHJEj2rEyX9QdTNAFSAkhfDQ14
	 wfpOeAs7kttMtQZKfhkQsbt3MfMM14IdTkixrd0qlx6f6oWEEGQC7n+Kk9TbmuFzeAHLz
	 3fsCewFzoMrR1ws4jqeMNW1o3lYX7Z7gu2EAmlJFdJ9JsXT9e44+l8FmMoynnzPDbPIRf
	 weWbOnO9c7XtB1W1kY2xwtdhvx0HdXwHQ3AJc7s/3KS3nvIn0gyluhxr1/JdLauhpiA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792805157;
	bh=04gsjwLCnz1GZQQoCjip6AU11BBjP5c97UIJiBbCDD0=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vZzCem3rBVQ0HMZs+bVwKzxser5OVqXTX39GqKU0BFMU8af4S9RGEbfn62VhMNkKB
	 Bi9/iCF73wmPfRu1UMw4QPcsxbqpY//2u8LKqxDv7oOvIulg/48DHszS2AQ7SqMX7z
	 +tMTUQ6/Sj7CYniEjysY1rvm0w3FNyup4lUetALN8Rqa4RyVjY5cPXpJlvqijBpd+4
	 TYss8wqv89to/JuN6DC4Dr6pWBH9o5K09fsPZlgNQBKMpZ7fvipn1cs+8qNumsyDqh
	 aq4th10/Fg6lOP9Eu8z98k/fbq7punjiyHzHCtsQDHfIxG+Vuu+DkR04QJ4xi+lyjZ
	 L0W9O4WtD/H3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3416440AC0;
	Sat, 24 Oct 2026 01:25:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C49F3B6
 for <intel-wired-lan@lists.osuosl.org>; Sat, 24 Oct 2026 01:25:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 89FED404A1
 for <intel-wired-lan@lists.osuosl.org>; Sat, 24 Oct 2026 01:25:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FYoDFvzdud7G for <intel-wired-lan@lists.osuosl.org>;
 Sat, 24 Oct 2026 01:25:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0444D40068
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792805154;
 b=KtzKVfDprAu3LvMTGPRRm61xM1BJJdcpR1PjO8i1w7W5y8II6WcQKGHIHNH7qgMDechw
 oheeiPlwbZijhb6uEXfeFmkt6kQdx3vnMiiLDCAl6fPgeT8pnEbvah05rlD0VxYComSjF
 I+C2nIIYjAfHcmUWlTKO4duPc+zBIEaMeG5cvuiG/2tldtW5J64P+1CfTfN5kSd1GQ5uF
 9I84MTSE12KCE5i+T8+i9HzxzL0KmfrRqT/M/eW5UKHXpLDePRYCj5jgaUxc2NCTqZEzC
 KslEFlzx0QI/QWzxFDtZoSHkBVwaZ/tMPiz2e/RciRpiXtBNr35en3aF2VfRlOXFz1g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792805154;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=04gsjwLCnz1GZQQoCjip6AU11BBjP5c97UIJiBbCDD0=;
 b=mX6pYhmU2BkLUuFPwgXDGp1LZBgLG+ybkL/NvdcPFXbcB1n+hokLxagXN96FRHS71p2t
 EJVEf2FGS5w6ZyixcJucRbStvh/a4igawpnPO82vG2xLgri88soS5w2SPhr5ZQ1HqPviv
 V63I9V2V0iOd/piDDKU9lI/WvE09EpbnYVOPBpQqtPxMngc0a0MqEY0Ph9/0QHCdtaiYQ
 +GBCgCzcO299HKS6y1XN2ecQavx4cXGYLixZ73e8oR4kQtZ2PG4uTKSelO/1S0K/7HzUv
 0RQvDpuepqv/F05kG55sjNjwDIgZP2oSxawIxWeAjJl0lTBtEG8R2gBggYsrSDjKP/w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CdybPBuR; 
 arc=none smtp.remote-ip=198.175.65.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CdybPBuR
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0444D40068
 for <intel-wired-lan@lists.osuosl.org>; Sat, 24 Oct 2026 01:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792805155; x=1824341155;
 h=from:subject:date:message-id:mime-version:
 content-transfer-encoding:to:cc;
 bh=ATyqcapxCuKXEPZHrJIcMn3cIXEHZvPQs5UQ2JRwqs4=;
 b=CdybPBuRhc/w4lVtxAfY0BTv1+IxOuY+L/+7quP1OLn3jncErQ5L1IEw
 LLrESf2ReDY+XI/J/9UifIgejwBKwn9b65MkmPYrZAbm6LEwI/B5ir98V
 3C3/U3P32v5NuOrAKLIjqdOJNTUc68yGafdvRKw2mE4VG15dWbP8fVvqW
 hz+Vg5SLCKHiNQvYPr6Yb1vR5bjCgvKQVawL2fIvJoo+7UpjGGiUIkIjp
 xUYqc535r4wFAq210XuyTburfjg+T1VokIqncjdWkyE8LVkhfmdnxqLUZ
 VxRzwrXCWIMnE7BidcWiHrj1tycjBmDeTdBe4y/qHclxRluBc5nichFZb Q==;
X-CSE-ConnectionGUID: s2c9Hb6ZQU6ouY2LRfXkOw==
X-CSE-MsgGUID: 6rptDXVwRIe7avjfcn8g6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1579036"
X-IronPort-AV: E=Sophos;i="6.27,175,1787036400"; 
   d="scan'208";a="1579036"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 18:25:53 -0700
X-CSE-ConnectionGUID: MpXiHhLeSZa5A5cvXgx5GQ==
X-CSE-MsgGUID: mAnLuXEaSlSAgBFP3m+tqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,175,1787036400"; 
   d="scan'208";a="3890845"
Received: from orcnseosdtjek.amr.corp.intel.com ([10.166.28.128])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 18:25:52 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH iwl-net 0/2] ice: E825 timer adjustment fixes
Date: Fri, 23 Oct 2026 18:24:28 -0700
Message-Id: <20261023-jk-e825-e830-timecounter-v1-0-e932602f0d16@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QrCMBAEf6XcsweXk0bxV8SHmq56VVNJUhVK/
 92oLwvDMjNTRjJk2jUzJTwt2xgruFVD4dLFM9j6yqSi3okqD1fGVts6a+Fid4RxigWJxQfX9hD
 FxlPVHwkne//Se7LXjSMKHf5Hno4DQvmGaVk+Cdd5+oUAAAA=
X-Change-ID: 20261022-jk-e825-e830-timecounter-06c15de02e76
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Sergey Temerkhanov <sergey.temerkhanov@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.17-dev-67df5
X-Developer-Signature: v=1; a=openpgp-sha256; l=9866;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=ATyqcapxCuKXEPZHrJIcMn3cIXEHZvPQs5UQ2JRwqs4=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqw7nGJJhSacW+YwysRWrlm3MzJwqmTQutMOddP3eHl96
 nU8+uVGRykLgxgXg6yYIouCQ8jK68YTwrTeOMvBzGFlAhnCwMUpABNpCmD47+ot9fJhiTn7hOX7
 AlbueP297kjXq0dqWgLOkV0PQ8K11jD8D3J5qXr4wN8p9R1Van/UNmjfMDb0cX51Iu5jv9Hm3/t
 MWQA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-24.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_NONE,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Recently we've had reports of bad timer adjustment on E825. This series
fixes the issues by replacing direct timer adjustments with a struct
timecounter to maintain the phase in software instead.

To motivate this, the following is an analysis of how the E825 PHY
timestamps function.

    The ice driver maintains PTP clock time in the MAC with a 96-bit
    register. Timestamps are captured in the PHY which only stores 64
    bits, only including the lower 32-bits of nanoseconds. The driver
    performs clock adjustments using a hardware timer command mechanism,
    where the clock adjustment is programmed into shadow registers in
    both the MAC and PHY, and then a timer command is initiated to
    synchronously update the timers.

    Since the PHY only maintains the lower 32 bits of nanoseconds,
    adjustments are also limited such that the maximum atomic adjustment
    is ~2.1 seconds (2^31-1 nanoseconds).

    For large offsets, the driver uses a non-atomic flow where the
    current time is read, an adjustment is applied in software, and then
    written back. This necessarily loses some elapsed time, which
    applications must deal with. For particular servo configurations,
    where the parameters are tuned for a very slow servo, this error can
    take a long time to finish correction.

    On E825, the adjustment in the PHY does not always work reliably.
    The reason for this is subtle, and is a quirk of how the timestamps
    are actually generated. The timestamps for Tx and Rx packets come
    from the PCS timer rather than directly from the PHY timer. The PCS
    timer is derived from internal PHY signaling.

    To keep the PCS timer and PHY timer in sync, every few cycles
    (testing seems to indicate every 8 cycles) the PHY timer is copied
    to the PCS timer. On other cycles, the PCS timer is incremented by a
    value determined from the PCS clock rate.

    Crucially, the copy of the PHY timer is skipped if the current value
    of the PHY timer is lower than the PCS timer (*and* on this cycle
    the regular PCS clock increment is also skipped).

    During normal operation, the PCS timer will tick from its own source
    for 7 ticks then copy the PCS timer. If the PCS timer is slightly
    ahead, then PHY timer update is skipped, and the PCS timer skips an
    update every 8 clock cycles until it is back in alignment with the
    PHY timer.

    Unfortunately, this hardware logic did not take into account manual
    adjustments to the PHY. If the PHY timer is adjusted backwards, (or
    if a forward adjustment causes the PHY timer to overflow), the PHY
    to PCS sync will not occur again until the PCS timer wraps back
    around to zero. In the worst case, an adjustment could land the PHY
    timer to just below the PCS timer just after it wraps around. PHY to
    PCS syncs would stop for ~3.6 seconds.

    During this time, the Tx and Rx timestamps will read from the PCS
    timer. These timestamps will be fed into the timestamp extension
    algorithm which will produce incoherent results, and data will be
    fed into the PTP application servo. During the invalid window,
    faulty timestamps will cause the servo to steer incorrectly, likely
    away from the true target time. After the PCS timer synchronizes
    again, the timestamps will return to normal. However, the servo may
    have steered the clock incorrectly. In default ptp4l configurations,
    direct clock adjustment is only performed once during startup. This
    forces the application to use frequency slewing to correct any
    remaining offset. With slow servo parameters, this can take a *very*
    long time. In some setups, we had reports of taking several minutes
    to nearly an hour before stabilizing, and in some configurations the
    servo was unable to ever recover.

    Note that adjustments work properly on the MAC timer, and indeed on
    the first-layer PHY timer value that the driver can read over the
    sideband queue. Only the PCS timer (which is inaccessible to the
    driver) fails to adjust. This made tracking the precise origin of
    the failure difficult.

Testing shows that pretty much all "negative" adjustments and about half
of the positive adjustments can trigger this failure. It is also
difficult to see without using extremely slow servo parameters. With a
servo tuned for fast reaction, the incorrect timestamps will cause some
difficulty in the first adjustment, but the servo will quickly correct
and recover within a few seconds at most.

I used the following P/I servo parameters in my testing:

    pi_proportional_const 0.60
    pi_integral_const 0.001
    pi_proportional_scale 0.0
    pi_proportional_exponent -0.3
    pi_proportional_norm_max 0.7
    pi_integral_scale 0.0
    pi_integral_exponent 0.4
    pi_integral_norm_max 0.3

In particular, the pi_integral_const will force the servo to be very
slow at reacting.

Even trying to compare the MAC timer with the Tx and Rx timestamps is
not trivial. There is no mechanism to synchronously read the MAC timer
along with a timestamp. Additionally, timestamp extension makes this even
harder to track. The MAC timer is immediately adjusted and the cached PHC
time is updated. Normally timestamps from before the adjustment should
reasonably convert, however if the adjustment is large enough the timestamp
can flip to being detected as "in the past" and in the worst cases the
resulting extended timestamps will have a second sudden jump of -4.2
seconds before the PCS timer adjustment is applied and things settle. All
of this while being fed into a servo trying to steer the clock can make it
difficult to understand what is going on.

With that background out of the way, here's a summary of the patch content:

First, the timestamp extension logic is refactored to store the cached
PHC time value inside the ice_adapter structure under a new ice_phc
structure which will be used to store timecounter data. This change
reduces the number of threads that need to perform timestamp extension
and makes introduction of timecounter simpler as it gives a natural
place for accessing the structure and simplifies modifications to the Rx
hotpath in particular.

Next, the driver is modified to allow use of a timecounter for
representing the time instead of directly adjusting the phase in
hardware. Frequency adjustments continue to be handled in hardware. For
now, only the E825 and E830 devices are switched. The legacy
implementation remains for supporting older installations of E810 and
E822 platform devices. We plan to complete migration in the future, but
felt that immediate conversion would slow down ability to validate that
all older installations will behave correctly. Since the E825 device
timer adjustment logic is completely useless, this can speed up ability
to adopt the fix. Although E830 does not appear to have the same timer
command issue, it was decided to convert both since they are the most
recent devices and undergoing the most testing and active development.

Although I would normally rate conversion to timecounter as a "feature", I
have submitted this series as a fix due to the severity of the failures
encountered on E825.We would prefer to be able to avoid delays and help get
this to critical customers soon.

This series fixes a separate issue from [1] and does not *directly* depend
on it. The fixes in that series are necessary but not sufficient to
completely eliminate PHY timer desync issues on E825.

There are some structural conflicts with the ctrl_pf RCU changes at [2]
which I have tried to integrate, so this won't be a straightforward
cherry-pick to trees without that series.

One final note, the conversion to timecounter supersedes the changes
from [3], and that patch has been removed from more recent versions of
that series. The reset partially helped, but was only applied to the
non-atomic settime interface. In particular, the settime interface was
vulnerable to the same PCS issue, but the PHY soft reset *does* clear
both the PHY and PCS timers back to 0. Performing a reset after the
adjustment will force both timers back to zero and then perform a
forward adjustment that won't trigger the failure condition. However,
attempting to add this reset to *every* timer adjustment comes with
unnecessary delay since the whole process takes a long time especially
with the PHY soft reset. It was ultimately deemed as not a proper fix
suitable for deployment.

Link: [1] https://lore.kernel.org/intel-wired-lan/20260925222824.270640-1-grzegorz.nitka@intel.com/
Link: [2] https://lore.kernel.org/intel-wired-lan/20261013091235.1423979-1-sergey.temerkhanov@intel.com/
Link: [3] https://lore.kernel.org/netdev/20261008215614.1987250-16-anthony.l.nguyen@intel.com/

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Jacob Keller (2):
      ice: store cached PHC time in ice_adapter
      ice: use struct timecounter for E825 and E830

 drivers/net/ethernet/intel/ice/ice_adapter.h |  42 +++
 drivers/net/ethernet/intel/ice/ice_ptp.h     |  12 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h    |   4 +-
 drivers/net/ethernet/intel/ice/ice_adapter.c |  10 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_lib.c     |   2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 381 +++++++++++++++++----------
 7 files changed, 311 insertions(+), 142 deletions(-)
---
base-commit: bfd1885cfb920d10c2739c9f152615ec26e3b045
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
change-id: 20261022-jk-e825-e830-timecounter-06c15de02e76

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>

