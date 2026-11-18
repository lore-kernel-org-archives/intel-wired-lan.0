Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715C860A3829
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 16:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=7QSfF2Fh;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dNGY9Zb6
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4AD596065C;
	Wed, 18 Nov 2026 16:52:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ig1hKLGuwuD6; Wed, 18 Nov 2026 16:52:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 67B3960664
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795020721;
	b=HORYBUlhuzw1twoVXSfjEVLTkWsXraLjNYZCDH8QsJ7qKo64y6EsemsYDA6hALTqUVeb
	 KAEBAFmiVvfLk283qGfyOZiERn6qEJlmpsyKtHtgg8mMHdBwVI7D2IYXpJiM1hDg3b3N7
	 M9gYdNRWvaXa4kULbAPByBC7pMeB5MXgo5cstUHDEgJ+GQH9O5YfZXOny1LSkUwi32nfz
	 +WbBCnPjmj72UrJCtlG44nTFYgoxWFXlFdOXOJwikuT67PJMd1TcA/iD7CmJjl3DxoFcr
	 ZHn9INdwv4CafFNyKjOYCPAXAxhHc5uyEtkbN9uMm1HXKxEGaICTpJBIba20Dzs2JiA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795020721;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=yR8EsdwRJ94dTXlG1jcNwLlabOTTGINVW/3cUR3Sxvo=;
	b=BbpOKXBQlUZT7IwzdCo6N+cU9UrYkQ5PiKDQuAGzzWj3lv3/w7ypvLe84msVado7Ov+7
	 ud7iPWZvLxaeAkHM+P21MeJxMlMB9SZkSiAbGzn6rQBhc29Nds70NRTtlfKo55hx9g1+o
	 GcKz8RRZ9ucBvTeDksa9P7APnhu017fiY8cnXBNYx5C+o0fWNYq7KmxT925QN8J287zVD
	 mQtlND/Sg9Jq9er8tdwYoC/SVHygQU1XdJstz5Cwwzyw4YE/HhfrojCa10iVHuRvaYjyN
	 V8pYWC1f11HDe1YZKPvqZWk+OQSkRgT3m2JtDNXyiKzxjZNMEkeCjeSFLpbe1y0I+cw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dNGY9Zb6;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795020721;
	bh=yR8EsdwRJ94dTXlG1jcNwLlabOTTGINVW/3cUR3Sxvo=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=7QSfF2FhFte72n2sk2hZyUPNsL0R//6ZIpAr1LtLE4Aqz/j0E/xy0NwHbMecOl4Ag
	 Jf93Rn6NjQRlWmSWb5vWc48edGq77M7RO8UgGc9ryaTS1EGG9BH5+FN3+YcAnaUOa5
	 Fh1nDg7IgbIP6UJrq7lAvmCMJTvW14jCo1nPSSwHKRNS7vV4AbUfb+UznwvQ40E98c
	 FJirDMrUtRH9NJPL1RSBcSJEoWlICRqEJuOSHNC4wvRuJTf4RYLZ6Xt01PiVeXCLiQ
	 pe02e0rXOqj6Ek92QyFM4Uam5f3H+slxKwtfyl089crGGBEWv2iovojOuflRSzZBCg
	 wtpRmIQZQET5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 67B3960664;
	Wed, 18 Nov 2026 16:52:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B75A13C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 16:52:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F11B360664
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 16:51:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4l5aCoDpPQl9 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 16:51:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E82236065C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=dNGY9Zb6
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E82236065C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 16:51:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 998E062D0D;
 Wed, 18 Nov 2026 16:51:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BF81F000C5;
 Wed, 18 Nov 2026 16:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795020716;
 bh=yR8EsdwRJ94dTXlG1jcNwLlabOTTGINVW/3cUR3Sxvo=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=dNGY9Zb6W73JMFMMfakRFJVy4Kh3cX9gApYfTvQzk4RfKGJ9Hap0o3eR9bMHBZ3LU
 YwK1FAHLv4cOxdRwLEFmgfZEzKPgsZzSTfGVdntaqguGIFlb+Vhd/TCHgmZvbiXag+
 Pa0PY/wSD0fL2LwqiiI4jxo8tuoQ4uwpESrlTmrL4jMFqZtYwuEc9WTweH0OawWgO0
 JXiwCJQW9jU1vTxt0J1yaFVwMYR+Q3lm3bmm4FHeVp8uClq1cSF5/kiBvdfni5lu03
 tf/o3Y/Xpt8pO2XsItTB6TzWuASBlUSaWCvd1NgfIIbXQFfcQKatC8KcX8C1/38qhN
 hjs24jfVQ0qfQ==
Message-ID: <sashiko-outbox-221568@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-net 2/2] e1000e: remove K1 workaround from Nova Lake
To: "Dima Ruinskiy" <dima.ruinskiy@intel.com>, intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261118163447.1117617-3-dima.ruinskiy@intel.com>
References: <20261118163447.1117617-1-dima.ruinskiy@intel.com>
 <20261118163447.1117617-3-dima.ruinskiy@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:51:55 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] e1000e: inaccurate Fixes tag and commit attribution for K1
  workaround
--

commit 5c9c29651f27bff328cda7813a58dbb82ff6d70b
Author: Dima Ruinskiy <dima.ruinskiy@intel.com>

> e1000e: remove K1 workaround from Nova Lake
>
> Commit 3c7bf5af2196 ("e1000e: Introduce private flag to disable K1")
> implemented a workaround for packet loss issues when the K1 low-power link
> state is enabled on the integrated LAN on several generations of platform=
s,
> between Meteor Lake and Panther Lake. On Nova Lake platforms, it is not
> needed, and may cause noticeable performance degradations.
>
> Now that board_pch_nvp and e1000_pch_nvp are distinct types, add another
> MAC type check in e1000_reconfigure_k1_params() so that it never applies
> to MAC types before Meteor Lake or after Panther Lake.
>
> Tested on an I219-V29 (8086:57ba), K1 enabled, 1 Gb/s link. For each test,
> first line is the result without the patch, second line is with the patch.
>
>   iperf3 TCP receive, 20 s runs:
>       16-50 Mbps, 72-208 rx_crc_errors per run
>       949 Mbps, 0 rx_crc_errors (5 of 5 runs)
>   UDP 120 Mbps for 120 s, 2 runs:
>       0.55-0.67 % lost, 1855-2651 rx_crc_errors
>       0 % lost, 0 rx_crc_errors
>   HTTPS download of a 4.3 GB and a 3.5 GB file:
>       5.6 and 10.3 MB/s
>       74 and 59 MB/s
>
> Fixes: 3c7bf5af2196 ("e1000e: Introduce private flag to disable K1")
> Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
> Co-developed-by: Michael Edri <michael.edri@intel.com>
> Signed-off-by: Michael Edri <michael.edri@intel.com>

[Severity: Low]
Should the commit description and Fixes tag reference efaaf344bc29 ("e1000e:
change k1 configuration on MTP and later platforms") instead of 3c7bf5af2196
("e1000e: Introduce private flag to disable K1")?

In e1000_reconfigure_k1_params(), the early return for hw->mac.type >
e1000_pch_ptp still honors FLAG2_DISABLE_K1 (added in 3c7bf5af2196 ("e1000e:
Introduce private flag to disable K1")), while skipping the FEXTNVM12 and
I217_PHY_TIMEOUTS_REG K1 parameter workaround introduced by efaaf344bc29
("e1000e: change k1 configuration on MTP and later platforms").

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118163447.1117=
617-1-dima.ruinskiy@intel.com?part=3D2
