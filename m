From: Stefano Brivio <sbrivio@redhat.com>
Date: Thu, 17 Aug 2017 03:13:27 +0200
Subject: [Intel-wired-lan] [PATCH] i40e{,
 vf}: Fix out-of-bound cpumask read in IRQ affinity handler
In-Reply-To: <20170817030109.31580d73@elisabeth>
References: <ae9c9586f61e914dc1c6fe2e6ac1fb2bf07283bc.1502792828.git.sbrivio@redhat.com>
 <1502929524.32783.3.camel@intel.com>
 <20170817030109.31580d73@elisabeth>
Message-ID: <20170817031327.16eede3c@elisabeth>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 17 Aug 2017 03:01:09 +0200
Stefano Brivio <sbrivio@redhat.com> wrote:

> Before posting, however, I checked patchwork at:
> 
> 	https://patchwork.ozlabs.org/project/intel-wired-lan/list/
> 
> and also your git tree (listed in MAINTAINERS) at:
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue.git
> 
> but I couldn't find that commit. I also can't find it now. So I suppose
> I'm looking for it in the wrong place. Can you please tell me which
> tree or patchwork I should check before submitting patches for i40e, so
> that I avoid further duplicate submissions next time?

Okay, I just found your e-mail on netdev (I wasn't expecting to see
this queued up for net-next). IMHO, this should be queued for -net (and
-stable) instead (and my previous comments still apply).

--
Stefano
