From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Wed, 14 Apr 2021 21:45:34 +0000
Subject: [Intel-wired-lan] [PATCH net v2] iavf: Fix init and watchdog
 state machines
In-Reply-To: <20210413114332.32650-1-mateusz.palczewski@intel.com>
References: <20210413114332.32650-1-mateusz.palczewski@intel.com>
Message-ID: <84bb456c862e0b3919c4c82f703b90d16a79a8b0.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2021-04-13 at 11:43 +0000, Mateusz Palczewski wrote:
> From: Jan Sokolowski <jan.sokolowski@intel.com>
> 
> Use single state machine for driver initialization
> and for service initialized driver. The init state
> machine implemented in init_task() is merged
> into the watchdog_task(). The init_task() function
> is removed.

It's unclear to me what's being fixed here. This sounds like a
refactor. If so, it should go to -next.

Also, feedback from the previous version has not been addressed. There
is a new state and helper function, but no explanation of it here.

> Testing-Hints: Change is only for VF driver state machine,
>                should be checked load/unload/reset and
>                set/get driver parameters.
> 
> Fixes: bac8486116b0 ("iavf: Refactor the watchdog state machine")
> Signed-off-by: Jakub Pawlak <jakub.pawlak@intel.com>
> Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
> ---
>  v2: splitted the patch into smaller pieces
> ---
>  drivers/net/ethernet/intel/iavf/iavf.h      |   2 +-
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 159 ++++++++++------
> ----
>  2 files changed, 77 insertions(+), 84 deletions(-)
