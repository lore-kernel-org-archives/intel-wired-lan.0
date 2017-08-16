From: Stefano Brivio <sbrivio@redhat.com>
Date: Wed, 16 Aug 2017 11:52:33 +0200
Subject: [Intel-wired-lan] [PATCH] net/i40e: use cpumask_copy() for
	assigning cpumask
In-Reply-To: <20170812160946.2278-1-jgross@suse.com>
References: <20170812160946.2278-1-jgross@suse.com>
Message-ID: <20170816115233.6cc33078@elisabeth>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Juergen,

On Sat, 12 Aug 2017 18:09:46 +0200
Juergen Gross <jgross@suse.com> wrote:

> Using direct assignment for a cpumask is wrong, cpumask_copy() should
> be used instead.

Perhaps a Fixes: tag might be helpful here, such as:

	Fixes: 96db776a3682 ("i40e/i40evf: fix interrupt affinity bug")

as I reported in my other (late) patch:

	http://marc.info/?l=linux-netdev&m=150279303222066&w=2

> Cc: stable at vger.kernel.org

and maybe also an indication about which versions this applies to, such as

Cc: stable at vger.kernel.org # 4.10+

In general, feel free to copy from my commit message.

These comments also apply to:

	[PATCH] net/i40evf: use cpumask_copy() for assigning cpumask

Thanks,


--
Stefano
