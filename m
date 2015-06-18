From: Young, James M <james.m.young@intel.com>
Date: Thu, 18 Jun 2015 00:24:34 +0000
Subject: [Intel-wired-lan] [net-next S5 14/15] i40e/i40evf: remove
 last_rx	reference in receive
In-Reply-To: <68C85B5FC2FE974B87244D7222BC92783EA16D78@ORSMSX102.amr.corp.intel.com>
References: <1430161042-28494-1-git-send-email-catherine.sullivan@intel.com>
 <1430161042-28494-15-git-send-email-catherine.sullivan@intel.com>
 <68C85B5FC2FE974B87244D7222BC92783EA16D78@ORSMSX102.amr.corp.intel.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783EA19B31@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Young, James M
> Sent: Friday, June 12, 2015 10:47 AM
> To: Sullivan, Catherine; intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [net-next S5 14/15] i40e/i40evf: remove last_rx
> reference in receive
> 
> > -----Original Message-----
> > From: Intel-wired-lan
> > [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of
> > Catherine Sullivan
> > Sent: Monday, April 27, 2015 11:57 AM
> > To: intel-wired-lan at lists.osuosl.org
> > Subject: [Intel-wired-lan] [net-next S5 14/15] i40e/i40evf: remove
> > last_rx reference in receive
> >
> > From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> >
> > The driver was suffering a slow down in RX performance due to
> > accessing this cache line from all receive queues, which resulted in a
> > performance improvement for forwarding packets with this patch.
> >
> > Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> > Change-ID: Ie841a72289207eadf8a16b1013ffe83dfec6db1d
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 2 --
> >  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 2 --
> >  2 files changed, 4 deletions(-)
> >
Tested-by: Jim Young <james.m.young@intel.com> 
This is a resend because the original  "tested-by" email  had a formatting error which prevented it from triggering the "tested" bit in patchwork. 


