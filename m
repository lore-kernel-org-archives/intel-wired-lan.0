From: Fuxbrumer, Dvora <dvorax.fuxbrumer@linux.intel.com>
Date: Thu, 19 Aug 2021 00:09:09 +0300
Subject: [Intel-wired-lan] [PATCH next-queue v3 1/3] igc: Use default
 cycle 'start' and 'end' values for queues
In-Reply-To: <1628520820-28907-2-git-send-email-aravindhan.gunasekaran@intel.com>
References: <1628520820-28907-1-git-send-email-aravindhan.gunasekaran@intel.com>
 <1628520820-28907-2-git-send-email-aravindhan.gunasekaran@intel.com>
Message-ID: <02a5627b-7f03-2578-c853-aba58d327cfa@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 8/9/2021 17:53, aravindhan.gunasekaran at intel.com wrote:
> From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> 
> Sets default values for each queue cycle start and cycle end.
> This allows some simplification in the handling of these
> configurations as most TSN features in i225 require a cycle
> to be configured.
> 
> In i225, cycle start and end time is required to be programmed
> for CBS to work properly.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Aravindhan Gunasekaran <aravindhan.gunasekaran@intel.com>
> Signed-off-by: Mallikarjuna Chilakala <mallikarjuna.chilakala@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 37 ++++++++++++++++++-------------
>   drivers/net/ethernet/intel/igc/igc_tsn.c  |  6 -----
>   2 files changed, 21 insertions(+), 22 deletions(-)
> 

Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
