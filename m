Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CDBC88E4D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 11 Sep 2026 16:52:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DFEEC6066B;
	Fri, 11 Sep 2026 16:52:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wOd0xOcNexq9; Fri, 11 Sep 2026 16:52:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 57B4760625
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789145561;
	b=MA9D28TTVmajBP/18nCG6AtvT6GmallIRkwYYqzHyZ+XwhGDqeVayAiiMGF393mMPQcP
	 CtRB91Axo6Wd1Bkr4DRZ9rEBADZ0/N2MDtYyIQXq34XXTRRZU6nBHvNffcX+6MkUtokbd
	 skcQ8INdbXoS2RgPaHUtzgyKgRQ/1my5gv4GwqirCDBNWW0c/qBX2HuHLNU7US4Pfm53/
	 ZqyqpgllV54WHW29Vz2GthjCd8Sopg3vdc6P75SQRsD2QCE5HKO62PTQXSgDO7JYsl1g+
	 WlVgYK8mx8TJA5SXuuUO1EXO5gj9vkRtudh3ByvJf+VQ2QOJFOGMM6oxP0UO4V0aYEA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789145561;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LmtaT5OOtng/3d/XlKtuOLYcMnkl4rQaCZQ5X7edgM8=;
	b=k59jRMv1+aaRQd6Gr1xigjadNwmyJyT3fixAcOHUZ+r1c7pUdYtUPeadCpnYQPTfciEw
	 i+h5rFVs90dZ/mMVMvz/1EfBU6cuMHeJA620E8em5M+6At21yjAi4dH6vG9dP3WEx7/6H
	 NBO336HJ+H52uQRZC0U9vaBzHnA0nV5lIcruS+Mh54OLmYmQ8yuKsbu94gwJNSEfgtP8M
	 yUld30NY1RlNHSbIMPuUk+HVIOiAXW3coEvLQ7yUSenrxLdJiBoEJoxS+rD6rd3KsC7QJ
	 D7bTkM6UYSR84OkcJkr0g0iRcwe/yUFXH+R1LBMsKTZfWaTJqOqME+zHIw4USv3AZgA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789145561;
	bh=LmtaT5OOtng/3d/XlKtuOLYcMnkl4rQaCZQ5X7edgM8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1oDuwwWuMi1A5ww7tWkMiGW6ZYUq9FkozZIJcbmYpwcDkVSAP+uNgYyWf1dxX+G5R
	 mgxqj4mIahM+a04lOqqjcx0NeFOtEKI7mX26a47EFdYJ7aCkNyUDqVqdIEwBGzsM0S
	 hP5tVKikZw2dyyXn8npyGyuu901rt5XJCbCj1puVYLu9/I66gam7/AlQfGGoUSEEKZ
	 5E2p7WDDtih5PVuuQpHCcwsa+yTUJbJlRz9I7hzmUkeDKOG/CQpxa+cZYEPFVIJWC8
	 rFx+I4MpZpkLpqVhbYNbSumbjGcvumZi8d5M0gePb422dNisOjZRAR8wzJeO68JJMN
	 3UJzgdErRP6TA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 57B4760625;
	Fri, 11 Sep 2026 16:52:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 86E703AF
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 16:52:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 795D940177
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 16:52:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cN8_INVK6aIh for <intel-wired-lan@lists.osuosl.org>;
 Fri, 11 Sep 2026 16:52:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org DF32B4006B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789145560;
 b=XJffrFCyTTwsjp67mrcCtk8Ssho1RekzyeqYR4uZk5IbVd/BoABJfaGxKEWoxfb1Brjt
 pKCS1lbbdtvZsNVCd7YvO+47fHhBKhLbJ3X3OiZLaxAUSagtArN+eF67xlKfgrUzLYcBC
 pi+ok2RaNvwxFVIlG4Q+3OIKMNt92GEjaaPS5MNz9m4OUTu6ydarl9DgX2U2OKUiFG11A
 PRYP9x4nimHWNc6FFuu5U4bbZ9FdzW7mgM6M5CHWWbOWWprqoy9rmrb9FDjbFHwTMadBr
 HowsyLmYp5DLPyZdZN84IQoGeLPDy6zipoiHny4hIvUNer+xyOlRjs48xR/UMCLNH0w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789145560;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=LmtaT5OOtng/3d/XlKtuOLYcMnkl4rQaCZQ5X7edgM8=;
 b=JCnRejpMnLHMy9iHUvu9OCDTeTm/WkeTPi4eknMRfWsnlWkpNuCDSxh1npfz8T6k1yMz
 Bxaiqd6MRB4mtEDRrtTFA/z/Zi4/Nhp/zVrNYb+K/aWT+337uFTWltqAFHOndbBGVdcgT
 L81aHIsTIarRej9pv7SaSfveFvzM9et7kHIlQUfsCU+Sgvb6hPUOJOB5CdC0xbHYcK92U
 zfgey1uuczxKt666aHEFIWNv1hue3FhMrom/ueSa/2j4eBvt8295/DFKI+aWVxp731s/4
 irRag3lXYPrHWFCz7kbDNl7TzVgDkPn9fdfsEFlaXNTJB1waAWBT76y3qaISg5bieaw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=IIw+JG4B; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=IIw+JG4B
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DF32B4006B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 16:52:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 13DD043616;
 Fri, 11 Sep 2026 16:52:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995D41F000FF;
 Fri, 11 Sep 2026 16:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789145559;
 bh=LmtaT5OOtng/3d/XlKtuOLYcMnkl4rQaCZQ5X7edgM8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=IIw+JG4BsBbhc/SfEGh186GxlKIOGfioXRx5wnjCYSnHwNKm17QaiUkBWtWjlDYWb
 VN4cxVtNIiMQ04kZfRoiwTOyH/TF8h0hDsXOH/6GFQM/7N4NOhnfXfeMA0FwydENWb
 dCPybsqMFaqUEqavNqQVXcc2InZyfRx5SGuMMfXJPk40Iy6PQWbBflGDvtq0fedAWY
 +w6DpEIWvaphnblusMmk67UoiKRypR0xrXZ0SNMnumBVrUMp85ihfAxtwQvdKewPpq
 6X+VVN7x/4rZ4wloAFujenheS2bINnePBGZ4dniy36L+KvBe8uCCYIv2kbJqmXEQSq
 BDElkEcdy4Whw==
Date: Fri, 11 Sep 2026 09:52:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Michal Schmidt
 <mschmidt@redhat.com>, intel-wired-lan@lists.osuosl.org,
 edumazet@google.com, horms@kernel.org, pabeni@redhat.com,
 davem@davemloft.net
Subject: Re: [PATCH net v3 0/5] ice: fix stats array overflow via proper
 realloc
Message-ID: <20260911095237.243ab37b@kernel.org>
In-Reply-To: <20260911113848.44086-1-przemyslaw.kitszel@intel.com>
References: <20260911113848.44086-1-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 11 Sep 2026 13:26:15 +0200 Przemek Kitszel wrote:
> Fix OOB access to the stats arrays.

I'm going to assume you mean this for iwl-net, there are already 15
patches from Tony in the queue for net.
