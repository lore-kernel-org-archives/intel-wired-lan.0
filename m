From: Fuxbrumer, Dvora <dvorax.fuxbrumer@linux.intel.com>
Date: Sun, 8 Aug 2021 15:15:23 +0300
Subject: [Intel-wired-lan] [PATCH v2 1/1] e1000e: Do not take care about
 recovery NVM checksum
In-Reply-To: <20210718041031.3619696-1-sasha.neftin@intel.com>
References: <20210718041031.3619696-1-sasha.neftin@intel.com>
Message-ID: <e5df4ab3-50f9-7a78-be51-40bed05fd71a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 7/18/2021 07:10, Sasha Neftin wrote:
> On new platforms, the NVM is read-only. Attempting to update the NVM
> is causing a lockup to occur. Do not attempt to write to the NVM
> on platforms where it's not supported.
> Emit an error message when the NVM checksum is invalid.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=213667
> Suggested-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
> Suggested-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/e1000e/ich8lan.c | 18 +++++++++++-------
>   1 file changed, 11 insertions(+), 7 deletions(-)
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
