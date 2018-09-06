From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Thu, 6 Sep 2018 17:16:24 +0000
Subject: [Intel-wired-lan] [PATCH v2 1/2] net: ethernet: i40e: fix build
 error
In-Reply-To: <eab442369533452a9fc138e310aa57b9@HXTBJIDCEMVIW02.hxtcorp.net>
References: <1536114430-21356-1-git-send-email-dongsheng.wang@hxt-semitech.com>
 <02874ECE860811409154E81DA85FBB5884C78D88@ORSMSX115.amr.corp.intel.com>
 <eab442369533452a9fc138e310aa57b9@HXTBJIDCEMVIW02.hxtcorp.net>
Message-ID: <02874ECE860811409154E81DA85FBB5884C7AC01@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Wang, Dongsheng [mailto:dongsheng.wang at hxt-semitech.com]
> Sent: Wednesday, September 05, 2018 8:36 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; sergei.shtylyov at cogentembedded.com
> Cc: davem at davemloft.net; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v2 1/2] net: ethernet: i40e: fix build error
> 
> Yes,  but not only i40e. igb/vf, ixgb/vf also share same code. If we change any of
> them, means we need to broken the whole layout of driver/net/ethernet/intel/ .
> Obviously we can't put header files to $src/include/net. ?|
> 
> Cheers,
> Dongsheng
> 
> 

I'm more worried about how it interacts with modules. For example, we could have i40e and i40evf share some code, but then wouldn't one of them become dependent on the other? i.e. you'd have to load i40e in order to successfully load i40evf? Or you'd have to have some sort of common glue module which you load first, and then load i40e and i40evf after? This also creates some interactions with out-of-tree modules which make it difficult. It would be nice if we could share the code in some way that still resulted in allowing each module to be separate...

And yes, I igb/vf and ixgbe/vf and i40e/vf all share some code though i40e is the most shared, comparatively. It's not an easy undertaking, which is why it's not been done before. For fm10k, the same driver handles both the PF and VF, but I know that users weren't happy about having the driver change a lot when fixing/changing the PF, and thus thinking they might need to update their VF too much.

Thanks,
Jake
