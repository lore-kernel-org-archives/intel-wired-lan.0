From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 8 Mar 2019 00:29:08 +0000
Subject: [Intel-wired-lan] [PATCH S17 07/17] ice: Use
 ice_for_each_q_vector macro where possible
In-Reply-To: <20190228232603.32156-8-anirudh.venkataramanan@intel.com>
References: <20190228232603.32156-1-anirudh.venkataramanan@intel.com>
 <20190228232603.32156-8-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D368E9A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Thursday, February 28, 2019 3:26 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S17 07/17] ice: Use ice_for_each_q_vector
> macro where possible
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> There are many places in the code where we do the following:
> 
> for (i = 0; i < vsi->num_q_vectors; i++)
> 
> Instead use the macro mentioned in the commit title:
> 
> ice_for_each_q_vector(vsi, i)
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c  |  6 +++---
> drivers/net/ethernet/intel/ice/ice_main.c | 10 +++++-----
>  2 files changed, 8 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


