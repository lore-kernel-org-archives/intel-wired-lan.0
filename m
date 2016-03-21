From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 21 Mar 2016 21:45:50 +0000
Subject: [Intel-wired-lan] [PATCH V2 5/5] ixgbe: Take manageability
 semaphore for firmware commands
In-Reply-To: <8511E145-FC8F-483B-9ED1-276997F3DB44@intel.com>
References: <20160314180316.8397.65394.stgit@mdrustad-wks.jf.intel.com>
 <20160314180602.8397.1350.stgit@mdrustad-wks.jf.intel.com>
 <8511E145-FC8F-483B-9ED1-276997F3DB44@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99EC66@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Rustad, Mark D
> Sent: Monday, March 14, 2016 2:11 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [PATCH V2 5/5] ixgbe: Take manageability
> semaphore for firmware commands
> 
> Mark D Rustad <mark.d.rustad@intel.com> wrote:
> 
> > We need to take the manageability semaphore when issuing firmware
> > commands to avoid problems. With this in place, the semaphore is no
> > longer taken in the ixgbe_set_fw_drv_ver_generic function, since it
> > will now always be taken by the ixgbe_host_interface_command function.
> >
> > Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |   30
> +++++++++++++++--------
> >  1 file changed, 19 insertions(+), 11 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes correctly applied.
