From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Wed, 6 May 2015 16:47:55 +0000
Subject: [Intel-wired-lan] [PATCH 3/3] ixgbevf: fold ixgbevf_pull_tail
 into	ixgbevf_add_rx_frag
In-Reply-To: <20150423044932.18903.18728.stgit@ahduyck-vm-fedora22>
References: <20150423040941.18903.3545.stgit@ahduyck-vm-fedora22>
 <20150423044932.18903.18728.stgit@ahduyck-vm-fedora22>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E17F82864B@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Wednesday, April 22, 2015 9:50 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 3/3] ixgbevf: fold ixgbevf_pull_tail into
> ixgbevf_add_rx_frag
> 
> This change folds the ixgbevf_pull_tail call into ixgbevf_add_rx_frag.  The
> advantage to doing this is that the fragment doesn't have to be modified after it
> is added to the skb.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@redhat.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   66 ++++++---------------
>  1 file changed, 19 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> index a16d267fbce4..cca8936f2fc3 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
