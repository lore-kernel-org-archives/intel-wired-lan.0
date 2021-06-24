From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Thu, 24 Jun 2021 16:21:06 +0000
Subject: [Intel-wired-lan] [PATCH net-next v4 0/3] iavf: Fix init and
 watchdog state machines
In-Reply-To: <20210623100739.10708-1-mateusz.palczewski@intel.com>
References: <20210623100739.10708-1-mateusz.palczewski@intel.com>
Message-ID: <5eba665754ec14ab0817f4392780978964245eb8.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2021-06-23 at 10:07 +0000, Mateusz Palczewski wrote:
> Use single state machine for driver initialization
> and for service initialized driver. The init state
> machine implemented in init_task() is merged
> into the watchdog_task(). The init_task() function
> is removed.

This series does not apply. Can you rebase and resend?

> ---
> v4: Removed unnecessary line
> v3: Added new file to patch series
> v2: Splitted the patch into 2 to make them smaller
> ---
> 
> Jan Sokolowski (3):
>   iavf: Refactor iavf state machine tracking
>   iavf: Add __IAVF_INIT_FAILED state
>   iavf: Fix init and watchdog state machines
> 
>  drivers/net/ethernet/intel/iavf/iavf.h        |  12 +-
>  drivers/net/ethernet/intel/iavf/iavf_main.c   | 195 ++++++++------
> ----
>  .../net/ethernet/intel/iavf/iavf_virtchnl.c   |   2 +-
>  3 files changed, 103 insertions(+), 106 deletions(-)
> 
