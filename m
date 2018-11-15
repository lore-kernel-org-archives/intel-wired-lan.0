From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 15 Nov 2018 00:12:34 +0000
Subject: [Intel-wired-lan] [PATCH net] igb: fix uninitialized variables
In-Reply-To: <1541492832-10412-1-git-send-email-wangyunjian@huawei.com>
References: <1541492832-10412-1-git-send-email-wangyunjian@huawei.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B965C1098@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of wangyunjian
> Sent: Tuesday, November 6, 2018 12:27 AM
> To: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> Cc: stone.zhou at huawei.com; Yunjian Wang <wangyunjian@huawei.com>
> Subject: [Intel-wired-lan] [PATCH net] igb: fix uninitialized variables
> 
> From: Yunjian Wang <wangyunjian@huawei.com>
> 
> This patch fixes the variable 'phy_word' may be used uninitialized.
> 
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_i210.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

