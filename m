From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Fri, 24 Jul 2020 18:43:56 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: add support for PTP external
 synchronization clock
In-Reply-To: <MN2PR11MB3565063DFB45A14ED9C8452EF3770@MN2PR11MB3565.namprd11.prod.outlook.com>
References: <20200716122107.13703-1-piotr.kwapulinski@intel.com>
 <1ad46857df3e932b2e28256a62f7ad32ae03da23.camel@intel.com>
 <MN2PR11MB3565063DFB45A14ED9C8452EF3770@MN2PR11MB3565.namprd11.prod.outlook.com>
Message-ID: <7ac0ad76dc62435842368f6628b1c37a14463ab5.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2020-07-24 at 15:56 +0000, Kwapulinski, Piotr wrote:
> > From: Nguyen, Anthony L <anthony.l.nguyen@intel.com> 
> > Sent: Saturday, July 18, 2020 1:21 AM
> > To: intel-wired-lan at lists.osuosl.org; Kwapulinski, Piotr <
> > piotr.kwapulinski at intel.com>
> > Subject: Re: [Intel-wired-lan] [PATCH] i40e: add support for PTP
> > external synchronization clock
> > > On Thu, 2020-07-16 at 14:21 +0200, Piotr Kwapulinski wrote:
> > > Add support for external synchronization clock via GPIOs.
> > > 1PPS signals are handled via the dedicated 3 GPIOs: SDP3_2,
> > > SDP3_3 and GPIO_4.
> > > Previously it was not possible to use the external PTP
> > > synchronization 
> > > clock.
> > > 
> > > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > > Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com
> > > >
> > > Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> > 
> > This doesn't apply, can you update to one that applies to dev-
> > queue.
> 
> This patch is prepared against Dave's net-next tree v5.8-rc4 (most
> recent)
> 
This patch should be prepared against the Intel Wired LAN next-queue,
dev-queue branch.

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-
queue.git/
