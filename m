Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3EF606A324
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 10:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=yWUEMYcZ;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dd1Y+lI2
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D95340750;
	Mon,  2 Nov 2026 10:50:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wavCutiGDb7B; Mon,  2 Nov 2026 10:50:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F1B9240730
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793616600;
	b=r1i3W0o6SkGT9hbmbu+v9Blu9Fe66tj8ASRu+VFvxtcuWpB5bbnuNf0XcNuyyEv/J7mA
	 JUuGkhsbvq5NhP6tFPwJ2ibvMz5Aa3hzom7DEsnShiWyy3marApdsFCAcZMXZWW+ih4/1
	 JmXXrhsMCyqO30totJt2Omc1ObUsP/PiIJTQ2YF/kXVjcBqFY3X+Pd7IRXF4fzabQCGuw
	 amvJSiOuISYAXtmQNqttwZfgtxzRPIiFQVTkAp56WichVhNnqrbcwjgP1qfIaP13vlWAf
	 8Q9piYPyinbBLhapTvqy0c9/+lwaX+As5Ukv124iDGiy8k3Q2qZShGFPKqq8Ry2cg4w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793616600;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	b=adx2hPuIu9khnmW3TMO4B6H5rynqEmQSwOTuV8/vTPtEnuVXPh6zqyy0IeROVllVmZvc
	 Pr/dfJYJRoHKrK0ttL+gZUIpjhmQVZU1PEmao7f4aH84r4zMAOuWWjEg+oDkUr/xbIv9s
	 CiRnY67VGD2re/2HEVJigOuFWL03ivIwUIuy+8pLiS/IOr8rnQjk79PEXq2axQzYdFUHT
	 avvf4WSD+B4L1M718iZdAetuK/38cKydJlTl2ITG1uTq7A2I28Rasd19HftdGTIF8HF2W
	 vlSLE6eZwayBdtNgcd0oT7YWZtflhIZ1nsMsJrpUPz0YL+R54InyMETJjkQOpddXZ/w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793616600;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yWUEMYcZxloVhAa/JIdOumhhVsXBioE9Or65OeWAsUndn6KMQQ6V2vNnBwN3o/Ngr
	 Qa9jctPAGd7D8tv7+hUn15XsTwervJMcvlQoJoyA06WL7yLVNin0r/3p7Opa7jx+sq
	 kOc52WZEWOeSRqwKD+CMg+X4qAahdfsauaCyVdM7SGZRm4mTrzy/edALBYWdtl2Wi4
	 LE3oPIjRgxkkVVCZYbKchb1VJDUQOF9oV6bNjukL+QYLgxswxBu1uXQUEvqQdJbqt9
	 5KaUnW1cU0l6zxnQ+MPkT1bYkCznI2EJP4FMUxFKefPPBp6T4T0ShRD2vXlI5klI6Z
	 1Qb8S22ckS/nA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F1B9240730;
	Mon,  2 Nov 2026 10:49:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C2B3362
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 10:49:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1242980D00
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 10:49:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IoPNxqMEg2TZ for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Nov 2026 10:49:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6628280CFA
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793616597;
 b=DRRXF77EAiBXVUISOP8GDyvohE/EhUvcVMgMgk2utglWe6ENQC+HRoiznMbMk5Q5BBsV
 DzSCGFxvKTkjM4fPJgVtd0et2Q8nJET8Da9zNn4m95jzpsSBMlWy7pI3oNGCk2Zi0ek7n
 lEm+YzUdr8T36B7zVtOc8GD8IK5JGtGYNUfwd+KnRz+ydKsXWq9ItjCoQnO3eun9jF/CK
 90XD4qNFOKp4Lzm/qF14VdTsPC1/FAgNOSh03oBxuH/t5b//r6+mj7YTnNScC76gWmfA2
 Cf9pKzRQz/4v/XY8WhMI+nmPCR+a3pgUxiAPEnMTRvU+K4r6wpLMc/Fb4q88F8N1fgg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793616597;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:Auto-Submitted:Content-Type:
 Content-Transfer-Encoding:MIME-Version;
 bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
 b=pmLGW6iAUoAZd7rxyLvL5ulVGnLaPt9AxwytZTn8LXT/BpFQ8krvXj9ndBXUJURWF7Kh
 BhhoVDYv/x+uXev3AFJquoMYpJOwGF7kG/d3PlU9VOfmVJ5hf1nGItDpKaH6XyM8uJPzt
 l/E6SSan6djHVrpMchewWnMDeKYMr+6TSmH3xbVOURhLcfkshG4HCmQuZk56T/QUd8PKM
 ryiH4e51Co2eUCgnV9iTp/9GoPGoLRURWeSGjZnuOABh9Rfx6ZM+K63L1Wxl/PWMu8EsW
 9cwHq/wkIRBKzofyzPoX528zjPxOH/X+wT93Di4V0n346oFjbNdE4MnO6tGrjU1F8MA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=dd1Y+lI2; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=netdev-bot+sinfo@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=dd1Y+lI2
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6628280CFA
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 10:49:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 452AE60EFF;
 Mon,  2 Nov 2026 10:49:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C192C1F000C1;
 Mon,  2 Nov 2026 10:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793616596;
 bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=dd1Y+lI28WyADcO2EB9JuvZE9YqJbSNFoL0yN2T5aVatUMAaTDVZxdX4NWQ6dh7kK
 BeGn7HEgzu5zmyGWrWNH3fHa3Pb4DMCM00PUzA8ABi3wXTjoV4uONZ5A6Dfr8pB8xj
 dCU7ciqzR73w165bgwosHg9zMwrkmguX9dWgMqk+rf789PLiHUR/JrhSyZRT3omg3f
 3xopf1KPTac84IknFxGCUd9oPpgj/tj7Ub8lO0V15yFxFqXBaSao7Z8kwPOhfCtk5z
 ZibVonzUMr6wRmWMPSSd0EBIQl1IrCa/Z3WsAczfXhqbQjNQvrbQ6SunwcD10jL2bo
 ESbAO18ggwPZQ==
From: netdev-bot+sinfo@kernel.org
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, Petr Oros <poros@redhat.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net 0/6] ice: fix DCB lock ordering
Date: Mon, 02 Nov 2026 10:49:55 +0000
Message-ID: <179361659537.3286.125563824218861188@kernel.org>
In-Reply-To: <20261102105346.30739-1-przemyslaw.kitszel@intel.com>
References: <20261102105346.30739-1-przemyslaw.kitszel@intel.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

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
