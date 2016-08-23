From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 23 Aug 2016 17:50:32 +0000
Subject: [Intel-wired-lan] ixgbe: simplify the logic for setting VLAN
	filtering
In-Reply-To: <1471974466.2485.29.camel@intel.com>
References: <20160822231746.7715.25120.stgit@localhost6.localdomain6>
 <1471974466.2485.29.camel@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9F9843@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Kirsher, Jeffrey T
> Sent: Tuesday, August 23, 2016 10:48 AM
> To: Bowers, AndrewX <andrewx.bowers@intel.com>
> Subject: Re: ixgbe: simplify the logic for setting VLAN filtering
> 
> On Mon, 2016-08-22 at 16:17 -0700, Tantilov, Emil S wrote:
> > Simplify the logic for setting VLNCTRL.VFE by checking the? VMDQ flag
> > and 82598 MAC instead of having to maintain a list of MAC types.
> >
> > Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> > ---
> > ?drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |?? 39
> > +++++++----------
> > --------
> > ?1 file changed, 11 insertions(+), 28 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


