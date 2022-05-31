From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Tue, 31 May 2022 16:47:55 +0200
Subject: [Intel-wired-lan] [PATCH net v1 0/2] ice: Fix memory corruption
 in VF driver
In-Reply-To: <20220531131818.3411-1-mateusz.palczewski@intel.com>
References: <20220531131818.3411-1-mateusz.palczewski@intel.com>
Message-ID: <5fd93df2-a46f-114f-ca9b-eb30d9c2bd48@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Mateusz,


Am 31.05.22 um 15:18 schrieb Mateusz Palczewski:
> Disable VF queues, when VF requests reset. Add error handling for
> VIRTCHNL_OP_CONFIG_VSI_QUEUES handler. Without this patch VF driver
> could experience memory corruption, which lead to crash:
> BUG: unable to handle kernel paging request at 00001b9780003237
> 
> Przemyslaw Patynowski (2):
>    ice: Add error handling for queue config fail
>    ice: Fix memory corruption in VF driver
> 
>   drivers/net/ethernet/intel/ice/ice_vf_lib.c   |  5 ++
>   drivers/net/ethernet/intel/ice/ice_virtchnl.c | 53 +++++++++----------
>   2 files changed, 31 insertions(+), 27 deletions(-)

Thank you for the patches. Although you seem to have used 
`git-send-email`, the patches messages are not threaded below the cover 
letter. Do you have an idea why?


Kind regards,

Paul
