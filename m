From: Fuxbrumer, Dvora <dvorax.fuxbrumer@linux.intel.com>
Date: Sun, 8 Aug 2021 11:55:13 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] e1000e: Do not take care about
 recovery NVM checksum
In-Reply-To: <20210715070342.2948195-1-sasha.neftin@intel.com>
References: <20210715070342.2948195-1-sasha.neftin@intel.com>
Message-ID: <c8936129-086c-04fe-9f17-1f04cf0902f9@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 7/15/2021 10:03, Sasha Neftin wrote:
> According to the HW De, integrated GbE sets to read-only after
> programming a unique MAC address. The driver should not take care of
> NVM checksum updating starting from Tiger Lake.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=213667
> Suggested-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
> Suggested-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/e1000e/ich8lan.c | 21 +++++++++++++--------
>   1 file changed, 13 insertions(+), 8 deletions(-)
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
