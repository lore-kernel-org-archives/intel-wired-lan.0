From: naamax.meir <naamax.meir@linux.intel.com>
Date: Tue, 15 Mar 2022 10:04:48 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Fix infinite loop in
 release_swfw_sync
In-Reply-To: <20220301133210.1433609-1-sasha.neftin@intel.com>
References: <20220301133210.1433609-1-sasha.neftin@intel.com>
Message-ID: <c9536ff5-72ac-5b78-6eb3-e6c5f415433a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 3/1/2022 15:32, Sasha Neftin wrote:
> An infinite loop may occur if we fail to acquire the HW semaphore,
> which is needed for resource release.
> This will typically happen if the hardware is surprise-removed.
> At this stage there is nothing to do, except log an error and quit.
>
> Suggested-by: Dima Ruinskiy<dima.ruinskiy@intel.com>
> Signed-off-by: Sasha Neftin<sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_i225.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20220315/e4f90db1/attachment.html>
