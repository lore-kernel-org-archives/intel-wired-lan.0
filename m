From: Fuxbrumer, Dvora <dvorax.fuxbrumer@linux.intel.com>
Date: Thu, 24 Jun 2021 16:36:09 +0300
Subject: [Intel-wired-lan] [PATCH v2 1/1] e1000e: Add space to the debug
 print
In-Reply-To: <20210616041930.1827357-1-sasha.neftin@intel.com>
References: <20210616041930.1827357-1-sasha.neftin@intel.com>
Message-ID: <98d4f29d-c7ee-b8e4-dc2f-30d97ddbcb0f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/16/2021 07:19, Sasha Neftin wrote:
> Minor fixes to allow debug prints more readable.
> 
> Fixes: 3cf31b1a9eff ("e1000e: bump up timeout to wait when ME un-configures ULP mode")
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> v1 -> v2: addressed compilation warnings
> ---
>   drivers/net/ethernet/intel/e1000e/ich8lan.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
