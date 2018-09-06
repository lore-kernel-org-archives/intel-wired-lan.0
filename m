From: Wyborny, Carolyn <carolyn.wyborny@intel.com>
Date: Thu, 6 Sep 2018 18:15:18 +0000
Subject: [Intel-wired-lan] [PATCH v2 1/2] net: ethernet: i40e: fix build
 error
In-Reply-To: <20180906180316.GB26997@lunn.ch>
References: <1536114430-21356-1-git-send-email-dongsheng.wang@hxt-semitech.com>
 <02874ECE860811409154E81DA85FBB5884C78D88@ORSMSX115.amr.corp.intel.com>
 <eab442369533452a9fc138e310aa57b9@HXTBJIDCEMVIW02.hxtcorp.net>
 <02874ECE860811409154E81DA85FBB5884C7AC01@ORSMSX115.amr.corp.intel.com>
 <20180906180316.GB26997@lunn.ch>
Message-ID: <9BBC4E0CF881AA4299206E2E1412B6267C602D24@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: netdev-owner at vger.kernel.org [mailto:netdev-
> owner at vger.kernel.org] On Behalf Of Andrew Lunn
> Sent: Thursday, September 06, 2018 11:03 AM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: Wang, Dongsheng <dongsheng.wang@hxt-semitech.com>; Kirsher,
> Jeffrey T <jeffrey.t.kirsher@intel.com>;
> sergei.shtylyov at cogentembedded.com; davem at davemloft.net; intel-
> wired-lan at lists.osuosl.org; netdev at vger.kernel.org; linux-
> kernel at vger.kernel.org
> Subject: Re: [PATCH v2 1/2] net: ethernet: i40e: fix build error
> 
[..]
> You have a few options here.
> 
> 1) A library module, containing shared code. Use EXPORT_SYMBOL_GPL()
> in the library module, and the kernel runtime linker will link the
> calls into the library. Also, modprobe will ensure the library module
> is loaded first, before the driver module.
> 
> 2) Build time sharing of code. Place the shared code into a .o file,
> and link it to both modules.
> 
> There is nothing particularly difficult here, this all done lots of
> times within the kernel. Just look around and see how others do it.

Thanks Andrew,

Yes, I agree and we do have a team working on doing this.

Carolyn

Carolyn Wyborny 
Linux Development 
Networking Division 
Intel Corporation 


