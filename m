From: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
Date: Wed, 1 Jul 2020 01:37:39 +0000
Subject: [Intel-wired-lan] [PATCH] igb: reinit_locked() should be called
 with rtnl_lock
In-Reply-To: <CA+HUmGjHQPUh1frfy5E28Om9WTVr0W+UQVDsm99beC_mbTeMog@mail.gmail.com>
References: <20200629211801.C3D7095C0900@us180.sjc.aristanetworks.com>
 <20200629171612.49efbdaa@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CA+HUmGjHQPUh1frfy5E28Om9WTVr0W+UQVDsm99beC_mbTeMog@mail.gmail.com>
Message-ID: <61CC2BC414934749BD9F5BF3D5D940449874358A@ORSMSX112.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Francesco Ruggeri <fruggeri@arista.com>
> Sent: Monday, June 29, 2020 21:51
> To: Jakub Kicinski <kuba@kernel.org>
> Cc: open list <linux-kernel@vger.kernel.org>; netdev
> <netdev@vger.kernel.org>; intel-wired-lan at lists.osuosl.org; David Miller
> <davem@davemloft.net>; Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Subject: Re: [PATCH] igb: reinit_locked() should be called with rtnl_lock
> 
> > Would you mind adding a fixes tag here? Probably:
> >
> > Fixes: 9d5c824399de ("igb: PCI-Express 82575 Gigabit Ethernet driver")
> 
> That seems to be the commit that introduced the driver in 2.6.25.
> I am not familiar with the history of the driver to tell if this was a day 1
> problem or if it became an issue later.
> 
> >
> > And as a matter of fact it looks like e1000e and e1000 have the same
> > bug :/ Would you mind checking all Intel driver producing matches for
> > all the affected ones?
> 
> Do you mean identify all Intel drivers that may have the same issue?
> 

Do not worry about the other Intel drivers, I have our developers looking at each of our drivers for the locking issue.

@David Miller - I am picking up this patch
