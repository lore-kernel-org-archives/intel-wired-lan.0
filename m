From: Wyborny, Carolyn <carolyn.wyborny@intel.com>
Date: Mon, 6 Feb 2017 23:55:37 +0000
Subject: [Intel-wired-lan] [PATCH] net: intel: i40evf: use new
	api	ethtool_{get|set}_link_ksettings
In-Reply-To: <1486248543-14722-1-git-send-email-tremyfr@gmail.com>
References: <1486248543-14722-1-git-send-email-tremyfr@gmail.com>
Message-ID: <9BBC4E0CF881AA4299206E2E1412B62650397D9C@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Philippe Reynes
> Sent: Saturday, February 04, 2017 2:49 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; davem at davemloft.net
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; linux-
> kernel at vger.kernel.org; Philippe Reynes <tremyfr@gmail.com>
> Subject: [Intel-wired-lan] [PATCH] net: intel: i40evf: use new api
> ethtool_{get|set}_link_ksettings
> 
> The ethtool api {get|set}_settings is deprecated.
> We move this driver to new api {get|set}_link_ksettings.
> 
Thanks for the patch Phillippe,

We have an internal patch in process for this functionality.  It should be out very soon.  I thought it was upstream already but it must not be.  I'll find it and get it expedited.

Thanks again,

Carolyn

Carolyn Wyborny 
Linux Development 
Networking Division 
Intel Corporation 



