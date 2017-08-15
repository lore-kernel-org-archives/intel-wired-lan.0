From: Stefano Brivio <sbrivio@redhat.com>
Date: Tue, 15 Aug 2017 12:33:48 +0200
Subject: [Intel-wired-lan] [PATCH] i40e{,
 vf}: Fix out-of-bound cpumask read in IRQ affinity handler
In-Reply-To: <ae9c9586f61e914dc1c6fe2e6ac1fb2bf07283bc.1502792828.git.sbrivio@redhat.com>
References: <ae9c9586f61e914dc1c6fe2e6ac1fb2bf07283bc.1502792828.git.sbrivio@redhat.com>
Message-ID: <20170815123348.711b1680@elisabeth>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 15 Aug 2017 12:30:14 +0200
Stefano Brivio <sbrivio@redhat.com> wrote:

> The cpumask used in i40e{,vf}_irq_affinity_notify() is allocated
> by irq_affinity_notify() with alloc_cpumask_var(), which doesn't
> allocate NR_CPUS bits, but only nr_cpumask_bits bits. If we just
> dereference it, we'll read way more than what is allocated, e.g.
> 1024 bytes vs. 8 bytes allocated on x86_64 machine with 24 CPUs.

Sorry, just two minutes after sending this I noticed Juergen submitted
the same fixes on Saturday:

From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org, netdev at vger.kernel.org,         intel-wired-lan at lists.osuosl.org
Cc: jeffrey.t.kirsher at intel.com, Juergen Gross <jgross@suse.com>,         stable at vger.kernel.org
Subject: [PATCH] net/i40e: use cpumask_copy() for assigning cpumask
Date: Sat, 12 Aug 2017 18:09:46 +0200

Please discard.

--
Stefano
