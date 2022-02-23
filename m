From: naamax.meir <naamax.meir@linux.intel.com>
Date: Wed, 23 Feb 2022 08:59:16 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: igc_write_phy_reg_gpy:
 drop premature return
In-Reply-To: <20220220072915.3067085-1-sasha.neftin@intel.com>
References: <20220220072915.3067085-1-sasha.neftin@intel.com>
Message-ID: <b082750a-b9ed-e398-b6c5-c77fb24a401a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2/20/2022 09:29, Sasha Neftin wrote:
> Similar to "igc_read_phy_reg_gpy: drop premature return" patch.
> igc_write_phy_reg_gpy checks the return value from igc_write_phy_reg_mdic
> and if it's not 0, returns immediately. By doing this, it leaves the HW
> semaphore in the acquired state.
>
> Drop this premature return statement, the function returns after
> releasing the semaphore immediately anyway.
>
> Fixes: 5586838fe9ce ("igc: Add code for PHY support")
> Suggested-by: Dima Ruinskiy<dima.ruinskiy@intel.com>
> Reported-by: Corinna Vinschen<vinschen@redhat.com>
> Signed-off-by: Sasha Neftin<sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_phy.c | 2 --
>   1 file changed, 2 deletions(-)
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20220223/fe9bc4a2/attachment-0001.html>
