Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D4BC83F2C
	for <intel-wired-lan@archiver.kernel.org>; Tue,  5 Sep 2023 15:14:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 52F8D41824;
	Tue,  5 Sep 2023 15:14:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 52F8D41824
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1693926864;
	bh=cweQQN56IzO0Fanuy8wPM1z6EesgNZBikJzMn9eLjVQ=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=LqbzIREQbrvwdOzQ5UpMCTm4j2t/Ymyw3Eitdy38UFXvAEN+qU8RQBuOwCqJKu6D5
	 sn9fbxvX09HiAguj0RNccYgPBTKrvp9YnDkCQSJu2KPstAkCKlkuCsy+jTdsteehxE
	 5vyy65X2+EufuflcOMsXC3tpjfzJaoU5t9HEimuOQ0Wf5wcIS1cCaigXaM1IcfHstc
	 K5tMwI3MYJOJ8zoTf4dEMiUPyvOnrZ+gsVS/kS5o3o862WZ/hKF1Qc16J4GBqaRbJx
	 6rmOocFR3WgEu1FHANdDzruXBgmV2neZ207+23GPANDzQjXbvAflQXJE7f3rBx+nB6
	 NnZO6cRiBaDzQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WTA_bdDqt98G; Tue,  5 Sep 2023 15:14:23 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C3B641827;
	Tue,  5 Sep 2023 15:14:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0C3B641827
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 17FFB1BF364
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 Sep 2023 04:03:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E150260B32
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 Sep 2023 04:03:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E150260B32
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tgDZ_vQ7ciWE for <intel-wired-lan@lists.osuosl.org>;
 Tue,  5 Sep 2023 04:03:37 +0000 (UTC)
X-Greylist: delayed 480 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 05 Sep 2023 04:03:37 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 85B2760773
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 85B2760773
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 Sep 2023 04:03:37 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 03017B8109E;
 Tue,  5 Sep 2023 03:55:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69398C433C8;
 Tue,  5 Sep 2023 03:55:32 +0000 (UTC)
Date: Mon, 04 Sep 2023 20:55:29 -0700
From: Kees Cook <kees@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org
User-Agent: K-9 Mail for Android
In-Reply-To: <20230904123107.116381-2-przemyslaw.kitszel@intel.com>
References: <20230904123107.116381-1-przemyslaw.kitszel@intel.com>
 <20230904123107.116381-2-przemyslaw.kitszel@intel.com>
Message-ID: <7AB970A3-883F-49A4-BBCD-23E2CD1E869C@kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 05 Sep 2023 15:14:17 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1693886132;
 bh=lLVUEbQlWPdqOrLlxxs6XsBseI0buyWLU4uLdO6rjow=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=LDgmblXsH4okbJodYbvPlniFpqN89lQ3SXmqVe4Sou8FN9xKjLrSFjBDGFuoSKyI6
 IOEaFE6uB3BhB3gwDFcvOp2WwwJYxrwWvCHIdNjvOx7zBWzGPyYtV4INNUW38Ows7m
 gdTtPqDbO6Sb0BX1eZ3TXqki38Amve8jq4HFpqlV/UTCPVXncFTYPZ20TDabvSqpsF
 48tGKtjsEjME/ZI+OxkaSBZIcyOqutkOyg6WqtgrOWemq2jkQ24TMbAG8oauYDMGig
 E5TSxZlBEuHqoJvBReR0SjCNZCPvLClNBKhGR3+lZdFSteZT9RYnle6kdk+uV05pDL
 2Ro3z09UFvMFw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=LDgmblXs
Subject: Re: [Intel-wired-lan] [RFC net-next v4 1/7] overflow: add
 DEFINE_FLEX() for on-stack allocs
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: Kees Cook <keescook@chromium.org>, Steven Zou <steven.zou@intel.com>,
 Anthony Nguyen <anthony.l.nguyen@intel.com>,
 David Laight <David.Laight@ACULAB.COM>, intel-wired-lan@lists.osuosl.org,
 linux-hardening@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On September 4, 2023 5:31:01 AM PDT, Przemek Kitszel <przemyslaw.kitszel@intel.com> wrote:
> [...]
>+/**
>+ * _DEFINE_FLEX() - helper macro for DEFINE_FLEX() family.
>+ * Enables caller macro to pass (different) initializer.
>+ *
>+ * @type: structure type name, including "struct" keyword.
>+ * @name: Name for a variable to define.
>+ * @member: Name of the array member.
>+ * @count: Number of elements in the array; must be compile-time const.
>+ * @initializer: initializer expression (could be empty for no init).
>+ */
>+#define _DEFINE_FLEX(type, name, member, count, initializer)			\
>+	_Static_assert(__builtin_constant_p(count),				\
>+		       "onstack flex array members require compile-time const count"); \
>+	union {									\
>+		u8 bytes[struct_size_t(type, member, count)];			\
>+		type obj;							\
>+	} name##_u initializer;							\
>+	type *name = (type *)&name##_u

Yeah, I like this! This will make it easy to add __counted_by initializers when we have the need in the future.



-- 
Kees Cook
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
