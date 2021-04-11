From: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
Date: Sun, 11 Apr 2021 10:03:04 +0300
Subject: [Intel-wired-lan] [PATCH v2 1/1] igc: Fix overwrites return
 value
In-Reply-To: <20210324080531.2051963-1-sasha.neftin@intel.com>
References: <20210324080531.2051963-1-sasha.neftin@intel.com>
Message-ID: <439041d0-ec08-0dbe-70dd-c5770c76b1b9@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 24/03/2021 10:05, Sasha Neftin wrote:
> drivers/net/ethernet/intel/igc/igc_i225.c:235 igc_write_nvm_srwr()
> warn: loop overwrites return value 'ret_val'
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_i225.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
