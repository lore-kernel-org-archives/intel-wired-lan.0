From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 8 Sep 2015 18:15:05 +0000
Subject: [Intel-wired-lan] [next PATCH S11 11/15] i40e/i40evf: give up
 the	__func__
In-Reply-To: <1440616461-110869-12-git-send-email-catherine.sullivan@intel.com>
References: <1440616461-110869-1-git-send-email-catherine.sullivan@intel.com>
 <1440616461-110869-12-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A5A59@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Wednesday, August 26, 2015 12:14 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S11 11/15] i40e/i40evf: give up the
> __func__
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> During early development, we added the function name to all of the error
> strings to make debugging simpler. Now that we've released the driver, our
> users should have more comprehensible error messages. So tear the roof off
> and give up the __func__. Ow.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I7e1766252c7a032b9af6520da6aff536bdfd533c
> ---
>  drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c      |  5 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 40 ++++++---------
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  9 ++--
>  .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    | 59 ++++++++++------------
>  4 files changed, 47 insertions(+), 66 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree.
