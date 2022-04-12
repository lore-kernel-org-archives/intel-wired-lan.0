From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Tue, 12 Apr 2022 07:38:43 +0200
Subject: [Intel-wired-lan] [PATCH net-next 2/6] ice: always check VF VSI
 pointer values
In-Reply-To: <20220411232907.1022602-3-jacob.e.keller@intel.com>
References: <20220411232907.1022602-1-jacob.e.keller@intel.com>
 <20220411232907.1022602-3-jacob.e.keller@intel.com>
Message-ID: <e079ab74-48fc-65d1-4d3f-2c0cdd4ffcb9@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Jacob,


Thank you for the patch.

Am 12.04.22 um 01:29 schrieb Jacob Keller:
> The ice_get_vf_vsi function can return NULL in some cases, such as if
> handling messages during a reset where the VSI is being removed and
> recreated.
> 
> Several places throughout the driver do not bother to check whether this
> VSI pointer is valid. Static analysis tools maybe report issues because
> they detect paths where a potentially NULL pointer could be
> dereferenced.

(side note: scripts/checkpatch.pl checks for 75 characters per line, and 
you seem to use 72 characters per line.)

> Fix this by checking the return value of ice_get_vf_vsi everywhere.

I didn?t understand, when WARN_ON() is necessary, and when not, but 
looks fine.

> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_devlink.c  |  5 ++-
>   drivers/net/ethernet/intel/ice/ice_repr.c     |  7 +++-
>   drivers/net/ethernet/intel/ice/ice_sriov.c    | 32 +++++++++++++++++--
>   drivers/net/ethernet/intel/ice/ice_vf_lib.c   | 28 +++++++++++++++-
>   drivers/net/ethernet/intel/ice/ice_virtchnl.c |  5 +++
>   .../ethernet/intel/ice/ice_virtchnl_fdir.c    |  7 +++-
>   6 files changed, 77 insertions(+), 7 deletions(-)

[?]

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
