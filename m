From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 29 Aug 2018 16:34:39 +0000
Subject: [Intel-wired-lan] [next PATCH S95 05/12] i40evf: Change a VF
 mac without reloading the VF driver
In-Reply-To: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2E968F@ORSMSX104.amr.corp.intel.com>
References: <20180820151233.14629-1-alice.michael@intel.com>
 <20180820151233.14629-5-alice.michael@intel.com>
 <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2E968F@ORSMSX104.amr.corp.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2EB19A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Bowers, AndrewX
> Sent: Tuesday, August 21, 2018 12:29 PM
> To: Michael, Alice <alice.michael@intel.com>; Michael, Alice
> <alice.michael@intel.com>; intel-wired-lan at lists.osuosl.org
> Cc: Pawel Jablonski
> <"pawel.jablonski@intel.compawel.jablonski"@intel.com>; Pawel Jablonski
> <pawel.jablonski@intel.com>
> Subject: Re: [Intel-wired-lan] [next PATCH S95 05/12] i40evf: Change a VF
> mac without reloading the VF driver
> 
> Setting the VF mac to something arbitrary works, however setting it back to
> 00:00:00:00:00:00 does NOT set it back to all zeroes, nor does it trigger
> random MAC generation (dmesg shows "removing MAC on VF 0" and the
> message to bring the interface down and back up, however dmesg does not
> report "invalid MAC address, using random" and "ip ad show"
>  still shows the 00:11:22:33:44:55 MAC that was set.
> 
> > -----Original Message-----
> > From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> > Behalf Of Alice Michael
> > Sent: Monday, August 20, 2018 8:12 AM
> > To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> > lan at lists.osuosl.org
> > Cc: Pawe? Jab?o?ski
> > <"pawel.jablonski@intel.compawel.jablonski"@intel.com>; Pawe?
> > Jab?o?ski <pawel.jablonski@intel.com>
> > Subject: [Intel-wired-lan] [next PATCH S95 05/12] i40evf: Change a VF
> > mac without reloading the VF driver
> >
> > From: Pawe? Jab?o?ski <pawel.jablonski@intel.com>
> > <pawel.jablonski@intel.com>
> >
> > Add possibility to change a VF mac address from host side without
> > reloading the VF driver on the guest side. Without this patch it is
> > not possible to change the VF mac because executing
> > i40evf_virtchnl_completion function with
> VIRTCHNL_OP_GET_VF_RESOURCES
> > opcode resets the VF mac address to previous value.
> >
> > Signed-off-by: Pawe? Jab?o?ski <pawel.jablonski@intel.com>
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c  |  8 +++++---
> > drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c | 11 +++++++++--
> >  2 files changed, 14 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


