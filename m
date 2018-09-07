From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Fri, 7 Sep 2018 21:42:49 +0000
Subject: [Intel-wired-lan] [PATCH v3 1/2] net: ethernet: i40e: fix build
 error
In-Reply-To: <f2b0bdfcb53c461191e71603257874ac@HXTBJIDCEMVIW02.hxtcorp.net>
References: <1536319175-3660-1-git-send-email-dongsheng.wang@hxt-semitech.com>
 <1536319175-3660-2-git-send-email-dongsheng.wang@hxt-semitech.com>
 <f2b0bdfcb53c461191e71603257874ac@HXTBJIDCEMVIW02.hxtcorp.net>
Message-ID: <02874ECE860811409154E81DA85FBB5884C7B944@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Wang, Dongsheng [mailto:dongsheng.wang at hxt-semitech.com]
> Sent: Friday, September 07, 2018 5:41 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>;
> sergei.shtylyov at cogentembedded.com
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>; davem at davemloft.net; intel-
> wired-lan at lists.osuosl.org; netdev at vger.kernel.org; linux-
> kernel at vger.kernel.org; Wyborny, Carolyn <carolyn.wyborny@intel.com>
> Subject: Re: [PATCH v3 1/2] net: ethernet: i40e: fix build error
> 
> Hello all,
> 
> The i40e_ethtool_stats.h is just included by i40e/i40e_ethtool.c. So the
> static doesn't make any affect. And Carolyn's team is working rebuild
> i40e and i40evf.
> 
> Cheers,
> Dongsheng

Dave wanted a fix sent to netdev by end of day today. I think the best immediate solution is to just migrate that code back into the i40e_ethtool.c and i40evf_ethtool.c files, rather than only the single function.

I'm going to send that patch to netdev now, since Jeff Kirsher is on vacation.

Thanks,
Jake
