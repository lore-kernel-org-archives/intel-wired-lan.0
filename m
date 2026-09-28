Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC42CA5FA5
	for <intel-wired-lan@archiver.kernel.org>; Mon, 28 Sep 2026 15:13:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A6B6A40706;
	Mon, 28 Sep 2026 15:13:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jBUID5DjQTWN; Mon, 28 Sep 2026 15:13:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 19D774064F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608423;
	b=QXBzJjlFPF6j6oqPgkFuajImSVQsblEJdQhWioK+lDTIPsAPFFPjUI7l0eHQE/zY+D0F
	 4+rw3kF/L4JR4KLsbKIJ069ZUQ7LbQpBgHKmdou9vw1+QhBbFCCk7yePyLFLYShb45BS4
	 V1zRF4O2pV0PaYLSacnkIqQjJhUPncoEngGBcBpUV/Tg8upcYW2vwH+QN9Oxf9gjVCqRf
	 U3qI/REKhVNfAk9svhcbAeUHncIiZGNliJ/gqUdnuc6AIfo5WzeDBNHUIKUln77kqES+b
	 3b6obm2AWjyZptr23ysS/GBFqPIDCL2pi3CI2pTU55a76L+tcHo6ia8DjDh0xpFQv8A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608423;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	b=CzwvGxuLsVu3iwHktma0MMkesSfgeyupNTEW+RqJWFavUtkTHXUW7vbLbIBXeHbM6P11
	 EONWhZIJzzVe2kNoM4WOkUl4d+vaKysyVzQslI2EDf5L6M7Oubb3xU6wCEm9igpRwSRWy
	 Gj7BnF6M5s4x+kVbh+mA7MJTXQW9vK5njCHhy3a6HqwZi9F9eB+jf8wIr3s1MEKgnGY74
	 zg4ZUXdkVj5QMLmN12KfU4HYjBXzJT9b2Izc71U4YCxj6BtK1sfCqdIuLWAe9tcXXWIni
	 mRHWBprFLKtQeETUfH5ElAFO1B4NT6Cc4eqkXofZs2tcC3690Mt0q6BL3f2F2/WJUng==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PmyQ60dA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790608423;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P6Bg4k6L0NYjIAitfRyXGw596Gtgx7dJMfLN+oJ2VHXyqNLw6wd/QI10ssKml/K/d
	 /UHgb18zaCU4QKMbY8oXdj5eDA51lRaWoRPfqb0dw8L0blym5lIs4G7DyhmDVEYoIQ
	 I3JGAhzs4y12lH0nACB3Yg/albuTZSvXbqpQCipHXU1zkr/dyLdXdLA9j4QWn/eFlN
	 b/KTIJjc4hdlpWRGDrw5kaxXw70EW2Cf3yARV+c/cZ4Irj5txfnp9it7WJ3XflPQ1h
	 3tpcG0zcv9b7BbETAOY2eus9CJ0d9GnlaBFdPiYlX0BePu4bWv+l/ztxyFWQwVQLhr
	 cfgJbbJVVXeyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19D774064F;
	Mon, 28 Sep 2026 15:13:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id EA5922B6
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 12:39:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D04C440635
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 12:39:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k0W3s2mMfCaZ for <intel-wired-lan@lists.osuosl.org>;
 Mon, 28 Sep 2026 12:39:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D47D9405DF
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790599188;
 b=gMz5n0GPpcW/nFXdyltXBGA1w7v9HEybAHLqUouoQWloj7I61ISLf6HGycL0x8ixkE8M
 OY4QKhfNrPXru39wY5RhRylTPj+yx4c0nVxm0xM5SEuDCjB3aVjPs9LyCNjyxcFhX3ZLc
 U8eusWRY2UmCg0fmYZD8YBdrMUurj+CFvxKb2o3LoDMv5QfqRwFFd9T0w4JJhc4Lji6vE
 WsBp9ai6rxWLKodOEUQMi3qfWREHN4/1duHDeYGg12J7bE3A2/ujrp8Ex2Y7Jf+DeJZa1
 dzN75LPqPzJwy5dxXL5tI9O2Zg1ktvSEc8+/0AZ+cqU0JhlmmCb+rR7Y07LDQxJSjSg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790599188;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:Auto-Submitted:Content-Type:
 Content-Transfer-Encoding:MIME-Version;
 bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
 b=ZmTl6UtJZ14Ro0QiHCuQC7bSgxjqThJBDVc97WOyYwOvZTCLnwgc/42MVquHkEr8lC5f
 wtFevAixNeQl9vzbsSiof00OV5AmwbP4B9boxucr88ErWaZk2LvLOXrKoWt+j3HTb/IdM
 0XmwMVRwTrA8FIzJQUDDX8BUJerDEEvS0FQ94LZeM/8FYTj1ujbxugOYAyH0vFvR8zK6F
 oTBXLm9zpUWE73zZSCN7ubmwXne7Jg+r5tkutIt5X0HTnQEzyvlCj5DnDop4jVwUDgUZy
 QfZYTt/efeCkXWs9uMcO69g6hYobv9XqG5zZTSQB85AaVt1wUZer5tAd4n7ddZ4uFuA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=PmyQ60dA; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=netdev-bot+sinfo@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=PmyQ60dA
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D47D9405DF
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 12:39:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BCBB24130B;
 Mon, 28 Sep 2026 12:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0AAE1F000FF;
 Mon, 28 Sep 2026 12:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790599186;
 bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=PmyQ60dAkt/uD6wyBgDRM3UFCZTVBM3auopW0Vp6w82r2+mmj8AAcRkDe6Y96e/8m
 eZ/jw6skaHjL6fpi5c2clwFEM7B6OBaeAE7CKT1nH/YRE6or8vgIaE5KxUBHZoEOGt
 cmWbNwz+wXfvVyXkY1UUYdLjBejJZ8DQ5XKWhBj1L9AYRhFTuUd6hKTbW6ftQM0Nbr
 3Edu6LYGs3v5a8LJjOwU8BpiuIf7IKLbrqU0bQLx7ZleDB/XE1oLaR/n2hbkanuKH7
 zwi1Q3bV1oW1Udhrc3tpCRMIFBdK0aMKQLRi+Qh7+A3eCyxN7+P9UxNT4Mh5IzGz9h
 ukzKRYdQsqzYQ==
From: netdev-bot+sinfo@kernel.org
To: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com, stable@vger.kernel.org
Subject: Re: [PATCH net v5] net: e1000: fix warning in iounmap on probe failure
Date: Mon, 28 Sep 2026 12:39:45 +0000
Message-ID: <179059918543.31693.4938540014506455007@kernel.org>
In-Reply-To: <20260928123814.2605-1-nsvatoslav515@gmail.com>
References: <20260928123814.2605-1-nsvatoslav515@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 28 Sep 2026 15:13:41 +0000
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

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
