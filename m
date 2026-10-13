Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E881CC6B12
	for <intel-wired-lan@archiver.kernel.org>; Tue, 13 Oct 2026 17:40:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 08CB740574;
	Tue, 13 Oct 2026 17:40:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WEx3aRG0DpGD; Tue, 13 Oct 2026 17:40:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 167CE40585
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791913208;
	b=iGY99haAjQ6XkOAGnPoR4syshdz885GanFGARqVw4iS/z92f7K/S6Ai5eRAv32SQWCUW
	 TxHhMPSpUldvFUtVXw8gaEH7xtLxt537Iiz7PJcFrf/y0LNs1Y8Os9ug2QvHqBrBQcSFd
	 LW9Kw5L7AZYeumazeQ6AY5MU+jZAB7cQwk5qULuzs9zDXJKW+FdVPW/EcR8uIzCC6cvRF
	 trI2sT6S4a6Bn6IzIEm9b4Uo+6oEbzWaos+L5bmZuno6cvQXZ8WinYoGvs327zhkU3wLo
	 VdtNzsEAurd0oLF8/4YfK7eWDud8iYX/mbGtSV5KSrW5pE1i/eAExAzUjKGrG0SKt+A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791913208;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:Received:DKIM-Signature:DKIM-Signature:X-DKIM2-Info:
	 DKIM2-Signature:X-DKIM2-Info:Message-Instance:X-ME-Sender:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zWrT6526wv35zHlukYifavAueFw34rBDLgGAnTBDzxg=;
	b=r2OljR81ZDqQPedcg4or0cAzYKJxbPBfHezU5SCu23Rj9CauZdoi2M3Dyhg2NU8vr2sk
	 SW5MxU37WShsqbfpL+Yq9C+ZMMRCYGf49K7YfBD5T4UkHeThlulTodKKx2fC7TBmp5bT4
	 tSP17JrSpGjHBmtDgzq/pHaH2FoygbecqotgIZ9VfBXmzsQUF1ef/8anksdNYp3kUXfdY
	 U+eZqOz/4gvOH/rqVcchkMoXzAKEGy45/CaBq7Vo/LpcEMe9nIU9ViJ1u1H9HFBYk96Jk
	 N5okfQg11NC6Dc7hU3J1fzRQzziqIY9cvX1Nna9yhw9IWztTogTLVO8H5TBk9pXnynw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791913208;
	bh=zWrT6526wv35zHlukYifavAueFw34rBDLgGAnTBDzxg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UUKxQTh2lEAevgnhoq6yilvYLeMtLmx7m8zve26ForhAWIf+cPZkbj8gdMDaWB/9S
	 FJes1ym6Y7zJI54X1sTOj3yRIFr59BIssNxdfNatKOUKl/vVlUtiBgXcS3XVTHD/Gv
	 sssOuWp1d1lZU9SRqvqA6SaFBToLKfkzKxU4JmreIfbe68imT042K9Y50uTbO3fHpj
	 NTNw1jHHZn3YU5zH43LM/V82nUGjb9GkYkiU1S6jMts/XXoEVCROgsjWwJQwEe+8VM
	 LBYShpg2oCvkbDFhVa9QyIEESdXI6yrPJN2k4zuoJWrDbijI4PKywYoltT9MZkopH1
	 KuX8DO2AL/hUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 167CE40585;
	Tue, 13 Oct 2026 17:40:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E5C7B75
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 17:40:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E3293606F2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 17:40:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ov9Nc1-zWDG9 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 13 Oct 2026 17:40:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 320866060E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791913204;
 b=cvKNwu+r5Bg3KeqBnoBhjJCkUKb/GzYFIdW86apIORzrOjMgMurpPQLOvp8WAUsZO4pY
 5qBeYOd9SklZQIuHWG+0LJwUBWvHFXGS4uoe0/D8tMrvbPOwNsMjuSJkwM33wx2Zjhyv4
 +4E0ZNaHsp3dunDdXrUbHJQFrc6qzfVp/JIrCzZI4I4jcXXgdcmiTD+a11NL3oRkhiigt
 AKg9w9JZsNLvwvEpbfRI1bivekWLMOCbaH4JBHbdm0QkegkbTR9BlX7eroH2eufNIE5tF
 Lo8rEjAAol63mazj6w5PUD41CoohAAbQIqMprq3VarC5S0PeBbS2rz9/VECazZLALCQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791913204;
 h=X-Greylist:Received-SPF:Received:Received:DKIM-Signature:
 DKIM-Signature:X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:
 Message-Instance:X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
 Received:X-Mailer:MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:
 In-Reply-To:References:Subject:Content-Type:
 Content-Transfer-Encoding;
 bh=zWrT6526wv35zHlukYifavAueFw34rBDLgGAnTBDzxg=;
 b=D+pGdhz/mJvH+iJaOkxqXxYsMLXnTmz5k/inMQbbIozbNJzBqQiJL5Fz5oUjnQ1XSpZ6
 krzP+nsIAqEQ0KAqt5zmb+Ldm71gkmQX+XtXJAiI3bb3p0lEmV3TMVVZ4cxUpbbyVfL/L
 ApH1A4ULmfDqu5HGxvk033DEiLDgyC8aUxEDFfvmR1MZoFnJTB2agQvUj/xFJX8y9Xq5T
 SeqN4l9ojQWyxry7ytolslEmeutp9piOBM1CTsxRy7le+OL8ol6WV3OrHYBQqfGKbVgaz
 gnRFVfdtxjE8Qie07XtGrKXlGt1KDbMLgpjD1NWmR2ueA/qKdXE82Wg6kbwEs+hRhaQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=squebb.ca;
 dkim=pass header.d=squebb.ca header.i=@squebb.ca header.a=rsa-sha256
 header.s=fm3 header.b=Y22fhyCX; 
 dkim=pass header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm2 header.b=Ent4EQAf; 
 arc=none smtp.remote-ip=103.168.172.158
