Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF06C3A5A7
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Dec 2022 16:28:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4396761108;
	Thu,  8 Dec 2022 16:28:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4396761108
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1670516914;
	bh=gQQTSUtvzKxcXSYm7uqfGN1vAnjMTG8WOMXsX5cMKms=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=F4tPKwo5rh9+O3VTdZWRQalmOfLdDevtXdN4lwx5TNoXluy1V2B89vsqiXq45v7R/
	 N+J8Ni2kMNmKAZdAQtUSK07L7XMyuBGrmRA+7R67Yu5hM9rmkq+X8sLS9w5EDHtFCu
	 DFyZOcwFegIE66g/JMEEnMDHruKWLpbDhXVjPR8LSFj/n//HL9Y9KXRUgGV05MkduQ
	 JoWQwVrBMBupfVVbJ4LrLXPEKDVSB++kpilKS+5mgGzVCF4NwKPGRUOdurp0HgLxmV
	 roatUBFjhI/2xz8GvBwCq8sei2yNTPU2vph6AoAjGmOQNsAu3Kw9YAqJ2q90dVtllC
	 0pgn1O2qoROyQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vc65Xj4PEJXA; Thu,  8 Dec 2022 16:28:33 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6AFD461141;
	Thu,  8 Dec 2022 16:28:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6AFD461141
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 644EC1BF313
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Dec 2022 12:52:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3ECE260B16
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Dec 2022 12:52:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3ECE260B16
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x9NNiXrGXG1x for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Dec 2022 12:52:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0E51B605AE
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0E51B605AE
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Dec 2022 12:52:25 +0000 (UTC)
Received: from localhost.localdomain (unknown [124.16.138.125])
 by APP-05 (Coremail) with SMTP id zQCowABXr+z73ZFjRwTKBQ--.40875S2;
 Thu, 08 Dec 2022 20:52:11 +0800 (CST)
From: Jiasheng Jiang <jiasheng@iscas.ac.cn>
To: jiri@resnulli.us
Date: Thu,  8 Dec 2022 20:52:00 +0800
Message-Id: <20221208125200.13263-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CM-TRANSID: zQCowABXr+z73ZFjRwTKBQ--.40875S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYf7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
 6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
 kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8I
 cVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2js
 IEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE
 5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeV
 CFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l
 FIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2xSY4AK67AK6ryUMxAIw28IcxkI7VAKI48JMxC20s
 026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
 JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
 v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
 j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
 W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjsjjDUUUUU==
X-Originating-IP: [124.16.138.125]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Mailman-Approved-At: Thu, 08 Dec 2022 16:28:28 +0000
Subject: Re: [Intel-wired-lan] [PATCH net v2] ice: Add check for kzalloc
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
Cc: leon@kernel.org, intel-wired-lan@lists.osuosl.org,
 Jiasheng Jiang <jiasheng@iscas.ac.cn>, jesse.brandeburg@intel.com,
 linux-kernel@vger.kernel.org, edumazet@google.com, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Dec 08, 2022 at 07:17:59PM +0800, Leon Romanovsky wrote:
>>>> +err_out:
>>>> +	for (j = 0; j < i; j++) {
>>> 
>>> You don't need an extra variable, "while(i--)" will do the trick.
>>
>>No, the right range is [0, i - 1], but the "while(i--)" is [1, i].
> 
> Are you sure??

Yes, you are right.
I will submit a v3 to add this change.

Thanks,
Jiang

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
