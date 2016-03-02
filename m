From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 2 Mar 2016 21:28:48 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbevf: fix error code path when
 setting	MAC address
In-Reply-To: <20160210231630.9713.65406.stgit@localhost6.localdomain6>
References: <20160210231630.9713.65406.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99C373@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Wednesday, February 10, 2016 3:17 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbevf: fix error code path when setting
> MAC address
> 
> Return error when a MAC address change is rejected by the PF.
> 
> This will prevent the user from modifying the MAC address when that
> operation is not permitted.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   12 ++++++++----
>  drivers/net/ethernet/intel/ixgbevf/vf.c           |    4 +++-
>  2 files changed, 11 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Unable to set invalid MAC on PF or VF
