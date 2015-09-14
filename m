From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 14 Sep 2015 13:55:06 +0200
Subject: [Intel-wired-lan] [PATCH 00/39] drop null test before destroy
	functions
In-Reply-To: <1442146532-9100-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1442146532-9100-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <55F6B59A.4040104@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> Recent commits to kernel/git/torvalds/linux.git have made the following
> functions able to tolerate NULL arguments:
>
> kmem_cache_destroy (commit 3942d29918522)
> mempool_destroy (commit 4e3ca3e033d1)
> dma_pool_destroy (commit 44d7175da6ea)

How do you think about to extend an other SmPL script?

Related topic:
scripts/coccinelle/free: Delete NULL test before freeing functions
https://systeme.lip6.fr/pipermail/cocci/2015-May/001960.html
https://www.mail-archive.com/cocci at systeme.lip6.fr/msg01855.html


> If these changes are OK, I will address the remainder later.

Would anybody like to reuse my general SmPL approach for similar source
code clean-up?

Regards,
Markus
