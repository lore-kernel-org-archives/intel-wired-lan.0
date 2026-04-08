Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8137A1073CB4
	for <intel-wired-lan@archiver.kernel.org>; Wed,  8 Apr 2026 13:11:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 10CBE40EB7;
	Wed,  8 Apr 2026 13:11:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l3_53ZrbfCu3; Wed,  8 Apr 2026 13:11:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 53B8240E9E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775653911;
	bh=UGQ67r6USA+flx1FAnz9wCvHAQQncWp3Wxkm5JwYX7c=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d3HORI5zrFpTKoipxBhTHT8cKGF30barQfiQHSwRTecjkMaP9gt9+xgqyhwsTyXRj
	 eDJxWNHV5ZdjqKWgJ+d9Kh8qg8aMA0h+TqRgor/Ml1yz4r1CWEx1Q+7KROaymwO7Tp
	 9zHoGQAPpOf18lHIhTwF9gR6hZw/KseJsPjNnj6NdYIduWdwgybgyxQkMfulOBuirI
	 2xIRtfCnBIA2jNQdnA+5iF562x6MuHixaylukYuZaarLBplzfhHNyjXZLfxgjMjMXs
	 2ZRVfP6LpK/Qxl94iD08HAFdkl6C6OAn4rpzw5XC7e3fsGrQ0lW/d9uCi2KpBsjJf0
	 hPcuQjaxOBXmA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 53B8240E9E;
	Wed,  8 Apr 2026 13:11:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C94E82C7
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Apr 2026 13:11:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AE2A440E9E
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Apr 2026 13:11:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7fHxNSzJz5LH for <intel-wired-lan@lists.osuosl.org>;
 Wed,  8 Apr 2026 13:11:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=49.212.198.91;
 helo=www2881.sakura.ne.jp; envelope-from=kohei@enjuk.jp; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1B38740E98
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1B38740E98
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1B38740E98
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Apr 2026 13:11:47 +0000 (UTC)
Received: from x1 (13.3.31.150.dy.iij4u.or.jp [150.31.3.13])
 (authenticated bits=0)
 by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 638DBRAt012252
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 8 Apr 2026 22:11:29 +0900 (JST) (envelope-from kohei@enjuk.jp)
Date: Wed, 8 Apr 2026 22:11:27 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
 Simon Horman <horms@kernel.org>
Message-ID: <adZRkBXUJKZqAiS9@x1>
References: <20260408083644.1621317-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260408083644.1621317-1-aleksandr.loktionov@intel.com>
X-Mailman-Original-DKIM-Signature: a=rsa-sha256;
 bh=UGQ67r6USA+flx1FAnz9wCvHAQQncWp3Wxkm5JwYX7c=; 
 c=relaxed/relaxed; d=enjuk.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20251215; t=1775653889; v=1;
 b=MFBfXvo1t7b8sFwFAmdphOrfgZfVVvxSCb+4NfRpPw0uUdD9B8mhHefPp4bk36LQ
 AWDyvUSSa1o5RAQA4IMCxMKdpnMHgZlm0Q3x8gEmJGQ+qbF04Pkgjz6wxm7jZOiC
 NgF6847RmsRRT3YIJyBHjChsErS+tRaJv5XLX3lq4IMXwp6SyRO8N/H/0ajSZTR1
 /prnGoiPyajVlHdg1nlgFnmxpLA9BSe/d6mccoDBNC66d+FzvqImqpMW9a+rhYt4
 kFGlxlYBgHPzSY+KFmBpdbpH2QJFOZTneUZltkjDGD1ehDaVpySreYPd7r99pv4o
 1C10Biq3nEmCQljEtIGWzA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=enjuk.jp
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=enjuk.jp header.i=@enjuk.jp header.a=rsa-sha256
 header.s=rs20251215 header.b=MFBfXvo1
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] e1000e: use
 ktime_get_real_ns() in e1000e_systim_reset()
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

On 04/08 10:36, Aleksandr Loktionov wrote:
> Replace ktime_to_ns(ktime_get_real()) with the direct equivalent
> ktime_get_real_ns() in e1000e_systim_reset().  Using the combined helper
> avoids the unnecessary intermediate ktime_t variable and makes the
> intent clearer.

FYI, e1000e_xtal_tgp_workaround(), introduced in a recent commit, has
the same pattern as well, though that commit only exists in Tony's tree.

Also, igc has the same pattern in igc_ptp_reset(). It may be worth
sending a follow-up patch for that as well?
