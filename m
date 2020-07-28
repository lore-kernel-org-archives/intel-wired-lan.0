From: Kwapulinski, Piotr <piotr.kwapulinski@intel.com>
Date: Tue, 28 Jul 2020 07:12:17 +0000
Subject: [Intel-wired-lan] [PATCH v2] i40e: add support for PTP external
 synchronization clock
In-Reply-To: <6ef09135cb431475f16beb55f79037d5875c40fc.camel@intel.com>
References: <1ad46857df3e932b2e28256a62f7ad32ae03da23.camel@intel.com>
 <20200724155948.9434-1-piotr.kwapulinski@intel.com>
 <6ef09135cb431475f16beb55f79037d5875c40fc.camel@intel.com>
Message-ID: <MN2PR11MB35651470DBB350230F0978F0F3730@MN2PR11MB3565.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> Sent: Tuesday, July 28, 2020 1:14 AM
> To: intel-wired-lan at lists.osuosl.org; Kwapulinski, Piotr <piotr.kwapulinski@intel.com>
> Subject: Re: [Intel-wired-lan] [PATCH v2] i40e: add support for PTP external synchronization clock
>
> On Fri, 2020-07-24 at 17:59 +0200, Piotr Kwapulinski wrote:
> > Add support for external synchronization clock via GPIOs.
> > 1PPS signals are handled via the dedicated 3 GPIOs: SDP3_2,
> > SDP3_3 and GPIO_4.
> > Previously it was not possible to use the external PTP synchronization
> > clock.
> >
> > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> > Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> > ---
>
> This still doesn't apply. I was able to hand merge the patch but ended up with a bunch errors when building. I'm guessing whatever this was prepared against didn't have this patch:
>
>
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/drivers/net/ethernet/intel/i40e?id=3c98f9ee6bc280499cbcb6f8e42c001c3bd7caa1
>
> Please use dev-queue that I pointed you to in the other reponse.

Thank you. I'm aware of it. It is exactly this patch that matters. I'm rebasing it.
