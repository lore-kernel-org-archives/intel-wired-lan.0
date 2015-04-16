From: Young, James M <james.m.young@intel.com>
Date: Thu, 16 Apr 2015 18:09:28 +0000
Subject: [Intel-wired-lan] [net-next S3 09/13] i40e/i40evf: Save
 WR_CSR_PROT field from DEV/FUNC capabilities
Message-ID: <68C85B5FC2FE974B87244D7222BC92783E9E7B42@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Kirsher, Jeffrey T
> Sent: Tuesday, April 07, 2015 4:59 PM
> To: Sullivan, Catherine; Young, James M
> Cc: intel-wired-lan at lists.osuosl.org; Scott, Kevin C
> Subject: Re: [Intel-wired-lan] [net-next S3 09/13] i40e/i40evf: Save
> WR_CSR_PROT field from DEV/FUNC capabilities
> 
> On Tue, 2015-04-07 at 19:45 -0400, Catherine Sullivan wrote:
> > From: Kevin Scott <kevin.c.scott@intel.com>
> >
> > Store the 8 bytes of the WR_CSR_PROT field returned as part of the get
> > device/function capabilities AQ command.
> >
> > Signed-off-by: Kevin Scott <kevin.c.scott@intel.com>
> > Change-ID: Ifcaeea2ff29885fa769e4f384c7db88a25e8afd0
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e_common.c | 5 +++++
> >  drivers/net/ethernet/intel/i40e/i40e_type.h   | 1 +
> >  drivers/net/ethernet/intel/i40evf/i40e_type.h | 1 +
> >  3 files changed, 7 insertions(+)
> 
> Thanks Catherine, I have added your patch to my queue.
> --
> git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
> dev-queue

Tested-by: Jim Young <james.m.young@intel.com>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: signature.asc
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150416/c03630e7/attachment.asc>
