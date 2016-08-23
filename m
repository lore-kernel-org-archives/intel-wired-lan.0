From: Tantilov, Emil S <emil.s.tantilov@intel.com>
Date: Tue, 23 Aug 2016 17:18:01 +0000
Subject: [Intel-wired-lan] [PATCH -next] ixgbe: Fix non static
	symbol	warnings
In-Reply-To: <1471964842-335-1-git-send-email-weiyj.lk@gmail.com>
References: <1471964842-335-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <87618083B2453E4A8714035B62D67992506CA9C8@FMSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
>Behalf Of Wei Yongjun
>Sent: Tuesday, August 23, 2016 8:07 AM
>To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
>Cc: intel-wired-lan at lists.osuosl.org; Wei Yongjun <weiyongjun1@huawei.com>;
>netdev at vger.kernel.org
>Subject: [Intel-wired-lan] [PATCH -next] ixgbe: Fix non static symbol
>warnings
>
>From: Wei Yongjun <weiyongjun1@huawei.com>
>
>Fixes the following sparse warnings:
>
>drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:2128:5: warning:
> symbol 'ixgbe_led_on_t_x550em' was not declared. Should it be static?
>drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:2150:5: warning:
> symbol 'ixgbe_led_off_t_x550em' was not declared. Should it be static?
>
>Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Already resolved:
http://patchwork.ozlabs.org/patch/661647/

Thanks,
Emil

