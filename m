From: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
Date: Sun, 11 Apr 2021 10:09:37 +0300
Subject: [Intel-wired-lan] [PATCH net-next v2 04/11] igb/igc: use
 strongly typed pointer
In-Reply-To: <20210326003834.3886241-5-jesse.brandeburg@intel.com>
References: <20210326003834.3886241-1-jesse.brandeburg@intel.com>
 <20210326003834.3886241-5-jesse.brandeburg@intel.com>
Message-ID: <e290e053-5118-1357-f4e5-6744be7fcc8e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 26/03/2021 03:38, Jesse Brandeburg wrote:
> The igb and igc driver both use a trick of creating a local type
> pointer on the stack to ease dealing with a receive descriptor in
> 64 bit chunks for printing.  Sparse however was not taken into
> account and receive descriptors are always in little endian
> order, so just make the unions use __le64 instead of u64.
> 
> No functional change.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
> Warning Detail:
>    CHECK   .../igb/igb_main.c
> .../igb/igb_main.c:442:25: warning: cast to restricted __le64
> .../igb/igb_main.c:442:25: warning: cast to restricted __le64
> .../igb/igb_main.c:522:33: warning: cast to restricted __le64
> .../igb/igb_main.c:522:33: warning: cast to restricted __le64
> .../igb/igb_main.c:528:33: warning: cast to restricted __le64
> .../igb/igb_main.c:528:33: warning: cast to restricted __le64
>    CHECK   .../igc/igc_dump.c
> .../igc/igc_dump.c:192:40: warning: cast to restricted __le64
> .../igc/igc_dump.c:193:37: warning: cast to restricted __le64
> .../igc/igc_dump.c:275:45: warning: cast to restricted __le64
> .../igc/igc_dump.c:276:45: warning: cast to restricted __le64
> .../igc/igc_dump.c:281:45: warning: cast to restricted __le64
> .../igc/igc_dump.c:282:45: warning: cast to restricted __le64
> ---
>   drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
>   drivers/net/ethernet/intel/igc/igc_dump.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
Tested for igc
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