X-Greylist: delayed 361 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 13 Oct 2026 17:40:04 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=squebb.ca header.i=@squebb.ca
 header.a=rsa-sha256 header.s=fm3 header.b=Y22fhyCX; 
 dkim=pass (2048-bit key,
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm2 header.b=Ent4EQAf
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=103.168.172.158;
 helo=fhigh-a7-smtp.messagingengine.com; envelope-from=mpearson@squebb.ca;
 receiver=<UNKNOWN> 
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 320866060E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 17:40:02 +0000 (UTC)
Received: from stl-compute-04.internal (stl-compute-04.internal [10.204.2.64])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 5D51D1400156
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 13:34:01 -0400 (EDT)
Received: from stl-imap-02 ([10.204.2.93])
 by stl-compute-04.internal (MEProxy); Tue, 13 Oct 2026 13:34:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1791912840;
 x=1791999240; bh=zWrT6526wv35zHlukYifavAueFw34rBDLgGAnTBDzxg=; b=
 Y22fhyCXazF/hy3sMgeO9skGmeK+0C58c8ys8JMg6nh+p1WXDipqzICQL95bHVgd
 DefEQo5DudqSXCxwt9baF1nkwWx3HravO8cxT9bI68juApl5qyi3eqbCBUyPmiMO
 TTZElo38f967rR6uGrb/vbQcgbcY3isfVCMCb8bn71sLFuS2ZoUy2/+eq6umJ4EA
 ntjPwNkhU3U+w/5pDkBMpgxPk/dHtbnIcsO0rO0wa0q3SJXws55lzquCXBumIEzf
 fjj8+WrID56aFB4nyKTta+KKjSzx0xqcQAT/jyuLWJhu+XCG4XF/DPPy9dgzyIs4
 YQBmwce0W14jn20/h5Eauw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791912840; x=
 1791999240; bh=zWrT6526wv35zHlukYifavAueFw34rBDLgGAnTBDzxg=; b=E
 nt4EQAfNdMxeIemi3u/VZEdn4VCmpIDg1FF+Wttp8JhNG0roZoAKGOqppWVTJPD+
 vd4aP6R49YrEQCricChgZ6DNxUovxOUE28qpf6vTwotcYFJ0KJn48MpXuZHViFQM
 bwpQZ7eJS1WonlqG5+Ap97ickup3GftaILCOxi8YkX0rnQY6fiIWaB3lp2qcWDPf
 YU2dadoBtqe/dKGzf3dPNASZGtsd7Join7VB5SWa2NdigbX9l9BG1JmW1W57WTmv
 HfuXALut8t3w5xR16ADqNW6Uk7qcOYgFl6Adta9W14qUjoBDUHdsS7S/r6STQ9a+
 GhVjd0ftni8aIsGTHTbrQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=squebb.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791912840; d=squebb.ca;
 mf=PG1wZWFyc29uQHNxdWViYi5jYT4=;
 rt=PGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnPg==;
 s=fm3:rsa-sha256:bvRwlYhibYVuZvJtkPnlThH3gSBfhp9LVrTxE6M7n63DvZd
 ScNPE7LzDNFYJEKDI95OmzuLVjlFvAJCjL7eRlrLUvfCAn/XAP6m8SRoEs1RFZB9
 2NtIcHLoLlSWjazwNSSM6GNSEizIk5I4T4TAhZ6HF/CvBNDcV19Tk8Q46G6yilPL
 Yhr9OuxtVahC7ypbegDl67SXr5byS+m1Zzp2YU2p/0G6Vu0ePnzOwogshxYblFFd
 2FnjTOgZL1FRwSBVuTBD40684dSvYOr5yHoSowU0WYekMxyVtDqJ0qWOHLvDVwpt
 1GvHcdPaiA8lwIKtOSCdIGTqxkbZHNHwKZg+mXQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:smyL4wS3CDOSnFu7HZryjOmmKHmvf3PLbaQMgi3Fw6o=:y6ysyt5X8W8XsyVqRgzWTeuAmYV3XM3MQEp2rH3KE1k=;
X-ME-Sender: <xms:h2vOagwIrYT0mtKs6TnF252pzNu2bgpc56IhoE3c9k9xQMKLsD8-8g>
 <xme:h2vOavEIhqHlXvCYBxSbjelyk8uC-Vmer9bTgHz2PAePb_wMVMKXmOFrHpaAlZpzV
 Vzpx4CBlkPQ7lCqcqsiWeH5n66KcOpWm-zIHt18RppidZMCJk57wA>
X-ME-Proxy-Cause: dmFkZTGhYXN3gpdWdt6ff1Nqh0Aka73Cqro5oTU9gAa+n8NggNF/K04+5NW5qdVaDd3NS+
 2RaZd9YIHFLQeGOP6KdceTC5PHaNtlLjGfO66LfMIVXNMt1xmB4fN+vR+7m/WAqTPOYfvQ
 o2pTAP81VscueLNMGI7lyQyNks/eCKx+l177NBXTI4Ned+yI2PtXn7JhIOMyGJh0jdJJij
 Ff70+1afxLD6jw5DuxW6hOXpe6I1KrzPNhr1NIi2nn2J4d5xe5qB7N7iMfqZ2MROBgwXS0
 +jQn/shhceug9e0fZgvzYDSLw5xB55E15nrX2nqfQrtTC5ExiWmOIPmPIZmsyZIfrMjKon
 ZTmARireY8V6jV9Kn4/0Q/LAiaFtmw36KvE5VXpPlmTZrk/F3VAzH2TSAcUXNUl65bGRMf
 9vwo0GcL+fg3PVBsHWkCwYtN8nuy4/BA7/yR224tV4F6PDbklaxJ/IcHuabjAkvy8jU4s0
 gzbhchg5fQxeWhKY1fSqeO9rYLzmz/B4CsM4sZASFUOnCJZUu2PLBA6f8QMQBF4rQZRXJu
 1iKT0XWR5/OfSckXH4cGPkF+VSTSCxljnVVo3ajy7JcIOTgzPGcj0GQd79V1lk8eighx2v
 tLNLqjDkzsnAA4Qlqy7Bry7QIwrkNLid1xryH3QBcvwTARZwznD/VjNKy1tQ
X-ME-Proxy: <xmx:iGvOasyrl0U4bigP_ZqUd1iVf5yXdTfyKnnob0tpk-Lt_n436y8Tyg>
 <xmx:iGvOarOMLb3LcnVLObUpiR4y-sAGWbR0IKkV3VPxPvbBXDJzW-MXRg>
 <xmx:iGvOatUw2nXU6ewCS6HTobwxJ_Epge2Kqnbvxou6XRekApq25kd80Q>
 <xmx:iGvOav0s8O5HFqgKe-HTjSQEMo8lumbSj_pK5S5CaObzS0qPYAALtg>
 <xmx:iGvOagDuHITyOBnKKNor9sIeeXEpciGBn8BLobsC3TEmDsJ1IuIIO04Z>
Feedback-ID: ic2b14614:Fastmail
Received: by mailuser.stl.internal (Postfix, from userid 501)
 id ABEC52C0007C; Tue, 13 Oct 2026 13:33:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AyVy3zSkWrTo
Date: Tue, 13 Oct 2026 13:33:38 -0400
From: "Mark Pearson" <mpearson@squebb.ca>
To: "Paul Menzel" <pmenzel@molgen.mpg.de>,
 "Dima Ruinskiy" <dima.ruinskiy@intel.com>
Cc: anthony.l.nguyen@intel.com, "Christoph Groth" <christoph@grothesque.org>, 
 ghrafn@proton.me, intel-wired-lan@lists.osuosl.org
Message-Id: <5fbfadf9-fb27-429d-82d5-ac8dc87e9886@app.fastmail.com>
In-Reply-To: <eea9e99d-ef6f-4bd6-abb2-54fb9c53a7de@molgen.mpg.de>
References: <20261012214113.69770-1-dima.ruinskiy@intel.com>
 <eea9e99d-ef6f-4bd6-abb2-54fb9c53a7de@molgen.mpg.de>
Subject: Re: [PATCH iwl-net] e1000e: Add additional systems to disable K1 list
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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



On Tue, Oct 13, 2026, at 1:16 AM, Paul Menzel wrote:
> [Cc: +Mark Pearson for Lenovo to maybe fix firmware to support K1]
>
> Dear Dima,
>
>
> Thank you for your patch.
>
> Am 12.10.26 um 23:41 schrieb Dima Ruinskiy:
>> On some Lenovo laptops performance issues were reported with K1 enabl=
ed.
>
> I=E2=80=99d make one commit per device, so the device can be mentioned=
 in the=20
> summary/title, and it can be reverted more easily. It also helps=20
> reverting commits in case of problems for just one device. Should you=20
> stay with one commit, please at least mention the devices in the commi=
t=20
> message.
>
> Commit messages should also be self-contained, so describing the=20
> performance issue would be great. Having the firmware versions directl=
y=20
> in the commit message would also help me.
>
>> Add them to the list of systems where K1 is disabled by default.
>>=20
>> Cc: stable@vger.kernel.org
>> Fixes: 578294b8b60d ("e1000e: Reconfigure PLL clock gate timeout and =
re-enable K1 on Meteor Lake")
>> Reported-by: Christoph Groth <christoph@grothesque.org>
>> Link: https://lore.kernel.org/intel-wired-lan/87v77ial45.fsf@grothesq=
ue.org/
>> Reported-by: ghrafn <ghrafn@proton.me>
>> Link: https://lore.kernel.org/intel-wired-lan/_kB6DUeC6oOmJnK0FobVVJH=
ADewewO3wzeFw_GrempgMu6s5CUwHpkT16Bwn8tXRq0k_CN4b2NY6API37M6mVciEpH6DKbT=
qK7f13KMpmgI=3D@proton.me/
>> Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
>> ---
>>   drivers/net/ethernet/intel/e1000e/netdev.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>=20
>> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net=
/ethernet/intel/e1000e/netdev.c
>> index 834a5b8883df..35c729368684 100644
>> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
>> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
>> @@ -74,6 +74,20 @@ static const struct dmi_system_id disable_k1_list[=
] =3D {
>>   			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad P14s Gen 5"),
>>   		},
>>   	},
>> +	{
>> +		.ident =3D "Lenovo ThinkPad P14s Gen 6",
>> +		.matches =3D {
>> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> +			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad P14s Gen 6"),
>> +		},
>> +	},
>> +	{
>> +		.ident =3D "Lenovo ThinkPad T14 Gen 6",
>> +		.matches =3D {
>> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> +			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T14 Gen 6"),
>> +		},
>> +	},
>>   	{}
>>   };
>
> The diff looks good. With my comments addressed, please feel free to a=
dd:
>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>
>
> Kind regards,
>
> Paul
>
>
> PS: As far as I can see, it=E2=80=99s not logged, when K1 is disabled =
by the=20
> quirk list.

Using the Product version is probably not a good idea as you'll be picki=
ng up both ARL and LNL versions of the T14 G6. Do you know if the LNL's =
are impacted? I'll see if I can reproduce on my system here.

I would recommend using the BOARD_NAME codes, as is done in thinkpad_acp=
i: https://github.com/torvalds/linux/blob/24a19b953e2a3d0ea5a8c4951a0ab8=
f32720c907/drivers/platform/x86/lenovo/thinkpad_acpi.c#L4244-L4245
It's a bit more annoying as there are two codes per platform - but it's =
safer in scope (these codes are fixed and won't change):
T14 G6 ARL: 21QC and 21QH
P14s G6 ARL: 21QT and 21QU
T14 G6 LNL: 21QD and 21QG

I've created internal ticket LO-4707 to get input from the FW team on if=
 we can do a FW fix for this. I'm not sure how this passed our certifica=
tion and QA with this issue. If you don't mind holding off a week or two=
 while we investigate the patch might not be needed.

Mark



