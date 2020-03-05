From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 5 Mar 2020 22:35:01 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] i40e: Move client header location
In-Reply-To: <20200302165154.1098-1-shiraz.saleem@intel.com>
References: <20200302165154.1098-1-shiraz.saleem@intel.com>
Message-ID: <866c6802a791470585e7df68253b1063@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Shiraz Saleem
> Sent: Monday, March 2, 2020 8:52 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Saleem, Shiraz <shiraz.saleem@intel.com>
> Subject: [Intel-wired-lan] [PATCH 1/2] i40e: Move client header location
> 
> Move i40e_client.h to include/linux/net/intel/* since its shared between
> i40iw and i40e.
> 
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/i40iw/Makefile          |   1 -
>  drivers/infiniband/hw/i40iw/i40iw.h           |   2 +-
>  drivers/net/ethernet/intel/i40e/i40e.h        |   2 +-
>  drivers/net/ethernet/intel/i40e/i40e_client.c |   2 +-
>  drivers/net/ethernet/intel/i40e/i40e_client.h | 203 --------------------------
>  include/linux/net/intel/i40e_client.h         | 203
> ++++++++++++++++++++++++++
>  6 files changed, 206 insertions(+), 207 deletions(-)  delete mode 100644
> drivers/net/ethernet/intel/i40e/i40e_client.h
>  create mode 100644 include/linux/net/intel/i40e_client.h

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


