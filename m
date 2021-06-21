From: Fuxbrumer, Dvora <dvorax.fuxbrumer@linux.intel.com>
Date: Mon, 21 Jun 2021 15:36:46 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Check if num of q_vectors
 is smaller than max before array access
In-Reply-To: <20210614121939.1246251-1-sasha.neftin@intel.com>
References: <20210614121939.1246251-1-sasha.neftin@intel.com>
Message-ID: <fd991e55-56fe-8eda-753b-52515302ff70@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/14/2021 15:19, Sasha Neftin wrote:
> Ensure that the adapter->q_vector[MAX_Q_VECTORS] array isn't accessed
> beyond its size. It was fixed by using a local variable num_q_vectors
> as a limit for loop index, and ensure that num_q_vectors is not bigger
> than MAX_Q_VECTORS.
> 
> Suggested-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
