From: naamax.meir <naamax.meir@linux.intel.com>
Date: Wed, 23 Feb 2022 09:00:56 +0200
Subject: [Intel-wired-lan] [PATCH net v2] igc: igc_read_phy_reg_gpy:
 drop premature return
In-Reply-To: <20220216133135.356870-1-vinschen@redhat.com>
References: <20220216133135.356870-1-vinschen@redhat.com>
Message-ID: <a0c2e828-438d-b5a4-5026-c700a7694ba3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2/16/2022 15:31, Corinna Vinschen wrote:
> igc_read_phy_reg_gpy checks the return value from igc_read_phy_reg_mdic
> and if it's not 0, returns immediately. By doing this, it leaves the HW
> semaphore in the acquired state.
>
> Drop this premature return statement, the function returns after
> releasing the semaphore immediately anyway.
>
> Fixes: 5586838fe9ce ("igc: Add code for PHY support")
> Signed-off-by: Corinna Vinschen<vinschen@redhat.com>
> Acked-by: Sasha Neftin<sasha.neftin@intel.com>
> ---
>
> v2: Add "Fixes:" tag
>
>   drivers/net/ethernet/intel/igc/igc_phy.c | 2 --
>   1 file changed, 2 deletions(-)
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20220223/0f06e9a3/attachment-0001.html>
