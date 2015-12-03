From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 3 Dec 2015 15:30:10 +0000
Subject: [Intel-wired-lan] [net PATCH v2] i40e/i40evf: avoid mutex
 re-init
In-Reply-To: <1447890426-15471-1-git-send-email-jesse.brandeburg@intel.com>
References: <1447890426-15471-1-git-send-email-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F96CB61@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jesse Brandeburg
> Sent: Wednesday, November 18, 2015 3:47 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net PATCH v2] i40e/i40evf: avoid mutex re-init
> 
> If the driver were to happen to have a mutex held while the
> i40e_init_adminq call was called, the init_adminq might inadvertently call
> mutex_init on a lock that was held which is a violation of the calling
> semantics.
> 
> Fix this by avoiding adminq.c code allocating/freeing this memory, and then
> do the same work only once in probe/remove.
> 
> Testing Hints (Required if no HSD): for VF, load i40evf in bare metal and echo
> 32 > sriov_numvfs; echo 0 > sriov_numvfs in a loop.  Yes this is a horrible
> thing to do.
> 
> Reported-by: Stefan Assmann <sassmann@redhat.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: Ida263c51b34e195252179e7e5e400d73a99be7a2
> 
> ---
> 
> v2: removed old calls to mutex_init that are no longer necessary
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c   |  6 ------
>  drivers/net/ethernet/intel/i40e/i40e_main.c     | 11 ++++++++++-
>  drivers/net/ethernet/intel/i40evf/i40e_adminq.c |  6 ------
> drivers/net/ethernet/intel/i40evf/i40evf_main.c | 10 ++++++++++
>  4 files changed, 20 insertions(+), 13 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, echoing 0, 32, repeat in a loop does not crash driver/cause unexpected behavior
